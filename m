Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbTBGIkW>; Fri, 7 Feb 2003 03:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267741AbTBGIkW>; Fri, 7 Feb 2003 03:40:22 -0500
Received: from dp.samba.org ([66.70.73.150]:54181 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267739AbTBGIkJ>;
	Fri, 7 Feb 2003 03:40:09 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Restore module support. 
In-reply-to: Your message of "Fri, 07 Feb 2003 15:53:44 +1100."
Date: Fri, 07 Feb 2003 19:26:50 +1100
Message-Id: <20030207084947.A31572C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <20030207001006.A19306@flint.arm.linux.org.uk> you write:
> > And I'll promptly provide you with the other view.  I'm still trying to
> > sort out the best thing to do for ARM.  We have the choice of:

Actually, I must be really confused.  I thought ARM was already
complete.

Anyway, here's a version which simply does what the usermode one did,
if you decide to take the "fix it later" approach.

Cheers!
Rusty.
PS.  I did this in the usermode test framework, so not live tested.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.59/arch/arm/kernel/module.c working-2.5.59-armmodule/arch/arm/kernel/module.c
--- linux-2.5.59/arch/arm/kernel/module.c	2003-02-07 19:21:51.000000000 +1100
+++ working-2.5.59-armmodule/arch/arm/kernel/module.c	2003-02-07 19:04:12.000000000 +1100
@@ -2,6 +2,7 @@
  *  linux/arch/arm/kernel/module.c
  *
  *  Copyright (C) 2002 Russell King.
+ *  Dumbed down by Rusty Russell.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,54 +18,74 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 
-#include <asm/pgtable.h>
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , ...)
+#endif
 
-void *module_alloc(unsigned long size)
+/* This is a beautiful architecture. --RR */
+struct arm_plt_entry
 {
-	struct vm_struct *area;
-	struct page **pages;
-	unsigned int array_size, i;
-
-	size = PAGE_ALIGN(size);
-	if (!size)
-		goto out_null;
+	u32 ldr_pc;			/* ldr pc,[pc,#-4] */
+	u32 location;			/* sym@ */
+};
 
-	area = __get_vm_area(size, VM_ALLOC, MODULE_START, MODULE_END);
-	if (!area)
-		goto out_null;
+void *module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+	return vmalloc(size);
+}
 
-	area->nr_pages = size >> PAGE_SHIFT;
-	array_size = area->nr_pages * sizeof(struct page *);
-	area->pages = pages = kmalloc(array_size, GFP_KERNEL);
-	if (!area->pages) {
-		remove_vm_area(area->addr);
-		kfree(area);
-		goto out_null;
-	}
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+}
 
-	memset(pages, 0, array_size);
+/* Count how many different PC24 relocations (different symbol) */
+static unsigned int count_relocs(const Elf32_Rel *rel, unsigned int num)
+{
+	unsigned int i, j, ret = 0;
 
-	for (i = 0; i < area->nr_pages; i++) {
-		pages[i] = alloc_page(GFP_KERNEL);
-		if (unlikely(!pages[i])) {
-			area->nr_pages = i;
-			goto out_no_pages;
+	/* Sure, this is order(n^2), but it's usually short, and not
+           time critical */
+	for (i = 0; i < num; i++) {
+		if (ELF32_R_TYPE(rel[i].r_info) != R_ARM_PC24)
+			continue;
+		for (j = 0; j < i; j++) {
+			if (ELF32_R_TYPE(rel[j].r_info) != R_ARM_PC24)
+				continue;
+			/* If this addend appeared before, it's
+                           already been counted */
+			if (ELF32_R_SYM(rel[i].r_info)
+			    == ELF32_R_SYM(rel[j].r_info))
+				break;
 		}
+		if (j == i) ret++;
 	}
-
-	if (map_vm_area(area, PAGE_KERNEL, &pages))
-		goto out_no_pages;
-	return area->addr;
-
- out_no_pages:
-	vfree(area->addr);
- out_null:
-	return NULL;
+	return ret;
 }
 
-void module_free(struct module *module, void *region)
+/* Get the potential trampolines size required sections */
+static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
+				  const Elf32_Shdr *sechdrs,
+				  const char *secstrings)
 {
-	vfree(region);
+	unsigned long ret = 0;
+	unsigned i;
+
+	/* Everything marked ALLOC (this includes the exported
+           symbols) */
+	for (i = 1; i < hdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_REL)
+			continue;
+		ret += count_relocs((void *)hdr + sechdrs[i].sh_offset,
+				    sechdrs[i].sh_size / sizeof(Elf32_Rel));
+	}
+
+	return ret * sizeof(struct arm_plt_entry);
 }
 
 int module_frob_arch_sections(Elf_Ehdr *hdr,
@@ -72,9 +93,55 @@ int module_frob_arch_sections(Elf_Ehdr *
 			      char *secstrings,
 			      struct module *mod)
 {
+	unsigned int i;
+	char *p;
+
+	/* Find .plt section, and rename .init sections, which we
+           don't handle */
+	for (i = 1; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings + sechdrs[i].sh_name, ".plt") == 0)
+			mod->arch.plt_section = i;
+		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
+			p[0] = '_';
+	}
+	if (!mod->arch.plt_section) {
+		printk("Module doesn't contain .plt section.\n");
+		return -ENOEXEC;
+	}
+
+	/* Override its size */
+	sechdrs[mod->arch.plt_section].sh_size
+		= get_plt_size(hdr, sechdrs, secstrings);
+	/* Override its type and flags: in asm statement doesn't work 8( */
+	sechdrs[mod->arch.plt_section].sh_type = SHT_NOBITS;
+	sechdrs[mod->arch.plt_section].sh_flags = (SHF_EXECINSTR | SHF_ALLOC);
 	return 0;
 }
 
+/* Allocate (or find) the PLT entry for this function. */
+static u32 make_plt(Elf32_Shdr *sechdrs, struct module *module, u32 funcaddr)
+{
+	struct arm_plt_entry *plt;
+	unsigned int i, num_plts;
+
+	plt = (void *)sechdrs[module->arch.plt_section].sh_addr;
+	num_plts = sechdrs[module->arch.plt_section].sh_size / sizeof(*plt);
+
+	for (i = 0; i < num_plts; i++) {
+		if (!plt[i].ldr_pc) {
+			/* New one.  Fill in. */
+			plt[i].ldr_pc = 0xe51ff004;
+			plt[i].location = funcaddr;
+		}
+		if (plt[i].location == funcaddr) {
+			DEBUGP("Made plt %u for %p at %p\n",
+			       i, (void *)funcaddr, &plt[i]);
+			return (u32)&plt[i];
+		}
+	}
+	BUG();
+}
+
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	       unsigned int relindex, struct module *module)
@@ -86,7 +153,7 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
 	unsigned int i;
 
 	for (i = 0; i < relsec->sh_size / sizeof(Elf32_Rel); i++, rel++) {
-		unsigned long loc;
+		unsigned long loc, addend;
 		Elf32_Sym *sym;
 		s32 offset;
 
@@ -98,6 +165,11 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
 		}
 
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
+		if (!sym->st_value) {
+			printk(KERN_WARNING "%s: unknown symbol %s\n",
+				module->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
 
 		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
 			printk(KERN_ERR "%s: out of bounds relocation, "
@@ -115,24 +187,26 @@ apply_relocate(Elf32_Shdr *sechdrs, cons
 			break;
 
 		case R_ARM_PC24:
-			offset = (*(u32 *)loc & 0x00ffffff) << 2;
-			if (offset & 0x02000000)
-				offset -= 0x04000000;
+			/* Pull addend from location */
+			addend = (*(u32 *)loc & 0x00ffffff) << 2;
+			if (addend & 0x02000000)
+				addend -= 0x04000000;
+			offset = sym->st_value + addend - loc;
 
-			offset += sym->st_value - loc;
-			if (offset & 3 ||
-			    offset <= (s32)0xfc000000 ||
-			    offset >= (s32)0x04000000) {
+			/* if the target is too far away, use plt. */
+			if (offset < -0x02000000 || offset >= 0x02000000)
+				offset = make_plt(sechdrs,module,sym->st_value)
+					+ addend - loc;
+
+			if (offset & 3) {
 				printk(KERN_ERR "%s: unable to fixup "
-				       "relocation: out of range\n",
-				       module->name);
+				       "relocation: %u out of range\n",
+				       module->name, offset);
 				return -ENOEXEC;
 			}
 
-			offset >>= 2;
-
 			*(u32 *)loc &= 0xff000000;
-			*(u32 *)loc |= offset & 0x00ffffff;
+			*(u32 *)loc |= (offset >> 2) & 0x00ffffff;
 			break;
 
 		default:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.59/include/asm-arm/module.h working-2.5.59-armmodule/include/asm-arm/module.h
--- linux-2.5.59/include/asm-arm/module.h	2003-02-07 19:16:25.000000000 +1100
+++ working-2.5.59-armmodule/include/asm-arm/module.h	2003-02-07 19:04:03.000000000 +1100
@@ -3,11 +3,16 @@
 
 struct mod_arch_specific
 {
-	int foo;
+	/* Index of PLT section within module. */
+	unsigned int plt_section;
 };
 
 #define Elf_Shdr	Elf32_Shdr
 #define Elf_Sym		Elf32_Sym
 #define Elf_Ehdr	Elf32_Ehdr
 
+/* Make empty sections for module_frob_arch_sections to expand. */
+#ifdef MODULE
+asm(".section .plt; .align 3; .previous");
+#endif
 #endif /* _ASM_ARM_MODULE_H */
