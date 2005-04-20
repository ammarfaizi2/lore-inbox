Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVDTMOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVDTMOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVDTMOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:14:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9646 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261570AbVDTMKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:10:35 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: working around gcc bogons (was: Re: Whirlpool oopses in 2.6.11 and 2.6.12-rc2)
Date: Wed, 20 Apr 2005 15:09:51 +0300
User-Agent: KMail/1.5.4
References: <200504190842.10991.vda@port.imtp.ilyichevsk.odessa.ua> <200504191054.46330.vda@ilport.com.ua> <20050419174052.GH23013@shell0.pdx.osdl.net>
In-Reply-To: <20050419174052.GH23013@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504200915.58154.vda@ilport.com.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending to lkml for wider audience]

> > > modprobe tcrypt hangs the box on both kernels.
> > > The last printks are:
> > > 
> > > <wp256 test runs ok>
> > > 
> > > testing wp384
> > > NN<n>Unable to handle kernel paging request at virtual address eXXXXXXX
> > > 
> > > Nothing is printed after this and system locks up solid.
> > > No Sysrq-B.
> > > 
> > > IIRC, 2.6.9 was okay.
> > 
> > Update: it does not oops on another machine. CPU or .config related,
> > I'll look into it...
> 
> Any update?  This is candidate for -stable fixing if it's an actual bug.

Yes. wp512_process_buffer() was using 3k of stack if compiled with -O2.
The appenede wp512.c (sans table at top) is instrumented to show it.
Use "make crypto/wp512.s".

The meat of the matter is this:

		L[0]  = C0[BYTE7(K[0])] XEND
		X(L[0]) C1[BYTE6(K[7])] XEND
		X(L[0]) C2[BYTE5(K[6])] XEND
		X(L[0]) C3[BYTE4(K[5])] XEND
		X(L[0]) C4[BYTE3(K[4])] XEND
		X(L[0]) C5[BYTE2(K[3])] XEND
		X(L[0]) C6[BYTE1(K[2])] XEND
		X(L[0]) C7[BYTE0(K[1])] XEND
		X(L[0]) rc[r];

It can be done either as v = c1 ^ c2 ^ c3 ^ c4;
or as v = c1; v ^= c2; v ^= c3; v ^= c4; macros
X and XEND allow to test both ways.

gcc 3.2.3 (IIRC, the box is at home) eats
~3k of stack for first method. gcc 3.4.1
seems to do better, but gcc 3.2.3 is in wide
use.

There is more.

#define BYTE7(v) ((u8)((v) >> 56))
gcc produce full u32 load, shift and zero extend
for this one.

#define BYTE7(v) (((u8*)&v)[7])
gcc does simple byte load.

There is even more.

#define BYTE3(v) ((u8)((u32)(v) >> 24))
                       ^^^^^
Without this, gcc produces:
        shrdl   $8, %edx, %eax <=== not needed
        andl    $255, %eax

This is all seen on i386 only. I expect this to be different
on each arch.

I'd like to generate good code, yet without heavy tailoring
for gcc versions and CPU architectures.

What shall I do?
--
vda

/**
 * The core Whirlpool transform.
 */

static void wp512_process_buffer(struct wp512_ctx *wctx) {
	int i, r;
	u64 K[8];        /* the round key */
	u64 block[8];    /* mu(buffer) */
	u64 state[8];    /* the cipher state */
	u64 L[8];

	for (i = 0; i < 8; i++) {
		block[i] = be64_to_cpu( ((__be64*)wctx->buffer)[i] );
	}

	state[0] = block[0] ^ (K[0] = wctx->hash[0]);
	state[1] = block[1] ^ (K[1] = wctx->hash[1]);
	state[2] = block[2] ^ (K[2] = wctx->hash[2]);
	state[3] = block[3] ^ (K[3] = wctx->hash[3]);
	state[4] = block[4] ^ (K[4] = wctx->hash[4]);
	state[5] = block[5] ^ (K[5] = wctx->hash[5]);
	state[6] = block[6] ^ (K[6] = wctx->hash[6]);
	state[7] = block[7] ^ (K[7] = wctx->hash[7]);


// gcc optimizer bug: first method is noticeably
// worse than second: loads full u32, shifts and
// zero-extends low u8 to u32
#if 0
 #define BYTE7(v) ((u8)((v) >> 56))
 #define BYTE6(v) ((u8)((v) >> 48))
 #define BYTE5(v) ((u8)((v) >> 40))
 #define BYTE4(v) ((u8)((v) >> 32))
 // gcc optimizer bug: without (u32) below will emit
 // spurious shrd insns
 #define BYTE3(v) ((u8)((u32)(v) >> 24))
 #define BYTE2(v) ((u8)((u32)(v) >> 16))
 #define BYTE1(v) ((u8)((u32)(v) >>  8))
 #define BYTE0(v) ((u8)(v))
#else
// little-endian
 #define BYTE7(v) (((u8*)&v)[7])
 #define BYTE6(v) (((u8*)&v)[6])
 #define BYTE5(v) (((u8*)&v)[5])
 #define BYTE4(v) (((u8*)&v)[4])
 #define BYTE3(v) (((u8*)&v)[3])
 #define BYTE2(v) (((u8*)&v)[2])
 #define BYTE1(v) (((u8*)&v)[1])
 #define BYTE0(v) (((u8*)&v)[0])
#endif

// gcc -O2 optimizer bug: second method
// causes excessive spills (~3K stack used)
#if 1
 #define X(a) a ^=
 #define XEND ;
#else
 #define X(a) ^
 #define XEND
#endif
	for (r = 1; r <= WHIRLPOOL_ROUNDS; r++) {
asm("#1");
		L[0]  = C0[BYTE7(K[0])] XEND
		X(L[0]) C1[BYTE6(K[7])] XEND
		X(L[0]) C2[BYTE5(K[6])] XEND
		X(L[0]) C3[BYTE4(K[5])] XEND
		X(L[0]) C4[BYTE3(K[4])] XEND
		X(L[0]) C5[BYTE2(K[3])] XEND
		X(L[0]) C6[BYTE1(K[2])] XEND
		X(L[0]) C7[BYTE0(K[1])] XEND
		X(L[0]) rc[r];
asm("#2");

		L[1]  = C0[BYTE7(K[1])] XEND
		X(L[1]) C1[BYTE6(K[0])] XEND
		X(L[1]) C2[BYTE5(K[7])] XEND
		X(L[1]) C3[BYTE4(K[6])] XEND
		X(L[1]) C4[BYTE3(K[5])] XEND
		X(L[1]) C5[BYTE2(K[4])] XEND
		X(L[1]) C6[BYTE1(K[3])] XEND
		X(L[1]) C7[BYTE0(K[2])];

		L[2]  = C0[BYTE7(K[2])] XEND
		X(L[2]) C1[BYTE6(K[1])] XEND
		X(L[2]) C2[BYTE5(K[0])] XEND
		X(L[2]) C3[BYTE4(K[7])] XEND
		X(L[2]) C4[BYTE3(K[6])] XEND
		X(L[2]) C5[BYTE2(K[5])] XEND
		X(L[2]) C6[BYTE1(K[4])] XEND
		X(L[2]) C7[BYTE0(K[3])];

		L[3]  = C0[BYTE7(K[3])] XEND
		X(L[3]) C1[BYTE6(K[2])] XEND
		X(L[3]) C2[BYTE5(K[1])] XEND
		X(L[3]) C3[BYTE4(K[0])] XEND
		X(L[3]) C4[BYTE3(K[7])] XEND
		X(L[3]) C5[BYTE2(K[6])] XEND
		X(L[3]) C6[BYTE1(K[5])] XEND
		X(L[3]) C7[BYTE0(K[4])];

		L[4]  = C0[BYTE7(K[4])] XEND
		X(L[4]) C1[BYTE6(K[3])] XEND
		X(L[4]) C2[BYTE5(K[2])] XEND
		X(L[4]) C3[BYTE4(K[1])] XEND
		X(L[4]) C4[BYTE3(K[0])] XEND
		X(L[4]) C5[BYTE2(K[7])] XEND
		X(L[4]) C6[BYTE1(K[6])] XEND
		X(L[4]) C7[BYTE0(K[5])];

		L[5]  = C0[BYTE7(K[5])] XEND
		X(L[5]) C1[BYTE6(K[4])] XEND
		X(L[5]) C2[BYTE5(K[3])] XEND
		X(L[5]) C3[BYTE4(K[2])] XEND
		X(L[5]) C4[BYTE3(K[1])] XEND
		X(L[5]) C5[BYTE2(K[0])] XEND
		X(L[5]) C6[BYTE1(K[7])] XEND
		X(L[5]) C7[BYTE0(K[6])];

		L[6]  = C0[BYTE7(K[6])] XEND
		X(L[6]) C1[BYTE6(K[5])] XEND
		X(L[6]) C2[BYTE5(K[4])] XEND
		X(L[6]) C3[BYTE4(K[3])] XEND
		X(L[6]) C4[BYTE3(K[2])] XEND
		X(L[6]) C5[BYTE2(K[1])] XEND
		X(L[6]) C6[BYTE1(K[0])] XEND
		X(L[6]) C7[BYTE0(K[7])];

		L[7]  = C0[BYTE7(K[7])] XEND
		X(L[7]) C1[BYTE6(K[6])] XEND
		X(L[7]) C2[BYTE5(K[5])] XEND
		X(L[7]) C3[BYTE4(K[4])] XEND
		X(L[7]) C4[BYTE3(K[3])] XEND
		X(L[7]) C5[BYTE2(K[2])] XEND
		X(L[7]) C6[BYTE1(K[1])] XEND
		X(L[7]) C7[BYTE0(K[0])];

		K[0] = L[0];
		K[1] = L[1];
		K[2] = L[2];
		K[3] = L[3];
		K[4] = L[4];
		K[5] = L[5];
		K[6] = L[6];
		K[7] = L[7];

		L[0]  = C0[BYTE7(state[0])] XEND
		X(L[0]) C1[BYTE6(state[7])] XEND
		X(L[0]) C2[BYTE5(state[6])] XEND
		X(L[0]) C3[BYTE4(state[5])] XEND
		X(L[0]) C4[BYTE3(state[4])] XEND
		X(L[0]) C5[BYTE2(state[3])] XEND
		X(L[0]) C6[BYTE1(state[2])] XEND
		X(L[0]) C7[BYTE0(state[1])] XEND
		X(L[0]) K[0];

		L[1]  = C0[BYTE7(state[1])] XEND
		X(L[1]) C1[BYTE6(state[0])] XEND
		X(L[1]) C2[BYTE5(state[7])] XEND
		X(L[1]) C3[BYTE4(state[6])] XEND
		X(L[1]) C4[BYTE3(state[5])] XEND
		X(L[1]) C5[BYTE2(state[4])] XEND
		X(L[1]) C6[BYTE1(state[3])] XEND
		X(L[1]) C7[BYTE0(state[2])] XEND
		X(L[1]) K[1];

		L[2]  = C0[BYTE7(state[2])] XEND
		X(L[2]) C1[BYTE6(state[1])] XEND
		X(L[2]) C2[BYTE5(state[0])] XEND
		X(L[2]) C3[BYTE4(state[7])] XEND
		X(L[2]) C4[BYTE3(state[6])] XEND
		X(L[2]) C5[BYTE2(state[5])] XEND
		X(L[2]) C6[BYTE1(state[4])] XEND
		X(L[2]) C7[BYTE0(state[3])] XEND
		X(L[2]) K[2];

		L[3]  = C0[BYTE7(state[3])] XEND
		X(L[3]) C1[BYTE6(state[2])] XEND
		X(L[3]) C2[BYTE5(state[1])] XEND
		X(L[3]) C3[BYTE4(state[0])] XEND
		X(L[3]) C4[BYTE3(state[7])] XEND
		X(L[3]) C5[BYTE2(state[6])] XEND
		X(L[3]) C6[BYTE1(state[5])] XEND
		X(L[3]) C7[BYTE0(state[4])] XEND
		X(L[3]) K[3];

		L[4]  = C0[BYTE7(state[4])] XEND
		X(L[4]) C1[BYTE6(state[3])] XEND
		X(L[4]) C2[BYTE5(state[2])] XEND
		X(L[4]) C3[BYTE4(state[1])] XEND
		X(L[4]) C4[BYTE3(state[0])] XEND
		X(L[4]) C5[BYTE2(state[7])] XEND
		X(L[4]) C6[BYTE1(state[6])] XEND
		X(L[4]) C7[BYTE0(state[5])] XEND
		X(L[4]) K[4];

		L[5]  = C0[BYTE7(state[5])] XEND
		X(L[5]) C1[BYTE6(state[4])] XEND
		X(L[5]) C2[BYTE5(state[3])] XEND
		X(L[5]) C3[BYTE4(state[2])] XEND
		X(L[5]) C4[BYTE3(state[1])] XEND
		X(L[5]) C5[BYTE2(state[0])] XEND
		X(L[5]) C6[BYTE1(state[7])] XEND
		X(L[5]) C7[BYTE0(state[6])] XEND
		X(L[5]) K[5];

		L[6]  = C0[BYTE7(state[6])] XEND
		X(L[6]) C1[BYTE6(state[5])] XEND
		X(L[6]) C2[BYTE5(state[4])] XEND
		X(L[6]) C3[BYTE4(state[3])] XEND
		X(L[6]) C4[BYTE3(state[2])] XEND
		X(L[6]) C5[BYTE2(state[1])] XEND
		X(L[6]) C6[BYTE1(state[0])] XEND
		X(L[6]) C7[BYTE0(state[7])] XEND
		X(L[6]) K[6];

		L[7]  = C0[BYTE7(state[7])] XEND
		X(L[7]) C1[BYTE6(state[6])] XEND
		X(L[7]) C2[BYTE5(state[5])] XEND
		X(L[7]) C3[BYTE4(state[4])] XEND
		X(L[7]) C4[BYTE3(state[3])] XEND
		X(L[7]) C5[BYTE2(state[2])] XEND
		X(L[7]) C6[BYTE1(state[1])] XEND
		X(L[7]) C7[BYTE0(state[0])] XEND
		X(L[7]) K[7];

		state[0] = L[0];
		state[1] = L[1];
		state[2] = L[2];
		state[3] = L[3];
		state[4] = L[4];
		state[5] = L[5];
		state[6] = L[6];
		state[7] = L[7];
	}
	/*
	* apply the Miyaguchi-Preneel compression function:
	*/
	wctx->hash[0] ^= state[0] ^ block[0];
	wctx->hash[1] ^= state[1] ^ block[1];
	wctx->hash[2] ^= state[2] ^ block[2];
	wctx->hash[3] ^= state[3] ^ block[3];
	wctx->hash[4] ^= state[4] ^ block[4];
	wctx->hash[5] ^= state[5] ^ block[5];
	wctx->hash[6] ^= state[6] ^ block[6];
	wctx->hash[7] ^= state[7] ^ block[7];
}

static void wp512_init(void *ctx) {
	int i;
	struct wp512_ctx *wctx = ctx;

	memset(wctx->bitLength, 0, 32);
	wctx->bufferBits = wctx->bufferPos = 0;
	wctx->buffer[0] = 0;
	for (i = 0; i < 8; i++) {
		wctx->hash[i] = 0L;
	}
}

static void wp512_update(void *ctx, const u8 *source, unsigned int len)
{

	struct wp512_ctx *wctx = ctx;
	int sourcePos    = 0;
	unsigned int bits_len = len * 8; // convert to number of bits
	int sourceGap    = (8 - ((int)bits_len & 7)) & 7;
	int bufferRem    = wctx->bufferBits & 7;
	int i;
	u32 b, carry;
	u8 *buffer       = wctx->buffer;
	u8 *bitLength    = wctx->bitLength;
	int bufferBits   = wctx->bufferBits;
	int bufferPos    = wctx->bufferPos;

	u64 value = bits_len;
	for (i = 31, carry = 0; i >= 0 && (carry != 0 || value != 0ULL); i--) {
		carry += bitLength[i] + ((u32)value & 0xff);
		bitLength[i] = (u8)carry;
		carry >>= 8;
		value >>= 8;
	}
	while (bits_len > 8) {
		b = ((source[sourcePos] << sourceGap) & 0xff) |
		((source[sourcePos + 1] & 0xff) >> (8 - sourceGap));
		buffer[bufferPos++] |= (u8)(b >> bufferRem);
		bufferBits += 8 - bufferRem;
		if (bufferBits == WP512_BLOCK_SIZE * 8) {
			wp512_process_buffer(wctx);
			bufferBits = bufferPos = 0;
		}
		buffer[bufferPos] = b << (8 - bufferRem);
		bufferBits += bufferRem;
		bits_len -= 8;
		sourcePos++;
	}
	if (bits_len > 0) {
		b = (source[sourcePos] << sourceGap) & 0xff;
		buffer[bufferPos] |= b >> bufferRem;
	} else {
		b = 0;
	}
	if (bufferRem + bits_len < 8) {
		bufferBits += bits_len;
	} else {
		bufferPos++;
		bufferBits += 8 - bufferRem;
		bits_len -= 8 - bufferRem;
		if (bufferBits == WP512_BLOCK_SIZE * 8) {
			wp512_process_buffer(wctx);
			bufferBits = bufferPos = 0;
		}
		buffer[bufferPos] = b << (8 - bufferRem);
		bufferBits += (int)bits_len;
	}

	wctx->bufferBits   = bufferBits;
	wctx->bufferPos    = bufferPos;
}

static void wp512_final(void *ctx, u8 *out)
{
	struct wp512_ctx *wctx = ctx;
	int i;
   	u8 *buffer      = wctx->buffer;
   	u8 *bitLength   = wctx->bitLength;
   	int bufferBits  = wctx->bufferBits;
   	int bufferPos   = wctx->bufferPos;

   	buffer[bufferPos] |= 0x80U >> (bufferBits & 7);
   	bufferPos++;
   	if (bufferPos > WP512_BLOCK_SIZE - WP512_LENGTHBYTES) {
   		if (bufferPos < WP512_BLOCK_SIZE) {
	   	memset(&buffer[bufferPos], 0, WP512_BLOCK_SIZE - bufferPos);
   		}
   		wp512_process_buffer(wctx);
   		bufferPos = 0;
   	}
   	if (bufferPos < WP512_BLOCK_SIZE - WP512_LENGTHBYTES) {
   		memset(&buffer[bufferPos], 0,
			  (WP512_BLOCK_SIZE - WP512_LENGTHBYTES) - bufferPos);
   	}
   	bufferPos = WP512_BLOCK_SIZE - WP512_LENGTHBYTES;
   	memcpy(&buffer[WP512_BLOCK_SIZE - WP512_LENGTHBYTES],
		   bitLength, WP512_LENGTHBYTES);
   	wp512_process_buffer(wctx);
   	for (i = 0; i < WP512_DIGEST_SIZE/8; i++) {
		((__be64*)out)[i] = cpu_to_be64(wctx->hash[i]);
   	}
   	wctx->bufferBits   = bufferBits;
   	wctx->bufferPos    = bufferPos;
}

static void wp384_final(void *ctx, u8 *out)
{
	struct wp512_ctx *wctx = ctx;
	u8 D[64];

	wp512_final (wctx, D);
	memcpy (out, D, WP384_DIGEST_SIZE);
	memset (D, 0, WP512_DIGEST_SIZE);
}

static void wp256_final(void *ctx, u8 *out)
{
	struct wp512_ctx *wctx = ctx;
	u8 D[64];

	wp512_final (wctx, D);
	memcpy (out, D, WP256_DIGEST_SIZE);
	memset (D, 0, WP512_DIGEST_SIZE);
}

static struct crypto_alg wp512 = {
	.cra_name	=	"wp512",
	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
	.cra_blocksize	=	WP512_BLOCK_SIZE,
	.cra_ctxsize	=	sizeof(struct wp512_ctx),
	.cra_module	=	THIS_MODULE,
	.cra_list       =       LIST_HEAD_INIT(wp512.cra_list),	
	.cra_u		=	{ .digest = {
	.dia_digestsize	=	WP512_DIGEST_SIZE,
	.dia_init   	= 	wp512_init,
	.dia_update 	=	wp512_update,
	.dia_final  	=	wp512_final } }
};

static struct crypto_alg wp384 = {
	.cra_name	=	"wp384",
	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
	.cra_blocksize	=	WP512_BLOCK_SIZE,
	.cra_ctxsize	=	sizeof(struct wp512_ctx),
	.cra_module	=	THIS_MODULE,
	.cra_list       =       LIST_HEAD_INIT(wp384.cra_list),	
	.cra_u		=	{ .digest = {
	.dia_digestsize	=	WP384_DIGEST_SIZE,
	.dia_init   	= 	wp512_init,
	.dia_update 	=	wp512_update,
	.dia_final  	=	wp384_final } }
};

static struct crypto_alg wp256 = {
	.cra_name	=	"wp256",
	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
	.cra_blocksize	=	WP512_BLOCK_SIZE,
	.cra_ctxsize	=	sizeof(struct wp512_ctx),
	.cra_module	=	THIS_MODULE,
	.cra_list       =       LIST_HEAD_INIT(wp256.cra_list),
	.cra_u		=	{ .digest = {
	.dia_digestsize	=	WP256_DIGEST_SIZE,
	.dia_init   	= 	wp512_init,
	.dia_update 	=	wp512_update,
	.dia_final  	=	wp256_final } }
};

static int __init init(void)
{
	int ret = 0;

	ret = crypto_register_alg(&wp512);

	if (ret < 0)
		goto out;

	ret = crypto_register_alg(&wp384);
	if (ret < 0)
	{
		crypto_unregister_alg(&wp512);
		goto out;
	}

	ret = crypto_register_alg(&wp256);
	if (ret < 0)
	{
		crypto_unregister_alg(&wp512);
		crypto_unregister_alg(&wp384);
	}
out:
	return ret;
}

static void __exit fini(void)
{
	crypto_unregister_alg(&wp512);
	crypto_unregister_alg(&wp384);
	crypto_unregister_alg(&wp256);
}

MODULE_ALIAS("wp384");
MODULE_ALIAS("wp256");

module_init(init);
module_exit(fini);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Whirlpool Message Digest Algorithm");

