Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265616AbSKEApl>; Mon, 4 Nov 2002 19:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265615AbSKEApl>; Mon, 4 Nov 2002 19:45:41 -0500
Received: from dp.samba.org ([66.70.73.150]:26559 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265606AbSKEApi>;
	Mon, 4 Nov 2002 19:45:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Module loader against 2.5.46: 7/9 
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-reply-to: Your message of "Tue, 05 Nov 2002 11:21:48 +1100."
             <20021105002215.8EEE22C0F8@lists.samba.org> 
Date: Tue, 05 Nov 2002 11:41:25 +1100
Message-Id: <20021105005213.DF59B2C0B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forced unload for modules "rmmod -f".  Taints the kernel, but
sometimes when you're developing or desperate, it's the best option.

Note that normal module unloading is still supported: this allows you
to unload modules with non-zero refcounts, no unload routine, or which
have been marked "unsafe" by detecting racy usages.

Linus, please apply,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Forced Module Unload
Author: Rusty Russell
Status: Experimental
Depends: Module/module.patch.gz

D: Allows the (very dangerous!) "rmmod -f" for kernel developers and
D: desperate people.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9002-linux-2.5.45/include/linux/kernel.h .9002-linux-2.5.45.updated/include/linux/kernel.h
--- .9002-linux-2.5.45/include/linux/kernel.h	2002-10-19 17:48:10.000000000 +1000
+++ .9002-linux-2.5.45.updated/include/linux/kernel.h	2002-11-01 11:52:04.000000000 +1100
@@ -102,6 +102,7 @@ extern const char *print_tainted(void);
 #define TAINT_PROPRIETORY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
+#define TAINT_FORCED_RMMOD		(1<<3)
 
 extern void dump_stack(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9002-linux-2.5.45/init/Kconfig .9002-linux-2.5.45.updated/init/Kconfig
--- .9002-linux-2.5.45/init/Kconfig	2002-11-01 11:51:08.000000000 +1100
+++ .9002-linux-2.5.45.updated/init/Kconfig	2002-11-01 11:55:00.000000000 +1100
@@ -125,6 +125,16 @@ config MODULE_UNLOAD
 	  anyway), which makes your kernel slightly smaller and
 	  simpler.  If unsure, say Y.
 
+config MODULE_FORCE_UNLOAD
+	bool "Forced module unloading"
+	depends on MODULES && EXPERIMENTAL
+	help
+	  This option allows you to force a module to unload, even if the
+	  kernel believes it is unsafe: the kernel will remove the module
+	  without waiting for anyone to stop using it (using the -f option to
+	  rmmod).  This is mainly for kernel developers and desparate users.
+	  If unsure, say N.
+
 config KMOD
 	bool "Kernel module loader"
 	depends on MODULES
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9002-linux-2.5.45/kernel/module.c .9002-linux-2.5.45.updated/kernel/module.c
--- .9002-linux-2.5.45/kernel/module.c	2002-11-01 11:51:08.000000000 +1100
+++ .9002-linux-2.5.45.updated/kernel/module.c	2002-11-01 11:52:04.000000000 +1100
@@ -335,12 +335,24 @@ static unsigned int module_refcount(stru
 /* This exists whether we can unload or not */
 static void free_module(struct module *mod);
 
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+static inline int try_force(unsigned int flags)
+{
+	return (flags & O_TRUNC);
+}
+#else
+static inline int try_force(unsigned int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_MODULE_FORCE_UNLOAD */
+
 asmlinkage long
 sys_delete_module(const char *name_user, unsigned int flags)
 {
 	struct module *mod;
 	char name[MODULE_NAME_LEN];
-	int ret;
+	int ret, forced = 0;
 
 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;
@@ -358,24 +370,29 @@ sys_delete_module(const char *name_user,
 		goto out;
 	}
 
+	if (!list_empty(&mod->modules_which_use_me)) {
+		/* Other modules depend on us: get rid of them first. */
+		ret = -EWOULDBLOCK;
+		goto out;
+	}
+
 	/* Already dying? */
 	if (!mod->live) {
+		/* FIXME: if (force), slam module count and wake up
+                   waiter --RR */
 		DEBUGP("%s already dying\n", mod->name);
 		ret = -EBUSY;
 		goto out;
 	}
 
 	if (!mod->exit || mod->unsafe) {
-		/* This module can't be removed */
-		ret = -EBUSY;
-		goto out;
-	}
-	if (!list_empty(&mod->modules_which_use_me)) {
-		/* Other modules depend on us: get rid of them first. */
-		ret = -EWOULDBLOCK;
-		goto out;
+		forced = try_force(flags);
+		if (!forced) {
+			/* This module can't be removed */
+			ret = -EBUSY;
+			goto out;
+		}
 	}
-
 	/* Stop the machine so refcounts can't move: irqs disabled. */
 	DEBUGP("Stopping refcounts...\n");
 	ret = stop_refcounts();
@@ -383,9 +400,11 @@ sys_delete_module(const char *name_user,
 		goto out;
 
 	/* If it's not unused, quit unless we are told to block. */
-	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0)
-		ret = -EWOULDBLOCK;
-	else {
+	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
+		forced = try_force(flags);
+		if (!forced)
+			ret = -EWOULDBLOCK;
+	} else {
 		mod->waiter = current;
 		mod->live = 0;
 	}
@@ -394,6 +413,9 @@ sys_delete_module(const char *name_user,
 	if (ret != 0)
 		goto out;
 
+	if (forced)
+		goto destroy;
+
 	/* Since we might sleep for some time, drop the semaphore first */
 	up(&module_mutex);
 	for (;;) {
@@ -408,10 +430,11 @@ sys_delete_module(const char *name_user,
 	DEBUGP("Regrabbing mutex...\n");
 	down(&module_mutex);
 
+ destroy:
 	/* Final destruction now noone is using it. */
-	mod->exit();
+	if (mod->exit)
+		mod->exit();
 	free_module(mod);
-	ret = 0;
 
  out:
 	up(&module_mutex);
