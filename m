Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTEII2K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTEII2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:28:10 -0400
Received: from dp.samba.org ([66.70.73.150]:54711 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262361AbTEII2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:28:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bump module ref during init.
Date: Fri, 09 May 2003 18:40:01 +1000
Message-Id: <20030509084045.792762C0F8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, __module_get is technically allowed during module init,
because the module is being held in by its non-live state.  But doing
so triggers the BUG(), so bump the refcount during init.

Also cleans up unload code a little, making it clearer. 

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Hold Initial Reference To Module
Author: Rusty Russell
Status: Tested on 2.5.69-bk3

D: __module_get is theoretically allowed on module inside init, since
D: we already hold an implicit reference.  Currently this BUG()s: make
D: the reference count explicit, which also simplifies delete path.
D: Also cleans up unload path, such that it only drops semaphore when
D: it's actually sleeping for rmmod --wait.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7932-linux-2.5.69/kernel/module.c .7932-linux-2.5.69.updated/kernel/module.c
--- .7932-linux-2.5.69/kernel/module.c	2003-05-05 12:37:13.000000000 +1000
+++ .7932-linux-2.5.69.updated/kernel/module.c	2003-05-07 12:47:45.000000000 +1000
@@ -214,6 +214,8 @@ static void module_unload_init(struct mo
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
 		atomic_set(&mod->ref[i].count, 0);
+	/* Hold reference count during initialization. */
+	atomic_set(&mod->ref[smp_processor_id()].count, 1);
 	/* Backwards compatibility macros put refcount during init. */
 	mod->waiter = current;
 }
@@ -462,6 +464,21 @@ void cleanup_module(void)
 }
 EXPORT_SYMBOL(cleanup_module);
 
+static void wait_for_zero_refcount(struct module *mod)
+{
+	/* Since we might sleep for some time, drop the semaphore first */
+	up(&module_mutex);
+	for (;;) {
+		DEBUGP("Looking at refcount...\n");
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (module_refcount(mod) == 0)
+			break;
+		schedule();
+	}
+	current->state = TASK_RUNNING;
+	down(&module_mutex);
+}
+
 asmlinkage long
 sys_delete_module(const char __user *name_user, unsigned int flags)
 {
@@ -500,16 +517,6 @@ sys_delete_module(const char __user *nam
 		goto out;
 	}
 
-	/* Coming up?  Allow force on stuck modules. */
-	if (mod->state == MODULE_STATE_COMING) {
-		forced = try_force(flags);
-		if (!forced) {
-			/* This module can't be removed */
-			ret = -EBUSY;
-			goto out;
-		}
-	}
-
 	/* If it has an init func, it must have an exit func to unload */
 	if ((mod->init != init_module && mod->exit == cleanup_module)
 	    || mod->unsafe) {
@@ -529,35 +536,22 @@ sys_delete_module(const char __user *nam
 	/* If it's not unused, quit unless we are told to block. */
 	if ((flags & O_NONBLOCK) && module_refcount(mod) != 0) {
 		forced = try_force(flags);
-		if (!forced)
+		if (!forced) {
 			ret = -EWOULDBLOCK;
-	} else {
-		mod->waiter = current;
-		mod->state = MODULE_STATE_GOING;
+			restart_refcounts();
+			goto out;
+		}
 	}
-	restart_refcounts();
-
-	if (ret != 0)
-		goto out;
-
-	if (forced)
-		goto destroy;
 
-	/* Since we might sleep for some time, drop the semaphore first */
-	up(&module_mutex);
-	for (;;) {
-		DEBUGP("Looking at refcount...\n");
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (module_refcount(mod) == 0)
-			break;
-		schedule();
-	}
-	current->state = TASK_RUNNING;
+	/* Mark it as dying. */
+	mod->waiter = current;
+	mod->state = MODULE_STATE_GOING;
+	restart_refcounts();
 
-	DEBUGP("Regrabbing mutex...\n");
-	down(&module_mutex);
+	/* Never wait if forced. */
+	if (!forced && module_refcount(mod) != 0)
+		wait_for_zero_refcount(mod);
 
- destroy:
 	/* Final destruction now noone is using it. */
 	mod->exit();
 	free_module(mod);
@@ -1448,6 +1442,7 @@ sys_init_module(void __user *umod,
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
 		else {
+			module_put(mod);
 			down(&module_mutex);
 			free_module(mod);
 			up(&module_mutex);
@@ -1458,6 +1453,8 @@ sys_init_module(void __user *umod,
 	/* Now it's a first class citizen! */
 	down(&module_mutex);
 	mod->state = MODULE_STATE_LIVE;
+	/* Drop initial reference. */
+	module_put(mod);
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
