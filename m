Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTABCqg>; Wed, 1 Jan 2003 21:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTABCqg>; Wed, 1 Jan 2003 21:46:36 -0500
Received: from dp.samba.org ([66.70.73.150]:56759 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265470AbTABCq1>;
	Wed, 1 Jan 2003 21:46:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Modules 1/3: remove common section handling
Date: Thu, 02 Jan 2003 13:52:19 +1100
Message-Id: <20030102025449.8BAC12C093@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

As RTH pointed out, we use -fno-common for the kernel (otherwise we'd
have to sort out the small symbols anyway).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Remove common section allocation
Author: Richard Henderson
Status: Trivial

D: As the kernel is compiled with -fnocommon, the common section
D: allocation in the module code is pointless.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28107-linux-2.5.53/kernel/module.c .28107-linux-2.5.53.updated/kernel/module.c
--- .28107-linux-2.5.53/kernel/module.c	2002-12-26 15:41:06.000000000 +1100
+++ .28107-linux-2.5.53.updated/kernel/module.c	2002-12-27 19:04:09.000000000 +1100
@@ -833,38 +833,11 @@ static int handle_section(const char *na
 	return ret;
 }
 
-/* Figure out total size desired for the common vars */
-static unsigned long read_commons(void *start, Elf_Shdr *sechdr)
-{
-	unsigned long size, i, max_align;
-	Elf_Sym *sym;
-	
-	size = max_align = 0;
-
-	for (sym = start + sechdr->sh_offset, i = 0;
-	     i < sechdr->sh_size / sizeof(Elf_Sym);
-	     i++) {
-		if (sym[i].st_shndx == SHN_COMMON) {
-			/* Value encodes alignment. */
-			if (sym[i].st_value > max_align)
-				max_align = sym[i].st_value;
-			/* Pad to required alignment */
-			size = ALIGN(size, sym[i].st_value) + sym[i].st_size;
-		}
-	}
-
-	/* Now, add in max alignment requirement (with align
-	   attribute, this could be large), so we know we have space
-	   whatever the start alignment is */
-	return size + max_align;
-}
-
 /* Change all symbols so that sh_value encodes the pointer directly. */
-static void simplify_symbols(Elf_Shdr *sechdrs,
-			     unsigned int symindex,
-			     unsigned int strindex,
-			     void *common,
-			     struct module *mod)
+static int simplify_symbols(Elf_Shdr *sechdrs,
+			    unsigned int symindex,
+			    unsigned int strindex,
+			    struct module *mod)
 {
 	unsigned int i;
 	Elf_Sym *sym;
@@ -877,13 +850,10 @@ static void simplify_symbols(Elf_Shdr *s
 	     i++) {
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
-			/* Value encodes alignment. */
-			common = (void *)ALIGN((unsigned long)common,
-					       sym[i].st_value);
-			/* Change it to encode pointer */
-			sym[i].st_value = (unsigned long)common;
-			common += sym[i].st_size;
-			break;
+			/* We compiled with -fno-common.  These are not
+			   supposed to happen.  */
+			DEBUGP("Common symbol: %s\n", strtab + sym[i].st_name);
+			return -ENOEXEC;
 
 		case SHN_ABS:
 			/* Don't need to do anything */
@@ -924,15 +894,16 @@ static void simplify_symbols(Elf_Shdr *s
 				sym[i].st_value = (unsigned long)mod;
 		}
 	}
+
+	return 0;
 }
 
 /* Get the total allocation size of the init and non-init sections */
 static struct sizes get_sizes(const Elf_Ehdr *hdr,
 			      const Elf_Shdr *sechdrs,
-			      const char *secstrings,
-			      unsigned long common_length)
+			      const char *secstrings)
 {
-	struct sizes ret = { 0, common_length };
+	struct sizes ret = { 0, 0 };
 	unsigned i;
 
 	/* Everything marked ALLOC (this includes the exported
@@ -967,7 +938,6 @@ static struct module *load_module(void *
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
 		modnameindex, obsparmindex;
 	long arglen;
-	unsigned long common_length;
 	struct sizes sizes, used;
 	struct module *mod;
 	long err = 0;
@@ -1091,9 +1061,8 @@ static struct module *load_module(void *
 	mod->state = MODULE_STATE_COMING;
 	module_unload_init(mod);
 
-	/* How much space will we need?  (Common area in first) */
-	common_length = read_commons(hdr, &sechdrs[symindex]);
-	sizes = get_sizes(hdr, sechdrs, secstrings, common_length);
+	/* How much space will we need? */
+	sizes = get_sizes(hdr, sechdrs, secstrings);
 
 	/* Set these up, and allow archs to manipulate them. */
 	mod->core_size = sizes.core_size;
@@ -1129,7 +1098,7 @@ static struct module *load_module(void *
 
 	/* Transfer each section which requires ALLOC, and set sh_offset
 	   fields to absolute addresses. */
-	used.core_size = common_length;
+	used.core_size = 0;
 	used.init_size = 0;
 	for (i = 1; i < hdr->e_shnum; i++) {
 		if (sechdrs[i].sh_flags & SHF_ALLOC) {
@@ -1147,7 +1116,9 @@ static struct module *load_module(void *
 		BUG();
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	simplify_symbols(sechdrs, symindex, strindex, mod->module_core, mod);
+	err = simplify_symbols(sechdrs, symindex, strindex, mod);
+	if (err < 0)
+		goto cleanup;
 
 	/* Set up EXPORTed symbols */
 	if (exportindex) {
