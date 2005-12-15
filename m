Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVLOUwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVLOUwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVLOUwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:52:55 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34973 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751066AbVLOUwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:52:54 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux@horizon.com
In-Reply-To: <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
References: <20051215135812.14578.qmail@science.horizon.com>
	 <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 15:52:41 -0500
Message-Id: <1134679961.13138.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 08:15 -0800, Linus Torvalds wrote:
> 
> On Thu, 15 Dec 2005, linux@horizon.com wrote:
> > 
> > A counting semaphore is NOT a perfectly fine mutex, and it SHOULD be changed.
> 
> Don't be silly.
> 
> First off, the data structure is called a "semaphore", and always has 
> been. It's _never_ been called a "mutex" in the first place, and the 
> operations have been called "down()" and "up()", because I thought calling 
> them P() and V() was just too damn traditional and confusing (I don't 
> speak dutch, and even if I did, I think shortening names to that degree is 
> just evil).

Thank you for the down and up, I always had problems way back when I was
in college.  I could never remember which was which (between P and V).

> And dammit, a counting semaphore (and usually you don't even say the 
> "counting" part, since counting is really always there) is just about 
> _the_ classical mutual exclusion mechanism. If somebody doesn't know that, 
> he has absolutely _no_ place talking about mutexes etc.
> 
> And a semaphore _is_ a mutex. Anybody who disputes that is just being a 
> total troll. Even classically, the case where the semaphore was 
> initialized to 1 is very very traditional, and is very much part of the 
> whole point of a semaphore. Sometimes they are called "binary semaphores", 
> but dammit, they are just the same thing.

<Total Troll> ;)

Uh, I think that a semaphore is _not_ a mutex.  As someone early said,
that a mutex is a semaphore, but not the other way around.  I have used
counting semaphores for resource allocations, not the semaphore=1 kind.
This is not a mutual exclusion, its shared.

Also a semaphore can be declared locked, a mutex cant.

Of course, if you said "binary semaphores" is a mutex, then I would
agree with you.

</Total Troll>


> 
> A patch that
>  - creates a non-counting mutex
>  - .. that is SLOWER than the current counting one
>  - .. and keeps the old "semaphore" and "up/down" naming
> 
> is simply INCREDIBLY BROKEN. It has absolutely _zero_ redeeming features. 
> I can't understand how there are a hundred emails in my mailbox even 
> discussing it. 

ACK

But that was just somebody's (David) first crack at this patch.  But
I've been pushing that he should first submit the mutex, where everyone
else can help make it really fast, and then submit the case by case
places that the semaphores should be replaced with mutex.  That's the
most logical way I see it. And yes, even if that means lots of patches,
but it makes it easier for more than one person to submit that, and
review.

> 
> And I can't understand how somebody has the balls to even say that a 
> semaphore isn't a mutex. That's like saying that an object of type "long" 
> isn't an integer, because only "int" objects are integers. That's just 
> INSANE.

No it's like saying a integer is a long. Wait did someone else say that
already?

> 
> > People are indeed unhappy with the naming, and whether patching 95%
> > of the callers of up() and down() is a good idea is a valid and active
> > subject of debate.  (For an out-of-tree -rt patch, is was certaintly
> > an extremely practical solution.)
> 
> Whatever people you claim are unhappy with the naming are
>  - obviously totally unaware of very basic synchronization primitives
>    used in concurrent programming
>  - likely haven't spent any time at all looking at the kernel source code.
>  - haven't _ever_ complained that I've seen before this totally made-up 
>    discussion.

:( I'm unhappy with calling a mutex down and up. But lets see if I am
any of the above?

1. Being the one to remove the global PI lock in the rt patch, gives me
some credit that I understand basic synchronization primitives used in
concurrent programming.

2. Have been playing with the Linux kernel source since 1998 (just not
publicly until 2003).

3.  OK, you got me there ;)


> 
> In other words, you are
>  (a) totally making up the claim that people are really unhappy
>  (b) jerking people around who _do_ know about semaphores and _have_ 
>      worked with the kernel locking primitives and understand them well

I'm one that would like to see semaphores turn to mutex when they really
are one.  But I'd like to keep up / down for semaphores (as they are
today) and introduce a new mutex api mutex_lock / mutex_unlock, since I
think that is the best way to explain what's going on.

> 
> So tell me, what do you think about your own arguments in that light?
> 
> > But regardless of the eventual naming convention, mutexes are a good idea.
> > A mutex is *safer* than a counting semaphore.  That's the main benefit.
> > Indeed, unless there's a performance advantage to a counting semaphore,
> > you should use a mutex!
> 
> Hey, feel free to introduce a mutex, but DAMMIT, just call it that, 
> instead of switching people over. 

ACK

> 
> And even then, it should damn well also:
>  - really _be_ faster. On platforms that matter. 
>  - have enough real other advantages that it's worth introducing another 
>    abstraction, and more conceptual complexity. At least the RT patches 
>    had a reason for them.

Actually, I would like this change to make it in mainline to help with
the RT patches.

> 
> And besides, all your "safer" arguments are pretty damn pointless in the 
> face of the fact that we have basically had zero bugs with the semaphores. 
> This is not where the bugs happen. Yeah, yeah, double releases can happen, 
> but it sure as hell isn't on my radar of things I remember people doing.
> 
> So when you say "This isn't about speed, this is about bug-free code", 
> you're just making that up. It's doubly silly when your "safer" 
> implementation uses totally illogical names. THAT is what creates bugs.
> 
> So go away.
> 
> Come back if you have pondered, and accepted reality, and perhaps have an 
> acceptable patch that introduces a separate data structure. 
> 
> And no, we're not switching users over whole-sale. First you introduce the 
> new concept. Only THEN can you can switch over INDIVIDUAL LOCKS with 
> reasons for why it's worth it.
> 
> And hell yes, performance does matter.

And so do a lot of other things.

-- Steve


