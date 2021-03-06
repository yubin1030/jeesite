<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>微信菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wx/wxMenu/">微信菜单列表</a></li>
		<li class="active"><a href="${ctx}/wx/wxMenu/form?id=${wxMenu.id}">微信菜单<shiro:hasPermission name="wx:wxMenu:edit">${not empty wxMenu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wx:wxMenu:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="wxMenu" action="${ctx}/wx/wxMenu/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">父级菜单：</label>
			<div class="controls">
			    
			    <sys:treeselect  id="parent" name="parentId" value="${menu.id}" labelName="menu.menuName" labelValue="${menu.menuName}"
					title="菜单" url="/wx/wxMenu/treeData"/>
			</div>
			
		</div>
		
		<div class="control-group">
			<label class="control-label">菜单标题：</label>
			<div class="controls">
				<form:input path="menuName" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">菜单键值：</label>
			<div class="controls">
				<form:input path="menuKey" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">网页链接：</label>
			<div class="controls">
				<form:input path="menuUrl" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">菜单类型：</label>
			<div class="controls">
				<form:radiobuttons path="menuType" items="${fns:getDictList('menu_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否显示：</label>
			<div class="controls">
				<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wx:wxMenu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>