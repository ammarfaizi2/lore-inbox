Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVBMBlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVBMBlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 20:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBMBlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 20:41:14 -0500
Received: from science.horizon.com ([192.35.100.1]:29230 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261230AbVBMBlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 20:41:05 -0500
Date: 13 Feb 2005 01:41:04 -0000
Message-ID: <20050213014104.19282.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, roland@topspin.com
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Cc: ak@muc.de, arjan@infradead.org, bunk@stusta.de, chrisw@osdl.org,
       davem@redhat.com, hlein@progressive-comp.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <527jld2tyx.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    linux> It's easy to make a smaller hash by just thowing bits away,
    linux> but a block cipher is a permutation, and has to be
    linux> invertible.

    linux> For example, if I take a k-bit counter and encrypt it with
    linux> a k-bit block cipher, the output is guaranteed not to
    linux> repeat in less than 2^k steps, but the value after a given
    linux> value is hard to predict.

> Huh?  What if my cipher consists of XOR-ing with a k-bit pattern?
> That's a permutation on the set of k-bit blocks but it happens to
> decompose as a product of (non-overlapping) swaps.
> 
> In general for more realistic block ciphers like DES it seems
> extremely unlikely that the cipher has only a single orbit when viewed
> as a permutation.  I would expect a real block cipher to behave more
> like a random permutation, which means that the expected number of
> orbits for a k-bit cipher should be about ln(2^k) or roughly .7 * k.

I think you misunderstand; your comments don't seem to make sense unless
I assume you're imagining output feedback mode:

x[0] = encrypt(IV)
x[1] = encrypt(x[0])
x[2] = encrypt(x[1])
etc.

Obviously, this pattern will repeat after some unpredictable interval.
(However, owing to the invertibility of encryption, looping can
be easily detected by noticing that x[i] = IV.)

But I was talking about counter mode:

x[0] = encrypt(0)
x[1] = encrypt(1)
x[2] = encrypt(2)
etc.

It should be obvious that this will not repeat until the counter
overflows k bits and you try to compute encrypt(2^k) = encrypt(0).

One easy way to generate unpredictable 16-bit port numbers that don't
repeat too fast is:

highbit = 0;
for (;;) {
	generate_random_encryption_key(key);
	for (i = 0; i < 20000; i++)
		use(highbit | encrypt15(i, key));
	highbit ^= 0x8000;
}

Note that this does NOT use all 32K values before switching to another
key; if that were the case, an attacker who kept a big bitmap of reviously
seen values could preduct the last few values based on knowing what
hadn't been seen already.


Of course, you can always wrap a layer of Knuth's Algorithm B
(randomization by shuffling) around anything:

#include "basic_rng.h"

#define SHUFFLE_SIZE 32	/* Power of 2 is more efficient */

struct better_rng_state {
	struct basic_rng_state basic;
	unsigned y;
	unsigned z[SHUFFLE_SIZE];
};

void
better_rng_seed(struct better_rng_state *state, unsigned seed)
{
	unsigned i;
	basic_rng_seed(&state->basic, seed);

	for (i = 0; i < SHUFFLE_SIZE; i++)
		state->z[i] = basic_rng(&state->basic);
	state->y = basic_rng(&state->basic) % SHUFFLE_SIZE;
}

unsigned
better_rng(struct better_rng_state *state)
{
	unsigned x = state->z[state->y];
	state->y = (state->z = basic_rng(&state->basic)) % SHUFFLE_SIZE;
	return x;
}

(You can reduce code size by reducing modulo SHUFFLE_SIZE when you use
state->y rather than when storing into it, but I have done it the other
way to make clear exactly how much "effective" state is stored.  You can
also just initialize state->y to a fixed value.)
