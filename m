Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSHHMv2>; Thu, 8 Aug 2002 08:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSHHMv2>; Thu, 8 Aug 2002 08:51:28 -0400
Received: from reload.namesys.com ([212.16.7.75]:50055 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S317497AbSHHMv1>; Thu, 8 Aug 2002 08:51:27 -0400
Date: Thu, 8 Aug 2002 16:55:05 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>,
       linux-kernel@vger.kernel.org, phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808125505.GA8804@reload.namesys.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org, phillips@arcor.de, rml@tech9.net
References: <20020807210855.GA27182@sgi.com> <Pine.LNX.4.44.0208071618290.16458-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208071618290.16458-100000@waste.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MUST_NOT_HOLD_LOCK means exactly I_AM_NOT_HOLDING_LOCK, otherwise the
assertion is obviously meaningless because another processor could be holding
the lock.  But since there is no reason to assert NO_ONE_IS_HOLDING_LOCK
(since it means the lock is unnecessary), the obvious meaning of
MUST_NOT_HOLD_LOCK is the correct one, that the current thread/CPU does not
hold the lock.

In order to implement MOST_NOT_HOLD_LOCK the spinlock must contain some record
of who holds the lock, and since the SCSI-layer apparently does not have such
a mechanism, it appears that something is broken in there.

-josh



On Wed, Aug 07, 2002 at 04:37:40PM -0500, Oliver Xymoron wrote:
> On Wed, 7 Aug 2002, Jesse Barnes wrote:
> 
> > On Wed, Aug 07, 2002 at 06:02:19PM -0300, Rik van Riel wrote:
> > > On Wed, 7 Aug 2002, Jesse Barnes wrote:
> > >
> > > > +++ linux-2.5.30-lockassert/drivers/scsi/scsi.c Wed Aug  7 11:35:32 2002
> > > > @@ -262,7 +262,7 @@
> > >
> > > > +        MUST_NOT_HOLD(q->queue_lock);
> > >
> > > ...
> > >
> > > > +#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
> > > > +#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
> > > > +#define MUST_NOT_HOLD(lock)		BUG_ON(spin_is_locked(lock))
> > >
> > > Please tell me the MUST_NOT_HOLD thing is a joke.
> > >
> > > What is to prevent another CPU in another code path
> > > from holding this spinlock when the code you've
> > > inserted the MUST_NOT_HOLD in is on its merry way
> > > not holding the lock ?
> >
> > Nothing at all, but isn't that how the scsi ASSERT_LOCK(&lock, 0)
> > macro worked before?  I could just remove all those checks in the scsi
> > code I guess.
> 
> Who's to say that they actually worked? They look like crap to me.
> 
> > After I posted the last patch, a few people asked for MUST_NOT_HOLD so
> > I added it back in.  Do you think it's a bad idea?  See the last
> > thread if you're curious (Joshua's comments in particular):
> > http://marc.theaimsgroup.com/?t=102764009400001&r=1&w=2
> 
> Interesting. I'm still going to say that MUST_NOT_HOLD is wrong, at least
> in its current form/name.
> 
> What MUST_HOLD is saying is "the current thread is holding this lock, go
> ahead, double check if you want". What MUST_NOT_HOLD says is "the current
> thread is not holding this lock, feel free to check". Right now the kernel
> doesn't record who grabbed a lock and the best it can do is check whether
> _anyone_ is holding the lock. In the first case, it can prove a negative
> if no one is holding the lock, in the second case it can't because it
> can't distiguish between the current task holding a lock and any other
> task holding a lock.
> 
> If we want a MUST_NOT_RECURSE, we can do that, but it means adding cpu or
> current into the debugging version of spinlocks. I'd also add eip, so we
> can see where the lock was acquired last and dump that when we hit a
> conflict/deadlock.
> 
> And if you interpret MUST_NOT_HOLD_LOCK to mean "no one is holding this
> lock" then you run into Rik's problem. Anyone who actually means this
> ought to be simply taking the lock, otherwise why would they care?
> 
> -- 
>  "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
