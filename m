Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSHRRO4>; Sun, 18 Aug 2002 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSHRRO4>; Sun, 18 Aug 2002 13:14:56 -0400
Received: from waste.org ([209.173.204.2]:1695 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315388AbSHRRO4>;
	Sun, 18 Aug 2002 13:14:56 -0400
Date: Sun, 18 Aug 2002 12:18:31 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818171831.GT21643@waste.org>
References: <20020818021522.GA21643@waste.org> <Pine.LNX.4.44.0208172001530.1491-100000@home.transmeta.com> <20020818042818.GG21643@waste.org> <1029689668.903.19.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029689668.903.19.camel@phantasy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 12:54:27PM -0400, Robert Love wrote:
> On Sun, 2002-08-18 at 00:28, Oliver Xymoron wrote:
> 
> > Now there's currently an orthogonal problem that /dev/urandom can
> > deplete /dev/random's entropy pool entirely and things like generating
> > sequence numbers get in the way. I intend to fix that separately. 
> 
> Curious, how do you intend on doing this?
> 
> The reason /dev/urandom depletes /dev/random (it actually just lowers
> the entropy estimate) is due to the assumption that knowledge of the
> state is now known, so the estimate of how random (actually, we mean
> non-deterministic here) needs to decrease...

Indeed. However, we have to be careful about how we do this. See
Schneier, et al's paper on catastrophic reseeding. It's better to
batch up entropy transfers rather than trickle it in.
 
> Are you thinking of (semi) decoupling the two pools?

I'm thinking of changing urandom read to avoid pulling entropy from
the primary pool (via xfer) if it falls below a given low
watermark. The important part is to prevent starvation of
/dev/random, it doesn't have to be fair.

> I sort of agree with you that we should make random "stricter" and push
> some of the sillier uses onto urandom... but only to a degree or else
> /dev/random grows worthless.  Right now, on my workstation with plenty
> of user input and my netdev-random patches, I have plenty of entropy and
> can safely use random for everything... and I like that.

My patches should provide sufficient entropy for any workstation use
with or without network sampling. It's only the headless case that's
problematic - see my compromise patch with trust_pct.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
