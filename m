Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTD3Cwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 22:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTD3Cwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 22:52:55 -0400
Received: from dp.samba.org ([66.70.73.150]:36018 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261969AbTD3Cwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 22:52:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] complete modinfo section
Date: Wed, 30 Apr 2003 12:24:28 +1000
Message-Id: <20030430030502.656C22C01A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-xmit.  Linus, please apply.

Rusty.

Name: Restore modinfo section
Author: Rusty Russell
Status: Tested on 2.5.66-bk2
Depends: 

D: Restores .modinfo section, and uses it to store license and vermagic.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26668-linux-2.5.66-bk2/include/linux/module.h .26668-linux-2.5.66-bk2.updated/include/linux/module.h
--- .26668-linux-2.5.66-bk2/include/linux/module.h	2003-03-27 15:20:11.000000000 +1100
+++ .26668-linux-2.5.66-bk2.updated/include/linux/module.h	2003-03-27 15:20:26.000000000 +1100
@@ -20,10 +20,7 @@
 #include <asm/module.h>
 
 /* Not Yet Implemented */
-#define MODULE_AUTHOR(name)
-#define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
-#define MODULE_PARM_DESC(var,desc)
 #define print_modules()
 
 /* v850 toolchain uses a `_' prefix for all user symbols */
@@ -58,12 +55,11 @@ search_extable(const struct exception_ta
 	       unsigned long value);
 
 #ifdef MODULE
-#define ___module_cat(a,b) a ## b
+#define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
-/* For userspace: you can also call me... */
-#define MODULE_ALIAS(alias)					\
-	static const char __module_cat(__alias_,__LINE__)[]	\
-		__attribute__((section(".modinfo"),unused)) = "alias=" alias
+#define __MODULE_INFO(tag, name, info)					  \
+static const char __module_cat(name,__LINE__)[]				  \
+  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 extern const struct gtype##_id __mod_##gtype##_table		\
@@ -71,6 +67,19 @@ extern const struct gtype##_id __mod_##g
 
 #define THIS_MODULE (&__this_module)
 
+#else  /* !MODULE */
+
+#define MODULE_GENERIC_TABLE(gtype,name)
+#define __MODULE_INFO(tag, name, info)
+#define THIS_MODULE ((struct module *)0)
+#endif
+
+/* Generic info of form tag = "info" */
+#define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
+
+/* For userspace: you can also call me... */
+#define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
+
 /*
  * The following license idents are currently accepted as indicating free
  * software modules
@@ -97,17 +108,18 @@ extern const struct gtype##_id __mod_##g
  * 2.	So the community can ignore bug reports including proprietary modules
  * 3.	So vendors can do likewise based on their own policies
  */
-#define MODULE_LICENSE(license)					\
-	static const char __module_license[]			\
-		__attribute__((section(".init.license"), unused)) = license
+#define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
 
-#else  /* !MODULE */
+/* Author, ideally of form NAME <EMAIL>[, NAME <EMAIL>]*[ and NAME <EMAIL>] */
+#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
+  
+/* What your module does. */
+#define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
 
-#define MODULE_ALIAS(alias)
-#define MODULE_GENERIC_TABLE(gtype,name)
-#define THIS_MODULE ((struct module *)0)
-#define MODULE_LICENSE(license)
-#endif
+/* One for each parameter, describing how to use it.  Some files do
+   multiple of these per line, so can't just use MODULE_INFO. */
+#define MODULE_PARM_DESC(_parm, desc) \
+	__MODULE_INFO(parm, _parm, #_parm ":" desc)
 
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26668-linux-2.5.66-bk2/kernel/module.c .26668-linux-2.5.66-bk2.updated/kernel/module.c
--- .26668-linux-2.5.66-bk2/kernel/module.c	2003-03-27 15:20:11.000000000 +1100
+++ .26668-linux-2.5.66-bk2.updated/kernel/module.c	2003-03-27 15:20:12.000000000 +1100
@@ -914,12 +914,12 @@ EXPORT_SYMBOL_GPL(__symbol_get);
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
-			    unsigned int strindex,
+			    const char *strtab,
 			    unsigned int versindex,
 			    struct module *mod)
 {
 	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
-	const char *strtab = (char *)sechdrs[strindex].sh_addr;
+	
 	unsigned int i, n = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 	int ret = 0;
 
@@ -1038,13 +1038,9 @@ static inline int license_is_gpl_compati
 		|| strcmp(license, "Dual MPL/GPL") == 0);
 }
 
-static void set_license(struct module *mod, Elf_Shdr *sechdrs, int licenseidx)
+static void set_license(struct module *mod, const char *license)
 {
-	char *license;
-
-	if (licenseidx) 
-		license = (char *)sechdrs[licenseidx].sh_addr;
-	else
+	if (!license)
 		license = "unspecified";
 
 	mod->license_gplok = license_is_gpl_compatible(license);
@@ -1055,6 +1051,40 @@ static void set_license(struct module *m
 	}
 }
 
+/* Parse tag=value strings from .modinfo section */
+static char *next_string(char *string, unsigned long *secsize)
+{
+	/* Skip non-zero chars */
+	while (string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+
+	/* Skip any zero padding. */
+	while (!string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+	return string;
+}
+
+static char *get_modinfo(Elf_Shdr *sechdrs,
+			 unsigned int info,
+			 const char *tag)
+{
+	char *p;
+	unsigned int taglen = strlen(tag);
+	unsigned long size = sechdrs[info].sh_size;
+
+	for (p = (char *)sechdrs[info].sh_addr; p; p = next_string(p, &size)) {
+		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
+			return p + taglen + 1;
+	}
+	return NULL;
+}
+
 /* Allocate and load the module: note that size of section 0 is always
    zero, and we rely on this for optional sections. */
 static struct module *load_module(void *umod,
@@ -1063,9 +1093,9 @@ static struct module *load_module(void *
 {
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
-	char *secstrings, *args;
-	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modindex, obsparmindex, licenseindex, gplindex, vmagindex,
+	char *secstrings, *args, *modmagic, *strtab = NULL;
+	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
+		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex;
 	long arglen;
 	struct module *mod;
@@ -1099,6 +1129,7 @@ static struct module *load_module(void *
 	/* Convenience variables */
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+	sechdrs[0].sh_addr = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = 0;
@@ -1112,6 +1143,7 @@ static struct module *load_module(void *
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
 			symindex = i;
 			strindex = sechdrs[i].sh_link;
+			strtab = (char *)hdr + sechdrs[strindex].sh_offset;
 		}
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
@@ -1120,12 +1152,6 @@ static struct module *load_module(void *
 #endif
 	}
 
-#ifdef CONFIG_KALLSYMS
-	/* Keep symbol and string tables for decoding later. */
-	sechdrs[symindex].sh_flags |= SHF_ALLOC;
-	sechdrs[strindex].sh_flags |= SHF_ALLOC;
-#endif
-
 	modindex = find_sec(hdr, sechdrs, secstrings,
 			    ".gnu.linkonce.this_module");
 	if (!modindex) {
@@ -1143,9 +1169,16 @@ static struct module *load_module(void *
 	setupindex = find_sec(hdr, sechdrs, secstrings, "__param");
 	exindex = find_sec(hdr, sechdrs, secstrings, "__ex_table");
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
-	licenseindex = find_sec(hdr, sechdrs, secstrings, ".init.license");
-	vmagindex = find_sec(hdr, sechdrs, secstrings, "__vermagic");
 	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
+	infoindex = find_sec(hdr, sechdrs, secstrings, ".modinfo");
+
+	/* Don't keep modinfo section */
+	sechdrs[infoindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
+#ifdef CONFIG_KALLSYMS
+	/* Keep symbol and string tables for decoding later. */
+	sechdrs[symindex].sh_flags |= SHF_ALLOC;
+	sechdrs[strindex].sh_flags |= SHF_ALLOC;
+#endif
 
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
@@ -1153,14 +1186,15 @@ static struct module *load_module(void *
 		goto free_hdr;
 	}
 
+	modmagic = get_modinfo(sechdrs, infoindex, "vermagic");
 	/* This is allowed: modprobe --force will invalidate it. */
-	if (!vmagindex) {
+	if (!modmagic) {
 		tainted |= TAINT_FORCED_MODULE;
 		printk(KERN_WARNING "%s: no version magic, tainting kernel.\n",
 		       mod->name);
-	} else if (!same_magic((char *)sechdrs[vmagindex].sh_addr, vermagic)) {
+	} else if (!same_magic(modmagic, vermagic)) {
 		printk(KERN_ERR "%s: version magic '%s' should be '%s'\n",
-		       mod->name, (char*)sechdrs[vmagindex].sh_addr, vermagic);
+		       mod->name, modmagic, vermagic);
 		err = -ENOEXEC;
 		goto free_hdr;
 	}
@@ -1240,11 +1274,11 @@ static struct module *load_module(void *
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 
-	/* Set up license info based on contents of section */
-	set_license(mod, sechdrs, licenseindex);
+	/* Set up license info based on the info section */
+	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	err = simplify_symbols(sechdrs, symindex, strindex, versindex, mod);
+	err = simplify_symbols(sechdrs, symindex, strtab, versindex, mod);
 	if (err < 0)
 		goto cleanup;
 
@@ -1274,8 +1308,7 @@ static struct module *load_module(void *
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *strtab = (char *)sechdrs[strindex].sh_addr;
 		if (sechdrs[i].sh_type == SHT_REL)
-			err = apply_relocate(sechdrs, strtab, symindex, i,
-					     mod);
+			err = apply_relocate(sechdrs, strtab, symindex, i,mod);
 		else if (sechdrs[i].sh_type == SHT_RELA)
 			err = apply_relocate_add(sechdrs, strtab, symindex, i,
 						 mod);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26668-linux-2.5.66-bk2/scripts/modpost.c .26668-linux-2.5.66-bk2.updated/scripts/modpost.c
--- .26668-linux-2.5.66-bk2/scripts/modpost.c	2003-03-18 12:21:42.000000000 +1100
+++ .26668-linux-2.5.66-bk2.updated/scripts/modpost.c	2003-03-27 15:20:12.000000000 +1100
@@ -398,9 +398,7 @@ add_header(struct buffer *b)
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
-	buf_printf(b, "const char vermagic[]\n");
-	buf_printf(b, "__attribute__((section(\"__vermagic\"))) =\n");
-	buf_printf(b, "VERMAGIC_STRING;\n");
+	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 }
 
 /* Record CRCs for unresolved symbols */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
