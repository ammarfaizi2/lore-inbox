Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbTC0EBt>; Wed, 26 Mar 2003 23:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTC0EBt>; Wed, 26 Mar 2003 23:01:49 -0500
Received: from dp.samba.org ([66.70.73.150]:58049 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262802AbTC0EBg>;
	Wed, 26 Mar 2003 23:01:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor module cleanup 2/3
Date: Thu, 27 Mar 2003 15:12:27 +1100
Message-Id: <20030327041250.34C162C050@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This removes the separate symbol list: it has a 1:1 mapping with the
module list anyway.

[ This is made trivial by the fact that noone accesses this list from
  outside module.c any more. ]

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Symbol list removal
Author: Rusty Russell
Status: Tested on 2.5.66-bk2
Depends: Module/module-text-address.patch.gz

D: This removes the symbol list, and the concept of kernel symbol groups,
D: in favour of just iterating through the modules.  Now all iteration is
D: within kernel/module.c, this is a fairly trivial cleanup.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21809-linux-2.5.61-bk1/include/linux/module.h .21809-linux-2.5.61-bk1.updated/include/linux/module.h
--- .21809-linux-2.5.61-bk1/include/linux/module.h	2003-02-17 15:47:09.000000000 +1100
+++ .21809-linux-2.5.61-bk1.updated/include/linux/module.h	2003-02-17 15:47:42.000000000 +1100
@@ -115,22 +115,6 @@ extern const struct gtype##_id __mod_##g
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
 
-struct kernel_symbol_group
-{
-	/* Links us into the global symbol list */
-	struct list_head list;
-
-	/* Module which owns it (if any) */
-	struct module *owner;
-
-	/* Are we internal use only? */
-	int gplonly;
-
-	unsigned int num_syms;
-	const struct kernel_symbol *syms;
-	const unsigned long *crcs;
-};
-
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
 
@@ -214,10 +198,14 @@ struct module
 	char name[MODULE_NAME_LEN];
 
 	/* Exported symbols */
-	struct kernel_symbol_group symbols;
+	const struct kernel_symbol *syms;
+	unsigned int num_ksyms;
+	const unsigned long *crcs;
 
 	/* GPL-only exported symbols. */
-	struct kernel_symbol_group gpl_symbols;
+	const struct kernel_symbol *gpl_syms;
+	unsigned int num_gpl_syms;
+	const unsigned long *gpl_crcs;
 
 	/* Exception tables */
 	struct exception_table extable;
@@ -411,8 +399,6 @@ extern struct module __this_module;
 struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
 	.name = __stringify(KBUILD_MODNAME),
-	.symbols = { .owner = &__this_module },
-	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
 	.init = init_module,
 #ifdef CONFIG_MODULE_UNLOAD
 	.exit = cleanup_module,
@@ -472,14 +458,6 @@ static inline void __deprecated _MOD_INC
 #define EXPORT_NO_SYMBOLS
 #define __MODULE_STRING(x) __stringify(x)
 
-/*
- * The exception and symbol tables, and the lock
- * to protect them.
- */
-extern spinlock_t modlist_lock;
-extern struct list_head extables;
-extern struct list_head symbols;
-
 /* Use symbol_get and symbol_put instead.  You'll thank me. */
 #define HAVE_INTER_MODULE
 extern void inter_module_register(const char *, struct module *, const void *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21809-linux-2.5.61-bk1/kernel/module.c .21809-linux-2.5.61-bk1.updated/kernel/module.c
--- .21809-linux-2.5.61-bk1/kernel/module.c	2003-02-17 15:47:09.000000000 +1100
+++ .21809-linux-2.5.61-bk1.updated/kernel/module.c	2003-02-17 15:48:45.000000000 +1100
@@ -58,7 +58,6 @@ static spinlock_t modlist_lock = SPIN_LO
 /* List of modules, protected by module_mutex AND modlist_lock */
 static DECLARE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
-static LIST_HEAD(symbols);
 static LIST_HEAD(extables);
 
 /* We require a truly strong try_module_get() */
@@ -76,25 +75,60 @@ int init_module(void)
 }
 EXPORT_SYMBOL(init_module);
 
-/* Find a symbol, return value and the symbol group */
+/* Provided by the linker */
+extern const struct kernel_symbol __start___ksymtab[];
+extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start___ksymtab_gpl[];
+extern const struct kernel_symbol __stop___ksymtab_gpl[];
+extern const unsigned long __start___kcrctab[];
+extern const unsigned long __start___kcrctab_gpl[];
+
+#ifndef CONFIG_MODVERSIONS
+#define symversion(base, idx) NULL
+#else
+#define symversion(base, idx) ((base) ? ((base) + (idx)) : NULL)
+#endif
+
+/* Find a symbol, return value, crc and module which owns it */
 static unsigned long __find_symbol(const char *name,
-				   struct kernel_symbol_group **group,
-				   unsigned int *symidx,
+				   struct module **owner,
+				   const unsigned long **crc,
 				   int gplok)
 {
-	struct kernel_symbol_group *ks;
- 
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
+	struct module *mod;
+	unsigned int i;
 
-		if (ks->gplonly && !gplok)
-			continue;
-		for (i = 0; i < ks->num_syms; i++) {
-			if (strcmp(ks->syms[i].name, name) == 0) {
-				*group = ks;
-				if (symidx)
-					*symidx = i;
-				return ks->syms[i].value;
+	/* Core kernel first. */ 
+	*owner = NULL;
+	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++) {
+		if (strcmp(__start___ksymtab[i].name, name) == 0) {
+			*crc = symversion(__start___kcrctab, i);
+			return __start___ksymtab[i].value;
+		}
+	}
+	if (gplok) {
+		for (i = 0; __start___ksymtab_gpl+i<__stop___ksymtab_gpl; i++)
+			if (strcmp(__start___ksymtab_gpl[i].name, name) == 0) {
+				*crc = symversion(__start___kcrctab_gpl, i);
+				return __start___ksymtab_gpl[i].value;
+			}
+	}
+
+	/* Now try modules. */ 
+	list_for_each_entry(mod, &modules, list) {
+		*owner = mod;
+		for (i = 0; i < mod->num_ksyms; i++)
+			if (strcmp(mod->syms[i].name, name) == 0) {
+				*crc = symversion(mod->crcs, i);
+				return mod->syms[i].value;
+			}
+
+		if (gplok) {
+			for (i = 0; i < mod->num_gpl_syms; i++) {
+				if (strcmp(mod->gpl_syms[i].name, name) == 0) {
+					*crc = symversion(mod->crcs, i);
+					return mod->gpl_syms[i].value;
+				}
 			}
 		}
 	}
@@ -520,13 +554,14 @@ static void print_unload_info(struct seq
 
 void __symbol_put(const char *symbol)
 {
-	struct kernel_symbol_group *ksg;
+	struct module *owner;
 	unsigned long flags;
+	const unsigned long *crc;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &ksg, NULL, 1))
+	if (!__find_symbol(symbol, &owner, &crc, 1))
 		BUG();
-	module_put(ksg->owner);
+	module_put(owner);
 	spin_unlock_irqrestore(&modlist_lock, flags);
 }
 EXPORT_SYMBOL(__symbol_put);
@@ -724,19 +759,15 @@ static int check_version(Elf_Shdr *sechd
 			 unsigned int versindex,
 			 const char *symname,
 			 struct module *mod, 
-			 struct kernel_symbol_group *ksg,
-			 unsigned int symidx)
+			 const unsigned long *crc)
 {
-	unsigned long crc;
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
 
 	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
-	if (!ksg->crcs)
+	if (!crc)
 		return 1;
 
-	crc = ksg->crcs[symidx];
-
 	versions = (void *) sechdrs[versindex].sh_addr;
 	num_versions = sechdrs[versindex].sh_size
 		/ sizeof(struct modversion_info);
@@ -745,12 +776,12 @@ static int check_version(Elf_Shdr *sechd
 		if (strcmp(versions[i].name, symname) != 0)
 			continue;
 
-		if (versions[i].crc == crc)
+		if (versions[i].crc == *crc)
 			return 1;
 		printk("%s: disagrees about version of symbol %s\n",
 		       mod->name, symname);
 		DEBUGP("Found checksum %lX vs module %lX\n",
-		       crc, versions[i].crc);
+		       *crc, versions[i].crc);
 		return 0;
 	}
 	/* Not in module's version table.  OK, but that taints the kernel. */
@@ -786,8 +817,7 @@ static inline int check_version(Elf_Shdr
 				unsigned int versindex,
 				const char *symname,
 				struct module *mod, 
-				struct kernel_symbol_group *ksg,
-				unsigned int symidx)
+				const unsigned long *crc)
 {
 	return 1;
 }
@@ -812,17 +842,16 @@ static unsigned long resolve_symbol(Elf_
 				    const char *name,
 				    struct module *mod)
 {
-	struct kernel_symbol_group *ksg;
+	struct module *owner;
 	unsigned long ret;
-	unsigned int symidx;
+	const unsigned long *crc;
 
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, &ksg, &symidx, mod->license_gplok);
+	ret = __find_symbol(name, &owner, &crc, mod->license_gplok);
 	if (ret) {
 		/* use_module can fail due to OOM, or module unloading */
-		if (!check_version(sechdrs, versindex, name, mod,
-				   ksg, symidx) ||
-		    !use_module(mod, ksg->owner))
+		if (!check_version(sechdrs, versindex, name, mod, crc) ||
+		    !use_module(mod, owner))
 			ret = 0;
 	}
 	spin_unlock_irq(&modlist_lock);
@@ -835,8 +864,6 @@ static void free_module(struct module *m
 	/* Delete from various lists */
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
-	list_del(&mod->symbols.list);
-	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
@@ -853,12 +880,13 @@ static void free_module(struct module *m
 
 void *__symbol_get(const char *symbol)
 {
-	struct kernel_symbol_group *ksg;
+	struct module *owner;
 	unsigned long value, flags;
+	const unsigned long *crc;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg, NULL, 1);
-	if (value && !strong_try_module_get(ksg->owner))
+	value = __find_symbol(symbol, &owner, &crc, 1);
+	if (value && !strong_try_module_get(owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
@@ -1297,21 +1325,17 @@ static struct module *load_module(void *
 		goto cleanup;
 
 	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
-	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-				 / sizeof(*mod->symbols.syms));
-	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
+	mod->num_syms = sechdrs[exportindex].sh_size / sizeof(*mod->syms);
+	mod->syms = (void *)sechdrs[exportindex].sh_addr;
 	if (crcindex)
-		mod->symbols.crcs = (void *)sechdrs[crcindex].sh_addr;
-
-	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
-				 / sizeof(*mod->symbols.syms));
-	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
+		mod->crcs = (void *)sechdrs[crcindex].sh_addr;
+	mod->num_gpl_syms = sechdrs[gplindex].sh_size / sizeof(*mod->gpl_syms);
+	mod->gpl_syms = (void *)sechdrs[gplindex].sh_addr;
 	if (gplcrcindex)
-		mod->gpl_symbols.crcs = (void *)sechdrs[gplcrcindex].sh_addr;
+		mod->gpl_crcs = (void *)sechdrs[gplcrcindex].sh_addr;
 
 #ifdef CONFIG_MODVERSIONS
-	if ((mod->symbols.num_syms && !crcindex)
-	    || (mod->gpl_symbols.num_syms && !gplcrcindex)) {
+	if ((mod->num_ksyms&&!crcindex) || (mod->num_gpl_syms&&!gplcrcindex)) {
 		printk(KERN_WARNING "%s: No versions for exported symbols."
 		       " Tainting kernel.\n", mod->name);
 		tainted |= TAINT_FORCED_MODULE;
@@ -1420,8 +1444,6 @@ sys_init_module(void *umod,
            strong_try_module_get() will fail. */
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
-	list_add_tail(&mod->symbols.list, &symbols);
-	list_add_tail(&mod->gpl_symbols.list, &symbols);
 	list_add(&mod->list, &modules);
 	spin_unlock_irq(&modlist_lock);
 
@@ -1614,39 +1636,6 @@ struct module *module_text_address(unsig
 	return NULL;
 }
 
-/* Provided by the linker */
-extern const struct kernel_symbol __start___ksymtab[];
-extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___ksymtab_gpl[];
-extern const struct kernel_symbol __stop___ksymtab_gpl[];
-extern const unsigned long __start___kcrctab[];
-extern const unsigned long __stop___kcrctab[];
-extern const unsigned long __start___kcrctab_gpl[];
-extern const unsigned long __stop___kcrctab_gpl[];
-
-static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;
-
-static int __init symbols_init(void)
-{
-	/* Add kernel symbols to symbol table */
-	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
-	kernel_symbols.syms = __start___ksymtab;
-	kernel_symbols.crcs = __start___kcrctab;
-	kernel_symbols.gplonly = 0;
-	list_add(&kernel_symbols.list, &symbols);
-
-	kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
-				       - __start___ksymtab_gpl);
-	kernel_gpl_symbols.syms = __start___ksymtab_gpl;
-	kernel_gpl_symbols.crcs = __start___kcrctab_gpl;
-	kernel_gpl_symbols.gplonly = 1;
-	list_add(&kernel_gpl_symbols.list, &symbols);
-
-	return 0;
-}
-
-__initcall(symbols_init);
-
 #ifdef CONFIG_MODVERSIONS
 /* Generate the signature for struct module here, too, for modversions. */
 void struct_module(struct module *mod) { return; }
b_gpl;
-	kernel_gpl_symbols.gplonly = 1;
-	list_add(&kernel_gpl_symbols.list, &symbols);
-
-	return 0;
+			return mod;
+	return NULL;
 }
-
-__initcall(symbols_init);
