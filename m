Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbTABCvn>; Wed, 1 Jan 2003 21:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbTABCvm>; Wed, 1 Jan 2003 21:51:42 -0500
Received: from dp.samba.org ([66.70.73.150]:58551 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265628AbTABCu4>;
	Wed, 1 Jan 2003 21:50:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, ak@suse.de,
       davem@redhat.com, paulus@samba.org, rmk@arm.linux.org.uk
Subject: [PATCH] Modules 2/3: Use sh_addr instead of sh_offset
Date: Thu, 02 Jan 2003 13:54:57 +1100
Message-Id: <20030102025923.672FB2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Trivial substitution.  Richard points out that we should be using
sh_addr to hold the address, rather than overloading sh_offset to be a
pointer.  Fixes archs appropriately.

Name: Use sh_addr instead of overloading sh_offset.
From: Richard Henderson <rth@twiddle.net>
Status: Tested on 2.5.53
Depends: Module/nocommon.patch.gz

D: The original patch used to overload sh_offset to a pointer to the
D: location of the section.  This uses sh_addr, which is more correct
D: and less surprising.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/arm/kernel/module.c .27574-linux-2.5-bk.updated/arch/arm/kernel/module.c
--- .27574-linux-2.5-bk/arch/arm/kernel/module.c	2002-11-25 08:43:47.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/arm/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -88,7 +88,7 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
 	Elf32_Shdr *symsec = sechdrs + symindex;
 	Elf32_Shdr *relsec = sechdrs + relindex;
 	Elf32_Shdr *dstsec = sechdrs + relsec->sh_info;
-	Elf32_Rel *rel = (void *)relsec->sh_offset;
+	Elf32_Rel *rel = (void *)relsec->sh_addr;
 	unsigned int i;
 
 	for (i = 0; i < relsec->sh_size / sizeof(Elf32_Rel); i++, rel++) {
@@ -103,7 +103,7 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
 			return -ENOEXEC;
 		}
 
-		sym = ((Elf32_Sym *)symsec->sh_offset) + offset;
+		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: unknown symbol %s\n",
 				module->name, strtab + sym->st_name);
@@ -118,7 +118,7 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
 			return -ENOEXEC;
 		}
 
-		loc = dstsec->sh_offset + rel->r_offset;
+		loc = dstsec->sh_addr + rel->r_offset;
 
 		switch (ELF32_R_TYPE(rel->r_info)) {
 		case R_ARM_ABS32:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/i386/kernel/module.c .27574-linux-2.5-bk.updated/arch/i386/kernel/module.c
--- .27574-linux-2.5-bk/arch/i386/kernel/module.c	2002-12-23 11:17:07.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/i386/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -68,7 +68,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 		   struct module *me)
 {
 	unsigned int i;
-	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Rel *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf32_Sym *sym;
 	uint32_t *location;
 
@@ -76,10 +76,10 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		/* This is the symbol it is referring to */
-		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rel[i].r_info);
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/ppc/kernel/module.c .27574-linux-2.5-bk.updated/arch/ppc/kernel/module.c
--- .27574-linux-2.5-bk/arch/ppc/kernel/module.c	2002-12-10 15:56:47.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/ppc/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -176,7 +176,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 		       struct module *module)
 {
 	unsigned int i;
-	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_addr;
 	Elf32_Sym *sym;
 	uint32_t *location;
 	uint32_t value;
@@ -185,10 +185,10 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
 		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rela[i].r_offset;
 		/* This is the symbol it is referring to */
-		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rela[i].r_info);
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/s390/kernel/module.c .27574-linux-2.5-bk.updated/arch/s390/kernel/module.c
--- .27574-linux-2.5-bk/arch/s390/kernel/module.c	2002-11-25 08:43:48.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/s390/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -78,7 +78,7 @@ int apply_relocate(Elf_Shdr *sechdrs,
 		   struct module *me)
 {
 	unsigned int i;
-	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_offset;
+	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_addr;
 	ElfW(Sym) *sym;
 	ElfW(Addr) *location;
 
@@ -86,10 +86,10 @@ int apply_relocate(Elf_Shdr *sechdrs,
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		/* This is the symbol it is referring to */
-		sym = (ElfW(Sym) *)sechdrs[symindex].sh_offset
+		sym = (ElfW(Sym) *)sechdrs[symindex].sh_addr
 			+ ELFW(R_SYM)(rel[i].r_info);
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/s390x/kernel/module.c .27574-linux-2.5-bk.updated/arch/s390x/kernel/module.c
--- .27574-linux-2.5-bk/arch/s390x/kernel/module.c	2002-11-25 08:43:49.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/s390x/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -78,7 +78,7 @@ int apply_relocate(Elf_Shdr *sechdrs,
 		   struct module *me)
 {
 	unsigned int i;
-	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_offset;
+	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_addr;
 	ElfW(Sym) *sym;
 	ElfW(Addr) *location;
 
@@ -86,10 +86,10 @@ int apply_relocate(Elf_Shdr *sechdrs,
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		/* This is the symbol it is referring to */
-		sym = (ElfW(Sym) *)sechdrs[symindex].sh_offset
+		sym = (ElfW(Sym) *)sechdrs[symindex].sh_addr
 			+ ELFW(R_SYM)(rel[i].r_info);
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/sparc/kernel/module.c .27574-linux-2.5-bk.updated/arch/sparc/kernel/module.c
--- .27574-linux-2.5-bk/arch/sparc/kernel/module.c	2002-11-25 08:43:49.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/sparc/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -71,7 +71,7 @@ int apply_relocate_add(Elf32_Shdr *sechd
 		       struct module *me)
 {
 	unsigned int i;
-	Elf32_Rela *rel = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf32_Sym *sym;
 	u8 *location;
 	u32 *loc32;
@@ -80,11 +80,11 @@ int apply_relocate_add(Elf32_Shdr *sechd
 		Elf32_Addr v;
 
 		/* This is where to make the change */
-		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		loc32 = (u32 *) location;
 		/* This is the symbol it is referring to */
-		sym = (Elf32_Sym *)sechdrs[symindex].sh_offset
+		sym = (Elf32_Sym *)sechdrs[symindex].sh_addr
 			+ ELF32_R_SYM(rel[i].r_info);
 		if (!(v = sym->st_value)) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/sparc64/kernel/module.c .27574-linux-2.5-bk.updated/arch/sparc64/kernel/module.c
--- .27574-linux-2.5-bk/arch/sparc64/kernel/module.c	2002-11-25 08:43:49.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/sparc64/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -178,7 +178,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		       struct module *me)
 {
 	unsigned int i;
-	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_offset;
+	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	u8 *location;
 	u32 *loc32;
@@ -187,14 +187,14 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		Elf64_Addr v;
 
 		/* This is where to make the change */
-		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 		loc32 = (u32 *) location;
 
 		BUG_ON(((u64)location >> (u64)32) != (u64)0);
 
 		/* This is the symbol it is referring to */
-		sym = (Elf64_Sym *)sechdrs[symindex].sh_offset
+		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rel[i].r_info);
 		if (!(v = sym->st_value)) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/v850/kernel/module.c .27574-linux-2.5-bk.updated/arch/v850/kernel/module.c
--- .27574-linux-2.5-bk/arch/v850/kernel/module.c	2002-11-28 10:20:03.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/v850/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -160,7 +160,7 @@ int apply_relocate_add (Elf32_Shdr *sech
 			struct module *mod)
 {
 	unsigned int i;
-	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_offset;
+	Elf32_Rela *rela = (void *)sechdrs[relsec].sh_addr;
 
 	DEBUGP ("Applying relocate section %u to %u\n", relsec,
 		sechdrs[relsec].sh_info);
@@ -168,11 +168,11 @@ int apply_relocate_add (Elf32_Shdr *sech
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof (*rela); i++) {
 		/* This is where to make the change */
 		uint32_t *loc
-			= ((void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+			= ((void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			   + rela[i].r_offset);
 		/* This is the symbol it is referring to */
 		Elf32_Sym *sym
-			= ((Elf32_Sym *)sechdrs[symindex].sh_offset
+			= ((Elf32_Sym *)sechdrs[symindex].sh_addr
 			   + ELF32_R_SYM (rela[i].r_info));
 		uint32_t val = sym->st_value;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/arch/x86_64/kernel/module.c .27574-linux-2.5-bk.updated/arch/x86_64/kernel/module.c
--- .27574-linux-2.5-bk/arch/x86_64/kernel/module.c	2002-12-26 15:41:04.000000000 +1100
+++ .27574-linux-2.5-bk.updated/arch/x86_64/kernel/module.c	2002-12-29 22:07:55.000000000 +1100
@@ -49,7 +49,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 		   struct module *me)
 {
 	unsigned int i;
-	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_offset;
+	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	void *loc;
 	u64 val; 
@@ -58,11 +58,11 @@ int apply_relocate_add(Elf64_Shdr *sechd
 	       sechdrs[relsec].sh_info);
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
-		loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_offset
+		loc = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
 
 		/* This is the symbol it is referring to */
-		sym = (Elf64_Sym *)sechdrs[symindex].sh_offset
+		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rel[i].r_info);
 		if (!sym->st_value) {
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27574-linux-2.5-bk/kernel/module.c .27574-linux-2.5-bk.updated/kernel/module.c
--- .27574-linux-2.5-bk/kernel/module.c	2002-12-29 22:07:29.000000000 +1100
+++ .27574-linux-2.5-bk.updated/kernel/module.c	2002-12-29 22:11:18.000000000 +1100
@@ -94,7 +94,7 @@ static unsigned long find_local_symbol(E
 				       const char *name)
 {
 	unsigned int i;
-	Elf_Sym *sym = (void *)sechdrs[symindex].sh_offset;
+	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
 
 	/* Search (defined) internal symbols first. */
 	for (i = 1; i < sechdrs[symindex].sh_size/sizeof(*sym); i++) {
@@ -793,7 +793,7 @@ static int handle_section(const char *na
 			  struct module *mod)
 {
 	int ret;
-	const char *strtab = (char *)sechdrs[strindex].sh_offset;
+	const char *strtab = (char *)sechdrs[strindex].sh_addr;
 
 	switch (sechdrs[i].sh_type) {
 	case SHT_REL:
@@ -835,7 +835,7 @@ static int simplify_symbols(Elf_Shdr *se
 	/* First simplify defined symbols, so if they become the
            "answer" to undefined symbols, copying their st_value us
            correct. */
-	for (sym = (void *)sechdrs[symindex].sh_offset, i = 0;
+	for (sym = (void *)sechdrs[symindex].sh_addr, i = 0;
 	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 	     i++) {
 		switch (sym[i].st_shndx) {
@@ -857,20 +857,20 @@ static int simplify_symbols(Elf_Shdr *se
 		default:
 			sym[i].st_value 
 				= (unsigned long)
-				(sechdrs[sym[i].st_shndx].sh_offset
+				(sechdrs[sym[i].st_shndx].sh_addr
 				 + sym[i].st_value);
 		}
 	}
 
 	/* Now try to resolve undefined symbols */
-	for (sym = (void *)sechdrs[symindex].sh_offset, i = 0;
+	for (sym = (void *)sechdrs[symindex].sh_addr, i = 0;
 	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
 	     i++) {
 		if (sym[i].st_shndx == SHN_UNDEF) {
 			/* Look for symbol */
 			struct kernel_symbol_group *ksg = NULL;
 			const char *strtab 
-				= (char *)sechdrs[strindex].sh_offset;
+				= (char *)sechdrs[strindex].sh_addr;
 
 			sym[i].st_value
 				= find_symbol_internal(sechdrs,
@@ -967,6 +967,10 @@ static struct module *load_module(void *
 
 	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
+		/* Mark all sections sh_addr with their address in the
+		   temporary image. */
+		sechdrs[i].sh_addr = (size_t)hdr + sechdrs[i].sh_offset;
+
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
 			/* Internal symbols */
 			DEBUGP("Symbol table in section %u\n", i);
@@ -1019,7 +1023,7 @@ static struct module *load_module(void *
 		err = -ENOEXEC;
 		goto free_hdr;
 	}
-	mod = (void *)hdr + sechdrs[modindex].sh_offset;
+	mod = (void *)sechdrs[modindex].sh_addr;
 
 	/* Now copy in args */
 	err = strlen_user(uargs);
@@ -1079,7 +1083,7 @@ static struct module *load_module(void *
 	memset(ptr, 0, mod->init_size);
 	mod->module_init = ptr;
 
-	/* Transfer each section which requires ALLOC, and set sh_offset
+	/* Transfer each section which requires ALLOC, and set sh_addr
 	   fields to absolute addresses. */
 	used.core_size = 0;
 	used.init_size = 0;
@@ -1089,12 +1093,10 @@ static struct module *load_module(void *
 					   hdr, &sechdrs[i], mod, &used);
 			if (IS_ERR(ptr))
 				goto cleanup;
-			sechdrs[i].sh_offset = (unsigned long)ptr;
+			sechdrs[i].sh_addr = (unsigned long)ptr;
 			/* Have we just copied __this_module across? */ 
 			if (i == modindex)
 				mod = ptr;
-		} else {
-			sechdrs[i].sh_offset += (unsigned long)hdr;
 		}
 	}
 	/* Don't use more than we allocated! */
@@ -1113,7 +1115,7 @@ static struct module *load_module(void *
 	if (exportindex) {
 		mod->symbols.num_syms = (sechdrs[exportindex].sh_size
 					/ sizeof(*mod->symbols.syms));
-		mod->symbols.syms = (void *)sechdrs[exportindex].sh_offset;
+		mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
 	}
 
 	/* Set up exception table */
@@ -1122,7 +1124,7 @@ static struct module *load_module(void *
 		mod->extable.num_entries = (sechdrs[exindex].sh_size
 					    / sizeof(struct
 						     exception_table_entry));
-		mod->extable.entry = (void *)sechdrs[exindex].sh_offset;
+		mod->extable.entry = (void *)sechdrs[exindex].sh_addr;
 	}
 
 	/* Now handle each section. */
@@ -1134,9 +1136,9 @@ static struct module *load_module(void *
 	}
 
 #ifdef CONFIG_KALLSYMS
-	mod->symtab = (void *)sechdrs[symindex].sh_offset;
+	mod->symtab = (void *)sechdrs[symindex].sh_addr;
 	mod->num_syms = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	mod->strtab = (void *)sechdrs[strindex].sh_offset;
+	mod->strtab = (void *)sechdrs[strindex].sh_addr;
 #endif
 	err = module_finalize(hdr, sechdrs, mod);
 	if (err < 0)
@@ -1146,16 +1148,16 @@ static struct module *load_module(void *
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
 				      (struct obsolete_modparm *)
-				      sechdrs[obsparmindex].sh_offset,
+				      sechdrs[obsparmindex].sh_addr,
 				      sechdrs[obsparmindex].sh_size
 				      / sizeof(struct obsolete_modparm),
 				      sechdrs, symindex,
-				      (char *)sechdrs[strindex].sh_offset);
+				      (char *)sechdrs[strindex].sh_addr);
 	} else {
 		/* Size of section 0 is 0, so this works well if no params */
 		err = parse_args(mod->name, mod->args,
 				 (struct kernel_param *)
-				 sechdrs[setupindex].sh_offset,
+				 sechdrs[setupindex].sh_addr,
 				 sechdrs[setupindex].sh_size
 				 / sizeof(struct kernel_param),
 				 NULL);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
