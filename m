Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTA1KbV>; Tue, 28 Jan 2003 05:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTA1KbU>; Tue, 28 Jan 2003 05:31:20 -0500
Received: from dp.samba.org ([66.70.73.150]:20138 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265063AbTA1KbP>;
	Tue, 28 Jan 2003 05:31:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [RFC] [PATCH] new modversions implementation 
In-reply-to: Your message of "Sat, 25 Jan 2003 12:44:39 MDT."
             <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu> 
Date: Tue, 28 Jan 2003 21:38:31 +1100
Message-Id: <20030128104035.68A742C2DC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu> you write:
> A kernel built with CONFIG_MODVERSIONING will continue to work fine with
> unpatched module-init-tools, however, forcing the load of a module
> with mismatched symbol versions will need a small patch to 
> module-init-tools.
> 
> Comments, testing or other feedback are much appreciated ;)

Well done Kai!

	But once again you are relying on link order to keep the crcs
section in the same order as the ksymtab section (although the ld
documentation says that's correct, I know RTH doesn't like it).  I put
the CRC inside the symbol unconditionally, making for 6k (or 12k on
64-bit) of bloat, which I'm not happy with, either.

	I'd recommend changing the name back to CONFIG_MODVERSIONS: I
invented CONFIG_MODVERSIONING because I didn't want to rip the old
stuff out of the makefiles 8) Keep the name the same, and users
migrating from 2.4 won't get asked the question again.

	I like the SHF_ALLOC tweak for --force, BTW: it's in the fresh
0.9.9-pre.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Tweaks to Module Versions
Author: Rusty Russell
Depends: Module/modversions.patch.gz
Status: Tested on 2.5.59

D: Put crc values into exported symbol structure, rather than relying
D: on link order.  Also fixes up help message for
D: CONFIG_MODVERSIONING, and only prints an error the first time the
D: kernel is tainted.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24463-2.5.59-modversions2.pre/include/asm-generic/vmlinux.lds.h .24463-2.5.59-modversions2/include/asm-generic/vmlinux.lds.h
--- .24463-2.5.59-modversions2.pre/include/asm-generic/vmlinux.lds.h	2003-01-28 21:29:55.000000000 +1100
+++ .24463-2.5.59-modversions2/include/asm-generic/vmlinux.lds.h	2003-01-28 21:29:57.000000000 +1100
@@ -26,20 +26,6 @@
 		__stop___ksymtab_gpl = .;				\
 	}								\
 									\
-	/* Kernel symbol table: Normal symbols */			\
-	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
-		__start___kcrctab = .;					\
-		*(__kcrctab)						\
-		__stop___kcrctab = .;					\
-	}								\
-									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
-		*(__kcrctab_gpl)					\
-		__stop___kcrctab_gpl = .;				\
-	}								\
-									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24463-2.5.59-modversions2.pre/include/linux/module.h .24463-2.5.59-modversions2/include/linux/module.h
--- .24463-2.5.59-modversions2.pre/include/linux/module.h	2003-01-28 21:29:56.000000000 +1100
+++ .24463-2.5.59-modversions2/include/linux/module.h	2003-01-28 21:29:57.000000000 +1100
@@ -38,6 +38,9 @@ struct kernel_symbol
 {
 	unsigned long value;
 	const char *name;
+	/* This is here unconditionally, so versioned modules can
+           easily be used in non-versioned kernels and vice-versa. */
+	unsigned long crc;
 };
 
 struct modversion_info
@@ -126,7 +129,6 @@ struct kernel_symbol_group
 
 	unsigned int num_syms;
 	const struct kernel_symbol *syms;
-	const unsigned long *crcs;
 };
 
 /* Given an address, look for it in the exception tables */
@@ -153,29 +155,26 @@ void *__symbol_get_gpl(const char *symbo
 /* genksyms doesn't handle GPL-only symbols yet */
 #define EXPORT_SYMBOL_GPL EXPORT_SYMBOL
 	
-#else
+#else /* ... !__GENKSYMS__ */
 
 #ifdef CONFIG_MODVERSIONING
-/* Mark the CRC weak since genksyms apparently decides not to
- * generate a checksums for some symbols */
-#define __CRC_SYMBOL(sym, sec)					\
-	extern void *__crc_##sym __attribute__((weak));		\
-	static const unsigned long __kcrctab_##sym		\
-	__attribute__((section("__kcrctab" sec)))		\
-	= (unsigned long) &__crc_##sym;
+/* This "address" is really the crc itself, and generated by the linker. */
+#define __CRC_SYMBOL(sym) ((unsigned long)&__crc_##sym)
 #else
-#define __CRC_SYMBOL(sym, sec)
+#define __CRC_SYMBOL(sym) NULL
 #endif
 
 /* For every exported symbol, place a struct in the __ksymtab section */
-#define __EXPORT_SYMBOL(sym, sec)				\
-	__CRC_SYMBOL(sym, sec)					\
-	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
-	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab" sec)))		\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+/* Mark the CRC weak since genksyms apparently decides not to generate
+   a checksums for some symbols */
+#define __EXPORT_SYMBOL(sym, sec)					\
+	extern unsigned long __crc_##sym __attribute__((weak));		\
+	static const char __kstrtab_##sym[]				\
+	__attribute__((section("__ksymtab_strings")))			\
+	= MODULE_SYMBOL_PREFIX #sym;					\
+	static const struct kernel_symbol __ksymtab_##sym		\
+	__attribute__((section("__ksymtab" sec)))			\
+	= { (unsigned long)&sym, __kstrtab_##sym, __CRC_SYMBOL(sym) }
 
 #define EXPORT_SYMBOL(sym)					\
 	__EXPORT_SYMBOL(sym, "")
@@ -183,7 +182,7 @@ void *__symbol_get_gpl(const char *symbo
 #define EXPORT_SYMBOL_GPL(sym)					\
 	__EXPORT_SYMBOL(sym, "_gpl")
 
-#endif
+#endif /* __GENKSYMS__ */
 
 /* We don't mangle the actual symbol anymore, so no need for
  * special casing EXPORT_SYMBOL_NOVERS */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24463-2.5.59-modversions2.pre/init/Kconfig .24463-2.5.59-modversions2/init/Kconfig
--- .24463-2.5.59-modversions2.pre/init/Kconfig	2003-01-28 21:29:55.000000000 +1100
+++ .24463-2.5.59-modversions2/init/Kconfig	2003-01-28 21:29:57.000000000 +1100
@@ -147,7 +147,6 @@ config OBSOLETE_MODPARM
 config MODVERSIONING
 	bool "Module versioning support (EXPERIMENTAL)"
 	depends on MODULES && EXPERIMENTAL
-	help
 	---help---
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24463-2.5.59-modversions2.pre/kernel/module.c .24463-2.5.59-modversions2/kernel/module.c
--- .24463-2.5.59-modversions2.pre/kernel/module.c	2003-01-28 21:29:56.000000000 +1100
+++ .24463-2.5.59-modversions2/kernel/module.c	2003-01-28 21:29:57.000000000 +1100
@@ -729,44 +729,40 @@ static int obsolete_params(const char *n
 static int check_version(Elf_Shdr *sechdrs,
 			 unsigned int versindex,
 			 const char *symname,
-			 struct module *mod, 
-			 struct kernel_symbol_group *ksg,
-			 unsigned int symidx)
+			 struct module *mod,
+			 const struct kernel_symbol *ksym)
 {
-	unsigned long crc;
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
 
-	if (!ksg->crcs) { 
-		printk("%s: no CRC for \"%s\" [%s] found: kernel tainted.\n",
-		       mod->name, symname, 
-		       ksg->owner ? ksg->owner->name : "kernel");
-		goto taint;
+	/* Doesn't need a version?  OK. */
+	if (!ksym->crc) {
+		DEBUGP("Symbol name %s has no crc\n", symname);
+		return 1;
 	}
 
-	crc = ksg->crcs[symidx];
-
-	versions = (void *) sechdrs[versindex].sh_addr;
-	num_versions = sechdrs[versindex].sh_size
-		/ sizeof(struct modversion_info);
+	versions = (struct modversion_info *)sechdrs[versindex].sh_addr;
+	num_versions = sechdrs[versindex].sh_size/sizeof(versions[0]);
 
 	for (i = 0; i < num_versions; i++) {
 		if (strcmp(versions[i].name, symname) != 0)
 			continue;
 
-		if (versions[i].crc == crc)
+		if (versions[i].crc == ksym->crc)
 			return 1;
 		printk("%s: disagrees about version of symbol %s\n",
 		       mod->name, symname);
 		DEBUGP("Found checksum %lX vs module %lX\n",
-		       crc, versions[i].crc);
+		       ksym->crc, versions[i].crc);
 		return 0;
 	}
+
 	/* Not in module's version table.  OK, but that taints the kernel. */
-	printk("%s: no version for \"%s\" found: kernel tainted.\n",
-	       mod->name, symname);
- taint:
-	tainted |= TAINT_FORCED_MODULE;
+	if (!(tainted & TAINT_FORCED_MODULE)) {
+		printk("%s: no version for \"%s\" found: kernel tainted.\n",
+		       mod->name, symname);
+		tainted |= TAINT_FORCED_MODULE;
+	}
 	return 1;
 }
 #else
@@ -774,8 +770,7 @@ static inline int check_version(Elf_Shdr
 				unsigned int versindex,
 				const char *symname,
 				struct module *mod, 
-				struct kernel_symbol_group *ksg,
-				unsigned int symidx)
+				const struct kernel_symbol *ksym)
 {
 	return 1;
 }
@@ -795,10 +790,12 @@ static unsigned long resolve_symbol(Elf_
 	spin_lock_irq(&modlist_lock);
 	ret = __find_symbol(name, &ksg, &symidx, mod->license_gplok);
 	if (ret) {
+		DEBUGP("Found symbol %i in ksg %p (owner %s)\n",
+		       symidx, ksg, module_name(ksg->owner));
 		/* use_module can fail due to OOM, or module unloading */
 		if (!check_version(sechdrs, versindex, name, mod,
-				   ksg, symidx) ||
-		    !use_module(mod, ksg->owner))
+				   &ksg->syms[symidx])
+		    || !use_module(mod, ksg->owner))
 			ret = 0;
 	}
 	spin_unlock_irq(&modlist_lock);
@@ -1141,20 +1138,23 @@ static struct module *load_module(void *
 			licenseindex = i;
 			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__vermagic") == 0 &&
-			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
+				  "__vermagic") == 0
+			   && (sechdrs[i].sh_flags & SHF_ALLOC)) {
 			/* Version magic. */
 			DEBUGP("Version magic found in section %u\n", i);
 			vmagindex = i;
 			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__versions") == 0 &&
-			   (sechdrs[i].sh_flags & SHF_ALLOC)) {
-			/* Module version info (both exported and needed) */
+		}
+
+#ifdef CONFIG_MODVERSIONING
+		if (strcmp(secstrings+sechdrs[i].sh_name, "__versions") == 0
+		    && (sechdrs[i].sh_flags & SHF_ALLOC)) {
+			/* Module version info (for needed symbols) */
 			DEBUGP("Versions found in section %u\n", i);
 			versindex = i;
 			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 		}
+#endif /* CONFIG_MODVERSIONING */
 #ifdef CONFIG_KALLSYMS
 		/* symbol and string tables for decoding later. */
 		if (sechdrs[i].sh_type == SHT_SYMTAB || i == strindex)
@@ -1174,12 +1174,15 @@ static struct module *load_module(void *
 	}
 	mod = (void *)sechdrs[modindex].sh_addr;
 
-	/* This is allowed: modprobe --force will invalidate it. */
+	/* This is allowed: modprobe --force will invalidate it.
+           Otherwise, if versindex is set, module symbole versions are
+           used instead. */
 	if (!vmagindex) {
 		tainted |= TAINT_FORCED_MODULE;
 		printk(KERN_WARNING "%s: no version magic, tainting kernel.\n",
 		       mod->name);
-	} else if (strcmp((char *)sechdrs[vmagindex].sh_addr, vermagic) != 0) {
+	} else if (strcmp((char *)sechdrs[vmagindex].sh_addr, vermagic) != 0
+		   && !versindex) {
 		printk(KERN_ERR "%s: version magic '%s' should be '%s'\n",
 		       mod->name, (char*)sechdrs[vmagindex].sh_addr, vermagic);
 		err = -ENOEXEC;
@@ -1273,11 +1276,9 @@ static struct module *load_module(void *
 	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
 				 / sizeof(*mod->symbols.syms));
 	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
-	mod->symbols.crcs = (void *)sechdrs[crcindex].sh_addr;
 	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
 				 / sizeof(*mod->symbols.syms));
 	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
-	mod->gpl_symbols.crcs = (void *)sechdrs[gplcrcindex].sh_addr;
 
 	/* Set up exception table */
 	if (exindex) {
@@ -1580,10 +1581,6 @@ extern const struct kernel_symbol __star
 extern const struct kernel_symbol __stop___ksymtab[];
 extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
-extern const unsigned long __start___kcrctab[];
-extern const unsigned long __stop___kcrctab[];
-extern const unsigned long __start___kcrctab_gpl[];
-extern const unsigned long __stop___kcrctab_gpl[];
 
 static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;
 
@@ -1592,14 +1589,12 @@ static int __init symbols_init(void)
 	/* Add kernel symbols to symbol table */
 	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
 	kernel_symbols.syms = __start___ksymtab;
-	kernel_symbols.crcs = __start___kcrctab;
 	kernel_symbols.gplonly = 0;
 	list_add(&kernel_symbols.list, &symbols);
 
 	kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
 				       - __start___ksymtab_gpl);
 	kernel_gpl_symbols.syms = __start___ksymtab_gpl;
-	kernel_gpl_symbols.crcs = __start___kcrctab_gpl;
 	kernel_gpl_symbols.gplonly = 1;
 	list_add(&kernel_gpl_symbols.list, &symbols);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24463-2.5.59-modversions2.pre/scripts/Makefile.build .24463-2.5.59-modversions2/scripts/Makefile.build
--- .24463-2.5.59-modversions2.pre/scripts/Makefile.build	2003-01-28 21:29:56.000000000 +1100
+++ .24463-2.5.59-modversions2/scripts/Makefile.build	2003-01-28 21:29:57.000000000 +1100
@@ -73,7 +73,7 @@ ifdef CONFIG_MODVERSIONING
 #   are done.
 # o otherwise, we calculate symbol versions using the good old
 #   genksyms on the preprocessed source and postprocess them in a way
-#   that they are usable as a linker script
+#   that they are usable as a linker script (replacing 0 crcs with 1).
 # o generate <file>.o from .tmp_<file>.o using the linker to
 #   replace the unresolved symbols __crc_exported_symbol with
 #   the actual value of the checksum generated by genksyms
@@ -92,6 +92,7 @@ define rule_vcc_o_c
 		| $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)	      \
 		| grep __ver						      \
 		| sed 's/\#define __ver_\([^ 	]*\)[ 	]*\([^ 	]*\)/__crc_\1 = 0x\2 ;/g' \
+		| sed 's/\(0x[0]*\)0 ;/\11 ;/'				      \
 		> $(@D)/.tmp_$(@F:.o=.ver);				      \
 									      \
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		      \
