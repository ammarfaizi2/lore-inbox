Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTAOIQx>; Wed, 15 Jan 2003 03:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAOIQD>; Wed, 15 Jan 2003 03:16:03 -0500
Received: from dp.samba.org ([66.70.73.150]:42461 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265851AbTAOIPt>;
	Wed, 15 Jan 2003 03:15:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: [PATCH] Proposed module init race fix.
Date: Wed, 15 Jan 2003 19:24:20 +1100
Message-Id: <20030115082444.13D1A2C128@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This basically reverts the "module starts isolated" code, with a fix
for add_disk (which now explicitly says "you can't fail init after
this", and we can detect if that happens), and a notifier for other
interfaces which really want a "confirm that this is now really live"
call.

Doug, does this meet your SCSI concerns?

I put a warning if someone tries to access a module during init, to
find other any interfaces which do that.  They're fairly rare, though
(I only found out about SCSI and IDE once Linus had merged, for
example).

Once again, no modules need change (any other interfaces which require
access during module init may, however).

Thoughts?
Rusty.
PS.  Yes, it's a narrow race.  We could just say "fuck it", of course.

Name: Module init race fix
Author: Rusty Russell
Status: Experimental

D: It's possible to start using a module, and then have it fail
D: initialization.  In 2.4, this resulted in random behaviour.  One
D: solution to this is to make all interfaces two-stage: reserve
D: everything you need (which might fail), the activate them.  This
D: means changing about 1600 modules, and deprecating every interface
D: they use.
D: 
D: The method used in the original module loader patch (which got
D: hacked out) was to make the module inaccessible until init had
D: succeeded.  This is fine for most interfaces, unfortunately, it
D: breaks scsi and ide, for example, which wanted to scan partition
D: tables during init.
D: 
D: The solution offered is two-fold: for those interfaces which can
D: sanely insist that initialization not fail after they succeed, a
D: call to "module_make_live()" will activate the module immediately.
D: This means we can easily detect if the module *does* fail init
D: afterwards.
D: 
D: The second part of the solution is a notifier when a module is made
D: live: an interface can choose to do any steps which require a live
D: module then, and the module author can remain unaware of any
D: complexities.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17886-linux-2.5-bk/drivers/block/genhd.c .17886-linux-2.5-bk.updated/drivers/block/genhd.c
--- .17886-linux-2.5-bk/drivers/block/genhd.c	2003-01-13 16:56:23.000000000 +1100
+++ .17886-linux-2.5-bk.updated/drivers/block/genhd.c	2003-01-13 22:58:07.000000000 +1100
@@ -104,10 +104,13 @@ static int exact_lock(dev_t dev, void *d
  * @gp: per-device partitioning information
  *
  * This function registers the partitioning information in @gp
- * with the kernel.
+ * with the kernel.  Your init function MUST NOT FAIL after this.
  */
 void add_disk(struct gendisk *disk)
 {
+	/* It needs to be accessible so we can read partitions. */
+	make_module_live(disk->fops->owner);
+
 	disk->flags |= GENHD_FL_UP;
 	blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
 			NULL, exact_match, exact_lock, disk);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17886-linux-2.5-bk/include/linux/module.h .17886-linux-2.5-bk.updated/include/linux/module.h
--- .17886-linux-2.5-bk/include/linux/module.h	2003-01-13 16:56:29.000000000 +1100
+++ .17886-linux-2.5-bk.updated/include/linux/module.h	2003-01-13 22:52:35.000000000 +1100
@@ -49,6 +49,11 @@ search_extable(const struct exception_ta
 	       const struct exception_table_entry *last,
 	       unsigned long value);
 
+/* Want to know when a module (or kernel) is finally made live? */
+extern int module_notifier_register(struct notifier_block *n);
+extern void module_notifier_unregister(struct notifier_block *n);
+extern void module_live_notify(struct module *module);
+
 #ifdef MODULE
 
 /* For replacement modutils, use an alias not a pointer. */
@@ -230,12 +235,9 @@ struct module
 	char *args;
 };
 
-/* FIXME: It'd be nice to isolate modules during init, too, so they
-   aren't used before they (may) fail.  But presently too much code
-   (IDE & SCSI) require entry into the module during init.*/
 static inline int module_is_live(struct module *mod)
 {
-	return mod->state != MODULE_STATE_GOING;
+	return mod->state == MODULE_STATE_LIVE;
 }
 
 /* Is this address in a module? */
@@ -261,8 +263,11 @@ static inline int try_module_get(struct 
 		unsigned int cpu = get_cpu();
 		if (likely(module_is_live(module)))
 			local_inc(&module->ref[cpu].count);
-		else
+		else {
+			/* This is possible, but most likely it's reentry. */
+			WARN_ON(module->state == MODULE_STATE_COMING);
 			ret = 0;
+		}
 		put_cpu();
 	}
 	return ret;
@@ -300,6 +305,12 @@ static inline void module_put(struct mod
 	__mod ? __mod->name : "kernel";		\
 })
 
+static inline void module_make_live(struct module *module)
+{
+	if (module)
+		module->state = MODULE_STATE_LIVE;
+}
+
 #define __unsafe(mod)							     \
 do {									     \
 	if (mod && !(mod)->unsafe) {					     \
@@ -353,6 +364,8 @@ static inline void module_put(struct mod
 
 #define module_name(mod) "kernel"
 
+#define module_make_live(mod)
+
 #define __unsafe(mod)
 
 /* For kallsyms to ask for address resolution.  NULL means not found. */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17886-linux-2.5-bk/include/linux/notifier.h .17886-linux-2.5-bk.updated/include/linux/notifier.h
--- .17886-linux-2.5-bk/include/linux/notifier.h	2003-01-02 12:32:49.000000000 +1100
+++ .17886-linux-2.5-bk.updated/include/linux/notifier.h	2003-01-13 22:52:35.000000000 +1100
@@ -66,5 +66,6 @@ extern int notifier_call_chain(struct no
 #define CPU_OFFLINE	0x0005 /* CPU (unsigned)v offline (still scheduling) */
 #define CPU_DEAD	0x0006 /* CPU (unsigned)v dead */
 
+#define MODULE_LIVE	0x0001 /* Module (struct module *)v is live */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17886-linux-2.5-bk/init/main.c .17886-linux-2.5-bk.updated/init/main.c
--- .17886-linux-2.5-bk/init/main.c	2003-01-10 10:55:43.000000000 +1100
+++ .17886-linux-2.5-bk.updated/init/main.c	2003-01-13 22:52:35.000000000 +1100
@@ -359,6 +359,24 @@ static void rest_init(void)
  	cpu_idle();
 } 
 
+static struct notifier_block *module_notifier;
+
+/* Want to know when a module (or kernel) is finally made live? */
+int module_notifier_register(struct notifier_block *n)
+{
+	return notifier_chain_register(&module_notifier, n);
+}
+
+void module_notifier_unregister(struct notifier_block *n)
+{
+	notifier_chain_unregister(n);
+}
+
+void module_live_notify(struct module *module)
+{
+	notifier_call_chain(module_notifier, MODULE_LIVE, module);
+}
+
 /*
  *	Activate the first processor.
  */
@@ -465,6 +483,8 @@ static void __init do_initcalls(void)
 
 	/* Make sure there is no pending stuff from the initcall sequence */
 	flush_scheduled_work();
+
+	module_live_notify(NULL);
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17886-linux-2.5-bk/kernel/module.c .17886-linux-2.5-bk.updated/kernel/module.c
--- .17886-linux-2.5-bk/kernel/module.c	2003-01-13 16:56:30.000000000 +1100
+++ .17886-linux-2.5-bk.updated/kernel/module.c	2003-01-13 22:52:35.000000000 +1100
@@ -60,14 +60,6 @@ static LIST_HEAD(modules);
 static LIST_HEAD(symbols);
 static LIST_HEAD(extables);
 
-/* We require a truly strong try_module_get() */
-static inline int strong_try_module_get(struct module *mod)
-{
-	if (mod && mod->state == MODULE_STATE_COMING)
-		return 0;
-	return try_module_get(mod);
-}
-
 /* Stub function for modules which don't have an initfn */
 int init_module(void)
 {
@@ -562,7 +554,7 @@ static inline void module_unload_free(st
 
 static inline int use_module(struct module *a, struct module *b)
 {
-	return strong_try_module_get(b);
+	return try_module_get(b);
 }
 
 static inline void module_unload_init(struct module *mod)
@@ -779,7 +771,7 @@ void *__symbol_get(const char *symbol)
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	value = __find_symbol(symbol, &ksg, 1);
-	if (value && !strong_try_module_get(ksg->owner))
+	if (value && !try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
@@ -1285,7 +1277,7 @@ sys_init_module(void *umod,
 			   (unsigned long)mod->module_core + mod->core_size);
 
 	/* Now sew it into the lists.  They won't access us, since
-           strong_try_module_get() will fail. */
+           try_module_get() will fail. */
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
 	list_add_tail(&mod->symbols.list, &symbols);
@@ -1299,6 +1291,10 @@ sys_init_module(void *umod,
 	/* Start the module */
 	ret = mod->init();
 	if (ret < 0) {
+		/* If made active, it shouldn't be failing! */
+		if (mod->state == MODULE_STATE_LIVE)
+			__unsafe(mod);
+
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
@@ -1320,6 +1316,7 @@ sys_init_module(void *umod,
 	mod->module_init = NULL;
 	mod->init_size = 0;
 
+	module_live_notify(mod);
 	return 0;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
