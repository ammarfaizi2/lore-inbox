Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSIKHQS>; Wed, 11 Sep 2002 03:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318458AbSIKHQS>; Wed, 11 Sep 2002 03:16:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10205 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318447AbSIKHQR>;
	Wed, 11 Sep 2002 03:16:17 -0400
Date: Wed, 11 Sep 2002 09:26:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Drokin <green@namesys.com>
Cc: Robert Love <rml@tech9.net>, Thomas Molina <tmolina@cox.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Problem Status Report
In-Reply-To: <20020911110709.A6193@namesys.com>
Message-ID: <Pine.LNX.4.44.0209110915140.5546-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Sep 2002, Oleg Drokin wrote:

> > >    BUG at kernel/sched.c        open                  10 Sep 2002
> > What exactly is this?
> 
> Looks like this is my bugreport for BUG in kernel/sched.c:944 in the middle
> of partition parsing output on boot.
> 
> Subject of email was
> '2.5.34 BUG at kernel/sched.c:944 (partitions code related?)'
> msgid: 20020910175639.A830@namesys.com

very strange backtrace:

 >>EIP; c0115818 <schedule+18/4a0>   <=====
 Trace; c01053a0 <default_idle+0/40>
 Trace; c0105000 <_stext+0/0>
 Trace; c01053c8 <default_idle+28/40>
 Trace; c010547e <cpu_idle+4e/50>
 Trace; c010506c <rest_init+6c/70>

i've once seen the 2.5 IDE code doing a schedule_timeout() from an IRQ
handler, but the above has to be something else. Could you hack sched.c to
print out the exact preemption count? It could be a preempt-count
underflow due to an unbalanced spin_unlock, or an inbalanced
preempt_enable. [or the IRQ code - but i doubt that, we'd have seen
problems much earlier if this was the case.]

Oleg, do you have CONFIG_DEBUG_SPINLOCK enabled? That should catch an
unbalanced spin_unlock().

Robert, i'd suggest to add some sort of debugging code for this anyway, if
preempt_count goes below 0, right now we do this:

 #define dec_preempt_count() \
 do { \
         preempt_count()--; \
 } while (0)

this should be something like:

 #if CONFIG_DEBUG_SPINLOCK

 #define dec_preempt_count() \
 do { \
         if (!--preempt_count()) \
                 BUG(); \
 } while (0)

 #else

 #define dec_preempt_count() \
 do { \
         preempt_count()--; \
 } while (0)

 #endif

or introduce a separate debug config option, CONFIG_DEBUG_PREEMPT - until
all code is converted. This should catch a bad preempt_enable where it
happens.

	Ingo

