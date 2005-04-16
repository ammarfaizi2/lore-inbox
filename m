Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVDPRQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVDPRQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVDPRQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 13:16:45 -0400
Received: from science.horizon.com ([192.35.100.1]:48 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262705AbVDPRQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 13:16:22 -0400
Date: 16 Apr 2005 17:16:22 -0000
Message-ID: <20050416171622.12751.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com, linux@horizon.com
Subject: Re: Fortuna
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
In-Reply-To: <20050416154625.GD17029@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes I saw that the first time, just struck me as "why?  why did I have to sit
> here and add a that to the litany of things to remember when it's so easy to
> just do it right?"

Huh?  Why?  Because it's faster and less code, that's why.
In what conceivable way is it NOT right?

On little-endian machines, we define the mixing function to the
the bit-reversed hash of the bit-reversed pool.  We could just as
easily store the entire pool bit-reversed and bit-reverse the inputs
before mising them in, and use stock SHA1.

Since we don't need to interoperate with anybody, details like
bit-ordering conventions are at the implementor's convenience.

The entire transformation has zero cryptological impact, so do it with
less code.  You don't *have* to remember it, any more than you have to
remember whether I incremented the loop counter with i++, ++i, i += 1,
or i = i+1.  It's SHA-1, and all the security properties still apply.

> Guess I just see a different approach to software engineering, making it
> easier to analyse makes it easier to improve.  You're 100% correct - security
> wise it doesn't matter.

I don't even see how it's any harder to analyze.  Any more than it
matters for most algorithm analysis whether the numbers are stored in
binary or decimal, or whether the loop counter is called i or j.

> I agree with the statement:
>  "If the current entropy estimation does not over estimate and crypto
>   primitives don't fail to leak information, then we're OK"

Er.. "if the crypto primitives don't fail TO leak information"?
I'm not quite sure I follow...

>> 2) Fortuna tries to support such a wide range of entropy source rates,
>>    down to very low rates, that it sequesters some entropy for literally
>>    years.  Ted thinks that's inexcusable, and I can't really disagree.
>>    This can be fixed to a significant degree by tweaking the number
>>    of subpools.

> Well, I'd take hording entropy for 7 years over trusting a general entropy
> accounting heuristic that is impossible to determine proper functioning.
> Assuming again that the problems of malicious entropy event injection is
> overcome.  Havn't come up with anything yet on how to do this nicely.

The problem is that it's spectacularly unlikely that the computer
will still be running in 7 years.  Any entropy put into that pool is
effectively lost *permanently*.

But maybe we can come to a compromise like 24 hours.

Plus, even a crude entropy estimate can do better.
Suppose we want do to 128-bit catastrophic reseeding.  But we don't
trust our entropy estimator.  Still, we think it's within a factor of
100 of being correct.  So we keep 8 subpools.  The first is dumped into
the main pool when we estimate it holds 128 bits.  The second, when the
extimate reaches 256.  Etc, until the eighth, which we wait for 16K bits -
the 128 bits we want plus a factor-of-128 safety margin.

And that only requires 8 pools, not 32.

(Still, unless our 8th pool can actually hold 16 kbits = 2048 bytes,
we're still wasting lots of entropy in the case that our entropy
estimator is correct.  And it's already pretty damn conservative
by design.)

> I feel this goes back to the round-robin event input system.  Your
> argument of n, n+b0, n+b0+b1, ... makes sense, in the state compromise
> / state initialisation scenarios if the attacker can know for certain
> that they will see 1 out of every 32 inputs.  If each of the pools has
> a 1:32 probability of landing into any of the pools, then the things
> get a lot harder.

Yes, but if you had a way to get 5 uniform random bits the attacker
didn't know, the entire issue would be trivial; just keep getting
5 random bits until you have as much as you need.

> Does this make sense?  Ignoring the "where are you going to get a secure
> 1-in-32 RNG" issue.

I have a really hard time letting go of the latter, but let me think...

No, I don't see how it helps more than the 5 random bits you're
giving yourself for free.  After any given subpool-0-to-main-pool
transfer, the attacker can easily see if subpool 0 was reseeded or not.
If it was, we can brute-force the seed.  With enough seeds at known
sequence positions, and high enough serial correlations, we can deduce
all the intermediate seeds.  Now the only uncertainty is which other pools
they got added to.

Which is the 5 bits of uncertainty you're giving yourself for free.

> Assuming an attacker can see the secondary-pool (/dev/random output) and
> events {n, n+b0, b+b0+b1} enter primary-pool at times {t, t+t1, t+t1+t2}.
> If the rate is slow enough, then an accurate entropy estimation will stop
> anything from getting out, great.

That's the hope.

> "How does the entropy estimator measure entropy of the event?" becomes a
> crucial concern here.  What if, by your leading example, there is 1/2 bit
> of entropy in each event?  Will the estimator even account for 1/2 bits?
> Or will it see each event as 3 bits of entropy?  How much of a margin
> of error can we tolerate?

H'm... the old code *used* to handle fractional bits, but the new code
seems to round down to the nearest bit.  May have to get fixed to
handle low-rate inputs.

As for margin of error, any persistent entropy overestimate is Bad.
a 6-fold overestimate is disastrous.

What we can do is refuse to drain the main pool below, say, 128 bits of
entropy.  Then we're safe against any *occasional* overestimates
as long as they don't add up to 128 bits.

> /dev/random will output once it has at least 160 bits of entropy
> (iirc), 1/2 bit turning into 3 bits would mean that 160bits of output
> it effectively only 27 bits worth of true entropy (again, assuming the
> catastrophic reseeder and output function don't waste entropy).
> 
> It's a lot of "ifs" for my taste.

/dev/random will output once it has as many bits of entropy as you're
asking for.  If you do a 20-byte read, it'll output once it has 160
bits.  If you do a 1-byte read, it'll output once it has 8 bits.
