Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTEFQBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTEFQBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:01:01 -0400
Received: from smtp6.dti.ne.jp ([202.216.228.41]:63123 "EHLO smtp6.dti.ne.jp")
	by vger.kernel.org with ESMTP id S263868AbTEFQAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:00:53 -0400
Date: Wed, 07 May 2003 01:13:22 +0900
From: Hiroshi Inoue <inoueh@uranus.dti.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: scheduler issue: bad scheduling latency case
X-Mailer-Plugin: AntiSpam for Becky!2 Ver.0.306
X-Spam-TotalCounts: 8 Counts
X-Spam-TotalRatios: 2 Percents
Message-Id: <20030507005733.D343.INOUEH@uranus.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found a case which may introduce bad scheduling latency up to
10 msec (or 1/HZ sec) in task scheduler of kernel 2.4.20 at SMP machine.

In schedule(), if other CPU in the system set "need_resched" flag
of task struct within the section showed below in order to request 
rescheduling, this reschedule request can be neglected.


		case TASK_RUNNING:;
	}
*****	prev->need_resched = 0;  ***************   // begin section 

	/*
	 * this is the scheduler proper:
	 */

(Omission)

	/*
	 * from this point on nothing can prevent us from
	 * switching to the next task, save this fact in
	 * sched_data.
	 */
*****	sched_data->curr = next;   *************  // end section
	task_set_cpu(next, this_cpu);


This case seems to be very rare, but it was observed that this occurred 
several times while I compiled a Linux kernel in my environment (machine 
with 2 logical CPUs by Hyper-Threading enabled processor). 

A simple patch for this issue is attached.
Does it make sense?



diff -Nru linux-2.4.20-orig/kernel/sched.c linux-2.4.20/kernel/sched.c
--- linux-2.4.20-orig/kernel/sched.c	Fri Nov 29 08:53:15 2002
+++ linux-2.4.20/kernel/sched.c	Fri Apr 11 16:04:34 2003
@@ -625,6 +625,11 @@
 		goto repeat_schedule;
 	}
 
+	if (unlikely(prev->need_resched)) {
+		prev->need_resched = 0;
+		goto repeat_schedule;
+	}
+
 	/*
 	 * from this point on nothing can prevent us from
 	 * switching to the next task, save this fact in



Regards,
Hiroshi Inoue <inoueh@uranus.dti.ne.jp>

