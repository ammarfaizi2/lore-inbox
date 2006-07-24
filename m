Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWGXQht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWGXQht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGXQht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:37:49 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23444 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932204AbWGXQht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:37:49 -0400
Subject: Re: [RT] rt priority losing
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Duetsch, Thomas LDE1" <thomas.duetsch@siemens.com>
In-Reply-To: <Pine.LNX.4.64.0607241758420.10471@localhost.localdomain>
References: <1153755660.4002.137.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607241758420.10471@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 12:37:22 -0400
Message-Id: <1153759042.11295.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 18:00 +0100, Esben Nielsen wrote:
> On Mon, 24 Jul 2006, Steven Rostedt wrote:
> 
> > Ingo or Tglx,
> >
> > It has come to my attention that the dynamic hrtimer softirq can lose a
> > boosted priority.  That is, if a softirq is running while a timeout
> > happens, and the call back is of lower priority than the currently
> > running hrtimer softirq, the timer interrupt will still lower the
> > hrtimer softirq.
> >
> > Here's the problem code:
> >
> > static void wakeup_softirqd_prio(int softirq, int prio)
> > {
> > 	/* Interrupts are disabled: no need to stop preemption */
> > 	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
> >
> > 	if (tsk) {
> > 		if (tsk->normal_prio != prio) {
> > 			struct sched_param param;
> >
> > 			param.sched_priority = MAX_RT_PRIO-1 - prio;
> > 			setscheduler(tsk, -1, SCHED_FIFO, &param);
> > 		}
> > 		if(tsk->state != TASK_RUNNING)
> > 			wake_up_process(tsk);
> > 	}
> > }
> >
> >
> > So, tsk could be softirqd-hrmono and we lower the priority. (only
> > normal_prio is checked versus prio).
> >
> > So this can be a problem, if the softirq function holds a lock of a high
> > priority task, and is running boosted.  If another timer goes off with a
> > lower priority, we can lower the priority of the softirqd and lose the
> > inherited priority that it was running at.
> 
> There is a check for that inside setscheduler():
>  	p->prio = rt_mutex_getprio(p);

OK, you are right about this.  The PI chain should not be affected.  But
this could still be a problem if the softirq was running at a high prio
for a task when a lower prio callback needs to be made.  It looks like
timer is removed from the base before the function runs.  So when the
interrupt looks at the base to determine the priority to set it at, it
might actually lower the priority of a running hrtimer thread.

-- Steve


