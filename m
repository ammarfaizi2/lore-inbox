Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWAWPPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWAWPPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWAWPPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:15:00 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:59080 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751472AbWAWPPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:15:00 -0500
Date: Mon, 23 Jan 2006 16:14:21 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Bill Huey <billh@gnuppy.monkey.org>, Ingo Molnar <mingo@elte.hu>,
       david singleton <dsingleton@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <1138026214.6762.204.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0601231608001.8284-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Steven Rostedt wrote:

> On Mon, 2006-01-23 at 10:33 +0100, Esben Nielsen wrote:
> > On Sun, 22 Jan 2006, Bill Huey wrote:
> >
> > > On Mon, Jan 23, 2006 at 01:20:12AM +0100, Esben Nielsen wrote:
> > > > Here is the problem:
> > > >
> > > > Task B (non-RT) takes BKL. It then takes mutex 1. Then B
> > > > tries to lock mutex 2, which is owned by task C. B goes blocks and releases the
> > > > BKL. Our RT task A comes along and tries to get 1. It boosts task B
> > > > which boosts task C which releases mutex 2. Now B can continue? No, it has
> > > > to reaquire BKL! The netto effect is that our RT task A waits for BKL to
> > > > be released without ever calling into a module using BKL. But just because
> > > > somebody in some non-RT code called into a module otherwise considered
> > > > safe for RT usage with BKL held, A must wait on BKL!
> > >
> > > True, that's major suckage, but I can't name a single place in the kernel that
> > > does that.
> >
> > Sounds good. But someone might put it in...
>
> Hmm, I wouldn't be surprised if this is done somewhere in the VFS layer.
>
> >
> > > Remember, BKL is now preemptible so the place that it might sleep
> > > similar
> > > to the above would be in spinlock_t definitions.
> > I can't see that from how it works. It is explicitly made such that you
> > are allowed to use semaphores with BKL held - and such that the BKL is
> > released if you do.
>
> Correct.  I hope you didn't remove my comment in the rt.c about BKL
> being a PITA :) (Ingo was nice enough to change my original patch to use
> the acronym.)

I left it there it seems :-)

>
> >
> > > But BKL is held across schedules()s
> > > so that the BKL semantics are preserved.
> > Only for spinlock_t now rt_mutex operation, not for semaphore/mutex
> > operations.
> > > Contending under a priority inheritance
> > > operation isn't too much of a problem anyways since the use of it already
> > > makes that
> > > path indeterminant.
> > The problem is that you might hit BKL because of what some other low
> > priority  task does, thus making your RT code indeterministic.
>
> I disagree here.  The fact that you grab a semaphore that may also be
> grabbed by a path while holding the BKL means that grabbing that
> semaphore may be blocked on the BKL too.  So the length of grabbing a
> semaphore that can be grabbed while also holding the BKL is the length
> of the critical section of the semaphore + the length of the longest BKL
> hold.
Exactly. What is "the length of the longest BKL hold" ? (see below).

>
> Just don't let your RT tasks grab semaphores that can be grabbed while
> also holding the BKL :)

How are you to _know_ that. Even though your code or any code you
call or any code called from code you call haven't changed, this situation
can arise!

>
> But the main point is that it is still deterministic.  Just that it may
> be longer than one thinks.
>
I don't consider "the length of the longest BKL hold" deterministic.
People might traverse all kinds of weird lists and datastructures while
holding BKL.

> >
> > > Even under contention, a higher priority task above A can still
> > > run since the kernel is preemptive now even when manipulating BKL.
> >
> > No, A waits for BKL because it waits for B which waits for the BKL.
>
> Right.
>
> -- Steve
>
> PS. I might actually get around to testing your patch today :)  That is,
> if -rt12 passes all my tests.
>

Sounds nice :-) I cross my fingers...

Esben


>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

