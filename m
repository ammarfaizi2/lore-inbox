Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVDNOwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVDNOwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 10:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDNOwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 10:52:35 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:29114 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261510AbVDNOwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 10:52:17 -0400
Date: Thu, 14 Apr 2005 10:52:04 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Fortuna
Message-ID: <20050414145204.GI12263@certainkey.com>
References: <20050414141538.3651.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414141538.3651.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the post.

Waiting for 256bits of entropy before outputting data is a good goal.  Problem
becomes how do you measure entropy in a reliable way?  This had me lynched
last time I asked it so I'll stop right there.

Info-theoretic randomness is a strong desire of some/many users, and they think
the current entropy estimation technique does the trick, so I left it there
with the option to #define it out.

I'll not make any claim that random-fortuna.c should be mv'd to random.c, the
patch given allows people to kernel config it in under the Cryptographic
Options menu.  Perhaps a disclaimer in the help menu would be in order to
inform users that Fortuna has profound consequences for those expecting
Info-theoretic /dev/random?

The case where an attacker has some small amount of unknown in the pool is a
problem that effects BOTH random-fortuna.c and random.c (and any other
replacement for that matter).  Just an FYI.

As for the "shifting property" problem of an attacker controlling some input
to the pooling system, I've tried to get around this:

r->pools_bytes[r->pool_index] += nwords * sizeof(__u32);
crypto_digest_update(r->pools[r->pool_index], sg, 1);
if (r->pool_index == 0) {
    r->pool0_len += nwords*sizeof(__u32);
}
/* idx = (idx + r) mod ( (2^N)-1 ) */
r->pool_index = (r->pool_index + r->key[keyidx])
                      & ((1<<random_state->pool_number)-1);
/* first 8 bytes of the key are used, 8 * 8 = 64 bits */
keyidx = (keyidx + 1) & 7;

The add_entropy_words() function uses the first 8 bytes of the central
pool to aggravate the predictability of where entropy goes.  It's still a
linear progression untill the central pool is re-keyed, then you don't know
where it went.  The central pool is reseeded every 0.1ms.

This causes problems of course, the hard upper bound of "we recover from
state compromise in at most a factor of 64 times the rate of entropy inflow"
is no longer non-deterministic.  That is, it changes to "we expect to recover
from state compromise in a factor of 64 times the rate of entropy inflow."

Not sure if this was caught or not, but <linux@>Anyway, every 32 cycles, a seed word
is added to subpool 0, which is then immediately added to the main pool</linux@>.
Entirely true however, every time other than the first seeding other pools
will be adding words to the main pool as well.

Cheers,

JLC

On Thu, Apr 14, 2005 at 02:15:38PM -0000, linux@horizon.com wrote:
> Just to refersh everyone's memory as to the strengths and weaknesses
> of Fortuna...
> 
> First, a reminder that the design goal of /dev/random proper is
> information-theoretic security.  That is, it should be secure against
> an attacker with infinite computational power.  If you want a weaker
> guarantee, use /dev/urandom.
> 
> I've heard a suggestion that something like /dev/urandom, but which blocks
> until it has received a minimum amount of seed material at least once,
> would be a nice thing.  So boot-time crypto initialization can stall
> until it has achieved a minimum level of security.
> 
> The minimum could be measured two ways:
> - Some reasonable default, like 256 bits, or
> - (clever) the size of the read() request, which is presumably the
>   key size that the user needs.  This might be too subtle to explain
>   to programmers, though.
> 
> 
> Anyway, there are two main parts to Fortuna.  The central "random pool",
> and the round-robin sub-pool system for reseeding the main pool.
> 
> Fortuna uses a "small pool, trust the crypto" central pool.
> /dev/random uses a large pool that is deliberately designed to be
> robust against failure of the crypto primitives.  Indeed, the basic
> design just uses it as a uniform hash.  Cryptographic strength is
> irrelevant to the information-theoretic guarantees.
> 
> This portion of Fortuna is at odds with /dev/random's design goals,
> but it could be replaced easily enough.  It's not the clever part.
> 
> 
> The "neat idea" in Fortuna is the round-robin sub-pool seeding technique,
> which attempts to avoid the entire issue of entropy estimation.
> 
> Now, for information-theoretic guarantees, entropy measurement is
> *required*.  You cannot be information-theoretic secure unless you
> have received more seed entropy than you have produced output.
> 
> However, Fortuna has a different philosophy.  This difference is why
> Fortuna will NEVER be an "exact drop-in replacement" for /dev/random,
> although it can do the job for /dev/urandom.  There are important
> user-visible differences in the guarantees it makes.  Someone may
> argue that the difference is immaterial in practice, but existence of
> a difference is indisputable.
> 
> 
> It tries to divide up the seed entropy into sub-pools and hold off
> re-seeding the main pool until the sub-pool has accumulated enough entropy
> to cause "catastrophic reseeding" of the main pool, adding enough entropy
> at once that someone who had captured the prior state of the main pool
> would not be able (due to computational limits and the one-way nature
> of the pool output function) to reverse-engineer the post-state.
> 
> The way it schedules the additions, it doesn't know *which* re-seed of
> the main pool will be catastrophic, but it knows that it will be within
> a factor of 64 of the shortest time that's possible.
> 
> 
> However, it possible to come up with some pathological entropy sources
> for which the standard Fortuna design completely fails to achieve that
> goal.
> 
> So Fortuna would be helped by some better understanding of what exactly
> makes it fail, so the discussion could move to whether real-world
> seed sources have those properties.
> 
> But until that understanding is gained, Fortuna is questionable.
> 
> 
> Appendix: how to "break" Fortuna.
> 
> First, the standard assumptions: the "attacker" can collect arbitrary
> amounts of RNG output at any time, and can see all operations on the
> pool except for the value of the seed material.
> 
> In particular, if the attacker's uncertainty about the pool's state
> is small, she can collect enough output to distinguish all the
> possibilities and attempt a brute-force computation to recover the
> unknown state information.
> 
> Finally, assume the attacker knows the full initial state of the
> generator.
> 
> For a classic 32-subpool Fortuna, let the seed be a 32-bit integer.
> Every time a new seed is produced, shift the previous value and insert
> a fresh random bit.  Thus, the seed does deliver 1 bit of entropy
> per sample, which should make for a secure source.
> 
> If you want to be cruel, encrypt that seed with a strong cipher known
> only to the attacker before producing output.  That keeps the nature
> of the seed from the Fortuna implementation.
> 
> Anyway, every 32 cycles, a seed word is added to subpool 0, which is then
> immediately added to the main pool.  An attacker who knows the prior
> state of the main pool can attempt a brute-force search for the 32 bits
> of the seed word in a reasonable period of time.
> 
> Because of the shifting property, an attacker who knows the seeds added
> to pool 0 at times t and t+32 can also deduce, with perfect accuracy,
> the seeds added to the other 31 pools at times t+1 through t+31.
> 
> The result being that the other subpools, which are supposed to be hoarding
> secret information unknown to the attacker, are actually being seeded with
> bits known to the attacker.
> 
> The ultimate result is that catastrohpic reseeding never takes place.
> If we could somehow separate the "fresh" entropy in the input samples
> from the "holdover" material, the problem would go away, but that's
> an entropy measurement problem!
> 
> Until this cloud is dissipated by further analysis, it's not possible to
> say "this is shiny and new and better; they's use it!" in good conscience.
