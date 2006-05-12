Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWELGKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWELGKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWELGJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:09:50 -0400
Received: from science.horizon.com ([192.35.100.1]:38463 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750980AbWELGJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:09:48 -0400
Date: 12 May 2006 02:09:46 -0400
Message-ID: <20060512060946.5412.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Cc: linux@horizon.com
In-Reply-To: <20060508073802.636.qmail@science.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eek!  I just realized that my earlier posting about the entropy from
biased coin flips was wrong.  More dangerous than obviously wrong, it
was subtly wrong.

The table I posted was based on the common Shannon entropy measure.
However, it is well known in the theory of "randomness extractors" that
Shannon entropy is not the appropriate measure to use when judging an
entropy source which you are going to derive key material from; you need
to use the more conservative min-entropy.

For a reminder, if your random variable has a number of possible states
1..n, with corresponding probabilities p[1]..p[n], then the Shannon entropy
of this variable is

	sum -p[i] * log(p[i]), for i = 1..n

while the min-entropy is simply

	min -log(p[i]), for i = 1..n

(For entropy in bits, we will use the base-2 logarithm.)
These are identical if all the p[i] are equal, but the min-entropy is
lower in all other cases.


The classic example of a bad source with good Shannon entropy is a 256-bit
key that has 255 bits of randomness half the time, but has a single fixed
value the other half of the time.  If you plug this distribution into
the Shannon entropy formula, you get 128.5 bits of entropy.  That should
be enough to keep out an attacker, right?

Well, except for the half of the time when you're using the single
fixed value!  The problem is that the fact that you have much more than
the required 128 bits half of the time doesn't make up for the drastic
loss the other half of the time.


For an entropy-accumulation example, suppose you have a source which
produces 31 truly random bits (0..07fffffff) half of the time, and
a fixed value of -1 the other half of the time.  Again, the Shannon
entropy of this source is easily computed as 16.5 bits per sample.

Just to work through the math for the Shannon entropy,
we have p[-1] = 1/2, and p[0] = p[1] = ... = p[0x7fffffff] = 2^-32.

	sum -p[i] * log(p[i]),			for i = -1..0x7fffffff
=	(-(1/2) * log(1/2) ) +			The i = -1 case
	sum -(2^-32) * log(2^-32),		for i = 0..0x7fffffff
= 	-1/2 * -1  +  2^31 * -(2^-32 * -32)
=	1/2 + 1/2 * 32
=	1/2 + 16
=	16.5

So taking 8 such samples should produce 132 bits of entropy, which
can be hashed into a good 128-bit key, right?

Well, except for the 1/256 of the time when the key is the
hash of 8 copies of -1.  And an additional 8/256 = 1/32 of the time,
the key has 34 bits of entropy.  (31 bits in one of the 8 seeds,
plus 3 bits of uncertainty as to which seed.)

Again, even though on average the input has more than 128 bits of entropy,
the hashing throws away the excess, while the naive Shannon estimate
averages that wasted excess with the cases that are severly lacking.


Unsing the min-entropy estimate, the source has 1 bit if min-entropy,
so 8 samples have 8 bits of min-entropy, and a good hash won't change
that much.  (It can't make it better, and collisions will make it slightly
worse.)  The highest-probability key will occur 2^-8 = 1/256 of the time.


In particular, the table of the probabilities needed to achieve
a particular entropy should be amended as follows:

Entropy	     Probability		min-entropy of
(bits)	Shannon		min		Shannon prob
1	0.5		0.5		1
0.999	0.518614        0.500347	0.947267
0.99	0.558802        0.503478        0.839591
0.9	0.683981        0.535887        0.547972
0.8	0.756996        0.574349        0.401642
0.7	0.810702        0.615572        0.302756
0.6	0.853898        0.659754        0.227864
0.5	0.889972        0.707107        0.168168
0.4	0.920617        0.757858        0.119327
0.3	0.946761        0.812252        0.078928
0.2	0.968876        0.870551        0.045616
0.1	0.987013        0.933033        0.018859
0.09	0.988590        0.939523        0.016556
0.08	0.990119        0.946058        0.014326
0.07	0.991598        0.952638        0.012173
0.06	0.993024        0.959264        0.010100
0.05	0.994393        0.965936        0.008112
0.04	0.995699        0.972655        0.006218
0.03	0.996936        0.979420        0.004427
0.02	0.998090        0.986233        0.002758
0.01	0.999140        0.993092        0.001241
0.009	0.999237        0.993781        0.001101
0.008	0.999333        0.994470        0.000963
0.007	0.999427        0.995160        0.000827
0.006	0.999519        0.995850        0.000694
0.005	0.999608        0.996540        0.000566
0.004	0.999695        0.997231        0.000440
0.003	0.999779        0.997923        0.000319
0.002	0.999860        0.998615        0.000202
0.001	0.999935        0.999307        0.000094
	(WRONG)		(RIGHT)		(RIGHT entropy of WRONG probability)

You need a most-likely probability less than the "min probability" column
to achieve the min-entropy given in the first column.  The fourth column
gives the actual min-entropy you'd get if you used the Shannon-derived
probability.  Note that it's off by a factor of >10 near the bottom of
the list.  (1-p = e*ln(2) is a very close approximation when e is
much less than 1.)

Also, unlike the Shannon entropy, the number and probabilities of
less-likely alternatives do not matter.  This actually makes analysis of
interrupt timing easier, because you don't have to worry about outliers.
Just see how often you can predict the EXACT timestamp of an interrupt
and ignore the rest.

(This in turn leads to the possibility of real-time entropy measurement
of timer interrupts.  Assuming both are derived from a common crystal
via PLLs, the slope of the interrupt number vs. timestamp should be a
simple exact rational number.  You can build a histogram of the measured
timestamps around the predicted slope, discarding outliers, and use the
maximum value to compute the min-entropy.  To be conservative, take the
sum of the largest two in case the wiggle between them is modelable.)
