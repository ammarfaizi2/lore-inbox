Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVDQAVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDQAVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 20:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVDQAVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 20:21:20 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:10762 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261216AbVDQAVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 20:21:11 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sun, 17 Apr 2005 00:19:11 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3sa1v$pck$1@abraham.cs.berkeley.edu>
References: <20050415170450.GB23277@certainkey.com> <20050416100555.25344.qmail@science.horizon.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113697151 26004 128.32.168.222 (17 Apr 2005 00:19:11 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sun, 17 Apr 2005 00:19:11 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux wrote:
>3) Fortuna's design doesn't actually *work*.  The authors' analysis
>   only works in the case that the entropy seeds are independent, but
>   forgot to state the assumption.  Some people reviewing the design
>   don't notice the omission.

Ok, now I understand your objection.  Yup, this is a real objection.
You are right to ask questions about whether this is a reasonable assumption.

I don't know whether /dev/random makes the same assumption.  I suspect that
its entropy estimator is making a similar assumption (not exactly the same
one), but I don't know for sure.

I also don't know whether this is a realistic assumption to make about
the physical sources we currently feed into /dev/random.  That would require
some analysis of the physics of those sources, and I don't have the skills
it would take to do that kind of analysis.

>   Again, suppose we have an entropy source that delivers one fresh
>   random bit each time it is sampled.
>
>   But suppose that rather than delivering a bare bit, it delivers the
>   running sum of the bits.  So adjacent samples are either the same or
>   differ by +1.  This seems to me an extremely plausible example.
>
>   Consider a Fortuna-like thing with two pools.  The first pool is seeded
>   with n, then the second with n+b0, then the first again with n+b0+b1.
>   n is the arbitrary starting count, while b0 and b1 are independent
>   random bits.
>
>   Assuming that an attacker can see the first pool, they can find n.
>   After the second step, their uncertainty about the second pool is 1
>   bit, the value of b0.
>
>   But the third step is interesting.  The attacker can see the value of
>   b0+b1.  If the sum is 0 or 2, the value of b0 is determined uniquely.
>   Only in the case that b0+b1 = 1 is there uncertainty.  So we have
>   only *half* a bit of uncertainty (one bit, half of the time) in the
>   second pool.
[..]
>   I probably just don't have enough mathematical background, but I don't
>   currently know how to bound this leakage.

Actually, this example scenario is not a problem.  I'll finish the
analysis for you.  Suppose that the adversary can observe the entire
evolution of the first pool (its initial value, and all updates to it).
Assume the adversary knows n.  In one round (i.e., a pair of updates),
the adversary learns the value of b0 + b1 (and nothing more!).  In the
next round, the adversary learns b0' + b1' -- and so on.

How many bits of uncertainty have been added to the second pool in
each round?  With probability 1/2, the uncertainty of the second pool
remains unchanged.  With probability 1/2, the uncertainty increases by
exactly 1 bit.  This means there are two classes of updates, and both
classes are equally likely.

Suppose we perform 200 rounds of updates.  Then we can expect about
100 of these updates to be of the second class.  If the updates were
split evently (50/50) between these two classes, the adversary would
have 100 bits of uncertainty about the second pool.  In general, we
expect somewhere near 100 bits of uncertainty -- sometimes a bit more,
sometimes a bit less, but the chances that it is a lot less than 100
bits of uncertainty are exponentially small.

Therefore, except for an event that occurs with exponentially small
probability, the adversary will be left with many bits of uncertainty
about the second pool.  So this kind of source should not pose a serious
problem for Fortuna, or for any two-pool solution.


If you want a better example of where the two-pool scheme completely
falls apart, consider this: our source picks a random bit, uses this
same bit the next two times it is queried, and then picks a new bit.
Its sequence of outputs will look like (b0,b0,b1,b1,b2,b2,..,).  If
we alternate pools, then the first pool sees the sequence b0,b1,b2,..
and the second pool sees exactly the same sequence.  Consequently, an
adversary who can observe the entire evolution of the first pool can
deduce everything there is to know about the second pool.  This just
illustrates that these multiple-pool solutions make some assumptions
about the time-independence of their sources, or at least that the bits
going into one pool don't have too much correlation with the bits going
into the other pool.
