Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVH2R4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVH2R4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVH2R4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:56:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:4506 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751197AbVH2Rzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:55:47 -0400
Date: Mon, 29 Aug 2005 19:55:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/10] s390: pfault interrupt race.
Message-ID: <20050829175542.GF6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/10] s390: pfault interrupt race.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

There is a race in pfault_interrupt. That function gets called two times
for each pfault notification. Once with a subcode of 0 to indicate that
a real page is not available and once with a subcode of 0x80 to indicate
that the page is present again. Since the two external interrupts can be
delivered on two different cpus the order in which the two calls are made
is unpredictable. It is possible that the subcode 0x80 interrupt is
completed before the subcode 0x00 interrupt has done the wake_up() call.
To avoid calling wake_up() on an already removed task structure proper
task structure reference counting is needed. Increase the reference
counter in the subcode 0x00 interrupt before setting pfault_wait to zero
and return the reference after the wake_up call.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/fault.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/fault.c	2005-08-29 19:18:09.000000000 +0200
@@ -563,12 +563,14 @@ pfault_interrupt(struct pt_regs *regs, _
 			 * interrupt. pfault_wait is valid. Set pfault_wait
 			 * back to zero and wake up the process. This can
 			 * safely be done because the task is still sleeping
-			 * and can't procude new pfaults. */
+			 * and can't produce new pfaults. */
 			tsk->thread.pfault_wait = 0;
 			wake_up_process(tsk);
+			put_task_struct(tsk);
 		}
 	} else {
 		/* signal bit not set -> a real page is missing. */
+		get_task_struct(tsk);
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (xchg(&tsk->thread.pfault_wait, 1) != 0) {
 			/* Completion interrupt was faster than the initial
@@ -578,6 +580,7 @@ pfault_interrupt(struct pt_regs *regs, _
 			 * mode and can't produce new pfaults. */
 			tsk->thread.pfault_wait = 0;
 			set_task_state(tsk, TASK_RUNNING);
+			put_task_struct(tsk);
 		} else
 			set_tsk_need_resched(tsk);
 	}
