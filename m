Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSHRCL1>; Sat, 17 Aug 2002 22:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSHRCL0>; Sat, 17 Aug 2002 22:11:26 -0400
Received: from waste.org ([209.173.204.2]:58835 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318792AbSHRCLY>;
	Sat, 17 Aug 2002 22:11:24 -0400
Date: Sat, 17 Aug 2002 21:15:22 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818021522.GA21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done an analysis of entropy collection and accounting in current
Linux kernels and founds some major weaknesses and bugs. As entropy
accounting is only one part of the security of the random number
device, it's unlikely that these flaws are compromisable, nonetheless
it makes sense to fix them.

- Broken analysis of entropy distribution
- Spoofable delta model
- Interrupt timing independence
- Ignoring time scale of entropy sources
- Confusion of unpredictable and merely complex sources and trusting the
  latter
- Broken pool transfers
- Entropy pool can be overrun with untrusted data

Net effect: a typical box will claim to generate 2-5 _orders of magnitude_
more entropy than it actually does. 

Note that entropy accounting is mostly useful for things like the
generation of large public key pairs where the number of bits of
entropy in the key is comparable to the size of the PRNG's internal
state. For most purposes, /dev/urandom is still more than strong
enough to make attacking a cipher directly more productive than
attacking the PRNG.

The following patches against 2.5.31 have been tested on x86, but
should compile elsewhere just fine.

I've tried to cover some of the issues in detail below:

Broken analysis of entropy distribution 
---------------------------------------

(I know the topic of entropy is rather poorly understood, so here's a couple
 useful pieces of background for kernel folks:

 Cryptanalytic Attacks on Pseudorandom Number Generators
 Kelsey, Schneier, Wagner, Hall
 www.counterpane.com/pseudorandom_number.pdf 

 Cryptographic Randomness from Air Turbulence in Disk Drives
 D. Davis, R. Ihaka, P.R. Fenstermacher
 http://world.std.com/~dtd/random/forward.ps)

Mathematically defining entropy

 For a probability distribution P of samples K, the entropy is:

  E = sum (-P(K) * log2 P(K))

 For a uniform distribution of n bits of data, the entropy is
 n. Anything other than a uniform distribution has less than n bits of
 entropy.

Non-Uniform Distribution Of Timing

 Unfortunately, our sample source is far from uniform. For starters, each
 interrupt has a finite time associated with it - the interrupt latency.
 Back to back interrupts will result in samples that are periodically
 spaced by a fixed interval.

 A priori, we might expect a typical interrupt to be a Poisson
 process, resulting in a gamma-like distribution. It would also have
 zero probability up to some minimum latency, have a peak at minimum
 latency representing the likelihood of back-to-back interrupts, a
 smooth hump around the average interrupt rate, and an infinite tail.

 Not surprisingly, this distribution has less entropy in it than a
 uniform distribution would. Linux takes the approach of assuming the
 distribution is "scale invariant" (which is true for exponential
 distributions and approximately true for the tails of gamma
 distributions) and that the amount of entropy in a sample is in
 relation to the number of bits in a given interrupt delta. 

 Assuming the interrupt actually has a nice gamma-like distribution
 (which is unlikely in practice), then this is indeed true. The
 trouble is that Linux assumes that if a delta is 13 bits, it contains
 12 bits of actual entropy. A moment of thought will reveal that
 binary numbers of the form 1xxxx can contain at most 4 bits of
 entropy - it's a tautology that all binary numbers start with 1 when
 you take off the leading zeros. This is actually a degenerate case of
 Benford's Law (http://mathworld.wolfram.com/BenfordsLaw.html), which
 governs the distribution of leading digits in scale invariant
 distributions.

 What we're concerned with is the entropy contained in digits
 following the leading 1, which we can derive with a simple extension
 of Benford's Law (and some Python):

    def entropy(l):
	s=0
	for pk in l:
	    if pk: s=s+(-pk*log2(pk))
	return s

    def benford(digit, place=0, base=10):
	if not place:
	    s=log(1+1.0/digit)
	else:
	    s=0
	    for k in range(base**(place-1), (base**place)):
		s=s+log(1+1.0/(k*base+digit))
		print k,s

	return s/log(base)

    for b in range(3,16):
	l=[]
	for k in range(1,(2**(b-1))-1):
	    l.append(benford(k,0,2**(b-1)))
	print "%2d %6f" % (b, entropy(l))

 Which gives us:
 
     3 1.018740
     4 2.314716
     5 3.354736
     6 4.238990
     7 5.032280
     8 5.769212
     9 6.468756
    10 7.141877
    11 7.795288
    12 8.433345
    13 9.059028
    14 9.674477
    15 10.281286
    
 As it turns out, our 13-bit number has at most 9 bits of entropy, and
 as we'll see in a bit, probably significantly less.

 All that said, this is easily dealt with by lookup table.

Interrupt Timing Independence
-----------------------------

 Linux entropy estimate also wrongly assumes independence of different
 interrupt sources. While SMP complicates the matter, this is
 generally not the case. Low-priority interrupts must wait on high
 priority ones and back to back interrupts on shared lines will
 serialize themselves ABABABAB. Further system-wide CLI, cache flushes
 and the like will skew -all- the timings and cause them to bunch up
 in predictable fashion.

 Furthermore, all this is observable from userspace in the same way
 that worst-case latency is measured. 

 To protect against back to back measurements and userspace
 observation, we insist that at least one context switch has occurred
 since we last sampled before we trust a sample.
 
Questionable Sources and Time Scales
------------------------------------

 Due to the vagarities of computer architecture, things like keyboard
 and mouse interrupts occur on their respective scanning or serial
 clock edges, and are clocked relatively slowly. Worse, devices like
 USB keyboards, mice, and disks tend to share interrupts and probably
 line up on USB clock boundaries. Even PCI interrupts have a
 granularity on the order of 33MHz (or worse, depending on the
 particular adapter), which when timed by a fast processor's 2GHz
 clock, make the low six bits of timing measurement predictable.

 And as far as I can find, no one's tried to make a good model or
 estimate of actual keyboard or mouse entropy. Randomness caused by
 disk drive platter turbulence has actually been measured and is on
 the order of 100bits/minute and is well correlated on timescales of
 seconds - we're likely way overestimating it. 

 We can deal with this by having each trusted source declare its clock
 resolution and removing extra timing resolution bits when we make samples.

Trusting Predictable or Measurable Sources
------------------------------------------

 What entropy can be measured from disk timings are very often leaked
 by immediately relaying data to web, shell, or X clients.  Further,
 patterns of drive head movement can be remotely controlled by clients
 talking to file and web servers. Thus, while disk timing might be an
 attractive source of entropy, it can't be used in a typical server
 environment without great caution.

 Complexity of analyzing timing sources should not be confused with
 unpredictability. Disk caching has no entropy, disk head movement has
 entropy only to the extent that it creates turbulence. Network
 traffic is potentially completely observable.

 (Incidentally, tricks like Matt Blaze's truerand clock drift
 technique probably don't work on most PCs these days as the
 "realtime" clock source is often derived directly from the
 bus/PCI/memory/CPU clock.)

 If we're careful, we can still use these timings to seed our RNG, as
 long as we don't account them as entropy.

Batching
--------

 Samples to be mixed are batched into a 256 element ring
 buffer. Because this ring isn't allowed to wrap, it's dangerous to
 store untrusted samples as they might flood out trusted ones.

 We can allow untrusted data to be safely added to the pool by XORing
 new samples in rather than copying and allowing the pool to wrap
 around. As non-random data won't be correlated with random data, this
 mixing won't destroy any entropy.

Broken Pool Transfers
---------------------

 Worst of all, the accounting of entropy transfers between the
 primary and secondary pools has been broken for quite some time and
 produces thousands of bits of entropy out of thin air. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
