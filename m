Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268532AbTBZBTb>; Tue, 25 Feb 2003 20:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268562AbTBZBTb>; Tue, 25 Feb 2003 20:19:31 -0500
Received: from dp.samba.org ([66.70.73.150]:43952 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268532AbTBZBTW>;
	Tue, 25 Feb 2003 20:19:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Modules code tidy up
Date: Wed, 26 Feb 2003 12:28:50 +1100
Message-Id: <20030226012938.D8DD12C269@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Now we search for 11 different sections by name, the if/else was
getting unwieldy.  Also, handle_section just does relocs, so it's a
bit of a misnomer, and it's best simply moved into the main code.

Thanks,
Rusty.

Name: Tidy Up module.c
Author: Rusty Russell
Status: Tested on 2.5.63

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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
