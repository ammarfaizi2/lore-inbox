Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWFPMAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWFPMAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWFPMAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:00:00 -0400
Received: from mout0.freenet.de ([194.97.50.131]:6382 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751251AbWFPL76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:59:58 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  3/4] Twofish cipher - i586 assembler
Date: Fri, 16 Jun 2006 13:59:54 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
References: <200606041516.38998.jfritschi@freenet.de> <200606072138.00251.jfritschi@freenet.de>
In-Reply-To: <200606072138.00251.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161359.54603.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update patch for the i586 twofish assembler implementation.

Changes since last version:
-Updated to the new twofish_common setup
-Complete rewrite of the code  according to the feedback i recieved for the
x86_64 patch (thanks linux@horizon.com)

The patch passed the trycpt tests and automated filesystem tests.
This rewrite resulted in some nice perfomance increase over my last patch.

Short summary of the tcrypt benchmarks:

Twofish Assembler vs. Twofish C (256bit 8kb block CBC)
encrypt: -33% Cycles
decrypt: -45% Cycles

Twofish Assembler vs. AES Assembler (128bit 8kb block CBC)
encrypt: +3%  Cycles
decrypt: -22% Cycles

Twofish Assembler vs. AES Assembler (256bit 8kb block CBC)
encrypt: -20% Cycles
decrypt: -36% Cycles

Full Output:
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-twofish-asm-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-twofish-c-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-aes-asm-i586.txt


Here is another bonnie++ benchmark with encrypted filesystems. All runs with
the twofish assembler modules max out the drivespeed. It should give some
idea what the module can do for encrypted filesystem performance even though
you can't see the full numbers.

http://homepages.tu-darmstadt.de/~fritschi/twofish/output_20060611_205432_x86.html


Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

diff -uprN linux-2.6.17-rc5.twofish2/arch/i386/crypto/Makefile linux-2.6.17-rc5.twofish3/arch/i386/crypto/Makefile
--- linux-2.6.17-rc5.twofish2/arch/i386/crypto/Makefile	2006-06-11 15:58:36.991988374 +0200
+++ linux-2.6.17-rc5.twofish3/arch/i386/crypto/Makefile	2006-06-11 16:05:51.675813834 +0200
@@ -5,5 +5,8 @@
 # 
 
 obj-$(CONFIG_CRYPTO_AES_586) += aes-i586.o
+obj-$(CONFIG_CRYPTO_TWOFISH_586) += twofish-i586.o
 
 aes-i586-y := aes-i586-asm.o aes.o
+twofish-i586-y := twofish-i586-asm.o twofish.o
+
diff -uprN linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish.c linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish.c
--- linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish.c	2006-06-11 16:03:56.669852049 +0200
@@ -0,0 +1,88 @@
+/*
+ *  Glue Code for optimized 586 assembler version of TWOFISH
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
+
+asmlinkage void twofish_enc_blk(void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void twofish_dec_blk(void *ctx, u8 *dst, const u8 *src);
+
+
+static struct crypto_alg alg = {
+	.cra_name           =   "twofish",
+	.cra_driver_name    =	"twofish-i586",
+        .cra_priority       =   200,
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
+MODULE_DESCRIPTION ("Twofish Cipher Algorithm, i586 asm optimized");
diff -uprN linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish-i586-asm.S linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish-i586-asm.S
--- linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish-i586-asm.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish-i586-asm.S	2006-06-11 21:49:26.508548778 +0200
@@ -0,0 +1,404 @@
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
+.file "twofish-i586-asm.S"
+.text
+
+/* return adress at 0 */
+
+#define in_blk    12  /* input byte array address parameter*/
+#define out_blk   8  /* output byte array address parameter*/
+#define ctx       4  /* Twofish context structure */
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
+#define R0D    %eax
+#define R0B    %al
+#define R0H    %ah
+
+#define R1D    %ebx
+#define R1B    %bl
+#define R1H    %bh
+
+#define R2D    %ecx
+#define R2B    %cl
+#define R2H    %ch
+
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
+/*
+a input register containing a (rotated 16)
+b input register containing b
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+*/
+#define encrypt_round(a,b,c,d,round)\
+movzx	b ## B,		%edi;\
+mov	s1(%ebp,%edi,4),d ## D;\
+movzx	a ## B,		%edi;\
+mov	s2(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	s2(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s3(%ebp,%edi,4),%esi;\
+movzx	b ## B,		%edi;\
+xor	s3(%ebp,%edi,4),d ## D;\
+movzx	a ## B,		%edi;\
+xor	(%ebp,%edi,4),	%esi;\
+movzx	b ## H,		%edi;\
+ror	$15,		b ## D;\
+xor	(%ebp,%edi,4),	d ## D;\
+movzx	a ## H,		%edi;\
+xor	s1(%ebp,%edi,4),%esi;\
+add	d ## D,		%esi;\
+add	%esi,		d ## D;\
+add	k+round(%ebp),	%esi;\
+pop	%edi;\
+push	b ## D;\
+xor	%esi,		c ## D;\
+rol	$15,		c ## D;\
+add	k+4+round(%ebp),d ## D;\
+xor	%edi,		d ## D;
+
+
+/*
+a input register containing a
+b input register containing b
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+*/
+#define encrypt_first_round(a,b,c,d,round)\
+movzx	a ## B,		%edi;\
+mov	(%ebp,%edi,4),	%esi;\
+movzx	b ## B,		%edi;\
+mov	s1(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s1(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	s2(%ebp,%edi,4),d ## D;\
+movzx	a ## B,		%edi;\
+xor	s2(%ebp,%edi,4),%esi;\
+movzx	b ## B,		%edi;\
+xor	s3(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s3(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$15,		b ## D;\
+xor	(%ebp,%edi,4),	d ## D;\
+pop	%edi;\
+add	d ## D,		%esi;\
+add	%esi,		d ## D;\
+add	k+round(%ebp),	%esi;\
+push	b ## D;\
+xor	%esi,		c ## D;\
+rol	$15,		c ## D;\
+add	k+4+round(%ebp),d ## D;\
+xor	%edi,		d ## D;
+
+#define encrypt_last_round(a,b,c,d,round)\
+movzx	b ## B,		%edi;\
+mov	s1(%ebp,%edi,4),d ## D;\
+movzx	a ## B,		%edi;\
+mov	s2(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	s2(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s3(%ebp,%edi,4),%esi;\
+movzx	b ## B,		%edi;\
+xor	s3(%ebp,%edi,4),d ## D;\
+movzx	a ## B,		%edi;\
+xor	(%ebp,%edi,4),	%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	(%ebp,%edi,4),	d ## D;\
+movzx	a ## H,		%edi;\
+xor	s1(%ebp,%edi,4),%esi;\
+add	d ## D,		%esi;\
+add	%esi,		d ## D;\
+add	k+round(%ebp),	%esi;\
+pop	%edi;\
+xor	%esi,		c ## D;\
+ror	$1,		c ## D;\
+add	k+4+round(%ebp),d ## D;\
+xor	%edi,		d ## D;
+
+/*
+a input register containing a
+b input register containing b (rotated 16)
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+*/
+#define decrypt_round(a,b,c,d,round)\
+movzx	a ## B,		%edi;\
+mov	(%ebp,%edi,4),	%esi;\
+movzx	b ## B,		%edi;\
+mov	s3(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s1(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	(%ebp,%edi,4),	d ## D;\
+movzx	a ## B,		%edi;\
+xor	s2(%ebp,%edi,4),%esi;\
+movzx	b ## B,		%edi;\
+xor	s1(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$15,		a ## D;\
+xor	s3(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+xor	s2(%ebp,%edi,4),d ## D;\
+add	d ## D,		%esi;\
+add	%esi,		d ## D;\
+add	k+4+round(%ebp),d ## D;\
+pop	%edi;\
+push	b ## D;\
+xor	%edi,		d ## D;\
+rol	$15,		d ## D;\
+add	k+round(%ebp),	%esi;\
+xor	%esi,		c ## D;
+
+
+/*
+a input register containing a
+b input register containing b
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+*/
+#define decrypt_first_round(a,b,c,d,round)\
+movzx	a ## B,		%edi;\
+mov	(%ebp,%edi,4),	%esi;\
+movzx	b ## B,		%edi;\
+mov	s1(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s1(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	s2(%ebp,%edi,4),d ## D;\
+movzx	a ## B,		%edi;\
+xor	s2(%ebp,%edi,4),%esi;\
+movzx	b ## B,		%edi;\
+xor	s3(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$15,		a ## D;\
+xor	s3(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	(%ebp,%edi,4),d ## D;\
+pop	%edi;\
+add	d ## D,		%esi;\
+add	%esi,		d ## D;\
+add	k+4+round(%ebp),d ## D;\
+xor	%edi,		d ## D;\
+rol	$15,		d ## D;\
+push	b ## D;\
+add	k+round(%ebp),	%esi;\
+xor	%esi,		c ## D;
+
+
+/*
+a input register containing a
+b input register containing b (rotated 16)
+c input register containing c
+d input register containing d (already rol $1)
+operations on a and b are interleaved to increase performance
+*/
+#define decrypt_last_round(a,b,c,d,round)\
+movzx	a ## B,		%edi;\
+mov	(%ebp,%edi,4),	%esi;\
+movzx	b ## B,		%edi;\
+mov	s3(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s1(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+ror	$16,		b ## D;\
+xor	(%ebp,%edi,4),	d ## D;\
+movzx	a ## B,		%edi;\
+xor	s2(%ebp,%edi,4),%esi;\
+movzx	b ## B,		%edi;\
+xor	s1(%ebp,%edi,4),d ## D;\
+movzx	a ## H,		%edi;\
+ror	$16,		a ## D;\
+xor	s3(%ebp,%edi,4),%esi;\
+movzx	b ## H,		%edi;\
+xor	s2(%ebp,%edi,4),d ## D;\
+pop	%edi;\
+add	d ## D,		%esi;\
+add	%esi,		d ## D;\
+add	k+4+round(%ebp),d ## D;\
+xor	%edi,		d ## D;\
+ror	$1,		d ## D;\
+add	k+round(%ebp),	%esi;\
+xor	%esi,		c ## D;
+	
+.align 4
+.global twofish_enc_blk
+.global twofish_dec_blk
+
+
+
+twofish_enc_blk:
+	push	%ebp			/* save registers according to calling convention*/
+	push    %ebx
+	push    %esi			
+	push    %edi
+		
+		
+	mov	ctx + 16(%esp),	%ebp	/* abuse the base pointer: set new base bointer to the crypto ctx */
+	mov     in_blk+16(%esp),%edi	/* input adress in edi */
+
+	mov	(%edi),		%eax
+	mov	b_offset(%edi),	%ebx
+	mov	c_offset(%edi),	%ecx
+	mov	d_offset(%edi),	%edx
+	input_whitening(%eax,%ebp,a_offset)
+	input_whitening(%ebx,%ebp,b_offset)
+	input_whitening(%ecx,%ebp,c_offset)
+	input_whitening(%edx,%ebp,d_offset)
+	rol	$1,	%edx
+	push	%edx
+
+	encrypt_first_round(R0,R1,R2,R3,0);
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
+	output_whitening(%eax,%ebp,c_offset)
+	output_whitening(%ebx,%ebp,d_offset)
+	output_whitening(%ecx,%ebp,a_offset)
+	output_whitening(%edx,%ebp,b_offset)
+	mov	out_blk+16(%esp),%edi;
+	mov	%eax,		c_offset(%edi)
+	mov	%ebx,		d_offset(%edi)
+	mov	%ecx,		(%edi)
+	mov	%edx,		b_offset(%edi)
+
+	pop	%edi
+	pop	%esi
+	pop	%ebx
+	pop	%ebp
+	mov	$1,	%eax
+	ret
+	
+twofish_dec_blk:	
+	push	%ebp			/* save registers according to calling convention*/
+	push    %ebx
+	push    %esi			
+	push    %edi
+		
+		
+	mov	ctx + 16(%esp),	%ebp	/* abuse the base pointer: set new base bointer to the crypto ctx */
+	mov     in_blk+16(%esp),%edi	/* input adress in edi */
+
+	mov	(%edi),		%eax
+	mov	b_offset(%edi),	%ebx
+	mov	c_offset(%edi),	%ecx
+	mov	d_offset(%edi),	%edx
+	output_whitening(%eax,%ebp,a_offset)
+	output_whitening(%ebx,%ebp,b_offset)
+	output_whitening(%ecx,%ebp,c_offset)
+	output_whitening(%edx,%ebp,d_offset)
+	rol	$1,	%ecx
+	push	%edx
+
+	decrypt_first_round(R0,R1,R2,R3,15*8);
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
+
+	input_whitening(%eax,%ebp,c_offset)
+	input_whitening(%ebx,%ebp,d_offset)
+	input_whitening(%ecx,%ebp,a_offset)
+	input_whitening(%edx,%ebp,b_offset)
+	mov	out_blk+16(%esp),%edi;
+	mov	%eax,		c_offset(%edi)
+	mov	%ebx,		d_offset(%edi)
+	mov	%ecx,		(%edi)
+	mov	%edx,		b_offset(%edi)
+
+	pop	%edi
+	pop	%esi
+	pop	%ebx
+	pop	%ebp
+	mov	$1,	%eax
+	ret
diff -uprN linux-2.6.17-rc5.twofish2/crypto/Kconfig linux-2.6.17-rc5.twofish3/crypto/Kconfig
--- linux-2.6.17-rc5.twofish2/crypto/Kconfig	2006-06-11 15:58:39.219982140 +0200
+++ linux-2.6.17-rc5.twofish3/crypto/Kconfig	2006-06-11 16:05:19.938782275 +0200
@@ -150,6 +150,21 @@ config CRYPTO_TWOFISH_COMMON
 	  Common parts of the Twofish cipher algorithm.
 	  
 
+config CRYPTO_TWOFISH_586
+	tristate "Twofish cipher algorithms (i586)"
+	depends on CRYPTO && ((X86 || UML_X86) && !64BIT)
+	select CRYPTO_TWOFISH_COMMON
+	help
+	  Twofish cipher algorithm.
+
+	  Twofish was submitted as an AES (Advanced Encryption Standard)
+	  candidate cipher by researchers at CounterPane Systems.  It is a
+	  16 round block cipher supporting key sizes of 128, 192, and 256
+	  bits.
+
+	  See also:
+	  <http://www.schneier.com/twofish.html>
+
 config CRYPTO_SERPENT
 	tristate "Serpent cipher algorithm"
 	depends on CRYPTO

