Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbSIYDZT>; Tue, 24 Sep 2002 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSIYDYg>; Tue, 24 Sep 2002 23:24:36 -0400
Received: from dp.samba.org ([66.70.73.150]:45440 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261896AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       Daniel Phillips <phillips@arcor.de>
Subject: [PATCH] Module rewrite 17/20: module_fini()
Date: Wed, 25 Sep 2002 13:19:09 +1000
Message-Id: <20020925032201.BC43A2C13A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Whether you agree with the gradual conversion to module_fini() as an
  auditing process, the documentation is probably worthwhile ]

Name: module_fini() function for audited drivers
Author: Rusty Russell
Status: Experimental
Depends: Module/module_put_return-i386.patch.gz

D: This patch adds module_fini(), which modules which require
D: unloading can implement, once they are sure they are safe for
D: unload.  module_unload() now does nothing in modules except for
D: "rmmod -f".  The requirements for module-friendly interfaces are
D: also documented.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15488-linux-2.5.38/Documentation/module-writing.txt .15488-linux-2.5.38.updated/Documentation/module-writing.txt
--- .15488-linux-2.5.38/Documentation/module-writing.txt	1970-01-01 10:00:00.000000000 +1000
+++ .15488-linux-2.5.38.updated/Documentation/module-writing.txt	2002-09-25 02:05:11.000000000 +1000
@@ -0,0 +1,112 @@
+Writing Modules and the Interfaces To Be Used By Them: A Gentle Guide.
+Copyright 2002, Rusty Russell IBM Corportation
+
+Modules are running parts of the kernel which can be added, and
+sometimes removed, while the kernel is operational.
+
+There are several delicate issues involved in this procedure which
+indicate special care should be taken.
+
+There are three cases you need to be careful:
+
+1) Any code which creates an interface for callbacks (ie. almost any
+   function called register_*)
+	=> See Rule #1
+
+2) Any modules which use (old) interfaces which do not obey Rule #1
+	=> See Rule #2
+
+3) Any modules which expose callback routines in other ways
+   (eg. setting the destructor function in an sk_buff)
+	=> See Rule #2
+
+
+Rule #1: Module-safe Interfaces.  Any interface which allows
+	registration of callbacks, must also allow registration of a
+	"struct module *owner", either in the structure or as a
+	function parameter, and it must use them to protect the
+	callbacks.  See "MAKING INTERFACES SAFE".
+
+Exception #1: As an optimization, you may skip this protection if you
+	   *know* that the callbacks are non-preemtible and never
+	   sleep (eg. registration of interrupt handlers).
+
+
+Rule #2: Modules using unsafe interfaces.  If your module is using any
+	interface which does not obey rule number 1, that means your
+	module functions may be called from the rest of the kernel
+	without the caller first doing a successful try_module_get().
+
+	You must not register a "module_fini" handler, and your module
+	cannot be unloaded except by force.  You must be especially
+	careful in this case with initialization: see "INITIALIZING
+	MODULES WHICH USE UNSAFE INTERFACES".
+
+Exception #2: If there is some special reason why an interface does
+	  not protect its callbacks, you may still allow unforced
+	  unloading as described in "SELF PROTECTING MODULES",
+	  although it is not recommended.
+
+
+MAKING INTERFACES SAFE
+
+A caller must always call "try_module_get()" on a function pointers's
+owner before calling through that function pointer.  If
+"try_module_get()" returns 0 (false), the function pointer must *not*
+be called, and the caller should pretend that registration does not
+exist: this means the (module) owner is closing down and doesn't want
+any more calls, or in the process of starting up and isn't ready yet.
+
+For many interfaces, this can be optimized by assuming that a
+structure containing function pointers has the same owner, and knowing
+that one function is always called before the others, such as the
+filesystem code which knows a mount must succeed before any other
+methods can be accessed.
+
+You must call "module_put()" on the owner sometime after you have
+called the function(s).
+
+If you cannot make your interface module-safe in this way, you can at
+least split registration into a "reserve" stage and an "activate"
+stage, so that modules can use the interface, even if they cannot
+(easily) unload.
+
+
+INITIALIZING MODULES WHICH USE UNSAFE INTERFACES
+
+Safe interfaces will never enter your module before module_init() has
+successfully finished, but unsafe interfaces may.  The rule is simple:
+your init_module() function *must* succeed (by returning 0) if it has
+successfully used any unsafe interfaces.
+
+So, if you are only using ONE unsafe interface, simply use that
+interface last.  Otherwise you will have to use printk() to report
+failure and leave the module initialized (but possibly useless).
+
+
+SELF PROTECTING MODULES
+
+Modules which wish to use unsafe interfaces and nonetheless allow
+themselves to be unloaded must follow two rules:
+
+1) Your functions must *never* sleep or be preempted without first
+   seizing a reference count using "try_module_get(THIS_MODULE)".  If
+   this fails, you must exit the function without sleeping.
+
+2) You must use "module_put_return()" to decrement your own reference
+   count, and you must return to a function *outside* your module.
+
+This means that if any of your functions are called without preemption
+disabled, your module cannot be safely unloaded and you should must
+not use "module_fini()".  Similarly, if your module ever does
+"module_put(THIS_MODULE)" it cannot be safely unloaded and you must
+not use "module_fini()".
+
+
+If you have questions about how to apply this document to your own
+modules, please ask rusty@rustcorp.com.au or
+linux-kernel@vger.kernel.org.
+
+Thankyou,
+Rusty.
+
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15488-linux-2.5.38/include/linux/init.h .15488-linux-2.5.38.updated/include/linux/init.h
--- .15488-linux-2.5.38/include/linux/init.h	2002-09-25 02:04:46.000000000 +1000
+++ .15488-linux-2.5.38.updated/include/linux/init.h	2002-09-25 02:05:11.000000000 +1000
@@ -104,14 +104,14 @@ typedef void (*exitcall_t)(void);
 #define module_init(x)	__initcall(x);
 
 /**
- * module_exit() - driver exit entry point
+ * module_fini() - exit hook for removable drivers
  * @x: function to be run when driver is removed
  * 
- * module_exit() will wrap the driver clean-up code
- * with cleanup_module() when used with rmmod when
- * the driver is a module.  If the driver is statically
- * compiled into the kernel, module_exit() has no effect.
- */
+ * module_fini() will be called when your driver is about to be
+ * removed, if CONFIG_MODULE_UNLOAD=y and you implement this.
+ * To use this, you must be very careful: see
+ * Documentation/module-writing.txt.  */
+#define module_fini(x)	__exitcall(x)
 #define module_exit(x)	__exitcall(x);
 
 #else /* MODULE */
@@ -135,12 +135,18 @@ typedef void (*exitcall_t)(void);
 	{ return initfn; }					\
 	int __initfn(void) __attribute__((alias(#initfn)));
 
-/* This is only required if you want to be unloadable. */
+/* This is only required if you want to be unloadable.  Be very
+ * careful, see Documentation/module-writing.txt.  */
+#define module_fini(finifn)					\
+	static inline exitcall_t __finitest(void)		\
+	{ return finifn; }					\
+	void __exitfn(void) __attribute__((alias(#finifn)))
+
+/* Deprecated: now only used in the rmmod -F case. */
 #define module_exit(exitfn)					\
-	static inline exitcall_t __exittest(void)		\
+ 	static inline exitcall_t __exittest(void)		\
 	{ return exitfn; }					\
-	void __exitfn(void) __attribute__((alias(#exitfn)));
-
+	void __force_exitfn(void) __attribute__((alias(#exitfn)));
 
 #define __setup(str,func) /* nothing */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15488-linux-2.5.38/include/linux/module.h .15488-linux-2.5.38.updated/include/linux/module.h
--- .15488-linux-2.5.38/include/linux/module.h	2002-09-25 02:04:47.000000000 +1000
+++ .15488-linux-2.5.38.updated/include/linux/module.h	2002-09-25 02:05:11.000000000 +1000
@@ -179,6 +179,7 @@ struct module
 
 	/* Destruction function. */
 	void (*exit)(void);
+	void (*force_exit)(void);
 #endif
 
 	/* The command line arguments (may be mangled).  People like
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15488-linux-2.5.38/kernel/module.c .15488-linux-2.5.38.updated/kernel/module.c
--- .15488-linux-2.5.38/kernel/module.c	2002-09-25 02:04:47.000000000 +1000
+++ .15488-linux-2.5.38.updated/kernel/module.c	2002-09-25 02:06:45.000000000 +1000
@@ -279,6 +279,9 @@ sys_delete_module(const char *name_user,
 	/* Final destruction now noone is using it. */
 	if (mod->exit)
 		mod->exit();
+	else if (mod->force_exit) /* Forced removal of obsolete module */
+		mod->force_exit();
+
 	free_module(mod);
 	ret = 0;
 
@@ -659,6 +662,8 @@ static int grab_private_symbols(Elf_Shdr
 #ifdef CONFIG_MODULE_UNLOAD
 		if (strcmp("__exitfn", strtab + sym[i].st_name) == 0)
 			mod->exit = (void *)sym[i].st_value;
+		if (strcmp("__force_exitfn", strtab + sym[i].st_name) == 0)
+			mod->force_exit = (void *)sym[i].st_value;
 #endif
 	}
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
