Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUHAQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUHAQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHAQ46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 12:56:58 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:31118 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266016AbUHAQ4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 12:56:03 -0400
Date: Sun, 1 Aug 2004 18:54:10 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 2/2] export module parameters in sysfs for modules _and_ built-in code: remove /sys/module/*parameters*
Message-ID: <20040801165410.GB8667@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the exporting of module parameters in sysfs in /sys/module,
and clean up the exporting of the attribute "refcnt". One functionality
change: it is always exported now, and if !CONFIG_MODULE_UNLOAD, it reports
1.

Signed-off-by: Dominik Brodowski <linux@brodo.de>

 include/linux/module.h |   18 ++-----
 kernel/module.c        |  114 ++++++++++++++----------------------------------- 
 2 files changed, 39 insertions(+), 93 deletions(-)

diff -ruN linux-original/include/linux/module.h linux/include/linux/module.h
--- linux-original/include/linux/module.h	2004-08-01 17:53:56.584410480 +0200
+++ linux/include/linux/module.h	2004-08-01 18:11:59.001858016 +0200
@@ -208,21 +208,16 @@
 	MODULE_STATE_GOING,
 };
 
-/* sysfs stuff */
-struct module_attribute
-{
-	struct attribute attr;
-	struct kernel_param *param;
+struct module_attribute {
+        struct attribute attr;
+        ssize_t (*show)(struct module *, char *);
+        ssize_t (*store)(struct module *, const char *, size_t count);
 };
 
 struct module_kobject
 {
-	/* Everyone should have one of these. */
 	struct kobject kobj;
-
-	/* We always have refcnt, we may have others from module_param(). */
-	unsigned int num_attributes;
-	struct module_attribute attr[0];
+	struct module *mod;
 };
 
 /* Similar stuff for section attributes. */
@@ -306,9 +301,6 @@
 
 	/* Destruction function. */
 	void (*exit)(void);
-
-	/* Fake kernel param for refcnt. */
-	struct kernel_param refcnt_param;
 #endif
 
 #ifdef CONFIG_KALLSYMS
diff -ruN linux-original/kernel/module.c linux/kernel/module.c
--- linux-original/kernel/module.c	2004-08-01 17:53:56.593409112 +0200
+++ linux/kernel/module.c	2004-08-01 18:26:15.722616664 +0200
@@ -378,22 +378,6 @@
 }
 #endif /* CONFIG_SMP */
 
-static int add_attribute(struct module *mod, struct kernel_param *kp)
-{
-	struct module_attribute *a;
-	int retval;
-
-	a = &mod->mkobj->attr[mod->mkobj->num_attributes];
-	a->attr.name = (char *)kp->name;
-	a->attr.owner = mod;
-	a->attr.mode = kp->perm;
-	a->param = kp;
-	retval = sysfs_create_file(&mod->mkobj->kobj, &a->attr);
-	if (!retval)
-		mod->mkobj->num_attributes++;
-	return retval;
-}
-
 #ifdef CONFIG_MODULE_UNLOAD
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
@@ -678,21 +662,10 @@
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
-static int refcnt_get_fn(char *buffer, struct kernel_param *kp)
-{
-	struct module *mod = container_of(kp, struct module, refcnt_param);
-
-	/* sysfs holds one reference. */
-	return sprintf(buffer, "%u", module_refcount(mod)-1);
-}
-
-static inline int sysfs_unload_setup(struct module *mod)
+static int show_refcnt(struct module *mod, char *buffer)
 {
-	mod->refcnt_param.name = "refcnt";
-	mod->refcnt_param.perm = 0444;
-	mod->refcnt_param.get = refcnt_get_fn;
-
-	return add_attribute(mod, &mod->refcnt_param);
+	/* sysfs holds a reference */
+	return sprintf(buffer, "%u\n", module_refcount(mod)-1);
 }
 
 #else /* !CONFIG_MODULE_UNLOAD */
@@ -711,8 +684,10 @@
 	return strong_try_module_get(b);
 }
 
-static inline void module_unload_init(struct module *mod)
+static int show_refcnt(struct module *mod, char *buffer)
 {
+	/* always non-removable */
+	return sprintf(buffer, "1\n");
 }
 
 asmlinkage long
@@ -1077,47 +1052,46 @@
 
 
 
+static struct module_attribute refcnt = {
+	.attr = { .name = "refcnt", .mode = 0444, .owner = THIS_MODULE },
+	.show = show_refcnt,
+};
+
+static struct attribute * default_attrs[] = {
+	&refcnt.attr,
+	NULL,
+};
 
 #define to_module_attr(n) container_of(n, struct module_attribute, attr);
+#define to_module_kobject(n) container_of(n, struct module_kobject, kobj);
 
 static ssize_t module_attr_show(struct kobject *kobj,
 				struct attribute *attr,
 				char *buf)
 {
-	int count;
-	struct module_attribute *attribute = to_module_attr(attr);
+	struct module_attribute *attribute; 
+	struct module_kobject *mk;
+	int ret;
 
-	if (!attribute->param->get)
+	attribute = to_module_attr(attr);
+	mk = to_module_kobject(kobj);
+
+	if (!attribute->show)
 		return -EPERM;
 
-	count = attribute->param->get(buf, attribute->param);
-	if (count > 0) {
-		strcat(buf, "\n");
-		++count;
-	}
-	return count;
-}
+	if (!try_module_get(mk->mod))
+		return -ENODEV;
 
-/* sysfs always hands a nul-terminated string in buf.  We rely on that. */
-static ssize_t module_attr_store(struct kobject *kobj,
-				 struct attribute *attr,
-				 const char *buf, size_t len)
-{
-	int err;
-	struct module_attribute *attribute = to_module_attr(attr);
+	ret = attribute->show(mk->mod, buf);
 
-	if (!attribute->param->set)
-		return -EPERM;
+	module_put(mk->mod);
 
-	err = attribute->param->set(buf, attribute->param);
-	if (!err)
-		return len;
-	return err;
+	return ret;
 }
 
 static struct sysfs_ops module_sysfs_ops = {
 	.show = module_attr_show,
-	.store = module_attr_store,
+	.store = NULL,
 };
 
 static void module_kobj_release(struct kobject *kobj)
@@ -1127,6 +1101,7 @@
 
 static struct kobj_type module_ktype = {
 	.sysfs_ops =	&module_sysfs_ops,
+        .default_attrs = default_attrs,
 	.release =	&module_kobj_release,
 };
 static decl_subsys(module, &module_ktype, NULL);
@@ -1137,42 +1112,27 @@
 
 extern void module_param_sysfs_remove(struct module *mod);
 
+
 static int mod_sysfs_setup(struct module *mod,
 			   struct kernel_param *kparam,
 			   unsigned int num_params)
 {
-	unsigned int i;
 	int err;
 
-	/* We overallocate: not every param is in sysfs, and maybe no refcnt */
-	mod->mkobj = kmalloc(sizeof(*mod->mkobj)
-			     + sizeof(mod->mkobj->attr[0]) * (num_params+1),
-			     GFP_KERNEL);
+	mod->mkobj = kmalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	if (!mod->mkobj)
 		return -ENOMEM;
 
-	memset(&mod->mkobj->kobj, 0, sizeof(mod->mkobj->kobj));
+	memset(&mod->mkobj->kobj, 0, sizeof(struct module_kobject));
 	err = kobject_set_name(&mod->mkobj->kobj, mod->name);
 	if (err)
 		goto out;
 	kobj_set_kset_s(mod->mkobj, module_subsys);
+	mod->mkobj->mod = mod;
 	err = kobject_register(&mod->mkobj->kobj);
 	if (err)
 		goto out;
 
-	mod->mkobj->num_attributes = 0;
-
-	for (i = 0; i < num_params; i++) {
-		if (kparam[i].perm) {
-			err = add_attribute(mod, &kparam[i]);
-			if (err)
-				goto out_unreg;
-		}
-	}
-	err = sysfs_unload_setup(mod);
-	if (err)
-		goto out_unreg;
-
 	err = module_param_sysfs_setup(mod, kparam, num_params);
 	if (err)
 		goto out_unreg;
@@ -1180,8 +1140,6 @@
 	return 0;
 
 out_unreg:
-	for (i = 0; i < mod->mkobj->num_attributes; i++)
-		sysfs_remove_file(&mod->mkobj->kobj,&mod->mkobj->attr[i].attr);
 	/* Calls module_kobj_release */
 	kobject_unregister(&mod->mkobj->kobj);
 	return err;
@@ -1192,12 +1150,8 @@
 
 static void mod_kobject_remove(struct module *mod)
 {
-	unsigned int i;
-
 	module_param_sysfs_remove(mod);
 
-	for (i = 0; i < mod->mkobj->num_attributes; i++)
-		sysfs_remove_file(&mod->mkobj->kobj,&mod->mkobj->attr[i].attr);
 	/* Calls module_kobj_release */
 	kobject_unregister(&mod->mkobj->kobj);
 }
