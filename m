Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbTDBRab>; Wed, 2 Apr 2003 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbTDBRab>; Wed, 2 Apr 2003 12:30:31 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:8656 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263073AbTDBRa3>; Wed, 2 Apr 2003 12:30:29 -0500
Date: Wed, 2 Apr 2003 11:41:41 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Brian Gerst <bgerst@didntduck.org>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module.c broken in latest snapshot
In-Reply-To: <3E8B0648.1010800@didntduck.org>
Message-ID: <Pine.LNX.4.44.0304021138570.8411-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Brian Gerst wrote:

> kernel/module.c: In function `check_modstruct_version':
> kernel/module.c:845: warning: passing arg 2 of `__find_symbol' from 
> incompatible pointer type
> kernel/module.c:845: warning: passing arg 3 of `__find_symbol' from 
> incompatible pointer type
> kernel/module.c:847: warning: passing arg 5 of `check_version' from 
> incompatible pointer type
> kernel/module.c:847: too many arguments to function `check_version'
> kernel/module.c: In function `load_module':
> kernel/module.c:1276: structure has no member named `num_syms'

This patch should fix this problem and another, less obvious, one, which 
made symbols exported by modules not work.

--Kai

===== include/linux/module.h 1.57 vs edited =====
--- 1.57/include/linux/module.h	Mon Mar 24 19:34:42 2003
+++ edited/include/linux/module.h	Wed Apr  2 10:37:00 2003
@@ -183,7 +183,7 @@
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
-	unsigned int num_ksyms;
+	unsigned int num_syms;
 	const unsigned long *crcs;
 
 	/* GPL-only exported symbols. */
@@ -233,7 +233,7 @@
 #ifdef CONFIG_KALLSYMS
 	/* We keep the symbol and string tables for kallsyms. */
 	Elf_Sym *symtab;
-	unsigned long num_syms;
+	unsigned long num_symtab;
 	char *strtab;
 #endif
 
===== kernel/module.c 1.72 vs edited =====
--- 1.72/kernel/module.c	Mon Mar 24 19:31:40 2003
+++ edited/kernel/module.c	Wed Apr  2 10:39:50 2003
@@ -156,7 +156,7 @@
 	/* Now try modules. */ 
 	list_for_each_entry(mod, &modules, list) {
 		*owner = mod;
-		for (i = 0; i < mod->num_ksyms; i++)
+		for (i = 0; i < mod->num_syms; i++)
 			if (strcmp(mod->syms[i].name, name) == 0) {
 				*crc = symversion(mod->crcs, i);
 				return mod->syms[i].value;
@@ -839,12 +839,13 @@
 					  unsigned int versindex,
 					  struct module *mod)
 {
-	unsigned int i;
-	struct kernel_symbol_group *ksg;
+	const unsigned long *crc;
+	struct module *owner;
 
-	if (!__find_symbol("struct_module", &ksg, &i, 1))
+	if (!__find_symbol("struct_module", &owner, &crc, 1))
 		BUG();
-	return check_version(sechdrs, versindex, "struct_module", mod, ksg, i);
+	return check_version(sechdrs, versindex, "struct_module", mod,
+			     crc);
 }
 
 /* First part is kernel version, which we ignore. */
@@ -1283,7 +1284,8 @@
 		mod->gpl_crcs = (void *)sechdrs[gplcrcindex].sh_addr;
 
 #ifdef CONFIG_MODVERSIONS
-	if ((mod->num_ksyms&&!crcindex) || (mod->num_gpl_syms&&!gplcrcindex)) {
+	if ((mod->num_syms && !crcindex) || 
+	    (mod->num_gpl_syms && !gplcrcindex)) {
 		printk(KERN_WARNING "%s: No versions for exported symbols."
 		       " Tainting kernel.\n", mod->name);
 		tainted |= TAINT_FORCED_MODULE;
@@ -1309,7 +1311,7 @@
 
 #ifdef CONFIG_KALLSYMS
 	mod->symtab = (void *)sechdrs[symindex].sh_addr;
-	mod->num_syms = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
+	mod->num_symtab = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 	mod->strtab = (void *)sechdrs[strindex].sh_addr;
 #endif
 	err = module_finalize(hdr, sechdrs, mod);
@@ -1452,7 +1454,7 @@
 
 	/* Scan for closest preceeding symbol, and next symbol. (ELF
            starts real symbols at 1). */
-	for (i = 1; i < mod->num_syms; i++) {
+	for (i = 1; i < mod->num_symtab; i++) {
 		if (mod->symtab[i].st_shndx == SHN_UNDEF)
 			continue;
 

