Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSHTRSO>; Tue, 20 Aug 2002 13:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSHTRSO>; Tue, 20 Aug 2002 13:18:14 -0400
Received: from waste.org ([209.173.204.2]:52183 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317182AbSHTRSN>;
	Tue, 20 Aug 2002 13:18:13 -0400
Date: Tue, 20 Aug 2002 12:22:16 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Tommi Kyntola <kynde@ts.ray.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020820172215.GE19225@waste.org>
References: <20020820132123.GB19225@waste.org> <Pine.LNX.4.44.0208201740480.3601-100000@behemoth.ts.ray.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208201740480.3601-100000@behemoth.ts.ray.fi>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 07:19:26PM +0300, Tommi Kyntola wrote:
> On Tue, 20 Aug 2002, Oliver Xymoron wrote:
> > On Tue, Aug 20, 2002 at 11:59:49AM +0300, Tommi Kyntola wrote:
> > > On Mon, 19 Aug 2002, Oliver Xymoron wrote:
> > > > On Mon, Aug 19, 2002 at 01:43:59AM -0400, Theodore Ts'o wrote:
> > > > > On Sat, Aug 17, 2002 at 09:15:22PM -0500, Oliver Xymoron wrote:
> > > > >
> > > > > >  Assuming the interrupt actually has a nice gamma-like distribution
> > > > > >  (which is unlikely in practice), then this is indeed true. The
> > > > > >  trouble is that Linux assumes that if a delta is 13 bits, it contains
> > > > > >  12 bits of actual entropy. A moment of thought will reveal that
> > > > > >  binary numbers of the form 1xxxx can contain at most 4 bits of
> > > > > >  entropy - it's a tautology that all binary numbers start with 1 when
> > > > > >  you take off the leading zeros. This is actually a degenerate case of
> > > > > >  Benford's Law (http://mathworld.wolfram.com/BenfordsLaw.html), which
> > > > > >  governs the distribution of leading digits in scale invariant
> > > > > >  distributions.
> > > > > > 
> > > > > >  What we're concerned with is the entropy contained in digits
> > > > > >  following the leading 1, which we can derive with a simple extension
> > > > > >  of Benford's Law (and some Python):
> > 
> > > I think you have it slightly wrong there. By snipping away the first digit 
> > > from a number leaves you with, not Benford's distribution, but 
> > > uniform distribution, for which the Shannon entropy is naturally roughly
> > > the bitcount.
> > 
> > No, it's much more complicated than that - that doesn't give us scale
> > invariance. Observe that the distribution of the first and second
> > digits in base n is the same as the distribution of the first digit in
> > base n*2. The probability of finding a 0 as the second digit
> > base 10 is simply the sum of the probabilities of finding 10, 20,
> > 30,..90 as the first digit, base 100, see? It's .1197, rather than the
> > expected .1. In base 2, the odds of the second digit being 0 is .58.
> 
> Oh now I see, you're relying on the given times to be gamma distributed 
> (1/x, and thus naturally scale invariant). I was constantly thinking about 
> the jiffie count that got masked that I took as uniform, but naturally 
> within the delta context it's not uniform, since the first order delta 
> naturally defines the timestamp when the previous timestamp is known.
> And thus yes, you are indeed right. Furthermore it wouldn't even have to 
> be gamma and as such scale invariant. Even mere nonuniformness (which I'm 
> sure the timings are) guarantees that mere first bit snipping is not 
> enough to ensure entropy inside that full range.
> 
> The current the delta bitcount - 1 is not the correct entropy amount in 
> any said gamma (or likes) distributed number. Does strict gamma assumption 
> really lead to so strict figures as you showed in your patch :
> static int benford[16]={0,0,0,1,2,3,4,5,5,6,7,7,8,9,9,10};
> 
> Numbers below 0..7, don't have a single bit of entropy?

They have fractional bits of entropy.
 
> I'm more inclined to think that where as this may be sound for the larger 
> delta bit counts, I don't think it applies that well for the smaller 
> deltas. It's unlikely that the timing distributions stay scale invariant
> for the lower end bits.

Possibly. If anything, I'd expect them to get worse, not better, more
strongly displaying quantization due to cache flushes or the like.
 
> Not mention that if the actual time separation is something like 12 bits,
> but the second order delta drops the entropy bit count down to 4, 
> couldn't those four be considered uniformly distributed, atleast roughly 
> enough, so that the benford array reduction could be skipped.

Actually, no. Scale invariant means we expect to see the same sorts of
numbers regardless of the units we use. Differences of such numbers
won't magically become associated with a particular unit and should
still match up with the so-called 'distribution of distributions'.

> Although Linus was not so hot about your "draconian measures" patch set
> this part of it would atleast seem worth the while. Atleast when the 
> limiting delta is the first order, it is indeed unreasonable to think 
> that it's bit count - 1 would show the entropy that's present.

I've got another spin that I'll send him after he's kicked out .32
that he'll probably find acceptable. Gives headless folks the rope to
hang themselves with.

Ooh, that's clever. I'll have to stick that in the comments somewhere.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
