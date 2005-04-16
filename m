Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVDPKGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVDPKGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 06:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVDPKGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 06:06:21 -0400
Received: from science.horizon.com ([192.35.100.1]:24622 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261733AbVDPKF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 06:05:57 -0400
Date: 16 Apr 2005 10:05:55 -0000
Message-ID: <20050416100555.25344.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: Fortuna
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
In-Reply-To: <20050415170450.GB23277@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MErging e-mails, first from mpm@selenic.com:
> You really ought to look at the _current_ implementation. There is no
> SHA1 code in random.c. 

So I'm imagining the call to sha_transform() in 2.6.12-rc2's
extract_buf()?  The SHA1 code has been moved to lib/sha1.c, so there's
no SHA1 code *lexically* in random.c, but that's a facile response;
it's a cryptologically meaningless change.

The way it's done, the length ends up being byte-swapped twice.  Here's an
alternative sha1_final, moving the byte-swapping into sha1_update and
saving a few cycles and a few bytes (234 -> 214 bytes with gcc-4.0 -O
-fomit-frame-pointer on x86).  I assume that moving the byte-swapping
from sha_transform to sha1_update has no code size impact.



extern void sha_transform(u32 state[5], u32 temp[80]);

void sha1_final(void* ctx, u8 *out)
{
	struct sha1_ctx *sctx = ctx;
	u32 temp[SHA_WORKSPACE_WORDS];
	u64 count = sctx->count;
	u32 i, j, index;
	static const u8 padding[64] = { 0x80, };
	
	/* Pad out to 56 mod 64 */
	index = (((unsigned)sctx->count >> 3) + 8) & 0x3f;
	sha1_update(sctx, padding, 64-index); 
	
	/* Byte-swap the first 14 words of the buffer */
	for (i = 0; i < 14; i++)
		temp[i] = be32_to_cpu(((u32 const *)sctx->buffer)[i]);
		
	/* Append length, two native words, in big-endian word order. */
	((u32 *)sctx->buffer)[14] = (u32)(count >> 32);
	((u32 *)sctx->buffer)[15] = (u32)count; 
	
	/* And the final transformation */
	sha_transform(sctx->state, temp);
	
	/* Store state in digest */
	for (i = j = 0; i < 5; i++, j += 4) {
		u32 t2 = sctx->state[i]; 
		out[j+3] = t2 & 0xff; t2>>=8;
		out[j+2] = t2 & 0xff; t2>>=8;
		out[j+1] = t2 & 0xff; t2>>=8;
		out[j  ] = t2 & 0xff;
	}

	/* Wipe context */
	memset(temp, 0, sizeof temp);
	memset(sctx, 0, sizeof *sctx);
}



Anyway, back to the long-suffering jlcooke@certainkey.com:

>> something?  Because it makes zero difference, and reduces the code
>> size and execution time.  Which is obviously a Good Thing.)

> It just bugged me when I was reading random.c for the first time.  First
> impressions and all.

Interesting.  Hopefully, further reflecton has shown you that the change
has zero security implications.  (For the same reason, cryptanalysts
studying DES ignore the initial permutation.)

>> Do you like:
>> - The neat name,
>> - The strong ciphers used in the pools, or
>> - The multi-pool reseeding strategy, or
>> - Something else?

> The multi-pool reseeding strategy is what I find particular interesting.
> It's design that can fit neatly into my little head and I hope into the heads
> of others in the future.  You can call it Bob or whatever you want, names
> doesn't matter to me.  As for the ciphers/digest algos used, they are
> not if great concern to me, replace them with what you want.  It's the design
> of the RNG itself that has my attention for the time being.

Great, we agree!  (Okay, almost.)  My point about "the neat name" was a
facetious straw-man.  That's a metaphor for "some stupid non-technical
reason".  Newer is not neceaarily better.  But your reason for liking
Fortuna is not quite that shallow.  Good.

Ted doesn't like Fortuna's pool design, I don't care for it much, but
you agree it's not important.  Great, no real point of contention there.
With lots of subpools, they need to be smaller, but the details of the
structure can be settled later.

But as I think I've said often enough, the sub-pool structure is what
makes Fortuna interesting.  *That* is Fortuna's contribution to the
state of the art, and the neat idea worth stealing.  We still agree!

However, there are a few issues, and if you'd like to address them, we
can actually get closer to agreeing, or at least clearly stating what
we disagree about.

1) Fortuna is trying to sidestep the hard problem of entropy measurement,
   to make it unnecessary.  This is a laudable goal, but /dev/random's
   information-theoretic design goal precludes this simplification.
   It *has* to measure entropy.  Are Fortuna's benefits sufficient to
   motivate a public interface change like that?  If you can argue that
   the current entropy measurement is such crap that it's not actually
   delivering its promise anyway, that would be a good reason.

   But as long as you *have* entropy measurement, you don't *need*
   Fortuna's elaborate scheme for avoiding it.  You only need *one*
   sub-pool.

2) Fortuna tries to support such a wide range of entropy source rates,
   down to very low rates, that it sequesters some entropy for literally
   years.  Ted thinks that's inexcusable, and I can't really disagree.
   This can be fixed to a significant degree by tweaking the number
   of subpools.

3) Fortuna's design doesn't actually *work*.  The authors' analysis
   only works in the case that the entropy seeds are independent, but
   forgot to state the assumption.  Some people reviewing the design
   don't notice the omission.

   It's that assumption which lets to "divide up" the seed material
   among various sub-pools.  Without it, seed information leaks from
   the sequestered sub-pools to the more exposed ones, decreasing the
   "value" of the sequestered pools.

   I've shown a contrived pathological example, but I haven't managed
   to figure out how to characterize the leakage in a more general way.
   But let me give a realistic example.

   Again, suppose we have an entropy source that delivers one fresh
   random bit each time it is sampled.

   But suppose that rather than delivering a bare bit, it delivers the
   running sum of the bits.  So adjacent samples are either the same or
   differ by +1.  This seems to me an extremely plausible example.

   Consider a Fortuna-like thing with two pools.  The first pool is seeded
   with n, then the second with n+b0, then the first again with n+b0+b1.
   n is the arbitrary starting count, while b0 and b1 are independent
   random bits.

   Assuming that an attacker can see the first pool, they can find n.
   After the second step, their uncertainty about the second pool is 1
   bit, the value of b0.

   But the third step is interesting.  The attacker can see the value of
   b0+b1.  If the sum is 0 or 2, the value of b0 is determined uniquely.
   Only in the case that b0+b1 = 1 is there uncertainty.  So we have
   only *half* a bit of uncertainty (one bit, half of the time) in the
   second pool.

   Where did the missing entropy go?  Well, remember the Shannon formula
   for entropy, H(p_1,...,p_n) = - Sum(p_i * log(p_i)).  If the log is
   to the base 2, the result is in bits.

   Well, p_0 = 1/4, p_1 = 1/2, and p_2 = 1/4.  The logs of those are
   -2, -1, and -2, respectively.  So the sum works out to
   2 * 1/4 + 1 * 1/2 + 2 * 1/4 = 1.5.

   Half a bit of entropy has leaked from the second pool back into the first!

   I probably just don't have enough mathematical background, but I don't
   currently know how to bound this leakage.  In pathological cases,
   *all* of the entropy leaks into the lowest-order pool, at which point
   the whole elaborate structure of Fortuna is completely useless.

   *That* is my big problem with Fortuna.  If someone can finish the
   analysis and actually bound the leakage, then we can construct something
   that works.  But I've pushed the idea around for a while and not figured
   it out.

> I'll take my patch and not bother you anymore.  I'm sure I've taken a
> lot of your time as it is.

And you've spent a lot of time preparing that patch.  It's not a bad idea
to revisit the ideas occasionally, but let's talk about the real *meat*
of the issue.

If you think my analysis of Fortuna's issues above is flawed, please
say so!  If you disagree about the importance of the issues, that's
worth discussing too, although I can't promise that such a difference
of opinions will ever be totally resolved.  But arguing about the
relative importance  of good and bad points is meaningful.

Ideally, we manage to come up with a solution that has all the good points.

The only thing that's frustrating is discussing it with someone who doesn't
even seem to *see* the issues.

> Not to sound like a "I'm taking my ball and going home" - just explaining
> that I like the Fortuna design, I think it's elegant, I want it for my
> systems.  GPL requires I submit changes back, so I did with the unpleasant
> side-dish of my opinion on random.c.

Actually, the GNU GPL doesn't.  It only requires that you give out the
source if and when you give out the binary.  You can make as many
private changes as you like.  (Search debian-legal for "desert island
test".)
