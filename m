Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbSLMC6N>; Thu, 12 Dec 2002 21:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267363AbSLMC6N>; Thu, 12 Dec 2002 21:58:13 -0500
Received: from dp.samba.org ([66.70.73.150]:478 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267357AbSLMC6F>;
	Thu, 12 Dec 2002 21:58:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kees.bakker@altium.nl (Kees Bakker)
Subject: [PATCH] Module init reentry fix
Date: Fri, 13 Dec 2002 13:44:56 +1100
Message-Id: <20021213030554.1498F2C305@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

In some configurations, parport and bttv request a module inside their
module_init function.  Drop the lock around mod->init(), change
module->live to module->state so we can detect modules which are in
init.

Survives stress_modules.sh here for a few hours, and according to
Kees, does fix the problem.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module init reentry fix
Author: Rusty Russell
Status: Tested on 2.5.51

D: This changes the code to drop the module_mutex() before calling the
D: module's init function, so module init functions can call
D: request_module().  This was trivial before someone broke the module
D: code to start non-live.  Now it requires us to keep info on the
D: exact module state.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27854-linux-2.5.51/include/linux/module.h .27854-linux-2.5.51.updated/include/linux/module.h
--- .27854-linux-2.5.51/include/linux/module.h	2002-12-10 15:56:53.000000000 +1100
+++ .27854-linux-2.5.51.updated/include/linux/module.h	2002-12-12 11:31:28.000000000 +1100
@@ -116,10 +116,16 @@ struct module_ref
 	atomic_t count;
 } ____cacheline_aligned;
 
+enum module_state
+{
+	MODULE_STATE_LIVE,
+	MODULE_STATE_COMING,
+	MODULE_STATE_GOING,
+};
+
 struct module
 {
-	/* Am I live (yet)? */
-	int live;
+	enum module_state state;
 
 	/* Member of list of modules */
 	struct list_head list;
@@ -177,6 +183,14 @@ struct module
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
@@ -195,7 +209,7 @@ static inline int try_module_get(struct 
 
 	if (module) {
 		unsigned int cpu = get_cpu();
-		if (likely(module->live))
+		if (likely(module_is_live(module)))
 			local_inc(&module->ref[cpu].count);
 		else
 			ret = 0;
@@ -210,7 +224,7 @@ static inline void module_put(struct mod
 		unsigned int cpu = get_cpu();
 		local_dec(&module->ref[cpu].count);
 		/* Maybe they're waiting for us to drop reference? */
-		if (unlikely(!module->live))
+		if (unlikely(!module_is_live(module)))
 			wake_up_process(module->waiter);
 		put_cpu();
 	}
@@ -219,7 +233,7 @@ static inline void module_put(struct mod
 #else /*!CONFIG_MODULE_UNLOAD*/
 static inline int try_module_get(struct module *module)
 {
-	return !module || module->live;
+	return !module || module_is_live(module);
 }
 static inline void module_put(struct module *module)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27854-linux-2.5.51/kernel/module.c .27854-linux-2.5.51.updated/kernel/module.c
--- .27854-linux-2.5.51/kernel/module.c	2002-12-10 15:56:54.000000000 +1100
+++ .27854-linux-2.5.51.updated/kernel/module.c	2002-12-12 11:31:28.000000000 +1100
@@ -44,6 +44,14 @@
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
@@ -378,7 +386,7 @@ sys_delete_module(const char *name_user,
 	}
 
 	/* Already dying? */
-	if (!mod->live) {
+	if (mod->state == MODULE_STATE_GOING) {
 		/* FIXME: if (force), slam module count and wake up
                    waiter --RR */
 		DEBUGP("%s already dying\n", mod->name);
@@ -386,6 +394,16 @@ sys_delete_module(const char *name_user,
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
@@ -407,7 +425,7 @@ sys_delete_module(const char *name_user,
 			ret = -EWOULDBLOCK;
 	} else {
 		mod->waiter = current;
-		mod->live = 0;
+		mod->state = MODULE_STATE_GOING;
 	}
 	restart_refcounts();
 
@@ -507,7 +525,7 @@ static inline void module_unload_free(st
 
 static inline int use_module(struct module *a, struct module *b)
 {
-	return try_module_get(b);
+	return strong_try_module_get(b);
 }
 
 static inline void module_unload_init(struct module *mod)
@@ -578,7 +596,7 @@ void *__symbol_get(const char *symbol)
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	value = __find_symbol(symbol, &ksg);
-	if (value && !try_module_get(ksg->owner))
+	if (value && !strong_try_module_get(ksg->owner))
 		value = 0;
 	spin_unlock_irqrestore(&modlist_lock, flags);
 
@@ -935,12 +953,8 @@ static struct module *load_module(void *
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
@@ -1097,51 +1111,40 @@ sys_init_module(void *umod,
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
                    buggy refcounters. */
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
+			up(&module_mutex);
 		}
-		up(&module_mutex);
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
 
