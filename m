Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbUKDXTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUKDXTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKDXRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:17:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:32385 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262466AbUKDXNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:13:46 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove contention on profile_lock
Date: Thu, 4 Nov 2004 15:13:40 -0800
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_keriBlKdDYeLkpa"
Message-Id: <200411041513.40119.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_keriBlKdDYeLkpa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

profile_hook unconditionally takes a read lock on profile_lock if kernel 
profiling is enabled.  The lock protects the profile_hook notifier chain from 
being written while it's being called.  The routine profile_hook is called in 
a very hot path though: every timer tick on every CPU.  As you can imagine, 
on a large system, this makes the cacheline containing profile_lock pretty 
hot.  Since oprofile was the only user of the profile_hook, I removed the 
notifier chain altogether in favor of a simple function pointer with the help 
of John Levon.  This removes all of the contention in the hot path since the 
variable is very seldom written and simplifies things a little to boot.

Acked-by: John Levon <levon@movementarian.org>
Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_keriBlKdDYeLkpa
Content-Type: text/plain;
  charset="us-ascii";
  name="remove-profile-notifier-list-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remove-profile-notifier-list-5.patch"

===== drivers/oprofile/timer_int.c 1.8 vs edited =====
--- 1.8/drivers/oprofile/timer_int.c	2004-09-03 16:55:27 -07:00
+++ edited/drivers/oprofile/timer_int.c	2004-11-04 14:24:59 -08:00
@@ -15,31 +15,24 @@
 #include <linux/init.h>
 #include <asm/ptrace.h>
  
-static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
+static int timer_notify(struct pt_regs *regs)
 {
-	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
 	unsigned long eip = profile_pc(regs);
  
 	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
 	return 0;
 }
- 
- 
-static struct notifier_block timer_notifier = {
-	.notifier_call	= timer_notify,
-};
- 
 
 static int timer_start(void)
 {
-	return register_profile_notifier(&timer_notifier);
+	return register_timer_hook(timer_notify);
 }
 
 
 static void timer_stop(void)
 {
-	unregister_profile_notifier(&timer_notifier);
+	unregister_timer_hook(timer_notify);
 }
 
 
===== include/linux/profile.h 1.11 vs edited =====
--- 1.11/include/linux/profile.h	2004-08-26 23:42:56 -07:00
+++ edited/include/linux/profile.h	2004-11-04 14:21:00 -08:00
@@ -53,13 +53,13 @@
 int profile_event_register(enum profile_type, struct notifier_block * n);
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
 
-int register_profile_notifier(struct notifier_block * nb);
-int unregister_profile_notifier(struct notifier_block * nb);
+int register_timer_hook(int (*hook)(struct pt_regs *));
+void unregister_timer_hook(int (*hook)(struct pt_regs *));
 
-struct pt_regs;
+/* Timer based profiling hook */
+extern int (*timer_hook)(struct pt_regs *);
 
-/* profiling hook activated on each timer interrupt */
-void profile_hook(struct pt_regs * regs);
+struct pt_regs;
 
 #else
 
@@ -87,17 +87,15 @@
 #define profile_handoff_task(a) (0)
 #define profile_munmap(a) do { } while (0)
 
-static inline int register_profile_notifier(struct notifier_block * nb)
+static inline int register_timer_hook(int (*hook)(struct pt_regs *))
 {
 	return -ENOSYS;
 }
 
-static inline int unregister_profile_notifier(struct notifier_block * nb)
+static inline void unregister_timer_hook(int (*hook)(struct pt_regs *))
 {
-	return -ENOSYS;
+	return;
 }
-
-#define profile_hook(regs) do { } while (0)
 
 #endif /* CONFIG_PROFILING */
 
===== kernel/profile.c 1.14 vs edited =====
--- 1.14/kernel/profile.c	2004-10-19 02:40:31 -07:00
+++ edited/kernel/profile.c	2004-11-04 14:23:38 -08:00
@@ -34,6 +34,9 @@
 #define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
+/* Oprofile timer tick hook */
+int (*timer_hook)(struct pt_regs *);
+
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
 static int prof_on;
@@ -168,38 +171,24 @@
 	return err;
 }
 
-static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
- 
-int register_profile_notifier(struct notifier_block * nb)
+int register_timer_hook(int (*hook)(struct pt_regs *))
 {
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
+	if (timer_hook)
+		return -EBUSY;
+	timer_hook = hook;
+	return 0;
 }
 
-
-int unregister_profile_notifier(struct notifier_block * nb)
-{
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
-}
-
-
-void profile_hook(struct pt_regs * regs)
+void unregister_timer_hook(int (*hook)(struct pt_regs *))
 {
-	read_lock(&profile_lock);
-	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
+	WARN_ON(hook != timer_hook);
+	timer_hook = NULL;
+	/* make sure all CPUs see the NULL hook */
+	synchronize_kernel();
 }
 
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
+EXPORT_SYMBOL_GPL(register_timer_hook);
+EXPORT_SYMBOL_GPL(unregister_timer_hook);
 EXPORT_SYMBOL_GPL(task_handoff_register);
 EXPORT_SYMBOL_GPL(task_handoff_unregister);
 
@@ -394,8 +383,8 @@
 
 void profile_tick(int type, struct pt_regs *regs)
 {
-	if (type == CPU_PROFILING)
-		profile_hook(regs);
+	if (type == CPU_PROFILING && timer_hook)
+		timer_hook(regs);
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }

--Boundary-00=_keriBlKdDYeLkpa--
