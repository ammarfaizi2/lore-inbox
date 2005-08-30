Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVH3NG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVH3NG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVH3NG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:06:26 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:3756 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751423AbVH3NG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:06:26 -0400
Subject: Re: 2.6.13-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050830055321.GB5743@elte.hu>
References: <20050829084829.GA23176@elte.hu>
	 <1125372830.6096.7.camel@localhost.localdomain>
	 <20050830055321.GB5743@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 30 Aug 2005 09:06:03 -0400
Message-Id: <1125407163.5675.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Looks like the BKL is a little more complicated than what I first sent.
I've been analyzing the logic and found that there's a point in time
where the BKL->P1->L1->P2->BKL can exist without any of the spinlocks
protecting it.  That is after P1 blocks on L1 but before it schedules
out and releases the BKL.  In this time another process on another CPU
could loop here.

The supplied patch fixes this.

Also, I need to look more into the logic of __up to see if the BKL can't
cause a deadlock with the grabbing and releasing of locks there.  So I
might be sending more patches to clean this up.

Do me a favor, and just take a quick look at the logic here, and make
sure that the situation is OK to break there, and that there won't be
any other side-effects, wrt. priority leaks.

Thanks,

-- Steve

Patch is against rt2

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 310)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -760,11 +760,12 @@
  */
 static void pi_setprio(struct rt_mutex *lock, struct task_struct *task, int prio)
 {
-	struct rt_mutex *l = lock;
-	struct task_struct *p = task;
 	/*
 	 * We don't want to release the parameters locks.
 	 */
+	struct rt_mutex *l = lock;
+	struct task_struct *p = task;
+	int bkl = 0;
 
 	if (unlikely(!p->pid)) {
 		pi_null++;
@@ -800,7 +801,7 @@
 #endif
 
 		mutex_setprio(p, prio);
-		if (!w)
+		if (!w || unlikely(bkl))
 			break;
 		/*
 		 * If the task is blocked on a lock, and we just made
@@ -817,18 +818,31 @@
 		TRACE_BUG_ON_LOCKED(!lock);
 
 		/*
-		 * The BKL can really be a pain.  It can happen that the lock
-		 * we are blocked on is owned by a task that is waiting for
-		 * the BKL, and we own it.  So, if this is the BKL and we own
-		 * it, then end the loop here.
+		 * The BKL can really be a pain. It can happen where the
+		 * BKL is being held by one task that is just about to 
+		 * block on another task that is waiting for the BKL.
+		 * This isn't a deadlock, since the BKL is released
+		 * when the task goes to sleep.  This also means that
+		 * all holders of the BKL are not blocked, or are just
+		 * about to be blocked.
+		 *
+		 * Another side-effect of this is that there's a small
+		 * window where the spinlocks are not held, and the blocked
+		 * process hasn't released the BKL.  So if we are going
+		 * to boost the owner of the BKL, stop after that,
+		 * since that owner is either running, or about to sleep
+		 * but don't go any further or we are in a loop.
 		 */
-		if (unlikely(l == &kernel_sem.lock) && lock_owner(l) == current_thread_info()) {
-			/*
-			 * No locks are held for locks, so fool the unlocking code
-			 * by thinking the last lock was the original.
-			 */
-			l = lock;
-			break;
+		if (unlikely(l == &kernel_sem.lock)) {
+			if (lock_owner(l) == current_thread_info()) {
+				/*
+				 * No locks are held for locks, so fool the unlocking code
+				 * by thinking the last lock was the original.
+				 */
+				l = lock;
+				break;
+			}
+			bkl = 1;
 		}
 
 		if (l != lock)


