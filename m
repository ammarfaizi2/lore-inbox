Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTLHS0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTLHS0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:26:35 -0500
Received: from holomorphy.com ([199.26.172.102]:5084 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261552AbTLHSZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:25:11 -0500
Date: Mon, 8 Dec 2003 10:25:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Volkov <Andrew.Volkov@transas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible proceses leak
Message-ID: <20031208182500.GL8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Volkov <Andrew.Volkov@transas.com>,
	linux-kernel@vger.kernel.org
References: <2E74F312D6980D459F3A05492BA40F8D0391B0E9@clue.transas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E74F312D6980D459F3A05492BA40F8D0391B0E9@clue.transas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 09:01:40PM +0300, Andrew Volkov wrote:
> In all kernels (up to 2.6-test11) next sequence of code 
> in __down/__down_interruptible function 
> (arch/i386/kernel/semaphore.c) may cause processes or threads leaking.

Something like this?


-- wli


===== arch/alpha/kernel/semaphore.c 1.5 vs edited =====
--- 1.5/arch/alpha/kernel/semaphore.c	Thu Apr  3 14:49:57 2003
+++ edited/arch/alpha/kernel/semaphore.c	Mon Dec  8 10:19:08 2003
@@ -62,9 +62,9 @@
 	       current->comm, current->pid, sem);
 #endif
 
+	add_wait_queue_exclusive(&sem->wait, &wait);
 	current->state = TASK_UNINTERRUPTIBLE;
 	wmb();
-	add_wait_queue_exclusive(&sem->wait, &wait);
 
 	/* At this point we know that sem->count is negative.  In order
 	   to avoid racing with __up, we must check for wakeup before
@@ -94,8 +94,8 @@
 		set_task_state(current, TASK_UNINTERRUPTIBLE);
 	}
 
-	remove_wait_queue(&sem->wait, &wait);
 	current->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
 	printk("%s(%d): down acquired(%p)\n",
@@ -114,9 +114,9 @@
 	       current->comm, current->pid, sem);
 #endif
 
+	add_wait_queue_exclusive(&sem->wait, &wait);
 	current->state = TASK_INTERRUPTIBLE;
 	wmb();
-	add_wait_queue_exclusive(&sem->wait, &wait);
 
 	while (1) {
 		long tmp, tmp2, tmp3;
@@ -181,8 +181,8 @@
 		set_task_state(current, TASK_INTERRUPTIBLE);
 	}
 
-	remove_wait_queue(&sem->wait, &wait);
 	current->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 
 #ifdef CONFIG_DEBUG_SEMAPHORE
===== arch/arm/kernel/semaphore.c 1.8 vs edited =====
--- 1.8/arch/arm/kernel/semaphore.c	Sat Sep 20 02:38:17 2003
+++ edited/arch/arm/kernel/semaphore.c	Mon Dec  8 10:19:27 2003
@@ -58,8 +58,8 @@
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
@@ -82,8 +82,8 @@
 		spin_lock_irq(&semaphore_lock);
 	}
 	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 }
 
@@ -92,8 +92,8 @@
 	int retval = 0;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_INTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers ++;
===== arch/arm26/kernel/semaphore.c 1.1 vs edited =====
--- 1.1/arch/arm26/kernel/semaphore.c	Wed Jun  4 04:15:45 2003
+++ edited/arch/arm26/kernel/semaphore.c	Mon Dec  8 10:19:41 2003
@@ -60,8 +60,8 @@
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
@@ -84,8 +84,8 @@
 		spin_lock_irq(&semaphore_lock);
 	}
 	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 }
 
@@ -94,8 +94,8 @@
 	int retval = 0;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_INTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers ++;
===== arch/cris/kernel/semaphore.c 1.2 vs edited =====
--- 1.2/arch/cris/kernel/semaphore.c	Mon Feb  4 23:39:23 2002
+++ edited/arch/cris/kernel/semaphore.c	Mon Dec  8 10:17:51 2003
@@ -68,8 +68,8 @@
 #define DOWN_HEAD(task_state)						\
 									\
 									\
-	tsk->state = (task_state);					\
 	add_wait_queue(&sem->wait, &wait);				\
+	tsk->state = (task_state);					\
 									\
 	/*								\
 	 * Ok, we're set up.  sem->count is known to be less than zero	\
@@ -91,8 +91,8 @@
 #define DOWN_TAIL(task_state)			\
 		tsk->state = (task_state);	\
 	}					\
-	tsk->state = TASK_RUNNING;		\
 	remove_wait_queue(&sem->wait, &wait);
+	tsk->state = TASK_RUNNING;		\
 
 void __down(struct semaphore * sem)
 {
===== arch/h8300/kernel/semaphore.c 1.1 vs edited =====
--- 1.1/arch/h8300/kernel/semaphore.c	Sun Feb 16 16:01:58 2003
+++ edited/arch/h8300/kernel/semaphore.c	Mon Dec  8 10:18:07 2003
@@ -69,8 +69,8 @@
 #define DOWN_HEAD(task_state)						\
 									\
 									\
-	current->state = (task_state);					\
 	add_wait_queue(&sem->wait, &wait);				\
+	current->state = (task_state);					\
 									\
 	/*								\
 	 * Ok, we're set up.  sem->count is known to be less than zero	\
===== arch/i386/kernel/semaphore.c 1.8 vs edited =====
--- 1.8/arch/i386/kernel/semaphore.c	Thu Nov 21 09:55:02 2002
+++ edited/arch/i386/kernel/semaphore.c	Mon Dec  8 10:18:43 2003
@@ -59,9 +59,9 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	spin_lock_irqsave(&sem->wait.lock, flags);
 	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	sem->sleepers++;
 	for (;;) {
@@ -84,10 +84,10 @@
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
+	tsk->state = TASK_RUNNING;
 	remove_wait_queue_locked(&sem->wait, &wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	tsk->state = TASK_RUNNING;
 }
 
 int __down_interruptible(struct semaphore * sem)
@@ -97,9 +97,9 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_INTERRUPTIBLE;
 	spin_lock_irqsave(&sem->wait.lock, flags);
 	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	sem->sleepers++;
 	for (;;) {
@@ -137,11 +137,11 @@
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
 	}
+	tsk->state = TASK_RUNNING;
 	remove_wait_queue_locked(&sem->wait, &wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
 
-	tsk->state = TASK_RUNNING;
 	return retval;
 }
 
===== arch/ia64/kernel/semaphore.c 1.4 vs edited =====
--- 1.4/arch/ia64/kernel/semaphore.c	Sat Aug 31 06:16:01 2002
+++ edited/arch/ia64/kernel/semaphore.c	Mon Dec  8 10:20:25 2003
@@ -51,9 +51,9 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	spin_lock_irqsave(&sem->wait.lock, flags);
 	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	sem->sleepers++;
 	for (;;) {
@@ -76,10 +76,10 @@
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
+	tsk->state = TASK_RUNNING;
 	remove_wait_queue_locked(&sem->wait, &wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	tsk->state = TASK_RUNNING;
 }
 
 int
@@ -90,9 +90,9 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_INTERRUPTIBLE;
 	spin_lock_irqsave(&sem->wait.lock, flags);
 	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	sem->sleepers ++;
 	for (;;) {
@@ -130,11 +130,11 @@
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
 	}
+	tsk->state = TASK_RUNNING;
 	remove_wait_queue_locked(&sem->wait, &wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
 
-	tsk->state = TASK_RUNNING;
 	return retval;
 }
 
===== arch/m68k/kernel/semaphore.c 1.2 vs edited =====
--- 1.2/arch/m68k/kernel/semaphore.c	Mon Feb  4 23:39:24 2002
+++ edited/arch/m68k/kernel/semaphore.c	Mon Dec  8 10:21:00 2003
@@ -69,8 +69,8 @@
 #define DOWN_HEAD(task_state)						\
 									\
 									\
-	current->state = (task_state);					\
 	add_wait_queue(&sem->wait, &wait);				\
+	current->state = (task_state);					\
 									\
 	/*								\
 	 * Ok, we're set up.  sem->count is known to be less than zero	\
===== arch/m68knommu/kernel/semaphore.c 1.1 vs edited =====
--- 1.1/arch/m68knommu/kernel/semaphore.c	Fri Nov  1 07:19:55 2002
+++ edited/arch/m68knommu/kernel/semaphore.c	Mon Dec  8 10:21:10 2003
@@ -70,8 +70,8 @@
 #define DOWN_HEAD(task_state)						\
 									\
 									\
-	current->state = (task_state);					\
 	add_wait_queue(&sem->wait, &wait);				\
+	current->state = (task_state);					\
 									\
 	/*								\
 	 * Ok, we're set up.  sem->count is known to be less than zero	\
===== arch/mips/kernel/semaphore.c 1.2 vs edited =====
--- 1.2/arch/mips/kernel/semaphore.c	Mon Feb  4 23:39:24 2002
+++ edited/arch/mips/kernel/semaphore.c	Mon Dec  8 10:21:19 2003
@@ -68,8 +68,8 @@
 #define DOWN_HEAD(task_state)						\
 									\
 									\
-	tsk->state = (task_state);					\
 	add_wait_queue(&sem->wait, &wait);				\
+	tsk->state = (task_state);					\
 									\
 	/*								\
 	 * Ok, we're set up.  sem->count is known to be less than zero	\
===== arch/parisc/kernel/semaphore.c 1.3 vs edited =====
--- 1.3/arch/parisc/kernel/semaphore.c	Sun Jul 21 14:20:31 2002
+++ edited/arch/parisc/kernel/semaphore.c	Mon Dec  8 10:21:52 2003
@@ -49,8 +49,8 @@
 	spin_lock_irq(&sem->sentry);					\
 	if (wakers(sem->count) == 0 && ret == 0)			\
 		goto lost_race;	/* Someone stole our wakeup */		\
-	__remove_wait_queue(&sem->wait, &wait);				\
 	current->state = TASK_RUNNING;					\
+	__remove_wait_queue(&sem->wait, &wait);				\
 	if (!waitqueue_active(&sem->wait) && (sem->count < 0))		\
 		sem->count = wakers(sem->count);
 
===== arch/ppc/kernel/semaphore.c 1.7 vs edited =====
--- 1.7/arch/ppc/kernel/semaphore.c	Sun Sep 15 21:51:59 2002
+++ edited/arch/ppc/kernel/semaphore.c	Mon Dec  8 10:22:15 2003
@@ -74,8 +74,8 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 	smp_wmb();
 
 	/*
@@ -88,8 +88,8 @@
 		schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 
 	/*
 	 * If there are any more sleepers, wake one of them up so
@@ -105,8 +105,8 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	tsk->state = TASK_INTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 	smp_wmb();
 
 	while (__sem_update_count(sem, -1) <= 0) {
===== arch/ppc64/kernel/semaphore.c 1.3 vs edited =====
--- 1.3/arch/ppc64/kernel/semaphore.c	Wed Aug 27 21:23:26 2003
+++ edited/arch/ppc64/kernel/semaphore.c	Mon Dec  8 10:22:33 2003
@@ -75,8 +75,8 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 
 	/*
 	 * Try to get the semaphore.  If the count is > 0, then we've
@@ -88,8 +88,8 @@
 		schedule();
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 	}
-	remove_wait_queue(&sem->wait, &wait);
 	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(&sem->wait, &wait);
 
 	/*
 	 * If there are any more sleepers, wake one of them up so
@@ -105,8 +105,8 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	__set_task_state(tsk, TASK_INTERRUPTIBLE);
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	__set_task_state(tsk, TASK_INTERRUPTIBLE);
 
 	while (__sem_update_count(sem, -1) <= 0) {
 		if (signal_pending(current)) {
@@ -122,8 +122,8 @@
 		schedule();
 		set_task_state(tsk, TASK_INTERRUPTIBLE);
 	}
-	remove_wait_queue(&sem->wait, &wait);
 	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(&sem->wait, &wait);
 
 	wake_up(&sem->wait);
 	return retval;
===== arch/s390/kernel/semaphore.c 1.4 vs edited =====
--- 1.4/arch/s390/kernel/semaphore.c	Wed Jun  5 10:43:26 2002
+++ edited/arch/s390/kernel/semaphore.c	Mon Dec  8 10:22:46 2003
@@ -64,14 +64,14 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 	while (__sem_update_count(sem, -1) <= 0) {
 		schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 }
 
@@ -87,8 +87,8 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	tsk->state = TASK_INTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 	while (__sem_update_count(sem, -1) <= 0) {
 		if (signal_pending(current)) {
 			__sem_update_count(sem, 0);
@@ -98,8 +98,8 @@
 		schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
 	}
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 	return retval;
 }
===== arch/sh/kernel/semaphore.c 1.3 vs edited =====
--- 1.3/arch/sh/kernel/semaphore.c	Wed Apr 10 00:09:38 2002
+++ edited/arch/sh/kernel/semaphore.c	Mon Dec  8 10:22:54 2003
@@ -77,8 +77,8 @@
 #define DOWN_HEAD(task_state)						\
 									\
 									\
-	tsk->state = (task_state);					\
 	add_wait_queue(&sem->wait, &wait);				\
+	tsk->state = (task_state);					\
 									\
 	/*								\
 	 * Ok, we're set up.  sem->count is known to be less than zero	\
===== arch/sparc/kernel/semaphore.c 1.5 vs edited =====
--- 1.5/arch/sparc/kernel/semaphore.c	Tue Jul 16 17:12:12 2002
+++ edited/arch/sparc/kernel/semaphore.c	Mon Dec  8 10:23:11 2003
@@ -49,8 +49,8 @@
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
@@ -73,8 +73,8 @@
 		spin_lock_irq(&semaphore_lock);
 	}
 	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 }
 
===== arch/sparc64/kernel/semaphore.c 1.7 vs edited =====
--- 1.7/arch/sparc64/kernel/semaphore.c	Wed Sep  3 23:40:12 2003
+++ edited/arch/sparc64/kernel/semaphore.c	Mon Dec  8 10:23:37 2003
@@ -95,15 +95,15 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	while (__sem_update_count(sem, -1) <= 0) {
 		schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 
 	wake_up(&sem->wait);
 }
@@ -198,8 +198,8 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	tsk->state = TASK_INTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	while (__sem_update_count(sem, -1) <= 0) {
 		if (signal_pending(current)) {
===== arch/v850/kernel/semaphore.c 1.2 vs edited =====
--- 1.2/arch/v850/kernel/semaphore.c	Wed Dec 18 18:20:47 2002
+++ edited/arch/v850/kernel/semaphore.c	Mon Dec  8 10:23:58 2003
@@ -60,8 +60,8 @@
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
@@ -84,8 +84,8 @@
 		spin_lock_irq(&semaphore_lock);
 	}
 	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
 	tsk->state = TASK_RUNNING;
+	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 }
 
@@ -94,8 +94,8 @@
 	int retval = 0;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_INTERRUPTIBLE;
 	add_wait_queue_exclusive(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	spin_lock_irq(&semaphore_lock);
 	sem->sleepers ++;
===== arch/x86_64/kernel/semaphore.c 1.3 vs edited =====
--- 1.3/arch/x86_64/kernel/semaphore.c	Fri Oct 11 16:52:38 2002
+++ edited/arch/x86_64/kernel/semaphore.c	Mon Dec  8 10:24:24 2003
@@ -60,9 +60,9 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_UNINTERRUPTIBLE;
 	spin_lock_irqsave(&sem->wait.lock, flags);
 	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	tsk->state = TASK_UNINTERRUPTIBLE;
 
 	sem->sleepers++;
 	for (;;) {
@@ -85,10 +85,10 @@
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
 	}
+	tsk->state = TASK_RUNNING;
 	remove_wait_queue_locked(&sem->wait, &wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	tsk->state = TASK_RUNNING;
 }
 
 int __down_interruptible(struct semaphore * sem)
@@ -98,9 +98,9 @@
 	DECLARE_WAITQUEUE(wait, tsk);
 	unsigned long flags;
 
-	tsk->state = TASK_INTERRUPTIBLE;
 	spin_lock_irqsave(&sem->wait.lock, flags);
 	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+	tsk->state = TASK_INTERRUPTIBLE;
 
 	sem->sleepers++;
 	for (;;) {
@@ -138,11 +138,11 @@
 		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
 	}
+	tsk->state = TASK_RUNNING;
 	remove_wait_queue_locked(&sem->wait, &wait);
 	wake_up_locked(&sem->wait);
 	spin_unlock_irqrestore(&sem->wait.lock, flags);
 
-	tsk->state = TASK_RUNNING;
 	return retval;
 }
 
