Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUA1A5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUA1A5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:57:52 -0500
Received: from dp.samba.org ([66.70.73.150]:49581 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265461AbUA1A5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:57:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core 
In-reply-to: Your message of "Mon, 26 Jan 2004 10:51:14 CDT."
             <Pine.LNX.4.44L0.0401261016530.822-100000@ida.rowland.org> 
Date: Wed, 28 Jan 2004 09:55:04 +1100
Message-Id: <20040128005801.403242C069@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44L0.0401261016530.822-100000@ida.rowland.org> you write:
> Create a new module entry point, the module_unreg routine.  For all
> existing modules this entry point would be undefined and hence not used.  

Just use the notifier, which already exists, just needs a few more
points.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: More Module Notifiers
Author: Rusty Russell
Status: Trivial

D: Put in the rest of the module notifiers, esp. one when a module is being
D: removed.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test5-bk2/include/linux/module.h working-2.6.0-test5-bk2-nat-expect/include/linux/module.h
--- linux-2.6.0-test5-bk2/include/linux/module.h	2003-07-31 01:50:19.000000000 +1000
+++ working-2.6.0-test5-bk2-nat-expect/include/linux/module.h	2003-09-21 15:24:09.000000000 +1000
@@ -180,6 +180,7 @@ enum module_state
 	MODULE_STATE_LIVE,
 	MODULE_STATE_COMING,
 	MODULE_STATE_GOING,
+	MODULE_STATE_GONE, /* Only for notifier: module about to be freed */
 };
 
 struct module
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test5-bk2/kernel/module.c working-2.6.0-test5-bk2-nat-expect/kernel/module.c
--- linux-2.6.0-test5-bk2/kernel/module.c	2003-09-09 10:35:05.000000000 +1000
+++ working-2.6.0-test5-bk2-nat-expect/kernel/module.c	2003-09-21 15:22:36.000000000 +1000
@@ -83,6 +83,13 @@ int unregister_module_notifier(struct no
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+static void module_notify(struct module *mod, enum module_state state)
+{
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, state, mod);
+	up(&notify_mutex);
+}
+
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
 {
@@ -723,12 +730,15 @@ sys_delete_module(const char __user *nam
 	mod->state = MODULE_STATE_GOING;
 	restart_refcounts();
 
+	module_notify(mod, MODULE_STATE_GOING);
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
 
 	/* Final destruction now noone is using it. */
 	mod->exit();
+	module_notify(mod, MODULE_STATE_GONE);
 	free_module(mod);
 
  out:
@@ -1718,9 +1728,7 @@ sys_init_module(void __user *umod,
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
-	down(&notify_mutex);
-	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
-	up(&notify_mutex);
+	module_notify(mod, MODULE_STATE_COMING);
 
 	/* Start the module */
 	ret = mod->init();
@@ -1728,12 +1736,14 @@ sys_init_module(void __user *umod,
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
+		module_notify(mod, MODULE_STATE_GOING);
 		synchronize_kernel();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
 		else {
 			module_put(mod);
+			module_notify(mod, MODULE_STATE_GONE);
 			down(&module_mutex);
 			free_module(mod);
 			up(&module_mutex);
@@ -1751,6 +1761,7 @@ sys_init_module(void __user *umod,
 	mod->init_size = 0;
 	mod->init_text_size = 0;
 	up(&module_mutex);
+	module_notify(mod, MODULE_STATE_LIVE);
 
 	return 0;
 }
