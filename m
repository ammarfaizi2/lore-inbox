Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUJPVBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUJPVBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268873AbUJPVBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:01:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47579 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268877AbUJPVBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:01:14 -0400
Date: Sat, 16 Oct 2004 23:02:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041016210231.GA14939@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161426020.1223@gradall.private.brainfood.com> <20041016193626.GB10626@elte.hu> <Pine.LNX.4.58.0410161457410.1223@gradall.private.brainfood.com> <20041016201417.GA12371@elte.hu> <4171871D.3000601@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4171871D.3000601@timesys.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john cooper <john.cooper@timesys.com> wrote:

> Ingo,
>    In reading your -U3 patch the test below (#156)
> wasn't clear to me.   It would seem in the case of
> softirq_preemption, __do_softirq() should be called
> to kick ksoftirqd, otherwise ___do_softirq() would
> be called to exec softirqs in the immediate context.

the dependencies here are a bit complex due to the
various compile-time and runtime flags, and various
architecture call-ins to softirq.c.

> kernel/softirq.c:
> 
>  153   asmlinkage void _do_softirq(void)
>  154   {
>  155           local_irq_disable();
>  156           if (!softirq_preemption)
>  157                   __do_softirq();
>  158           else
>  159                   ___do_softirq();
>  160           local_irq_enable();
>  161   }

___do_softirq() is the 'lowest level' softirq function, it
directly executes the handlers.

__do_softirq() disables bhs and calls ___do_softirq() - this
is the 'direct' softirq execution model, this function is
called by hardirq contexts and by softirqd. [btw., irqd calls
this function too which is a bit pointless.] In the indirect
execution model (SOFTIRQ_PREEMPT) this function does no softirq
execution, it only wakes up softirqd.

_do_softirq() is what is called by softirqd - dependent on the
execution model this function will either execute ___do_softirq()
[no additional locking or bh disabling] in the threaded case,
while in the direct case it will execute __do_softirq().

so the logic seems to be correct to me. (except for the minor
detail of irqd calling __do_softirq() which doesnt make much 
sense but which is harmless otherwise.)

with DEBUG_PREEMPT it is relatively safe to call ___do_softirq()
from softirqd (without doing the extra bh disabling), because
the two main rules of softirqs are still preserved:

 1) softirq execution doesnt reenter itself

 2) per-CPU assumptions safely detected

	Ingo
