Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbTCYGWP>; Tue, 25 Mar 2003 01:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCYGWP>; Tue, 25 Mar 2003 01:22:15 -0500
Received: from dp.samba.org ([66.70.73.150]:57802 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261470AbTCYGWK>;
	Tue, 25 Mar 2003 01:22:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sf.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Module load notification take 3 
In-reply-to: Your message of "Tue, 25 Mar 2003 02:03:16 -0000."
             <20030325020316.GA95492@compsoc.man.ac.uk> 
Date: Tue, 25 Mar 2003 17:32:33 +1100
Message-Id: <20030325063320.843BD2C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030325020316.GA95492@compsoc.man.ac.uk> you write:
> 
> Implement a module load notifier for the benefit of OProfile, tested
> with .66 on UP.

Minor change to make unregister_module_notifier return void.

Either way Linus, don't really mind.  Please apply.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Notifier Patch
Author: John Levon
Status: Experimental

D: Adds a notifier for when modules are inserted, for use of oprofile.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17066-linux-2.5.66/include/linux/module.h .17066-linux-2.5.66.updated/include/linux/module.h
--- .17066-linux-2.5.66/include/linux/module.h	2003-03-25 12:17:31.000000000 +1100
+++ .17066-linux-2.5.66.updated/include/linux/module.h	2003-03-25 17:31:06.000000000 +1100
@@ -138,6 +138,7 @@ struct exception_table
 	const struct exception_table_entry *entry;
 };
 
+struct notifier_block;
 
 #ifdef CONFIG_MODULES
 
@@ -348,6 +349,9 @@ const char *module_address_lookup(unsign
 /* For extable.c to search modules' exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr);
 
+int register_module_notifier(struct notifier_block *nb);
+void unregister_module_notifier(struct notifier_block *nb);
+
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
@@ -392,6 +396,17 @@ static inline const char *module_address
 {
 	return NULL;
 }
+
+static inline int register_module_notifier(struct notifier_block *nb)
+{
+	/* no events will happen anyway, so this can always succeed */
+	return 0;
+}
+
+static inline void unregister_module_notifier(struct notifier_block *nb)
+{
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17066-linux-2.5.66/kernel/module.c .17066-linux-2.5.66.updated/kernel/module.c
--- .17066-linux-2.5.66/kernel/module.c	2003-03-18 05:01:52.000000000 +1100
+++ .17066-linux-2.5.66.updated/kernel/module.c	2003-03-25 17:31:06.000000000 +1100
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/vermagic.h>
+#include <linux/notifier.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/pgalloc.h>
@@ -61,6 +62,27 @@ static LIST_HEAD(modules);
 static LIST_HEAD(symbols);
 static LIST_HEAD(extables);
 
+static DECLARE_MUTEX(notify_mutex);
+static struct notifier_block *module_notify_list;
+
+int register_module_notifier(struct notifier_block * nb)
+{
+	int err;
+	down(&notify_mutex);
+	err = notifier_chain_register(&module_notify_list, nb);
+	up(&notify_mutex);
+	return err;
+}
+EXPORT_SYMBOL(register_module_notifier);
+
+void unregister_module_notifier(struct notifier_block * nb)
+{
+	down(&notify_mutex);
+	notifier_chain_unregister(&module_notify_list, nb);
+	up(&notify_mutex);
+}
+EXPORT_SYMBOL(unregister_module_notifier);
+
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
 {
@@ -1368,6 +1390,10 @@ sys_init_module(void *umod,
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
+	up(&notify_mutex);
+
 	/* Start the module */
 	ret = mod->init();
 	if (ret < 0) {
