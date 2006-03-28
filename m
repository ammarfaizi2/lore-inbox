Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWC1WXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWC1WXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWC1WXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:23:31 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:467 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S932447AbWC1WXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:23:31 -0500
Date: Tue, 28 Mar 2006 23:23:20 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <1143581802.5344.229.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0603282313050.22822-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Thomas Gleixner wrote:

> On Tue, 2006-03-28 at 22:17 +0100, Esben Nielsen wrote:
> > I think we talk about the situation
>
> No, we talk about existing lock chains L(0) --> L(n).
>
> >                         B locks 1            C locks 2       D locks 3
> >                         B locks 2, boosts C and block
> >       A locks 2
> >       A is boost B
> >       A drop it's spinlocks and is preempted
> >                                              C unlocks 2 and auto unboosts
> >                         B is running
> >                         B locks 3, boosts C and blocks
> >       A gets a CPU again
> >       A boosts B
> >       A boosts D
> >
> > Is there anything wrong with that?
> > And in the case where A==D there indeed is a deadlock which will be
> > detected.
>
> If you get to L(x) the underlying dependencies might have changed
> already as well as the dependencies x ... n. We might get false
> positives in the deadlock detection that way, as a deadlock is an
> "atomic" state.

As I see it you might detect a circular lock graph "atomically". But is
that a "deadlock"? Yes, if you rule out signals and timeouts, this
situation does indeed deadlock your program.

But if you count in signals and timeouts your algoritm also gives "false
positives": You can detect a circular lock but when you return from
rt_mutex_slowlock(), a signal is delivered and there is no longer a
circular dependency and most important: The program wouldn't be
deadlocked even if you didn't ask for deadlock detection and your task in
that case would block.

I would like to see an examble of a false deadlock. I don't rule them out
in the present code. But they might be simple to fix.

Esben

>
> 	tglx
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

