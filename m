Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318918AbSIJBeD>; Mon, 9 Sep 2002 21:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSIJBeD>; Mon, 9 Sep 2002 21:34:03 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:61635 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318918AbSIJBeC>;
	Mon, 9 Sep 2002 21:34:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Tue, 10 Sep 2002 03:40:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17oUnq-0006tg-00@starship> <20020910014459.B5875@kushida.apsleyroad.org>
In-Reply-To: <20020910014459.B5875@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oa11-0006ww-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 02:44, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > It wasn't obvious to you, was it.  So how can you call it simple.
> 
> I have to agree.
> 
> > [...] This doesn't cover the whole range of module applications.
> > There is a significant class of module types that must rely on
> > sheduling techniques to prove inactivity.  My suggestion covers both,
> > Al has his blinders on.
> 
> Unfortunately having cleanup_module() return a value don't necessarily
> make things simpler.  Sure, it's a general solution, but it's not always
> easier to use.

It's always as easy to use, or easier.  It's certainly more obvious.

> Typically, your module's resources are protected by a lock or so.
> cleanup_module() could take this lock, check any private reference
> counts, and (because it has the lock) decide whether to proceed with
> unregistering the module's resources.  Once it begins unregistering
> resources, it's pretty committed to unregistering them all and saying it
> exited ok.

And failing silently if it can't?

> Unfortunately, once it has the lock, and the reference counts are all
> zero, it's still _not_ generally safe to cleanup up a module.
> 
> This is because any other function, for example a release() op on a
> file, or a remove() op on a PCI device, can't take a module's private
> lock, decrement the private reference count, release the lock and
> return.  There's a race between releasing the lock and returning, where
> it still isn't safe to remove the module's memory.
>
> Even waiting for a schedule to happen won't help if CONFIG_PREEMPT is
> enabled. 

That's exactly the race that is removed by having the module subsystem call 
__exit to remove the module.  Since the module subsystem checks the __exit's 
flag on return and releases the lock, so there is no window after releasing 
the lock when the releasor is still executing in the module.

> In other words, the module's idea of whether it's own resources are no
> longer in use _must_ be released by code outside the module - or at
> very least, locks protecting that information must be released outside
> the module.

Yup, that's exactly what I've proposed, in the simplest way possible.

> > Designs are not always correct just because they work.
> 
> Unfortunately it's not immediately clear to me that having
> cleanup_module() be able to abort an exit actually helps.

Silent failure is about the worst thing that we could possibly design into 
the system, but that's not even the issue I'm going on about - because I 
think it's so appallingly obvious it's wrong, I assume everybody can see that.

Rather, it's the simple fact that this is the obvious interface a naive 
person would expect, and nobody has presented a rational argument for not 
using it.

> Doing so with RCU-style "wait until none of my module functions could
> possible be in their race window" might work, though.  If you could 100%
> trust GCC's sibling call optimisation, variations on
> `spin_unlock_and_return' and `up_and_return' could be written.
> 
> But even if you can write code that's safe, is it likely to be
> understood by most module authors?  If not, it's no better than Al
> Viro's filesystem method.

It solves one of the races in a tidy, obviously correct way.  There are other 
races that are much more difficult (which don't for the most part apply to 
filesystem modules) where we have to do cute things to be sure that all 
threads are out of the module, however, that is an othogonal issue, and when 
last sighted, it had a workable solution on the table, which requires each 
task to schedule once.  Config_preempt is a trivial issue: just increment the 
preempt counter and nobody will preempt on you while you run the magic 
quiescence test.  The module runs this test, by the way, so that only modules 
that can't figure this out by some less intrusive means have to impose 
themselves on the rest of the system this way.

Anyway, this does not replace Al's filesystem method, it *uses* it, but only 
where appropriate.

Of course we can design a more complex method for accomplishing the same 
thing, but why?  Have you looked at the module.c by the way?  If you have and 
you like it, you are one sick puppy ;-)

-- 
Daniel
