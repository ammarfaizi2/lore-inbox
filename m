Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbUKWGUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUKWGUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUKWGTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:19:13 -0500
Received: from [211.58.254.17] ([211.58.254.17]:14747 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262206AbUKWGQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:16:41 -0500
Date: Tue, 23 Nov 2004 15:16:38 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST 2.6.10-rc2 4/4] module sysfs: module parameters reimplemented using attr group
Message-ID: <20041123061638.GE14209@home-tj.org>
References: <20041123061252.GA14209@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123061252.GA14209@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/module.h
===================================================================
--- linux-export.orig/include/linux/module.h	2004-11-23 15:08:15.000000000 +0900
+++ linux-export/include/linux/module.h	2004-11-23 15:08:22.000000000 +0900
@@ -238,7 +238,7 @@ struct module_sect_attrs
 	struct module_sect_attr attrs[0];
 };
 
-struct param_kobject;
+struct module_param_attrs;
 
 struct module
 {
@@ -252,7 +252,7 @@ struct module
 
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
-	struct param_kobject *params_kobject;
+	struct module_param_attrs *param_attrs;
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-23 15:08:11.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-23 15:08:22.000000000 +0900
@@ -357,26 +357,23 @@ extern struct kernel_param __start___par
 
 struct param_attribute
 {
-	struct attribute attr;
+	struct module_attribute mattr;
 	struct kernel_param *param;
 };
 
-struct param_kobject
+struct module_param_attrs
 {
-	struct kobject kobj;
-
-	unsigned int num_attributes;
-	struct param_attribute attr[0];
+	struct attribute_group grp;
+	struct param_attribute attrs[0];
 };
 
-#define to_param_attr(n) container_of(n, struct param_attribute, attr);
+#define to_param_attr(n) container_of(n, struct param_attribute, mattr);
 
-static ssize_t param_attr_show(struct kobject *kobj,
-			       struct attribute *attr,
-			       char *buf)
+static ssize_t param_attr_show(struct module_attribute *mattr,
+			       struct module *mod, char *buf)
 {
 	int count;
-	struct param_attribute *attribute = to_param_attr(attr);
+	struct param_attribute *attribute = to_param_attr(mattr);
 
 	if (!attribute->param->get)
 		return -EPERM;
@@ -390,12 +387,12 @@ static ssize_t param_attr_show(struct ko
 }
 
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
-static ssize_t param_attr_store(struct kobject *kobj,
-				struct attribute *attr,
+static ssize_t param_attr_store(struct module_attribute *mattr,
+				struct module *owner,
 				const char *buf, size_t len)
 {
  	int err;
-	struct param_attribute *attribute = to_param_attr(attr);
+	struct param_attribute *attribute = to_param_attr(mattr);
 
 	if (!attribute->param->set)
 		return -EPERM;
@@ -406,27 +403,6 @@ static ssize_t param_attr_store(struct k
 	return err;
 }
 
-
-static struct sysfs_ops param_sysfs_ops = {
-	.show = param_attr_show,
-	.store = param_attr_store,
-};
-
-static void param_kobj_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct param_kobject, kobj));
-}
-
-static struct kobj_type param_ktype = {
-	.sysfs_ops =	&param_sysfs_ops,
-	.release =	&param_kobj_release,
-};
-
-static struct kset param_kset = {
-	.subsys =	&module_subsys,
-	.ktype =	&param_ktype,
-};
-
 #ifdef CONFIG_MODULES
 #define __modinit
 #else
@@ -434,54 +410,6 @@ static struct kset param_kset = {
 #endif
 
 /*
- * param_add_attribute - actually adds an parameter to sysfs
- * @mod: owner of parameter
- * @pk: param_kobject the attribute shall be assigned to.
- *      One per module, one per KBUILD_MODNAME.
- * @kp: kernel_param to be added
- * @skip: offset where the parameter name start in kp->name.
- * Needed for built-in modules
- *
- * Fill in data into appropriate &pk->attr[], and create sysfs file.
- */
-static __modinit int param_add_attribute(struct module *mod,
-					 struct param_kobject *pk,
-					 struct kernel_param *kp,
-					 unsigned int skip)
-{
-	struct param_attribute *a;
-	int err;
-
-	a = &pk->attr[pk->num_attributes];
-	a->attr.name = (char *) &kp->name[skip];
-	a->attr.owner = mod;
-	a->attr.mode = kp->perm;
-	a->param = kp;
-	err = sysfs_create_file(&pk->kobj, &a->attr);
-	if (!err)
-		pk->num_attributes++;
-	return err;
-}
-
-/*
- * param_sysfs_remove - remove sysfs support for one module or KBUILD_MODNAME
- * @pk: struct param_kobject which is to be removed
- *
- * Called when an error in registration occurs or a module is removed
- * from the system.
- */
-static __modinit void param_sysfs_remove(struct param_kobject *pk)
-{
-	unsigned int i;
-	for (i = 0; i < pk->num_attributes; i++)
-		sysfs_remove_file(&pk->kobj,&pk->attr[i].attr);
-
-	/* Calls param_kobj_release */
-	kobject_unregister(&pk->kobj);
-}
-
-
-/*
  * param_sysfs_setup - setup sysfs support for one module or KBUILD_MODNAME
  * @mk: struct module_kobject (contains parent kobject)
  * @kparam: array of struct kernel_param, the actual parameter definitions
@@ -492,15 +420,17 @@ static __modinit void param_sysfs_remove
  * in sysfs. A pointer to the param_kobject is returned on success,
  * NULL if there's no parameter to export, or other ERR_PTR(err).
  */
-static __modinit struct param_kobject *
+static __modinit struct module_param_attrs *
 param_sysfs_setup(struct module_kobject *mk,
 		  struct kernel_param *kparam,
 		  unsigned int num_params,
 		  unsigned int name_skip)
 {
-	struct param_kobject *pk;
+	struct module_param_attrs *mp;
 	unsigned int valid_attrs = 0;
-	unsigned int i;
+	unsigned int i, size[2];
+	struct param_attribute *pattr;
+	struct attribute **gattr;
 	int err;
 
 	for (i=0; i<num_params; i++) {
@@ -511,42 +441,39 @@ param_sysfs_setup(struct module_kobject 
 	if (!valid_attrs)
 		return NULL;
 
-	pk = kmalloc(sizeof(struct param_kobject)
-		     + sizeof(struct param_attribute) * valid_attrs,
-		     GFP_KERNEL);
-	if (!pk)
+	size[0] = ALIGN(sizeof(*mp) +
+			valid_attrs * sizeof(mp->attrs[0]),
+			sizeof(mp->grp.attrs[0]));
+	size[1] = (valid_attrs + 1) * sizeof(mp->grp.attrs[0]);
+
+	mp = kmalloc(size[0] + size[1], GFP_KERNEL);
+	if (!mp)
 		return ERR_PTR(-ENOMEM);
-	memset(pk, 0, sizeof(struct param_kobject)
-	       + sizeof(struct param_attribute) * valid_attrs);
 
-	err = kobject_set_name(&pk->kobj, "parameters");
-	if (err)
-		goto out;
-
-	pk->kobj.kset = &param_kset;
-	pk->kobj.parent = &mk->kobj;
-	err = kobject_register(&pk->kobj);
-	if (err)
-		goto out;
+	mp->grp.name = "parameters";
+	mp->grp.attrs = (void *)mp + size[0];
 
+	pattr = &mp->attrs[0];
+	gattr = &mp->grp.attrs[0];
 	for (i = 0; i < num_params; i++) {
-		if (kparam[i].perm) {
-			err = param_add_attribute(mk->mod, pk,
-						  &kparam[i], name_skip);
-			if (err)
-				goto out_unreg;
+		struct kernel_param *kp = &kparam[i];
+		if (kp->perm) {
+			pattr->param = kp;
+			pattr->mattr.show = param_attr_show;
+			pattr->mattr.store = param_attr_store;
+			pattr->mattr.attr.name = (char *)&kp->name[name_skip];
+			pattr->mattr.attr.owner = mk->mod;
+			pattr->mattr.attr.mode = kp->perm;
+			*(gattr++) = &(pattr++)->mattr.attr;
 		}
 	}
+	*gattr = NULL;
 
-	return pk;
-
-out_unreg:
-	param_sysfs_remove(pk);
-	return ERR_PTR(err);
-
-out:
-	kfree(pk);
-	return ERR_PTR(err);
+	if ((err = sysfs_create_group(&mk->kobj, &mp->grp))) {
+		kfree(mp);
+		return ERR_PTR(err);
+	}
+	return mp;
 }
 
 
@@ -565,13 +492,13 @@ int module_param_sysfs_setup(struct modu
 			     struct kernel_param *kparam,
 			     unsigned int num_params)
 {
-	struct param_kobject *pk;
+	struct module_param_attrs *mp;
 
-	pk = param_sysfs_setup(&mod->mkobj, kparam, num_params, 0);
-	if (IS_ERR(pk))
-		return PTR_ERR(pk);
+	mp = param_sysfs_setup(&mod->mkobj, kparam, num_params, 0);
+	if (IS_ERR(mp))
+		return PTR_ERR(mp);
 
-	mod->params_kobject = pk;
+	mod->param_attrs = mp;
 	return 0;
 }
 
@@ -584,9 +511,13 @@ int module_param_sysfs_setup(struct modu
  */
 void module_param_sysfs_remove(struct module *mod)
 {
-	if (mod->params_kobject) {
-		param_sysfs_remove(mod->params_kobject);
-		mod->params_kobject = NULL;
+	if (mod->param_attrs) {
+		sysfs_remove_group(&mod->mkobj.kobj,
+				   &mod->param_attrs->grp);
+		/* We are positive that no one is using any param
+		 * attrs at this point.  Deallocate immediately. */
+		kfree(mod->param_attrs);
+		mod->param_attrs = NULL;
 	}
 }
 #endif
@@ -724,8 +655,6 @@ decl_subsys(module, &module_ktype, NULL)
 static int __init param_sysfs_init(void)
 {
 	subsystem_register(&module_subsys);
-	kobject_set_name(&param_kset.kobj, "parameters");
-	kset_init(&param_kset);
 
 	param_sysfs_builtin();
 
