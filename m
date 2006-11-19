Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933395AbWKSVvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395AbWKSVvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbWKSVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:51:03 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:24811 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S933395AbWKSVvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:51:01 -0500
Date: Mon, 20 Nov 2006 00:50:53 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <jens.axboe@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@timesys.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, manfred@colorfullife.com
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061119215053.GA176@oleg>
References: <20061119190027.GA3676@oleg> <Pine.LNX.4.44L0.0611191512280.15059-100000@netrider.rowland.org> <20061119205516.GA117@oleg> <20061119212057.GE4427@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119212057.GE4427@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Paul E. McKenney wrote:
>
> On Sun, Nov 19, 2006 at 11:55:16PM +0300, Oleg Nesterov wrote:
> > So synchronize_xxx() should do
> >
> > 	smp_mb();
> > 	idx = sp->completed++ & 0x1;
> >
> > 	for (;;) { ... }
> >
> > >               You see, there's no way around using synchronize_sched().
> >
> > With this change I think we are safe.
> >
> > If synchronize_xxx() increments ->completed in between, the caller of
> > xxx_read_lock() will see all memory ops (started before synchronize_xxx())
> > completed. It is ok that synchronize_xxx() returns immediately.
>
> Let me take Alan's example one step further:
>
> o	CPU 0 starts executing xxx_read_lock(), but is interrupted
> 	(or whatever) just before the atomic_inc().
>
> o	CPU 1 executes synchronize_xxx() to completion, which it
> 	can because CPU 0 has not yet incremented the counter.

Let's suppose for simplicity that CPU 1 does "classical"

	old = global_ptr;
	global_ptr = new_value();

before synchronize_xxx(), and ->completed == 0.

Now, synchronize_xxx() sets ->completed == 1. Because of mb()
'global_ptr = new_value()' is completed.

> o	CPU 0 returns from interrupt and completes xxx_read_lock(),
> 	but has incremented the wrong counter.

->completed == 1, it is not so wrong, see below

> o	CPU 0 continues into its critical section, picking up a
> 	pointer to an xxx-protected data structure (or, in Jens's
> 	case starting an xxx-protected I/O).

it sees the new value in global_ptr, we are safe.

> o	CPU 1 executes another synchronize_xxx().  This completes
> 	immediately because CPU 1 has the wrong counter incremented.

No, it will notice .ctr[1] != 1 and wait.

> o	CPU 1 continues, either freeing a data structure while
> 	CPU 0 is still referencing it, or, in Jens's case, completing
> 	an I/O barrier while there is still outstanding I/O.

CPU 1 continues only when CPU 0 does read_unlock(/*completed*/ 1),
we are safe.

Safe?

Oleg.

