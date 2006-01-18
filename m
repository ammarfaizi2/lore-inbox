Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWARLHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWARLHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWARLHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:07:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51597 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030212AbWARLHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:07:52 -0500
Date: Wed, 18 Jan 2006 12:07:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, ntl@pobox.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com,
       torvalds@osdl.org
Subject: Re: [patch] turn on might_sleep() in early bootup code too
Message-ID: <20060118110739.GA11316@elte.hu>
References: <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org> <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org> <20060118091834.GA21366@elte.hu> <20060118023509.50fe2701.akpm@osdl.org> <43CE1C8B.3010802@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CE1C8B.3010802@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Andrew Morton wrote:
> >Ingo Molnar <mingo@elte.hu> wrote:
> >
> >>enable might_sleep() checks even in early bootup code (when system_state 
> >>!= SYSTEM_RUNNING). There's also a new config option to turn this off:
> >>CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
> >>while most other architectures.
> >
> >
> >I get just the one on ppc64:
> >
> >
> >Debug: sleeping function called from invalid context at 
> >include/asm/semaphore.h:62
> >in_atomic():1, irqs_disabled():1
> >Call Trace:
> >[C0000000004EFD20] [C00000000000F660] .show_stack+0x5c/0x1cc (unreliable)
> >[C0000000004EFDD0] [C000000000053214] .__might_sleep+0xbc/0xe0
> >[C0000000004EFE60] [C000000000413D1C] .lock_kernel+0x50/0xb0
> >[C0000000004EFEF0] [C0000000004AC574] .start_kernel+0x1c/0x278
> >[C0000000004EFF90] [C0000000000085D4] .hmt_init+0x0/0x2c
> >
> >
> >Your fault ;)
> 
> This lock_kernel should never sleep should it? Maybe it could be 
> changed to lock_kernel_init_locked() or something?

the way i fixed it in my tree was to add a trylock_kernel(), and to 
check for success in init/main.c. See the patch below.

	Ingo

--

introduce trylock_kernel(), to be used by the early init code to acquire 
the BKL in an atomic way.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

Index: linux/include/linux/smp_lock.h
===================================================================
--- linux.orig/include/linux/smp_lock.h
+++ linux/include/linux/smp_lock.h
@@ -39,6 +39,7 @@ static inline int reacquire_kernel_lock(
 }
 
 extern void __lockfunc lock_kernel(void)	__acquires(kernel_lock);
+extern int __lockfunc trylock_kernel(void);
 extern void __lockfunc unlock_kernel(void)	__releases(kernel_lock);
 
 #else
Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -443,11 +443,14 @@ asmlinkage void __init start_kernel(void
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
-/*
- * Interrupts are still disabled. Do necessary setups, then
- * enable them
- */
-	lock_kernel();
+
+	/*
+	 * Interrupts are still disabled. Do necessary setups, then
+	 * enable them. This is the first time we take the BKL, so
+	 * it must succeed:
+	 */
+	if (!trylock_kernel())
+		WARN_ON(1);
 	page_address_init();
 	printk(KERN_NOTICE);
 	printk(linux_banner);
@@ -466,6 +469,7 @@ asmlinkage void __init start_kernel(void
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+	mutex_key_hash_init();
 	/*
 	 * Disable preemption - early bootup scheduling is extremely
 	 * fragile until we cpu_idle() for the first time.
Index: linux/lib/kernel_lock.c
===================================================================
--- linux.orig/lib/kernel_lock.c
+++ linux/lib/kernel_lock.c
@@ -76,6 +76,23 @@ void __lockfunc lock_kernel(void)
 	task->lock_depth = depth;
 }
 
+int __lockfunc trylock_kernel(void)
+{
+	struct task_struct *task = current;
+	int depth = task->lock_depth + 1;
+
+	if (likely(!depth)) {
+		if (unlikely(down_trylock(&kernel_sem)))
+			return 0;
+		else
+			__acquire(kernel_sem);
+	}
+
+	task->lock_depth = depth;
+	return 1;
+}
+
+
 void __lockfunc unlock_kernel(void)
 {
 	struct task_struct *task = current;
@@ -194,6 +211,25 @@ void __lockfunc lock_kernel(void)
 	current->lock_depth = depth;
 }
 
+int __lockfunc trylock_kernel(void)
+{
+	struct task_struct *task = current;
+	int depth = task->lock_depth + 1;
+
+	if (likely(!depth)) {
+		if (unlikely(!spin_trylock(&kernel_flag)))
+			return 0;
+		else
+			__acquire(kernel_sem);
+	}
+
+	if (likely(!depth) && unlikely(!spin_trylock(&kernel_flag)))
+		return 0;
+
+	task->lock_depth = depth;
+	return 1;
+}
+
 void __lockfunc unlock_kernel(void)
 {
 	BUG_ON(current->lock_depth < 0);
@@ -204,5 +240,6 @@ void __lockfunc unlock_kernel(void)
 #endif
 
 EXPORT_SYMBOL(lock_kernel);
+/* we do not export trylock_kernel(). BKL code should shrink :-) */
 EXPORT_SYMBOL(unlock_kernel);
 
