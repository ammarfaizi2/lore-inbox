Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVAHHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVAHHta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVAHHso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:48:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:48261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261872AbVAHFsT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:19 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632612059@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:41 -0800
Message-Id: <11051632613788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.18, 2004/12/21 10:36:03-08:00, tj@home-tj.org

[PATCH] module sysfs: make module.mkobj inline

    Make module.mkobj inline.  As this is simpler and what's
    usually done with kobjs when it's representing an entity.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/module.h |    2 +-
 kernel/module.c        |   35 +++++++++++------------------------
 kernel/params.c        |   12 ++++--------
 3 files changed, 16 insertions(+), 33 deletions(-)


diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2005-01-07 15:41:47 -08:00
+++ b/include/linux/module.h	2005-01-07 15:41:47 -08:00
@@ -250,7 +250,7 @@
 	char name[MODULE_NAME_LEN];
 
 	/* Sysfs stuff. */
-	struct module_kobject *mkobj;
+	struct module_kobject mkobj;
 	struct param_kobject *params_kobject;
 
 	/* Exported symbols */
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2005-01-07 15:41:47 -08:00
+++ b/kernel/module.c	2005-01-07 15:41:47 -08:00
@@ -964,9 +964,6 @@
 	unsigned int nloaded = 0, i;
 	struct module_sect_attr *sattr;
 	
-	if (!mod->mkobj)
-		return;
-	
 	/* Count loaded sections and allocate structures */
 	for (i = 0; i < nsect; i++)
 		if (sechdrs[i].sh_flags & SHF_ALLOC)
@@ -980,7 +977,7 @@
 	memset(mod->sect_attrs, 0, sizeof(struct module_sections));
 	if (kobject_set_name(&mod->sect_attrs->kobj, "sections"))
 		goto out;
-	mod->sect_attrs->kobj.parent = &mod->mkobj->kobj;
+	mod->sect_attrs->kobj.parent = &mod->mkobj.kobj;
 	mod->sect_attrs->kobj.ktype = &module_sect_ktype;
 	if (kobject_register(&mod->sect_attrs->kobj))
 		goto out;
@@ -1029,11 +1026,11 @@
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
@@ -1052,17 +1049,13 @@
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
 
@@ -1077,11 +1070,8 @@
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
 
@@ -1090,8 +1080,7 @@
 	module_remove_refcnt_attr(mod);
 	module_param_sysfs_remove(mod);
 
-	/* Calls module_kobj_release */
-	kobject_unregister(&mod->mkobj->kobj);
+	kobject_unregister(&mod->mkobj.kobj);
 }
 
 /* Free a module, remove from lists, etc (must hold module mutex). */
@@ -2089,11 +2078,9 @@
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
 
diff -Nru a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c	2005-01-07 15:41:47 -08:00
+++ b/kernel/params.c	2005-01-07 15:41:47 -08:00
@@ -567,7 +567,7 @@
 {
 	struct param_kobject *pk;
 
-	pk = param_sysfs_setup(mod->mkobj, kparam, num_params, 0);
+	pk = param_sysfs_setup(&mod->mkobj, kparam, num_params, 0);
 	if (IS_ERR(pk))
 		return PTR_ERR(pk);
 
@@ -610,8 +610,10 @@
 	kobject_register(&mk->kobj);
 
 	/* no need to keep the kobject if no parameter is exported */
-	if (!param_sysfs_setup(mk, kparam, num_params, name_skip))
+	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
 		kobject_unregister(&mk->kobj);
+		kfree(mk);
+	}
 }
 
 /*
@@ -710,14 +712,8 @@
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

