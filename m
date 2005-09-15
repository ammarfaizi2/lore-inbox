Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVIOKvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVIOKvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVIOKvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:51:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62700 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964787AbVIOKve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:51:34 -0400
Date: Thu, 15 Sep 2005 12:51:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, torvalds@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050914124642.1b19dd73.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0509150116150.3728@scrub.home>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
 <20050912043943.5795d8f8.akpm@osdl.org> <20050912075155.3854b6e3.pj@sgi.com>
 <Pine.LNX.4.61.0509121821270.3743@scrub.home> <20050912153135.3812d8e2.pj@sgi.com>
 <Pine.LNX.4.61.0509131120020.3728@scrub.home> <20050913103724.19ac5efa.pj@sgi.com>
 <Pine.LNX.4.61.0509141446590.3728@scrub.home> <20050914124642.1b19dd73.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Sep 2005, Paul Jackson wrote:

> Arghh.  I'm still playing 'pin the tail on the donkey' guessing games
> here, trying to guess what you think is necessary.

Sorry, I thought it was more obvious... :)

> So, if a per-cpuset spinlock isn't necessary, then are you saying that
> going from one global local to two global locks (where the second one
> might be a spinlock) might work?  Or are you saying just the current
> one global semaphore should work?  I'm guessing the former, as you can
> see from my further replies below.

In the basic model you need two locks. 1) the current semaphore for 
general cpusem management 2) a second lock to synchronize with kernel 
callbacks, the type of this lock depends on the callback requirements, 
but for simplicity let's assume a spinlock. It's possible to split it 
further into per-cpuset spinlocks, but let's get the basic scheme 
working, more fine grained locking can be built on top of this.

> Question 1:
> 
>     Roman: This means you have to take the second lock ...
> 
>     Paul: By "second lock", did you mean what you described in your
> 	  earlier message as:
>     	  > low-level lock (maybe even a spinlock) which manages the
> 	  > state of an active cpuset.
> 
>     [Aside - note your phrase 'manages the state of an active cpuset'.
> 	It doesn't surprise me that I thought from this you had in
> 	mind a per-cpuset lock, not just a second global lock.]

Active meant here that it's attached to a task. Any access to 
"tsk->cpuset" has to be protected by the spinlock (in the general case, 
e.g. for cpuset_exit() it's avoidable).

>     Roman:
>     > The only (simple) solution I see is to do this:
>     > 
>     > 	lock();
>     > 	tsk->cpuset = current->cpuset;
>     > 	atomic_inc(&tsk->cpuset->count);
>     > 	unlock();
> 
>     Paul: What "lock()" and "unlock()" is this?  Your "second lock",
>     	  aka "low-level lock (maybe even a spinlock)" ?

Yes, see aove.

> > Modifications in the cpuset hierarchy require the cpuset_sem and an 
> > inactive cpuset, (de)activating a cpuset requires the cpuset_sem and 
> > (let's call it) cpuset_tasklock.
> 
> Is this 'cpuset_tasklock' the same as the earlier 'second lock'
> and the 'lock()/unlock()'?  My current guess is yes - same.

Yes.

> I suspect, though I haven't gotten it clear enough yet in my
> mind to be confident, that something like I guess you're describing
> would be sufficient to keep a cpuset from evaporating out from under
> us.
> 
> And from this last comment of yours, I am guessing that 'cpuset_tasklock'
> is one global lock, not per cpuset, and that the answer to my first
> question above is that you are suggesting going from one global lock
> to two global locks.
> 
> But I don't see what, in your proposal, ensures that it is safe to
> read out the mems_allowed vector (multi-word, perhaps).  I need to
> do more than make sure cpusets don't evaporate out from under me
> at inopportune times.  I also need to freeze their values, so I
> can do non atomic reads of multiple distinct values, or of multiword
> values, out of them.  What does that?

All kernel callbacks are done using the spinlock, as soon as you hold this 
spinlock it's safe to dereference tsk->cpuset, as attach_task() can't 
change this field. Also attach_task() makes sure that the count of an 
attached cpuset is always different from zero, so cpuset_rmdir() cannot 
remove it. attach_task() and cpuset_rmdir() are synchronized using the 
semaphore.

You have to concentrate on the state of a cpuset, it can be either active 
or inactive. Certain operations (e.g. removal) are only possible if it's 
inactive and these are protected by the semaphore. Other operations are 
only possible when the cpuset is active and you need the spinlock for 
them, as long as the cpuset is active and you only hold the semaphore 
some operations are not possible (e.g. changing the parent).
attach_task() switches between these two states and so has to shortly 
take both locks.

> I'm also inclined, if I see that it is within reach, to prefer a
> per-cpuset lock, rather than just global locks.  If I could get
> the locks that are required by the callbacks, such as from beneath
> __alloc_pages(), to only need per-cpuset locks, then this would reduce
> the risk that these turn into performance and scalability issues
> someday on really large systems.  I've got a nice hierarchy to the
> cpusets, so imposing the partial order on per-cpuset locks necessary
> to avoid deadlock should be easy enough.

Yes, but that's a separate step.

> Roman wrote [modified to reinsert some ellided code - pj]:
> > You're right, it should better look like this:
> > 
> > 	tsk->cpuset = NULL;
> > 	if (atomic_read(&cs->count) == 1 && notify_on_release(cs)) {
> >                 char *pathbuf = NULL;
> > 
> >                 cpuset_down(&cpuset_sem);
> >                 if (atomic_dec_and_test(&cs->count))
> >                         check_for_release(cs, &pathbuf);
> >                 cpuset_up(&cpuset_sem);
> >                 cpuset_release_agent(pathbuf);
> > 	}
> > 	atomic_dec(&cs->count);
> > 
> > This way it only may happen that two notifaction are sent.
> 
> I don't think that works at all.  Consider the following sequence:
> 	1) The first 'atomic_read' returns 2
> 	2) [ The other task holding a reference drops out. ]
> 		(so count is 1 now)
> 	3) The atomic_dec() moves the count from 1 to 0.
> 	4) Oops - we just missed doing a release.

If you want to do it like this, just add an else before the last 
atomic_dec().
The main point I was trying to make is that clearing tsk->cpuset doesn't 
require the spinlock, as long as you check for dead tasks in 
attach_task(). Ignore the rest if it's too confusing.

bye, Roman
