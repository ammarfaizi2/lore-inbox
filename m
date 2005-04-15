Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVDOAzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVDOAzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDOAx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:53:56 -0400
Received: from science.horizon.com ([192.35.100.1]:4402 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261693AbVDOAwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:52:16 -0400
Date: 15 Apr 2005 00:52:09 -0000
Message-ID: <20050415005209.1698.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: Fortuna
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, mpm@selenic.com,
       tytso@mit.edu
In-Reply-To: <20050414145204.GI12263@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Waiting for 256bits of entropy before outputting data is a good goal.
> Problem becomes how do you measure entropy in a reliable way?  This had
> me lynched last time I asked it so I'll stop right there.

It's a problem.  Also, with the current increase in wireless keyboards
and mice, that source should possibly not be considered secure any more.

On the other hand, clock jitter in GHz clocks is a *very* rich source
of seed material.  One rdtsc per timer tick, even accounted for at
0.1 bit per rdtsc (I think reality is more like 3-5 bits) would keep
you in clover.

> I'll not make any claim that random-fortuna.c should be mv'd to random.c, the
> patch given allows people to kernel config it in under the Cryptographic
> Options menu.  Perhaps a disclaimer in the help menu would be in order to
> inform users that Fortuna has profound consequences for those expecting
> Info-theoretic /dev/random?

I don't mean to disparage you efforts, but then what's the upside to
the resultant code maintenance hassles?  Other than hack value, what's the
advantage of even offering the choice?  An option like that is justified
when the two options have value for different people and it's not
possible to build a single merged solutions that satisfies both markets.

Also, Ted very deliberately made /dev/random non-optional so it could
be relied on without a lot of annoying run-time testing.  Would
a separate /dev/fortuna be better?



> The case where an attacker has some small amount of unknown in the pool is a
> problem that effects BOTH random-fortuna.c and random.c (and any other
> replacement for that matter).  Just an FYI.

Yes, but entropy estimation is supposed to deal with that.  If the
attacker is never allowed enough information out of the pool to
distinguish various input states, the output is secure.

> As for the "shifting property" problem of an attacker controlling some input
> to the pooling system, I've tried to get around this:

(Code that varies the pool things get added to based on r->key[i++ & 7])

> The add_entropy_words() function uses the first 8 bytes of the central
> pool to aggravate the predictability of where entropy goes.  It's still a
> linear progression untill the central pool is re-keyed, then you don't know
> where it went.  The central pool is reseeded every 0.1ms.

You need to think more carefully.  You're just elaborating it without
adding security.  Yes, the attacker *does* know!  The entire underlying
assumption is that the attacker knows the entire initial state of the
pool, owing to some compromise or another.

The assumption is that the only thing the attacker doesn't know is the
exact value of the incoming seed material.  (But the attacker does have
an excellent model of its distribution.)

Given that, the attacker knows the initial value of the key[] array,
and thus knows the order in which the pools are fed.  The question
then arises, come next reseed, can the attacker (with a small mountain
of computers, able to brute-force 40-bit problems in the blink of an
eye) infer the *complete* state of the pool from the output.

The confusion is over the word "random".  In programming jargon, the
word is most often used to mean "arbitrary" or "the choice doesn't
matter".  But that doesn't capture the idea of "unpredictable to
a skilled and determined opponent" that is needed in /dev/random.

So while the contents of key[] may be "random-looking", they're not
*unpredictable*, any more than the digits of pi are.

The attacker just has to, after each reseeding, brute-force the seed
bits fed to the (predictable) pools chosen to mix in, and then
use that information to infer the seeds added to the not-selected
pools.

If the attacker's uncertainty about the state of some of the subpools
increases to the catastrophic reseeding level, then the Fortuna design
goal is achieved.

If the seed samples are independent, then it's easy to see that the
schedule works.

But if the seed samples are correlated, it gets a lot trickier.
