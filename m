Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318899AbSHSN6S>; Mon, 19 Aug 2002 09:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSHSN6S>; Mon, 19 Aug 2002 09:58:18 -0400
Received: from waste.org ([209.173.204.2]:46572 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318899AbSHSN6Q>;
	Mon, 19 Aug 2002 09:58:16 -0400
Date: Mon, 19 Aug 2002 09:02:07 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Marco Colombo <marco@esi.it>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020819140207.GC14427@waste.org>
References: <20020817072310.GQ5418@waste.org> <Pine.LNX.4.44.0208191034390.26653-100000@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208191034390.26653-100000@Megathlon.ESI>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 11:29:00AM +0200, Marco Colombo wrote:
> On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> 
> > > If you are in there fixing things, it might make sense to have
> > > /dev/urandom extract entropy from the random pool far less often than
> > > /dev/random.  This way people who use /dev/urandom for a source of
> > > less-strong randomness (e.g. TCP sequence numbers or whatever), will
> > > not be shooting themselves in the foot for when they need a 2048-byte
> > > PGP key, if they are low on entropy sources.
> > 
> > Not sure this is an ideal fix. We might instead have an entropy
> > low-water mark (say 1/2 pool size), below which /dev/urandom will not
> > deplete the pool. This way when we have ample entropy, both devices
> > will behave like TRNGs, with /dev/urandom falling back to PRNG when a
> > shortage is threatened.
> 
> How can you make /dev/urandom return something without leaking
> information about the internal pool state to the observer?
> Do you plan to switch to a completely different source and reseed the
> PRNG with data not taken from the pool?

I plan to make a third pool, reseeding from the first. The code
appears to actually be structured with that in mind, it just hasn't
been done.

> In my experience, there's little you can do when the entropy demand is
> higher than the rate at which the kernel collects it. Either we implement
> /dev/random quotas, or it will be always easy to drain the internal pool
> from userspace.

Root can decide, for instance, to make /dev/random privileged to some
group if important_set is getting starved by unimportant_set.

> I'd say that /dev/urandom interface is somewhat broken: the application
> either can live with an almost pure PRNG (and use an userspace
> implementation) or needs true, pure and strong randomness. The programmer
> should know the mimimal need for true randomness of the application.
> For every application that uses /dev/urandom, it's 0 by definition of
> /dev/urandom, and the application should just use an userspace PRNG.

Many actually do this. I believe OpenSSL merely seeds though I'd have
to doublecheck.  

> If you need a weak solution (a perturbated PRNG), just read a few bits
> from /dev/random at times (but in a controlled and defined way).

It might be helpful to think of /dev/urandom as akin to /dev/random with
O_NONBLOCK. "Give me stronger bits if you got 'em" is desirable,
otherwise this thread would be much shorter.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
