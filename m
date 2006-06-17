Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWFQKit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWFQKit (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWFQKit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:38:49 -0400
Received: from mout0.freenet.de ([194.97.50.131]:1240 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751527AbWFQKir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:38:47 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Sat, 17 Jun 2006 12:38:44 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
References: <200606041516.46920.jfritschi@freenet.de>
In-Reply-To: <200606041516.46920.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606171238.44468.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After recieving some more feedback from linux@horizon.com, i have revised my
patch a bit and done some cosmetic changes. The first_round macros are now 
eliminated reducing the patchsize.

Correctness was verified with the tcrypt module and automated test scripts.
 
Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

diff -uprN linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/Makefile linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/Makefile
--- linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/Makefile	2006-06-11 16:03:17.716764337 +0200
+++ linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/Makefile	2006-06-11 16:11:41.279630413 +0200
@@ -5,5 +5,8 @@
 # 
 
 obj-$(CONFIG_CRYPTO_AES_X86_64) += aes-x86_64.o
+obj-$(CONFIG_CRYPTO_TWOFISH_X86_64) += twofish-x86_64.o
 
 aes-x86_64-y := aes-x86_64-asm.o aes.o
+twofish-x86_64-y := twofish-x86_64-asm.o twofish.o
+
diff -uprN linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish.c linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish.c
--- linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish.c	2006-06-11 16:10:49.426288180 +0200
@@ -0,0 +1,86 @@
+/*
+ * Glue Code for optimized x86_64 assembler version of TWOFISH
+ *
+ * Originally Twofish for GPG
+ * By Matthew Skala <mskala@ansuz.sooke.bc.ca>, July 26, 1998
+ * 256-bit key length added March 20, 1999
+ * Some modifications to reduce the text size by Werner Koch, April, 1998
+ * Ported to the kerneli patch by Marc Mutz <Marc@Mutz.com>
+ * Ported to CryptoAPI by Colin Slater <hoho@tacomeat.net>
+ *
+ * The original author has disclaimed all copyright interest in this
+ * code and thus put it in the public domain. The subsequent authors
+ * have put this under the GNU General Public License.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * This code is a "clean room" implementation, written from the paper
+ * _Twofish: A 128-Bit Block Cipher_ by Bruce Schneier, John Kelsey,
+ * Doug Whiting, David Wagner, Chris Hall, and Niels Ferguson, available
+ * through http://www.counterpane.com/twofish.html
+ *
+ * For background information on multiplication in finite fields, used for
+ * the matrix operations in the key schedule, see the book _Contemporary
+ * Abstract Algebra_ by Joseph A. Gallian, especially chapter 22 in the
+ * Third Edition.
+ */
+
+#include <asm/byteorder.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/crypto.h>
+#include <linux/bitops.h>
+#include <crypto/twofish.h>
+
+asmlinkage void twofish_enc_blk(void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void twofish_dec_blk(void *ctx, u8 *dst, const u8 *src);
+
+static struct crypto_alg alg = {
+	.cra_name           =   "twofish",
+	.cra_driver_name    =	"twofish-x86_64",
+	.cra_priority       =	200,
+	.cra_flags          =   CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize      =   TF_BLOCK_SIZE,
+	.cra_ctxsize        =   sizeof(struct twofish_ctx),
+	.cra_alignmask      =	3,
+	.cra_module         =   THIS_MODULE,
+	.cra_list           =   LIST_HEAD_INIT(alg.cra_list),
+	.cra_u              =   { .cipher = {
+	.cia_min_keysize    =   TF_MIN_KEY_SIZE,
+	.cia_max_keysize    =   TF_MAX_KEY_SIZE,
+	.cia_setkey         =   twofish_setkey,
+	.cia_encrypt        =   twofish_enc_blk,
+	.cia_decrypt        =   twofish_dec_blk } }
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
+MODULE_DESCRIPTION ("Twofish Cipher Algorithm, x86_64 asm optimized");
diff -uprN linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish-x86_64-asm.S linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish-x86_64-asm.S
--- linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish-x86_64-asm.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish-x86_64-asm.S	2006-06-17 12:34:00.038152154 +0200
@@ -0,0 +1,321 @@
+/***************************************************************************
+*   Copyright (C) 2006 by Joachim Fritschi, <jfritschi@freenet.de>        *
+*                                                                         *
+*   This program is free software; you can redistribute it and/or modify  *
+*   it under the terms of the GNU General Public License as published by  *
+*   the Free Software Foundation; either version 2 of the License, or     *
+*   (at your option) any later version.                                   *
+*                                                                         *
+*   This program is distributed in the hope that it will be useful,       *
+*   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
+*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
+*   GNU General Public License for more details.                          *
+*                                                                         *
+*   You should have received a copy of the GNU General Public License     *
+*   along with this program; if not, write to the                         *
+*   Free Software Foundation, Inc.,                                       *
+*   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
+***************************************************************************/
+
+.file "twofish-x86_64-asm.S"
+.text
+
+#define a_offset	0
+#define b_offset	4
+#define c_offset	8
+#define d_offset	12
+
+/* Structure of the crypto context struct*/
+
+#define s0	0	/* S0 Array 256 Words each */
+#define s1	1024	/* S1 Array */
+#define s2	2048	/* S2 Array */
+#define s3	3072	/* S3 Array */
+#define w	4096	/* 8 whitening keys (word) */
+#define k	4128	/* key 1-32 ( word ) */
+
+/* define a few register aliases to allow macro substitution */
+
+#define R0     %rax
+#define R0D    %eax
+#define R0B    %al
+#define R0H    %ah
+
+#define R1     %rbx
+#define R1D    %ebx
+#define R1B    %bl
+#define R1H    %bh
+
+#define R2     %rcx
+#define R2D    %ecx
+#define R2B    %cl
+#define R2H    %ch
+
+#define R3     %rdx
+#define R3D    %edx
+#define R3B    %dl
+#define R3H    %dh
+
+
+/* performs input whitening */
+#define input_whitening(src,context,offset)\
+	xor	w+offset(context),	src;
+
+/* performs input whitening */
+#define output_whitening(src,context,offset)\
+	xor	w+16+offset(context),	src;
+
+
+/*
+a input register containing a (rotated 16)
+b input register containing b
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+*/
+#define encrypt_round(a,b,c,d,round)\
+movzx	b ## B,		%edi;\
+mov	s1(%r11,%rdi,4),%r8d;\
+movzx	a ## B,		%edi;\
+mov	s2(%r11,%rdi,4),%r9d;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	s2(%r11,%rdi,4),%r8d;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s3(%r11,%rdi,4),%r9d;\
+movzx	b ## B,		%edi;\
+xor	s3(%r11,%rdi,4),%r8d;\
+movzx	a ## B,		%edi;\
+xor	(%r11,%rdi,4),	%r9d;\
+movzx	b ## H,		%edi;\
+ror	$15,		b ## D;\
+xor	(%r11,%rdi,4),	%r8d;\
+movzx	a ## H,		%edi;\
+xor	s1(%r11,%rdi,4),%r9d;\
+add	%r8d,		%r9d;\
+add	%r9d,		%r8d;\
+add	k+round(%r11),	%r9d;\
+xor	%r9d,		c ## D;\
+rol	$15,		c ## D;\
+add	k+4+round(%r11),%r8d;\
+xor	%r8d,		d ## D;
+
+/*
+a input register containing a(rotated 16)
+b input register containing b
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+during the round a and b are prepared for the output whitening
+*/
+#define encrypt_last_round(a,b,c,d,round)\
+mov	b ## D,		%r10d;\
+shl	$32,		%r10;\
+movzx	b ## B,		%edi;\
+mov	s1(%r11,%rdi,4),%r8d;\
+movzx	a ## B,		%edi;\
+mov	s2(%r11,%rdi,4),%r9d;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	s2(%r11,%rdi,4),%r8d;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s3(%r11,%rdi,4),%r9d;\
+movzx	b ## B,		%edi;\
+xor	s3(%r11,%rdi,4),%r8d;\
+movzx	a ## B,		%edi;\
+xor	(%r11,%rdi,4),	%r9d;\
+xor	a,		%r10;\
+movzx	b ## H,		%edi;\
+xor	(%r11,%rdi,4),	%r8d;\
+movzx	a ## H,		%edi;\
+xor	s1(%r11,%rdi,4),%r9d;\
+add	%r8d,		%r9d;\
+add	%r9d,		%r8d;\
+add	k+round(%r11),	%r9d;\
+xor	%r9d,		c ## D;\
+ror	$1,		c ## D;\
+add	k+4+round(%r11),%r8d;\
+xor	%r8d,		d ## D
+
+/*
+a input register containing a
+b input register containing b (rotated 16)
+c input register containing c (already rol $1)
+d input register containing d 
+operations on a and b are interleaved to increase performance
+*/
+#define decrypt_round(a,b,c,d,round)\
+movzx	a ## B,		%edi;\
+mov	(%r11,%rdi,4),	%r9d;\
+movzx	b ## B,		%edi;\
+mov	s3(%r11,%rdi,4),%r8d;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s1(%r11,%rdi,4),%r9d;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	(%r11,%rdi,4),	%r8d;\
+movzx	a ## B,		%edi;\
+xor	s2(%r11,%rdi,4),%r9d;\
+movzx	b ## B,		%edi;\
+xor	s1(%r11,%rdi,4),%r8d;\
+movzx	a ## H,		%edi;\
+ror	$15,		a ## D;\
+xor	s3(%r11,%rdi,4),%r9d;\
+movzx	b ## H,		%edi;\
+xor	s2(%r11,%rdi,4),%r8d;\
+add	%r8d,		%r9d;\
+add	%r9d,		%r8d;\
+add	k+round(%r11),	%r9d;\
+xor	%r9d,		c ## D;\
+add	k+4+round(%r11),%r8d;\
+xor	%r8d,		d ## D;\
+rol	$15,		d ## D;
+
+/*
+a input register containing a
+b input register containing b
+c input register containing c (already rol $1)
+d input register containing d
+operations on a and b are interleaved to increase performance
+during the round a and b are prepared for the output whitening
+*/
+#define decrypt_last_round(a,b,c,d,round)\
+movzx	a ## B,		%edi;\
+mov	(%r11,%rdi,4),	%r9d;\
+movzx	b ## B,		%edi;\
+mov	s3(%r11,%rdi,4),%r8d;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	(%r11,%rdi,4),	%r8d;\
+movzx	a ## H,		%edi;\
+mov	b ## D,		%r10d;\
+shl	$32,		%r10;\
+xor	a,		%r10;\
+ror	$16,		a ## D;\
+xor	s1(%r11,%rdi,4),%r9d;\
+movzx	b ## B,		%edi;\
+xor	s1(%r11,%rdi,4),%r8d;\
+movzx	a ## B,		%edi;\
+xor	s2(%r11,%rdi,4),%r9d;\
+movzx	b ## H,		%edi;\
+xor	s2(%r11,%rdi,4),%r8d;\
+movzx	a ## H,		%edi;\
+xor	s3(%r11,%rdi,4),%r9d;\
+add	%r8d,		%r9d;\
+add	%r9d,		%r8d;\
+add	k+round(%r11),	%r9d;\
+xor	%r9d,		c ## D;\
+add	k+4+round(%r11),%r8d;\
+xor	%r8d,		d ## D;\
+ror	$1,		d ## D;
+
+.align 8
+.global twofish_enc_blk
+.global twofish_dec_blk
+
+twofish_enc_blk:
+	pushq    R1
+
+	/* %rdi contains the crypto ctx adress */
+	/* %rsi contains the output adress */
+	/* %rdx contains the input adress */
+
+	/* ctx adress is moved to free one non-rex register
+	as target for the 8bit high operations */
+	mov	%rdi,		%r11
+
+	movq	(R3),	R1
+	movq	8(R3),	R3
+	input_whitening(R1,%r11,a_offset)
+	input_whitening(R3,%r11,c_offset)
+	mov	R1D,	R0D
+	rol	$16,	R0D
+	shr	$32,	R1
+	mov	R3D,	R2D
+	shr	$32,	R3
+	rol	$1,	R3D
+
+	encrypt_round(R0,R1,R2,R3,0);
+	encrypt_round(R2,R3,R0,R1,8);
+	encrypt_round(R0,R1,R2,R3,2*8);
+	encrypt_round(R2,R3,R0,R1,3*8);
+	encrypt_round(R0,R1,R2,R3,4*8);
+	encrypt_round(R2,R3,R0,R1,5*8);
+	encrypt_round(R0,R1,R2,R3,6*8);
+	encrypt_round(R2,R3,R0,R1,7*8);
+	encrypt_round(R0,R1,R2,R3,8*8);
+	encrypt_round(R2,R3,R0,R1,9*8);
+	encrypt_round(R0,R1,R2,R3,10*8);
+	encrypt_round(R2,R3,R0,R1,11*8);
+	encrypt_round(R0,R1,R2,R3,12*8);
+	encrypt_round(R2,R3,R0,R1,13*8);
+	encrypt_round(R0,R1,R2,R3,14*8);
+	encrypt_last_round(R2,R3,R0,R1,15*8);
+
+
+	output_whitening(%r10,%r11,a_offset)
+	movq	%r10,	(%rsi)
+
+	shl	$32,	R1
+	xor	R0,	R1
+
+	output_whitening(R1,%r11,c_offset)
+	movq	R1,	8(%rsi)
+
+	popq	R1
+	movq	$1,%rax
+	ret
+	
+twofish_dec_blk:	
+	pushq    R1
+
+	/* %rdi contains the crypto ctx adress */
+	/* %rsi contains the output adress */
+	/* %rdx contains the input adress */
+	/* ctx adress is moved to free one non-rex register
+	as target for the 8bit high operations */
+	mov	%rdi,		%r11
+
+	movq	(R3),	R1
+	movq	8(R3),	R3
+	output_whitening(R1,%r11,a_offset)
+	output_whitening(R3,%r11,c_offset)
+	mov	R1D,	R0D
+	shr	$32,	R1
+	rol	$16,	R1D
+	mov	R3D,	R2D
+	shr	$32,	R3
+	rol	$1,	R2D
+
+	decrypt_round(R0,R1,R2,R3,15*8);
+	decrypt_round(R2,R3,R0,R1,14*8);
+	decrypt_round(R0,R1,R2,R3,13*8);
+	decrypt_round(R2,R3,R0,R1,12*8);
+	decrypt_round(R0,R1,R2,R3,11*8);
+	decrypt_round(R2,R3,R0,R1,10*8);
+	decrypt_round(R0,R1,R2,R3,9*8);
+	decrypt_round(R2,R3,R0,R1,8*8);
+	decrypt_round(R0,R1,R2,R3,7*8);
+	decrypt_round(R2,R3,R0,R1,6*8);
+	decrypt_round(R0,R1,R2,R3,5*8);
+	decrypt_round(R2,R3,R0,R1,4*8);
+	decrypt_round(R0,R1,R2,R3,3*8);
+	decrypt_round(R2,R3,R0,R1,2*8);
+	decrypt_round(R0,R1,R2,R3,1*8);
+	decrypt_last_round(R2,R3,R0,R1,0);
+
+	input_whitening(%r10,%r11,a_offset)
+	movq	%r10,	(%rsi)
+
+	shl	$32,	R1
+	xor	R0,	R1
+
+	input_whitening(R1,%r11,c_offset)
+	movq	R1,	8(%rsi)
+
+	popq	R1
+	movq	$1,%rax
+	ret
diff -uprN linux-2.6.17-rc5.twofish3/crypto/Kconfig linux-2.6.17-rc5.twofish4/crypto/Kconfig
--- linux-2.6.17-rc5.twofish3/crypto/Kconfig	2006-06-11 16:05:19.938782275 +0200
+++ linux-2.6.17-rc5.twofish4/crypto/Kconfig	2006-06-11 16:11:17.126755733 +0200
@@ -165,6 +165,21 @@ config CRYPTO_TWOFISH_586
 	  See also:
 	  <http://www.schneier.com/twofish.html>
 
+config CRYPTO_TWOFISH_X86_64
+        tristate "Twofish cipher algorithm (x86_64)"
+        depends on CRYPTO && ((X86 || UML_X86) && 64BIT)
+        select CRYPTO_TWOFISH_COMMON
+	help
+          Twofish cipher algorithm (x86_64).
+
+          Twofish was submitted as an AES (Advanced Encryption Standard)
+          candidate cipher by researchers at CounterPane Systems.  It is a
+          16 round block cipher supporting key sizes of 128, 192, and 256
+          bits.
+
+          See also:
+          <http://www.schneier.com/twofish.html>
+
 config CRYPTO_SERPENT
 	tristate "Serpent cipher algorithm"
 	depends on CRYPTO

