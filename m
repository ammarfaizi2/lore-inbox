Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUKWGRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUKWGRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUKWGQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:16:03 -0500
Received: from [211.58.254.17] ([211.58.254.17]:63130 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262235AbUKWGOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:14:05 -0500
Date: Tue, 23 Nov 2004 15:13:58 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST 2.6.10-rc2 1/4] module sysfs: make module.mkobj inline
Message-ID: <20041123061358.GB14209@home-tj.org>
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
--- linux-export.orig/include/linux/module.h	2004-11-23 10:57:37.000000000 +0900
+++ linux-export/include/linux/module.h	2004-11-23 15:08:01.000000000 +0900
@@ -250,7 +250,7 @@ struct module
 	char name[MODULE_NAME_LEN];
 
 	/* Sysfs stuff. */
-	struct module_kobject *mkobj;
+	struct module_kobject mkobj;
 	struct param_kobject *params_kobject;
 
 	/* Exported symbols */
Index: linux-export/kernel/module.c
===================================================================
--- linux-export.orig/kernel/module.c	2004-11-23 10:57:37.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-23 15:08:01.000000000 +0900
@@ -964,9 +964,6 @@ static void add_sect_attrs(struct module
 	unsigned int nloaded = 0, i;
 	struct module_sect_attr *sattr;
 	
-	if (!mod->mkobj)
-		return;
-	
 	/* Count loaded sections and allocate structures */
 	for (i = 0; i < nsect; i++)
 		if (sechdrs[i].sh_flags & SHF_ALLOC)
@@ -980,7 +977,7 @@ static void add_sect_attrs(struct module
 	memset(mod->sect_attrs, 0, sizeof(struct module_sections));
 	if (kobject_set_name(&mod->sect_attrs->kobj, "sections"))
 		goto out;
-	mod->sect_attrs->kobj.parent = &mod->mkobj->kobj;
+	mod->sect_attrs->kobj.parent = &mod->mkobj.kobj;
 	mod->sect_attrs->kobj.ktype = &module_sect_ktype;
 	if (kobject_register(&mod->sect_attrs->kobj))
 		goto out;
@@ -1029,11 +1026,11 @@ static inline void remove_sect_attrs(str
 #ifdef CONFIG_MODULE_UNLOAD
 static inline int module_add_refcnt_attr(struct module *mod)
 {
-	return sysfs_create_file(&mod->mkobj->kobj, &refcnt.attr);
+	return sysfs_create_file(&mod->mkobj.kobj, &refcnt.attr);
 }
 static void module_remove_refcnt_attr(struct module *mod)
 {
-	return sysfs_remove_file(&mod->mkobj->kobj, &refcnt.attr);
+	return sysfs_remove_file(&mod->mkobj.kobj, &refcnt.attr);
 }
 #else
 static inline int module_add_refcnt_attr(struct module *mod)
@@ -1052,17 +1049,13 @@ static int mod_sysfs_setup(struct module
 {
 	int err;
 
-	mod->mkobj = kmalloc(sizeof(struct module_kobject), GFP_KERNEL);
-	if (!mod->mkobj)
-		return -ENOMEM;
-
-	memset(&mod->mkobj->kobj, 0, sizeof(mod->mkobj->kobj));
-	err = kobject_set_name(&mod->mkobj->kobj, "%s", mod->name);
+	memset(&mod->mkobj.kobj, 0, sizeof(mod->mkobj.kobj));
+	err = kobject_set_name(&mod->mkobj.kobj, "%s", mod->name);
 	if (err)
 		goto out;
-	kobj_set_kset_s(mod->mkobj, module_subsys);
-	mod->mkobj->mod = mod;
-	err = kobject_register(&mod->mkobj->kobj);
+	kobj_set_kset_s(&mod->mkobj, module_subsys);
+	mod->mkobj.mod = mod;
+	err = kobject_register(&mod->mkobj.kobj);
 	if (err)
 		goto out;
 
@@ -1077,11 +1070,8 @@ static int mod_sysfs_setup(struct module
 	return 0;
 
 out_unreg:
-	/* Calls module_kobj_release */
-	kobject_unregister(&mod->mkobj->kobj);
-	return err;
+	kobject_unregister(&mod->mkobj.kobj);
 out:
-	kfree(mod->mkobj);
 	return err;
 }
 
@@ -1090,8 +1080,7 @@ static void mod_kobject_remove(struct mo
 	module_remove_refcnt_attr(mod);
 	module_param_sysfs_remove(mod);
 
-	/* Calls module_kobj_release */
-	kobject_unregister(&mod->mkobj->kobj);
+	kobject_unregister(&mod->mkobj.kobj);
 }
 
 /* Free a module, remove from lists, etc (must hold module mutex). */
@@ -2089,11 +2078,9 @@ void module_add_driver(struct module *mo
 {
 	if (!mod || !drv)
 		return;
-	if (!mod->mkobj)
-		return;
 
 	/* Don't check return code; this call is idempotent */
-	sysfs_create_link(&drv->kobj, &mod->mkobj->kobj, "module");
+	sysfs_create_link(&drv->kobj, &mod->mkobj.kobj, "module");
 }
 EXPORT_SYMBOL(module_add_driver);
 
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-23 10:57:38.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-23 15:08:01.000000000 +0900
@@ -567,7 +567,7 @@ int module_param_sysfs_setup(struct modu
 {
 	struct param_kobject *pk;
 
-	pk = param_sysfs_setup(mod->mkobj, kparam, num_params, 0);
+	pk = param_sysfs_setup(&mod->mkobj, kparam, num_params, 0);
 	if (IS_ERR(pk))
 		return PTR_ERR(pk);
 
@@ -610,8 +610,10 @@ static void __init kernel_param_sysfs_se
 	kobject_register(&mk->kobj);
 
 	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip))
+	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
 		kobject_unregister(&mk->kobj);
+		kfree(mk);
+	}
 }
 
 /*
@@ -710,14 +712,8 @@ static struct sysfs_ops module_sysfs_ops
 };
 #endif
 
-static void module_kobj_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct module_kobject, kobj));
-}
-
 static struct kobj_type module_ktype = {
 	.sysfs_ops =	&module_sysfs_ops,
-	.release =	&module_kobj_release,
 };
 
 decl_subsys(module, &module_ktype, NULL);
