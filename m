Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261888AbSIYDfb>; Tue, 24 Sep 2002 23:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSIYDYS>; Tue, 24 Sep 2002 23:24:18 -0400
Received: from dp.samba.org ([66.70.73.150]:44928 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261893AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 15/20: Forced Unload Support
Date: Wed, 25 Sep 2002 13:18:53 +1000
Message-Id: <20020925032201.B2EAB2C134@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Forced Module Unload
Author: Rusty Russell
Status: Experimental
Depends: Module/module-license.patch.gz

D: Allows the (very dangerous!) "rmmod -f" for kernel developers and
D: desperate people.  It is currently under CONFIG_DEBUG_KERNEL, but it
D: could be moved out.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10910-linux-2.5.38/arch/i386/Config.help .10910-linux-2.5.38.updated/arch/i386/Config.help
--- .10910-linux-2.5.38/arch/i386/Config.help	2002-09-18 16:04:37.000000000 +1000
+++ .10910-linux-2.5.38.updated/arch/i386/Config.help	2002-09-25 02:00:14.000000000 +1000
@@ -976,3 +976,10 @@ CONFIG_SOFTWARE_SUSPEND
   absence of features.
 
   For more information take a look at Documentation/swsusp.txt.
+
+CONFIG_MODULE_FORCE_UNLOAD
+  This option allows you to force a module to unload, even if the
+  kernel believes it is unsafe: the kernel will remove the module
+  without waiting for anyone to stop using it (using the -F option to
+  rmmod).  This is mainly for kernel developers.  In unsure, say N.
+
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10910-linux-2.5.38/arch/i386/config.in .10910-linux-2.5.38.updated/arch/i386/config.in
--- .10910-linux-2.5.38/arch/i386/config.in	2002-09-21 13:55:07.000000000 +1000
+++ .10910-linux-2.5.38.updated/arch/i386/config.in	2002-09-25 02:00:14.000000000 +1000
@@ -436,6 +436,7 @@ if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; th
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
+   dep_bool '  Forced module removal' CONFIG_MODULE_FORCE_UNLOAD $CONFIG_MODULE_UNLOAD
 fi
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10910-linux-2.5.38/include/linux/kernel.h .10910-linux-2.5.38.updated/include/linux/kernel.h
--- .10910-linux-2.5.38/include/linux/kernel.h	2002-09-25 01:59:44.000000000 +1000
+++ .10910-linux-2.5.38.updated/include/linux/kernel.h	2002-09-25 02:00:14.000000000 +1000
@@ -95,6 +95,7 @@ extern const char *print_tainted(void);
 #define TAINT_PROPRIETORY_MODULE	(1<<0)
 #define TAINT_FORCED_MODULE		(1<<1)
 #define TAINT_UNSAFE_SMP		(1<<2)
+#define TAINT_FORCED_RMMOD		(1<<3)
 
 extern void dump_stack(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10910-linux-2.5.38/init/Config.help .10910-linux-2.5.38.updated/init/Config.help
--- .10910-linux-2.5.38/init/Config.help	2002-09-25 01:59:50.000000000 +1000
+++ .10910-linux-2.5.38.updated/init/Config.help	2002-09-25 02:00:14.000000000 +1000
@@ -93,7 +93,7 @@ CONFIG_MODULES
 
 CONFIG_MODULE_UNLOAD
   Without this option you will not be able to unload any modules (note
-  that some modules may not be unloadable anyway).  This makes your
+  that some modules may not be unloadable anyway), which makes your
   kernel slightly smaller and simpler.  If unsure, say Y.
 
 CONFIG_OBSOLETE_MODPARM
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .10910-linux-2.5.38/kernel/module.c .10910-linux-2.5.38.updated/kernel/module.c
--- .10910-linux-2.5.38/kernel/module.c	2002-09-25 01:59:51.000000000 +1000
+++ .10910-linux-2.5.38.updated/kernel/module.c	2002-09-25 02:01:30.000000000 +1000
@@ -191,12 +191,24 @@ static void module_unload_free(struct mo
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
@@ -214,9 +226,12 @@ sys_delete_module(const char *name_user,
 		goto out;
 	}
 	if (!mod->exit || mod->unsafe_to_unload) {
-		/* This module can't be removed */
-		ret = -EBUSY;
-		goto out;
+		forced = try_force(flags);
+		if (!forced) {
+			/* This module can't be removed */
+			ret = -EBUSY;
+			goto out;
+		}
 	}
 	if (!list_empty(&mod->modules_which_use_me)) {
 		/* Other modules depend on us: get rid of them first. */
@@ -242,29 +257,42 @@ sys_delete_module(const char *name_user,
 
 	/* If they don't want to wait, and refcount non-zero, bring it
            back to life and report that we lost. */
-	if (((flags & O_NONBLOCK) && bigref_approx_val(&mod->use) != 0)
-	    || mod->unsafe_to_unload) {
-		mod->live = 1;
-		try_module_get(mod); /* Can't fail */
-		spin_lock_irq(&modlist_lock);
-		list_add(&mod->symbols.list, &kernel_symbols.list);
-		list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
-		spin_unlock_irq(&modlist_lock);
-		ret = -EWOULDBLOCK;
-		goto out;
-	}
+	if ((flags & O_NONBLOCK) && bigref_approx_val(&mod->use) != 0)
+		if (!(forced = try_force(flags)))
+			goto reanimate;
 
-	/* Since it's not live, this should monotonically decrease. */
-	bigref_wait_for_zero(&mod->use);
+	/* It may have just become unsafe */
+	if (mod->unsafe_to_unload)
+		if (!(forced = try_force(flags)))
+			goto reanimate;
+
+	/* Since it's not live, count should monotonically decrease. */
+	if (!forced)
+		bigref_wait_for_zero(&mod->use);
+	else {
+		printk(KERN_WARNING "Forced removal of %s.\n", mod->name);
+		tainted |= TAINT_FORCED_RMMOD;
+	}
 
 	/* Final destruction now noone is using it. */
-	mod->exit();
+	if (mod->exit)
+		mod->exit();
 	free_module(mod);
 	ret = 0;
 
  out:
 	up(&module_mutex);
 	return ret;
+
+ reanimate:
+	mod->live = 1;
+	try_module_get(mod); /* Can't fail */
+	spin_lock_irq(&modlist_lock);
+	list_add(&mod->symbols.list, &kernel_symbols.list);
+	list_add(&mod->gpl_symbols.list, &kernel_symbols.list);
+	spin_unlock_irq(&modlist_lock);
+	ret = -EWOULDBLOCK;
+	goto out;
 }
 
 static void print_unload_info(struct seq_file *m, struct module *mod)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
