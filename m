Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTBXSPH>; Mon, 24 Feb 2003 13:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbTBXSPA>; Mon, 24 Feb 2003 13:15:00 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:28907 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S267137AbTBXSKM> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:12 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (12/13): kernel module loader.
Date: Mon, 24 Feb 2003 19:14:40 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241914.40582.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing/fix existing s390 relocations in the kernel module loader.

diff -urN linux-2.5.62/arch/s390/kernel/module.c linux-2.5.62-s390/arch/s390/kernel/module.c
--- linux-2.5.62/arch/s390/kernel/module.c	Mon Feb 17 23:56:54 2003
+++ linux-2.5.62-s390/arch/s390/kernel/module.c	Mon Feb 24 18:24:54 2003
@@ -2,7 +2,8 @@
  *  arch/s390/kernel/module.c - Kernel module help for s390.
  *
  *  S390 version
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 2002, 2003 IBM Deutschland Entwicklung GmbH,
+ *			       IBM Corporation
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
@@ -36,6 +37,9 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+#define GOT_ENTRY_SIZE 4
+#define PLT_ENTRY_SIZE 12
+
 void *module_alloc(unsigned long size)
 {
 	if (size == 0)
@@ -51,109 +55,296 @@
            table entries. */
 }
 
-int module_frob_arch_sections(Elf_Ehdr *hdr,
-			      Elf_Shdr *sechdrs,
-			      char *secstrings,
-			      struct module *mod)
+static inline void
+check_rela(Elf32_Rela *rela, struct module *me)
 {
-	// FIXME: add space needed for GOT/PLT
-	return 0;
+	struct mod_arch_syminfo *info;
+
+	info = me->arch.syminfo + ELF32_R_SYM (rela->r_info);
+	switch (ELF32_R_TYPE (rela->r_info)) {
+	case R_390_GOT12:	/* 12 bit GOT offset.  */
+	case R_390_GOT16:	/* 16 bit GOT offset.  */
+	case R_390_GOT32:	/* 32 bit GOT offset.  */
+	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
+	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
+	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
+	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
+		if (info->got_offset == -1UL) {
+			info->got_offset = me->arch.got_size;
+			me->arch.got_size += GOT_ENTRY_SIZE;
+		}
+		break;
+	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+	case R_390_PLTOFF16:	/* 16 bit offset from GOT to PLT. */
+	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
+		if (info->plt_offset == -1UL) {
+			info->plt_offset = me->arch.plt_size;
+			me->arch.plt_size += PLT_ENTRY_SIZE;
+		}
+		break;
+	case R_390_COPY:
+	case R_390_GLOB_DAT:
+	case R_390_JMP_SLOT:
+	case R_390_RELATIVE:
+		/* Only needed if we want to support loading of 
+		   modules linked with -shared. */
+		break;
+	}
 }
 
-int apply_relocate(Elf_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
-		   struct module *me)
+/*
+ * Account for GOT and PLT relocations. We can't add sections for
+ * got and plt but we can increase the core module size.
+ */
+int
+module_frob_arch_sections(Elf32_Ehdr *hdr, Elf32_Shdr *sechdrs,
+			  char *secstrings, struct module *me)
 {
-	unsigned int i;
-	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_addr;
-	ElfW(Sym) *sym;
-	ElfW(Addr) *location;
-
-	DEBUGP("Applying relocate section %u to %u\n", relsec,
-	       sechdrs[relsec].sh_info);
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rel[i].r_offset;
-		/* This is the symbol it is referring to.  Note that all
-		   undefined symbols have been resolved.  */
-		sym = (ElfW(Sym) *)sechdrs[symindex].sh_addr
-			+ ELFW(R_SYM)(rel[i].r_info);
-
-		switch (ELF_R_TYPE(rel[i].r_info)) {
-		case R_390_8:		/* Direct 8 bit.   */
-			*(u8*) location += sym->st_value;
-			break;
-		case R_390_12:		/* Direct 12 bit.  */
-			*(u16*) location = (*(u16*) location & 0xf000) | 
-				(sym->st_value & 0xfff);
-			break;
-		case R_390_16:		/* Direct 16 bit.  */
-			*(u16*) location += sym->st_value;
-			break;
-		case R_390_32:		/* Direct 32 bit.  */
-			*(u32*) location += sym->st_value;
-			break;
-		case R_390_PC16:	/* PC relative 16 bit.  */
-			*(u16*) location += sym->st_value
-					    - (unsigned long )location;
-
-		case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
-			*(u16*) location += (sym->st_value
-					     - (unsigned long )location) >> 1;
-		case R_390_PC32:	/* PC relative 32 bit.  */
-			*(u32*) location += sym->st_value
-					    - (unsigned long )location;
-			break;
-		case R_390_GOT12:	/* 12 bit GOT offset.  */
-		case R_390_GOT16:	/* 16 bit GOT offset.  */
-		case R_390_GOT32:	/* 32 bit GOT offset.  */
-			// FIXME: TODO
-			break;
-
-		case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
-		case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
-			// FIXME: TODO
-			break;
-		case R_390_GLOB_DAT:	/* Create GOT entry.  */
-		case R_390_JMP_SLOT:	/* Create PLT entry.  */
-			*location = sym->st_value;
-			break;
-		case R_390_RELATIVE:	/* Adjust by program base.  */
-			// FIXME: TODO
-			break;
-		case R_390_GOTOFF:	/* 32 bit offset to GOT.  */
-			// FIXME: TODO
-			break;
-		case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
-			// FIXME: TODO
+	Elf32_Shdr *symtab;
+	Elf32_Sym *symbols;
+	Elf32_Rela *rela;
+	char *strings;
+	int nrela, i, j;
+
+	/* Find symbol table and string table. */
+	symtab = 0;
+	for (i = 0; i < hdr->e_shnum; i++)
+		switch (sechdrs[i].sh_type) {
+		case SHT_SYMTAB:
+			symtab = sechdrs + i;
 			break;
-		default:
-			printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
-			       me->name,
-			       (unsigned long)ELF_R_TYPE(rel[i].r_info));
-			return -ENOEXEC;
 		}
+	if (!symtab) {
+		printk(KERN_ERR "module %s: no symbol table\n", me->name);
+		return -ENOEXEC;
 	}
+
+	/* Allocate one syminfo structure per symbol. */
+	me->arch.nsyms = symtab->sh_size / sizeof(Elf32_Sym);
+	me->arch.syminfo = kmalloc(me->arch.nsyms *
+				   sizeof(struct mod_arch_syminfo),
+				   GFP_KERNEL);
+	if (!me->arch.syminfo)
+		return -ENOMEM;
+	symbols = (void *) hdr + symtab->sh_offset;
+	strings = (void *) hdr + sechdrs[symtab->sh_link].sh_offset;
+	for (i = 0; i < me->arch.nsyms; i++) {
+		if (symbols[i].st_shndx == SHN_UNDEF &&
+		    strcmp(strings + symbols[i].st_name,
+			   "_GLOBAL_OFFSET_TABLE_") == 0)
+			/* "Define" it as absolute. */
+			symbols[i].st_shndx = SHN_ABS;
+		me->arch.syminfo[i].got_offset = -1UL;
+		me->arch.syminfo[i].plt_offset = -1UL;
+		me->arch.syminfo[i].got_initialized = 0;
+		me->arch.syminfo[i].plt_initialized = 0;
+	}
+
+	/* Search for got/plt relocations. */
+	me->arch.got_size = me->arch.plt_size = 0;
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_RELA)
+			continue;
+		nrela = sechdrs[i].sh_size / sizeof(Elf32_Rela);
+		rela = (void *) hdr + sechdrs[i].sh_offset;
+		for (j = 0; j < nrela; j++)
+			check_rela(rela + j, me);
+	}
+
+	/* Increase core size by size of got & plt and set start
+	   offsets for got and plt. */
+	me->core_size = ALIGN(me->core_size, 4);
+	me->arch.got_offset = me->core_size;
+	me->core_size += me->arch.got_size;
+	me->arch.plt_offset = me->core_size;
+	me->core_size += me->arch.plt_size;
 	return 0;
 }
 
-int apply_relocate_add(Elf32_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *me)
+int
+apply_relocate(Elf_Shdr *sechdrs, const char *strtab, unsigned int symindex,
+	       unsigned int relsec, struct module *me)
 {
-	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n",
+	printk(KERN_ERR "module %s: RELOCATION unsupported\n",
 	       me->name);
 	return -ENOEXEC;
 }
 
+static inline int
+apply_rela(Elf32_Rela *rela, Elf32_Addr base, Elf32_Sym *symtab, 
+	   struct module *me)
+{
+	struct mod_arch_syminfo *info;
+	Elf32_Addr loc, val;
+	int r_type, r_sym;
+
+	/* This is where to make the change */
+	loc = base + rela->r_offset;
+	/* This is the symbol it is referring to.  Note that all
+	   undefined symbols have been resolved.  */
+	r_sym = ELF32_R_SYM(rela->r_info);
+	r_type = ELF32_R_TYPE(rela->r_info);
+	info = me->arch.syminfo + r_sym;
+	val = symtab[r_sym].st_value;
+
+	switch (r_type) {
+	case R_390_8:		/* Direct 8 bit.   */
+	case R_390_12:		/* Direct 12 bit.  */
+	case R_390_16:		/* Direct 16 bit.  */
+	case R_390_32:		/* Direct 32 bit.  */
+		val += rela->r_addend;
+		if (r_type == R_390_8)
+			*(unsigned char *) loc = val;
+		else if (r_type == R_390_12)
+			*(unsigned short *) loc = (val & 0xfff) |
+				(*(unsigned short *) loc & 0xf000);
+		else if (r_type == R_390_16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_32)
+			*(unsigned int *) loc = val;
+		break;
+	case R_390_PC16:	/* PC relative 16 bit.  */
+	case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
+	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
+	case R_390_PC32:	/* PC relative 32 bit.  */
+		val += rela->r_addend - loc;
+		if (r_type == R_390_PC16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_PC16DBL)
+			*(unsigned short *) loc = val >> 1;
+		else if (r_type == R_390_PC32DBL)
+			*(unsigned int *) loc = val >> 1;
+		else if (r_type == R_390_PC32)
+			*(unsigned int *) loc = val;
+		break;
+	case R_390_GOT12:	/* 12 bit GOT offset.  */
+	case R_390_GOT16:	/* 16 bit GOT offset.  */
+	case R_390_GOT32:	/* 32 bit GOT offset.  */
+	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
+	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
+	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
+	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
+		if (info->got_initialized == 0) {
+			Elf32_Addr *gotent;
+			gotent = me->module_core + me->arch.got_offset +
+				info->got_offset;
+			*gotent = val;
+			info->got_initialized = 1;
+		}
+		val = info->got_offset + rela->r_addend;
+		if (r_type == R_390_GOT12 ||
+		    r_type == R_390_GOTPLT12)
+			*(unsigned short *) loc = (val & 0xfff) |
+				(*(unsigned short *) loc & 0xf000);
+		else if (r_type == R_390_GOT16 ||
+			 r_type == R_390_GOTPLT16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_GOT32 ||
+			 r_type == R_390_GOTPLT32)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_GOTENT ||
+			 r_type == R_390_GOTPLTENT)
+			*(unsigned int *) loc = val >> 1;
+		break;
+	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+	case R_390_PLTOFF16:	/* 16 bit offset from GOT to PLT. */
+	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
+		if (info->plt_initialized == 0) {
+			unsigned int *ip;
+			ip = me->module_core + me->arch.plt_offset +
+				info->plt_offset;
+			ip[0] = 0x0d105810; /* basr 1,0; l 1,6(1); br 1 */
+			ip[1] = 0x100607f1;
+			ip[2] = val;
+			info->plt_initialized = 1;
+		}
+		if (r_type == R_390_PLTOFF16 ||
+		    r_type == R_390_PLTOFF32)
+			val = me->arch.plt_offset - me->arch.got_offset +
+				info->plt_offset + rela->r_addend;
+		else
+			val =  (Elf32_Addr) me->module_core +
+				me->arch.plt_offset + info->plt_offset + 
+				rela->r_addend - loc;
+		if (r_type == R_390_PLT16DBL)
+			*(unsigned short *) loc = val >> 1;
+		else if (r_type == R_390_PLTOFF16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_PLT32DBL)
+			*(unsigned int *) loc = val >> 1;
+		else if (r_type == R_390_PLT32 ||
+			 r_type == R_390_PLTOFF32)
+			*(unsigned int *) loc = val;
+		break;
+	case R_390_GOTOFF16:	/* 16 bit offset to GOT.  */
+	case R_390_GOTOFF32:	/* 32 bit offset to GOT.  */
+		val = val + rela->r_addend -
+			((Elf32_Addr) me->module_core + me->arch.got_offset);
+		if (r_type == R_390_GOTOFF16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_GOTOFF32)
+			*(unsigned int *) loc = val;
+		break;
+	case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
+	case R_390_GOTPCDBL:	/* 32 bit PC rel. off. to GOT shifted by 1. */
+		val = (Elf32_Addr) me->module_core + me->arch.got_offset +
+			rela->r_addend - loc;
+		if (r_type == R_390_GOTPC)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_GOTPCDBL)
+			*(unsigned int *) loc = val >> 1;
+		break;
+	case R_390_COPY:
+	case R_390_GLOB_DAT:	/* Create GOT entry.  */
+	case R_390_JMP_SLOT:	/* Create PLT entry.  */
+	case R_390_RELATIVE:	/* Adjust by program base.  */
+		/* Only needed if we want to support loading of 
+		   modules linked with -shared. */
+		break;
+	default:
+		printk(KERN_ERR "module %s: Unknown relocation: %u\n",
+		       me->name, r_type);
+		return -ENOEXEC;
+	}
+	return 0;
+}
+
+int
+apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relsec,
+		   struct module *me)
+{
+	Elf32_Addr base;
+	Elf32_Sym *symtab;
+	Elf32_Rela *rela;
+	unsigned long i, n;
+	int rc;
+
+	DEBUGP("Applying relocate section %u to %u\n",
+	       relsec, sechdrs[relsec].sh_info);
+	base = sechdrs[sechdrs[relsec].sh_info].sh_addr;
+	symtab = (Elf32_Sym *) sechdrs[symindex].sh_addr;
+	rela = (Elf32_Rela *) sechdrs[relsec].sh_addr;
+	n = sechdrs[relsec].sh_size / sizeof(Elf32_Rela);
+	for (i = 0; i < n; i++, rela++) {
+		rc = apply_rela(rela, base, symtab, me);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
+	if (me->arch.syminfo)
+		kfree(me->arch.syminfo);
 	return 0;
 }
diff -urN linux-2.5.62/arch/s390x/kernel/module.c linux-2.5.62-s390/arch/s390x/kernel/module.c
--- linux-2.5.62/arch/s390x/kernel/module.c	Mon Feb 17 23:57:21 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/module.c	Mon Feb 24 18:24:54 2003
@@ -2,7 +2,8 @@
  *  arch/s390x/kernel/module.c - Kernel module help for s390x.
  *
  *  S390 version
- *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 2002, 2003 IBM Deutschland Entwicklung GmbH,
+ *			       IBM Corporation
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
@@ -36,6 +37,9 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+#define GOT_ENTRY_SIZE 8
+#define PLT_ENTRY_SIZE 20
+
 void *module_alloc(unsigned long size)
 {
 	if (size == 0)
@@ -51,126 +55,322 @@
            table entries. */
 }
 
-/* s390/s390x needs additional memory for GOT/PLT sections. */
-int module_frob_arch_sections(Elf_Ehdr *hdr,
-			      Elf_Shdr *sechdrs,
-			      char *secstrings,
-			      struct module *mod)
+static inline void
+check_rela(Elf64_Rela *rela, struct module *me)
 {
-	// FIXME: add space needed for GOT/PLT
-	return 0;
+	struct mod_arch_syminfo *info;
+
+	info = me->arch.syminfo + ELF64_R_SYM (rela->r_info);
+	switch (ELF64_R_TYPE (rela->r_info)) {
+	case R_390_GOT12:	/* 12 bit GOT offset.  */
+	case R_390_GOT16:	/* 16 bit GOT offset.  */
+	case R_390_GOT32:	/* 32 bit GOT offset.  */
+	case R_390_GOT64:	/* 64 bit GOT offset.  */
+	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
+	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
+	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
+	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
+	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
+		if (info->got_offset == -1UL) {
+			info->got_offset = me->arch.got_size;
+			me->arch.got_size += GOT_ENTRY_SIZE;
+		}
+		break;
+	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+	case R_390_PLT64:	/* 64 bit PC relative PLT address.  */
+	case R_390_PLTOFF16:	/* 16 bit offset from GOT to PLT. */
+	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
+	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
+		if (info->plt_offset == -1UL) {
+			info->plt_offset = me->arch.plt_size;
+			me->arch.plt_size += PLT_ENTRY_SIZE;
+		}
+		break;
+	case R_390_COPY:
+	case R_390_GLOB_DAT:
+	case R_390_JMP_SLOT:
+	case R_390_RELATIVE:
+		/* Only needed if we want to support loading of 
+		   modules linked with -shared. */
+		break;
+	}
 }
 
-int apply_relocate(Elf_Shdr *sechdrs,
-		   const char *strtab,
-		   unsigned int symindex,
-		   unsigned int relsec,
-		   struct module *me)
+/*
+ * Account for GOT and PLT relocations. We can't add sections for
+ * got and plt but we can increase the core module size.
+ */
+int
+module_frob_arch_sections(Elf64_Ehdr *hdr, Elf64_Shdr *sechdrs,
+			  char *secstrings, struct module *me)
 {
-	unsigned int i;
-	ElfW(Rel) *rel = (void *)sechdrs[relsec].sh_addr;
-	ElfW(Sym) *sym;
-	ElfW(Addr) *location;
-
-	DEBUGP("Applying relocate section %u to %u\n", relsec,
-	       sechdrs[relsec].sh_info);
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rel[i].r_offset;
-		/* This is the symbol it is referring to.  Note that all
-		   undefined symbols have been resolved.  */
-		sym = (ElfW(Sym) *)sechdrs[symindex].sh_addr
-			+ ELFW(R_SYM)(rel[i].r_info);
-
-		switch (ELF_R_TYPE(rel[i].r_info)) {
-		case R_390_8:		/* Direct 8 bit.   */
-			*(u8*) location += sym->st_value;
-			break;
-		case R_390_12:		/* Direct 12 bit.  */
-			*(u16*) location = (*(u16*) location & 0xf000) | 
-				(sym->st_value & 0xfff);
-			break;
-		case R_390_16:		/* Direct 16 bit.  */
-			*(u16*) location += sym->st_value;
-			break;
-		case R_390_32:		/* Direct 32 bit.  */
-			*(u32*) location += sym->st_value;
-			break;
-		case R_390_64:		/* Direct 64 bit.  */
-			*(u64*) location += sym->st_value;
-			break;
-		case R_390_PC16:	/* PC relative 16 bit.  */
-			*(u16*) location += sym->st_value
-					    - (unsigned long )location;
-
-		case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
-			*(u16*) location += (sym->st_value
-					     - (unsigned long )location) >> 1;
-		case R_390_PC32:	/* PC relative 32 bit.  */
-			*(u32*) location += sym->st_value
-					    - (unsigned long )location;
-			break;
-		case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
-			*(u32*) location += (sym->st_value
-					     - (unsigned long )location) >> 1;
-			break;
-		case R_390_PC64:	/* PC relative 64 bit.  */
-			*(u64*) location += sym->st_value
-					    - (unsigned long )location;
-			break;
-		case R_390_GOT12:	/* 12 bit GOT offset.  */
-		case R_390_GOT16:	/* 16 bit GOT offset.  */
-		case R_390_GOT32:	/* 32 bit GOT offset.  */
-		case R_390_GOT64:	/* 64 bit GOT offset.  */
-		case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry >> 1. */
-			// FIXME: TODO
-			break;
-
-		case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
-		case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
-		case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
-		case R_390_PLT64:	/* 64 bit PC relative PLT address.   */
-			// FIXME: TODO
-			break;
-		case R_390_GLOB_DAT:	/* Create GOT entry.  */
-		case R_390_JMP_SLOT:	/* Create PLT entry.  */
-			*location = sym->st_value;
-			break;
-		case R_390_RELATIVE:	/* Adjust by program base.  */
-			// FIXME: TODO
+	Elf64_Shdr *symtab;
+	Elf64_Sym *symbols;
+	Elf64_Rela *rela;
+	char *strings;
+	int nrela, i, j;
+
+	/* Find symbol table and string table. */
+	symtab = 0;
+	for (i = 0; i < hdr->e_shnum; i++)
+		switch (sechdrs[i].sh_type) {
+		case SHT_SYMTAB:
+			symtab = sechdrs + i;
 			break;
-		case R_390_GOTOFF:	/* 32 bit offset to GOT.  */
-			// FIXME: TODO
-			break;
-		case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
-		case R_390_GOTPCDBL:	/* 32 bit PC rel. GOT shifted by 1.  */
-			// FIXME: TODO
-			break;
-		default:
-			printk(KERN_ERR "module %s: Unknown relocation: %lu\n",
-			       me->name,
-			       (unsigned long)ELF_R_TYPE(rel[i].r_info));
-			return -ENOEXEC;
 		}
+	if (!symtab) {
+		printk(KERN_ERR "module %s: no symbol table\n", me->name);
+		return -ENOEXEC;
+	}
+
+	/* Allocate one syminfo structure per symbol. */
+	me->arch.nsyms = symtab->sh_size / sizeof(Elf64_Sym);
+	me->arch.syminfo = kmalloc(me->arch.nsyms *
+				   sizeof(struct mod_arch_syminfo),
+				   GFP_KERNEL);
+	if (!me->arch.syminfo)
+		return -ENOMEM;
+	symbols = (void *) hdr + symtab->sh_offset;
+	strings = (void *) hdr + sechdrs[symtab->sh_link].sh_offset;
+	for (i = 0; i < me->arch.nsyms; i++) {
+		if (symbols[i].st_shndx == SHN_UNDEF &&
+		    strcmp(strings + symbols[i].st_name,
+			   "_GLOBAL_OFFSET_TABLE_") == 0)
+			/* "Define" it as absolute. */
+			symbols[i].st_shndx = SHN_ABS;
+		me->arch.syminfo[i].got_offset = -1UL;
+		me->arch.syminfo[i].plt_offset = -1UL;
+		me->arch.syminfo[i].got_initialized = 0;
+		me->arch.syminfo[i].plt_initialized = 0;
+	}
+
+	/* Search for got/plt relocations. */
+	me->arch.got_size = me->arch.plt_size = 0;
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_RELA)
+			continue;
+		nrela = sechdrs[i].sh_size / sizeof(Elf64_Rela);
+		rela = (void *) hdr + sechdrs[i].sh_offset;
+		for (j = 0; j < nrela; j++)
+			check_rela(rela + j, me);
 	}
+
+	/* Increase core size by size of got & plt and set start
+	   offsets for got and plt. */
+	me->core_size = ALIGN(me->core_size, 4);
+	me->arch.got_offset = me->core_size;
+	me->core_size += me->arch.got_size;
+	me->arch.plt_offset = me->core_size;
+	me->core_size += me->arch.plt_size;
 	return 0;
 }
 
-int apply_relocate_add(Elf32_Shdr *sechdrs,
-		       const char *strtab,
-		       unsigned int symindex,
-		       unsigned int relsec,
-		       struct module *me)
+int
+apply_relocate(Elf_Shdr *sechdrs, const char *strtab, unsigned int symindex,
+	       unsigned int relsec, struct module *me)
 {
-	printk(KERN_ERR "module %s: ADD RELOCATION unsupported\n",
+	printk(KERN_ERR "module %s: RELOCATION unsupported\n",
 	       me->name);
 	return -ENOEXEC;
 }
 
+static inline int
+apply_rela(Elf64_Rela *rela, Elf64_Addr base, Elf64_Sym *symtab, 
+	   struct module *me)
+{
+	struct mod_arch_syminfo *info;
+	Elf64_Addr loc, val;
+	int r_type, r_sym;
+
+	/* This is where to make the change */
+	loc = base + rela->r_offset;
+	/* This is the symbol it is referring to.  Note that all
+	   undefined symbols have been resolved.  */
+	r_sym = ELF64_R_SYM(rela->r_info);
+	r_type = ELF64_R_TYPE(rela->r_info);
+	info = me->arch.syminfo + r_sym;
+	val = symtab[r_sym].st_value;
+
+	switch (r_type) {
+	case R_390_8:		/* Direct 8 bit.   */
+	case R_390_12:		/* Direct 12 bit.  */
+	case R_390_16:		/* Direct 16 bit.  */
+	case R_390_32:		/* Direct 32 bit.  */
+	case R_390_64:		/* Direct 64 bit.  */
+		val += rela->r_addend;
+		if (r_type == R_390_8)
+			*(unsigned char *) loc = val;
+		else if (r_type == R_390_12)
+			*(unsigned short *) loc = (val & 0xfff) |
+				(*(unsigned short *) loc & 0xf000);
+		else if (r_type == R_390_16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_32)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_64)
+			*(unsigned long *) loc = val;
+		break;
+	case R_390_PC16:	/* PC relative 16 bit.  */
+	case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
+	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
+	case R_390_PC32:	/* PC relative 32 bit.  */
+	case R_390_PC64:	/* PC relative 64 bit.	*/
+		val += rela->r_addend - loc;
+		if (r_type == R_390_PC16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_PC16DBL)
+			*(unsigned short *) loc = val >> 1;
+		else if (r_type == R_390_PC32DBL)
+			*(unsigned int *) loc = val >> 1;
+		else if (r_type == R_390_PC32)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_PC64)
+			*(unsigned long *) loc = val;
+		break;
+	case R_390_GOT12:	/* 12 bit GOT offset.  */
+	case R_390_GOT16:	/* 16 bit GOT offset.  */
+	case R_390_GOT32:	/* 32 bit GOT offset.  */
+	case R_390_GOT64:	/* 64 bit GOT offset.  */
+	case R_390_GOTENT:	/* 32 bit PC rel. to GOT entry shifted by 1. */
+	case R_390_GOTPLT12:	/* 12 bit offset to jump slot.	*/
+	case R_390_GOTPLT16:	/* 16 bit offset to jump slot. */
+	case R_390_GOTPLT32:	/* 32 bit offset to jump slot. */
+	case R_390_GOTPLT64:	/* 64 bit offset to jump slot.	*/
+	case R_390_GOTPLTENT:	/* 32 bit rel. offset to jump slot >> 1. */
+		if (info->got_initialized == 0) {
+			Elf64_Addr *gotent;
+			gotent = me->module_core + me->arch.got_offset +
+				info->got_offset;
+			*gotent = val;
+			info->got_initialized = 1;
+		}
+		val = info->got_offset + rela->r_addend;
+		if (r_type == R_390_GOT12 ||
+		    r_type == R_390_GOTPLT12)
+			*(unsigned short *) loc = (val & 0xfff) |
+				(*(unsigned short *) loc & 0xf000);
+		else if (r_type == R_390_GOT16 ||
+			 r_type == R_390_GOTPLT16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_GOT32 ||
+			 r_type == R_390_GOTPLT32)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_GOTENT ||
+			 r_type == R_390_GOTPLTENT)
+			*(unsigned int *) loc = val >> 1;
+		else if (r_type == R_390_GOT64 ||
+			 r_type == R_390_GOTPLT64)
+			*(unsigned long *) loc = val;
+		break;
+	case R_390_PLT16DBL:	/* 16 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
+	case R_390_PLT32:	/* 32 bit PC relative PLT address.  */
+	case R_390_PLT64:	/* 64 bit PC relative PLT address.  */
+	case R_390_PLTOFF16:	/* 16 bit offset from GOT to PLT. */
+	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
+	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
+		if (info->plt_initialized == 0) {
+			unsigned int *ip;
+			ip = me->module_core + me->arch.plt_offset +
+				info->plt_offset;
+			ip[0] = 0x0d10e310; /* basr 1,0; lg 1,10(1); br 1 */
+			ip[1] = 0x100a0004;
+			ip[2] = 0x07f10000;
+			ip[3] = (unsigned int) (val >> 32);
+			ip[4] = (unsigned int) val;
+			info->plt_initialized = 1;
+		}
+		if (r_type == R_390_PLTOFF16 ||
+		    r_type == R_390_PLTOFF32 ||
+		    r_type == R_390_PLTOFF64)
+			val = me->arch.plt_offset - me->arch.got_offset +
+				info->plt_offset + rela->r_addend;
+		else
+			val =  (Elf64_Addr) me->module_core +
+				me->arch.plt_offset + info->plt_offset + 
+				rela->r_addend - loc;
+		if (r_type == R_390_PLT16DBL)
+			*(unsigned short *) loc = val >> 1;
+		else if (r_type == R_390_PLTOFF16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_PLT32DBL)
+			*(unsigned int *) loc = val >> 1;
+		else if (r_type == R_390_PLT32 ||
+			 r_type == R_390_PLTOFF32)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_PLT64 ||
+			 r_type == R_390_PLTOFF64)
+			*(unsigned long *) loc = val;
+		break;
+	case R_390_GOTOFF16:	/* 16 bit offset to GOT.  */
+	case R_390_GOTOFF32:	/* 32 bit offset to GOT.  */
+	case R_390_GOTOFF64:	/* 64 bit offset to GOT. */
+		val = val + rela->r_addend -
+			((Elf64_Addr) me->module_core + me->arch.got_offset);
+		if (r_type == R_390_GOTOFF16)
+			*(unsigned short *) loc = val;
+		else if (r_type == R_390_GOTOFF32)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_GOTOFF64)
+			*(unsigned long *) loc = val;
+		break;
+	case R_390_GOTPC:	/* 32 bit PC relative offset to GOT. */
+	case R_390_GOTPCDBL:	/* 32 bit PC rel. off. to GOT shifted by 1. */
+		val = (Elf64_Addr) me->module_core + me->arch.got_offset +
+			rela->r_addend - loc;
+		if (r_type == R_390_GOTPC)
+			*(unsigned int *) loc = val;
+		else if (r_type == R_390_GOTPCDBL)
+			*(unsigned int *) loc = val >> 1;
+		break;
+	case R_390_COPY:
+	case R_390_GLOB_DAT:	/* Create GOT entry.  */
+	case R_390_JMP_SLOT:	/* Create PLT entry.  */
+	case R_390_RELATIVE:	/* Adjust by program base.  */
+		/* Only needed if we want to support loading of 
+		   modules linked with -shared. */
+		break;
+	default:
+		printk(KERN_ERR "module %s: Unknown relocation: %u\n",
+		       me->name, r_type);
+		return -ENOEXEC;
+	}
+	return 0;
+}
+
+int
+apply_relocate_add(Elf64_Shdr *sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relsec,
+		   struct module *me)
+{
+	Elf64_Addr base;
+	Elf64_Sym *symtab;
+	Elf64_Rela *rela;
+	unsigned long i, n;
+	int rc;
+
+	DEBUGP("Applying relocate section %u to %u\n",
+	       relsec, sechdrs[relsec].sh_info);
+	base = sechdrs[sechdrs[relsec].sh_info].sh_addr;
+	symtab = (Elf64_Sym *) sechdrs[symindex].sh_addr;
+	rela = (Elf64_Rela *) sechdrs[relsec].sh_addr;
+	n = sechdrs[relsec].sh_size / sizeof(Elf64_Rela);
+	for (i = 0; i < n; i++, rela++) {
+		rc = apply_rela(rela, base, symtab, me);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
+	if (me->arch.syminfo)
+		kfree(me->arch.syminfo);
 	return 0;
 }
diff -urN linux-2.5.62/include/asm-s390/module.h linux-2.5.62-s390/include/asm-s390/module.h
--- linux-2.5.62/include/asm-s390/module.h	Mon Feb 17 23:55:49 2003
+++ linux-2.5.62-s390/include/asm-s390/module.h	Mon Feb 24 18:24:54 2003
@@ -4,10 +4,28 @@
  * This file contains the s390 architecture specific module code.
  */
 
+struct mod_arch_syminfo
+{
+	unsigned long got_offset;
+	unsigned long plt_offset;
+	int got_initialized;
+	int plt_initialized;
+};
+
 struct mod_arch_specific
 {
-	void *module_got, *module_plt;
-	unsigned long got_size, plt_size;
+	/* Starting offset of got in the module core memory. */
+	unsigned long got_offset;
+	/* Starting offset of plt in the module core memory. */
+	unsigned long plt_offset;
+	/* Size of the got. */
+	unsigned long got_size;
+	/* Size of the plt. */
+	unsigned long plt_size;
+	/* Number of symbols in syminfo. */
+	int nsyms;
+	/* Additional symbol information (got and plt offsets). */
+	struct mod_arch_syminfo *syminfo;
 };
 
 #ifdef CONFIG_ARCH_S390X
diff -urN linux-2.5.62/include/asm-s390x/module.h linux-2.5.62-s390/include/asm-s390x/module.h
--- linux-2.5.62/include/asm-s390x/module.h	Mon Feb 17 23:55:48 2003
+++ linux-2.5.62-s390/include/asm-s390x/module.h	Mon Feb 24 18:24:54 2003
@@ -4,10 +4,28 @@
  * This file contains the s390 architecture specific module code.
  */
 
+struct mod_arch_syminfo
+{
+	unsigned long got_offset;
+	unsigned long plt_offset;
+	int got_initialized;
+	int plt_initialized;
+};
+
 struct mod_arch_specific
 {
-	void *module_got, *module_plt;
-	unsigned long got_size, plt_size;
+	/* Starting offset of got in the module core memory. */
+	unsigned long got_offset;
+	/* Starting offset of plt in the module core memory. */
+	unsigned long plt_offset;
+	/* Size of the got. */
+	unsigned long got_size;
+	/* Size of the plt. */
+	unsigned long plt_size;
+	/* Number of symbols in syminfo. */
+	int nsyms;
+	/* Additional symbol information (got and plt offsets). */
+	struct mod_arch_syminfo *syminfo;
 };
 
 #ifdef CONFIG_ARCH_S390X
diff -urN linux-2.5.62/include/linux/elf.h linux-2.5.62-s390/include/linux/elf.h
--- linux-2.5.62/include/linux/elf.h	Mon Feb 17 23:55:57 2003
+++ linux-2.5.62-s390/include/linux/elf.h	Mon Feb 24 18:24:54 2003
@@ -433,35 +433,82 @@
 #define R_PPC_NUM		37
 
 /* s390 relocations defined by the ABIs */
-#define R_390_NONE	0	       /* No reloc.  */
-#define R_390_8		1	       /* Direct 8 bit.	 */
-#define R_390_12	2	       /* Direct 12 bit.  */
-#define R_390_16	3	       /* Direct 16 bit.  */
-#define R_390_32	4	       /* Direct 32 bit.  */
-#define R_390_PC32	5	       /* PC relative 32 bit.  */
-#define R_390_GOT12	6	       /* 12 bit GOT offset.  */
-#define R_390_GOT32	7	       /* 32 bit GOT offset.  */
-#define R_390_PLT32	8	       /* 32 bit PC relative PLT address.  */
-#define R_390_COPY	9	       /* Copy symbol at runtime.  */
-#define R_390_GLOB_DAT	10	       /* Create GOT entry.  */
-#define R_390_JMP_SLOT	11	       /* Create PLT entry.  */
-#define R_390_RELATIVE	12	       /* Adjust by program base.  */
-#define R_390_GOTOFF	13	       /* 32 bit offset to GOT.	 */
-#define R_390_GOTPC	14	       /* 32 bit PC relative offset to GOT.  */
-#define R_390_GOT16	15	       /* 16 bit GOT offset.  */
-#define R_390_PC16	16	       /* PC relative 16 bit.  */
-#define R_390_PC16DBL	17	       /* PC relative 16 bit shifted by 1.  */
-#define R_390_PLT16DBL	18	       /* 16 bit PC rel. PLT shifted by 1.  */
-#define R_390_PC32DBL	19	       /* PC relative 32 bit shifted by 1.  */
-#define R_390_PLT32DBL	20	       /* 32 bit PC rel. PLT shifted by 1.  */
-#define R_390_GOTPCDBL	21	       /* 32 bit PC rel. GOT shifted by 1.  */
-#define R_390_64	22	       /* Direct 64 bit.  */
-#define R_390_PC64	23	       /* PC relative 64 bit.  */
-#define R_390_GOT64	24	       /* 64 bit GOT offset.  */
-#define R_390_PLT64	25	       /* 64 bit PC relative PLT address.  */
-#define R_390_GOTENT	26	       /* 32 bit PC rel. to GOT entry >> 1. */
+#define R_390_NONE		0	/* No reloc.  */
+#define R_390_8			1	/* Direct 8 bit.  */
+#define R_390_12		2	/* Direct 12 bit.  */
+#define R_390_16		3	/* Direct 16 bit.  */
+#define R_390_32		4	/* Direct 32 bit.  */
+#define R_390_PC32		5	/* PC relative 32 bit.	*/
+#define R_390_GOT12		6	/* 12 bit GOT offset.  */
+#define R_390_GOT32		7	/* 32 bit GOT offset.  */
+#define R_390_PLT32		8	/* 32 bit PC relative PLT address.  */
+#define R_390_COPY		9	/* Copy symbol at runtime.  */
+#define R_390_GLOB_DAT		10	/* Create GOT entry.  */
+#define R_390_JMP_SLOT		11	/* Create PLT entry.  */
+#define R_390_RELATIVE		12	/* Adjust by program base.  */
+#define R_390_GOTOFF32		13	/* 32 bit offset to GOT.	 */
+#define R_390_GOTPC		14	/* 32 bit PC rel. offset to GOT.  */
+#define R_390_GOT16		15	/* 16 bit GOT offset.  */
+#define R_390_PC16		16	/* PC relative 16 bit.	*/
+#define R_390_PC16DBL		17	/* PC relative 16 bit shifted by 1.  */
+#define R_390_PLT16DBL		18	/* 16 bit PC rel. PLT shifted by 1.  */
+#define R_390_PC32DBL		19	/* PC relative 32 bit shifted by 1.  */
+#define R_390_PLT32DBL		20	/* 32 bit PC rel. PLT shifted by 1.  */
+#define R_390_GOTPCDBL		21	/* 32 bit PC rel. GOT shifted by 1.  */
+#define R_390_64		22	/* Direct 64 bit.  */
+#define R_390_PC64		23	/* PC relative 64 bit.	*/
+#define R_390_GOT64		24	/* 64 bit GOT offset.  */
+#define R_390_PLT64		25	/* 64 bit PC relative PLT address.  */
+#define R_390_GOTENT		26	/* 32 bit PC rel. to GOT entry >> 1. */
+#define R_390_GOTOFF16		27	/* 16 bit offset to GOT. */
+#define R_390_GOTOFF64		28	/* 64 bit offset to GOT. */
+#define R_390_GOTPLT12		29	/* 12 bit offset to jump slot.	*/
+#define R_390_GOTPLT16		30	/* 16 bit offset to jump slot.	*/
+#define R_390_GOTPLT32		31	/* 32 bit offset to jump slot.	*/
+#define R_390_GOTPLT64		32	/* 64 bit offset to jump slot.	*/
+#define R_390_GOTPLTENT		33	/* 32 bit rel. offset to jump slot.  */
+#define R_390_PLTOFF16		34	/* 16 bit offset from GOT to PLT. */
+#define R_390_PLTOFF32		35	/* 32 bit offset from GOT to PLT. */
+#define R_390_PLTOFF64		36	/* 16 bit offset from GOT to PLT. */
+#define R_390_TLS_LOAD		37	/* Tag for load insn in TLS code. */
+#define R_390_TLS_GDCALL	38	/* Tag for function call in general
+                                           dynamic TLS code.  */
+#define R_390_TLS_LDCALL	39	/* Tag for function call in local
+                                           dynamic TLS code.  */
+#define R_390_TLS_GD32		40	/* Direct 32 bit for general dynamic
+                                           thread local data.  */
+#define R_390_TLS_GD64		41	/* Direct 64 bit for general dynamic
+                                           thread local data.  */
+#define R_390_TLS_GOTIE12	42	/* 12 bit GOT offset for static TLS
+                                           block offset.  */
+#define R_390_TLS_GOTIE32	43	/* 32 bit GOT offset for static TLS
+                                           block offset.  */
+#define R_390_TLS_GOTIE64	44	/* 64 bit GOT offset for static TLS
+                                           block offset.  */
+#define R_390_TLS_LDM32		45	/* Direct 32 bit for local dynamic
+                                           thread local data in LD code.  */
+#define R_390_TLS_LDM64		46	/* Direct 64 bit for local dynamic
+                                           thread local data in LD code.  */
+#define R_390_TLS_IE32		47	/* 32 bit address of GOT entry for
+                                           negated static TLS block offset.  */
+#define R_390_TLS_IE64		48	/* 64 bit address of GOT entry for
+                                           negated static TLS block offset.  */
+#define R_390_TLS_IEENT		49	/* 32 bit rel. offset to GOT entry for
+                                           negated static TLS block offset.  */
+#define R_390_TLS_LE32		50	/* 32 bit negated offset relative to
+                                           static TLS block.  */
+#define R_390_TLS_LE64		51	/* 64 bit negated offset relative to
+                                           static TLS block.  */
+#define R_390_TLS_LDO32		52	/* 32 bit offset relative to TLS
+                                           block.  */
+#define R_390_TLS_LDO64		53	/* 64 bit offset relative to TLS
+                                           block.  */
+#define R_390_TLS_DTPMOD	54	/* ID of module containing symbol.  */
+#define R_390_TLS_DTPOFF	55	/* Offset in TLS block.  */
+#define R_390_TLS_TPOFF		56	/* Negate offset in static TLS
+                                           block.  */
 /* Keep this the last entry.  */
-#define R_390_NUM	27
+#define R_390_NUM	57
 
 /* x86-64 relocation types */
 #define R_X86_64_NONE		0	/* No reloc */
@@ -484,37 +531,6 @@
 
 #define R_X86_64_NUM		16
 
-/* s390 relocations defined by the ABIs */
-#define R_390_NONE	0	       /* No reloc.  */
-#define R_390_8		1	       /* Direct 8 bit.	 */
-#define R_390_12	2	       /* Direct 12 bit.  */
-#define R_390_16	3	       /* Direct 16 bit.  */
-#define R_390_32	4	       /* Direct 32 bit.  */
-#define R_390_PC32	5	       /* PC relative 32 bit.  */
-#define R_390_GOT12	6	       /* 12 bit GOT offset.  */
-#define R_390_GOT32	7	       /* 32 bit GOT offset.  */
-#define R_390_PLT32	8	       /* 32 bit PC relative PLT address.  */
-#define R_390_COPY	9	       /* Copy symbol at runtime.  */
-#define R_390_GLOB_DAT	10	       /* Create GOT entry.  */
-#define R_390_JMP_SLOT	11	       /* Create PLT entry.  */
-#define R_390_RELATIVE	12	       /* Adjust by program base.  */
-#define R_390_GOTOFF	13	       /* 32 bit offset to GOT.	 */
-#define R_390_GOTPC	14	       /* 32 bit PC relative offset to GOT.  */
-#define R_390_GOT16	15	       /* 16 bit GOT offset.  */
-#define R_390_PC16	16	       /* PC relative 16 bit.  */
-#define R_390_PC16DBL	17	       /* PC relative 16 bit shifted by 1.  */
-#define R_390_PLT16DBL	18	       /* 16 bit PC rel. PLT shifted by 1.  */
-#define R_390_PC32DBL	19	       /* PC relative 32 bit shifted by 1.  */
-#define R_390_PLT32DBL	20	       /* 32 bit PC rel. PLT shifted by 1.  */
-#define R_390_GOTPCDBL	21	       /* 32 bit PC rel. GOT shifted by 1.  */
-#define R_390_64	22	       /* Direct 64 bit.  */
-#define R_390_PC64	23	       /* PC relative 64 bit.  */
-#define R_390_GOT64	24	       /* 64 bit GOT offset.  */
-#define R_390_PLT64	25	       /* 64 bit PC relative PLT address.  */
-#define R_390_GOTENT	26	       /* 32 bit PC rel. to GOT entry >> 1. */
-/* Keep this the last entry.  */
-#define R_390_NUM	27
-
 /* Legal values for e_flags field of Elf64_Ehdr.  */
 
 #define EF_ALPHA_32BIT		1	/* All addresses are below 2GB */

