Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751435AbWFDNRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWFDNRB (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 09:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWFDNQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 09:16:47 -0400
Received: from mout2.freenet.de ([194.97.50.155]:29836 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751063AbWFDNQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 09:16:42 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH  3/4] Twofish cipher - i586 assembler
Date: Sun, 4 Jun 2006 15:16:38 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041516.38998.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the twofish i586 assembler routine. 

Changes since the last version:
- The keysetup is now handled by the twofish_common.c (see patch 1 )

Correctness was verified with the tcrypt module and automated test scripts.

Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

diff -uprN linux-2.6.17-rc5.twofish2/arch/i386/crypto/Makefile 
linux-2.6.17-rc5.twofish3/arch/i386/crypto/Makefile
--- linux-2.6.17-rc5.twofish2/arch/i386/crypto/Makefile	2006-05-30 
19:43:48.768000198 +0200
+++ linux-2.6.17-rc5.twofish3/arch/i386/crypto/Makefile	2006-05-30 
20:06:10.880715217 +0200
@@ -5,5 +5,8 @@
 #

 obj-$(CONFIG_CRYPTO_AES_586) += aes-i586.o
+obj-$(CONFIG_CRYPTO_TWOFISH_586) += twofish-i586.o

 aes-i586-y := aes-i586-asm.o aes.o
+twofish-i586-y := twofish-i586-asm.o 
twofish.o ../../../crypto/twofish_common.o
+
diff -uprN linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish.c 
linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish.c
--- linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish.c	1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish.c	2006-05-30 
20:04:16.279682770 +0200
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
diff -uprN linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish-i586-asm.S 
linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish-i586-asm.S
--- linux-2.6.17-rc5.twofish2/arch/i386/crypto/twofish-i586-asm.S	1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish3/arch/i386/crypto/twofish-i586-asm.S	2006-05-30 
20:00:47.825035584 +0200
@@ -0,0 +1,377 @@
+	/***************************************************************************
+	*   Copyright (C) 2006 by Joachim Fritschi, <jfritschi@freenet.de>        *
+	*                                                                         *
+	*   This program is free software; you can redistribute it and/or modify  *
+	*   it under the terms of the GNU General Public License as published by  *
+	*   the Free Software Foundation; either version 2 of the License, or     *
+	*   (at your option) any later version.                                   *
+	*                                                                         *
+	*   This program is distributed in the hope that it will be useful,       *
+	*   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
+	*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
+	*   GNU General Public License for more details.                          *
+	*                                                                         *
+	*   You should have received a copy of the GNU General Public License     *
+	*   along with this program; if not, write to the                         *
+	*   Free Software Foundation, Inc.,                                       *
+	*   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
+	***************************************************************************/
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
+
+
+
+/* register aliases for better reading */
+
+#define r0  eax
+#define r1  ebx
+#define r2  ecx
+#define r3  edx
+#define r4  esi
+#define r5  edi
+
+
+
+#define eaxl  al
+#define eaxh  ah
+#define ebxl  bl
+#define ebxh  bh
+#define ecxl  cl
+#define ecxh  ch
+#define edxl  dl
+#define edxh  dh
+
+
+#define _h(reg) reg##h
+#define h(reg) _h(reg)
+
+#define _l(reg) reg##l
+#define l(reg) _l(reg)
+
+/*load input word with whitening */
+
+#define get_input(input_adress,offset,dst,context)\
+	load_input(input_adress,offset,dst);\
+	input_whitening(dst,context,offset);
+
+#define get_dec_input(input_adress,offset,dst,context)\
+	load_dec_input(input_adress,offset,dst);\
+	dec_input_whitening(dst,context,offset);
+
+/* perform output whitening and save value. Old value is saved */
+#define process_output(dst,src,tmp,context,offset)\
+	output_whitening(src,tmp,context,offset);\
+	save_output(dst,offset,tmp);
+
+/* perform output whitening and save value. The old value is destoyed */
+#define destructive_process_output(dst,src,context,offset)\
+	destructive_output_whitening(src,context,offset);\
+	save_output(dst,offset,src);
+
+/* perform output whitening and save value. Old value is saved */
+#define process_dec_output(dst,src,tmp,context,offset)\
+	dec_output_whitening(src,tmp,context,offset);\
+	save_output(dst,offset,tmp);
+
+/* perform output whitening and save value. The old value is destoyed */
+#define destructive_process_dec_output(dst,src,context,offset)\
+	destructive_dec_output_whitening(src,context,offset);\
+	save_output(dst,offset,src);
+
+/* load input */
+#define load_input(input_adress,offset,dst)\
+	mov	offset(%input_adress), %dst;
+
+#define load_dec_input(input_adress,offset,dst)\
+	mov	offset(%input_adress), %dst;
+
+/* performs input whitening */
+#define input_whitening(src,context,offset)\
+	xor	w+offset(%context), %src;\
+
+#define dec_input_whitening(src,context,offset)\
+	xor	w+16+offset(%context), %src;
+
+/* performs decryption output whitening */
+/* Result is in dst, the original value is still intact */
+#define dec_output_whitening(src,dst,context,offset)\
+	mov	w+offset(%context), %dst;\
+	xor	%src,%dst;
+
+/* performs encryption output whitening */
+/* Result is in dst, the original value is still intact */
+#define output_whitening(src,dst,context,offset)\
+	mov	w+16+offset(%context), %dst;\
+	xor	%src,%dst;
+
+/* performs encryption output whitening */
+/* Result is in dst, the original value is destroyed */
+#define destructive_output_whitening(src,context,offset)\
+	xor	w+16+offset(%context), %src;\
+
+/* performs decryption output whitening */
+/* Result is in dst, the original value is destroyed */
+#define destructive_dec_output_whitening(src,context,offset)\
+	xor	w+offset(%context), %src;\
+
+/* save the output values */
+#define save_output(output_adress,offset,src)\
+	mov	%src,offset(%output_adress);\
+
+/* load sbox values */
+#define load_s(context,sbox,index,dst)\
+	xor	sbox(%context,%index,4),%dst;\
+
+/* performs "a" sbox transfomation */
+/* input value is still intact but rotatet */
+#define g1(context,input,dst,tmp)\
+	xor	%dst,%dst;\
+ 	movzx	%l(input),%tmp;\
+	load_s(context,s0,tmp,dst);\
+	movzx	%h(input),%tmp;\
+	load_s(context,s1,tmp,dst);\
+	ror	$16,%input;\
+	movzx	%l(input),%tmp;\
+	load_s(context,s2,tmp,dst);\
+	movzx	%h(input),%tmp;\
+	load_s(context,s3,tmp,dst);\
+
+/* performs "b" sbox transfomation */
+/* input value is still intact but rotatet */
+#define g2(context,input,dst,tmp)\
+	xor	%dst,%dst;\
+	movzx	%l(input),%tmp;\
+	load_s(context,s1,tmp,dst);\
+	movzx	%h(input),%tmp;\
+	load_s(context,s2,tmp,dst);\
+	ror	$16,%input;\
+	movzx	%l(input),%tmp;\
+	load_s(context,s3,tmp,dst);\
+	movzx	%h(input),%tmp;\
+	load_s(context,s0,tmp,dst);\
+	;
+
+/* Pseudo Harmann Transfomation */
+#define pht(a,b)\
+	add	%b,%a;\
+	add	%a,%b;
+
+/* Adds the round keys to a and b */
+#define round_key(context,a,b,round)\
+	add	k+round(%context),%a;\
+	add	k+4+round(%context),%b;\
+
+
+/* Input in a and b , output in fa fb */
+/* a and b a prerotate for the next round */
+#define f_function(context,a,b,fa,fb,tmp3,round)\
+	g1(context,a,fa,tmp3);\
+	g2(context,b,fb,tmp3);\
+	ror	$16,%a;\
+	ror	$15,%b;\
+	pht(fa,fb);\
+	round_key(context,fa,fb,round);
+
+
+/* Input in a and b , output in fa fb */
+/* a and b a prerotate for the next round */
+#define reverse_f_function(context,a,b,fa,fb,tmp3,round)\
+	g1(context,a,fa,tmp3);\
+	g2(context,b,fb,tmp3);\
+	ror	$15,%a;\
+	ror	$16,%b;\
+	pht(fa,fb);\
+	round_key(context,fa,fb,round);
+
+
+/* Output in a and b */
+/* olda contains the a of the round before, cuts down stack use to one push / 
pop per round for the oldb */
+/* b is alread pre rotated (rol 1) in the f funtion to save one instruction 
*/
+#define round(context,a,b,tmp1,tmp2,tmp3,olda,round)\
+	f_function(context,a,b,tmp1,tmp2,tmp3,round);\
+	mov	%b,%tmp3;\
+	pop	%b;\
+	push	%tmp3;\
+	xor	%tmp2,%b;\
+	xor	%tmp1,%olda;\
+	ror	$1,%olda;
+
+
+/* Output in a and b */
+/* olda contains the a of the round before, cuts donw stack use to one push / 
pop per round for the oldb */
+/* a is alread pre rotated (rol 1) in the f funtion to save one instruction 
*/
+#define dec_round(context,a,b,tmp1,tmp2,tmp3,olda,round)\
+	reverse_f_function(context,a,b,tmp1,tmp2,tmp3,round);\
+	xor	%tmp1,%olda;\
+	mov	%b,%tmp3;\
+	pop	%b;\
+	push	%tmp3;\
+	xor	%tmp2,%b;\
+	ror	$1,%b;
+
+
+
+.align 4
+.global twofish_enc_blk
+.global twofish_dec_blk
+
+
+
+twofish_enc_blk:
+	push	%ebp			/* save registers according to calling convention*/
+	push    %r1
+	push    %esi
+	push    %edi
+
+
+	mov	ctx + 16(%esp),%ebp	/* abuse the base pointer: set new base bointer to 
the crypto ctx */
+	mov     in_blk+16(%esp),%r5	/* input adress in r5 */
+
+	get_input(r5,a_offset,r0,ebp);
+	get_input(r5,b_offset,r1,ebp);
+
+	/* To save a few instructions round 1 is unrolled */
+
+	f_function(ebp,r0,r1,r2,r3,r4,0);	//ouput in r2 r3
+	push	%r1;
+
+	get_input(r5,c_offset,r1,ebp);
+	get_input(r5,d_offset,r4,ebp);
+	xor	%r1,%r2;\
+	ror	$1,%r2;\
+	rol	$1,%r4;\
+	xor	%r4,%r3;
+
+
+	round(ebp,r2,r3,r4,r5,r1,r0,1*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,2*8);
+	round(ebp,r2,r3,r4,r5,r1,r0,3*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,4*8);
+	round(ebp,r2,r3,r4,r5,r1,r0,5*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,6*8);
+	round(ebp,r2,r3,r4,r5,r1,r0,7*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,8*8);
+	round(ebp,r2,r3,r4,r5,r1,r0,9*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,10*8);
+	round(ebp,r2,r3,r4,r5,r1,r0,11*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,12*8);
+	round(ebp,r2,r3,r4,r5,r1,r0,13*8);
+	round(ebp,r0,r3,r4,r5,r1,r2,14*8);
+
+	/* To save a few instructions round 15 is unrolled */
+
+	mov	out_blk+20(%esp),%r1;
+	process_output(r1,r2,r4,ebp,a_offset);
+	process_output(r1,r3,r4,ebp,b_offset);
+	g1(ebp,r2,r4,r1);
+	g2(ebp,r3,r5,r1);
+	pht(r4,r5);
+	round_key(ebp,r4,r5,15*8);
+	pop	%r1;
+	xor	%r5,%r1;
+	xor	%r4,%r0;
+	ror	$1,%r0;
+
+	mov	out_blk+16(%esp),%r3
+	destructive_process_output(r3,r0,ebp,c_offset);
+	destructive_process_output(r3,r1,ebp,d_offset);
+
+	pop	%edi
+	pop	%esi
+	pop	%r1
+	pop	%ebp
+	mov	$1,%r0
+	ret
+
+twofish_dec_blk:
+	push	%ebp			/* save  registers according to calling convention*/
+	push    %r1
+	push    %esi
+	push    %edi
+
+
+	mov	ctx + 16(%esp),%ebp	/* abuse the base pointer: set new base bointer to 
the crypto ctx */
+	mov     in_blk+16(%esp),%r5	/* output adress in r5 */
+
+	/* To save a few instructions round 15 is unrolled */
+	get_dec_input(r5,a_offset,r0,ebp);
+	get_dec_input(r5,b_offset,r1,ebp);
+
+	reverse_f_function(ebp,r0,r1,r2,r3,r4,15*8);
+
+        push %r1; /* save oldb for next rount */
+
+	get_dec_input(r5,c_offset,r1,ebp);
+	get_dec_input(r5,d_offset,r4,ebp);
+	xor	%r4,%r3;
+	ror	$1,%r3;
+	rol	$1,%r1;
+	xor	%r1,%r2;
+
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,14*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,13*8);
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,12*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,11*8);
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,10*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,9*8);
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,8*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,7*8);
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,6*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,5*8);
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,4*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,3*8);
+	dec_round(ebp,r2,r3,r4,r5,r1,r0,2*8);
+	dec_round(ebp,r0,r3,r4,r5,r1,r2,8);
+
+	/* To save a few instructions round 0 is unrolled */
+	mov	out_blk+20(%esp),%r1;
+	process_dec_output(r1,r2,r4,ebp,a_offset);
+	process_dec_output(r1,r3,r4,ebp,b_offset);
+	g1(ebp,r2,r4,r1);
+	g2(ebp,r3,r5,r1);
+	pht(r4,r5);
+	round_key(ebp,r4,r5,0);
+
+	pop	%r1;
+	xor	%r1,%r5
+	ror	$1,%r5
+	xor	%r0,%r4
+
+
+
+	mov	out_blk+16(%esp),%r3
+	destructive_process_dec_output(r3,r4,ebp,c_offset);
+	destructive_process_dec_output(r3,r5,ebp,d_offset);
+
+	pop	%edi
+	pop	%esi
+	pop	%r1
+	pop	%ebp
+	mov	$1,%r0
+	ret
+
+
+
+
diff -uprN linux-2.6.17-rc5.twofish2/crypto/Kconfig 
linux-2.6.17-rc5.twofish3/crypto/Kconfig
--- linux-2.6.17-rc5.twofish2/crypto/Kconfig	2006-05-30 19:44:02.607579102 
+0200
+++ linux-2.6.17-rc5.twofish3/crypto/Kconfig	2006-05-30 20:00:47.841035197 
+0200
@@ -142,6 +142,20 @@ config CRYPTO_TWOFISH
 	  See also:
 	  <http://www.schneier.com/twofish.html>

+config CRYPTO_TWOFISH_586
+	tristate "Twofish cipher algorithms (i586)"
+	depends on CRYPTO && ((X86 || UML_X86) && !64BIT)
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
