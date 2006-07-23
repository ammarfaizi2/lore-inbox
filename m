Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWGWRYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWGWRYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGWRYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 13:24:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWGWRYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 13:24:10 -0400
Date: Sun, 23 Jul 2006 10:20:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       davej@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <1153627754.7359.17.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607230955130.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>  <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
  <20060722180602.ac0d36f5.akpm@osdl.org>  <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
 <1153627754.7359.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jul 2006, Arjan van de Ven wrote:
> 
> with rwsems being 100% fair... how is that going to make a difference?
> Other than just making the deadlock harder to trigger because the writer
> needs to come in just at the right time...

Fair enough, I forgot about that particular braindamage. It would be _soo_ 
nice to have a proper rwsem like we used to.

Ok, here's a final try.

Its actually simpler than either of the previous ones, and it just does 
two different locks: a "cpu_add_remove_lock" which is entirely internal to 
kernel/cpu.c, and is held over the entirety of a cpu_add()/cpu_down() 
sequence, so that we will only ever add one CPU at a time.

The other lock is the "cpu_bitmask_lock", and the only thing that protects 
is the actual changing of the present bitmask. It's always nested inside 
of the "cpu_add_remove_lock" (if that is taken at all, of course).

The latter one is the one that "lock_cpu_hotplug()" actually takes, so 
anybody who does "lock_cpu_hotplug()" will only protect against the bitmap 
itself changing, not against the bigger issue of "cpu hotplug events are 
happening".

Does this work? Hey, it works for me once. It's pretty simple, and had 
better not have any recursion issues. It guarantees that actual cpu 
hotplug events are single-threaded wrt each other, and it does not allow 
any recursive taking of "lock_cpu_hotplug()", but since cpu_add() and 
cpu_down() no longer hold that particular lock when they to the call-outs 
for the cpu events, it should hopefully not be needed any more either.

Not very well tested, but it did suspend and resume twice for me.

Does anybody see any problems with this?

		Linus
---
 include/linux/cpu.h |    6 ------
 kernel/cpu.c        |   54 ++++++++++++---------------------------------------
 2 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 44a11f1..8fb344a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -48,7 +48,6 @@ static inline void unregister_cpu_notifi
 {
 }
 #endif
-extern int current_in_cpu_hotplug(void);
 
 int cpu_up(unsigned int cpu);
 
@@ -61,10 +60,6 @@ static inline int register_cpu_notifier(
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
-static inline int current_in_cpu_hotplug(void)
-{
-	return 0;
-}
 
 #endif /* CONFIG_SMP */
 extern struct sysdev_class cpu_sysdev_class;
@@ -73,7 +68,6 @@ #ifdef CONFIG_HOTPLUG_CPU
 /* Stop CPUs going up and down. */
 extern void lock_cpu_hotplug(void);
 extern void unlock_cpu_hotplug(void);
-extern int lock_cpu_hotplug_interruptible(void);
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 70fbf2e..4157055 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -16,7 +16,8 @@ #include <linux/stop_machine.h>
 #include <linux/mutex.h>
 
 /* This protects CPUs going up and down... */
-static DEFINE_MUTEX(cpucontrol);
+static DEFINE_MUTEX(cpu_add_remove_lock);
+static DEFINE_MUTEX(cpu_bitmask_lock);
 
 static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
@@ -24,48 +25,18 @@ #ifdef CONFIG_HOTPLUG_CPU
 static struct task_struct *lock_cpu_hotplug_owner;
 static int lock_cpu_hotplug_depth;
 
-static int __lock_cpu_hotplug(int interruptible)
-{
-	int ret = 0;
-
-	if (lock_cpu_hotplug_owner != current) {
-		if (interruptible)
-			ret = mutex_lock_interruptible(&cpucontrol);
-		else
-			mutex_lock(&cpucontrol);
-	}
-
-	/*
-	 * Set only if we succeed in locking
-	 */
-	if (!ret) {
-		lock_cpu_hotplug_depth++;
-		lock_cpu_hotplug_owner = current;
-	}
-
-	return ret;
-}
-
 void lock_cpu_hotplug(void)
 {
-	__lock_cpu_hotplug(0);
+	mutex_lock(&cpu_bitmask_lock);
 }
 EXPORT_SYMBOL_GPL(lock_cpu_hotplug);
 
 void unlock_cpu_hotplug(void)
 {
-	if (--lock_cpu_hotplug_depth == 0) {
-		lock_cpu_hotplug_owner = NULL;
-		mutex_unlock(&cpucontrol);
-	}
+	mutex_unlock(&cpu_bitmask_lock);
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
-int lock_cpu_hotplug_interruptible(void)
-{
-	return __lock_cpu_hotplug(1);
-}
-EXPORT_SYMBOL_GPL(lock_cpu_hotplug_interruptible);
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 /* Need to know about CPUs going up/down? */
@@ -122,9 +93,7 @@ int cpu_down(unsigned int cpu)
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	if ((err = lock_cpu_hotplug_interruptible()) != 0)
-		return err;
-
+	mutex_lock(&cpu_add_remove_lock);
 	if (num_online_cpus() == 1) {
 		err = -EBUSY;
 		goto out;
@@ -150,7 +119,10 @@ int cpu_down(unsigned int cpu)
 	cpu_clear(cpu, tmp);
 	set_cpus_allowed(current, tmp);
 
+	mutex_lock(&cpu_bitmask_lock);
 	p = __stop_machine_run(take_cpu_down, NULL, cpu);
+	mutex_unlock(&cpu_bitmask_lock);
+
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		if (blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED,
@@ -187,7 +159,7 @@ out_thread:
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
 out:
-	unlock_cpu_hotplug();
+	mutex_unlock(&cpu_add_remove_lock);
 	return err;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
@@ -197,9 +169,7 @@ int __devinit cpu_up(unsigned int cpu)
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	if ((ret = lock_cpu_hotplug_interruptible()) != 0)
-		return ret;
-
+	mutex_lock(&cpu_add_remove_lock);
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
@@ -214,7 +184,9 @@ int __devinit cpu_up(unsigned int cpu)
 	}
 
 	/* Arch-specific enabling code. */
+	mutex_lock(&cpu_bitmask_lock);
 	ret = __cpu_up(cpu);
+	mutex_unlock(&cpu_bitmask_lock);
 	if (ret != 0)
 		goto out_notify;
 	BUG_ON(!cpu_online(cpu));
@@ -227,6 +199,6 @@ out_notify:
 		blocking_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
 out:
-	unlock_cpu_hotplug();
+	mutex_unlock(&cpu_add_remove_lock);
 	return ret;
 }
