Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSHTI4F>; Tue, 20 Aug 2002 04:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSHTI4E>; Tue, 20 Aug 2002 04:56:04 -0400
Received: from ws-002.ray.fi ([193.64.14.2]:64377 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S316610AbSHTI4D>;
	Tue, 20 Aug 2002 04:56:03 -0400
Date: Tue, 20 Aug 2002 11:59:49 +0300 (EEST)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: kynde@behemoth.ts.ray.fi
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020819135222.GB14427@waste.org>
Message-ID: <Pine.LNX.4.44.0208201134570.3350-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Oliver Xymoron wrote:
> On Mon, Aug 19, 2002 at 01:43:59AM -0400, Theodore Ts'o wrote:
> > On Sat, Aug 17, 2002 at 09:15:22PM -0500, Oliver Xymoron wrote:
> >
> > >  Assuming the interrupt actually has a nice gamma-like distribution
> > >  (which is unlikely in practice), then this is indeed true. The
> > >  trouble is that Linux assumes that if a delta is 13 bits, it contains
> > >  12 bits of actual entropy. A moment of thought will reveal that
> > >  binary numbers of the form 1xxxx can contain at most 4 bits of
> > >  entropy - it's a tautology that all binary numbers start with 1 when
> > >  you take off the leading zeros. This is actually a degenerate case of
> > >  Benford's Law (http://mathworld.wolfram.com/BenfordsLaw.html), which
> > >  governs the distribution of leading digits in scale invariant
> > >  distributions.
> > > 
> > >  What we're concerned with is the entropy contained in digits
> > >  following the leading 1, which we can derive with a simple extension
> > >  of Benford's Law (and some Python):
> > 
> > I'm not a statistician, and my last probability class was over 15
> > years ago, but I don't buy your extension of Benford's law.  Sure, if
> > we take street addresses numbering from 1 to 10000, the probability
> > that the leading digit will be 1 will be roughly 30%.  But the
> > distribution of the low two digits will be quite evenly distributed.
> > Put another way, by picking a house at random, and looking at the low
> > two digits, and can very fairly choose a number between 0 and 99.  
> 
> That's correct, and that's what's being calculated. The example Python
> code calculates the Benford distribution not in base 2, but in base
> 2^bits. Then it uses the Shannon entropy definition to calculate the
> overall entropy of that distribution. For a 12 bit number, we've got
> about 7 bits of entropy, most of it concentrated in the LSBs.

I think you have it slightly wrong there. By snipping away the first digit 
from a number leaves you with, not Benford's distribution, but 
uniform distribution, for which the Shannon entropy is naturally roughly
the bitcount.

Benford's distribution as presented (1 being the first digit 30% of the 
time) concerns firstly base 10 and secondly randomly upper bound sets.
For base 2 the Benford's leading digit distribution naturally narrows down 
to 1 being the first digit 100% of the time. Benford's law says little 
about the remaining digits. Thus by snipping that first bit away leaves us 
with a set that reflects the properties of the choice. Assuming it's 
random, we get uniform distribution.

Wether the bit count of the smallest of the three deltas is
actually sufficient to guarantee us that amount of randomness in the 
choice is another question. Like stated here already, it can be easily 
fooled, and there's a strong possibility that it gets "fooled" already.

Clearly periodic but not delta-wise detectable sequences would pass the 
delta checks. If interrupts get timed like, 1 3 11 50 1 3 11 50 1 3 11 50,
the deltas would indicate more entropy than there's present.

Some level of fourier analysis would be necessary to go further than what 
we can with the deltas.

(For the record, I'm not one bit worried about the kernel rng, perhaps 
the entropy bit count may be theoretically a bit off from time to time, but 
remarks like "If someone then breaks SHA-1, he can do this and that..."
only amuze me. If someone breaks SHA-1 we're bound to change the hash 
then, eh? Not mention that we'd be in deep shit not just kernelwise.)

-- 
Tommi Kynde Kyntola		kynde@ts.ray.fi
      "A man alone in the forest talking to himself and
       no women around to hear him. Is he still wrong?"

