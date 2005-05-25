Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVEYN2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVEYN2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVEYN2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:28:32 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:64817 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262347AbVEYNZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:25:59 -0400
X-IronPort-AV: i="3.93,135,1115010000"; 
   d="scan'208"; a="247098909:sNHT25329140"
Date: Wed, 25 May 2005 08:25:55 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org, greg@kroah.com, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2.6.12-rc4-mm2] modules: add version and srcversion to sysfs
Message-ID: <20050525132555.GA13453@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module:  Add module version and srcversion to the sysfs tree

This patch adds version and srcversion files to
/sys/module/${modulename} containing the version and srcversion fields
of the module's modinfo section (if present).

/sys/module/e1000
|-- srcversion
`-- version

This patch differs slightly from the version posted in January, as it
now uses the new kstrdup() call in -mm.

Why put this in sysfs?

a) Tools like DKMS, which deal with changing out individual kernel
modules without replacing the whole kernel, can behave smarter if they
can tell the version of a given module.  The autoinstaller feature,
for example, which determines if your system has a "good" version of a
driver (i.e. if the one provided by DKMS has a newer verson than that
provided by the kernel package installed), and to automatically
compile and install a newer version if DKMS has it but your kernel
doesn't yet have that version.

b) Because sysadmins manually, or with tools like DKMS, can switch out
modules on the file system, you can't count on 'modinfo foo.ko', which
looks at /lib/modules/${kernelver}/... actually matching what is
loaded into the kernel already.  Hence asking sysfs for this.

c) as the unbind-driver-from-device work takes shape, it will be
possible to rebind a driver that's built-in (no .ko to modinfo for the
version) to a newly loaded module.  sysfs will have the
currently-built-in version info, for comparison.

d) tech support scripts can then easily grab the version info for
what's running presently - a question I get often.

 include/linux/module.h |    5 ++
 kernel/module.c        |   85 +++++++++++++++++++++++++++++++++++++++++++++++++

There has been renewed interest in this patch on linux-scsi by driver
authors.

As the idea originated from GregKH, I leave his Signed-off-by: intact,
though the implementation is nearly completely new.  Compiled and run
on x86 and x86_64.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks,
Matt


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.6.12-rc4-mm2/include/linux/module.h	Fri May 20 12:13:13 2005
+++ linux-2.6.12-rc4-mm2.sysfs_modinfo/include/linux/module.h	Tue May 24 22:32:34 2005
@@ -51,6 +51,9 @@ struct module_attribute {
         ssize_t (*show)(struct module_attribute *, struct module *, char *);
         ssize_t (*store)(struct module_attribute *, struct module *,
 			 const char *, size_t count);
+	void (*setup)(struct module *, const char *);
+	int (*test)(struct module *);
+	void (*free)(struct module *);
 };
 
 struct module_kobject
@@ -239,6 +242,8 @@ struct module
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_param_attrs *param_attrs;
+	const char *version;
+	const char *srcversion;
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
--- linux-2.6.12-rc4-mm2/kernel/module.c	Fri May 20 12:13:42 2005
+++ linux-2.6.12-rc4-mm2.sysfs_modinfo/kernel/module.c	Wed May 25 04:31:43 2005
@@ -35,6 +35,7 @@
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
 #include <linux/device.h>
+#include <linux/string.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -663,6 +664,43 @@ static struct module_attribute refcnt = 
 	.show = show_refcnt,
 };
 
+#define MODINFO_ATTR(field)	\
+static void setup_modinfo_##field(struct module *mod, const char *s)  \
+{                                                                     \
+	mod->field = kstrdup(s, GFP_KERNEL);                          \
+}                                                                     \
+static ssize_t show_modinfo_##field(struct module_attribute *mattr,   \
+	                struct module *mod, char *buffer)             \
+{                                                                     \
+	return sprintf(buffer, "%s\n", mod->field);                   \
+}                                                                     \
+static int modinfo_##field##_exists(struct module *mod)               \
+{                                                                     \
+	return mod->field != NULL;                                    \
+}                                                                     \
+static void free_modinfo_##field(struct module *mod)                  \
+{                                                                     \
+        kfree(mod->field);                                            \
+        mod->field = NULL;                                            \
+}                                                                     \
+static struct module_attribute modinfo_##field = {                    \
+	.attr = { .name = __stringify(field), .mode = 0444,           \
+		  .owner = THIS_MODULE },                             \
+	.show = show_modinfo_##field,                                 \
+	.setup = setup_modinfo_##field,                               \
+	.test = modinfo_##field##_exists,                             \
+	.free = free_modinfo_##field,                                 \
+};
+
+MODINFO_ATTR(version);
+MODINFO_ATTR(srcversion);
+
+static struct module_attribute *modinfo_attrs[] = {
+	&modinfo_version,
+	&modinfo_srcversion,
+	NULL,
+};
+
 #else /* !CONFIG_MODULE_UNLOAD */
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
@@ -1031,6 +1069,30 @@ static void module_remove_refcnt_attr(st
 }
 #endif
 
+static int module_add_modinfo_attrs(struct module *mod)
+{
+	struct module_attribute * attr;
+	int error = 0;
+	int i;
+
+	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
+		if (!attr->test ||
+		    (attr->test && attr->test(mod)))
+			error = sysfs_create_file(&mod->mkobj.kobj,&attr->attr);
+	}
+	return error;
+}
+
+static void module_remove_modinfo_attrs(struct module *mod)
+{
+	struct module_attribute * attr;
+	int i;
+
+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
+		sysfs_remove_file(&mod->mkobj.kobj,&attr->attr);
+		attr->free(mod);
+	}
+}
 
 static int mod_sysfs_setup(struct module *mod,
 			   struct kernel_param *kparam,
@@ -1056,6 +1118,10 @@ static int mod_sysfs_setup(struct module
 	if (err)
 		goto out_unreg;
 
+	err = module_add_modinfo_attrs(mod);
+	if (err)
+		goto out_unreg;
+
 	return 0;
 
 out_unreg:
@@ -1066,6 +1132,7 @@ out:
 
 static void mod_kobject_remove(struct module *mod)
 {
+	module_remove_modinfo_attrs(mod);
 	module_remove_refcnt_attr(mod);
 	module_param_sysfs_remove(mod);
 
@@ -1311,6 +1378,21 @@ static char *get_modinfo(Elf_Shdr *sechd
 	return NULL;
 }
 
+static void setup_modinfo(struct module *mod, Elf_Shdr *sechdrs,
+			  unsigned int infoindex)
+{
+	struct module_attribute * attr;
+	int i;
+
+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
+		if (attr->setup)
+			attr->setup(mod,
+				    get_modinfo(sechdrs,
+						infoindex,
+						attr->attr.name));
+	}
+}
+
 #ifdef CONFIG_KALLSYMS
 int is_exported(const char *name, const struct module *mod)
 {
@@ -1614,6 +1696,9 @@ static struct module *load_module(void _
 
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
+
+	/* Set up MODINFO_ATTR fields */
+	setup_modinfo(mod, sechdrs, infoindex);
 
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
