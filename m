Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267380AbTACET1>; Thu, 2 Jan 2003 23:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTACESh>; Thu, 2 Jan 2003 23:18:37 -0500
Received: from dp.samba.org ([66.70.73.150]:37518 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267374AbTACEST>;
	Thu, 2 Jan 2003 23:18:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] Module licence and EXPORT_SYMBOL_GPL
Date: Fri, 03 Jan 2003 14:55:58 +1100
Message-Id: <20030103042650.68E102C0B0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, EXPORT_SYMBOL_GPL and EXPORT_SYMBOL are the same, and
MODULE_LICENCE is a noop.  This patch implements EXPORT_SYMBOL_GPL and
enforces it, using module licences.

Linus, your options:
1) Drop the patch and leave well enough alone.
2) Just keep the module licence taint check.
3) Say OK to the whole thing (once I've tested it against latest bk).

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: MODULE_LICENSE support for modules
Author: Rusty Russell
Status: Untested

D: This implements EXPORT_SYMBOL_GPL and MODULE_LICENSE properly (so
D: restrictions are enforced).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2893-linux-2.5.54/arch/i386/vmlinux.lds.S .2893-linux-2.5.54.updated/arch/i386/vmlinux.lds.S
--- .2893-linux-2.5.54/arch/i386/vmlinux.lds.S	2003-01-02 12:46:12.000000000 +1100
+++ .2893-linux-2.5.54.updated/arch/i386/vmlinux.lds.S	2003-01-02 20:06:02.000000000 +1100
@@ -30,6 +30,10 @@ SECTIONS
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
+  . = ALIGN(64);
+  __start___gpl_ksymtab = .;	/* Kernel symbol table (GPL only) */
+  __gpl_ksymtab : { *(__gpl_ksymtab) }
+  __stop___gpl_ksymtab = .;
 
   __start___kallsyms = .;       /* All kernel symbols */
   __kallsyms : { *(__kallsyms) }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2893-linux-2.5.54/include/linux/module.h .2893-linux-2.5.54.updated/include/linux/module.h
--- .2893-linux-2.5.54/include/linux/module.h	2003-01-02 14:48:00.000000000 +1100
+++ .2893-linux-2.5.54.updated/include/linux/module.h	2003-01-02 20:07:30.000000000 +1100
@@ -21,7 +21,6 @@
 #include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
-#define MODULE_LICENSE(name)
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
@@ -57,6 +56,34 @@ extern const struct gtype##_id __mod_##g
 
 #define THIS_MODULE (&__this_module)
 
+/*
+ * The following license idents are currently accepted as indicating free
+ * software modules
+ *
+ *	"GPL"				[GNU Public License v2 or later]
+ *	"GPL v2"			[GNU Public License v2]
+ *	"GPL and additional rights"	[GNU Public License v2 rights and more]
+ *	"Dual BSD/GPL"			[GNU Public License v2 or BSD license choice]
+ *	"Dual MPL/GPL"			[GNU Public License v2 or Mozilla license choice]
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
+		__attribute__((section(".license"))) = license
+
 #else  /* !MODULE */
 
 #define MODULE_GENERIC_TABLE(gtype,name)
@@ -75,6 +102,9 @@ struct kernel_symbol_group
 	/* Module which owns it (if any) */
 	struct module *owner;
 
+	/* Are we internal use only? */
+	int gplonly;
+
 	unsigned int num_syms;
 	const struct kernel_symbol *syms;
 };
@@ -101,7 +131,11 @@ void *__symbol_get_gpl(const char *symbo
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
@@ -128,6 +162,9 @@ struct module
 	/* Exported symbols */
 	struct kernel_symbol_group symbols;
 
+	/* GPL-only exported symbols. */
+	struct kernel_symbol_group gpl_symbols;
+
 	/* Exception tables */
 	struct exception_table extable;
 
@@ -149,6 +186,9 @@ struct module
 	/* Am I unsafe to unload? */
 	int unsafe;
 
+	/* My license */
+	char *license;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
@@ -293,6 +333,7 @@ struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
 	.name = __stringify(KBUILD_MODNAME),
 	.symbols = { .owner = &__this_module },
+	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
 	.init = init_module,
 #ifdef CONFIG_MODULE_UNLOAD
 	.exit = cleanup_module,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2893-linux-2.5.54/kernel/extable.c .2893-linux-2.5.54.updated/kernel/extable.c
--- .2893-linux-2.5.54/kernel/extable.c	2003-01-02 12:36:08.000000000 +1100
+++ .2893-linux-2.5.54.updated/kernel/extable.c	2003-01-02 20:06:02.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2893-linux-2.5.54/kernel/module.c .2893-linux-2.5.54.updated/kernel/module.c
--- .2893-linux-2.5.54/kernel/module.c	2003-01-02 14:48:01.000000000 +1100
+++ .2893-linux-2.5.54.updated/kernel/module.c	2003-01-02 20:09:28.000000000 +1100
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
@@ -703,6 +706,15 @@ static int obsolete_params(const char *n
 }
 #endif /* CONFIG_OBSOLETE_MODPARM */
 
+static int module_is_gpl(struct module *mod)
+{
+	return (strcmp(mod->license, "GPL") == 0
+		|| strcmp(mod->license, "GPL v2") == 0
+		|| strcmp(mod->license, "GPL and additional rights") == 0
+		|| strcmp(mod->license, "Dual BSD/GPL") == 0
+		|| strcmp(mod->license, "Dual MPL/GPL") == 0);
+}
+
 /* Find an symbol for this module (ie. resolve internals first).
    It we find one, record usage.  Must be holding module_mutex. */
 unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
@@ -721,7 +733,7 @@ unsigned long find_symbol_internal(Elf_S
 	}
 	/* Look in other modules... */
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, ksg);
+	ret = __find_symbol(name, ksg, module_is_gpl(mod));
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
 		if (!use_module(mod, (*ksg)->owner))
@@ -738,6 +750,7 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->symbols.list);
+	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
@@ -758,7 +771,7 @@ void *__symbol_get(const char *symbol)
 	unsigned long value, flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg);
+	value = __find_symbol(symbol, &ksg, 1);
 	if (value && !strong_try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -930,7 +943,23 @@ static void layout_sections(struct modul
 	}
 }
 
-/* Allocate and load the module */
+static void set_license(struct module *mod, Elf_Shdr *sechdrs, int licenseidx)
+{
+	if (licenseidx)
+		mod->license = (char *)sechdrs[licenseidx].sh_addr;
+	else
+		mod->license = "unspecified";
+
+	if (module_is_gpl(mod))
+		return;
+
+	printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
+	       mod->name, mod->license);
+	tainted |= TAINT_PROPRIETORY_MODULE;
+}
+
+/* Allocate and load the module: note that size of section 0 is always
+   zero, and we rely on this for optional sections. */
 static struct module *load_module(void *umod,
 				  unsigned long len,
 				  const char *uargs)
@@ -939,7 +968,7 @@ static struct module *load_module(void *
 	Elf_Shdr *sechdrs;
 	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modindex, obsparmindex;
+		modindex, obsparmindex, licenseindex, gplindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -975,7 +1004,7 @@ static struct module *load_module(void *
 
 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = obsparmindex = 0;
+	exportindex = setupindex = obsparmindex = gplindex = licenseindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modindex = 0;
@@ -1018,6 +1047,16 @@ static struct module *load_module(void *
 			/* Obsolete MODULE_PARM() table */
 			DEBUGP("Obsolete param found in section %u\n", i);
 			obsparmindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".license")
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
@@ -1118,12 +1157,16 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
-	/* Set up EXPORTed symbols */
-	if (exportindex) {
-		mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-					/ sizeof(*mod->symbols.syms));
-		mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
-	}
+	/* Set up license info based on contents of section */
+	set_license(mod, sechdrs, licenseindex);
+
+	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
+	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
+				 / sizeof(*mod->symbols.syms));
+	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
+	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
+				 / sizeof(*mod->symbols.syms));
+	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
 
 	/* Set up exception table */
 	if (exindex) {
@@ -1228,6 +1271,7 @@ sys_init_module(void *umod,
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
 	list_add_tail(&mod->symbols.list, &symbols);
+	list_add_tail(&mod->gpl_symbols.list, &kernel_symbols.list);
 	spin_unlock_irq(&modlist_lock);
 	list_add(&mod->list, &modules);
 
