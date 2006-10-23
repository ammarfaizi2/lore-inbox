Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752031AbWJWVug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbWJWVug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWJWVug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:50:36 -0400
Received: from CHOKECHERRY.SRV.CS.CMU.EDU ([128.2.185.41]:13975 "EHLO
	chokecherry.srv.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1752022AbWJWVue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:50:34 -0400
Date: Mon, 23 Oct 2006 17:50:20 -0400
From: Benjamin Gilbert <bgilbert@cs.cmu.edu>
To: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] x86-optimized SHA1 hash for CryptoAPI
Message-Id: <20061023175020.23fabf00.bgilbert@cs.cmu.edu>
Organization: Carnegie Mellon University
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new CryptoAPI module containing an x86-optimized implementation of
SHA1, taken from Nettle.

On my box (Pentium IV), tcrypt's performance tester reports the following
cycles-per-byte figures (average of 5 trials):

Test#  Bytes/  Bytes/    Unopt       Opt
        block  update cycles/B  cycles/B
    0      16      16      209       150
    1      64      16      130        84
    2      64      64       91        45
    3     256      16       95        69
    4     256      64       53        28
    5     256     256       40        18
    6    1024      16       88        66
    7    1024     256       32        15
    8    1024    1024       28        12
    9    2048      16       91        65
   10    2048     256       36        16
   11    2048    1024       27        12
   12    2048    2048       27        13
   13    4096      16       92        65
   14    4096     256       30        14
   15    4096    1024       27        11
   16    4096    4096       26        11
   17    8192      16       85        65
   18    8192     256       30        14
   19    8192    1024       27        11
   20    8192    4096       26        10
   21    8192    8192       26        10

so the x86-optimized version is more than twice as fast for large updates
and still somewhat faster than the current version for small updates.

Now for my question.  The attached patch is a fairly straightforward port
from the Nettle asm and C code.  However, there are (at least) two other
options:

1.  Recognizing that arch/i386/crypto/sha1.c contains almost the same
functionality as crypto/sha1.c, I could abstract out common code between the
two implementations.  However, given the length of the files in question, I
suspect the complexity isn't worth it.  In-tree, AES uses duplicated code
between the asm and C versions, while Twofish pulls out common code into a
separate module.

2.  Since the optimized part of the code is the SHA1 compression function,
and since crypto/sha1.c is just a wrapper around the compression function in
lib/sha1.c, I could eliminate the separate CryptoAPI module and switch the
kernel between the C and asm compression functions based on a config option
-- so that all SHA1 users get the optimized version, instead of just
CryptoAPI.  There is an API issue though: the optimized code needs to
allocate its workspace on the stack for register-allocation reasons, and the
C version expects the caller to allocate a temporary buffer (to minimize the
number of times the workspace needs to be cleared when hashing several times
in a row).  If the optimized code was used with the current API, the caller
would be doing a bunch of allocation and clearing for nothing.  (Note: the
only direct users of lib/sha1.c right now are /dev/random and syncookies.)

Which (if any) is the preferred approach?

Suggestions and comments appreciated.

--Benjamin Gilbert

Signed-off-by: Benjamin Gilbert <bgilbert@cs.cmu.edu>
---
 arch/i386/crypto/Makefile        |    2 
 arch/i386/crypto/sha1-i586-asm.S |  330 ++++++++++++++++++++++++++++++++++++++
 arch/i386/crypto/sha1.c          |  161 +++++++++++++++++++
 crypto/Kconfig                   |    8 +
 4 files changed, 501 insertions(+), 0 deletions(-)

diff --git a/arch/i386/crypto/Makefile b/arch/i386/crypto/Makefile
index 3fd19af..8ab8f04 100644
--- a/arch/i386/crypto/Makefile
+++ b/arch/i386/crypto/Makefile
@@ -6,7 +6,9 @@ # 
 
 obj-$(CONFIG_CRYPTO_AES_586) += aes-i586.o
 obj-$(CONFIG_CRYPTO_TWOFISH_586) += twofish-i586.o
+obj-$(CONFIG_CRYPTO_SHA1_586) += sha1-i586.o
 
 aes-i586-y := aes-i586-asm.o aes.o
 twofish-i586-y := twofish-i586-asm.o twofish.o
+sha1-i586-y := sha1-i586-asm.o sha1.o
 
diff --git a/arch/i386/crypto/sha1-i586-asm.S b/arch/i386/crypto/sha1-i586-asm.S
new file mode 100644
index 0000000..77b9cbf
--- /dev/null
+++ b/arch/i386/crypto/sha1-i586-asm.S
@@ -0,0 +1,330 @@
+/*
+ * x86-optimized SHA1 hash algorithm
+ *
+ * Originally from Nettle
+ * Ported from M4 to cpp by Benjamin Gilbert <bgilbert@cs.cmu.edu>
+ *
+ * Copyright (C) 2004, Niels Möller
+ * Copyright (c) 2006 Carnegie Mellon University
+ *
+ * This file is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU Lesser General Public License as published by the
+ * Free Software Foundation; either version 2.1 of the License, or (at your
+ * option) any later version.
+ */
+
+/* Register usage */
+#define SA	%eax
+#define SB	%ebx
+#define SC	%ecx
+#define SD	%edx
+#define SE	%ebp
+#define DATA	%esp
+#define TMP	%edi
+#define TMP2	%esi			/* Used by SWAP and F3 */
+#define TMP3	64(%esp)
+
+/* Constants */
+#define K1VALUE	$0x5A827999		/* Rounds  0-19 */
+#define K2VALUE	$0x6ED9EBA1		/* Rounds 20-39 */
+#define K3VALUE	$0x8F1BBCDC		/* Rounds 40-59 */
+#define K4VALUE	$0xCA62C1D6		/* Rounds 60-79 */
+
+/* Convert stack offsets in words to offsets in bytes */
+#define OFFSET(i) 4*(i)
+
+/* Reads the input via TMP2 into register, byteswaps it, and stores it in
+   the DATA array. */
+#define SWAP(index, register)					\
+	movl	OFFSET(index)(TMP2), register;			\
+	bswap	register;					\
+	movl	register, OFFSET(index)(DATA)
+
+/* Sets the workspace word at the given index to zero. */
+#define CLEAR(index)						\
+	movl	$0, OFFSET(index)(DATA)
+
+/*
+ * expand(i) is the expansion function
+ *
+ *   W[i] = (W[i - 16] ^ W[i - 14] ^ W[i - 8] ^ W[i - 3]) <<< 1
+ *
+ * where W[i] is stored in DATA[i mod 16].
+ *
+ * Result is stored back in W[i], and also left in TMP, the only
+ * register that is used.
+ */
+#define EXPAND(i)						\
+	movl	OFFSET(i % 16)(DATA), TMP;			\
+	xorl	OFFSET((i + 2) % 16)(DATA), TMP;		\
+	xorl	OFFSET((i + 8) % 16)(DATA), TMP;		\
+	xorl	OFFSET((i + 13) % 16)(DATA), TMP;		\
+	roll	$1, TMP;					\
+	movl	TMP, OFFSET(i % 16)(DATA)
+
+/*
+ * The f functions,
+ *
+ *  f1(x,y,z) = z ^ (x & (y ^ z))
+ *  f2(x,y,z) = x ^ y ^ z
+ *  f3(x,y,z) = (x & y) | (z & (x | y))
+ *  f4 = f2
+ *
+ * The macro Fk(x,y,z) computes = fk(x,y,z).
+ * Result is left in TMP.
+ */
+#define F1(x,y,z)						\
+	movl	z, TMP;						\
+	xorl	y, TMP;						\
+	andl	x, TMP;						\
+	xorl	z, TMP
+
+#define F2(x,y,z)						\
+	movl	x, TMP;						\
+	xorl	y, TMP;						\
+	xorl	z, TMP
+
+#define F3(x,y,z)						\
+	movl	x, TMP2;					\
+	andl	y, TMP2;					\
+	movl	x, TMP;						\
+	orl	y, TMP;						\
+	andl	z, TMP;						\
+	orl	TMP2, TMP
+
+/*
+ * The form of one sha1 round is
+ *
+ *   a' = e + a <<< 5 + f( b, c, d ) + k + w;
+ *   b' = a;
+ *   c' = b <<< 30;
+ *   d' = c;
+ *   e' = d;
+ *
+ * where <<< denotes rotation. We permute our variables, so that we
+ * instead get
+ *
+ *   e += a <<< 5 + f( b, c, d ) + k + w;
+ *   b <<<= 30
+ *
+ * Using the TMP register for the rotate could be avoided, by rotating
+ * %a in place, adding, and then rotating back.
+ */
+#define ROUND(a,b,c,d,e,f,k,w)					\
+	addl	k, e;						\
+	addl	w, e;						\
+	f(b,c,d);						\
+	addl	TMP, e;						\
+	movl	a, TMP;						\
+	roll	$5, TMP;					\
+	addl	TMP, e;						\
+	roll	$30, b;
+
+/* sha1_compress(u32 *state, u8 *data) */
+.text
+.align 4
+.globl sha1_compress
+sha1_compress:
+	/* save all registers that need to be saved */
+	pushl	%ebx		/* 80(%esp) */
+	pushl	%ebp		/* 76(%esp) */
+	pushl	%esi		/* 72(%esp) */
+	pushl	%edi		/* 68(%esp) */
+
+	subl	$68, %esp	/* %esp = W */
+
+	/* Load and byteswap data */
+	movl	92(%esp), TMP2
+
+	SWAP( 0, %eax); SWAP( 1, %ebx); SWAP( 2, %ecx); SWAP( 3, %edx)
+	SWAP( 4, %eax); SWAP( 5, %ebx); SWAP( 6, %ecx); SWAP( 7, %edx)
+	SWAP( 8, %eax); SWAP( 9, %ebx); SWAP(10, %ecx); SWAP(11, %edx)
+	SWAP(12, %eax); SWAP(13, %ebx); SWAP(14, %ecx); SWAP(15, %edx)
+
+	/* load the state vector */
+	movl	88(%esp),TMP
+	movl	(TMP),   SA
+	movl	4(TMP),  SB
+	movl	8(TMP),  SC
+	movl	12(TMP), SD
+	movl	16(TMP), SE
+
+	movl	K1VALUE, TMP2
+	ROUND(SA, SB, SC, SD, SE, F1, TMP2, OFFSET( 0)(DATA))
+	ROUND(SE, SA, SB, SC, SD, F1, TMP2, OFFSET( 1)(DATA))
+	ROUND(SD, SE, SA, SB, SC, F1, TMP2, OFFSET( 2)(DATA))
+	ROUND(SC, SD, SE, SA, SB, F1, TMP2, OFFSET( 3)(DATA))
+	ROUND(SB, SC, SD, SE, SA, F1, TMP2, OFFSET( 4)(DATA))
+
+	ROUND(SA, SB, SC, SD, SE, F1, TMP2, OFFSET( 5)(DATA))
+	ROUND(SE, SA, SB, SC, SD, F1, TMP2, OFFSET( 6)(DATA))
+	ROUND(SD, SE, SA, SB, SC, F1, TMP2, OFFSET( 7)(DATA))
+	ROUND(SC, SD, SE, SA, SB, F1, TMP2, OFFSET( 8)(DATA))
+	ROUND(SB, SC, SD, SE, SA, F1, TMP2, OFFSET( 9)(DATA))
+
+	ROUND(SA, SB, SC, SD, SE, F1, TMP2, OFFSET(10)(DATA))
+	ROUND(SE, SA, SB, SC, SD, F1, TMP2, OFFSET(11)(DATA))
+	ROUND(SD, SE, SA, SB, SC, F1, TMP2, OFFSET(12)(DATA))
+	ROUND(SC, SD, SE, SA, SB, F1, TMP2, OFFSET(13)(DATA))
+	ROUND(SB, SC, SD, SE, SA, F1, TMP2, OFFSET(14)(DATA))
+
+	ROUND(SA, SB, SC, SD, SE, F1, TMP2, OFFSET(15)(DATA))
+	EXPAND(16); ROUND(SE, SA, SB, SC, SD, F1, TMP2, TMP)
+	EXPAND(17); ROUND(SD, SE, SA, SB, SC, F1, TMP2, TMP)
+	EXPAND(18); ROUND(SC, SD, SE, SA, SB, F1, TMP2, TMP)
+	EXPAND(19); ROUND(SB, SC, SD, SE, SA, F1, TMP2, TMP)
+
+	/* TMP2 is free to use in these rounds */
+	movl	K2VALUE, TMP2
+	EXPAND(20); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(21); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(22); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(23); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(24); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	EXPAND(25); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(26); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(27); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(28); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(29); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	EXPAND(30); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(31); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(32); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(33); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(34); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	EXPAND(35); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(36); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(37); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(38); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(39); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	/* We have to put this constant on the stack */
+	movl	K3VALUE, TMP3
+	EXPAND(40); ROUND(SA, SB, SC, SD, SE, F3, TMP3, TMP)
+	EXPAND(41); ROUND(SE, SA, SB, SC, SD, F3, TMP3, TMP)
+	EXPAND(42); ROUND(SD, SE, SA, SB, SC, F3, TMP3, TMP)
+	EXPAND(43); ROUND(SC, SD, SE, SA, SB, F3, TMP3, TMP)
+	EXPAND(44); ROUND(SB, SC, SD, SE, SA, F3, TMP3, TMP)
+
+	EXPAND(45); ROUND(SA, SB, SC, SD, SE, F3, TMP3, TMP)
+	EXPAND(46); ROUND(SE, SA, SB, SC, SD, F3, TMP3, TMP)
+	EXPAND(47); ROUND(SD, SE, SA, SB, SC, F3, TMP3, TMP)
+	EXPAND(48); ROUND(SC, SD, SE, SA, SB, F3, TMP3, TMP)
+	EXPAND(49); ROUND(SB, SC, SD, SE, SA, F3, TMP3, TMP)
+
+	EXPAND(50); ROUND(SA, SB, SC, SD, SE, F3, TMP3, TMP)
+	EXPAND(51); ROUND(SE, SA, SB, SC, SD, F3, TMP3, TMP)
+	EXPAND(52); ROUND(SD, SE, SA, SB, SC, F3, TMP3, TMP)
+	EXPAND(53); ROUND(SC, SD, SE, SA, SB, F3, TMP3, TMP)
+	EXPAND(54); ROUND(SB, SC, SD, SE, SA, F3, TMP3, TMP)
+
+	EXPAND(55); ROUND(SA, SB, SC, SD, SE, F3, TMP3, TMP)
+	EXPAND(56); ROUND(SE, SA, SB, SC, SD, F3, TMP3, TMP)
+	EXPAND(57); ROUND(SD, SE, SA, SB, SC, F3, TMP3, TMP)
+	EXPAND(58); ROUND(SC, SD, SE, SA, SB, F3, TMP3, TMP)
+	EXPAND(59); ROUND(SB, SC, SD, SE, SA, F3, TMP3, TMP)
+
+	movl	K4VALUE, TMP2
+	EXPAND(60); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(61); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(62); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(63); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(64); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	EXPAND(65); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(66); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(67); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(68); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(69); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	EXPAND(70); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(71); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(72); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(73); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(74); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	EXPAND(75); ROUND(SA, SB, SC, SD, SE, F2, TMP2, TMP)
+	EXPAND(76); ROUND(SE, SA, SB, SC, SD, F2, TMP2, TMP)
+	EXPAND(77); ROUND(SD, SE, SA, SB, SC, F2, TMP2, TMP)
+	EXPAND(78); ROUND(SC, SD, SE, SA, SB, F2, TMP2, TMP)
+	EXPAND(79); ROUND(SB, SC, SD, SE, SA, F2, TMP2, TMP)
+
+	/* Update the state vector */
+	movl	88(%esp),TMP
+	addl	SA, (TMP)
+	addl	SB, 4(TMP)
+	addl	SC, 8(TMP)
+	addl	SD, 12(TMP)
+	addl	SE, 16(TMP)
+
+	/* Clear the workspace for security */
+	CLEAR( 0); CLEAR( 1); CLEAR( 2); CLEAR( 3);
+	CLEAR( 4); CLEAR( 5); CLEAR( 6); CLEAR( 7);
+	CLEAR( 8); CLEAR( 9); CLEAR(10); CLEAR(11);
+	CLEAR(12); CLEAR(13); CLEAR(14); CLEAR(15);
+
+	addl	$68, %esp
+	popl	%edi
+	popl	%esi
+	popl	%ebp
+	popl	%ebx
+	ret
+
+/*
+ * It's possible to shave of half of the stores to tmp in the evaluation of f3,
+ * although it's probably not worth the effort. This is the trick:
+ *
+ * round(a,b,c,d,e,f,k,w) modifies only b,e.
+ *
+ * round(a,b,c,d,e,f3,k,w)
+ * round(e,a,b,c,d,f3,k,w)
+ *
+ * ; f3(b,c,d) = (b & c) | (d & (b | c))
+ *
+ *   movl b, tmp
+ *   andl c, tmp
+ *   movl tmp, tmp2
+ *   movl b, tmp
+ *   orl  c, tmp
+ *   andl d, tmp
+ *   orl tmp2, tmp
+ *
+ * and corresponding code for f3(a,b,c)
+ *
+ * Use the register allocated for c as a temporary?
+ *
+ *   movl c, tmp2
+ * ; f3(b,c,d) = (b & c) | (d & (b | c))
+ *   movl b, tmp
+ *   orl  c, tmp
+ *   andl b, c
+ *   andl d, tmp
+ *   orl  c, tmp
+ *
+ * ; f3(a,b,c) = (a & b) | (c & (a | b))
+ *   movl b, tmp
+ *   andl a, tmp
+ *   movl a, c
+ *   orl  b, c
+ *   andl tmp2, c
+ *   orl  c, tmp
+ *
+ *   movl tmp2, c
+ *
+ * Before: 14 instr, 2 store, 2 load
+ * After: 13 instr, 1 store, 2 load
+ *
+ * Final load can be folded into the next round,
+ *
+ * round(d,e,a,b,c,f3,k)
+ *
+ *   c += d <<< 5 + f(e, a, b) + k + w
+ *
+ * if we arrange to have w placed directly into the register
+ * corresponding to w. That way we save one more instruction, total save
+ * of two instructions, one of which is a store, per two rounds. For the
+ * twenty rounds involving f3, that's 20 instructions, 10 of which are
+ * stores, or about 1.5 %.
+ */
diff --git a/arch/i386/crypto/sha1.c b/arch/i386/crypto/sha1.c
new file mode 100644
index 0000000..be8658b
--- /dev/null
+++ b/arch/i386/crypto/sha1.c
@@ -0,0 +1,161 @@
+/*
+ * x86-optimized SHA1 hash algorithm
+ *
+ * Originally from Nettle
+ * Ported to CryptoAPI by Benjamin Gilbert <bgilbert@cs.cmu.edu>
+ *
+ * Copyright (C) 2001 Peter Gutmann, Andrew Kuchling, Niels Möller
+ * Copyright (c) 2006 Carnegie Mellon University
+ *
+ * This file is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU Lesser General Public License as published by the
+ * Free Software Foundation; either version 2.1 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/crypto.h>
+
+#define SHA1_DIGEST_SIZE 20
+#define SHA1_DATA_SIZE 64
+
+struct sha1_ctx {
+	u32 digest[SHA1_DIGEST_SIZE / 4];	/* Message digest */
+	u64 count;				/* Blocks processed */
+	u8 block[SHA1_DATA_SIZE];		/* SHA1 data buffer */
+	unsigned int index;			/* index into buffer */
+};
+
+/* Compression function. @state points to 5 u32 words, and @data points to
+   64 bytes of input data, possibly unaligned. */
+asmlinkage void sha1_compress(u32 *state, const u8 *data);
+
+/* Writes a 32-bit integer to an arbitrary pointer in big-endian byte order */
+static inline void write_u32_be(void *ptr, u32 i)
+{
+	u32 *p = ptr;
+	*p = cpu_to_be32(i);
+}
+
+static void sha1_init(struct crypto_tfm *data)
+{
+	struct sha1_ctx *ctx = crypto_tfm_ctx(data);
+
+	/* Set the h-vars to their initial values */
+	ctx->digest[0] = 0x67452301L;
+	ctx->digest[1] = 0xEFCDAB89L;
+	ctx->digest[2] = 0x98BADCFEL;
+	ctx->digest[3] = 0x10325476L;
+	ctx->digest[4] = 0xC3D2E1F0L;
+
+	/* Initialize block count */
+	ctx->count = 0;
+
+	/* Initialize buffer */
+	ctx->index = 0;
+}
+
+static void sha1_update(struct crypto_tfm *data, const u8 *buffer,
+			unsigned length)
+{
+	struct sha1_ctx *ctx = crypto_tfm_ctx(data);
+	if (ctx->index) {
+		/* Try to fill partial block */
+		unsigned left = SHA1_DATA_SIZE - ctx->index;
+		if (length < left) {
+			memcpy(ctx->block + ctx->index, buffer, length);
+			ctx->index += length;
+			return;	/* Finished */
+		} else {
+			memcpy(ctx->block + ctx->index, buffer, left);
+			sha1_compress(ctx->digest, ctx->block);
+			ctx->count++;
+			buffer += left;
+			length -= left;
+		}
+	}
+	while (length >= SHA1_DATA_SIZE) {
+		sha1_compress(ctx->digest, buffer);
+		ctx->count++;
+		buffer += SHA1_DATA_SIZE;
+		length -= SHA1_DATA_SIZE;
+	}
+	if ((ctx->index = length))
+		/* Buffer leftovers */
+		memcpy(ctx->block, buffer, length);
+}
+
+/* Final wrapup - pad to SHA1_DATA_SIZE-byte boundary with the bit pattern
+   1 0* (64-bit count of bits processed, MSB-first) */
+static void sha1_final(struct crypto_tfm *data, u8 *digest)
+{
+	struct sha1_ctx *ctx = crypto_tfm_ctx(data);
+	u64 bitcount;
+	unsigned i = ctx->index;
+
+	/* Set the first char of padding to 0x80.  This is safe since there is
+	   always at least one byte free */
+	BUG_ON(i >= SHA1_DATA_SIZE);
+	ctx->block[i++] = 0x80;
+
+	if (i > (SHA1_DATA_SIZE - 8)) {
+		/* No room for length in this block. Process it and
+		   pad with another one */
+		memset(ctx->block + i, 0, SHA1_DATA_SIZE - i);
+		sha1_compress(ctx->digest, ctx->block);
+		i = 0;
+	}
+	if (i < (SHA1_DATA_SIZE - 8))
+		memset(ctx->block + i, 0, (SHA1_DATA_SIZE - 8) - i);
+
+	/* There are 512 = 2^9 bits in one block */
+	bitcount = (ctx->count << 9) | (ctx->index << 3);
+
+	/* This is slightly inefficient, as the numbers are converted to
+	   big-endian format, and will be converted back by the compression
+	   function. It's probably not worth the effort to fix this. */
+	write_u32_be(ctx->block + (SHA1_DATA_SIZE - 8), bitcount >> 32);
+	write_u32_be(ctx->block + (SHA1_DATA_SIZE - 4), bitcount);
+
+	sha1_compress(ctx->digest, ctx->block);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / 4; i++, digest += 4)
+		write_u32_be(digest, ctx->digest[i]);
+
+	/* Wipe context */
+	memset(ctx, 0, sizeof(*ctx));
+}
+
+static struct crypto_alg alg = {
+	.cra_name	=	"sha1",
+	.cra_driver_name=	"sha1-i586",
+	.cra_priority	=	200,
+	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	=	SHA1_DATA_SIZE,
+	.cra_ctxsize	=	sizeof(struct sha1_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_alignmask	=	3,
+	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{ .digest = {
+	.dia_digestsize	=	SHA1_DIGEST_SIZE,
+	.dia_init	=	sha1_init,
+	.dia_update	=	sha1_update,
+	.dia_final	=	sha1_final } }
+};
+
+static int __init init(void)
+{
+	return crypto_register_alg(&alg);
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("x86-optimized SHA1 hash algorithm");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index cbae839..c4e37b8 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -63,6 +63,14 @@ config CRYPTO_SHA1
 	help
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
+config CRYPTO_SHA1_586
+	tristate "SHA1 digest algorithm (i586)"
+	depends on (X86 || UML_X86) && !64BIT
+	select CRYPTO_ALGAPI
+	help
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).  This is the
+	  i586-optimized version.
+
 config CRYPTO_SHA1_S390
 	tristate "SHA1 digest algorithm (s390)"
 	depends on S390
