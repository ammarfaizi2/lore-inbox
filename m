Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSFKSZS>; Tue, 11 Jun 2002 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSFKSZR>; Tue, 11 Jun 2002 14:25:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62710 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317488AbSFKSZQ>; Tue, 11 Jun 2002 14:25:16 -0400
Subject: Re: [patch] current scheduler bits #2, 2.5.21
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206111917220.14481-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 11:25:13 -0700
Message-Id: <1023819914.21176.266.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 10:35, Ingo Molnar wrote:

> anyway, my current tree has a new type of optimization which again changes
> the way task_rq_lock() and task_rq_unlock() looks like: in this specific
> case we can rely on __cli() disabling preemption, we do not need to
> elevate the preemption count in this case. (Some special care has to be
> taken to not cause a preemption with the raw rq spinlock held, which the
> patch does.)

Ow, I thought about doing this but decided against it.  If we merge
this, we have to be _very_ careful.  Any code that sets need_resched
explicitly will cause a preemption on a preempt_enable (implicitly off
any unlock, etc ...).  Is this worth it to save an inc/dec?

Hm,

	static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
	{
		_raw_spin_unlock_irqrestore(&rq->lock, *flags);
	}

Don't we want to explicitly check for a preemption here?  Using your new
preempt_check_resched() would make sense...

> and i found and fixed a preemption latency source in wait_task_inactive().
> That function can create *very* bad latencies if the target task happens
> to not go away from its CPU for many milliseconds (for whatever reason).
> So we should and can check the resched bit.

Hm, this may be the cause of the latency issues some have raised. 
Dieter Nutzel, for example, has been saying sometime early in O(1)'s
life it killed latency with the preemptible kernel... this may be it.

I'll check it out.  Good job.

	Robert Love

