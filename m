Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbSK2LKR>; Fri, 29 Nov 2002 06:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSK2LKR>; Fri, 29 Nov 2002 06:10:17 -0500
Received: from dp.samba.org ([66.70.73.150]:7101 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267018AbSK2LKH>;
	Fri, 29 Nov 2002 06:10:07 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RELEASE] module-init-tools 0.8 
In-reply-to: Your message of "Thu, 28 Nov 2002 17:16:24 BST."
             <200211281616.gASGGOE6012229@bytesex.org> 
Date: Fri, 29 Nov 2002 21:00:51 +1100
Message-Id: <20021129111730.1B56C2C31E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211281616.gASGGOE6012229@bytesex.org> you write:
> Smells like a deadlock due to request_module() in some modules init
> function or something like this.

This doesn't happen on my test box for any of my modules, so I can't
really check.  But I'd appreciate it if you would try the patch below.

Thanks for the report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module init reentry fix
Author: Rusty Russell
Status: Tested on 2.5.50

D: This changes the code to drop the module_mutex() before calling the
D: module's init function, so module init functions can call
D: request_module().  This was trivial before someone broke the module
D: code to start non-live.  Now it requires us to keep info on the
D: exact module state.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.50/include/linux/module.h working-2.5.50-initlock/include/linux/module.h
--- linux-2.5.50/include/linux/module.h	2002-11-25 08:44:18.000000000 +1100
+++ working-2.5.50-initlock/include/linux/module.h	2002-11-29 18:57:25.000000000 +1100
@@ -100,12 +100,18 @@ void *__symbol_get_gpl(const char *symbo
 struct module_ref
 {
 	atomic_t count;
-} ____cacheline_aligned;
+} ____cacheline_aligned_in_smp;
+
+enum module_state
+{
+	MODULE_STATE_LIVE,
+	MODULE_STATE_COMING,
+	MODULE_STATE_GOING,
+};
 
 struct module
 {
-	/* Am I live (yet)? */
-	int live;
+	enum module_state state;
 
 	/* Member of list of modules */
 	struct list_head list;
@@ -163,6 +169,14 @@ struct module
 	char args[0];
 };
 
+/* FIXME: It'd be nice to isolate modules during init, too, so they
+   aren't used before they (may) fail.  But presently too much code
+   (IDE & SCSI) require entry into the module during init.*/
+static inline int module_is_live(struct module *mod)
+{
+	return mod->state != MODULE_STATE_GOING;
+}
+
 #ifdef CONFIG_MODULE_UNLOAD
 
 void __symbol_put(const char *symbol);
@@ -181,7 +195,7 @@ static inline int try_module_get(struct 
 
 	if (module) {
 		unsigned int cpu = get_cpu();
-		if (likely(module->live))
+		if (likely(module_is_live(module)))
 			local_inc(&module->ref[cpu].count);
 		else
 			ret = 0;
@@ -196,7 +210,7 @@ static inline void module_put(struct mod
 		unsigned int cpu = get_cpu();
 		local_dec(&module->ref[cpu].count);
 		/* Maybe they're waiting for us to drop reference? */
-		if (unlikely(!module->live))
+		if (unlikely(!module_is_live(module)))
 			wake_up_process(module->waiter);
 		put_cpu();
 	}
@@ -205,7 +219,7 @@ static inline void module_put(struct mod
 #else /*!CONFIG_MODULE_UNLOAD*/
 static inline int try_module_get(struct module *module)
 {
-	return !module || module->live;
+	return !module || module_is_live(module);
 }
 static inline void module_put(struct module *module)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.50/kernel/module.c working-2.5.50-initlock/kernel/module.c
--- linux-2.5.50/kernel/module.c	2002-11-25 08:44:19.000000000 +1100
+++ working-2.5.50-initlock/kernel/module.c	2002-11-29 18:59:48.000000000 +1100
@@ -41,6 +41,14 @@
 static DECLARE_MUTEX(module_mutex);
 LIST_HEAD(modules); /* FIXME: Accessed w/o lock on oops by some archs */
 
+/* We require a truly strong try_module_get() */
+static inline int strong_try_module_get(struct module *mod)
+{
+	if (mod && mod->state == MODULE_STATE_COMING)
+		return 0;
+	return try_module_get(mod);
+}
+
 /* Convenient structure for holding init and core sizes */
 struct sizes
 {
@@ -375,7 +383,7 @@ sys_delete_module(const char *name_user,
 	}
 
 	/* Already dying? */
-	if (!mod->live) {
+	if (mod->state == MODULE_STATE_GOING) {
 		/* FIXME: if (force), slam module count and wake up
                    waiter --RR */
 		DEBUGP("%s already dying\n", mod->name);
@@ -383,6 +391,16 @@ sys_delete_module(const char *name_user,
 		goto out;
 	}
 
+	/* Coming up?  Allow force on stuck modules. */
+	if (mod->state == MODULE_STATE_COMING) {
+		forced = try_force(flags);
+		if (!forced) {
+			/* This module can't be removed */
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
 	if (!mod->exit || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
@@ -404,7 +422,7 @@ sys_delete_module(const char *name_user,
 			ret = -EWOULDBLOCK;
 	} else {
 		mod->waiter = current;
-		mod->live = 0;
+		mod->state = MODULE_STATE_GOING;
 	}
 	restart_refcounts();
 
@@ -504,7 +523,7 @@ static inline void module_unload_free(st
 
 static inline int use_module(struct module *a, struct module *b)
 {
-	return try_module_get(b);
+	return strong_try_module_get(b);
 }
 
 static inline void module_unload_init(struct module *mod)
@@ -575,7 +594,7 @@ void *__symbol_get(const char *symbol)
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	value = __find_symbol(symbol, &ksg);
-	if (value && !try_module_get(ksg->owner))
+	if (value && !strong_try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
@@ -932,12 +951,8 @@ static struct module *load_module(void *
 		goto free_mod;
 	}
 
-	/* Initialize the lists, since they will be list_del'd if init fails */
-	INIT_LIST_HEAD(&mod->extable.list);
-	INIT_LIST_HEAD(&mod->list);
-	INIT_LIST_HEAD(&mod->symbols.list);
 	mod->symbols.owner = mod;
-	mod->live = 0;
+	mod->state = MODULE_STATE_COMING;
 	module_unload_init(mod);
 
 	/* How much space will we need?  (Common area in first) */
@@ -1094,51 +1109,39 @@ sys_init_module(void *umod,
 	flush_icache_range((unsigned long)mod->module_core,
 			   (unsigned long)mod->module_core + mod->core_size);
 
-	/* Now sew it into exception list (just in case...). */
+	/* Now sew it into the lists.  They won't access us, since
+           strong_try_module_get() will fail. */
 	spin_lock_irq(&modlist_lock);
 	list_add(&mod->extable.list, &extables);
+	list_add_tail(&mod->symbols.list, &symbols);
 	spin_unlock_irq(&modlist_lock);
+	list_add(&mod->list, &modules);
+
+	/* Drop lock so they can recurse */
+	up(&module_mutex);
 
-	/* Note, setting the mod->live to 1 here is safe because we haven't
-	 * linked the module into the system's kernel symbol table yet,
-	 * which means that the only way any other kernel code can call
-	 * into this module right now is if this module hands out entry
-	 * pointers to the other code.  We assume that no module hands out
-	 * entry pointers to the rest of the kernel unless it is ready to
-	 * have them used.
-	 */
-	mod->live = 1;
 	/* Start the module */
 	ret = mod->init ? mod->init() : 0;
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
-                   buggy refcounters. */
+		   buggy refcounters. */
+		mod->state = MODULE_STATE_GOING;
 		synchronize_kernel();
-		if (mod->unsafe) {
+		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
-			/* Mark it "live" so that they can force
-			   deletion later, and we don't keep getting
-			   woken on every decrement. */
-		} else {
-			mod->live = 0;
+		else {
+			down(&module_mutex);
 			free_module(mod);
-		}
-		up(&module_mutex);
+			up(&module_mutex);
 		return ret;
 	}
 
 	/* Now it's a first class citizen! */
-	spin_lock_irq(&modlist_lock);
-	list_add_tail(&mod->symbols.list, &symbols);
-	spin_unlock_irq(&modlist_lock);
-	list_add(&mod->list, &modules);
-
+	mod->state = MODULE_STATE_LIVE;
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 
-	/* All ok! */
-	up(&module_mutex);
 	return 0;
 }
 
