Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVBLXZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVBLXZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVBLXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 18:25:50 -0500
Received: from science.horizon.com ([192.35.100.1]:45635 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261212AbVBLXZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 18:25:34 -0500
Date: 12 Feb 2005 23:25:18 -0000
Message-ID: <20050212232518.10838.qmail@science.horizon.com>
From: linux@horizon.com
To: ak@muc.de, linux@horizon.com
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Cc: arjan@infradead.org, bunk@stusta.de, chrisw@osdl.org, davem@redhat.com,
       hlein@progressive-comp.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu
In-Reply-To: <m11xblif93.fsf@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux@horizon.com writes:
>> (The homebrew 15-bit block cipher in this code does show how much the
>> world needs a small block cipher for some of these applications.)
>
> Doesn't TEA fill this niche? It's certainly used for this in the Linux
> kernel, e.g. in reiserfs (although I have my doubts it is really useful
> there) 

Sorry; ambiguous parsing.  I meant "(small block) cipher", not "small
(block cipher)".  TEA is intended for the latter niche.  What I meant
was a cipher that could encrypt blocks smaller than 64 bits.

It's easy to make a smaller hash by just thowing bits away, but a block
cipher is a permutation, and has to be invertible.

For example, if I take a k-bit counter and encrypt it with a k-bit
block cipher, the output is guaranteed not to repeat in less than 2^k
steps, but the value after a given value is hard to predict.

There is a well-known technique for reducing the block size of a cipher
by a small factor, such as from a power of 2 to a prime number
slightly lower.  That is:

unsigned
encrypt_mod_n(unsigned x, unsigned n)
{
	assert(x < n);
	do {
		x = encrypt(x);
	} while (x >= n);
	return x;
}

It takes a bit of thinking to realize why this creates an bijection from
[0..n-1] -> [0..n-1], but it's kind of a neat "aha!" when it does.

Remember, encrypt() is a bijection from [0..N-1] -> [0..N-1] for some
N >= n.  Typically N = 2^k for some k.

However, this technique requires N/n calls to encrypt().  I.e.
n calls to encrypt_mod_n() will cause N calls to encrypt().

It's generally considered practical up to N/n = 2, so we can encrypt
modulo any modulus n if we have encrypt() functions for any N = 2^k a
power of 2.  I.e. a k-bit block cipher.

For example, suppose we want to encrypt 7-digit North American telephone
numbers.  These are of the form NXX-XXXX, where N is a digit other than
0 or 1, and X is any digit.  there are 8e6 possibilities.  Using this
scheme and a 23-bit block cipher, we can encrypt them to different valid
7-digit telephone numbers.

Likewise, 10-digit number with area codes, +1 NXX NXX-XXXX (but not
starting with N11) are also possible.  There are 792 area codes and
8e6 numbers for a total of 7776000000 < 2^33 combinations.

This sort of thing is very useful for adding encryption to protocols and
file formats not designed for it.


However, the standard literature is notably lacking in block ciphers
in funny block sizes.  There was one AES submission (The Hasty Pudding
Cipher, http://www.cs.arizona.edu/~rcs/hpc/) that supported variable
block sizes, but it was eliminated fairly early.


To start with, consider very small blocks: 1, 2 or 3 bits.
There are only two possible things encrypt() can do with a 1-bit value:
either invert it or leave it alone.

There are 4! = 24 possible 2-bit encryption operations.  Ideally, the
key should specify them all with equal probability, but 24 does not
evenly divide the (power of 2 sized) keyspace.  It is interesting to
look at how iniformly the possibilities are covered.

It's fun to consider a Feistel network, dividing the plaintext into 1-bit
L and R values, and alternating L ^= f(R), R ^= f(L) for (not nexessarily
invertible) round functions f.  Since there are only 4 possible 1-bit
functions (1, 0, x and !x), you can consider each round to have an
independent 2-bit round subkey and see how the cipher's uniformity
develops as you increase the number of rounds and the key length to go
with it.

There are 8! = 40320 3-bit encryption operations.  Again, all should be
covered uniformly.  An odd number of bits makes a Feistel design more
challenging.  But if you don't allow odd numbers of bits, you have to push
the shrinking technique it to N/n = 4, which starts to get unpleasant.
