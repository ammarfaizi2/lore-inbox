Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290650AbSAYMNO>; Fri, 25 Jan 2002 07:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290651AbSAYMND>; Fri, 25 Jan 2002 07:13:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20376 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290650AbSAYMMp>;
	Fri, 25 Jan 2002 07:12:45 -0500
Date: Fri, 25 Jan 2002 15:10:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] fork-fix 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201251506020.7091-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below fixes a fork() bug introduced by the new scheduler. If the
parent process schedules away and gets rebalanced to another CPU then
wake_up_forked_process() does runqueue manipulation incorrectly.

the crash was first reported by Robert Love, it happened with the
preemption patches applied. Later the crash was reproduced on the 2.4 +
O(1) kernel as well, using Cerberus.

	Ingo

--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -275,6 +293,7 @@
 		p->prio = effective_prio(p);
 	}
 	spin_lock_irq(&rq->lock);
+	p->cpu = smp_processor_id();
 	activate_task(p, rq);
 	spin_unlock_irq(&rq->lock);
 }

