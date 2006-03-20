Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbWCTWIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbWCTWIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWCTWBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:58809 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030540AbWCTWBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:15 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/23] fix module sysfs files reference counting
In-Reply-To: <11428920383496-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <1142892038657-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The module files, refcnt, version, and srcversion did not properly
increment the owner's module reference count, allowing the modules to
be removed while the files were open, causing oopses.

This patch fixes this, and also fixes the problem that the version and
srcversion files were not showing up, unless CONFIG_MODULE_UNLOAD was
enabled, which is not correct.

Cc: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/module.h |    1 +
 kernel/module.c        |   77 +++++++++++++++++++-----------------------------
 kernel/params.c        |   10 ------
 3 files changed, 32 insertions(+), 56 deletions(-)

03e88ae1b13dfdc8bbaa59b8198e1ca53aad12ac
diff --git a/include/linux/module.h b/include/linux/module.h
index a25d5f6..70bd843 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -245,6 +245,7 @@ struct module
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_param_attrs *param_attrs;
+	struct module_attribute *modinfo_attrs;
 	const char *version;
 	const char *srcversion;
 
diff --git a/kernel/module.c b/kernel/module.c
index 5ca99fb..77764f2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -429,7 +429,6 @@ static inline void percpu_modcopy(void *
 }
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_MODULE_UNLOAD
 #define MODINFO_ATTR(field)	\
 static void setup_modinfo_##field(struct module *mod, const char *s)  \
 {                                                                     \
@@ -461,12 +460,7 @@ static struct module_attribute modinfo_#
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
-static struct module_attribute *modinfo_attrs[] = {
-	&modinfo_version,
-	&modinfo_srcversion,
-	NULL,
-};
-
+#ifdef CONFIG_MODULE_UNLOAD
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
 {
@@ -781,6 +775,15 @@ static inline void module_unload_init(st
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
+static struct module_attribute *modinfo_attrs[] = {
+	&modinfo_version,
+	&modinfo_srcversion,
+#ifdef CONFIG_MODULE_UNLOAD
+	&refcnt,
+#endif
+	NULL,
+};
+
 #ifdef CONFIG_OBSOLETE_MODPARM
 /* Bounds checking done below */
 static int obsparm_copy_string(const char *val, struct kernel_param *kp)
@@ -1106,37 +1109,28 @@ static inline void remove_sect_attrs(str
 }
 #endif /* CONFIG_KALLSYMS */
 
-
-#ifdef CONFIG_MODULE_UNLOAD
-static inline int module_add_refcnt_attr(struct module *mod)
-{
-	return sysfs_create_file(&mod->mkobj.kobj, &refcnt.attr);
-}
-static void module_remove_refcnt_attr(struct module *mod)
-{
-	return sysfs_remove_file(&mod->mkobj.kobj, &refcnt.attr);
-}
-#else
-static inline int module_add_refcnt_attr(struct module *mod)
-{
-	return 0;
-}
-static void module_remove_refcnt_attr(struct module *mod)
-{
-}
-#endif
-
-#ifdef CONFIG_MODULE_UNLOAD
 static int module_add_modinfo_attrs(struct module *mod)
 {
 	struct module_attribute *attr;
+	struct module_attribute *temp_attr;
 	int error = 0;
 	int i;
 
+	mod->modinfo_attrs = kzalloc((sizeof(struct module_attribute) *
+					(ARRAY_SIZE(modinfo_attrs) + 1)),
+					GFP_KERNEL);
+	if (!mod->modinfo_attrs)
+		return -ENOMEM;
+
+	temp_attr = mod->modinfo_attrs;
 	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
 		if (!attr->test ||
-		    (attr->test && attr->test(mod)))
-			error = sysfs_create_file(&mod->mkobj.kobj,&attr->attr);
+		    (attr->test && attr->test(mod))) {
+			memcpy(temp_attr, attr, sizeof(*temp_attr));
+			temp_attr->attr.owner = mod;
+			error = sysfs_create_file(&mod->mkobj.kobj,&temp_attr->attr);
+			++temp_attr;
+		}
 	}
 	return error;
 }
@@ -1146,12 +1140,16 @@ static void module_remove_modinfo_attrs(
 	struct module_attribute *attr;
 	int i;
 
-	for (i = 0; (attr = modinfo_attrs[i]); i++) {
+	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
+		/* pick a field to test for end of list */
+		if (!attr->attr.name)
+			break;
 		sysfs_remove_file(&mod->mkobj.kobj,&attr->attr);
-		attr->free(mod);
+		if (attr->free)
+			attr->free(mod);
 	}
+	kfree(mod->modinfo_attrs);
 }
-#endif
 
 static int mod_sysfs_setup(struct module *mod,
 			   struct kernel_param *kparam,
@@ -1169,19 +1167,13 @@ static int mod_sysfs_setup(struct module
 	if (err)
 		goto out;
 
-	err = module_add_refcnt_attr(mod);
-	if (err)
-		goto out_unreg;
-
 	err = module_param_sysfs_setup(mod, kparam, num_params);
 	if (err)
 		goto out_unreg;
 
-#ifdef CONFIG_MODULE_UNLOAD
 	err = module_add_modinfo_attrs(mod);
 	if (err)
 		goto out_unreg;
-#endif
 
 	return 0;
 
@@ -1193,10 +1185,7 @@ out:
 
 static void mod_kobject_remove(struct module *mod)
 {
-#ifdef CONFIG_MODULE_UNLOAD
 	module_remove_modinfo_attrs(mod);
-#endif
-	module_remove_refcnt_attr(mod);
 	module_param_sysfs_remove(mod);
 
 	kobject_unregister(&mod->mkobj.kobj);
@@ -1474,7 +1463,6 @@ static char *get_modinfo(Elf_Shdr *sechd
 	return NULL;
 }
 
-#ifdef CONFIG_MODULE_UNLOAD
 static void setup_modinfo(struct module *mod, Elf_Shdr *sechdrs,
 			  unsigned int infoindex)
 {
@@ -1489,7 +1477,6 @@ static void setup_modinfo(struct module 
 						attr->attr.name));
 	}
 }
-#endif
 
 #ifdef CONFIG_KALLSYMS
 int is_exported(const char *name, const struct module *mod)
@@ -1803,10 +1790,8 @@ static struct module *load_module(void _
 	if (strcmp(mod->name, "driverloader") == 0)
 		add_taint(TAINT_PROPRIETARY_MODULE);
 
-#ifdef CONFIG_MODULE_UNLOAD
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);
-#endif
 
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
diff --git a/kernel/params.c b/kernel/params.c
index c76ad25..a291505 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -638,13 +638,8 @@ static ssize_t module_attr_show(struct k
 	if (!attribute->show)
 		return -EIO;
 
-	if (!try_module_get(mk->mod))
-		return -ENODEV;
-
 	ret = attribute->show(attribute, mk->mod, buf);
 
-	module_put(mk->mod);
-
 	return ret;
 }
 
@@ -662,13 +657,8 @@ static ssize_t module_attr_store(struct 
 	if (!attribute->store)
 		return -EIO;
 
-	if (!try_module_get(mk->mod))
-		return -ENODEV;
-
 	ret = attribute->store(attribute, mk->mod, buf, len);
 
-	module_put(mk->mod);
-
 	return ret;
 }
 
-- 
1.2.4


