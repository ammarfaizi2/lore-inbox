Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWEHHiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWEHHiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEHHiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:38:04 -0400
Received: from science.horizon.com ([192.35.100.1]:44089 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751182AbWEHHiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:38:03 -0400
Date: 8 May 2006 03:38:02 -0400
Message-ID: <20060508073802.636.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thing to do, on modern machines, is to stop relying on
external sources and start using the timer interrupt.

Since there is a gigahertz-rate clock available, the jitter between it
and another clock can be a fruitful source of entropy.  Frankly, I think
there's > 1 bit of entropy available per sample, but even at 0.01 bits
per sample (which is saying that it's exactly predictable at least 99.914%
of the time), that's still 128 bits of key in 13 seconds.

Even though both the processor clock and the timer clock are ultimately
derived from the same crystal, the phase-locked loops which do
the frequency multiplying have quite detectable noise.  And that's
ignoring the "spread-spectrum" frequency modulation that many modern PC
motherboards do.

In these days of wireless keyboards and mice, /dev/random's faith in
those sources is probably misplaced, but with much faster processor
clocks, a new, purely internal source becomes much more practical.

Machines without TSCs are still a challenge.  For PCs, I'd suggest using
the 32 kHz-crystal-driven RTC and beating that against the 2 MHz PIT.
On other platforms, I'm a little unclear.

If you want to test this, collect the appropriate data points on an
otherwise idle machine, with speread-spectrum clocking turned off in
the BIOS of possible, subtract the slope, and delete all the outlyers.
Then look at the scatter of the remaining data and subject it to various
randomness tests.  Note that if there is a PLL connecting the two
clocks, a sufficiently high-resolution slope measurement will reveal
the rational number ratio.


For those intersted, the entropy (in bits) of a based coin is related
to the chance of its landing heads (or tails) as follows:

Entropy	Probability
1	0.5
0.999	0.518614
0.99	0.558802
0.9	0.683981
0.8	0.756996
0.7	0.810702
0.6	0.853898
0.5	0.889972
0.4	0.920617
0.3	0.946761
0.2	0.968876
0.1	0.987013
0.09	0.988590
0.08	0.990119
0.07	0.991598
0.06	0.993024
0.05	0.994393
0.04	0.995699
0.03	0.996936
0.02	0.998090
0.01	0.999140
0.009	0.999237
0.008	0.999333
0.007	0.999427
0.006	0.999519
0.005	0.999608
0.004	0.999695
0.003	0.999779
0.002	0.999860
0.001	0.999935

If there are more secondary alternatives than just "tails", the
numbers - either the entropy for a certain probability of heads,
or the probability of heads to get a certain entropy - go up.



As for the discussion of hash functions "broken", /dev/random is very
conservative about its use of the hash function.

There are three major kinds of attacks against hash functions.
In increasing order of difficulty:
	1) Collision attack.  Find x and y such that H(x) == H(y)
	2) Second pre-image attack.  Given y, find x so H(x) == H(y).
	3) (First) pre-image attack.  Given y, find x so H(x) == y.

There is an obvious brute-force solution to a collision attack for
an n-bit hash in O(2^(n/2)) steps.  (Basically, compute the hashes of
2^(n/2) random strings; you will alsmost certainly find a collision.
There re clever ways to avoid storing 2^(n/2) input values.)

Generally, when collsions are easy to find in a hash function, it is
considered broken for practical purposes.  For example, if I know a
collision for two values x and y, suppose I give you $x in return for
a digitally signed negotiable instrument for $x.  Then I can change it
to read $y and present it for payment.  Assuming that x < y, this has
potential for profit.  (Reality is a bit more complicated, but hopefully
you get the idea.)

A pre-image attack, where there is a *single* hash value you want to
match, is far more difficult.  For example, even for the generally
laughable MD4, a second pre-image attack is only known for a class of
"weak" messages consituting 2^-122 of possible inputs.  (Xiaoyun Wang
et. al, "Cryptanalysis of the Hash Functions MD4 and RIPEMD", 2005)

To break /dev/urandom with cryptanalysis, the basic difficulty lies in
deducing the internal random pool state.  The pool is by default 1024
bits in size, but you only get 80 bits of hash function output at a time.
So the first thing you have to do is read at least as many bits from the
pool as there is entropy, and then solve a pre-image problem.  But not
just ANY pre-image will do; you have to find the one of the 2^1024 states
that simultaneously satisfies your a priori knowledge of the pool state
and the (possibly multiple) hash function pre-image conditions.  This is
vastly harder than a simple pre-image attack, which is much much harder
than a collision attack.

Even if the hash function is so thoroughly broken that it's are useless
for most purposes, it can still shield /dev/urandom's internal state.

It's a very conservative and robust design.
