Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267897AbTAMFvC>; Mon, 13 Jan 2003 00:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267913AbTAMFvC>; Mon, 13 Jan 2003 00:51:02 -0500
Received: from dp.samba.org ([66.70.73.150]:10200 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267897AbTAMFu4>;
	Mon, 13 Jan 2003 00:50:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup 1/2: Remove exported symbol list
Date: Mon, 13 Jan 2003 16:57:26 +1100
Message-Id: <20030113055946.91D482C0BD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the symbol lists and module lists are finally static to
kernel/module.c, we can get rid of the extable list (and just traverse
the modules), without effecting anyone else.

Name: Symbol list removal
Author: Rusty Russell
Status: Tested on 2.5.56

D: This removes the symbol list, and the concept of kernel symbol groups,
D: in favour of just iterating through the modules.  Now all iteration is
D: within kernel/module.c, this is a fairly trivial cleanup.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5517-linux-2.5-bk/include/linux/module.h .5517-linux-2.5-bk.updated/include/linux/module.h
--- .5517-linux-2.5-bk/include/linux/module.h	2003-01-13 11:17:32.000000000 +1100
+++ .5517-linux-2.5-bk.updated/include/linux/module.h	2003-01-13 15:52:03.000000000 +1100
@@ -106,21 +106,6 @@ extern const struct gtype##_id __mod_##g
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
-};
-
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
 
@@ -175,10 +160,12 @@ struct module
 	char name[MODULE_NAME_LEN];
 
 	/* Exported symbols */
-	struct kernel_symbol_group symbols;
+	const struct kernel_symbol *syms;
+	unsigned int num_ksyms;
 
 	/* GPL-only exported symbols. */
-	struct kernel_symbol_group gpl_symbols;
+	const struct kernel_symbol *gpl_syms;
+	unsigned int num_gpl_syms;
 
 	/* Exception tables */
 	struct exception_table extable;
@@ -239,7 +226,7 @@ static inline int module_is_live(struct 
 }
 
 /* Is this address in a module? */
-int module_text_address(unsigned long addr);
+struct module *module_text_address(unsigned long addr);
 
 #ifdef CONFIG_MODULE_UNLOAD
 
@@ -332,9 +319,9 @@ search_module_extables(unsigned long add
 }
 
 /* Is this address in a module? */
-static inline int module_text_address(unsigned long addr)
+static inline struct module *module_text_address(unsigned long addr)
 {
-	return 0;
+	return NULL;
 }
 
 /* Get/put a kernel symbol (calls should be symmetric) */
@@ -359,8 +352,6 @@ extern struct module __this_module;
 struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
 	.name = __stringify(KBUILD_MODNAME),
-	.symbols = { .owner = &__this_module },
-	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
 	.init = init_module,
 #ifdef CONFIG_MODULE_UNLOAD
 	.exit = cleanup_module,
@@ -436,14 +423,6 @@ extern int module_dummy_usage;
 #define MOD_IN_USE 0
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13250-2.5-bk-extable-list.pre/include/linux/moduleloader.h .13250-2.5-bk-extable-list/include/linux/moduleloader.h
--- .13250-2.5-bk-extable-list.pre/include/linux/moduleloader.h	2003-01-10 10:55:43.000000000 +1100
+++ .13250-2.5-bk-extable-list/include/linux/moduleloader.h	2003-01-13 16:34:24.000000000 +1100
@@ -11,7 +11,7 @@ unsigned long find_symbol_internal(Elf_S
 				   const char *strtab,
 				   const char *name,
 				   struct module *mod,
-				   struct kernel_symbol_group **group);
+				   struct module **owner);
 
 /* These must be implemented by the specific architecture */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5517-linux-2.5-bk/kernel/extable.c .5517-linux-2.5-bk.updated/kernel/extable.c
--- .5517-linux-2.5-bk/kernel/extable.c	2003-01-10 10:55:43.000000000 +1100
+++ .5517-linux-2.5-bk.updated/kernel/extable.c	2003-01-13 15:52:03.000000000 +1100
@@ -38,5 +38,5 @@ int kernel_text_address(unsigned long ad
 	    addr <= (unsigned long)_etext)
 		return 1;
 
-	return module_text_address(addr);
+	return module_text_address(addr) != NULL;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5517-linux-2.5-bk/kernel/module.c .5517-linux-2.5-bk.updated/kernel/module.c
--- .5517-linux-2.5-bk/kernel/module.c	2003-01-10 10:55:43.000000000 +1100
+++ .5517-linux-2.5-bk.updated/kernel/module.c	2003-01-13 15:53:14.000000000 +1100
@@ -57,7 +57,6 @@ static spinlock_t modlist_lock = SPIN_LO
 /* List of modules, protected by module_mutex AND modlist_lock */
 static DECLARE_MUTEX(module_mutex);
 static LIST_HEAD(modules);
-static LIST_HEAD(symbols);
 static LIST_HEAD(extables);
 
 /* We require a truly strong try_module_get() */
@@ -75,23 +74,41 @@ int init_module(void)
 }
 EXPORT_SYMBOL(init_module);
 
-/* Find a symbol, return value and the symbol group */
+/* Provided by the linker */
+extern const struct kernel_symbol __start___ksymtab[];
+extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start___gpl_ksymtab[];
+extern const struct kernel_symbol __stop___gpl_ksymtab[];
+
+/* Find a symbol, return value and module which owns it */
 static unsigned long __find_symbol(const char *name,
-				   struct kernel_symbol_group **group,
+				   struct module **owner,
 				   int gplok)
 {
-	struct kernel_symbol_group *ks;
+	struct module *mod;
+	unsigned int i;
  
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
+	*owner = NULL;
+	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++)
+		if (strcmp(__start___ksymtab[i].name, name) == 0)
+			return __start___ksymtab[i].value;
 
-		if (ks->gplonly && !gplok)
-			continue;
-		for (i = 0; i < ks->num_syms; i++) {
-			if (strcmp(ks->syms[i].name, name) == 0) {
-				*group = ks;
-				return ks->syms[i].value;
-			}
+	if (gplok) {
+		for (i = 0; __start___gpl_ksymtab+i<__stop___gpl_ksymtab; i++)
+			if (strcmp(__start___gpl_ksymtab[i].name, name) == 0)
+			return __start___gpl_ksymtab[i].value;
+	}
+
+	list_for_each_entry(mod, &modules, list) {
+		*owner = mod;
+		for (i = 0; i < mod->num_ksyms; i++)
+			if (strcmp(mod->syms[i].name, name) == 0)
+				return mod->syms[i].value;
+
+		if (gplok) {
+			for (i = 0; i < mod->num_gpl_syms; i++)
+				if (strcmp(mod->gpl_syms[i].name, name) == 0)
+					return mod->gpl_syms[i].value;
 		}
 	}
 	DEBUGP("Failed to find symbol %s\n", name);
@@ -516,36 +533,27 @@ static void print_unload_info(struct seq
 
 void __symbol_put(const char *symbol)
 {
-	struct kernel_symbol_group *ksg;
+	struct module *mod;
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &ksg, 1))
+	if (!__find_symbol(symbol, &mod, 1))
 		BUG();
-	module_put(ksg->owner);
+	module_put(mod);
 	spin_unlock_irqrestore(&modlist_lock, flags);
 }
 EXPORT_SYMBOL(__symbol_put);
 
 void symbol_put_addr(void *addr)
 {
-	struct kernel_symbol_group *ks;
 	unsigned long flags;
 
-	spin_lock_irqsave(&modlist_lock, flags);
-	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
+	if (!kernel_text_address((unsigned long)addr))
+		BUG();
 
-		for (i = 0; i < ks->num_syms; i++) {
-			if (ks->syms[i].value == (unsigned long)addr) {
-				module_put(ks->owner);
-				spin_unlock_irqrestore(&modlist_lock, flags);
-				return;
-			}
-		}
-	}
+	spin_lock_irqsave(&modlist_lock, flags);
+	module_put(module_text_address((unsigned long)addr));
 	spin_unlock_irqrestore(&modlist_lock, flags);
-	BUG();
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
@@ -729,21 +737,21 @@ unsigned long find_symbol_internal(Elf_S
 				   const char *strtab,
 				   const char *name,
 				   struct module *mod,
-				   struct kernel_symbol_group **ksg)
+				   struct module **owner)
 {
 	unsigned long ret;
 
 	ret = find_local_symbol(sechdrs, symindex, strtab, name);
 	if (ret) {
-		*ksg = NULL;
+		*owner = NULL;
 		return ret;
 	}
 	/* Look in other modules... */
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, ksg, mod->license_gplok);
+	ret = __find_symbol(name, owner, mod->license_gplok);
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
-		if (!use_module(mod, (*ksg)->owner))
+		if (!use_module(mod, *owner))
 			ret = 0;
 	}
 	spin_unlock_irq(&modlist_lock);
@@ -756,8 +764,6 @@ static void free_module(struct module *m
 	/* Delete from various lists */
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
-	list_del(&mod->symbols.list);
-	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
@@ -774,12 +780,12 @@ static void free_module(struct module *m
 
 void *__symbol_get(const char *symbol)
 {
-	struct kernel_symbol_group *ksg;
+	struct module *module;
 	unsigned long value, flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg, 1);
-	if (value && !strong_try_module_get(ksg->owner))
+	value = __find_symbol(symbol, &module, 1);
+	if (value && !strong_try_module_get(module))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
@@ -871,7 +877,7 @@ static int simplify_symbols(Elf_Shdr *se
 	     i++) {
 		if (sym[i].st_shndx == SHN_UNDEF) {
 			/* Look for symbol */
-			struct kernel_symbol_group *ksg = NULL;
+			struct module *owner;
 			const char *strtab 
 				= (char *)sechdrs[strindex].sh_addr;
 
@@ -881,7 +887,7 @@ static int simplify_symbols(Elf_Shdr *se
 						       strtab,
 						       strtab + sym[i].st_name,
 						       mod,
-						       &ksg);
+						       &owner);
 		}
 	}
 
@@ -1179,12 +1185,10 @@ static struct module *load_module(void *
 		goto cleanup;
 
 	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
-	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-				 / sizeof(*mod->symbols.syms));
-	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
-	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
-				 / sizeof(*mod->symbols.syms));
-	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
+	mod->num_ksyms = (sechdrs[exportindex].sh_size/ sizeof(*mod->syms));
+	mod->syms = (void *)sechdrs[exportindex].sh_addr;
+	mod->num_gpl_syms = sechdrs[gplindex].sh_size / sizeof(*mod->gpl_syms);
+	mod->gpl_syms = (void *)sechdrs[gplindex].sh_addr;
 
 	/* Set up exception table */
 	if (exindex) {
@@ -1288,8 +1292,6 @@ sys_init_module(void *umod,
            strong_try_module_get() will fail. */
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
-	list_add_tail(&mod->symbols.list, &symbols);
-	list_add_tail(&mod->gpl_symbols.list, &symbols);
 	list_add(&mod->list, &modules);
 	spin_unlock_irq(&modlist_lock);
 
@@ -1462,7 +1464,7 @@ const struct exception_table_entry *sear
 }
 
 /* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
-int module_text_address(unsigned long addr)
+struct module *module_text_address(unsigned long addr)
 {
 	struct module *mod;
 
@@ -1473,32 +1475,6 @@ int module_text_address(unsigned long ad
 	return 0;
 }
 
-/* Provided by the linker */
-extern const struct kernel_symbol __start___ksymtab[];
-extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___gpl_ksymtab[];
-extern const struct kernel_symbol __stop___gpl_ksymtab[];
-
-static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;
-
-static int __init symbols_init(void)
-{
-	/* Add kernel symbols to symbol table */
-	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
-	kernel_symbols.syms = __start___ksymtab;
-	kernel_symbols.gplonly = 0;
-	list_add(&kernel_symbols.list, &symbols);
-	kernel_gpl_symbols.num_syms = (__stop___gpl_ksymtab
-				       - __start___gpl_ksymtab);
-	kernel_gpl_symbols.syms = __start___gpl_ksymtab;
-	kernel_gpl_symbols.gplonly = 1;
-	list_add(&kernel_gpl_symbols.list, &symbols);
-
-	return 0;
-}
-
-__initcall(symbols_init);
-
 /* Obsolete lvalue for broken code which asks about usage */
 int module_dummy_usage = 1;
 EXPORT_SYMBOL(module_dummy_usage);



--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
