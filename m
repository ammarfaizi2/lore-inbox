Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751484AbWFDNRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWFDNRY (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 09:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWFDNRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 09:17:06 -0400
Received: from mout1.freenet.de ([194.97.50.132]:44429 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751063AbWFDNQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 09:16:52 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Sun, 4 Jun 2006 15:16:46 +0200
User-Agent: KMail/1.9.1
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, ak@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041516.46920.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the twofish x86_64 assembler routine. 

Changes since last version:
- The keysetup is now handled by the twofish_common.c (see patch 1 )
- The last round of the encrypt/decrypt routines where optimized saving 5 
instructions. 

Correctness was verified with the tcrypt module and automated test scripts.

Signed-off-by: Joachim Fritschi <jfritschi@freenet.de>

diff -uprN linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/Makefile 
linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/Makefile
--- linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/Makefile	2006-05-30 
19:58:05.172677025 +0200
+++ linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/Makefile	2006-05-31 
11:56:48.239053258 +0200
@@ -5,5 +5,8 @@
 #

 obj-$(CONFIG_CRYPTO_AES_X86_64) += aes-x86_64.o
+obj-$(CONFIG_CRYPTO_TWOFISH_X86_64) += twofish-x86_64.o

 aes-x86_64-y := aes-x86_64-asm.o aes.o
+twofish-x86_64-y := twofish-x86_64-asm.o 
twofish.o ../../../crypto/twofish_common.o
+
diff -uprN linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish.c 
linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish.c
--- linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish.c	1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish.c	2006-05-31 
11:55:51.492767729 +0200
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
diff -uprN linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish-x86_64-asm.S 
linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish-x86_64-asm.S
--- linux-2.6.17-rc5.twofish3/arch/x86_64/crypto/twofish-x86_64-asm.S	
1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc5.twofish4/arch/x86_64/crypto/twofish-x86_64-asm.S	
2006-05-31 11:58:05.204726048 +0200
@@ -0,0 +1,400 @@
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
+/* Defining a few register aliases for better reading */
+
+#define R0     %rax
+#define R0D    %eax
+#define R0W    %ax
+#define R0B    %al
+#define R0H    %ah
+
+#define R1     %rbx
+#define R1D    %ebx
+#define R1W    %bx
+#define R1B    %bl
+#define R1H    %bh
+
+#define R2     %rcx
+#define R2D    %ecx
+#define R2W    %cx
+#define R2B    %cl
+#define R2H    %ch
+
+#define R3     %rdx
+#define R3D    %edx
+#define R3W    %dx
+#define R3B    %dl
+#define R3H    %dh
+
+#define R4     %rsi
+#define R4D    %esi
+#define R4W    %six
+#define R4B    %sil
+
+#define R5     %rdi
+#define R5D    %edi
+#define R5W    %dix
+#define R5B    %dil
+
+#define R6     %rsp
+#define R6D    %esp
+#define R6W    %spx
+#define R6B    %spl
+
+#define R7     %rbp
+#define R7D    %ebp
+#define R7W    %bpx
+#define R7B    %bpl
+
+#define R8     %r8
+#define R8D    %r8d
+#define R8W    %r8w
+#define R8B    %r8b
+
+#define R9     %r9
+#define R9D    %r9d
+#define R9W    %r9w
+#define R9B    %r9b
+
+#define R10     %r10
+#define R10D    %r10d
+#define R10W    %r10w
+#define R10B    %r10b
+
+#define R11     %r11
+#define R11D    %r11d
+#define R11W    %r11w
+#define R11B    %r11b
+
+#define R12     %r12
+#define R12D    %r12d
+#define R12W    %r12w
+#define R12B    %r12b
+
+#define R13     %r13
+#define R13D    %r13d
+#define R13W    %r13w
+#define R13B    %r13b
+
+#define R14     %r14
+#define R14D    %r14d
+#define R14W    %r14w
+#define R14B    %r14b
+
+#define R15     %r15
+#define R15D    %r15d
+#define R15W    %r15w
+#define R15B    %r15b
+
+
+
+/* performs input whitening */
+#define input_whitening(src,context,offset)\
+	xor	w+offset(context), src;\
+
+/* performs input whitening */
+#define output_whitening(src,context,offset)\
+	xor	w+16+offset(context),src;\
+
+/* load sbox values */
+#define load_s(context,sbox,index,dst)\
+	xor	sbox(context,index,4),dst ## D;\
+
+/* load both round keys */
+#define load_round_key(dsta,dstb,context,round)\
+	mov	k+round(context),dsta ## D;\
+	mov	k+4+round(context),dstb ## D;
+
+
+#define encrypt_round(a,b,olda,oldb,newa,newb,ctx,round,tmp1,tmp2,key1,key2);
\
+	xor	tmp1,tmp1;\
+	load_round_key(key1,key2,ctx,round);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	ror	$16,a ## D;\
+	load_s(ctx,s0,newa,tmp1);\
+	load_s(ctx,s1,newb,tmp1);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	load_s(ctx,s2,newa,tmp1);\
+	load_s(ctx,s3,newb,tmp1);\
+	ror	$16,a ## D;\
+	xor	tmp2,tmp2;\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	ror	$16,b ## D;\
+	load_s(ctx,s1,newa,tmp2);\
+	load_s(ctx,s2,newb,tmp2);\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	load_s(ctx,s3,newa,tmp2);\
+	load_s(ctx,s0,newb,tmp2);\
+	ror	$15,b ## D;\
+	add	tmp2 ## D,tmp1 ## D;\
+	add	tmp1 ## D,tmp2 ## D;\
+	add	tmp1 ## D,key1 ## D;\
+	add	tmp2 ## D,key2 ## D;\
+	mov	olda  ## D,newa ## D;\
+	mov	oldb ## D,newb ## D;\
+	mov	a ## D,olda ## D;\
+	mov	b ## D,oldb ## D;\
+	xor	key1 ## D,newa ## D;\
+	xor	key2 ## D,newb ## D;\
+	ror	$1,newa ## D
+
+/* Last Round can ignore saving a,b for the next round */
+
+#define 
encrypt_last_round(a,b,olda,oldb,newa,newb,ctx,round,tmp1,tmp2,key1,key2);\
+	xor	tmp1,tmp1;\
+	load_round_key(key1,key2,ctx,round);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	ror	$16,a ## D;\
+	load_s(ctx,s0,newa,tmp1);\
+	load_s(ctx,s1,newb,tmp1);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	load_s(ctx,s2,newa,tmp1);\
+	load_s(ctx,s3,newb,tmp1);\
+	xor	tmp2,tmp2;\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	ror	$16,b ## D;\
+	load_s(ctx,s1,newa,tmp2);\
+	load_s(ctx,s2,newb,tmp2);\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	load_s(ctx,s3,newa,tmp2);\
+	load_s(ctx,s0,newb,tmp2);\
+	add	tmp2 ## D,tmp1 ## D;\
+	add	tmp1 ## D,tmp2 ## D;\
+	add	tmp1 ## D,key1 ## D;\
+	add	tmp2 ## D,key2 ## D;\
+	mov	olda  ## D,newa ## D;\
+	mov	oldb ## D,newb ## D;\
+	xor	key1 ## D,newa ## D;\
+	xor	key2 ## D,newb ## D;\
+	ror	$1,newa ## D
+
+#define decrypt_round(a,b,olda,oldb,newa,newb,ctx,round,tmp1,tmp2,key1,key2);
\
+	xor	tmp1,tmp1;\
+	load_round_key(key1,key2,ctx,round);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	ror	$16,a ## D;\
+	load_s(ctx,s0,newa,tmp1);\
+	load_s(ctx,s1,newb,tmp1);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	load_s(ctx,s2,newa,tmp1);\
+	load_s(ctx,s3,newb,tmp1);\
+	ror	$15,a ## D;\
+	xor	tmp2,tmp2;\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	ror	$16,b ## D;\
+	load_s(ctx,s1,newa,tmp2);\
+	load_s(ctx,s2,newb,tmp2);\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	load_s(ctx,s3,newa,tmp2);\
+	load_s(ctx,s0,newb,tmp2);\
+	ror	$16,b ## D;\
+	add	tmp2 ## D,tmp1 ## D;\
+	add	tmp1 ## D,tmp2 ## D;\
+	add	tmp1 ## D,key1 ## D;\
+	add	tmp2 ## D,key2 ## D;\
+	mov	olda  ## D,newa ## D;\
+	mov	oldb ## D,newb ## D;\
+	mov	a ## D,olda ## D;\
+	mov	b ## D,oldb ## D;\
+	xor	key1 ## D,newa ## D;\
+	xor	key2 ## D,newb ## D;\
+	ror	$1,newb ## D
+
+/* Last Round can ignore saving a,b for the next round */
+
+#define 
decrypt_last_round(a,b,olda,oldb,newa,newb,ctx,round,tmp1,tmp2,key1,key2);\
+	xor	tmp1,tmp1;\
+	load_round_key(key1,key2,ctx,round);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	ror	$16,a ## D;\
+	load_s(ctx,s0,newa,tmp1);\
+	load_s(ctx,s1,newb,tmp1);\
+	movzx	a ## B,newa;\
+	movzx	a ## H,newb ## D;\
+	load_s(ctx,s2,newa,tmp1);\
+	load_s(ctx,s3,newb,tmp1);\
+	xor	tmp2,tmp2;\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	ror	$16,b ## D;\
+	load_s(ctx,s1,newa,tmp2);\
+	load_s(ctx,s2,newb,tmp2);\
+	movzx	b ## B,newa;\
+	movzx	b ## H,newb ## D;\
+	load_s(ctx,s3,newa,tmp2);\
+	load_s(ctx,s0,newb,tmp2);\
+	add	tmp2 ## D,tmp1 ## D;\
+	add	tmp1 ## D,tmp2 ## D;\
+	add	tmp1 ## D,key1 ## D;\
+	add	tmp2 ## D,key2 ## D;\
+	mov	olda  ## D,newa ## D;\
+	mov	oldb ## D,newb ## D;\
+	xor	key1 ## D,newa ## D;\
+	xor	key2 ## D,newb ## D;\
+	ror	$1,newb ## D
+
+
+
+
+.align 8
+.global twofish_enc_blk
+.global twofish_dec_blk
+
+
+
+twofish_enc_blk:
+	pushq    R1
+	pushq	 R12
+	pushq	 R13
+
+	/* r5 contains the crypto ctx adress */
+	/* r4 contains the output adress */
+	/* r3 contains the input adress */
+
+	movq	(R3),R1
+	movq	8(R3),R9
+	input_whitening(R1,R5,a_offset)
+	input_whitening(R9,R5,c_offset)
+	mov	R1D,R0D
+	shr	$32,R1
+	mov	R9D,R8D
+	shr	$32,R9
+	rol	$1,R9D
+
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,0,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,2*8,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,3*8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,4*8,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,5*8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,6*8,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,7*8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,8*8,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,9*8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,10*8,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,11*8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,12*8,R10,R11,R12,R13);
+	encrypt_round(R2,R3,R8,R9,R0,R1,R5,13*8,R10,R11,R12,R13);
+	encrypt_round(R0,R1,R8,R9,R2,R3,R5,14*8,R10,R11,R12,R13);
+
+	mov	R3,R13
+	shl	$32,R13
+	xor	R2,R13
+	output_whitening(R13,R5,a_offset)
+	movq	R13,(R4)
+
+	encrypt_last_round(R2,R3,R8,R9,R0,R1,R5,15*8,R10,R11,R12,R13);
+
+
+	shl	$32,R1
+	xor	R0,R1
+
+	output_whitening(R1,R5,c_offset)
+	movq	R1,8(R4)
+
+	popq	R13
+	popq	R12
+	popq	R1
+	movq	$1,%rax
+	ret
+
+twofish_dec_blk:
+	pushq    R1
+	pushq	 R12
+	pushq	 R13
+
+	/* r5 contains the crypto ctx adress */
+	/* r4 contains the output adress */
+	/* r3 contains the input adress */
+
+	movq	(R3),R1
+	movq	8(R3),R9
+	output_whitening(R1,R5,a_offset)
+	output_whitening(R9,R5,c_offset)
+	mov	R1D,R0D
+	shr	$32,R1
+	mov	R9D,R8D
+	shr	$32,R9
+	rol	$1,R8D
+
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,15*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,14*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,13*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,12*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,11*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,10*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,9*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,8*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,7*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,6*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,5*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,4*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,3*8,R10,R11,R12,R13);
+	decrypt_round(R2,R3,R8,R9,R0,R1,R5,2*8,R10,R11,R12,R13);
+	decrypt_round(R0,R1,R8,R9,R2,R3,R5,8,R10,R11,R12,R13);
+
+	mov	R3,R13
+	shl	$32,R13
+	xor	R2,R13
+	input_whitening(R13,R5,a_offset)
+	movq	R13,(R4)
+
+	decrypt_last_round(R2,R3,R8,R9,R0,R1,R5,0,R10,R11,R12,R13);
+
+	shl	$32,R1
+	xor	R0,R1
+	input_whitening(R1,R5,c_offset)
+	movq	R1,8(R4)
+
+	popq	R13
+	popq	R12
+	popq	R1
+	movq	$1,%rax
+	ret
diff -uprN linux-2.6.17-rc5.twofish3/crypto/Kconfig 
linux-2.6.17-rc5.twofish4/crypto/Kconfig
--- linux-2.6.17-rc5.twofish3/crypto/Kconfig	2006-05-30 20:00:47.841035197 
+0200
+++ linux-2.6.17-rc5.twofish4/crypto/Kconfig	2006-05-31 11:52:43.234447029 
+0200
@@ -156,6 +156,20 @@ config CRYPTO_TWOFISH_586
 	  See also:
 	  <http://www.schneier.com/twofish.html>

+config CRYPTO_TWOFISH_X86_64
+        tristate "Twofish cipher algorithm (x86_64)"
+        depends on CRYPTO && ((X86 || UML_X86) && 64BIT)
+        help
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
