Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSKZHqy>; Tue, 26 Nov 2002 02:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbSKZHqy>; Tue, 26 Nov 2002 02:46:54 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:63905 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266286AbSKZHqw>; Tue, 26 Nov 2002 02:46:52 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]  Symbol name prefixes (e.g., `_') with the new module loader
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 26 Nov 2002 16:40:53 +0900
In-Reply-To: <20021126013330.8DC822C31D@lists.samba.org>
Message-ID: <buon0nw7p8a.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

On the v850, the elf toolchain uses a `_' prefix for all user symbols
(I'm not sure why, since most toolchains seem to have dropped this sort
of thing).

The attached patch adds the ability to deal with this, if the macro
MODULE_SYMBOL_PREFIX is defined by <asm/module.h>.  This only affects
places where symbol names come from the user, e.g., EXPORT_SYMBOL, or
the explicit symbol-names used in kernel/module.c itself.


Patch:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=module-sympfx-20021126.patch
Content-Description: module-sympfx-20021126.patch

diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/linux/module.h include/linux/module.h
--- ../orig/linux-2.5.49-uc0/include/linux/module.h	2002-11-25 10:30:09.000000000 +0900
+++ include/linux/module.h	2002-11-25 18:55:11.000000000 +0900
@@ -88,11 +88,18 @@
 void *__symbol_get_gpl(const char *symbol);
 #define symbol_get(x) ((typeof(&x))(__symbol_get(#x)))
 
+#ifdef MODULE_SYMBOL_PREFIX
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define EXPORT_SYMBOL(sym)				\
 	const struct kernel_symbol __ksymtab_##sym	\
 	__attribute__((section("__ksymtab")))		\
+	= { (unsigned long)&sym, MODULE_SYMBOL_PREFIX #sym }
+#else
+#define EXPORT_SYMBOL(sym)				\
+	const struct kernel_symbol __ksymtab_##sym	\
+	__attribute__((section("__ksymtab")))		\
 	= { (unsigned long)&sym, #sym }
+#endif
 
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/kernel/module.c kernel/module.c
--- ../orig/linux-2.5.49-uc0/kernel/module.c	2002-11-25 10:30:10.000000000 +0900
+++ kernel/module.c	2002-11-25 18:38:58.000000000 +0900
@@ -37,6 +37,17 @@
 #define DEBUGP(fmt , a...)
 #endif
 
+/* Define a handy short alias for MODULE_SYMBOL_PREFIX, defaulting
+   to "" if it isn't defined (it's also useful to avoid just
+   defining MODULE_SYMBOL_PREFIX here so that #ifdefs can still be
+   done against it).  */
+#ifdef MODULE_SYMBOL_PREFIX
+#define SYMPFX MODULE_SYMBOL_PREFIX
+#else
+#define SYMPFX ""
+#endif
+
+
 /* List of modules, protected by module_mutex */
 static DECLARE_MUTEX(module_mutex);
 LIST_HEAD(modules); /* FIXME: Accessed w/o lock on oops by some archs */
@@ -630,10 +641,10 @@
 	unsigned int i;
 
 	for (i = 1; i < sechdrs[symbolsec].sh_size/sizeof(*sym); i++) {
-		if (strcmp("__initfn", strtab + sym[i].st_name) == 0)
+		if (strcmp(SYMPFX "__initfn", strtab + sym[i].st_name) == 0)
 			mod->init = (void *)sym[i].st_value;
 #ifdef CONFIG_MODULE_UNLOAD
-		if (strcmp("__exitfn", strtab + sym[i].st_name) == 0)
+		if (strcmp(SYMPFX "__exitfn", strtab + sym[i].st_name) == 0)
 			mod->exit = (void *)sym[i].st_value;
 #endif
 	}
@@ -770,7 +781,8 @@
 						       mod,
 						       &ksg);
 			/* We fake up "__this_module" */
-			if (strcmp(strtab+sym[i].st_name, "__this_module")==0)
+			if (strcmp(strtab+sym[i].st_name,
+				   SYMPFX "__this_module")==0)
 				sym[i].st_value = (unsigned long)mod;
 		}
 	}
@@ -869,7 +881,8 @@
 			/* This module's name */
 			DEBUGP("Module name in section %u\n", i);
 			modnameindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  SYMPFX "__ksymtab")
 			   == 0) {
 			/* Exported symbols. */
 			DEBUGP("EXPORT table in section %u\n", i);
@@ -884,7 +897,8 @@
 			/* Setup parameter info */
 			DEBUGP("Setup table found in section %u\n", i);
 			setupindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ex_table")
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  SYMPFX "__ex_table")
 			   == 0) {
 			/* Exception table */
 			DEBUGP("Exception table found in section %u\n", i);

--=-=-=



Thanks,

-Miles
-- 
"1971 pickup truck; will trade for guns"

--=-=-=--
