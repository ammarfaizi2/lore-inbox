Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTANIcS>; Tue, 14 Jan 2003 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbTANIbd>; Tue, 14 Jan 2003 03:31:33 -0500
Received: from dp.samba.org ([66.70.73.150]:23698 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261724AbTANIbT>;
	Tue, 14 Jan 2003 03:31:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling 
In-reply-to: Your message of "Mon, 13 Jan 2003 11:00:36 -0800."
             <20030113110036.A873@twiddle.net> 
Date: Tue, 14 Jan 2003 19:39:44 +1100
Message-Id: <20030114084011.53EA32C455@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113110036.A873@twiddle.net> you write:
> I discovered this while working on oprofile for Alpha.  I thought
> I'd avoid a whole series of nested ifdefs by marking some symbols
> weak, and so let them go undefined and resolve to null.  Except 
> that we don't handle that in the new module loader.
> 
> Fixed thus.

After that's reverted, here's my implementation.  Richard?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Weak Symbol Support
Author: Richard Henderson
Status: Tested on 2.5.58
Depends: Module/revert-rth.patch.gz

D: This is Rusty's cut-down version of Richard's Weak Symbol Support
D: patch.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/linux/moduleloader.h .22700-2.5.58-weak/include/linux/moduleloader.h
--- .22700-2.5.58-weak.pre/include/linux/moduleloader.h	2003-01-14 19:36:43.000000000 +1100
+++ .22700-2.5.58-weak/include/linux/moduleloader.h	2003-01-14 19:37:16.000000000 +1100
@@ -6,12 +6,9 @@
 #include <linux/elf.h>
 
 /* Helper function for arch-specific module loaders */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **group);
+unsigned long module_find_symbol(const char *name,
+				 struct module *mod,
+				 struct kernel_symbol_group **group);
 
 /* These must be implemented by the specific architecture */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/kernel/module.c .22700-2.5.58-weak/kernel/module.c
--- .22700-2.5.58-weak.pre/kernel/module.c	2003-01-14 19:36:43.000000000 +1100
+++ .22700-2.5.58-weak/kernel/module.c	2003-01-14 19:37:16.000000000 +1100
@@ -724,20 +724,12 @@ static int obsolete_params(const char *n
 
 /* Find an symbol for this module (ie. resolve internals first).
    It we find one, record usage.  Must be holding module_mutex. */
-unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
-				   unsigned int symindex,
-				   const char *strtab,
-				   const char *name,
-				   struct module *mod,
-				   struct kernel_symbol_group **ksg)
+unsigned long module_find_symbol(const char *name,
+				 struct module *mod,
+				 struct kernel_symbol_group **ksg)
 {
 	unsigned long ret;
 
-	ret = find_local_symbol(sechdrs, symindex, strtab, name);
-	if (ret) {
-		*ksg = NULL;
-		return ret;
-	}
 	/* Look in other modules... */
 	spin_lock_irq(&modlist_lock);
 	ret = __find_symbol(name, ksg, mod->license_gplok);
@@ -833,14 +825,12 @@ static int simplify_symbols(Elf_Shdr *se
 			    struct module *mod)
 {
 	unsigned int i;
-	Elf_Sym *sym;
+	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
+	const char *strtab = (char *)sechdrs[strindex].sh_addr;
+	struct kernel_symbol_group *ksg;
 
-	/* First simplify defined symbols, so if they become the
-           "answer" to undefined symbols, copying their st_value us
-           correct. */
-	for (sym = (void *)sechdrs[symindex].sh_addr, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
+	/* Set st_value on all symbols to its address. */
+	for (i = 0; i < sechdrs[symindex].sh_size / sizeof(Elf_Sym); i++) {
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* We compiled with -fno-common.  These are not
@@ -855,36 +845,35 @@ static int simplify_symbols(Elf_Shdr *se
 			break;
 
 		case SHN_UNDEF:
+			sym[i].st_value
+				= module_find_symbol(strtab + sym[i].st_name,
+						     mod, &ksg);
+			/* Don't barf here if not found: some archs
+			   (ie. ppc64) can handle this. */
 			break;
 
 		default:
+			/* If it's weak, other modules can override. */
+			if (ELF_ST_BIND(sym[i].st_info) == STB_WEAK) {
+				unsigned long strongsym;
+
+				strongsym = module_find_symbol(strtab
+							       +sym[i].st_name,
+							       mod, &ksg);
+				if (strongsym) {
+					sym[i].st_name = SHN_UNDEF;
+					sym[i].st_value = strongsym;
+					break;
+				}
+			}
+
 			sym[i].st_value 
 				= (unsigned long)
 				(sechdrs[sym[i].st_shndx].sh_addr
 				 + sym[i].st_value);
+			break;
 		}
 	}
-
-	/* Now try to resolve undefined symbols */
-	for (sym = (void *)sechdrs[symindex].sh_addr, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
-		if (sym[i].st_shndx == SHN_UNDEF) {
-			/* Look for symbol */
-			struct kernel_symbol_group *ksg = NULL;
-			const char *strtab 
-				= (char *)sechdrs[strindex].sh_addr;
-
-			sym[i].st_value
-				= find_symbol_internal(sechdrs,
-						       symindex,
-						       strtab,
-						       strtab + sym[i].st_name,
-						       mod,
-						       &ksg);
-		}
-	}
-
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-alpha/module.h .22700-2.5.58-weak/include/asm-alpha/module.h
--- .22700-2.5.58-weak.pre/include/asm-alpha/module.h	2003-01-10 10:55:43.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-alpha/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -13,6 +13,7 @@ struct mod_arch_specific
 #define Elf_Dyn Elf64_Dyn
 #define Elf_Rel Elf64_Rel
 #define Elf_Rela Elf64_Rela
+#define ELF_ST_BIND(info) ELF64_ST_BIND(info)
 
 #define ARCH_SHF_SMALL SHF_ALPHA_GPREL
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-arm/module.h .22700-2.5.58-weak/include/asm-arm/module.h
--- .22700-2.5.58-weak.pre/include/asm-arm/module.h	2003-01-02 12:36:07.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-arm/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -9,5 +9,6 @@ struct mod_arch_specific
 #define Elf_Shdr	Elf32_Shdr
 #define Elf_Sym		Elf32_Sym
 #define Elf_Ehdr	Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 
 #endif /* _ASM_ARM_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-i386/module.h .22700-2.5.58-weak/include/asm-i386/module.h
--- .22700-2.5.58-weak.pre/include/asm-i386/module.h	2003-01-02 12:35:14.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-i386/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -8,4 +8,5 @@ struct mod_arch_specific
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 #endif /* _ASM_I386_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-m68k/module.h .22700-2.5.58-weak/include/asm-m68k/module.h
--- .22700-2.5.58-weak.pre/include/asm-m68k/module.h	2003-01-02 14:48:00.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-m68k/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -4,4 +4,5 @@ struct mod_arch_specific { };
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 #endif /* _ASM_M68K_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-parisc/module.h .22700-2.5.58-weak/include/asm-parisc/module.h
--- .22700-2.5.58-weak.pre/include/asm-parisc/module.h	2003-01-14 17:25:27.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-parisc/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -7,10 +7,12 @@
 #define Elf_Shdr Elf64_Shdr
 #define Elf_Sym Elf64_Sym
 #define Elf_Ehdr Elf64_Ehdr
+#define ELF_ST_BIND(info) ELF64_ST_BIND(info)
 #else
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 #endif
 
 #define module_map(x)		vmalloc(x)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-ppc/module.h .22700-2.5.58-weak/include/asm-ppc/module.h
--- .22700-2.5.58-weak.pre/include/asm-ppc/module.h	2003-01-10 10:55:43.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-ppc/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -25,6 +25,7 @@ struct mod_arch_specific
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 
 /* Make empty sections for module_frob_arch_sections to expand. */
 #ifdef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-s390/module.h .22700-2.5.58-weak/include/asm-s390/module.h
--- .22700-2.5.58-weak.pre/include/asm-s390/module.h	2003-01-02 12:36:07.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-s390/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -22,4 +22,5 @@ struct mod_arch_specific
 #define Elf_Sym ElfW(Sym)
 #define Elf_Ehdr ElfW(Ehdr)
 #define ELF_R_TYPE ELFW(R_TYPE)
+#define ELF_ST_BIND(info) ELFW(_ST_BIND)(info)
 #endif /* _ASM_S390_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-s390x/module.h .22700-2.5.58-weak/include/asm-s390x/module.h
--- .22700-2.5.58-weak.pre/include/asm-s390x/module.h	2003-01-02 12:36:08.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-s390x/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -22,4 +22,5 @@ struct mod_arch_specific
 #define Elf_Sym ElfW(Sym)
 #define Elf_Ehdr ElfW(Ehdr)
 #define ELF_R_TYPE ELFW(R_TYPE)
+#define ELF_ST_BIND(info) ELFW(_ST_BIND)(info)
 #endif /* _ASM_S390_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-sparc/module.h .22700-2.5.58-weak/include/asm-sparc/module.h
--- .22700-2.5.58-weak.pre/include/asm-sparc/module.h	2003-01-02 12:35:14.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-sparc/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -4,4 +4,5 @@ struct mod_arch_specific { };
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 #endif /* _ASM_SPARC_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-sparc64/module.h .22700-2.5.58-weak/include/asm-sparc64/module.h
--- .22700-2.5.58-weak.pre/include/asm-sparc64/module.h	2003-01-02 12:35:14.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-sparc64/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -4,4 +4,5 @@ struct mod_arch_specific { };
 #define Elf_Shdr Elf64_Shdr
 #define Elf_Sym Elf64_Sym
 #define Elf_Ehdr Elf64_Ehdr
+#define ELF_ST_BIND(info) ELF64_ST_BIND(info)
 #endif /* _ASM_SPARC64_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-v850/module.h .22700-2.5.58-weak/include/asm-v850/module.h
--- .22700-2.5.58-weak.pre/include/asm-v850/module.h	2003-01-14 10:13:08.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-v850/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -34,6 +34,7 @@ struct mod_arch_specific
 #define Elf_Shdr Elf32_Shdr
 #define Elf_Sym Elf32_Sym
 #define Elf_Ehdr Elf32_Ehdr
+#define ELF_ST_BIND(info) ELF32_ST_BIND(info)
 
 /* Make empty sections for module_frob_arch_sections to expand. */
 #ifdef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22700-2.5.58-weak.pre/include/asm-x86_64/module.h .22700-2.5.58-weak/include/asm-x86_64/module.h
--- .22700-2.5.58-weak.pre/include/asm-x86_64/module.h	2003-01-02 12:47:04.000000000 +1100
+++ .22700-2.5.58-weak/include/asm-x86_64/module.h	2003-01-14 19:37:16.000000000 +1100
@@ -6,5 +6,6 @@ struct mod_arch_specific {}; 
 #define Elf_Shdr Elf64_Shdr
 #define Elf_Sym Elf64_Sym
 #define Elf_Ehdr Elf64_Ehdr
+#define ELF_ST_BIND(info) ELF64_ST_BIND(info)
 
 #endif 
