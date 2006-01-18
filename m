Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWARMxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWARMxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWARMxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:53:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:29152 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932497AbWARMxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:53:21 -0500
Date: Wed, 18 Jan 2006 13:53:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ntl@pobox.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com,
       torvalds@osdl.org
Subject: [patch] add trylock_kernel()
Message-ID: <20060118125305.GA30907@elte.hu>
References: <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org> <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org> <20060118091834.GA21366@elte.hu> <20060118023509.50fe2701.akpm@osdl.org> <43CE1C8B.3010802@yahoo.com.au> <20060118110739.GA11316@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118110739.GA11316@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the way i fixed it in my tree was to add a trylock_kernel(), and to 
> check for success in init/main.c. See the patch below.

i had a silly bug in the spinlock variant, and some extra unneeded 
change from another debug patch - fixed patch is below. Tested on x86, 
with and without CONFIG_PREEMPT_BKL.

	Ingo

--
introduce trylock_kernel(), to be used by the early init code to acquire 
the BKL in an atomic way.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/smp_lock.h |    1 +
 init/main.c              |   13 ++++++++-----
 lib/kernel_lock.c        |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 5 deletions(-)

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
@@ -194,6 +211,22 @@ void __lockfunc lock_kernel(void)
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
+	task->lock_depth = depth;
+	return 1;
+}
+
 void __lockfunc unlock_kernel(void)
 {
 	BUG_ON(current->lock_depth < 0);
@@ -204,5 +237,6 @@ void __lockfunc unlock_kernel(void)
 #endif
 
 EXPORT_SYMBOL(lock_kernel);
+/* we do not export trylock_kernel(). BKL code should shrink :-) */
 EXPORT_SYMBOL(unlock_kernel);
 
