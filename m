Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWGXQAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWGXQAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWGXQAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:00:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:12356 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751321AbWGXQAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:00:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=JvSlS8OcZCZeUx/H3/cPGEmfR3YallwJ3cGXt9W293VsLauBIcnkYGyrTI9jfSdgVVmpT/UzruFwufIaHGBFlEcg7c8mEiO4VOw5tGU0nTXFEu/2qca5dzfJy5+KyeywM7EN+vpF6OBUERRKiRNp1hNIDc6cExoe5M/+tKPNo/4=
Date: Mon, 24 Jul 2006 18:00:24 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Duetsch, Thomas LDE1" <thomas.duetsch@siemens.com>
Subject: Re: [RT] rt priority losing
In-Reply-To: <1153755660.4002.137.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607241758420.10471@localhost.localdomain>
References: <1153755660.4002.137.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Steven Rostedt wrote:

> Ingo or Tglx,
>
> It has come to my attention that the dynamic hrtimer softirq can lose a
> boosted priority.  That is, if a softirq is running while a timeout
> happens, and the call back is of lower priority than the currently
> running hrtimer softirq, the timer interrupt will still lower the
> hrtimer softirq.
>
> Here's the problem code:
>
> static void wakeup_softirqd_prio(int softirq, int prio)
> {
> 	/* Interrupts are disabled: no need to stop preemption */
> 	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
>
> 	if (tsk) {
> 		if (tsk->normal_prio != prio) {
> 			struct sched_param param;
>
> 			param.sched_priority = MAX_RT_PRIO-1 - prio;
> 			setscheduler(tsk, -1, SCHED_FIFO, &param);
> 		}
> 		if(tsk->state != TASK_RUNNING)
> 			wake_up_process(tsk);
> 	}
> }
>
>
> So, tsk could be softirqd-hrmono and we lower the priority. (only
> normal_prio is checked versus prio).
>
> So this can be a problem, if the softirq function holds a lock of a high
> priority task, and is running boosted.  If another timer goes off with a
> lower priority, we can lower the priority of the softirqd and lose the
> inherited priority that it was running at.

There is a check for that inside setscheduler():
 	p->prio = rt_mutex_getprio(p);

Esben

>
> -- Steve
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
