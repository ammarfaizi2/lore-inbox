Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSLBBXn>; Sun, 1 Dec 2002 20:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLBBXm>; Sun, 1 Dec 2002 20:23:42 -0500
Received: from dp.samba.org ([66.70.73.150]:16019 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263204AbSLBBXf>;
	Sun, 1 Dec 2002 20:23:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v850 support
Date: Mon, 02 Dec 2002 12:29:42 +1100
Message-Id: <20021202013103.327B82C303@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This from Miles Bader (NEC V850 maintainer) and myself: their
toolchain prefixes user symbols with "_", so requires some minor
modifications (asm-v850/module.h defines MODULE_SYMBOL_PREFIX to "_").

He said this works fine,
Rusty.

Name: symbol prefix support for v850
Author: Miles Bader
Status: Experimental

D: On the v850, the elf toolchain uses a `_' prefix for all user symbols
D: (I'm not sure why, since most toolchains seem to have dropped this sort
D: of thing).
D: 
D: The attached patch adds the ability to deal with this, if the macro
D: MODULE_SYMBOL_PREFIX is defined by <asm/module.h>.  This only affects
D: places where symbol names come from the user, e.g., EXPORT_SYMBOL, or
D: the explicit symbol-names used in kernel/module.c itself.
D: 
D: [Tweaked a little by Rusty]

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9619-linux-2.5.50/include/linux/module.h .9619-linux-2.5.50.updated/include/linux/module.h
--- .9619-linux-2.5.50/include/linux/module.h	2002-11-25 08:44:18.000000000 +1100
+++ .9619-linux-2.5.50.updated/include/linux/module.h	2002-11-29 13:22:32.000000000 +1100
@@ -31,6 +31,11 @@
 #define MODULE_PARM_DESC(var,desc)
 #define print_modules()
 
+/* v850 toolchain uses a `_' prefix for all user symbols */
+#ifndef MODULE_SYMBOL_PREFIX
+#define MODULE_SYMBOL_PREFIX ""
+#endif
+
 #define MODULE_NAME_LEN (64 - sizeof(unsigned long))
 struct kernel_symbol
 {
@@ -86,13 +91,13 @@ struct exception_table
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
+#define symbol_get(x) ((typeof(&x))(__symbol_get(MODULE_SYMBOL_PREFIX #x)))
 
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define EXPORT_SYMBOL(sym)				\
 	const struct kernel_symbol __ksymtab_##sym	\
 	__attribute__((section("__ksymtab")))		\
-	= { (unsigned long)&sym, #sym }
+	= { (unsigned long)&sym, MODULE_SYMBOL_PREFIX #sym }
 
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
@@ -166,7 +171,7 @@ struct module
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
-#define symbol_put(x) __symbol_put(#x)
+#define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
 void symbol_put_addr(void *addr);
 
 /* We only need protection against local interrupts. */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9619-linux-2.5.50/kernel/module.c .9619-linux-2.5.50.updated/kernel/module.c
--- .9619-linux-2.5.50/kernel/module.c	2002-11-25 08:44:19.000000000 +1100
+++ .9619-linux-2.5.50.updated/kernel/module.c	2002-11-29 13:20:21.000000000 +1100
@@ -37,6 +37,9 @@
 #define DEBUGP(fmt , a...)
 #endif
 
+#define symbol_is(literal, string)				\
+	(strcmp(MODULE_SYMBOL_PREFIX literal, (string)) == 0)
+
 /* List of modules, protected by module_mutex */
 static DECLARE_MUTEX(module_mutex);
 LIST_HEAD(modules); /* FIXME: Accessed w/o lock on oops by some archs */
@@ -630,10 +633,10 @@ static int grab_private_symbols(Elf_Shdr
 	unsigned int i;
 
 	for (i = 1; i < sechdrs[symbolsec].sh_size/sizeof(*sym); i++) {
-		if (strcmp("__initfn", strtab + sym[i].st_name) == 0)
+		if (symbol_is("__initfn", strtab + sym[i].st_name))
 			mod->init = (void *)sym[i].st_value;
 #ifdef CONFIG_MODULE_UNLOAD
-		if (strcmp("__exitfn", strtab + sym[i].st_name) == 0)
+		if (symbol_is("__exitfn", strtab + sym[i].st_name))
 			mod->exit = (void *)sym[i].st_value;
 #endif
 	}
@@ -770,7 +773,7 @@ static void simplify_symbols(Elf_Shdr *s
 						       mod,
 						       &ksg);
 			/* We fake up "__this_module" */
-			if (strcmp(strtab+sym[i].st_name, "__this_module")==0)
+			if (symbol_is("__this_module", strtab+sym[i].st_name))
 				sym[i].st_value = (unsigned long)mod;
 		}
 	}

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
