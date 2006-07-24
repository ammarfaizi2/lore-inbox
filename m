Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWGXPli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWGXPli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWGXPli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:41:38 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51675 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751164AbWGXPli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:41:38 -0400
Subject: [RT] rt priority losing
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       "Duetsch, Thomas LDE1" <thomas.duetsch@siemens.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 11:41:00 -0400
Message-Id: <1153755660.4002.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo or Tglx,

It has come to my attention that the dynamic hrtimer softirq can lose a
boosted priority.  That is, if a softirq is running while a timeout
happens, and the call back is of lower priority than the currently
running hrtimer softirq, the timer interrupt will still lower the
hrtimer softirq.

Here's the problem code:

static void wakeup_softirqd_prio(int softirq, int prio)
{
	/* Interrupts are disabled: no need to stop preemption */
	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);

	if (tsk) {
		if (tsk->normal_prio != prio) {
			struct sched_param param;

			param.sched_priority = MAX_RT_PRIO-1 - prio;
			setscheduler(tsk, -1, SCHED_FIFO, &param);
		}
		if(tsk->state != TASK_RUNNING)
			wake_up_process(tsk);
	}
}


So, tsk could be softirqd-hrmono and we lower the priority. (only
normal_prio is checked versus prio).

So this can be a problem, if the softirq function holds a lock of a high
priority task, and is running boosted.  If another timer goes off with a
lower priority, we can lower the priority of the softirqd and lose the
inherited priority that it was running at.

-- Steve

