Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWALMyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWALMyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWALMyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:54:54 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:2954 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S964912AbWALMyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:54:52 -0500
Date: Thu, 12 Jan 2006 13:54:23 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <20060112113316.GA14416@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44L0.0601121337480.30644-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Jan 2006, Bill Huey wrote:

> On Wed, Jan 11, 2006 at 06:25:36PM +0100, Esben Nielsen wrote:
> > I have done 2 things which might be of interrest:
> >
> > II) I changed the priority inheritance mechanism in rt.c,
> > optaining the following goals:
> > 3) Simpler code. rt.c was kind of messy. Maybe it still is....:-)
>
> Awssome. The code was done in what seems like a hurry and mixes up a
> bunch of things that should be seperate out into individual sub-sections.

*nod*
I worked on the tester before christmas and only had a few evenings for
myself to look at the kernel after christmas. With a fulltime job and a family
I don't get many spare hours with no disturbance to code (close to none
really), so I had to ship it while my girlfriend and child were away for a
few days.

>
> The allocation of the waiter object on the thread's stack should undergo
> some consideration of whether this should be move into a more permanent
> store.

Hmm, why?
When I first saw it in the Linux kernel I thought: Damn this is elagant.
You only need a waiter when you block, and while you block your stack is
untouched. When you don't block you don't need the waiter, so why have it
allocated somewhere else, say in task_t?

> I haven't looked at an implementation of turnstiles recently,

turnstiles? What is that?

> but
> I suspect that this is what it actually is and it would eliminate the
> moving of waiters to the thread that's is actively running with the lock
> path terminal mutex. It works, but it's sloppy stuff.
>
> [loop trickery, priority leanding operations handed off to mutex owner]
>
> > What is gained is that the amount of time where irq and preemption is off
> > is limited: One task does it's work with preemption disabled, wakes up the
> > next and enable preemption and schedules. The amount of time spend with
> > preemption disabled is has a clear upper limit, untouched by how
> > complicated and deep the lock structure is.
>
> task_blocks_on_lock() is another place that one might consider seperating
> out some bundled functionality into different places in the down()
> implementation.

What is done now with my patch is "minimal", but you have to add your
self to the wait list. You also have to boost the owner of the lock.
You might be able to split it up by releasing and reacquiring all the
spinlocks; but I am pretty much sure this is not the place in the
whole system giving you the longest preemptions off section, so it doesn't
make much sense to improve it.


> I'll look at the preemption stuff next.
>
> Just some ideas. Looks like a decent start.
>

Thanks for the positive response!

Esben

> bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

