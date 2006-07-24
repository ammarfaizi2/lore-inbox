Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWGXQyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWGXQyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWGXQym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:54:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:51207 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932211AbWGXQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:54:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Ot8isN9nuy8ukBiFhf7xC+L5vXYzrfvXBKL9Sej7XrMNuNY1pndBWU9r5zQrNoaHdiRBiV9XP8vSaacDLxCKU16Idust414YlrvK2l4Hn0Zci2AYCulGz775Y67A02t54HESP4DyGew5luDmPpIw1oNmcgJKGYjPXmh4gEdq+us=
Date: Mon, 24 Jul 2006 18:54:58 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Duetsch, Thomas LDE1" <thomas.duetsch@siemens.com>
Subject: Re: [RT] rt priority losing
In-Reply-To: <1153759042.11295.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607241854360.10471@localhost.localdomain>
References: <1153755660.4002.137.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607241758420.10471@localhost.localdomain>
 <1153759042.11295.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Steven Rostedt wrote:

> On Mon, 2006-07-24 at 18:00 +0100, Esben Nielsen wrote:
>> On Mon, 24 Jul 2006, Steven Rostedt wrote:
>>
>>> Ingo or Tglx,
>>>
>>> It has come to my attention that the dynamic hrtimer softirq can lose a
>>> boosted priority.  That is, if a softirq is running while a timeout
>>> happens, and the call back is of lower priority than the currently
>>> running hrtimer softirq, the timer interrupt will still lower the
>>> hrtimer softirq.
>>>
>>> Here's the problem code:
>>>
>>> static void wakeup_softirqd_prio(int softirq, int prio)
>>> {
>>> 	/* Interrupts are disabled: no need to stop preemption */
>>> 	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
>>>
>>> 	if (tsk) {
>>> 		if (tsk->normal_prio != prio) {
>>> 			struct sched_param param;
>>>
>>> 			param.sched_priority = MAX_RT_PRIO-1 - prio;
>>> 			setscheduler(tsk, -1, SCHED_FIFO, &param);
>>> 		}
>>> 		if(tsk->state != TASK_RUNNING)
>>> 			wake_up_process(tsk);
>>> 	}
>>> }
>>>
>>>
>>> So, tsk could be softirqd-hrmono and we lower the priority. (only
>>> normal_prio is checked versus prio).
>>>
>>> So this can be a problem, if the softirq function holds a lock of a high
>>> priority task, and is running boosted.  If another timer goes off with a
>>> lower priority, we can lower the priority of the softirqd and lose the
>>> inherited priority that it was running at.
>>
>> There is a check for that inside setscheduler():
>>  	p->prio = rt_mutex_getprio(p);
>
> OK, you are right about this.  The PI chain should not be affected.  But
> this could still be a problem if the softirq was running at a high prio
> for a task when a lower prio callback needs to be made.  It looks like
> timer is removed from the base before the function runs.  So when the
> interrupt looks at the base to determine the priority to set it at, it
> might actually lower the priority of a running hrtimer thread.
>

That is a simple bug which ought to be simple fixable.

Esben
> -- Steve
>
>
