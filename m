Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSHQQwn>; Sat, 17 Aug 2002 12:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSHQQwn>; Sat, 17 Aug 2002 12:52:43 -0400
Received: from waste.org ([209.173.204.2]:20155 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317365AbSHQQwm>;
	Sat, 17 Aug 2002 12:52:42 -0400
Date: Sat, 17 Aug 2002 11:56:40 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817165640.GB21829@waste.org>
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <200208161751.35895.henrique@cyclades.com> <20020817004520.GN5418@waste.org> <20020817060507.GM9642@clusterfs.com> <20020817072310.GQ5418@waste.org> <20020817090950.GN9642@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020817090950.GN9642@clusterfs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 03:09:50AM -0600, Andreas Dilger wrote:
> > 
> > Not sure this is an ideal fix. We might instead have an entropy
> > low-water mark (say 1/2 pool size), below which /dev/urandom will not
> > deplete the pool. This way when we have ample entropy, both devices
> > will behave like TRNGs, with /dev/urandom falling back to PRNG when a
> > shortage is threatened.
> 
> Well, I can think of a few mechanisms that would work better than a
> simple on/off method that you are proposing.  The current code will
> basically "fill" the urandom pool each time it is depleted, and then
> when the entropy is gone it will just go on dumping out data.  You
> could make urandom only get more entropy each N times through its pool,
> or make N a function of the "fullness" of the available entropy.  Then
> if a system has lots of entropy sources urandom is TRNG, but if not
> it will gracefully degrade from TRNG to PRNG without wiping out all
> the entropy in the process.
> 
> As an alternative, instead of taking poolsize bytes of entropy each
> N uses, you could take some small amount of entropy to mix into the
> pool slowly.

Actually, that gives us exactly the scenario catastrophic reseeding
intends to avoid. Presume for a moment that the internal state of the
PRNG is somehow known to an attacker - the PRNG has been broken. If we
take eight bits out of the entropy pool, mix them in, then generate a
new random number, an attacker needs to only test 256 possible pool
states before he knows the entire state again. If he keeps up this
state extension attack, /dev/urandom will never return to an unknown
state. If, on the other hand, /dev/urandom waits until there are, say,
64 entropy bits to mix in, it can make a leap to a state that the
attacker will have a very hard time guessing and the PRNG has
recovered.

We merely need to avoid starvation of /dev/random, and I think a
straightforward low watermark approach will do that nicely. Starving
/dev/urandom is no worse than feeding it a trickle. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
