Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSL0KgP>; Fri, 27 Dec 2002 05:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSL0Kf2>; Fri, 27 Dec 2002 05:35:28 -0500
Received: from dp.samba.org ([66.70.73.150]:53391 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264875AbSL0KfK>;
	Fri, 27 Dec 2002 05:35:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Embed __this_module in module itself.
Date: Fri, 27 Dec 2002 21:25:39 +1100
Message-Id: <20021227104328.143DD2C05D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Oops, forgot to CC lkml on this to Linus, and people might want to see ]

Linus, please apply.

	Rather than have the module loader the module structure and
resolve the symbols __this_module to it, make __this_module a real
structure inside the module, using the linkonce trick we used for
module names.

	This saves us an allocation (saving a page per module on
archs which need the module structure close by), and means we don't
have to fill in a few module fields.

Works fine here.  Requires the previous "Overzealous permenant mark
removed" patch, otherwise you'll get some rejects.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Embedded __this_module
Author: Rusty Russell
Status: Tested in 2.5.52
Depends: Module/module-noexit.patch.gz

D: This makes __this_module a real symbol for modules, rather than
D: allocating at load time.  This makes things a little simpler, and
D: also saves about a page on architectures which have their own
D: module allocator (eg. Sparc64).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1411-2.5.53-embedded-thismodule.pre/include/linux/init.h .1411-2.5.53-embedded-thismodule/include/linux/init.h
--- .1411-2.5.53-embedded-thismodule.pre/include/linux/init.h	2002-12-17 08:10:38.000000000 +1100
+++ .1411-2.5.53-embedded-thismodule/include/linux/init.h	2002-12-27 21:05:37.000000000 +1100
@@ -147,14 +147,13 @@ struct obs_kernel_param {
 #define module_init(initfn)					\
 	static inline initcall_t __inittest(void)		\
 	{ return initfn; }					\
-	int __initfn(void) __attribute__((alias(#initfn)));
+	int init_module(void) __attribute__((alias(#initfn)));
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
 	static inline exitcall_t __exittest(void)		\
 	{ return exitfn; }					\
-	void __exitfn(void) __attribute__((alias(#exitfn)));
-
+	void cleanup_module(void) __attribute__((alias(#exitfn)));
 
 #define __setup(str,func) /* nothing */
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1411-2.5.53-embedded-thismodule.pre/include/linux/module.h .1411-2.5.53-embedded-thismodule/include/linux/module.h
--- .1411-2.5.53-embedded-thismodule.pre/include/linux/module.h	2002-12-17 08:10:39.000000000 +1100
+++ .1411-2.5.53-embedded-thismodule/include/linux/module.h	2002-12-27 21:05:37.000000000 +1100
@@ -40,12 +40,11 @@ struct kernel_symbol
 	char name[MODULE_NAME_LEN];
 };
 
-#ifdef MODULE
+/* These are either module local, or the kernel's dummy ones. */
+extern int init_module(void);
+extern void cleanup_module(void);
 
-#ifdef KBUILD_MODNAME
-static const char __module_name[MODULE_NAME_LEN] __attribute__((section(".gnu.linkonce.modname"))) = \
-  __stringify(KBUILD_MODNAME);
-#endif
+#ifdef MODULE
 
 /* For replacement modutils, use an alias not a pointer. */
 #define MODULE_GENERIC_TABLE(gtype,name)			\
@@ -56,9 +55,6 @@ static const struct gtype##_id * __modul
 extern const struct gtype##_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 
-/* This is magically filled in by the linker, but THIS_MODULE must be
-   a constant so it works in initializers. */
-extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
 
 #else  /* !MODULE */
@@ -176,7 +172,7 @@ struct module
 
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
-	char args[0];
+	char *args;
 };
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
@@ -289,6 +285,19 @@ static inline const char *module_address
 }
 #endif /* CONFIG_MODULES */
 
+#if defined(MODULE) && defined(KBUILD_MODNAME)
+/* We make the linker do some of the work. */
+struct module __this_module
+__attribute__((section(".gnu.linkonce.this_module"))) = {
+	.name = __stringify(KBUILD_MODNAME),
+	.symbols = { .owner = &__this_module },
+	.init = init_module,
+#ifdef CONFIG_MODULE_UNLOAD
+	.exit = cleanup_module,
+#endif
+};
+#endif /* MODULE && KBUILD_MODNAME */
+
 /* For archs to search exception tables */
 extern struct list_head extables;
 extern spinlock_t modlist_lock;
@@ -342,13 +351,6 @@ extern int module_dummy_usage;
   && __mod_between((p),(n),(m)->module_init,(m)->init_size))	\
  || __mod_between((p),(n),(m)->module_core,(m)->core_size))
 
-/* Old-style "I'll just call it init_module and it'll be run at
-   insert".  Use module_init(myroutine) instead. */
-#ifdef MODULE
-#define init_module(voidarg) __initfn(void)
-#define cleanup_module(voidarg) __exitfn(void)
-#endif
-
 /*
  * The exception and symbol tables, and the lock
  * to protect them.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1411-2.5.53-embedded-thismodule.pre/kernel/module.c .1411-2.5.53-embedded-thismodule/kernel/module.c
--- .1411-2.5.53-embedded-thismodule.pre/kernel/module.c	2002-12-27 21:05:37.000000000 +1100
+++ .1411-2.5.53-embedded-thismodule/kernel/module.c	2002-12-27 21:05:37.000000000 +1100
@@ -60,6 +60,13 @@ struct sizes
 	unsigned long core_size;
 };
 
+/* Stub function for modules which don't have an initfn */
+int init_module(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(init_module);
+
 /* Find a symbol, return value and the symbol group */
 static unsigned long __find_symbol(const char *name,
 				   struct kernel_symbol_group **group)
@@ -357,6 +364,12 @@ static inline int try_force(unsigned int
 }
 #endif /* CONFIG_MODULE_FORCE_UNLOAD */
 
+/* Stub function for modules which don't have an exitfn */
+void cleanup_module(void)
+{
+}
+EXPORT_SYMBOL(cleanup_module);
+
 asmlinkage long
 sys_delete_module(const char *name_user, unsigned int flags)
 {
@@ -406,7 +419,8 @@ sys_delete_module(const char *name_user,
 	}
 
 	/* If it has an init func, it must have an exit func to unload */
-	if ((mod->init && !mod->exit) || mod->unsafe) {
+	if ((mod->init != init_module && mod->exit == cleanup_module)
+	    || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -453,8 +467,7 @@ sys_delete_module(const char *name_user,
 
  destroy:
 	/* Final destruction now noone is using it. */
-	if (mod->exit)
-		mod->exit();
+	mod->exit();
 	free_module(mod);
 
  out:
@@ -474,7 +487,7 @@ static void print_unload_info(struct seq
 	if (mod->unsafe)
 		seq_printf(m, " [unsafe]");
 
-	if (mod->init && !mod->exit)
+	if (mod->init != init_module && mod->exit == cleanup_module)
 		seq_printf(m, " [permanent]");
 
 	seq_printf(m, "\n");
@@ -708,15 +721,15 @@ static void free_module(struct module *m
 	list_del(&mod->extable.list);
 	spin_unlock_irq(&modlist_lock);
 
-	/* These may be NULL, but that's OK */
-	module_free(mod, mod->module_init);
-	module_free(mod, mod->module_core);
-
 	/* Module unload stuff */
 	module_unload_free(mod);
 
-	/* Finally, free the module structure */
-	module_free(mod, mod);
+	/* This may be NULL, but that's OK */
+	module_free(mod, mod->module_init);
+	kfree(mod->args);
+
+	/* Finally, free the core (containing the module structure) */
+	module_free(mod, mod->module_core);
 }
 
 void *__symbol_get(const char *symbol)
@@ -771,27 +784,6 @@ static void *copy_section(const char *na
 	return dest;
 }
 
-/* Look for the special symbols */
-static int grab_private_symbols(Elf_Shdr *sechdrs,
-				unsigned int symbolsec,
-				const char *strtab,
-				struct module *mod)
-{
-	Elf_Sym *sym = (void *)sechdrs[symbolsec].sh_offset;
-	unsigned int i;
-
-	for (i = 1; i < sechdrs[symbolsec].sh_size/sizeof(*sym); i++) {
-		if (symbol_is("__initfn", strtab + sym[i].st_name))
-			mod->init = (void *)sym[i].st_value;
-#ifdef CONFIG_MODULE_UNLOAD
-		if (symbol_is("__exitfn", strtab + sym[i].st_name))
-			mod->exit = (void *)sym[i].st_value;
-#endif
-	}
-
-	return 0;
-}
-
 /* Deal with the given section */
 static int handle_section(const char *name,
 			  Elf_Shdr *sechdrs,
@@ -810,9 +802,6 @@ static int handle_section(const char *na
 	case SHT_RELA:
 		ret = apply_relocate_add(sechdrs, strtab, symindex, i, mod);
 		break;
-	case SHT_SYMTAB:
-		ret = grab_private_symbols(sechdrs, i, strtab, mod);
-		break;
 	default:
 		DEBUGP("Ignoring section %u: %s\n", i,
 		       sechdrs[i].sh_type==SHT_NULL ? "NULL":
@@ -920,9 +909,6 @@ static void simplify_symbols(Elf_Shdr *s
 						       strtab + sym[i].st_name,
 						       mod,
 						       &ksg);
-			/* We fake up "__this_module" */
-			if (symbol_is("__this_module", strtab+sym[i].st_name))
-				sym[i].st_value = (unsigned long)mod;
 		}
 	}
 }
@@ -964,9 +950,9 @@ static struct module *load_module(void *
 {
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
-	char *secstrings;
+	char *secstrings, *args;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex, obsparmindex;
+		modindex, obsparmindex;
 	long arglen;
 	unsigned long common_length;
 	struct sizes sizes, used;
@@ -1007,7 +993,7 @@ static struct module *load_module(void *
 	exportindex = setupindex = obsparmindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modnameindex = 0;
+	symindex = strindex = exindex = modindex = 0;
 
 	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1016,10 +1002,10 @@ static struct module *load_module(void *
 			DEBUGP("Symbol table in section %u\n", i);
 			symindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  ".gnu.linkonce.modname") == 0) {
-			/* This module's name */
-			DEBUGP("Module name in section %u\n", i);
-			modnameindex = i;
+				  ".gnu.linkonce.this_module") == 0) {
+			/* The module struct */
+			DEBUGP("Module in section %u\n", i);
+			modindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
 			   == 0) {
 			/* Exported symbols. */
@@ -1058,39 +1044,35 @@ static struct module *load_module(void *
 #endif
 	}
 
-	if (!modnameindex) {
-		DEBUGP("Module has no name!\n");
+	if (!modindex) {
+		printk(KERN_WARNING "No module found in object\n");
 		err = -ENOEXEC;
 		goto free_hdr;
 	}
+	mod = (void *)hdr + sechdrs[modindex].sh_offset;
 
-	/* Now allocate space for the module proper, and copy name and args. */
+	/* Now copy in args */
 	err = strlen_user(uargs);
 	if (err < 0)
 		goto free_hdr;
 	arglen = err;
 
-	mod = module_alloc(sizeof(*mod) + arglen+1);
-	if (!mod) {
+	args = kmalloc(arglen+1, GFP_KERNEL);
+	if (!args) {
 		err = -ENOMEM;
 		goto free_hdr;
 	}
-	memset(mod, 0, sizeof(*mod) + arglen+1);
-	if (copy_from_user(mod->args, uargs, arglen) != 0) {
+	if (copy_from_user(args, uargs, arglen+1) != 0) {
 		err = -EFAULT;
 		goto free_mod;
 	}
-	strncpy(mod->name, (char *)hdr + sechdrs[modnameindex].sh_offset,
-		sizeof(mod->name)-1);
 
 	if (find_module(mod->name)) {
 		err = -EEXIST;
 		goto free_mod;
 	}
 
-	mod->symbols.owner = mod;
 	mod->state = MODULE_STATE_COMING;
-	module_unload_init(mod);
 
 	/* How much space will we need?  (Common area in first) */
 	common_length = read_commons(hdr, &sechdrs[symindex]);
@@ -1139,6 +1121,9 @@ static struct module *load_module(void *
 			if (IS_ERR(ptr))
 				goto cleanup;
 			sechdrs[i].sh_offset = (unsigned long)ptr;
+			/* Have we just copied __this_module across? */ 
+			if (i == modindex)
+				mod = ptr;
 		} else {
 			sechdrs[i].sh_offset += (unsigned long)hdr;
 		}
@@ -1147,6 +1132,9 @@ static struct module *load_module(void *
 	if (used.init_size > mod->init_size || used.core_size > mod->core_size)
 		BUG();
 
+	/* Now we've moved module, initialize linked lists, etc. */
+	module_unload_init(mod);
+
 	/* Fix up syms, so that st_value is a pointer to location. */
 	simplify_symbols(sechdrs, symindex, strindex, mod->module_core, mod);
 
@@ -1183,6 +1171,7 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
+	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
 				      (struct obsolete_modparm *)
@@ -1215,7 +1204,7 @@ static struct module *load_module(void *
  free_core:
 	module_free(mod, mod->module_core);
  free_mod:
-	module_free(mod, mod);
+	kfree(args);
  free_hdr:
 	vfree(hdr);
 	if (err < 0) return ERR_PTR(err);
@@ -1266,7 +1255,7 @@ sys_init_module(void *umod,
 	up(&module_mutex);
 
 	/* Start the module */
-	ret = mod->init ? mod->init() : 0;
+	ret = mod->init();
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
