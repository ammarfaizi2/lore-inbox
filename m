Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318244AbSGXHMB>; Wed, 24 Jul 2002 03:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318245AbSGXHMB>; Wed, 24 Jul 2002 03:12:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63699 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318244AbSGXHL7>;
	Wed, 24 Jul 2002 03:11:59 -0400
Date: Wed, 24 Jul 2002 09:13:58 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption
 in2.5.27?]
In-Reply-To: <Pine.LNX.4.44.0207232016410.6943-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207240903060.2193-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Jul 2002, Linus Torvalds wrote:

> > And yet here we have a case where a spin_unlock() will
> > go and turn on local interrupts.  Only with CONFIG_PREEMPT,
> > and even then, extremely rarely.
> 
> I think that's just a bug, the same way it was a bug that preemtion would
> sometimes set tsk->state to TASK_RUNNING.
> 
> I think Robert already sent a fix: make "preempt_schedule()" refuse to
> schedule if local interrupts are disabled.

my problem with Robert's patch is that the intention is not debugging, the
intention of the change was make it the standard thing. This just hides
serious bugs like the one in slab.c. I'd suggest to rather fix these bugs
and be aware of them via a debugging mechanism, instead of putting one
more (not quite cheap) check into one of our hotpaths.

> That, together with making it a warning (so that we can _fix_ places
> that have unbalanced irq/spinlock behaviour) shoul dbe fine. [...]

yep - i've moved the check from schedule() to preempt_schedule(), which
clearly is the most serious offender. This enabled the removal of the
CONFIG_DEBUG_IRQ_SCHEDULE define.

	Ingo

