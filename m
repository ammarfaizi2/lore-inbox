Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUJZTx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUJZTx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUJZTx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:53:26 -0400
Received: from ida.rowland.org ([192.131.102.52]:2564 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261406AbUJZTwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:52:53 -0400
Date: Tue, 26 Oct 2004 15:52:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [RFC as402] Delaying module memory release
Message-ID: <Pine.LNX.4.44L0.0410261520170.690-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This issue has come up in the past, without much in the way of visible 
results.

The problem is that sometimes the memory for a kernel module needs to be
freed _after_ rmmod has exited.  The classic example is where the standard
input to the rmmod process has been redirected to a pseudo-file that pins
a kobject whose release method calls into the module.  Another example
(which could be worked around with some effort) is multiple kernel threads
executing in the module -- the module exit routine would have to wait for 
each one of them to terminate.

In these cases it's not desirable/feasible to increment the module's 
refcount.  Instead the module's exit routine should run and rmmod should 
return, but the module's memory should only be freed when it is known that 
nothing else will try to use it.

This patch implements that behavior, by adding a "soft" refcount field to
struct module.  A "soft" reference to a module is one whose release will
be triggered when the module's exit routine runs.  It can't be treated as
a normal reference, since doing so would prevent the exit routine from
being called at all.

The sys_delete_module code will proceed normally, but won't call 
free_module directly unless the "forced" flag is used.  Instead it drops 
a soft reference, and when the last one is gone a workqueue item is 
scheduled to call free_module.

Proper use of this mechanism can convert unsafe module interfaces into
safe ones.  Just about every module I've worked on would benefit from
this.  It solves the long-standing dilemma about whether to allow deadlock
(by waiting for resources that may not be released) or to allow an oops
(by attempting to execute release callbacks after the module has been
unloaded).

No doubt my implementation isn't the greatest, since I don't have much
experience with the module subsystem.  If someone wants to propose an
alternative way to achieve the same result that would be fine with me --
just so long as _something_ gets done!

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

===== include/linux/module.h 1.46 vs edited =====
--- 1.46/include/linux/module.h	2004-10-21 16:02:23 -04:00
+++ edited/include/linux/module.h	2004-10-26 13:08:27 -04:00
@@ -293,6 +293,7 @@
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
+	atomic_t soft_refcnt;
 
 	/* What modules depend on me? */
 	struct list_head modules_which_use_me;
@@ -303,6 +304,9 @@
 	/* Destruction function. */
 	void (*exit)(void);
 
+	/* Workqueue for delayed freeing */
+	struct work_struct free_work;
+
 	/* Fake kernel param for refcnt. */
 	struct kernel_param refcnt_param;
 #endif
@@ -352,6 +356,10 @@
 extern void __module_put_and_exit(struct module *mod, long code)
 	__attribute__((noreturn));
 #define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE, code);
+extern void __module_put_soft_and_exit(struct module *mod, long code)
+	__attribute__((noreturn));
+#define module_put_soft_and_exit(code) \
+	__module_put_soft_and_exit(THIS_MODULE, code)
 
 #ifdef CONFIG_MODULE_UNLOAD
 unsigned int module_refcount(struct module *mod);
@@ -397,6 +405,12 @@
 	}
 }
 
+extern int __try_module_get_soft(struct module *mod);
+#define try_module_get_soft() __try_module_get_soft(THIS_MODULE)
+
+extern void __module_put_soft(struct module *mod);
+#define module_put_soft() __module_put_soft(THIS_MODULE);
+
 #else /*!CONFIG_MODULE_UNLOAD*/
 static inline int try_module_get(struct module *module)
 {
@@ -408,6 +422,13 @@
 static inline void __module_get(struct module *module)
 {
 }
+static inline int try_module_get_soft(struct module *module)
+{
+	return !module || module_is_live(module);
+}
+static inline void module_put_soft(struct module *module)
+{
+}
 #define symbol_put(x) do { } while(0)
 #define symbol_put_addr(p) do { } while(0)
 
@@ -487,6 +508,15 @@
 }
 
 static inline void module_put(struct module *module)
+{
+}
+
+static inline int try_module_get_soft(struct module *module)
+{
+	return 1;
+}
+
+static inline void module_put_soft(struct module *module)
 {
 }
 
===== kernel/module.c 1.71 vs edited =====
--- 1.71/kernel/module.c	2004-10-08 14:32:52 -04:00
+++ edited/kernel/module.c	2004-10-26 14:32:48 -04:00
@@ -35,6 +35,7 @@
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
@@ -100,6 +101,13 @@
 	do_exit(code);
 }
 EXPORT_SYMBOL(__module_put_and_exit);
+
+void __module_put_soft_and_exit(struct module *mod, long code)
+{
+	__module_put_soft(mod);
+	do_exit(code);
+}
+EXPORT_SYMBOL(__module_put_soft_and_exit);
 	
 /* Find a module section: 0 means not found. */
 static unsigned int find_sec(Elf_Ehdr *hdr,
@@ -386,6 +394,8 @@
 }
 
 #ifdef CONFIG_MODULE_UNLOAD
+static void delayed_free_module(void *);
+
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
 {
@@ -394,6 +404,9 @@
 	INIT_LIST_HEAD(&mod->modules_which_use_me);
 	for (i = 0; i < NR_CPUS; i++)
 		local_set(&mod->ref[i].count, 0);
+	atomic_set(&mod->soft_refcnt, 0);
+	INIT_WORK(&mod->free_work, delayed_free_module, mod);
+
 	/* Hold reference count during initialization. */
 	local_set(&mod->ref[smp_processor_id()].count, 1);
 	/* Backwards compatibility macros put refcount during init. */
@@ -538,6 +551,38 @@
 	down(&module_mutex);
 }
 
+int __try_module_get_soft(struct module *mod)
+{
+	int ret = 1;
+
+	if (mod) {
+		if (likely(module_is_live(mod)))
+			atomic_inc(&mod->soft_refcnt);
+		else
+			ret = 0;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__try_module_get_soft);
+
+void __module_put_soft(struct module *mod)
+{
+	if (mod && atomic_dec_and_test(&mod->soft_refcnt)) {
+		schedule_work(&mod->free_work);
+	}
+}
+EXPORT_SYMBOL(__module_put_soft);
+
+static void delayed_free_module(void *m)
+{
+	/* Wait for all callbacks to exit */
+	synchronize_kernel();
+
+	down(&module_mutex);
+	free_module((struct module *) m);
+	up(&module_mutex);
+}
+
 asmlinkage long
 sys_delete_module(const char __user *name_user, unsigned int flags)
 {
@@ -590,6 +635,9 @@
 	/* Set this up before setting mod->state */
 	mod->waiter = current;
 
+	/* Don't let anyone free the module until we're done with it */
+	__try_module_get_soft(mod);
+
 	/* Stop the machine so refcounts can't move and disable module. */
 	ret = try_stop_module(mod, flags, &forced);
 
@@ -603,8 +651,11 @@
 		mod->exit();
 		down(&module_mutex);
 	}
-	free_module(mod);
 
+	if (forced)
+		free_module(mod);
+	else
+		__module_put_soft(mod);
  out:
 	up(&module_mutex);
 	return ret;

