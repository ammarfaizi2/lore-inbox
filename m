Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUHAQ6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUHAQ6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 12:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHAQ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 12:58:40 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:11239 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S266013AbUHAQ4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 12:56:03 -0400
Date: Sun, 1 Aug 2004 18:54:07 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH 1/2] export module parameters in sysfs for modules _and_ built-in code
Message-ID: <20040801165407.GA8667@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new /sys top-level directory named "parameters", and make all
to-be-sysfs-exported module parameters available as attributes to kobjects.
Currently, only module parameters in _modules_ are exported in /sys/modules/,
while those of "modules" built into the kernel can be set by the kernel command 
line, but not read or set via sysfs.

For modules, a symlink

brodo@mondschein param $ ls -l /sys/module/ehci_hcd/ | grep param
lrwxrwxrwx  1 brodo brodo    0  1. Aug 17:50 parameters -> ../../parameters/ehci_hcd

is added. Removal of double module parameters export for modules is sent in a second
patch, so the diffstat

 include/linux/module.h |    2
 kernel/module.c        |   14 +
 kernel/params.c        |  377 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+)

looks worse than it is.

Much of this work is based on the current code for modules only to be found in
linux/kernel/module.c

Signed-off-by: Dominik Brodowski <linux@brodo.de>

diff -ruN linux-original/include/linux/module.h linux/include/linux/module.h
--- linux-original/include/linux/module.h	2004-08-01 18:40:25.836963920 +0200
+++ linux/include/linux/module.h	2004-08-01 18:39:01.019858080 +0200
@@ -240,6 +240,7 @@
 	struct module_sect_attr attrs[0];
 };
 
+struct param_kobject;
 
 struct module
 {
@@ -253,6 +254,7 @@
 
 	/* Sysfs stuff. */
 	struct module_kobject *mkobj;
+	struct param_kobject *params_kobject;
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
diff -ruN linux-original/kernel/module.c linux/kernel/module.c
--- linux-original/kernel/module.c	2004-08-01 18:40:25.939948264 +0200
+++ linux/kernel/module.c	2004-08-01 18:39:01.097846224 +0200
@@ -1131,6 +1131,12 @@
 };
 static decl_subsys(module, &module_ktype, NULL);
 
+extern int module_param_sysfs_setup(struct module *mod, 
+				    struct kernel_param *kparam,
+				    unsigned int num_params);
+
+extern void module_param_sysfs_remove(struct module *mod);
+
 static int mod_sysfs_setup(struct module *mod,
 			   struct kernel_param *kparam,
 			   unsigned int num_params)
@@ -1166,6 +1172,11 @@
 	err = sysfs_unload_setup(mod);
 	if (err)
 		goto out_unreg;
+
+	err = module_param_sysfs_setup(mod, kparam, num_params);
+	if (err)
+		goto out_unreg;
+
 	return 0;
 
 out_unreg:
@@ -1182,6 +1193,9 @@
 static void mod_kobject_remove(struct module *mod)
 {
 	unsigned int i;
+
+	module_param_sysfs_remove(mod);
+
 	for (i = 0; i < mod->mkobj->num_attributes; i++)
 		sysfs_remove_file(&mod->mkobj->kobj,&mod->mkobj->attr[i].attr);
 	/* Calls module_kobj_release */
diff -ruN linux-original/kernel/params.c linux/kernel/params.c
--- linux-original/kernel/params.c	2004-08-01 18:40:25.948946896 +0200
+++ linux/kernel/params.c	2004-08-01 18:39:58.243158816 +0200
@@ -20,6 +20,8 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/device.h>
+#include <linux/config.h>
 
 #if 0
 #define DEBUGP printk
@@ -339,6 +341,381 @@
 	return 0;
 }
 
+
+
+/* sysfs output in /sys/parameters/ */
+
+extern struct kernel_param __start___param[], __stop___param[];
+
+#define MAX_KBUILD_MODNAME KOBJ_NAME_LEN
+
+struct param_attribute
+{
+	struct attribute attr;
+	struct kernel_param *param;
+};
+
+struct param_kobject
+{
+	struct kobject kobj;
+
+	unsigned int num_attributes;
+	struct param_attribute attr[0];
+};
+
+#define to_param_attr(n) container_of(n, struct param_attribute, attr);
+
+static ssize_t param_attr_show(struct kobject *kobj,
+			       struct attribute *attr,
+			       char *buf)
+{
+	int count;
+	struct param_attribute *attribute = to_param_attr(attr);
+
+	if (!attribute->param->get)
+		return -EPERM;
+
+	count = attribute->param->get(buf, attribute->param);
+	if (count > 0) {
+		strcat(buf, "\n");
+		++count;
+	}
+	return count;
+}
+
+/* sysfs always hands a nul-terminated string in buf.  We rely on that. */
+static ssize_t param_attr_store(struct kobject *kobj,
+				struct attribute *attr,
+				const char *buf, size_t len)
+{
+	int err;
+	struct param_attribute *attribute = to_param_attr(attr);
+
+	if (!attribute->param->set)
+		return -EPERM;
+
+	err = attribute->param->set(buf, attribute->param);
+	if (!err)
+		return len;
+	return err;
+}
+
+
+static struct sysfs_ops param_sysfs_ops = {
+	.show = param_attr_show,
+	.store = param_attr_store,
+};
+
+static void param_kobj_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct param_kobject, kobj));
+	return;
+}
+
+static struct kobj_type param_ktype = {
+	.sysfs_ops =	&param_sysfs_ops,
+	.release =	&param_kobj_release,
+};
+
+static decl_subsys(parameters, &param_ktype, NULL);
+
+
+#ifdef CONFIG_MODULE
+#define __modinit 
+#else
+#define __modinit __init
+#endif
+
+/*
+ * param_add_attribute - actually adds an parameter to sysfs
+ * @mod: owner of parameter
+ * @pk: param_kobject the attribute shall be assigned to. One per module, one per KBUILD_MODNAME.
+ * @kp: kernel_param to be added
+ * @skip: offset where the parameter name start in kp->name. Needed for built-in "modules"
+ *
+ * Fill in data into appropriate &pk->attr[], and create sysfs file.
+ */
+static __modinit int param_add_attribute(struct module *mod, 
+					 struct param_kobject *pk, 
+					 struct kernel_param *kp, 
+					 unsigned int skip)
+{
+	struct param_attribute *a;
+	int retval;
+
+	a = &pk->attr[pk->num_attributes];
+	a->attr.name = (char *) &kp->name[skip];
+	a->attr.owner = mod;
+	a->attr.mode = kp->perm;
+	a->param = kp;
+	retval = sysfs_create_file(&pk->kobj, &a->attr);
+	if (!retval)
+		pk->num_attributes++;
+	return retval;
+}
+
+
+/*
+ * param_sysfs_remove - remove sysfs support for one module or KBUILD_MODNAME
+ * @pk: struct param_kobject which is to be removed
+ * @embed: where reference to struct param_kobject is stored, if anywhere
+ *
+ * Called when an error in registration occurs or a module is removed from the system.
+ */
+static __modinit void param_sysfs_remove(struct param_kobject *pk, 
+					 struct param_kobject **embed)
+{
+	unsigned int i;
+	for (i = 0; i < pk->num_attributes; i++)
+		sysfs_remove_file(&pk->kobj,&pk->attr[i].attr);
+
+	/* Calls param_kobj_release */
+	kobject_unregister(&pk->kobj);
+
+	if (embed)
+		*embed = NULL;
+}
+
+
+/*
+ * param_sysfs_setup - setup sysfs support for one module or KBUILD_MODNAME
+ * @name: name of module
+ * @mod: owner of module
+ * @kparam: array of struct kernel_param, the actual parameter definitions
+ * @num_params: number of entries in array
+ * @name_skip: offset where the parameter name start in kparam[].name. Needed for built-in "modules"
+ * @embed: where to save allocated struct param_kobject, if anywhere
+ *
+ * Create a kobject for a (per-module) group of parameters, and create files in sysfs.
+ */
+static __modinit int param_sysfs_setup(char *name, 
+				       struct module *mod,
+				       struct kernel_param *kparam,
+				       unsigned int num_params,
+				       unsigned int name_skip,
+				       struct param_kobject **embed)
+{
+	struct param_kobject *pk;
+	unsigned int valid_attrs = 0;
+	unsigned int i;
+	int err;
+
+	for (i=0; i<num_params; i++) {
+		if (kparam[i].perm)
+			valid_attrs++;
+	}
+
+	if (!valid_attrs)
+		return ENODEV;
+
+	pk = kmalloc(sizeof(struct param_kobject) + sizeof(struct param_attribute) * valid_attrs, GFP_KERNEL);
+	if (!pk)
+		return -ENOMEM;
+	memset(pk, 0, sizeof(struct param_kobject) + sizeof(struct param_attribute) * valid_attrs);
+
+	err = kobject_set_name(&pk->kobj, name);
+	if (err)
+		goto out;
+
+	kobj_set_kset_s(pk, parameters_subsys);
+	err = kobject_register(&pk->kobj);
+	if (err)
+		goto out;
+
+	for (i = 0; i < num_params; i++) {
+		if (kparam[i].perm) {
+			err = param_add_attribute(mod, pk, &kparam[i], name_skip);
+			if (err)
+				goto out_unreg;
+		}
+	}
+
+	if (embed)
+		*embed = pk;
+
+	return 0;
+
+out_unreg:
+	param_sysfs_remove(pk, embed);
+	return err;
+
+out:
+	kfree(pk);
+	return err;
+}
+
+
+#ifdef CONFIG_MODULES
+
+/*
+ * module_param_sysfs_setup - setup sysfs support for one module
+ * @mod: module
+ * @kparam: module parameters (array)
+ * @num_params: number of module parameters
+ *
+ * Adds sysfs entries for module parameters, and creates a link from
+ * /sys/module/[mod->name]/parameters to /sys/parameters/[mod->name]/
+ */
+int module_param_sysfs_setup(struct module *mod, 
+			     struct kernel_param *kparam,
+			     unsigned int num_params)
+{
+	int err;
+
+	err = param_sysfs_setup(mod->name, mod, kparam, num_params, 0, &mod->params_kobject);
+	if (err == ENODEV)
+		return 0;
+	if (err)
+		return (err);
+
+	err = sysfs_create_link(&mod->mkobj->kobj, &mod->params_kobject->kobj, "parameters");
+	if (err)
+		goto out_unreg;
+
+	return 0;
+
+out_unreg:
+	param_sysfs_remove(mod->params_kobject, &mod->params_kobject);
+	return err;
+
+}
+
+
+/*
+ * module_param_sysfs_remove - remove sysfs support for one module
+ * @mod: module
+ *
+ * Remove sysfs entries for module parameters, and remove the link from
+ * /sys/module/[mod->name]/parameters to /sys/parameters/[mod->name]/
+ */
+void module_param_sysfs_remove(struct module *mod) 
+{
+	struct param_kobject *pk;
+
+	pk = mod->params_kobject;
+	if (!pk)
+		return;
+
+	sysfs_remove_link(&mod->mkobj->kobj, "parameters");
+
+	param_sysfs_remove(pk, &mod->params_kobject);
+}
+
+#endif
+
+
+/*
+ * kernel_param_sysfs_setup - wrapper for built-in params support
+ */
+static int __init kernel_param_sysfs_setup(char *name, 
+					   struct kernel_param *kparam,
+					   unsigned int num_params,
+					   unsigned int name_skip)
+{
+	return param_sysfs_setup(name, THIS_MODULE, kparam, num_params, name_skip, NULL);
+}
+
+
+/*
+ * param_sysfs_builtin - add contents in /sys/parameters for built-in modules
+ *
+ * Add module_parameters to sysfs for "modules" built into the kernel.
+ *
+ * The "module" name (KBUILD_MODNAME) is stored before a dot, the
+ * "parameter" name is stored behind a dot in kernel_param->name. So,
+ * extract the "module" name for all built-in kernel_param-eters,
+ * and for all who have the same, call kernel_param_sysfs_setup.
+ */
+static int __init param_sysfs_builtin(void)
+{
+	int err = 0;
+	struct kernel_param *kp;
+	struct kernel_param *kp_begin = NULL;
+	unsigned int num_param, i, j;
+	unsigned int stop_point;
+	unsigned int last_stop_point = 0;
+	unsigned int count = 0;
+	char *kbuild_modname;
+
+	num_param = __stop___param - __start___param;
+	if (!num_param)
+		return 0;
+
+	kbuild_modname = kmalloc(sizeof(char) * (MAX_KBUILD_MODNAME + 1), GFP_KERNEL);
+	if (!kbuild_modname)
+		return -ENOMEM;
+	memset(kbuild_modname, 0, sizeof(char) * (MAX_KBUILD_MODNAME + 1));
+
+	for (i=0; i<num_param; i++) {
+		kp = &__start___param[i];
+		stop_point = 0;
+
+		/* get KBUILD_MODNAME out of kp */
+		for (j=0; j <= MAX_KBUILD_MODNAME; j++)
+		{
+			if ((kp->name[j] == '\0') || (kp->name[j] == '\n')) {
+				DEBUGP("invalid KBUILD_MODNAME: %s\n", kp->name);
+				break;
+			}
+			if (kp->name[j] == '.') {
+				stop_point = j;
+				break;
+			}
+		}
+		if (!stop_point) {
+			DEBUGP("couldn't find stop_point\n");
+			continue;
+		}
+
+		/* add a new kobject for previous kernel_params if a new 
+		 * kbuild_modname is detected for this kernel_param.
+		 */
+		if (kp_begin && strncmp(kbuild_modname, kp->name, stop_point))
+		{
+			kernel_param_sysfs_setup(kbuild_modname, kp_begin, count, last_stop_point);
+		}
+
+		/* first, or new kbuild_modname */
+		if (!kp_begin || strncmp(kbuild_modname, kp->name, stop_point)) {
+			strncpy(kbuild_modname, kp->name, stop_point);
+			kbuild_modname[stop_point] = '\0';
+			count = 0;
+
+			kp_begin = kp;
+			last_stop_point = stop_point + 1;
+		}
+
+		count++;
+	}
+	/* last kernel_params need to be registered as well */
+	if (kp_begin && count)
+		kernel_param_sysfs_setup(kbuild_modname, kp_begin, count, last_stop_point);
+
+	kfree (kbuild_modname);
+	return (err);
+}
+
+
+/*
+ * param_sysfs_init - wrapper for built-in params support
+ */
+static int __init param_sysfs_init(void)
+{
+	int err;
+
+	err = subsystem_register(&parameters_subsys);
+	if (err)
+		return (err);
+
+	param_sysfs_builtin();
+
+	return 0;
+}
+
+/* Needs to be before __initcall(module_init) */
+fs_initcall(param_sysfs_init);
+
+
 EXPORT_SYMBOL(param_set_short);
 EXPORT_SYMBOL(param_get_short);
 EXPORT_SYMBOL(param_set_ushort);
