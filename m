Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135790AbRDYB6i>; Tue, 24 Apr 2001 21:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135791AbRDYB62>; Tue, 24 Apr 2001 21:58:28 -0400
Received: from nrg.org ([216.101.165.106]:39430 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S135790AbRDYB6N>;
	Tue, 24 Apr 2001 21:58:13 -0400
Date: Tue, 24 Apr 2001 18:58:12 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Scheduling bug for SCHED_FIFO and SCHED_RR
In-Reply-To: <Pine.LNX.4.05.10104201625540.4048-100000@cosmic.nrg.org>
Message-ID: <Pine.LNX.4.05.10104241853320.3475-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Nigel Gamble wrote:
> A SCHED_FIFO or SCHED_RR task with priority n+1 will not preempt a
> running task with priority n.  You need to give the higher priority task
> a priority of at least n+2 for it to be chosen by the scheduler.
> 
> The problem is caused by reschedule_idle(), uniprocessor version:
> 
> 	if (preemption_goodness(tsk, p, this_cpu) > 1)
> 		tsk->need_resched = 1;
> 
> For real-time scheduling to work correctly, need_resched should be set
> whenever preemption_goodness() is greater than 0, not 1.

This bug is also in the SMP version of reschedule_idle().  The
corresponding fix (against 2.4.3-ac14) is:

--- 2.4.3-ac14/kernel/sched.c	Tue Apr 24 18:40:15 2001
+++ linux/kernel/sched.c	Tue Apr 24 18:41:32 2001
@@ -246,7 +246,7 @@
 	 */
 	oldest_idle = (cycles_t) -1;
 	target_tsk = NULL;
-	max_prio = 1;
+	max_prio = 0;
 
 	for (i = 0; i < smp_num_cpus; i++) {
 		cpu = cpu_logical_map(i);

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

