Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDTXuq>; Fri, 20 Apr 2001 19:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDTXug>; Fri, 20 Apr 2001 19:50:36 -0400
Received: from nrg.org ([216.101.165.106]:26666 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132140AbRDTXuS>;
	Fri, 20 Apr 2001 19:50:18 -0400
Date: Fri, 20 Apr 2001 16:50:17 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: linux-kernel@vger.kernel.org
Subject: Scheduling bug for SCHED_FIFO and SCHED_RR
Message-ID: <Pine.LNX.4.05.10104201625540.4048-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A SCHED_FIFO or SCHED_RR task with priority n+1 will not preempt a
running task with priority n.  You need to give the higher priority task
a priority of at least n+2 for it to be chosen by the scheduler.

The problem is caused by reschedule_idle(), uniprocessor version:

	if (preemption_goodness(tsk, p, this_cpu) > 1)
		tsk->need_resched = 1;

For real-time scheduling to work correctly, need_resched should be set
whenever preemption_goodness() is greater than 0, not 1.

Here is a patch against 2.4.3:

--- 2.4.3/kernel/sched.c	Thu Apr 19 15:03:21 2001
+++ linux/kernel/sched.c	Fri Apr 20 16:45:07 2001
@@ -290,7 +290,7 @@
 	struct task_struct *tsk;
 
 	tsk = cpu_curr(this_cpu);
-	if (preemption_goodness(tsk, p, this_cpu) > 1)
+	if (preemption_goodness(tsk, p, this_cpu) > 0)
 		tsk->need_resched = 1;
 #endif
 }

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

