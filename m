Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVAZGGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVAZGGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 01:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAZGGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 01:06:13 -0500
Received: from lists.us.dell.com ([143.166.224.162]:6555 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262355AbVAZGGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 01:06:03 -0500
Date: Wed, 26 Jan 2005 00:05:41 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: rusty@rustcorp.com.au, Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
Message-ID: <20050126060541.GA16017@lists.us.dell.com>
References: <20050119171357.GA16136@lst.de> <20050119172106.GB32702@kroah.com> <20050119213924.GG5508@us.ibm.com> <20050119224016.GA5086@kroah.com> <20050119230350.GA23553@infradead.org> <20050119230855.GA5646@kroah.com> <20050119231559.GA10404@lists.us.dell.com> <20050119234219.GA6294@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119234219.GA6294@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module:  Add module version and srcversion to the sysfs tree

There are two ways one could go with this:
1) strdup() the interesting fields from modinfo section before it is discarded.
That's what this patch does, and what Greg's original patch did too,
despite his reservations about using strdup().
2) don't drop the modinfo section on load, and use those strings directly.

The problem with 2) is that the modinfo section can be quite large,
compared to the few bytes that the "interesting" fields consume.  And
it would have to be kmalloc'd and copied from the vmalloc area before
that area is dropped.

So, I did #1.

It's trivial to add new fields now.  For my purposes, version and
srcversion are all I need, so that's all I'm exposing via sysfs.
Others may be added later as needed.

As the idea originated from GregKH, I leave his Signed-off-by: intact,
though the implementation is nearly completely new.  Compiled and run
on x86_64.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

Rusty, thoughts?

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== include/linux/module.h 1.92 vs edited =====
--- 1.92/include/linux/module.h	2005-01-10 13:28:15 -06:00
+++ edited/include/linux/module.h	2005-01-25 22:25:15 -06:00
@@ -51,6 +51,9 @@ struct module_attribute {
         ssize_t (*show)(struct module_attribute *, struct module *, char *);
         ssize_t (*store)(struct module_attribute *, struct module *,
 			 const char *, size_t count);
+	void (*setup)(struct module *, const char *);
+	int (*test)(struct module *);
+	void (*free)(struct module *);
 };
 
 struct module_kobject
@@ -249,6 +252,8 @@ struct module
 	/* Sysfs stuff. */
 	struct module_kobject mkobj;
 	struct module_param_attrs *param_attrs;
+	const char *version;
+	const char *srcversion;
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
===== kernel/module.c 1.132 vs edited =====
--- 1.132/kernel/module.c	2005-01-11 18:42:57 -06:00
+++ edited/kernel/module.c	2005-01-25 23:42:17 -06:00
@@ -663,6 +663,57 @@ static struct module_attribute refcnt = 
 	.show = show_refcnt,
 };
 
+static char *strdup(const char *str)
+{
+	char *s;
+
+	if (!str)
+		return NULL;
+	s = kmalloc(strlen(str)+1, GFP_KERNEL);
+	if (!s)
+		return NULL;
+	strcpy(s, str);
+	return s;
+}
+
+#define MODINFO_ATTR(field)	\
+static void setup_modinfo_##field(struct module *mod, const char *s)  \
+{                                                                     \
+	mod->field = strdup(s);                                       \
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
@@ -1031,6 +1082,29 @@ static void module_remove_refcnt_attr(st
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
@@ -1056,6 +1130,10 @@ static int mod_sysfs_setup(struct module
 	if (err)
 		goto out_unreg;
 
+	err = module_add_modinfo_attrs(mod);
+	if (err)
+		goto out_unreg;
+
 	return 0;
 
 out_unreg:
@@ -1066,6 +1144,7 @@ out:
 
 static void mod_kobject_remove(struct module *mod)
 {
+	module_remove_modinfo_attrs(mod);
 	module_remove_refcnt_attr(mod);
 	module_param_sysfs_remove(mod);
 
@@ -1303,6 +1382,21 @@ static char *get_modinfo(Elf_Shdr *sechd
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
@@ -1606,6 +1700,9 @@ static struct module *load_module(void _
 
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
+
+	/* Set up MODINFO_ATTR fields */
+	setup_modinfo(mod, sechdrs, infoindex);
 
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strtab, versindex, pcpuindex,
