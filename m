Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSHGVeh>; Wed, 7 Aug 2002 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSHGVeh>; Wed, 7 Aug 2002 17:34:37 -0400
Received: from waste.org ([209.173.204.2]:42723 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313070AbSHGVeg>;
	Wed, 7 Aug 2002 17:34:36 -0400
Date: Wed, 7 Aug 2002 16:37:40 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jesse Barnes <jbarnes@sgi.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       <jmacd@namesys.com>, <phillips@arcor.de>, <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020807210855.GA27182@sgi.com>
Message-ID: <Pine.LNX.4.44.0208071618290.16458-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Jesse Barnes wrote:

> On Wed, Aug 07, 2002 at 06:02:19PM -0300, Rik van Riel wrote:
> > On Wed, 7 Aug 2002, Jesse Barnes wrote:
> >
> > > +++ linux-2.5.30-lockassert/drivers/scsi/scsi.c Wed Aug  7 11:35:32 2002
> > > @@ -262,7 +262,7 @@
> >
> > > +        MUST_NOT_HOLD(q->queue_lock);
> >
> > ...
> >
> > > +#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
> > > +#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
> > > +#define MUST_NOT_HOLD(lock)		BUG_ON(spin_is_locked(lock))
> >
> > Please tell me the MUST_NOT_HOLD thing is a joke.
> >
> > What is to prevent another CPU in another code path
> > from holding this spinlock when the code you've
> > inserted the MUST_NOT_HOLD in is on its merry way
> > not holding the lock ?
>
> Nothing at all, but isn't that how the scsi ASSERT_LOCK(&lock, 0)
> macro worked before?  I could just remove all those checks in the scsi
> code I guess.

Who's to say that they actually worked? They look like crap to me.

> After I posted the last patch, a few people asked for MUST_NOT_HOLD so
> I added it back in.  Do you think it's a bad idea?  See the last
> thread if you're curious (Joshua's comments in particular):
> http://marc.theaimsgroup.com/?t=102764009400001&r=1&w=2

Interesting. I'm still going to say that MUST_NOT_HOLD is wrong, at least
in its current form/name.

What MUST_HOLD is saying is "the current thread is holding this lock, go
ahead, double check if you want". What MUST_NOT_HOLD says is "the current
thread is not holding this lock, feel free to check". Right now the kernel
doesn't record who grabbed a lock and the best it can do is check whether
_anyone_ is holding the lock. In the first case, it can prove a negative
if no one is holding the lock, in the second case it can't because it
can't distiguish between the current task holding a lock and any other
task holding a lock.

If we want a MUST_NOT_RECURSE, we can do that, but it means adding cpu or
current into the debugging version of spinlocks. I'd also add eip, so we
can see where the lock was acquired last and dump that when we hit a
conflict/deadlock.

And if you interpret MUST_NOT_HOLD_LOCK to mean "no one is holding this
lock" then you run into Rik's problem. Anyone who actually means this
ought to be simply taking the lock, otherwise why would they care?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


