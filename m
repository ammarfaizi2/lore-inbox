Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUBETtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266645AbUBETs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:48:27 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:54725 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S266632AbUBETqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:46:35 -0500
Date: Thu, 5 Feb 2004 14:40:46 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch   pentium3,4
Message-ID: <20040205194046.GE14521@certainkey.com>
References: <20040202040837.6306.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202040837.6306.qmail@science.horizon.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Linux",

I've always wanted to have done the compression function like this (loop, not
unrolled).

Your changes to choice and majority are already submitted (see my path from a
few weeks ago).

Your argument to changing big/little sigma is thin in my opinion.

Also, the memset(W, 0, 64 * sizeof(u32)) is is needed should you me computing
a MAC for an encrypted message (MACs are done on the unencrypted portion you
see, and parts of the message would still be in memory).  Can someone
confirm the kernel MemMgr doesn't wipe memory?

Here is a patch to sha256.c and sha512.c which does not use full
unrolling, saving space.
  http://jlcooke.ca/lkml/smaller_sha2.patch

This has been tested against the existing sha256/512.  Performance:
  10,000,000 sha256_transform()'s
   - manually unrolled (current):
     21sec or about 476,190 sha256 compression function calls per second
   - for(i=0; i<64; i++){ ... }
     26sec or about 384,615 sha256 compression function calls per second
   - for(i=0; i<64; i++){ ... } with -funroll-all-loops -funroll-loops
     24sec or about 416,667 sha256 compression function calls per second

So you see, it's very tight.

  1,000,000 sha512_transform()'s
   - manually unrolled by 8 (current)
     for(i=0; i<80; i+=8) {...}
     10sec or 100,000 per sec
   - for(i=0; i<80; i+=1) {...}
     10sec or 100,000 per sec
   - for(i=0; i<80; i+=1) {...} with -funroll-all-loops -funroll-loops
     10sec or 100,000 per sec

And here it's even tighter!

JLC - all tests were on a AMD Athlon(tm) XP 1700+ 1.4GHz using time(&timeval)

On Mon, Feb 02, 2004 at 04:08:37AM -0000, linux@horizon.com wrote:
> If it helps anyone, here's a modified sha256.c file that takes 256 bytes
> off the stack and shrinks the main code loop by a factor of 8.
> 
> The speed penalty is pretty minor, and might actually be negative due to
> better icache usage.
> 
> Includes x86 stubs for standalone self-test using the NIST test vectors.
> Enable the #if 0 parts and remove the commented-out debug lines
> for production use.
> 
> A few other additions:
> - Uses optimized unaligned-fetch and byte-swap routines.
> - Reordered the the Ch() and Maj() functions slightly to work better on
>   2-address instruction sets.
> - Got rid of two temporaries in the round function
> - Removed the need to memset() 256 bytes on the stack every call to
>   sha256_transform
> - Uses memset() rather than a padding array.
> 
> A few questions:
> - Should we just use a u64 to count the bytes rather than doing carries by
>   hand?
> - Do we actually need support for hashing more than 2^32 bytes in the first
>   place?
> - This does the aligned/unaligned check at the outermost feasible loop
>   position in the code, leading to quite a bit of duplication.
>   If the processor supports unaligned loads natively, it isn't even
>   necessary at all.  An better ideas?  I can understand:
>   - Moving the test to once per call to sha256_transform, on the
>     grounds that the latter outweights it by a large amount.
>   - Always using the unaligned load, likewise.
>   - Rolling my own unaligned block move-and-byte-swap (using aligned
>     loads, shifts, and algned stores), since the existing unaligned code
>     isn't quite what we want.
>   - Just using memcpy and byte-swap in place, and letting the L1 cache
>     take care of it.
> - The e() functions as written take a an temp register in addition to the
>   input and output.  Would it be better to rewrite them as e.g.
>   better to rewrite them as e.g.
> 	static inline u32 e0(u32 x)
> 	{
> 		u32 y = x;
> 		y = RORu32(y, 22-13) ^ x;
> 		y = RORu32(y, 13-2) ^ x;
> 		return RORu32(y, 2);
> 	}
>   to get rid of the need?  (And can someone figure out a similar trick
>   for the s() functions?  I don't think it's as important because there's
>   less register pressure when they're used.)
> 
> (P.S. These modifications are in the public domain; copyright abandoned.)
> 
> 
> /*
>  * Cryptographic API.
>  *
>  * SHA-256, as specified in
>  * http://csrc.nist.gov/cryptval/shs/sha256-384-512.pdf
>  *
>  * SHA-256 code by Jean-Luc Cooke <jlcooke@certainkey.com>.
>  *
>  * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
>  * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
>  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
>  *
>  * This program is free software; you can redistribute it and/or modify it
>  * under the terms of the GNU General Public License as published by the Free
>  * Software Foundation; either version 2 of the License, or (at your option) 
>  * any later version.
>  *
>  */
> #if 0
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/mm.h>
> #include <linux/crypto.h>
> #include <asm/scatterlist.h>
> #include <asm/byteorder.h>
> #else
> typedef unsigned int u32;
> typedef unsigned char u8;
> #include <string.h>
> #define get_unaligned(p) (*(p))
> #define be32_to_cpus(p) asm("bswap %0" : "+r" (*(p)));
> static inline u32
> be32_to_cpup(u32 const *p)
> {
> 	u32 x;
> 	asm("bswap %0" : "=r" (x) : "0" (*p));
> 	return x;
> }
> static inline u32
> be32_to_cpu(u32 x)
> {
> 	asm("bswap %0" : "+r" (x));
> 	return x;
> }
> #define cpu_to_be32s be32_to_cpus
> #define cpu_to_be32p be32_to_cpup
> #define cpu_to_be32 be32_to_cpu
> #endif
> 
> 
> #define SHA256_DIGEST_SIZE	32
> #define SHA256_HMAC_BLOCK_SIZE	64
> 
> struct sha256_ctx {
> 	u32 count[2];	/* Bytes so far: Low, then high */
> 	u32 state[8];
> 	u32 W[64];
> };
> 
> /* Bit-wise choose x ? y : z = (x & y) + (~x & z) = z ^ (x & (y ^ z)) */
> #define Ch(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
> 
> /*
>  * Majority function.  There's no really good way to optimize this,
>  * although x is the most recently computed vaue, so put it later in
>  * the dependency chain.  Also use ^ in the OR so that the halves can
>  * be merged with + which gives the compiler more flexibility to
>  * rearrange the surrounding sum.
>  * x&y | y&z | z&x = x&(y|z) | y&z = x&(y^z) + y&z
>  */
> #define Maj(x, y, z) (((x) & ((y) ^ (z))) + ((y) & (z)))
> 
> static inline u32 RORu32(u32 x, u32 y)
> {
> 	return (x >> y) | (x << (32 - y));
> }
> 
> #define e0(x)       (RORu32(x, 2) ^ RORu32(x,13) ^ RORu32(x,22))
> #define e1(x)       (RORu32(x, 6) ^ RORu32(x,11) ^ RORu32(x,25))
> #define s0(x)       (RORu32(x, 7) ^ RORu32(x,18) ^ (x >> 3))
> #define s1(x)       (RORu32(x,17) ^ RORu32(x,19) ^ (x >> 10))
> 
> #if __BYTE_ORDER == __BIG_ENDIAN
> #error WTF?
> # define loadin_inplace(w, len) (void)0
> #else
> static inline void
> loadin_inplace(u32 *W, unsigned i)
> {
> 	unsigned j;
> 	for (j = 0; j < i; j++)
> 		be32_to_cpus(W+j);
> }
> #endif
> 
> static inline void
> loadin_aligned(u32 *W, u32 const *input, unsigned i)
> {
> 	unsigned j;
> 	for (j = 0; j < i; j++)
> 		W[j] = be32_to_cpup(input+j);
> }
> /*
>  * This may be a bit bigger than we want an inline function, but
>  * it's only called from one place.
>  */
> static inline void
> loadin_unaligned(u32 *W, u8 const *input, unsigned i)
> {
> 	unsigned j;
> 	for (j = 0; j < i; j++)
> 		W[j] = be32_to_cpu(get_unaligned(input+4*j));
> }
> 
> static inline void BLEND_OP(int I, u32 *W)
> {
> 	W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
> }
> 
> /*
>  * This expects input in the first 16 words of W[], and uses all
>  * 64 words.  Doing it this way avoinds the need to allocate
>  * and zeroize a stack temporary each time.
>  */
> static void sha256_transform(u32 state[8], u32 W[64])
> {
> 	u32 a, b, c, d, e, f, g, h;
> 	int i;
> 	static u32 const k[64] = {
> 		0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
> 		0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5, 
> 		0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
> 		0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
> 		0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
> 		0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
> 		0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
> 		0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
> 		0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
> 		0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
> 		0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
> 		0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
> 		0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
> 		0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
> 		0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
> 		0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
> 	};
> //printf("in: %08x %08x %08x %08x %08x %08x %08x %08x\n",W[0],W[1],W[2],W[3],W[4],W[5],W[6],W[7]);
> //printf("in: %08x %08x %08x %08x %08x %08x %08x %08x\n",W[8],W[9],W[10],W[11],W[12],W[13],W[14],W[15]);
> 
> 	/* The first 16 words of W already contain the input - now blend */
> 	/* This is a sort of key-scheduling operation */
> 	for (i = 16; i < 64; i++)
> 		W[i] = s1(W[i-2]) + W[i-7] + s0(W[i-15]) + W[i-16];
>     
> 	/* load the state into our registers */
> 	a=state[0];  b=state[1];  c=state[2];  d=state[3];
> 	e=state[4];  f=state[5];  g=state[6];  h=state[7];
> 	/*
> 	 * Now iterate the actual round function.  This is actually 64
> 	 * copies of the same round function with the variables
> 	 * rotated each time, but here we unroll it 8 times to
> 	 * reduce the amount of data motion.  You could roll it up
> 	 * more if code size is a priority.
> 	 */
> 	for (i = 0; i < 64; i += 8) {
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+0,a,b,c,d,e,f,g,h);
> 		d += h += e1(e) + Ch(e,f,g) + k[i+0] + W[i+0];
> 		h += e0(a) + Maj(a,b,c);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+1,h,a,b,c,d,e,f,g);
> 		c += g += e1(d) + Ch(d,e,f) + k[i+1] + W[i+1];
> 		g += e0(h) + Maj(h,a,b);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+2,g,h,a,b,c,d,e,f);
> 		b += f += e1(c) + Ch(c,d,e) + k[i+2] + W[i+2];
> 		f += e0(g) + Maj(g,h,a);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+3,f,g,h,a,b,c,d,e);
> 		a += e += e1(b) + Ch(b,c,d) + k[i+3] + W[i+3];
> 		e += e0(f) + Maj(f,g,h);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+4,e,f,g,h,a,b,c,d);
> 		h += d += e1(a) + Ch(a,b,c) + k[i+4] + W[i+4];
> 		d += e0(e) + Maj(e,f,g);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+5,d,e,f,g,h,a,b,c);
> 		g += c += e1(h) + Ch(h,a,b) + k[i+5] + W[i+5];
> 		c += e0(d) + Maj(d,e,f);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+6,c,d,e,f,g,h,a,b);
> 		f += b += e1(g) + Ch(g,h,a) + k[i+6] + W[i+6];
> 		b += e0(c) + Maj(c,d,e);
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+7,b,c,d,e,f,g,h,a);
> 		e += a += e1(f) + Ch(f,g,h) + k[i+7] + W[i+7];
> 		a += e0(b) + Maj(b,c,d);
> 	}
> //printf("%2u: %08x %08x %08x %08x %08x %08x %08x %08x\n", i+0,a,b,c,d,e,f,g,h);
> 
> 	/* Add back to the state to make hash one-way */
> 	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
> 	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
> 
> 	/* clear any sensitive info... */
> 	a = b = c = d = e = f = g = h = 0;
> }
> 
> static void
> sha256_init(void *ctx)
> {
> 	struct sha256_ctx *sctx = ctx;
> 	static u32 const Hinit[SHA256_DIGEST_SIZE/4] = {
> 		0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
> 		0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
> 	};
> 
> 	memcpy(sctx->state, Hinit, sizeof Hinit);
> 	sctx->count[0] = sctx->count[1] = 0;
> }
> 
> static void
> sha256_update(void *ctx, const u8 *data, unsigned int len)
> {
> 	struct sha256_ctx *sctx = ctx;
> 
> 	/* Compute number of bytes mod 63 */
> 	unsigned index = (unsigned)sctx->count[0] & (SHA256_HMAC_BLOCK_SIZE-1);
> 
> //printf("sha256_update(%.*s)\n", (int)len, data);
> 
> 	/* Add 32-bit len to 64-bit sctx->count */
> 	sctx->count[1] += ((sctx->count[0] += len) < len);
> 
> 	if (len + index >= SHA256_HMAC_BLOCK_SIZE) {
> 		if (index) {
> 			memcpy((char *)sctx->W + index, data, len);
> 			loadin_inplace(sctx->W, 16);
> 			sha256_transform(sctx->state, sctx->W);
> 			index = SHA256_HMAC_BLOCK_SIZE-1-index;
> 			data += index;
> 			len -= index;
> 			index = 0;
> 		}
> 		/*
> 		 * I wish there was a way to tell if unaligned loads
> 		 * required a special instruction sequence and there
> 		 * was a point to splitting this...
> 		 */
> 		if ((unsigned)data % 4 == 0) {
> 			/* Aligned case */
> 			while (len >= SHA256_HMAC_BLOCK_SIZE) {
> 				loadin_aligned(sctx->W, (u32 const *)data, 16);
> 				sha256_transform(sctx->state, sctx->W);
> 				data += SHA256_HMAC_BLOCK_SIZE;
> 				len -= SHA256_HMAC_BLOCK_SIZE;
> 			}
> 		} else {
> 			/* Unaligned case */
> 			while (len >= SHA256_HMAC_BLOCK_SIZE) {
> 				loadin_unaligned(sctx->W, data, 16);
> 				sha256_transform(sctx->state, sctx->W);
> 				data += SHA256_HMAC_BLOCK_SIZE;
> 				len -= SHA256_HMAC_BLOCK_SIZE;
> 			}
> 		}
> 	}
> 	/* Buffer any leftover data */
> 	memcpy((char *)sctx->W + index, data, len);
> }
> 
> static void
> sha256_final(void* ctx, u8 *out)
> {
> 	struct sha256_ctx *sctx = ctx;
> 
> 	/* Next byte to store */
> 	unsigned index = (unsigned)sctx->count[0] & (SHA256_HMAC_BLOCK_SIZE-1);
> 
> 	/* Add padding bit sequence 1000...; we're limited to 8-bit bytes. */
> 	((u8 *)sctx->W)[index++] = 0x80;
> 	if (index > 56) {
> 		/* Wups, need a whole extra block to fit the 8-bit count */
> 		memset((u8 *)sctx->W + index, 0, 64-index);
> 		loadin_inplace(sctx->W, 16);
> 		sha256_transform(sctx->state, sctx->W);
> 		index = 0;
> 	}
> 	memset((u8 *)sctx->W + index, 0, 56-index);
> 	loadin_inplace(sctx->W, 14);
> 
> 	/* Append number of bits in final 8 bytes, big-endian */
> 	/* QUESTION: Are we ever going to hash more than 256 MiB? */
> 	sctx->W[14] = (sctx->count[1] << 3) + (sctx->count[0] >> 29);
> 	sctx->W[15] = (sctx->count[0] << 3);
> 
> 	sha256_transform(sctx->state, sctx->W);
> 
> 	/* Output the state */
> 	for (index = 0; index < SHA256_DIGEST_SIZE/4; index++)
> 		cpu_to_be32s(sctx->state + index);
> 	memcpy(out, sctx->state, SHA256_DIGEST_SIZE);
> 
> 	/* Zeroize sensitive information. */
> 	memset(sctx, 0, sizeof *sctx);
> }
> 
> #if 0
> 
> static struct crypto_alg alg = {
> 	.cra_name	=	"sha256",
> 	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
> 	.cra_blocksize	=	SHA256_HMAC_BLOCK_SIZE,
> 	.cra_ctxsize	=	sizeof(struct sha256_ctx),
> 	.cra_module	=	THIS_MODULE,
> 	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
> 	.cra_u		=	{ .digest = {
> 		.dia_digestsize	=	SHA256_DIGEST_SIZE,
> 		.dia_init   	= 	sha256_init,
> 		.dia_update 	=	sha256_update,
> 		.dia_final  	=	sha256_final }
>        	}
> };
> 
> static int __init init(void)
> {
> 	return crypto_register_alg(&alg);
> }
> 
> static void __exit fini(void)
> {
> 	crypto_unregister_alg(&alg);
> }
> 
> module_init(init);
> module_exit(fini);
> 
> MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("SHA256 Secure Hash Algorithm");
> #else
> 
> #include <stdio.h>
> 
> static void
> dump_hash(u8 const buf[32])
> {
> 	unsigned i;
> 	for (i = 0; i < 32; i++) {
> 		if (i % 4 == 0)
> 			putchar(' ');
> 		printf("%02x", buf[i]);
> 	}
> }
> 
> static int
> check_hash(u8 const buf[32], u8 const expected[32])
> {
> 	printf(" Result:");
> 	dump_hash(buf);
> 	if (memcmp(buf, expected, 32) != 0) {
> 		printf("Correct:");
> 		puts("*** MISMATCH ***");
> 		return 1;
> 	}
> 	return 0;
> }
> 
> int
> main(void)
> {
> 	/* Test driver using the test vectors from FIPS 180-2 */
> 	char tv1[3] = "abc";
> 	static u8 const out1[32] =  {
> 		0xba,0x78,0x16,0xbf, 0x8f,0x01,0xcf,0xea, 0x41,0x41,0x40,0xde,
> 	       	0x5d,0xae,0x22,0x23, 0xb0,0x03,0x61,0xa3, 0x96,0x17,0x7a,0x9c,
> 	       	0xb4,0x10,0xff,0x61, 0xf2,0x00,0x15,0xad
> 	};
> 
> 	char tv2[56] = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";
> 	static u8 const out2[32] =  {
> 		0x24,0x8d,0x6a,0x61, 0xd2,0x06,0x38,0xb8, 0xe5,0xc0,0x26,0x93,
> 	       	0x0c,0x3e,0x60,0x39, 0xa3,0x3c,0xe4,0x59, 0x64,0xff,0x21,0x67,
> 	       	0xf6,0xec,0xed,0xd4, 0x19,0xdb,0x06,0xc1
> 	};
> 
> 	char tv3[1024];
> 	static u8 const out3[32] =  {
> 		0xcd,0xc7,0x6e,0x5c, 0x99,0x14,0xfb,0x92, 0x81,0xa1,0xc7,0xe2,
> 	       	0x84,0xd7,0x3e,0x67, 0xf1,0x80,0x9a,0x48, 0xa4,0x97,0x20,0x0e,
> 	       	0x04,0x6d,0x39,0xcc, 0xc7,0x11,0x2c,0xd0
> 	};
> 	u8 hash[32];
> 	struct sha256_ctx ctx;
> 	unsigned i, j, errors = 0;
> 
> 	/* tv1 */
> 	for (i = 1; i <= 3; i++) {
> 		sha256_init(&ctx);
> 		for (j = 0; j < 3-i; j += i)
> 			sha256_update(&ctx, tv1+j, i);
> 		sha256_update(&ctx, tv1+j, 3-j);
> 		sha256_final(&ctx, hash);
> 		printf("Hash computed %u bytes at a time:\n", i);
> 		errors += check_hash(hash, out1);
> 	}
> 
> 	/* tv2 */
> 	for (i = 1; i <= 56; i++) {
> 		sha256_init(&ctx);
> 		for (j = 0; j < 56-i; j += i)
> 			sha256_update(&ctx, tv2+j, i);
> 		sha256_update(&ctx, tv2+j, 56-j);
> 		sha256_final(&ctx, hash);
> 		printf("Hash computed %u bytes at a time:\n", i);
> 		errors += check_hash(hash, out2);
> 	}
> 
> 	/* tv3 */
> 	memset(tv3, 'a', sizeof tv3);
> 	for (i = 1; i <= sizeof tv3; i *= 2) {
> 		sha256_init(&ctx);
> 		for (j = 0; j < 1000000-i; j += i)
> 			sha256_update(&ctx, tv3, i);
> 		sha256_update(&ctx, tv3, 1000000-j);
> 		sha256_final(&ctx, hash);
> 		printf("Hash computed %u bytes at a time:\n", i);
> 		errors += check_hash(hash, out3);
> 	}
> 	printf("Check complete, %u errors\n", errors);
> 	return errors != 0;
> }
> 
> #endif
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
