Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTABCwz>; Wed, 1 Jan 2003 21:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTABCwy>; Wed, 1 Jan 2003 21:52:54 -0500
Received: from dp.samba.org ([66.70.73.150]:62903 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265675AbTABCwQ>;
	Wed, 1 Jan 2003 21:52:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, ak@suse.de,
       davem@redhat.com, paulus@samba.org, rmk@arm.linux.org.uk
Subject: [PATCH] Modules 3/3: Sort sections
Date: Thu, 02 Jan 2003 14:00:27 +1100
Message-Id: <20030102030044.D066C2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

RTH's final complaint (so far 8) was that we should sort the module
sections: archs which use GOT pointers (or equiv) might need those
sections close by each other.

The code does this, and simplifies the arch interface: previously an
arch could specify it wanted extra space, but not where that space
would be.  The new method (used only by PPC so far) is to allocate an
empty section (in asm/module.h or by setting LDFLAGS_MODULE to use an
arch specific linker script), and expand that to the desired size in
"module_frob_arch_sections()".

x86 and PPC are tested, others are trivial.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Section Ordering Patch
Author: Richard Henderson
Status: Tested on 2.5.53
Depends: Module/nocommon.patch.gz Module/sh_addr.patch.gz

D: Some architectures require some sections to be adjacent, so they
D: can all be reached by a relative pointer (ie. GOT pointer).  This
D: implements that reordering, and simplfies the module interface
D: for architectures as well.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/arm/kernel/module.c .1000-2.5-bk-section-ordering/arch/arm/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/arm/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/arm/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -67,18 +67,12 @@ void module_free(struct module *module, 
 	vfree(region);
 }
 
-long
-module_core_size(const Elf32_Ehdr *hdr, const Elf32_Shdr *sechdrs,
-		 const char *secstrings, struct module *module)
-{
-	return module->core_size;
-}
-
-long
-module_init_size(const Elf32_Ehdr *hdr, const Elf32_Shdr *sechdrs,
-		 const char *secstrings, struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
-	return module->init_size;
+	return 0;
 }
 
 int
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/i386/kernel/module.c .1000-2.5-bk-section-ordering/arch/i386/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/i386/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/i386/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -45,20 +45,12 @@ void module_free(struct module *mod, voi
 }
 
 /* We don't need anything special. */
-long module_core_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	return module->core_size;
-}
-
-long module_init_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
-	return module->init_size;
+	return 0;
 }
 
 int apply_relocate(Elf32_Shdr *sechdrs,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/ppc/kernel/module.c .1000-2.5-bk-section-ordering/arch/ppc/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/ppc/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/ppc/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -101,24 +101,31 @@ static unsigned long get_plt_size(const 
 	return ret;
 }
 
-long module_core_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(Elf32_Ehdr *hdr,
+			      Elf32_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *me)
 {
-	module->arch.core_plt_offset = ALIGN(module->core_size, 4);
-	return module->arch.core_plt_offset
-		+ get_plt_size(hdr, sechdrs, secstrings, 0);
-}
+	unsigned int i;
 
-long module_init_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	module->arch.init_plt_offset = ALIGN(module->init_size, 4);
-	return module->arch.init_plt_offset
-		+ get_plt_size(hdr, sechdrs, secstrings, 1);
+	/* Find .plt and .pltinit sections */
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if (strcmp(secstrings + sechdrs[i].sh_name, ".plt.init") == 0)
+			me->arch.init_plt_section = i;
+		else if (strcmp(secstrings + sechdrs[i].sh_name, ".plt") == 0)
+			me->arch.core_plt_section = i;
+	}
+	if (!me->arch.core_plt_section || !me->arch.init_plt_section) {
+		printk("Module doesn't contain .plt or .plt.init sections.\n");
+		return -ENOEXEC;
+	}
+
+	/* Override their sizes */
+	sechdrs[me->arch.core_plt_section].sh_size
+		= get_plt_size(hdr, sechdrs, secstrings, 0);
+	sechdrs[me->arch.init_plt_section].sh_size
+		= get_plt_size(hdr, sechdrs, secstrings, 1);
+	return 0;
 }
 
 int apply_relocate(Elf32_Shdr *sechdrs,
@@ -141,17 +148,20 @@ static inline int entry_matches(struct p
 }
 
 /* Set up a trampoline in the PLT to bounce us to the distant function */
-static uint32_t do_plt_call(void *location, Elf32_Addr val, struct module *mod)
+static uint32_t do_plt_call(void *location,
+			    Elf32_Addr val, 
+			    Elf32_Shdr *sechdrs,
+			    struct module *mod)
 {
 	struct ppc_plt_entry *entry;
 
 	DEBUGP("Doing plt for call to 0x%x at 0x%x\n", val, (unsigned int)location);
 	/* Init, or core PLT? */
 	if (location >= mod->module_core
-	    && location < mod->module_core + mod->arch.core_plt_offset)
-		entry = mod->module_core + mod->arch.core_plt_offset;
+	    && location < mod->module_core + mod->core_size)
+		entry = (void *)sechdrs[mod->arch.core_plt_section].sh_addr;
 	else
-		entry = mod->module_init + mod->arch.init_plt_offset;
+		entry = (void *)sechdrs[mod->arch.init_plt_section].sh_addr;
 
 	/* Find this entry, or if that fails, the next avail. entry */
 	while (entry->jump[0]) {
@@ -220,7 +230,8 @@ int apply_relocate_add(Elf32_Shdr *sechd
 		case R_PPC_REL24:
 			if ((int)(value - (uint32_t)location) < -0x02000000
 			    || (int)(value - (uint32_t)location) >= 0x02000000)
-				value = do_plt_call(location, value, module);
+				value = do_plt_call(location, value,
+						    sechdrs, module);
 
 			/* Only replace bits 2 through 26 */
 			DEBUGP("REL24 value = %08X. location = %08X\n",
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/s390/kernel/module.c .1000-2.5-bk-section-ordering/arch/s390/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/s390/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/s390/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -51,26 +51,15 @@ void module_free(struct module *mod, voi
            table entries. */
 }
 
-/* s390/s390x needs additional memory for GOT/PLT sections. */
-long module_core_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
 	// FIXME: add space needed for GOT/PLT
-	return module->core_size;
-}
-
-long module_init_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	return module->init_size;
+	return 0;
 }
 
-
-
 int apply_relocate(Elf_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/s390x/kernel/module.c .1000-2.5-bk-section-ordering/arch/s390x/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/s390x/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/s390x/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -52,25 +52,15 @@ void module_free(struct module *mod, voi
 }
 
 /* s390/s390x needs additional memory for GOT/PLT sections. */
-long module_core_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
 	// FIXME: add space needed for GOT/PLT
-	return module->core_size;
-}
-
-long module_init_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	return module->init_size;
+	return 0;
 }
 
-
-
 int apply_relocate(Elf_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/sparc/kernel/module.c .1000-2.5-bk-section-ordering/arch/sparc/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/sparc/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/sparc/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -37,20 +37,12 @@ void module_free(struct module *mod, voi
 }
 
 /* We don't need anything special. */
-long module_core_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	return module->core_size;
-}
-
-long module_init_size(const Elf32_Ehdr *hdr,
-		      const Elf32_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
-	return module->init_size;
+	return 0;
 }
 
 int apply_relocate(Elf32_Shdr *sechdrs,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/sparc64/kernel/module.c .1000-2.5-bk-section-ordering/arch/sparc64/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/sparc64/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/sparc64/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -144,20 +144,12 @@ void module_free(struct module *mod, voi
 }
 
 /* We don't need anything special. */
-long module_core_size(const Elf64_Ehdr *hdr,
-		      const Elf64_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	return module->core_size;
-}
-
-long module_init_size(const Elf64_Ehdr *hdr,
-		      const Elf64_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
-	return module->init_size;
+	return 0;
 }
 
 int apply_relocate(Elf64_Shdr *sechdrs,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/arch/x86_64/kernel/module.c .1000-2.5-bk-section-ordering/arch/x86_64/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/arch/x86_64/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/arch/x86_64/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
@@ -26,20 +26,12 @@
 #define DEBUGP(fmt...) 
  
 /* We don't need anything special. */
-long module_core_size(const Elf64_Ehdr *hdr,
-		      const Elf64_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
-{
-	return module->core_size;
-}
-
-long module_init_size(const Elf64_Ehdr *hdr,
-		      const Elf64_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *module)
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod)
 {
-	return module->init_size;
+	return 0;
 }
 
 int apply_relocate_add(Elf64_Shdr *sechdrs,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/include/asm-ppc/module.h .1000-2.5-bk-section-ordering/include/asm-ppc/module.h
--- .1000-2.5-bk-section-ordering.pre/include/asm-ppc/module.h	2002-11-25 08:44:17.000000000 +1100
+++ .1000-2.5-bk-section-ordering/include/asm-ppc/module.h	2003-01-02 11:12:31.000000000 +1100
@@ -18,16 +18,17 @@ struct ppc_plt_entry
 
 struct mod_arch_specific
 {
-	/* How much of the core is actually taken up with core (then
-           we know the rest is for the PLT */
-	unsigned int core_plt_offset;
-
-	/* Same for init */
-	unsigned int init_plt_offset;
+	/* Indices of PLT sections within module. */
+	unsigned int core_plt_section, init_plt_section;
 };
 
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
 
+/* Make empty sections for module_frob_arch_sections to expand. */
+#ifdef MODULE
+asm(".section .plt,\"aws\",@nobits; .align 3; .previous");
+asm(".section .plt.init,\"aws\",@nobits; .align 3; .previous");
+#endif
 #endif /* _ASM_PPC_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/include/linux/moduleloader.h .1000-2.5-bk-section-ordering/include/linux/moduleloader.h
--- .1000-2.5-bk-section-ordering.pre/include/linux/moduleloader.h	2002-11-19 09:58:51.000000000 +1100
+++ .1000-2.5-bk-section-ordering/include/linux/moduleloader.h	2003-01-02 11:12:31.000000000 +1100
@@ -15,20 +15,11 @@ unsigned long find_symbol_internal(Elf_S
 
 /* These must be implemented by the specific architecture */
 
-/* Total size to allocate for the non-releasable code; return len or
-   -error.  mod->core_size is the current generic tally. */
-long module_core_size(const Elf_Ehdr *hdr,
-		      const Elf_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *mod);
-
-/* Total size of (if any) sections to be freed after init.  Return 0
-   for none, len, or -error. mod->init_size is the current generic
-   tally. */
-long module_init_size(const Elf_Ehdr *hdr,
-		      const Elf_Shdr *sechdrs,
-		      const char *secstrings,
-		      struct module *mod);
+/* Adjust arch-specific sections.  Return 0 on success.  */
+int module_frob_arch_sections(const Elf_Ehdr *hdr,
+			      const Elf_Shdr *sechdrs,
+			      const char *secstrings,
+			      struct module *mod);
 
 /* Allocator used for allocating struct module, core sections and init
    sections.  Returns NULL on failure. */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1000-2.5-bk-section-ordering.pre/kernel/module.c .1000-2.5-bk-section-ordering/kernel/module.c
--- .1000-2.5-bk-section-ordering.pre/kernel/module.c	2003-01-02 11:12:31.000000000 +1100
+++ .1000-2.5-bk-section-ordering/kernel/module.c	2003-01-02 11:12:32.000000000 +1100
@@ -1,4 +1,5 @@
 /* Rewritten by Rusty Russell, on the backs of many others...
+   Copyright (C) 2002 Richard Henderson
    Copyright (C) 2001 Rusty Russell, 2002 Rusty Russell IBM.
 
     This program is free software; you can redistribute it and/or modify
@@ -27,6 +28,8 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/errno.h>
+#include <linux/err.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -38,6 +41,13 @@
 #define DEBUGP(fmt , a...)
 #endif
 
+#ifndef ARCH_SHF_SMALL
+#define ARCH_SHF_SMALL 0
+#endif
+
+/* If this is set, the section belongs in the init part of the module */
+#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
+
 #define symbol_is(literal, string)				\
 	(strcmp(MODULE_SYMBOL_PREFIX literal, (string)) == 0)
 
@@ -53,13 +63,6 @@ static inline int strong_try_module_get(
 	return try_module_get(mod);
 }
 
-/* Convenient structure for holding init and core sizes */
-struct sizes
-{
-	unsigned long init_size;
-	unsigned long core_size;
-};
-
 /* Stub function for modules which don't have an initfn */
 int init_module(void)
 {
@@ -764,43 +767,6 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
-/* Transfer one ELF section to the correct (init or core) area. */
-static void *copy_section(const char *name,
-			  void *base,
-			  Elf_Shdr *sechdr,
-			  struct module *mod,
-			  struct sizes *used)
-{
-	void *dest;
-	unsigned long *use;
-	unsigned long max;
-
-	/* Only copy to init section if there is one */
-	if (strstr(name, ".init") && mod->module_init) {
-		dest = mod->module_init;
-		use = &used->init_size;
-		max = mod->init_size;
-	} else {
-		dest = mod->module_core;
-		use = &used->core_size;
-		max = mod->core_size;
-	}
-
-	/* Align up */
-	*use = ALIGN(*use, sechdr->sh_addralign);
-	dest += *use;
-	*use += sechdr->sh_size;
-
-	if (*use > max)
-		return ERR_PTR(-ENOEXEC);
-
-	/* May not actually be in the file (eg. bss). */
-	if (sechdr->sh_type != SHT_NOBITS)
-		memcpy(dest, base + sechdr->sh_offset, sechdr->sh_size);
-
-	return dest;
-}
-
 /* Deal with the given section */
 static int handle_section(const char *name,
 			  Elf_Shdr *sechdrs,
@@ -902,33 +868,66 @@ static int simplify_symbols(Elf_Shdr *se
 	return 0;
 }
 
-/* Get the total allocation size of the init and non-init sections */
-static struct sizes get_sizes(const Elf_Ehdr *hdr,
-			      const Elf_Shdr *sechdrs,
-			      const char *secstrings)
+/* Update size with this section: return offset. */
+static long get_offset(unsigned long *size, Elf_Shdr *sechdr)
 {
-	struct sizes ret = { 0, 0 };
-	unsigned i;
+	long ret;
 
-	/* Everything marked ALLOC (this includes the exported
-           symbols) */
-	for (i = 1; i < hdr->e_shnum; i++) {
-		unsigned long *add;
+	ret = ALIGN(*size, sechdr->sh_addralign ?: 1);
+	*size = ret + sechdr->sh_size;
+	return ret;
+}
 
-		/* If it's called *.init*, and we're init, we're interested */
-		if (strstr(secstrings + sechdrs[i].sh_name, ".init") != 0)
-			add = &ret.init_size;
-		else
-			add = &ret.core_size;
+/* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
+   might -- code, read-only data, read-write data, small data.  Tally
+   sizes, and place the offsets into sh_link fields: high bit means it
+   belongs in init. */
+static void layout_sections(struct module *mod,
+			    const Elf_Ehdr *hdr,
+			    Elf_Shdr *sechdrs,
+			    const char *secstrings)
+{
+	static unsigned long const masks[][2] = {
+		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
+		{ SHF_ALLOC, SHF_WRITE | ARCH_SHF_SMALL },
+		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
+		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 }
+	};
+	unsigned int m, i;
 
-		if (sechdrs[i].sh_flags & SHF_ALLOC) {
-			/* Pad up to required alignment */
-			*add = ALIGN(*add, sechdrs[i].sh_addralign ?: 1);
-			*add += sechdrs[i].sh_size;
+	for (i = 0; i < hdr->e_shnum; i++)
+		sechdrs[i].sh_link = ~0UL;
+
+	DEBUGP("Core section allocation order:\n");
+	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
+		for (i = 0; i < hdr->e_shnum; ++i) {
+			Elf_Shdr *s = &sechdrs[i];
+
+			if ((s->sh_flags & masks[m][0]) != masks[m][0]
+			    || (s->sh_flags & masks[m][1])
+			    || s->sh_link != ~0UL
+			    || strstr(secstrings + s->sh_name, ".init"))
+				continue;
+			s->sh_link = get_offset(&mod->core_size, s);
+			DEBUGP("\t%s\n", name);
 		}
 	}
 
-	return ret;
+	DEBUGP("Init section allocation order:\n");
+	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
+		for (i = 0; i < hdr->e_shnum; ++i) {
+			Elf_Shdr *s = &sechdrs[i];
+
+			if ((s->sh_flags & masks[m][0]) != masks[m][0]
+			    || (s->sh_flags & masks[m][1])
+			    || s->sh_link != ~0UL
+			    || !strstr(secstrings + s->sh_name, ".init"))
+				continue;
+			s->sh_link = (get_offset(&mod->init_size, s)
+				      | INIT_OFFSET_MASK);
+			DEBUGP("\t%s\n", name);
+		}
+	}
 }
 
 /* Allocate and load the module */
@@ -942,7 +941,6 @@ static struct module *load_module(void *
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
 		modindex, obsparmindex;
 	long arglen;
-	struct sizes sizes, used;
 	struct module *mod;
 	long err = 0;
 	void *ptr = NULL; /* Stops spurious gcc uninitialized warning */
@@ -1063,23 +1061,15 @@ static struct module *load_module(void *
 
 	mod->state = MODULE_STATE_COMING;
 
-	/* How much space will we need? */
-	sizes = get_sizes(hdr, sechdrs, secstrings);
-
-	/* Set these up, and allow archs to manipulate them. */
-	mod->core_size = sizes.core_size;
-	mod->init_size = sizes.init_size;
-
-	/* Allow archs to add to them. */
-	err = module_init_size(hdr, sechdrs, secstrings, mod);
+	/* Allow arches to frob section contents and sizes.  */
+	err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
 	if (err < 0)
 		goto free_mod;
-	mod->init_size = err;
 
-	err = module_core_size(hdr, sechdrs, secstrings, mod);
-	if (err < 0)
-		goto free_mod;
-	mod->core_size = err;
+	/* Determine total sizes, and put offsets in sh_link.  For now
+	   this is done generically; there doesn't appear to be any
+	   special cases for the architectures. */
+	layout_sections(mod, hdr, sechdrs, secstrings);
 
 	/* Do the allocs. */
 	ptr = module_alloc(mod->core_size);
@@ -1098,25 +1088,27 @@ static struct module *load_module(void *
 	memset(ptr, 0, mod->init_size);
 	mod->module_init = ptr;
 
-	/* Transfer each section which requires ALLOC, and set sh_addr
-	   fields to absolute addresses. */
-	used.core_size = 0;
-	used.init_size = 0;
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (sechdrs[i].sh_flags & SHF_ALLOC) {
-			ptr = copy_section(secstrings + sechdrs[i].sh_name,
-					   hdr, &sechdrs[i], mod, &used);
-			if (IS_ERR(ptr))
-				goto cleanup;
-			sechdrs[i].sh_addr = (unsigned long)ptr;
-			/* Have we just copied __this_module across? */ 
-			if (i == modindex)
-				mod = ptr;
-		}
+	/* Transfer each section which specifies SHF_ALLOC */
+	for (i = 0; i < hdr->e_shnum; i++) {
+		void *dest;
+
+		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
+			continue;
+
+		if (sechdrs[i].sh_link & INIT_OFFSET_MASK)
+			dest = mod->module_init
+				+ (sechdrs[i].sh_link & ~INIT_OFFSET_MASK);
+		else
+			dest = mod->module_core + sechdrs[i].sh_link;
+
+		if (sechdrs[i].sh_type != SHT_NOBITS)
+			memcpy(dest, (void *)sechdrs[i].sh_addr,
+			       sechdrs[i].sh_size);
+		/* Update sh_addr to point to copy in image. */
+		sechdrs[i].sh_addr = (unsigned long)dest;
 	}
-	/* Don't use more than we allocated! */
-	if (used.init_size > mod->init_size || used.core_size > mod->core_size)
-		BUG();
+	/* Module has been moved. */
+	mod = (void *)sechdrs[modindex].sh_addr;
 
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
