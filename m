Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbSIYDZT>; Tue, 24 Sep 2002 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbSIYDZI>; Tue, 24 Sep 2002 23:25:08 -0400
Received: from dp.samba.org ([66.70.73.150]:46464 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261897AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 14/20: Module License Support
Date: Wed, 25 Sep 2002 13:05:25 +1000
Message-Id: <20020925032201.CB0BF2C147@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: MODULE_LICENSE support for modules
Author: Rusty Russell
Status: Untested
Depends: Module/modversions.patch.gz

D: This implements EXPORT_SYMBOL_GPL and MODULE_LICENSE properly (so
D: restrictions are enforced).  It also sets up a table for finding
D: the sections in the ELF object, since there are now enough
D: variables to make it sensible.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14496-linux-2.5.38/arch/i386/vmlinux.lds.S .14496-linux-2.5.38.updated/arch/i386/vmlinux.lds.S
--- .14496-linux-2.5.38/arch/i386/vmlinux.lds.S	2002-09-25 10:34:57.000000000 +1000
+++ .14496-linux-2.5.38.updated/arch/i386/vmlinux.lds.S	2002-09-25 10:35:23.000000000 +1000
@@ -29,6 +29,10 @@ SECTIONS
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
+  . = ALIGN(64);
+  __start_gpl_ksymtab = .;	/* Kernel symbol table (GPL only) */
+  __gpl.ksymtab : { *(__gpl.ksymtab) }
+  __stop_gpl_ksymtab = .;
 
   .data : {			/* Data */
 	*(.data)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14496-linux-2.5.38/include/linux/module.h .14496-linux-2.5.38.updated/include/linux/module.h
--- .14496-linux-2.5.38/include/linux/module.h	2002-09-25 10:35:00.000000000 +1000
+++ .14496-linux-2.5.38.updated/include/linux/module.h	2002-09-25 10:35:23.000000000 +1000
@@ -19,7 +19,6 @@
 #include <asm/uaccess.h> /* For struct exception_table_entry */
 
 /* Not Yet Implemented */
-#define MODULE_LICENSE(name)
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
@@ -44,8 +43,36 @@ struct modversion_info {
    a constant so it works in initializers. */
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
+
+/*
+ * The following license idents are currently accepted as indicating free
+ * software modules
+ *
+ *	"GPL"				[GNU Public License v2 or later]
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
 #else
 #define THIS_MODULE ((struct module *)0)
+#define MODULE_LICENSE(license)
 #endif
 
 #ifdef CONFIG_MODULES
@@ -73,8 +100,10 @@ extern struct modversion_info modversion
 	NEED_MODVERSION(sym)				\
 	EXPORT_SYMBOL_NOVERS(sym)
 
-/* FIXME: Enforce this. */
-#define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_GPL(sym)				\
+	const struct kernel_symbol __ksymtab_##sym	\
+	__attribute__((section("__gpl.ksymtab")))	\
+	= { (unsigned long)&sym, #sym }
 
 struct kernel_symbol_group
 {
@@ -84,6 +113,9 @@ struct kernel_symbol_group
 	/* Module which owns it (if any) */
 	struct module *owner;
 
+	/* Are we internal use only? */
+	int gplonly;
+
 	unsigned int num_syms;
 	const struct kernel_symbol *syms;
 };
@@ -106,6 +138,9 @@ struct module
 	/* Exported symbols */
 	struct kernel_symbol_group symbols;
 
+	/* GPL-only exported symbols. */
+	struct kernel_symbol_group gpl_symbols;
+
 	/* Exception tables */
 	struct exception_table extable;
 
@@ -130,6 +165,9 @@ struct module
 	/* Am I unsafe to unload? */
 	int unsafe_to_unload;
 
+	/* My license */
+	char *license;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Usage count. */
 	struct bigref use;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14496-linux-2.5.38/kernel/module.c .14496-linux-2.5.38.updated/kernel/module.c
--- .14496-linux-2.5.38/kernel/module.c	2002-09-25 10:35:01.000000000 +1000
+++ .14496-linux-2.5.38.updated/kernel/module.c	2002-09-25 10:36:50.000000000 +1000
@@ -35,10 +35,13 @@
 #define DEBUGP(fmt , ...)
 #endif
 
+/* Created by linker magic */
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
+extern const struct kernel_symbol __start_gpl_ksymtab[];
+extern const struct kernel_symbol __stop_gpl_ksymtab[];
 
 /* Protects extables and symbol tables */
 spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
@@ -49,6 +52,7 @@ static LIST_HEAD(symbols);
 
 static struct exception_table kernel_extable;
 static struct kernel_symbol_group kernel_symbols;
+static struct kernel_symbol_group kernel_gpl_symbols;
 
 /* List of modules, protected by module_mutex */
 static DECLARE_MUTEX(module_mutex);
@@ -63,13 +67,16 @@ struct sizes
 
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
@@ -220,6 +227,7 @@ sys_delete_module(const char *name_user,
 	/* Remove symbols so module count can't increase from symbol_get() */
 	spin_lock_irq(&modlist_lock);
 	list_del_init(&mod->symbols.list);
+	list_del_init(&mod->gpl_symbols.list);
 	spin_unlock_irq(&modlist_lock);
 
 	/* Mark it as non-live. */
@@ -240,6 +248,7 @@ sys_delete_module(const char *name_user,
 		try_module_get(mod); /* Can't fail */
 		spin_lock_irq(&modlist_lock);
 		list_add(&mod->symbols.list, &kernel_symbols.list);
+		list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
 		spin_unlock_irq(&modlist_lock);
 		ret = -EWOULDBLOCK;
 		goto out;
@@ -298,7 +307,7 @@ void __symbol_put(const char *symbol)
 	unsigned long flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &ksg))
+	if (!__find_symbol(symbol, &ksg, 1))
 		BUG();
 	module_put(ksg->owner);
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -501,6 +510,14 @@ static inline int check_version(const ch
 }
 #endif /* CONFIG_MODVERSIONING */
 
+static int module_is_gpl(struct module *mod)
+{
+	return (strcmp(mod->license, "GPL") == 0
+		|| strcmp(mod->license, "GPL and additional rights") == 0
+		|| strcmp(mod->license, "Dual BSD/GPL") == 0
+		|| strcmp(mod->license, "Dual MPL/GPL") == 0);
+}
+
 /* Find an symbol for this module (ie. resolve internals first).
    It we find one, record usage.  Must be holding module_mutex. */
 unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
@@ -519,7 +536,7 @@ unsigned long find_symbol_internal(Elf_S
 	}
 	/* Look in other modules... */
 	spin_lock_irq(&modlist_lock);
-	ret = __find_symbol(name, ksg);
+	ret = __find_symbol(name, ksg, module_is_gpl(mod));
 	if (ret) {
 		/* This can fail due to OOM, or module unloading */
 		if (!use_module(mod, (*ksg)->owner))
@@ -536,6 +553,7 @@ static void free_module(struct module *m
 	list_del(&mod->list);
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->symbols.list);
+	list_del(&mod->gpl_symbols.list);
 	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
@@ -556,7 +574,7 @@ void *__symbol_get(const char *symbol)
 	unsigned long value, flags;
 
 	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &ksg);
+	value = __find_symbol(symbol, &ksg, 1);
 	if (value && !try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
@@ -792,7 +810,62 @@ static struct sizes get_sizes(const Elf_
 	return ret;
 }
 
-/* Allocate and load the module */
+struct section_locate
+{
+	const char *name;
+	unsigned int *position;
+	int compulsory;
+};
+
+static int find_secs(Elf_Shdr *sechdrs,
+		     const char *secstrings,
+		     unsigned int numsections,
+		     struct section_locate locate[],
+		     unsigned int num)
+{
+	unsigned int i, j;
+
+	for (j = 0; j < num; j++)
+		*locate[j].position = 0;
+
+	for (i = 0; i < numsections; i++) {
+		const char *secname = secstrings + sechdrs[i].sh_name;
+		for (j = 0; j < num; j++) {
+			if (strcmp(locate[j].name, secname) == 0)
+				*locate[j].position = i;
+		}
+#ifndef CONFIG_MODULE_UNLOAD
+		/* Don't load .exit sections */
+		if (strstr(secname, ".exit"))
+			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
+#endif
+	}
+	for (j = 0; j < num; j++) {
+		if (!*locate[j].position && locate[j].compulsory) {
+			printk(KERN_ERR "module has no %s\n", locate[j].name);
+			return -ENOEXEC;
+		}
+	}
+	return 0;
+}
+
+static void set_license(struct module *mod, Elf_Shdr *sechdrs, int licenseidx)
+{
+	if (licenseidx)
+		mod->license = (char *)sechdrs[licenseidx].sh_offset;
+	else
+		mod->license = "unspecified";
+
+	if (module_is_gpl(mod))
+		return;
+
+	printk(KERN_WARNING "%s: module license `%s' taints kernel.\n",
+	       mod->name, mod->license);
+	tainted |= TAINT_PROPRIETORY_MODULE;
+}
+
+/* Allocate and load the module: note that size of section 0 is always
+   zero, and we rely on this for optional sections. */
 static struct module *load_module(void *umod,
 				  unsigned long len,
 				  const char *uargs)
@@ -800,14 +873,20 @@ static struct module *load_module(void *
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
 	char *secstrings;
-	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex, obsparmindex, versindex;
+	unsigned int i, symidx, exportidx, stridx, setupidx, exidx,
+		modnameidx, obsparmidx, versionidx, licenseidx, gplidx;
 	long arglen;
 	unsigned long common_length;
 	struct sizes sizes, used;
 	struct module *mod;
 	int err = 0;
 	void *ptr = NULL; /* Stops spurious gcc uninitialized warning */
+	struct section_locate loc[]
+		= { { ".symtab",&symidx,1 }, { ".modulename",&modnameidx,1 },
+		    { "__ksymtab",&exportidx,0 }, {"__gpl.ksymtab",&gplidx,0 },
+		    { ".setup.init",&setupidx,0 }, { "__ex_table",&exidx,0 },
+		    { ".obsparm",&obsparmidx,0}, { ".license",&licenseidx,0 },
+		    { ".versions",&versionidx,0}, { ".strtab",&stridx,1 } };
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -837,67 +916,10 @@ static struct module *load_module(void *
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
-	/* May not export symbols, or have setup params, so these may
-           not exist */
-	exportindex = setupindex = obsparmindex = versindex = 0;
-
-	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modnameindex = 0;
-
 	/* Find where important sections are */
-	for (i = 1; i < hdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type == SHT_SYMTAB) {
-			/* Internal symbols */
-			DEBUGP("Symbol table in section %u\n", i);
-			symindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".modulename")
-			   == 0) {
-			/* This module's name */
-			DEBUGP("Module name in section %u\n", i);
-			modnameindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
-			   == 0) {
-			/* Exported symbols. */
-			DEBUGP("EXPORT table in section %u\n", i);
-			exportindex = i;
-		} else if (strcmp(secstrings + sechdrs[i].sh_name, ".strtab")
-			   == 0) {
-			/* Strings */
-			DEBUGP("String table found in section %u\n", i);
-			strindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".setup.init")
-			   == 0) {
-			/* Setup parameter info */
-			DEBUGP("Setup table found in section %u\n", i);
-			setupindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ex_table")
-			   == 0) {
-			/* Exception table */
-			DEBUGP("Exception table found in section %u\n", i);
-			exindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".obsparm")
-			   == 0) {
-			/* Obsolete MODULE_PARM() table */
-			DEBUGP("Obsolete param found in section %u\n", i);
-			obsparmindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".versions")
-			   == 0) {
-			/* Module versioning table. */
-			DEBUGP("Symbol versions found in section %u\n", i);
-			versindex = i;
-		}
-#ifndef CONFIG_MODULE_UNLOAD
-		/* Don't load .exit sections */
-		if (strstr(secstrings+sechdrs[i].sh_name, ".exit"))
-			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
-#endif
-	}
-
-	if (!modnameindex) {
-		DEBUGP("Module has no name!\n");
-		err = -ENOEXEC;
+	err = find_secs(sechdrs, secstrings, hdr->e_shnum,loc,ARRAY_SIZE(loc));
+	if (err < 0)
 		goto free_hdr;
-	}
 
 	/* Now allocate space for the module proper, and copy name and args. */
 	err = strlen_user(uargs);
@@ -915,7 +937,7 @@ static struct module *load_module(void *
 		err = -EFAULT;
 		goto free_mod;
 	}
-	strncpy(mod->name, (char *)hdr + sechdrs[modnameindex].sh_offset,
+	strncpy(mod->name, (char *)hdr + sechdrs[modnameidx].sh_offset,
 		sizeof(mod->name)-1);
 
 	if (find_module(mod->name)) {
@@ -927,12 +949,14 @@ static struct module *load_module(void *
 	INIT_LIST_HEAD(&mod->extable.list);
 	INIT_LIST_HEAD(&mod->list);
 	INIT_LIST_HEAD(&mod->symbols.list);
-	mod->symbols.owner = mod;
+	INIT_LIST_HEAD(&mod->gpl_symbols.list);
+	mod->symbols.owner = mod->gpl_symbols.owner = mod;
+	mod->gpl_symbols.gplonly = 1;
 	module_unload_init(mod);
 
 	/* How much space will we need?  (Common area in core) */
 	sizes = get_sizes(hdr, sechdrs, secstrings);
-	common_length = read_commons(hdr, &sechdrs[symindex]);
+	common_length = read_commons(hdr, &sechdrs[symidx]);
 	sizes.core_size += common_length;
 
 	/* Set these up: arch's can add to them */
@@ -943,7 +967,6 @@ static struct module *load_module(void *
 	ptr = module_core_alloc(hdr, sechdrs, secstrings, mod);
 	if (IS_ERR(ptr))
 		goto free_mod;
-
 	mod->module_core = ptr;
 
 	ptr = module_init_alloc(hdr, sechdrs, secstrings, mod);
@@ -970,40 +993,40 @@ static struct module *load_module(void *
 	if (used.init_size > mod->init_size || used.core_size > mod->core_size)
 		BUG();
 
+	/* Set up license info based on contents of section */
+	set_license(mod, sechdrs, licenseidx);
+
 	/* Fix up syms, so that st_value is a pointer to location. */
-	err = simplify_symbols(sechdrs, symindex, strindex, versindex,
+	err = simplify_symbols(sechdrs, symidx, stridx, versionidx,
 			       mod->module_core, mod);
 	if (err < 0)
 		goto cleanup;
 
 	/* Always do SMP check for modversions. */
 	err = check_version(mod->name, "__SMP__",
-			    (void *)sechdrs[versindex].sh_offset,
-			    sechdrs[versindex].sh_size
+			    (void *)sechdrs[versionidx].sh_offset,
+			    sechdrs[versionidx].sh_size
 			    / sizeof(struct modversion_info));
 	if (err < 0)
 		goto cleanup;
 
-	/* Set up EXPORTed symbols */
-	if (exportindex) {
-		mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-					/ sizeof(*mod->symbols.syms));
-		mod->symbols.syms = (void *)sechdrs[exportindex].sh_offset;
-	}
+	/* Set up EXPORTed & EXPORT_GPLed symbols */
+	mod->symbols.num_syms = (sechdrs[exportidx].sh_size
+				 / sizeof(*mod->symbols.syms));
+	mod->symbols.syms = (void *)sechdrs[exportidx].sh_offset;
+	mod->gpl_symbols.num_syms = (sechdrs[gplidx].sh_size
+				     / sizeof(*mod->gpl_symbols.syms));
+	mod->gpl_symbols.syms = (void *)sechdrs[gplidx].sh_offset;
 
-	/* Set up exception table */
-	if (exindex) {
-		/* FIXME: Sort exception table. */
-		mod->extable.num_entries = (sechdrs[exindex].sh_size
-					    / sizeof(struct
-						     exception_table_entry));
-		mod->extable.entry = (void *)sechdrs[exindex].sh_offset;
-	}
+	/* Set up exception table. FIXME: Sort exception table. */
+	mod->extable.num_entries = (sechdrs[exidx].sh_size
+				    / sizeof(struct exception_table_entry));
+	mod->extable.entry = (void *)sechdrs[exidx].sh_offset;
 
 	/* Now handle each section. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		err = handle_section(secstrings + sechdrs[i].sh_name,
-				     sechdrs, strindex, symindex, i, mod);
+				     sechdrs, stridx, symidx, i, mod);
 		if (err < 0)
 			goto cleanup;
 	}
@@ -1012,7 +1035,7 @@ static struct module *load_module(void *
 	   put a dummy function in, because otherwise this can be a
 	   very confusing silent failure */
 	if (!mod->init) {
-		printk("%s: No init function.\n", mod->name);
+		printk(KERN_ERR "%s: No init function.\n", mod->name);
 		err = -ENOEXEC;
 		goto cleanup;
 	}
@@ -1021,20 +1044,20 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
-	if (obsparmindex) {
+	if (obsparmidx) {
 		err = obsolete_params(mod->name, mod->args,
 				      (struct obsolete_modparm *)
-				      sechdrs[obsparmindex].sh_offset,
-				      sechdrs[obsparmindex].sh_size
+				      sechdrs[obsparmidx].sh_offset,
+				      sechdrs[obsparmidx].sh_size
 				      / sizeof(struct obsolete_modparm),
-				      sechdrs, symindex,
-				      (char *)sechdrs[strindex].sh_offset);
+				      sechdrs, symidx,
+				      (char *)sechdrs[stridx].sh_offset);
 	} else {
 		/* Size of section 0 is 0, so this works well if no params */
 		err = parse_args(mod->name, mod->args,
 				 (struct kernel_param *)
-				 sechdrs[setupindex].sh_offset,
-				 sechdrs[setupindex].sh_size
+				 sechdrs[setupidx].sh_offset,
+				 sechdrs[setupidx].sh_size
 				 / sizeof(struct kernel_param),
 				 NULL);
 	}
@@ -1115,6 +1138,7 @@ sys_init_module(void *umod,
 	/* Now it's a first class citizen! */
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->symbols.list, &kernel_symbols.list);
+	list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
 	spin_unlock_irq(&modlist_lock);
 	list_add(&mod->list, &modules);
 
@@ -1179,7 +1203,12 @@ static int __init init(void)
 	/* Add kernel symbols to symbol table */
 	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
 	kernel_symbols.syms = __start___ksymtab;
+	kernel_symbols.gplonly = 0;
 	list_add(&kernel_symbols.list, &symbols);
+	kernel_gpl_symbols.num_syms = (__stop_gpl_ksymtab-__start_gpl_ksymtab);
+	kernel_gpl_symbols.syms = __start_gpl_ksymtab;
+	kernel_gpl_symbols.gplonly = 1;
+	list_add(&kernel_gpl_symbols.list, &symbols);
 
 	/* Add kernel exception table to exception tables */
 	kernel_extable.num_entries = (__stop___ex_table -__start___ex_table);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
