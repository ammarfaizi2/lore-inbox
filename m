Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUFCVjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUFCVjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUFCVjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:39:55 -0400
Received: from vena.lwn.net ([206.168.112.25]:58502 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264348AbUFCVjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:39:48 -0400
Message-ID: <20040603213946.31209.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Module section offsets in /sys/module
cc: rusty@rustcorp.com.au
From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 03 Jun 2004 15:39:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So here I am trying to write about how one can apply gdb to a running
kernel, and I'd like to tell people how to debug loadable modules.  Only
with the 2.6 module loader, there's no way to find out where the various
sections in the module image ended up, so you can't do much.  This patch
attempts to fix that by adding a "sections" subdirectory to every module's
entry in /sys/module; each attribute in that directory associates a
beginning address with the section name.  Those attributes can be used by a
a simple script to generate an add-symbol-file command for gdb, something
like:

#!/bin/bash
#
# gdbline module image
#
# Outputs an add-symbol-file line suitable for pasting into gdb to examine
# a loaded module.
#
cd /sys/module/$1/sections
echo -n add-symbol-file $2 `/bin/cat .text`

for section in .[a-z]* *; do
    if [ $section != ".text" ]; then
	echo  " \\"
	echo -n "	-s" $section `/bin/cat $section`
    fi
done
echo

Currently, this feature is absent if CONFIG_KALLSYMS is not set.  I do
wonder if CONFIG_DEBUG_INFO might not be a better choice, now that I think
about it.  Section names are unmunged, so "ls -a" is needed to see most of
them. 

Applies to 2.6.7-rc2.  Comments?

jon

diff -urNp -X ../dontdiff 2.6.7-rc2-vanilla/include/linux/module.h 2.6.7-rc2/include/linux/module.h
--- 2.6.7-rc2-vanilla/include/linux/module.h	2004-06-02 17:14:10.000000000 -0600
+++ 2.6.7-rc2/include/linux/module.h	2004-06-03 15:01:29.298761888 -0600
@@ -225,6 +225,22 @@ struct module_kobject
 	struct module_attribute attr[0];
 };
 
+/* Similar stuff for section attributes. */
+#define MODULE_SECT_NAME_LEN 32
+struct module_sect_attr
+{
+	struct attribute attr;
+	char name[MODULE_SECT_NAME_LEN];
+	unsigned long address;
+};
+
+struct module_sections
+{
+	struct kobject kobj;
+	struct module_sect_attr attrs[0];
+};
+
+
 struct module
 {
 	enum module_state state;
@@ -298,6 +314,9 @@ struct module
 	Elf_Sym *symtab;
 	unsigned long num_symtab;
 	char *strtab;
+
+	/* Section attributes */
+	struct module_sections *sect_attrs;
 #endif
 
 	/* Per-cpu data. */
diff -urNp -X ../dontdiff 2.6.7-rc2-vanilla/kernel/module.c 2.6.7-rc2/kernel/module.c
--- 2.6.7-rc2-vanilla/kernel/module.c	2004-06-02 17:14:10.000000000 -0600
+++ 2.6.7-rc2/kernel/module.c	2004-06-03 15:37:16.993262696 -0600
@@ -981,6 +981,104 @@ static unsigned long resolve_symbol(Elf_
 	return ret;
 }
 
+
+/*
+ * /sys/module/foo/sections stuff
+ * J. Corbet <corbet@lwn.net>
+ */
+#ifdef CONFIG_KALLSYMS
+static void module_sect_attrs_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct module_sections, kobj));
+}
+
+static ssize_t module_sect_show(struct kobject *kobj, struct attribute *attr,
+		char *buf)
+{
+	struct module_sect_attr *sattr =
+		container_of(attr, struct module_sect_attr, attr);
+	return sprintf(buf, "0x%lx\n", sattr->address);
+}
+
+static struct sysfs_ops module_sect_ops = {
+	.show = module_sect_show,
+};
+
+static struct kobj_type module_sect_ktype = {
+	.sysfs_ops = &module_sect_ops,
+	.release =   module_sect_attrs_release,
+};
+
+static void add_sect_attrs(struct module *mod, unsigned int nsect,
+		char *secstrings, Elf_Shdr *sechdrs)
+{
+	unsigned int nloaded = 0, i;
+	struct module_sect_attr *sattr;
+	
+	if (!mod->mkobj)
+		return;
+	
+	/* Count loaded sections and allocate structures */
+	for (i = 0; i < nsect; i++)
+		if (sechdrs[i].sh_flags & SHF_ALLOC)
+			nloaded++;
+	mod->sect_attrs = kmalloc(sizeof(struct module_sections) +
+			nloaded*sizeof(mod->sect_attrs->attrs[0]), GFP_KERNEL);
+	if (! mod->sect_attrs)
+		return;
+
+	/* sections entry setup */
+	memset(mod->sect_attrs, 0, sizeof(struct module_sections));
+	if (kobject_set_name(&mod->sect_attrs->kobj, "sections"))
+		goto out;
+	mod->sect_attrs->kobj.parent = &mod->mkobj->kobj;
+	mod->sect_attrs->kobj.ktype = &module_sect_ktype;
+	if (kobject_register(&mod->sect_attrs->kobj))
+		goto out;
+
+	/* And the section attributes. */
+	sattr = &mod->sect_attrs->attrs[0];
+	for (i = 0; i < nsect; i++) {
+		if (! (sechdrs[i].sh_flags & SHF_ALLOC))
+			continue;
+		sattr->address = sechdrs[i].sh_addr;
+		strlcpy(sattr->name, secstrings + sechdrs[i].sh_name,
+				MODULE_SECT_NAME_LEN);
+		sattr->attr.name = sattr->name;
+		sattr->attr.owner = mod;
+		sattr->attr.mode = S_IRUGO;
+		(void) sysfs_create_file(&mod->sect_attrs->kobj, &sattr->attr);
+		sattr++;
+	}
+	return;
+  out:
+	kfree(mod->sect_attrs);
+	mod->sect_attrs = NULL;
+}
+
+static void remove_sect_attrs(struct module *mod)
+{
+	if (mod->sect_attrs) {
+		kobject_unregister(&mod->sect_attrs->kobj);
+		mod->sect_attrs = NULL;
+	}
+}
+
+
+#else
+static inline void add_sect_attrs(struct module *mod, unsigned int nsect,
+		char *sectstrings, Elf_Shdr *sechdrs)
+{
+}
+
+static inline void remove_sect_attrs(struct module *mod)
+{
+}
+#endif /* CONFIG_KALLSYMS */
+
+
+
+
 #define to_module_attr(n) container_of(n, struct module_attribute, attr);
 
 static ssize_t module_attr_show(struct kobject *kobj,
@@ -1099,6 +1197,7 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
 
+	remove_sect_attrs(mod);
 	mod_kobject_remove(mod);
 
 	/* Arch-specific cleanup. */
@@ -1712,6 +1811,7 @@ static struct module *load_module(void _
 			      / sizeof(struct kernel_param));
 	if (err < 0)
 		goto arch_cleanup;
+	add_sect_attrs(mod, hdr->e_shnum, secstrings, sechdrs);
 
 	/* Get rid of temporary copy */
 	vfree(hdr);
