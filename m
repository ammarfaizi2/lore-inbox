Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbSLWIdu>; Mon, 23 Dec 2002 03:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLWIdu>; Mon, 23 Dec 2002 03:33:50 -0500
Received: from dp.samba.org ([66.70.73.150]:9693 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266702AbSLWIdp>;
	Mon, 23 Dec 2002 03:33:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Embed __this_module in module itself.
Date: Mon, 23 Dec 2002 19:38:41 +1100
Message-Id: <20021223084155.8C2D22C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please check out this patch, which embeds the module structure into
the module itself (in ".gnu.linkonce.this_module").  Slight
simplification, and gives Dave that page back, as I promised.

Testers welcome,
Rusty.

Name: Embedded __this_module
Author: Rusty Russell
Status: Tested in 2.5.52

D: This makes __this_module a real symbol for modules, rather than
D: allocating at load time.  This makes things a little simpler, and
D: also saves about a page on architectures which have their own
D: module allocator (eg. Sparc64).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/include/linux/module.h working-2.5.52-thismodule/include/linux/module.h
--- linux-2.5.52/include/linux/module.h	Tue Dec 17 08:10:39 2002
+++ working-2.5.52-thismodule/include/linux/module.h	Mon Dec 23 16:37:53 2002
@@ -42,11 +42,6 @@ struct kernel_symbol
 
 #ifdef MODULE
 
-#ifdef KBUILD_MODNAME
-static const char __module_name[MODULE_NAME_LEN] __attribute__((section(".gnu.linkonce.modname"))) = \
-  __stringify(KBUILD_MODNAME);
-#endif
-
 /* For replacement modutils, use an alias not a pointer. */
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 static const unsigned long __module_##gtype##_size		\
@@ -56,9 +51,6 @@ static const struct gtype##_id * __modul
 extern const struct gtype##_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 
-/* This is magically filled in by the linker, but THIS_MODULE must be
-   a constant so it works in initializers. */
-extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
 
 #else  /* !MODULE */
@@ -176,7 +174,7 @@ struct module
 
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
-	char args[0];
+	char *args;
 };
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
@@ -288,6 +286,11 @@ static inline const char *module_address
 	return NULL;
 }
 #endif /* CONFIG_MODULES */
+
+#ifdef MODULE
+/* This defines __this_module. */
+#include <linux/thismodule.h>
+#endif
 
 /* For archs to search exception tables */
 extern struct list_head extables;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/include/linux/thismodule.h working-2.5.52-thismodule/include/linux/thismodule.h
--- linux-2.5.52/include/linux/thismodule.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.52-thismodule/include/linux/thismodule.h	Mon Dec 23 16:10:04 2002
@@ -0,0 +1,19 @@
+#ifndef _LINUX_THISMODULE_H
+#define _LINUX_THISMODULE_H
+/* This stub is linked into every module. */
+
+/* These could be defined in the module, or will resolve to the kernel stubs */
+extern int __initfn(void);
+extern void __exitfn(void);
+
+/* We use the linker to do some of the work for us. */
+static struct module __this_module
+__attribute__((section(".gnu.linkonce.this_module"))) = {
+	.name = __stringify(KBUILD_MODNAME),
+	.symbols = { .owner = &__this_module },
+	.init = __initfn,
+#ifdef CONFIG_MODULE_UNLOAD
+	.exit = __exitfn,
+#endif
+};
+#endif /* MODULE */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/kernel/module.c working-2.5.52-thismodule/kernel/module.c
--- linux-2.5.52/kernel/module.c	Tue Dec 17 08:11:03 2002
+++ working-2.5.52-thismodule/kernel/module.c	Mon Dec 23 16:37:14 2002
@@ -32,7 +32,7 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
-#if 0
+#if 1
 #define DEBUGP printk
 #else
 #define DEBUGP(fmt , a...)
@@ -60,6 +60,13 @@ struct sizes
 	unsigned long core_size;
 };
 
+/* Stub function for modules which don't have an initfn */
+int __initfn(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(__initfn);
+
 /* Find a symbol, return value and the symbol group */
 static unsigned long __find_symbol(const char *name,
 				   struct kernel_symbol_group **group)
@@ -357,6 +364,12 @@ static inline int try_force(unsigned int
 }
 #endif /* CONFIG_MODULE_FORCE_UNLOAD */
 
+/* Stub function for modules which don't have an exitfn */
+void __exitfn(void)
+{
+}
+EXPORT_SYMBOL(__exitfn);
+
 asmlinkage long
 sys_delete_module(const char *name_user, unsigned int flags)
 {
@@ -405,7 +418,7 @@ sys_delete_module(const char *name_user,
 		}
 	}
 
-	if (!mod->exit || mod->unsafe) {
+	if (mod->exit == __exitfn || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -452,8 +465,7 @@ sys_delete_module(const char *name_user,
 
  destroy:
 	/* Final destruction now noone is using it. */
-	if (mod->exit)
-		mod->exit();
+	mod->exit();
 	free_module(mod);
 
  out:
@@ -473,7 +485,7 @@ static void print_unload_info(struct seq
 	if (mod->unsafe)
 		seq_printf(m, " [unsafe]");
 
-	if (!mod->exit)
+	if (mod->exit == __exitfn)
 		seq_printf(m, " [permanent]");
 
 	seq_printf(m, "\n");
@@ -715,6 +727,7 @@ static void free_module(struct module *m
 	module_unload_free(mod);
 
 	/* Finally, free the module structure */
+	kfree(mod->args);
 	module_free(mod, mod);
 }
 
@@ -770,27 +783,6 @@ static void *copy_section(const char *na
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
@@ -809,9 +801,6 @@ static int handle_section(const char *na
 	case SHT_RELA:
 		ret = apply_relocate_add(sechdrs, strtab, symindex, i, mod);
 		break;
-	case SHT_SYMTAB:
-		ret = grab_private_symbols(sechdrs, i, strtab, mod);
-		break;
 	default:
 		DEBUGP("Ignoring section %u: %s\n", i,
 		       sechdrs[i].sh_type==SHT_NULL ? "NULL":
@@ -919,9 +908,6 @@ static void simplify_symbols(Elf_Shdr *s
 						       strtab + sym[i].st_name,
 						       mod,
 						       &ksg);
-			/* We fake up "__this_module" */
-			if (symbol_is("__this_module", strtab+sym[i].st_name))
-				sym[i].st_value = (unsigned long)mod;
 		}
 	}
 }
@@ -963,9 +949,9 @@ static struct module *load_module(void *
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
@@ -1006,7 +992,7 @@ static struct module *load_module(void *
 	exportindex = setupindex = obsparmindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modnameindex = 0;
+	symindex = strindex = exindex = modindex = 0;
 
 	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1015,10 +1001,10 @@ static struct module *load_module(void *
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
@@ -1057,30 +1043,28 @@ static struct module *load_module(void *
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
+	if (copy_from_user(args, uargs, arglen) != 0) {
 		err = -EFAULT;
 		goto free_mod;
 	}
-	strncpy(mod->name, (char *)hdr + sechdrs[modnameindex].sh_offset,
-		sizeof(mod->name)-1);
 
 	if (find_module(mod->name)) {
 		err = -EEXIST;
@@ -1089,7 +1073,6 @@ static struct module *load_module(void *
 
 	mod->symbols.owner = mod;
 	mod->state = MODULE_STATE_COMING;
-	module_unload_init(mod);
 
 	/* How much space will we need?  (Common area in first) */
 	common_length = read_commons(hdr, &sechdrs[symindex]);
@@ -1138,6 +1121,9 @@ static struct module *load_module(void *
 			if (IS_ERR(ptr))
 				goto cleanup;
 			sechdrs[i].sh_offset = (unsigned long)ptr;
+			/* Have we just copied __this_module across? */ 
+			if (i == modindex)
+				mod = ptr;
 		} else {
 			sechdrs[i].sh_offset += (unsigned long)hdr;
 		}
@@ -1146,6 +1132,9 @@ static struct module *load_module(void *
 	if (used.init_size > mod->init_size || used.core_size > mod->core_size)
 		BUG();
 
+	/* Now we've moved module, initialize linked lists, etc. */
+	module_unload_init(mod);
+
 	/* Fix up syms, so that st_value is a pointer to location. */
 	simplify_symbols(sechdrs, symindex, strindex, mod->module_core, mod);
 
@@ -1182,6 +1171,7 @@ static struct module *load_module(void *
 	if (err < 0)
 		goto cleanup;
 
+	mod->args = args;
 	if (obsparmindex) {
 		err = obsolete_params(mod->name, mod->args,
 				      (struct obsolete_modparm *)
@@ -1214,7 +1204,7 @@ static struct module *load_module(void *
  free_core:
 	module_free(mod, mod->module_core);
  free_mod:
-	module_free(mod, mod);
+	kfree(args);
  free_hdr:
 	vfree(hdr);
 	if (err < 0) return ERR_PTR(err);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
