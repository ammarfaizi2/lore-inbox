Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275857AbRI1HAM>; Fri, 28 Sep 2001 03:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275858AbRI1HAE>; Fri, 28 Sep 2001 03:00:04 -0400
Received: from chiara.elte.hu ([157.181.150.200]:34574 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275857AbRI1G7x>;
	Fri, 28 Sep 2001 02:59:53 -0400
Date: Fri, 28 Sep 2001 08:57:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <E15mkaf-0000ms-00@mail.tv-sign.ru>
Message-ID: <Pine.LNX.4.33.0109280836080.1569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Oleg Nesterov wrote:

> I am trying to understand the basics of softirq handling.
>
> It seems to me that ksoftirqd()'s loop can be cleanuped a bit with
> following (untested) patch on top of 2.4.10-softirq-A7.

thanks - the patch looks mostly correct.

> It also removes	the 'mask' variable in do_softirq().

(right, applied.)

> -	schedule();
> -	__set_current_state(TASK_INTERRUPTIBLE);

we need a single schedule to migrate the CPU to the right CPU. Btw, it's
not a big offense to run on the wrong CPU: do_softirq() will run
correctly. But there wont be a ksoftirqd exeuting on the 'right' CPU (for
this short amount of time until it schedules once), and we might miss a
single instance of softirq processing. So it's cleaner to do a schedule()
that guarantees that we migrate to the target CPU.

> +		__set_current_state(TASK_RUNNING);
> +	}

well, this basically reverts it to the original code and removes the
optimization - but i dont have any strong feelings in either way. I think
Andrea is right and it's more correct to set it TASK_RUNNING, for
task-statistics reasons. Reverted it to the old code.

and in fact while doing that i found another bug in the old code:
TASK_INTERRUPTIBLE was set in a non-IRQ-atomic way, so theoretically it
could be possible that the compiler reorders the setting of
TASK_INTERRUPTIBLE and the test for softirq_pending(), and if an IRQ gets
inbetween the we could miss processing softirq for 1/HZ again. Added an
optimization barrier(). (SMP-consistency is not needed, since we are
per-CPU.)

	Ingo

