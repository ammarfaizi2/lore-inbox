Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSKYGFb>; Mon, 25 Nov 2002 01:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSKYGFb>; Mon, 25 Nov 2002 01:05:31 -0500
Received: from dp.samba.org ([66.70.73.150]:41916 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262450AbSKYGF2>;
	Mon, 25 Nov 2002 01:05:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, kai-germaschewski@uiowa.edu, dwmw2@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modname fix
Date: Mon, 25 Nov 2002 17:11:46 +1100
Message-Id: <20021125061243.182D22C099@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Kai's solution to the nameless module problem, which I like
very much.  dwmw2, I will fix the dummy problem by implementing "-o"
in modprobe 0.8.

This patch is tested: on 614 modules, each ended up with the correct
name.  Thanks Kai!

Rusty.

Name: Module Name Solution
Author: Kai Germaschewski
Depends: Module/module.patch.gz

D: Well, I have another solution, which doesn't need additional Makefile 
D: magic or anything.
D: 
D: I just put the module name into each .o file where <linux/module.h> is 
D: included. Putting it into the section .gnu.linkonce.modname has the effect
D: that even for multi-part modules, we only end up with one copy of the 
D: name.
D: 
D: Caveat: I'm using the preprocessor macro KBUILD_MODNAME to know what to 
D: put into .gnu.linkonce.modname. The following used to happen:
D: 
D: (drivers/isdn/eicon/Makefile)
D: 
D: divas-objs := common.o Divas_mod.o ...
D: eicon-objs := common.o eicon_mod.o ...
D: 
D: Divas_mod.o is compiled with -DKBUILD_MODNAME=divas
D: eicon_mod.o is compiled with -DKBUILD_MODNAME=eicon
D: common.o is compiled with -DKBUILD_MODNAME=divas_eicon
D: 
D: So in the case above, both divas.o and eicon.o would end up with
D: a .gnu.linkonce.modname section containing "divas_eicon"
D: 
D: My fix to this is to not define KBUILD_MODNAME when compiling an object 
D: whilch will be linked into more than one module - so common.o gets no 
D: .gnu.linkonce.modname section at all. Works fine here.
D: 
D: Now, doing this I remove one of the reasons why we would need modules 
D: linked as '.ko' ;), but it seems much cleaner than generating a temporary 
D: file, using objcopy etc.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.49/include/linux/init.h working-2.5.49-modname/include/linux/init.h
--- linux-2.5.49/include/linux/init.h	Tue Nov 19 09:58:51 2002
+++ working-2.5.49-modname/include/linux/init.h	Mon Nov 25 14:30:26 2002
@@ -125,14 +125,6 @@ extern struct kernel_param __setup_start
  */
 #define module_exit(x)	__exitcall(x);
 
-/**
- * no_module_init - code needs no initialization.
- *
- * The equivalent of declaring an empty init function which returns 0.
- * Every module must have exactly one module_init() or no_module_init
- * invocation.  */
-#define no_module_init
-
 #else /* MODULE */
 
 /* Don't use these in modules, but some people do... */
@@ -144,11 +136,6 @@ extern struct kernel_param __setup_start
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
 
-/* Each module knows its own name. */
-#define __DEFINE_MODULE_NAME						\
-	char __module_name[] __attribute__((section(".modulename"))) =	\
-	__stringify(KBUILD_MODNAME)
-
 /* These macros create a dummy inline: gcc 2.9x does not count alias
  as usage, hence the `unused function' warning when __init functions
  are declared static. We use the dummy __*_module_inline functions
@@ -157,12 +144,9 @@ extern struct kernel_param __setup_start
 
 /* Each module must use one module_init(), or one no_module_init */
 #define module_init(initfn)					\
-	__DEFINE_MODULE_NAME;					\
 	static inline initcall_t __inittest(void)		\
 	{ return initfn; }					\
 	int __initfn(void) __attribute__((alias(#initfn)));
-
-#define no_module_init __DEFINE_MODULE_NAME
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.49/include/linux/module.h working-2.5.49-modname/include/linux/module.h
--- linux-2.5.49/include/linux/module.h	Mon Nov 25 08:44:18 2002
+++ working-2.5.49-modname/include/linux/module.h	Mon Nov 25 14:35:57 2002
@@ -40,6 +40,11 @@ struct kernel_symbol
 
 #ifdef MODULE
 
+#ifdef KBUILD_MODNAME
+static const char __module_name[MODULE_NAME_LEN] __attribute__((section(".gnu.linkonce.modname"))) = \
+  __stringify(KBUILD_MODNAME);
+#endif
+
 #define MODULE_GENERIC_TABLE(gtype,name)	\
 static const unsigned long __module_##gtype##_size \
   __attribute__ ((unused)) = sizeof(struct gtype##_id); \
@@ -306,12 +311,7 @@ extern int module_dummy_usage;
 /* Old-style "I'll just call it init_module and it'll be run at
    insert".  Use module_init(myroutine) instead. */
 #ifdef MODULE
-/* Used as "int init_module(void) { ... }".  Get funky to insert modname. */
-#define init_module(voidarg)						\
-	__initfn(void);							\
-	char __module_name[] __attribute__((section(".modulename"))) =	\
-	__stringify(KBUILD_MODNAME);					\
-	int __initfn(void)
+#define init_module(voidarg) __initfn(void)
 #define cleanup_module(voidarg) __exitfn(void)
 #endif
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.49/kernel/module.c working-2.5.49-modname/kernel/module.c
--- linux-2.5.49/kernel/module.c	Mon Nov 25 08:44:19 2002
+++ working-2.5.49-modname/kernel/module.c	Mon Nov 25 14:35:40 2002
@@ -864,8 +864,8 @@ static struct module *load_module(void *
 			/* Internal symbols */
 			DEBUGP("Symbol table in section %u\n", i);
 			symindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".modulename")
-			   == 0) {
+		} else if (strcmp(secstrings+sechdrs[i].sh_name,
+				  ".gnu.linkonce.modname") == 0) {
 			/* This module's name */
 			DEBUGP("Module name in section %u\n", i);
 			modnameindex = i;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.49/lib/zlib_deflate/deflate_syms.c working-2.5.49-modname/lib/zlib_deflate/deflate_syms.c
--- linux-2.5.49/lib/zlib_deflate/deflate_syms.c	Tue Nov 19 09:58:52 2002
+++ working-2.5.49-modname/lib/zlib_deflate/deflate_syms.c	Mon Nov 25 13:55:31 2002
@@ -19,5 +19,3 @@ EXPORT_SYMBOL(zlib_deflateReset);
 EXPORT_SYMBOL(zlib_deflateCopy);
 EXPORT_SYMBOL(zlib_deflateParams);
 MODULE_LICENSE("GPL");
-
-no_module_init;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.49/lib/zlib_inflate/inflate_syms.c working-2.5.49-modname/lib/zlib_inflate/inflate_syms.c
--- linux-2.5.49/lib/zlib_inflate/inflate_syms.c	Tue Nov 19 09:58:52 2002
+++ working-2.5.49-modname/lib/zlib_inflate/inflate_syms.c	Mon Nov 25 13:55:31 2002
@@ -20,5 +20,3 @@ EXPORT_SYMBOL(zlib_inflateReset);
 EXPORT_SYMBOL(zlib_inflateSyncPoint);
 EXPORT_SYMBOL(zlib_inflateIncomp); 
 MODULE_LICENSE("GPL");
-
-no_module_init;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.49/scripts/Makefile.lib working-2.5.49-modname/scripts/Makefile.lib
--- linux-2.5.49/scripts/Makefile.lib	Mon Nov 25 08:44:19 2002
+++ working-2.5.49-modname/scripts/Makefile.lib	Mon Nov 25 13:55:31 2002
@@ -124,14 +124,14 @@ depfile = $(subst $(comma),_,$(@D)/.$(@F
 #       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
 #       where foo and bar are the name of the modules.
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
-modname_flags  = -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname)))
+modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
 c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
 	         $(basename_flags) $(modname_flags) $(export_flags) 
 
 # Finds the multi-part object the current object will be linked into
-modname-multi = $(subst $(space),_,$(sort $(foreach m,$(multi-used),\
-		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=)))))
+modname-multi = $(sort $(foreach m,$(multi-used),\
+		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
 
 # Shipped files
 # ===========================================================================

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
