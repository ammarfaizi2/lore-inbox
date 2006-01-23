Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWAWJdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWAWJdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWAWJdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:33:46 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:15266 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932133AbWAWJdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:33:45 -0500
Date: Mon, 23 Jan 2006 10:33:15 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <20060123020421.GA21208@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44L0.0601231029090.5144-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006, Bill Huey wrote:

> On Mon, Jan 23, 2006 at 01:20:12AM +0100, Esben Nielsen wrote:
> > Here is the problem:
> >
> > Task B (non-RT) takes BKL. It then takes mutex 1. Then B
> > tries to lock mutex 2, which is owned by task C. B goes blocks and releases the
> > BKL. Our RT task A comes along and tries to get 1. It boosts task B
> > which boosts task C which releases mutex 2. Now B can continue? No, it has
> > to reaquire BKL! The netto effect is that our RT task A waits for BKL to
> > be released without ever calling into a module using BKL. But just because
> > somebody in some non-RT code called into a module otherwise considered
> > safe for RT usage with BKL held, A must wait on BKL!
>
> True, that's major suckage, but I can't name a single place in the kernel that
> does that.

Sounds good. But someone might put it in...

> Remember, BKL is now preemptible so the place that it might sleep
> similar
> to the above would be in spinlock_t definitions.
I can't see that from how it works. It is explicitly made such that you
are allowed to use semaphores with BKL held - and such that the BKL is
released if you do.

> But BKL is held across schedules()s
> so that the BKL semantics are preserved.
Only for spinlock_t now rt_mutex operation, not for semaphore/mutex
operations.
> Contending under a priority inheritance
> operation isn't too much of a problem anyways since the use of it already
> makes that
> path indeterminant.
The problem is that you might hit BKL because of what some other low
priority  task does, thus making your RT code indeterministic.

> Even under contention, a higher priority task above A can still
> run since the kernel is preemptive now even when manipulating BKL.

No, A waits for BKL because it waits for B which waits for the BKL.

Esben
>
> bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

