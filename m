Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSHSJZJ>; Mon, 19 Aug 2002 05:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318213AbSHSJZJ>; Mon, 19 Aug 2002 05:25:09 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:38669 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318208AbSHSJZI>; Mon, 19 Aug 2002 05:25:08 -0400
Date: Mon, 19 Aug 2002 11:29:00 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem with random.c and PPC
In-Reply-To: <20020817072310.GQ5418@waste.org>
Message-ID: <Pine.LNX.4.44.0208191034390.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Oliver Xymoron wrote:

> > If you are in there fixing things, it might make sense to have
> > /dev/urandom extract entropy from the random pool far less often than
> > /dev/random.  This way people who use /dev/urandom for a source of
> > less-strong randomness (e.g. TCP sequence numbers or whatever), will
> > not be shooting themselves in the foot for when they need a 2048-byte
> > PGP key, if they are low on entropy sources.
> 
> Not sure this is an ideal fix. We might instead have an entropy
> low-water mark (say 1/2 pool size), below which /dev/urandom will not
> deplete the pool. This way when we have ample entropy, both devices
> will behave like TRNGs, with /dev/urandom falling back to PRNG when a
> shortage is threatened.

How can you make /dev/urandom return something without leaking
information about the internal pool state to the observer?
Do you plan to switch to a completely different source and reseed the
PRNG with data not taken from the pool?

I don't understand what you mean with the "1/2 pool size": the pool 
size is always the same (once you set sys.kernel.random.poolsize),
it's just that the pool is somewhat known to the external observer.
The random bits you return to userspace either are related to the
internal pool (and thus leak knowledge about it) or not. Tertium non
datur. Or am I missing something?

I believe your 1/2 idea it's better implemented having two different
(and separated) pools: you can make /dev/urandom drain one but not the
other. /dev/random can drain one or both, it's just an implementation
choice.

In my experience, there's little you can do when the entropy demand is
higher than the rate at which the kernel collects it. Either we implement
/dev/random quotas, or it will be always easy to drain the internal pool
from userspace.
I'd say that /dev/urandom interface is somewhat broken: the application
either can live with an almost pure PRNG (and use an userspace
implementation) or needs true, pure and strong randomness. The programmer
should know the mimimal need for true randomness of the application.
For every application that uses /dev/urandom, it's 0 by definition of
/dev/urandom, and the application should just use an userspace PRNG.
If you need a weak solution (a perturbated PRNG), just read a few bits
from /dev/random at times (but in a controlled and defined way).
IMHO, the whole urandom thing should be extended and put into a
userspace library.

.TM.


