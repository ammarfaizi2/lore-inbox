Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSFTOn3>; Thu, 20 Jun 2002 10:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSFTOn2>; Thu, 20 Jun 2002 10:43:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13120 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314690AbSFTOn1>; Thu, 20 Jun 2002 10:43:27 -0400
Date: Thu, 20 Jun 2002 16:44:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620144441.GM10718@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <Pine.LNX.4.44.0206201546510.4390-100000@e2> <20020620144033.GL10718@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620144033.GL10718@dualathlon.random>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 04:40:33PM +0200, Andrea Arcangeli wrote:
> however I noticed an smp bug in my changes, I was too aggressive
> removing the loop in task_rq_lock, not that such bug ever triggered yet
> but the rq may change under us while we take the lock if the task is
> getting migrated to another cpu.

just for reference, here it is the fix:

--- sched/kernel/sched.c.~1~	Thu Jun 20 16:42:41 2002
+++ sched/kernel/sched.c	Thu Jun 20 16:43:36 2002
@@ -133,19 +133,13 @@ static inline runqueue_t *task_rq_lock(t
 {
 	struct runqueue *rq;
 
-	/*
-	 * 2.4 cannot be made preemptive or it can trigger preemption bugs all
-	 * over the place (just check the networking per-cpu data), so it's
-	 * pointless to disable irq before reading the current runqueue address.
-	 */
+repeat_lock_task:
 	rq = task_rq(p);
 	spin_lock_irqsave(&rq->lock, *flags);
-	if (unlikely(rq != task_rq(p)))
-		/*
-		 * Bug just in case somebody made the 2.4 kernel non preemptive
-		 * as an experiment on a non production system.
-		 */
-		BUG();
+	if (unlikely(rq != task_rq(p))) {
+		spin_unlock_irqrestore(&rq->lock, *flags);
+		goto repeat_lock_task;
+	}
 	return rq;
 }
 

Andrea
