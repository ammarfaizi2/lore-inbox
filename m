Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTAEX7r>; Sun, 5 Jan 2003 18:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbTAEX7r>; Sun, 5 Jan 2003 18:59:47 -0500
Received: from dp.samba.org ([66.70.73.150]:65498 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265506AbTAEX7R>;
	Sun, 5 Jan 2003 18:59:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_LICENSE and EXPORT_SYMBOL_GPL support
Date: Mon, 06 Jan 2003 11:04:16 +1100
Message-Id: <20030106000753.0E29A2C080@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-xmit: Linus, please apply.

Now simply a flag, and the license text itself is in a .init section,
so will be discarded for most archs.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: MODULE_LICENSE support for modules
Author: Rusty Russell
Status: Tested in 2.5.54

D: This implements EXPORT_SYMBOL_GPL and MODULE_LICENSE properly (so
D: restrictions are enforced).  Also fixes "proprietory" spelling.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/kernel.h working-2.5-bk-module-license/include/linux/kernel.h
--- linux-2.5-bk/include/linux/kernel.h	Thu Jan  2 14:48:00 2003
+++ working-2.5-bk-module-license/include/linux/kernel.h	Fri Jan  3 16:32:18 2003
@@ -105,7 +105,7 @@ extern int oops_in_progress;		/* If set,
 
 extern int tainted;
 extern const char *print_tainted(void);
-#define TAINT_PROPRIETORY_MODULE	(1<<0)
+#define TAINT_PROPRIETARY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
 #define TAINT_FORCED_RMMOD		(1<<3)
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/module.h working-2.5-bk-module-license/include/linux/module.h
--- linux-2.5-bk/include/linux/module.h	Thu Jan  2 14:48:00 2003
+++ working-2.5-bk-module-license/include/linux/module.h	Fri Jan  3 17:12:33 2003
@@ -21,7 +21,6 @@
 #include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
-#define MODULE_LICENSE(name)
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
@@ -57,11 +56,41 @@ extern const struct gtype##_id __mod_##g
 
 #define THIS_MODULE (&__this_module)
 
+/*
+ * The following license idents are currently accepted as indicating free
+ * software modules
+ *
+ *	"GPL"				[GNU Public License v2 or later]
+ *	"GPL v2"			[GNU Public License v2]
+ *	"GPL and additional rights"	[GNU Public License v2 rights and more]
+ *	"Dual BSD/GPL"			[GNU Public License v2
+ *					 or BSD license choice]
+ *	"Dual MPL/GPL"			[GNU Public License v2
+ *					 or Mozilla license choice]
+ *
+ * The following other idents are available
+ *
+ *	"Proprietary"			[Non free products]
+ *
+ * There are dual licensed components, but when running with Linux it is the
+ * GPL that is relevant so this is a non issue. Similarly LGPL linked with GPL
+ * is a GPL combined work.
+ *
+ * This exists for several reasons
+ * 1.	So modinfo can show license info for users wanting to vet their setup 
+ *	is free
+ * 2.	So the community can ignore bug reports including proprietary modules
+ * 3.	So vendors can do likewise based on their own policies
+ */
+#define MODULE_LICENSE(license)					\
+	static const char __module_license[]			\
+		__attribute__((section(".init.license"))) = license
+
 #else  /* !MODULE */
 
 #define MODULE_GENERIC_TABLE(gtype,name)
 #define THIS_MODULE ((struct module *)0)
-
+#define MODULE_LICENSE(license)
 #endif
 
 #define MODULE_DEVICE_TABLE(type,name)		\
@@ -75,6 +104,9 @@ struct kernel_symbol_group
 	/* Module which owns it (if any) */
 	struct module *owner;
 
+	/* Are we internal use only? */
+	int gplonly;
+
 	unsigned int num_syms;
 	const struct kernel_symbol *syms;
 };
@@ -101,7 +133,11 @@ void *__symbol_get_gpl(const char *symbo
 	= { (unsigned long)&sym, MODULE_SYMBOL_PREFIX #sym }
 
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
-#define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
+
+#define EXPORT_SYMBOL_GPL(sym)				\
+	const struct kernel_symbol __ksymtab_##sym	\
+	__attribute__((section("__gpl_ksymtab")))	\
+	= { (unsigned long)&sym, #sym }
 
 struct module_ref
 {
@@ -128,6 +164,9 @@ struct module
 	/* Exported symbols */
 	struct kernel_symbol_group symbols;
 
+	/* GPL-only exported symbols. */
+	struct kernel_symbol_group gpl_symbols;
+
 	/* Exception tables */
 	struct exception_table extable;
 
@@ -149,6 +188,9 @@ struct module
 	/* Am I unsafe to unload? */
 	int unsafe;
 
+	/* Am I GPL-compatible */
+	int license_gplok;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
@@ -293,6 +335,7 @@ struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
 	.name = __stringify(KBUILD_MODNAME),
 	.symbols = { .owner = &__this_module },
+	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
 	.init = init_module,
 #ifdef CONFIG_MODULE_UNLOAD
 	.exit = cleanup_module,
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/extable.c working-2.5-bk-module-license/kernel/extable.c
--- linux-2.5-bk/kernel/extable.c	Thu Jan  2 12:36:08 2003
+++ working-2.5-bk-module-license/kernel/extable.c	Fri Jan  3 16:29:26 2003
@@ -24,6 +24,8 @@ extern const struct exception_table_entr
 extern const struct exception_table_entry __stop___ex_table[];
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start___gpl_ksymtab[];
+extern const struct kernel_symbol __stop___gpl_ksymtab[];
 
 /* Protects extables and symbol tables */
 spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
@@ -34,13 +36,20 @@ LIST_HEAD(symbols);
 
 static struct exception_table kernel_extable;
 static struct kernel_symbol_group kernel_symbols;
+static struct kernel_symbol_group kernel_gpl_symbols;
 
 void __init extable_init(void)
 {
 	/* Add kernel symbols to symbol table */
 	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
 	kernel_symbols.syms = __start___ksymtab;
+	kernel_symbols.gplonly = 0;
 	list_add(&kernel_symbols.list, &symbols);
+	kernel_gpl_symbols.num_syms = (__stop___gpl_ksymtab
+				       - __start___gpl_ksymtab);
+	kernel_gpl_symbols.syms = __start___gpl_ksymtab;
+	kernel_gpl_symbols.gplonly = 1;
+	list_add(&kernel_gpl_symbols.list, &symbols);
 
 	/* Add kernel exception table to exception tables */
 	kernel_extable.num_entries = (__stop___ex_table -__start___ex_table);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/module.c working-2.5-bk-module-license/kernel/module.c
--- linux-2.5-bk/kernel/module.c	Thu Jan  2 14:48:01 2003
+++ working-2.5-bk-module-license/kernel/module.c	Fri Jan  3 16:47:20 2003
@@ -72,13 +72,16 @@ EXPORT_SYMBOL(init_module);
 
 /* Find a symbol, return value and the symbol group */
 static unsigned long __find_symbol(const char *name,
-				   struct kernel_symbol_group **group)
+				   struct kernel_symbol_group **group,
+				   int gplok)
 {
 	struct kernel_symbol_group *ks;
  
 	list_for_each_entry(ks, &symbols, list) {
  		unsigned int i;
 
+		if (ks->gplonly && !gplok)
+			continue;
 		for (i = 0; i < ks->num_syms; i++) {
 			if (strcmp(ks->syms[i].name, name) == 0) {
 				*group = ks;
@@ -502,7 +505,7 @@ void __symbol_put(const char *symbol)
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &ksg))
+	if (!__find_symbol(symbol, &ksg, 1))
 		BUG();
 	module_put(ksg->owner);
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -721,7 +724,7 @@ unsigned long find_symbol_internal(Elf_S
 	}
 	/* Look in other modules... */
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, ksg);
+	ret = __find_symbol(name, ksg, mod->license_gplok);
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
 		if (!use_module(mod, (*ksg)->owner))
@@ -738,6 +741,7 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->symbols.list);
+	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
@@ -758,7 +762,7 @@ void *__symbol_get(const char *symbol)
 	unsigned long value, flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg);
+	value = __find_symbol(symbol, &ksg, 1);
 	if (value && !strong_try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -930,7 +934,34 @@ static void layout_sections(struct modul
 	}
 }
 
-/* Allocate and load the module */
+static inline int license_is_gpl_compatible(const char *license)
+{
+	return (strcmp(license, "GPL") == 0
+		|| strcmp(license, "GPL v2") == 0
+		|| strcmp(license, "GPL and additional rights") == 0
+		|| strcmp(license, "Dual BSD/GPL") == 0
+		|| strcmp(license, "Dual MPL/GPL") == 0);
+}
+
+static void set_license(struct module *mod, Elf_Shdr *sechdrs, int licenseidx)
+{
+	char *license;
+
+	if (licenseidx) 
+		license = (char *)sechdrs[licenseidx].sh_addr;
+	else
+		license = "unspecified";
+
+	mod->license_gplok = license_is_gpl_compatible(license);
+	if (!mod->license_gplok) {
+		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
+		       mod->name, license);
+		tainted |= TAINT_PROPRIETARY_MODULE;
+	}
+}
+
+/* Allocate and load the module: note that size of section 0 is always
+   zero, and we rely on this for optional sections. */
 static struct module *load_module(void *umod,
 				  unsigned long len,
 				  const char *uargs)
@@ -939,7 +970,7 @@ static struct module *load_module(void *
 	Elf_Shdr *sechdrs;
 	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modindex, obsparmindex;
+		modindex, obsparmindex, licenseindex, gplindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -975,7 +1006,7 @@ static struct module *load_module(void *
 
 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = obsparmindex = 0;
+	exportindex = setupindex = obsparmindex = gplindex = licenseindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modindex = 0;
@@ -1018,6 +1049,16 @@ static struct module *load_module(void *
 			/* Obsolete MODULE_PARM() table */
 			DEBUGP("Obsolete param found in section %u\n", i);
 			obsparmindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,".init.license")
+			   == 0) {
+			/* MODULE_LICENSE() */
+			DEBUGP("Licence found in section %u\n", i);
+			licenseindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  "__gpl_ksymtab") == 0) {
+			/* EXPORT_SYMBOL_GPL() */
+			DEBUGP("GPL symbols found in section %u\n", i);
+			gplindex = i;
 		}
 #ifdef CONFIG_KALLSYMS
 		/* symbol and string tables for decoding later. */
@@ -1113,17 +1154,21 @@ static struct module *load_module(void *
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
 
+	/* Set up license info based on contents of section */
+	set_license(mod, sechdrs, licenseindex);
+
 	/* Fix up syms, so that st_value is a pointer to location. */
 	err = simplify_symbols(sechdrs, symindex, strindex, mod);
 	if (err < 0)
 		goto cleanup;
 
-	/* Set up EXPORTed symbols */
-	if (exportindex) {
-		mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-					/ sizeof(*mod->symbols.syms));
-		mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
-	}
+	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
+	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
+				 / sizeof(*mod->symbols.syms));
+	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
+	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
+				 / sizeof(*mod->symbols.syms));
+	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
 
 	/* Set up exception table */
 	if (exindex) {
@@ -1228,6 +1273,7 @@ sys_init_module(void *umod,
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
 	list_add_tail(&mod->symbols.list, &symbols);
+	list_add_tail(&mod->gpl_symbols.list, &symbols);
 	spin_unlock_irq(&modlist_lock);
 	list_add(&mod->list, &modules);
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/kernel/panic.c working-2.5-bk-module-license/kernel/panic.c
--- linux-2.5-bk/kernel/panic.c	Thu Jan  2 12:25:16 2003
+++ working-2.5-bk-module-license/kernel/panic.c	Fri Jan  3 16:32:55 2003
@@ -103,7 +103,7 @@ NORET_TYPE void panic(const char * fmt, 
 /**
  *	print_tainted - return a string to represent the kernel taint state.
  *
- *  'P' - Proprietory module has been loaded.
+ *  'P' - Proprietary module has been loaded.
  *  'F' - Module has been forcibly loaded.
  *  'S' - SMP with CPUs not designed for SMP.
  *
@@ -115,7 +115,7 @@ const char *print_tainted()
 	static char buf[20];
 	if (tainted) {
 		snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
-			tainted & TAINT_PROPRIETORY_MODULE ? 'P' : 'G',
+			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
 			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
 			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
 	}
