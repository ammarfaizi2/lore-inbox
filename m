Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269024AbTBXAPm>; Sun, 23 Feb 2003 19:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbTBXAPm>; Sun, 23 Feb 2003 19:15:42 -0500
Received: from dp.samba.org ([66.70.73.150]:60052 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269024AbTBXAPb>;
	Sun, 23 Feb 2003 19:15:31 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCHES] minor module.c code cleanups modinfo section
Date: Fri, 21 Feb 2003 18:55:04 +1100
Message-Id: <20030224002543.DDEE42C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Three patchess.  First one is cosmetic changes from a big
if/else/if statement to a find_sec function for modules, and
handle_section removal.

Second reintroduces the .modinfo section and puts vermagic, aliases,
etc in there (to be supported fully, grab 0.9.10-pre
module-init-tools).

Third one is Brian Gerst's patch to put the module structure in .mod.c
rather than using linker tricks, with a couple of changes (the module
name is converted correctly, and the section is called __module).

Very lightly tested: my test box doesn't stay up for very long under
recent kernels 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Tidy Up module.c
Author: Rusty Russell
Status: Experimental

D: This open-codes handle_section, which simply does relocations now
D: Also adds "find_sec" and uses it to find the various sections.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.62-bk1/kernel/module.c working-2.5.62-bk1-modclean/kernel/module.c
--- linux-2.5.62-bk1/kernel/module.c	2003-02-18 11:18:57.000000000 +1100
+++ working-2.5.62-bk1-modclean/kernel/module.c	2003-02-19 22:22:19.000000000 +1100
@@ -76,6 +76,22 @@ int init_module(void)
 }
 EXPORT_SYMBOL(init_module);
 
+/* Find a module section: 0 means not found. */
+static unsigned int find_sec(Elf_Ehdr *hdr,
+			     Elf_Shdr *sechdrs,
+			     const char *secstrings,
+			     const char *name)
+{
+	unsigned int i;
+
+	for (i = 1; i < hdr->e_shnum; i++)
+		/* Alloc bit cleared means "ignore it." */
+		if ((sechdrs[i].sh_flags & SHF_ALLOC)
+		    && strcmp(secstrings+sechdrs[i].sh_name, name) == 0)
+			return i;
+	return 0;
+}
+
 /* Find a symbol, return value and the symbol group */
 static unsigned long __find_symbol(const char *name,
 				   struct kernel_symbol_group **group,
@@ -875,45 +891,6 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
-/* Deal with the given section */
-static int handle_section(const char *name,
-			  Elf_Shdr *sechdrs,
-			  unsigned int strindex,
-			  unsigned int symindex,
-			  unsigned int i,
-			  struct module *mod)
-{
-	int ret;
-	const char *strtab = (char *)sechdrs[strindex].sh_addr;
-
-	switch (sechdrs[i].sh_type) {
-	case SHT_REL:
-		ret = apply_relocate(sechdrs, strtab, symindex, i, mod);
-		break;
-	case SHT_RELA:
-		ret = apply_relocate_add(sechdrs, strtab, symindex, i, mod);
-		break;
-	default:
-		DEBUGP("Ignoring section %u: %s\n", i,
-		       sechdrs[i].sh_type==SHT_NULL ? "NULL":
-		       sechdrs[i].sh_type==SHT_PROGBITS ? "PROGBITS":
-		       sechdrs[i].sh_type==SHT_SYMTAB ? "SYMTAB":
-		       sechdrs[i].sh_type==SHT_STRTAB ? "STRTAB":
-		       sechdrs[i].sh_type==SHT_RELA ? "RELA":
-		       sechdrs[i].sh_type==SHT_HASH ? "HASH":
-		       sechdrs[i].sh_type==SHT_DYNAMIC ? "DYNAMIC":
-		       sechdrs[i].sh_type==SHT_NOTE ? "NOTE":
-		       sechdrs[i].sh_type==SHT_NOBITS ? "NOBITS":
-		       sechdrs[i].sh_type==SHT_REL ? "REL":
-		       sechdrs[i].sh_type==SHT_SHLIB ? "SHLIB":
-		       sechdrs[i].sh_type==SHT_DYNSYM ? "DYNSYM":
-		       sechdrs[i].sh_type==SHT_NUM ? "NUM":
-		       "UNKNOWN");
-		ret = 0;
-	}
-	return ret;
-}
-
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
@@ -1103,93 +1080,16 @@ static struct module *load_module(void *
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
-	/* May not export symbols, or have setup params, so these may
-           not exist */
-	exportindex = setupindex = obsparmindex = gplindex = licenseindex 
-		= crcindex = gplcrcindex = versindex = 0;
-
-	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modindex = vmagindex = 0;
-
-	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		/* Mark all sections sh_addr with their address in the
 		   temporary image. */
 		sechdrs[i].sh_addr = (size_t)hdr + sechdrs[i].sh_offset;
 
+		/* Internal symbols and strings. */
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
-			/* Internal symbols */
-			DEBUGP("Symbol table in section %u\n", i);
 			symindex = i;
-			/* Strings */
 			strindex = sechdrs[i].sh_link;
-			DEBUGP("String table found in section %u\n", strindex);
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  ".gnu.linkonce.this_module") == 0) {
-			/* The module struct */
-			DEBUGP("Module in section %u\n", i);
-			modindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
-			   == 0) {
-			/* Exported symbols. */
-			DEBUGP("EXPORT table in section %u\n", i);
-			exportindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__ksymtab_gpl") == 0) {
-			/* Exported symbols. (GPL) */
-			DEBUGP("GPL symbols found in section %u\n", i);
-			gplindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__kcrctab")
-			   == 0) {
-			/* Exported symbols CRCs. */
-			DEBUGP("CRC table in section %u\n", i);
-			crcindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__kcrctab_gpl")
-			   == 0) {
-			/* Exported symbols CRCs. (GPL)*/
-			DEBUGP("CRC table in section %u\n", i);
-			gplcrcindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__param")
-			   == 0) {
-			/* Setup parameter info */
-			DEBUGP("Setup table found in section %u\n", i);
-			setupindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ex_table")
-			   == 0) {
-			/* Exception table */
-			DEBUGP("Exception table found in section %u\n", i);
-			exindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__obsparm")
-			   == 0) {
-			/* Obsolete MODULE_PARM() table */
-			DEBUGP("Obsolete param found in section %u\n", i);
-			obsparmindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,".init.license")
-			   == 0) {
-			/* MODULE_LICENSE() */
-			DEBUGP("Licence found in section %u\n", i);
-			licenseindex = i;
-			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__vermagic") == 0 &&
-			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
-			/* Version magic. */
-			DEBUGP("Version magic found in section %u\n", i);
-			vmagindex = i;
-			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__versions") == 0 &&
-			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
-			/* Module version info (both exported and needed) */
-			DEBUGP("Versions found in section %u\n", i);
-			versindex = i;
-			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		}
-#ifdef CONFIG_KALLSYMS
-		/* symbol and string tables for decoding later. */
-		if (sechdrs[i].sh_type == SHT_SYMTAB || i == strindex)
-			sechdrs[i].sh_flags |= SHF_ALLOC;
-#endif
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
 		if (strstr(secstrings+sechdrs[i].sh_name, ".exit"))
@@ -1197,6 +1097,14 @@ static struct module *load_module(void *
 #endif
 	}
 
+#ifdef CONFIG_KALLSYMS
+	/* Keep symbol and string tables for decoding later. */
+	sechdrs[symindex].sh_flags |= SHF_ALLOC;
+	sechdrs[strindex].sh_flags |= SHF_ALLOC;
+#endif
+
+	modindex = find_sec(hdr, sechdrs, secstrings,
+			    ".gnu.linkonce.this_module");
 	if (!modindex) {
 		printk(KERN_WARNING "No module found in object\n");
 		err = -ENOEXEC;
@@ -1204,6 +1112,18 @@ static struct module *load_module(void *
 	}
 	mod = (void *)sechdrs[modindex].sh_addr;
 
+	/* Optional sections */
+	exportindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab");
+	gplindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl");
+	crcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab");
+	gplcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl");
+	setupindex = find_sec(hdr, sechdrs, secstrings, "__param");
+	exindex = find_sec(hdr, sechdrs, secstrings, "__ex_table");
+	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
+	licenseindex = find_sec(hdr, sechdrs, secstrings, ".init.license");
+	vmagindex = find_sec(hdr, sechdrs, secstrings, "__vermagic");
+	versindex = find_sec(hdr, sechdrs, secstrings, "__versions");
+
 	/* Check module struct version now, before we try to use module. */
 	if (!check_modstruct_version(sechdrs, versindex, mod)) {
 		err = -ENOEXEC;
@@ -1336,10 +1256,14 @@ static struct module *load_module(void *
 		mod->extable.entry = (void *)sechdrs[exindex].sh_addr;
 	}
 
-	/* Now handle each section. */
+	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
-		err = handle_section(secstrings + sechdrs[i].sh_name,
-				     sechdrs, strindex, symindex, i, mod);
+		if (sechdrs[i].sh_type == SHT_REL)
+			err = apply_relocate(sechdrs, strtab, symindex, i,
+					     mod);
+		else if (sechdrs[i].sh_type == SHT_RELA)
+			err = apply_relocate_add(sechdrs, strtab, symindex, i,
+						 mod);
 		if (err < 0)
 			goto cleanup;
 	}

Name: Restore modinfo section
Author: Rusty Russell
Status: Tested on 2.5.62-bk2
Depends: Module/tidy.patch.gz

D: Restores .modinfo section, and uses it to store license and vermagic.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27442-linux-2.5.62-bk3/include/linux/module.h .27442-linux-2.5.62-bk3.updated/include/linux/module.h
--- .27442-linux-2.5.62-bk3/include/linux/module.h	2003-02-21 10:32:28.000000000 +1100
+++ .27442-linux-2.5.62-bk3.updated/include/linux/module.h	2003-02-21 18:53:23.000000000 +1100
@@ -21,10 +21,7 @@
 #include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
-#define MODULE_AUTHOR(name)
-#define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
-#define MODULE_PARM_DESC(var,desc)
 #define print_modules()
 
 /* v850 toolchain uses a `_' prefix for all user symbols */
@@ -57,12 +54,11 @@ search_extable(const struct exception_ta
 	       unsigned long value);
 
 #ifdef MODULE
-#define ___module_cat(a,b) a ## b
+#define ___module_cat(a,b) __mod_ ## a ## b
 #define __module_cat(a,b) ___module_cat(a,b)
-/* For userspace: you can also call me... */
-#define MODULE_ALIAS(alias)					\
-	static const char __module_cat(__alias_,__LINE__)[]	\
-		__attribute__((section(".modinfo"),unused)) = "alias=" alias
+#define MODULE_INFO(tag, info) \
+static const char __module_cat(tag,__LINE__)[]	\
+	__attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 extern const struct gtype##_id __mod_##gtype##_table		\
@@ -72,6 +68,18 @@ extern const struct gtype##_id __mod_##g
 #define MOD_INC_USE_COUNT _MOD_INC_USE_COUNT(THIS_MODULE)
 #define MOD_DEC_USE_COUNT __MOD_DEC_USE_COUNT(THIS_MODULE)
 
+#else  /* !MODULE */
+
+#define MODULE_GENERIC_TABLE(gtype,name)
+#define MODULE_INFO(tag, info)
+#define THIS_MODULE ((struct module *)0)
+#define MOD_INC_USE_COUNT	do { } while (0)
+#define MOD_DEC_USE_COUNT	do { } while (0)
+#endif
+
+/* For userspace: you can also call me... */
+#define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
+
 /*
  * The following license idents are currently accepted as indicating free
  * software modules
@@ -98,19 +106,17 @@ extern const struct gtype##_id __mod_##g
  * 2.	So the community can ignore bug reports including proprietary modules
  * 3.	So vendors can do likewise based on their own policies
  */
-#define MODULE_LICENSE(license)					\
-	static const char __module_license[]			\
-		__attribute__((section(".init.license"), unused)) = license
+#define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
 
-#else  /* !MODULE */
+/* Author, preferably of form NAME <email>[ and NAME <email>]* */
+#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
 
-#define MODULE_ALIAS(alias)
-#define MODULE_GENERIC_TABLE(gtype,name)
-#define THIS_MODULE ((struct module *)0)
-#define MOD_INC_USE_COUNT	do { } while (0)
-#define MOD_DEC_USE_COUNT	do { } while (0)
-#define MODULE_LICENSE(license)
-#endif
+/* What your module does. */
+#define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
+
+/* One for each parameter, describing how to use it. */
+#define MODULE_PARM_DESC(_parm, desc) \
+	MODULE_INFO(parm, #_parm ":" desc)
 
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27442-linux-2.5.62-bk3/kernel/module.c .27442-linux-2.5.62-bk3.updated/kernel/module.c
--- .27442-linux-2.5.62-bk3/kernel/module.c	2003-02-21 18:52:50.000000000 +1100
+++ .27442-linux-2.5.62-bk3.updated/kernel/module.c	2003-02-21 18:53:23.000000000 +1100
@@ -894,12 +894,12 @@ EXPORT_SYMBOL_GPL(__symbol_get);
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
 
@@ -1018,13 +1018,9 @@ static inline int license_is_gpl_compati
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
@@ -1035,6 +1031,40 @@ static void set_license(struct module *m
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
@@ -1043,9 +1073,9 @@ static struct module *load_module(void *
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
@@ -1079,6 +1109,7 @@ static struct module *load_module(void *
 	/* Convenience variables */
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+	sechdrs[0].sh_addr = 0;
 
 	for (i = 1; i < hdr->e_shnum; i++) {
 		/* Mark all sections sh_addr with their address in the
@@ -1089,6 +1120,7 @@ static struct module *load_module(void *
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
 			symindex = i;
 			strindex = sechdrs[i].sh_link;
+			strtab = (char *)hdr + sechdrs[strindex].sh_offset;
 		}
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
@@ -1097,12 +1129,6 @@ static struct module *load_module(void *
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
@@ -1120,9 +1146,16 @@ static struct module *load_module(void *
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
@@ -1130,14 +1163,15 @@ static struct module *load_module(void *
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
@@ -1217,11 +1251,11 @@ static struct module *load_module(void *
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
 
@@ -1259,8 +1293,7 @@ static struct module *load_module(void *
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type == SHT_REL)
-			err = apply_relocate(sechdrs, strtab, symindex, i,
-					     mod);
+			err = apply_relocate(sechdrs, strtab, symindex, i,mod);
 		else if (sechdrs[i].sh_type == SHT_RELA)
 			err = apply_relocate_add(sechdrs, strtab, symindex, i,
 						 mod);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27442-linux-2.5.62-bk3/scripts/modpost.c .27442-linux-2.5.62-bk3.updated/scripts/modpost.c
--- .27442-linux-2.5.62-bk3/scripts/modpost.c	2003-02-21 10:32:29.000000000 +1100
+++ .27442-linux-2.5.62-bk3.updated/scripts/modpost.c	2003-02-21 18:53:23.000000000 +1100
@@ -386,9 +386,7 @@ add_header(struct buffer *b)
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
-	buf_printf(b, "const char vermagic[]\n");
-	buf_printf(b, "__attribute__((section(\"__vermagic\"))) =\n");
-	buf_printf(b, "VERMAGIC_STRING;\n");
+	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 }
 
 /* Record CRCs for unresolved symbols */

Name: Move module structure out of header
Author: Brian Gerst <bgerst@quark.didntduck.org>
Status: Experimental
Depends: Module/modinfo.patch.gz

D: This patch moves the module structure to the generated .mod.c file, 
D: instead of compiling it into each object and relying on the linker to 
D: include it only once.
D:
D: Tweaked by Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27119-2.5.62-bk3-this_module.pre/arch/v850/Makefile .27119-2.5.62-bk3-this_module/arch/v850/Makefile
--- .27119-2.5.62-bk3-this_module.pre/arch/v850/Makefile	2003-02-11 14:26:00.000000000 +1100
+++ .27119-2.5.62-bk3-this_module/arch/v850/Makefile	2003-02-21 18:51:11.000000000 +1100
@@ -22,11 +22,6 @@ CFLAGS += -ffixed-r16 -mno-prolog-functi
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
-# This prevents the linker from consolidating the .gnu.linkonce.this_module
-# section into .text (which the v850 default linker script for -r does for
-# some reason)
-LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module
-
 LDFLAGS_BLOB := -b binary --oformat elf32-little
 OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27119-2.5.62-bk3-this_module.pre/include/linux/module.h .27119-2.5.62-bk3-this_module/include/linux/module.h
--- .27119-2.5.62-bk3-this_module.pre/include/linux/module.h	2003-02-21 18:51:10.000000000 +1100
+++ .27119-2.5.62-bk3-this_module/include/linux/module.h	2003-02-21 18:51:11.000000000 +1100
@@ -412,19 +412,6 @@ static inline const char *module_address
 
 #ifdef MODULE
 extern struct module __this_module;
-#ifdef KBUILD_MODNAME
-/* We make the linker do some of the work. */
-struct module __this_module
-__attribute__((section(".gnu.linkonce.this_module"))) = {
-	.name = __stringify(KBUILD_MODNAME),
-	.symbols = { .owner = &__this_module },
-	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
-	.init = init_module,
-#ifdef CONFIG_MODULE_UNLOAD
-	.exit = cleanup_module,
-#endif
-};
-#endif /* KBUILD_MODNAME */
 #endif /* MODULE */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27119-2.5.62-bk3-this_module.pre/kernel/module.c .27119-2.5.62-bk3-this_module/kernel/module.c
--- .27119-2.5.62-bk3-this_module.pre/kernel/module.c	2003-02-21 18:51:10.000000000 +1100
+++ .27119-2.5.62-bk3-this_module/kernel/module.c	2003-02-21 18:51:11.000000000 +1100
@@ -1146,8 +1129,7 @@ static struct module *load_module(void *
 #endif
 	}
 
-	modindex = find_sec(hdr, sechdrs, secstrings,
-			    ".gnu.linkonce.this_module");
+	modindex = find_sec(hdr, sechdrs, secstrings, "__module");
 	if (!modindex) {
 		printk(KERN_WARNING "No module found in object\n");
 		err = -ENOEXEC;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27119-2.5.62-bk3-this_module.pre/scripts/modpost.c .27119-2.5.62-bk3-this_module/scripts/modpost.c
--- .27119-2.5.62-bk3-this_module.pre/scripts/modpost.c	2003-02-21 18:51:10.000000000 +1100
+++ .27119-2.5.62-bk3-this_module/scripts/modpost.c	2003-02-21 18:51:11.000000000 +1100
@@ -10,7 +10,7 @@
  *
  * Usage: modpost vmlinux module1.o module2.o ...
  */
-
+#include <ctype.h>
 #include "modpost.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
@@ -289,6 +289,10 @@ handle_modversions(struct module *mod, s
 		/* undefined symbol */
 		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
 			break;
+
+		/* ignore __this_module */
+		if (!strcmp(symname, "__this_module"))
+			break;
 		
 		s = alloc_symbol(symname);
 		/* add to list */
@@ -377,16 +381,50 @@ buf_write(struct buffer *buf, const char
 	buf->pos += len;
 }
 
-/* Header for the generated file */
+static inline void filename2modname(char *modname, const char *filename)
+{
+	const char *afterslash;
+	unsigned int i;
+
+	afterslash = strrchr(filename, '/');
+	if (!afterslash)
+		afterslash = filename;
+	else
+		afterslash++;
+
+	/* Convert to underscores, stop at first . */
+	for (i = 0; afterslash[i] && afterslash[i] != '.'; i++) {
+		if (!isalnum(afterslash[i]))
+			modname[i] = '_';
+		else
+			modname[i] = afterslash[i];
+	}
+	modname[i] = '\0';
+}
 
+/* Header for the generated file */
 void
-add_header(struct buffer *b)
+add_header(struct buffer *b, struct module *mod)
 {
+	char modname[strlen(mod->name)+1];
+	filename2modname(modname, mod->name);
+
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
+	buf_printf(b, "\n");
+	buf_printf(b, "struct module __this_module\n");
+	buf_printf(b, "__attribute__((section(\"__module\"))) = {\n");
+	buf_printf(b, "	.name = \"%s\",\n", modname);
+	buf_printf(b, "	.symbols = { .owner = &__this_module },\n");
+	buf_printf(b, "	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },\n");
+	buf_printf(b, "	.init = init_module,\n");
+	buf_printf(b, "#ifdef CONFIG_MODULE_UNLOAD\n");
+	buf_printf(b, "	.exit = cleanup_module,\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "};\n");
 }
 
 /* Record CRCs for unresolved symbols */
@@ -528,7 +566,7 @@ main(int argc, char **argv)
 
 		buf.pos = 0;
 
-		add_header(&buf);
+		add_header(&buf, mod);
 		add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
