Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVH3DeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVH3DeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVH3DeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:34:23 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:60051 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932114AbVH3DeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:34:23 -0400
Subject: Re: 2.6.13-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050829084829.GA23176@elte.hu>
References: <20050829084829.GA23176@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 29 Aug 2005 23:33:50 -0400
Message-Id: <1125372830.6096.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I just found another deadlock in the pi_lock logic.  The PI logic is
very dependent on the P1->L1->P2->L2->P3 order.  But our good old friend
is back, the BKL.

Since the BKL is let go and regrabbed even if a task is grabbing another
lock, it messes up the order.  For example, it can do the following:
L1->P1->L2->P2->L1 if L1 is the BKL.  Luckly, (and I guess there's
really no other way) the BKL is only held by those that are currently
running, or at least not blocked on anyone.  So I added code in the
pi_setprio code to test if the next lock in the loop is the BKL and if
so, if its owner is the current task.  If so, the loop is broken.

Without this patch, I would constantly get lock ups on shutdown where it
sends SIGTERM to all the processes.  It usually would lock up on the
killing of udev.  But with the patch, I've shutdown a few times already
and no lockups so far.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_goliath/kernel/rt.c
===================================================================
--- linux_realtime_goliath/kernel/rt.c	(revision 308)
+++ linux_realtime_goliath/kernel/rt.c	(working copy)
@@ -816,6 +816,21 @@
 		l = w->lock;
 		TRACE_BUG_ON_LOCKED(!lock);
 
+		/*
+		 * The BKL can really be a pain.  It can happen that the lock
+		 * we are blocked on is owned by a task that is waiting for
+		 * the BKL, and we own it.  So, if this is the BKL and we own
+		 * it, then end the loop here.
+		 */
+		if (unlikely(l == &kernel_sem.lock) && lock_owner(l) == current_thread_info()) {
+			/*
+			 * No locks are held for locks, so fool the unlocking code
+			 * by thinking the last lock was the original.
+			 */
+			l = lock;
+			break;
+		}
+
 		if (l != lock)
 			__raw_spin_lock(&l->wait_lock);
 


