Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUENNI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUENNI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUENNI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:08:56 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:45316 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S265269AbUENNHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:07:44 -0400
Date: Fri, 14 May 2004 15:07:24 +0200
To: linux-kernel@vger.kernel.org
Cc: Christophe Saout <christophe@saout.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       James Morris <jmorris@redhat.com>
Subject: [PATCH] AES i586 optimized, regparm fixed
Message-ID: <20040514130724.GA8081@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085404045.d167@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patch posted yesterday has had an issue with CONFIG_REGPARM. The
following patch corrects this issue and works for both cases
CONFIG_REGPARM=3Dy||n. Thanks to Christophe Saout, who pointed out the
solution almost instantly. The patch does not apply Christophe's patch, but
rather forces the interface back to regparm(0).

James, if the patch suits your taste, please take care of forwarding it to
Andrew or Linus.

Best Regards, Clemens

diff --new-file -ru linux-2.6.6-orig/arch/i386/crypto/aes-i586-asm.S linux-=
2.6.6/arch/i386/crypto/aes-i586-asm.S
--- linux-2.6.6-orig/arch/i386/crypto/aes-i586-asm.S	1970-01-01 01:00:00.00=
0000000 +0100
+++ linux-2.6.6/arch/i386/crypto/aes-i586-asm.S	2004-05-13 10:24:36.0000000=
00 +0200
@@ -0,0 +1,925 @@
+//
+// Copyright (c) 2001, Dr Brian Gladman <brg@gladman.uk.net>, Worcester, U=
K.
+// All rights reserved.
+//
+// TERMS
+//
+//  Redistribution and use in source and binary forms, with or without
+//  modification, are permitted subject to the following conditions:
+//
+//  1. Redistributions of source code must retain the above copyright
+//     notice, this list of conditions and the following disclaimer.
+//
+//  2. Redistributions in binary form must reproduce the above copyright
+//     notice, this list of conditions and the following disclaimer in the
+//     documentation and/or other materials provided with the distribution.
+//
+//  3. The copyright holder's name must not be used to endorse or promote
+//     any products derived from this software without his specific prior
+//     written permission.
+//
+//  This software is provided 'as is' with no express or implied warranties
+//  of correctness or fitness for purpose.
+
+// Modified by Jari Ruusu,  December 24 2001
+//  - Converted syntax to GNU CPP/assembler syntax
+//  - C programming interface converted back to "old" API
+//  - Minor portability cleanups and speed optimizations
+
+// Modified by Jari Ruusu,  April 11 2002
+//  - Added above copyright and terms to resulting object code so that
+//    binary distributions can avoid legal trouble
+
+// Modified by Clemens Fruhwirth,  Feb 04 2003
+//  - Switched in/out to fit CryptoAPI calls.
+
+// An AES (Rijndael) implementation for the Pentium. This version only
+// implements the standard AES block length (128 bits, 16 bytes). This code
+// does not preserve the eax, ecx or edx registers or the artihmetic status
+// flags. However, the ebx, esi, edi, and ebp registers are preserved acro=
ss
+// calls.
+
+// void aes_set_key(aes_context *cx, const unsigned char key[], const int =
key_len, const int f)
+// void aes_encrypt(const aes_context *cx, unsigned char out_blk[], const =
unsigned char in_blk[])
+// void aes_decrypt(const aes_context *cx, unsigned char out_blk[], const =
unsigned char in_blk[])
+
+#if defined(USE_UNDERLINE)
+# define aes_set_key _aes_set_key
+# define aes_encrypt _aes_encrypt
+# define aes_decrypt _aes_decrypt
+#endif
+#if !defined(ALIGN32BYTES)
+# define ALIGN32BYTES 32
+#endif
+
+	.file	"aes-i586.S"
+	.globl	aes_set_key
+	.globl	aes_encrypt
+	.globl	aes_decrypt
+
+	.text
+copyright:
+	.ascii "    \000"
+	.ascii "Copyright (c) 2001, Dr Brian Gladman <brg@gladman.uk.net>, Worces=
ter, UK.\000"
+	.ascii "All rights reserved.\000"
+	.ascii "    \000"
+	.ascii "TERMS\000"
+	.ascii "    \000"
+	.ascii " Redistribution and use in source and binary forms, with or witho=
ut\000"
+	.ascii " modification, are permitted subject to the following conditions:=
\000"
+	.ascii "    \000"
+	.ascii " 1. Redistributions of source code must retain the above copyrigh=
t\000"
+	.ascii "    notice, this list of conditions and the following disclaimer.=
\000"
+	.ascii "    \000"
+	.ascii " 2. Redistributions in binary form must reproduce the above copyr=
ight\000"
+	.ascii "    notice, this list of conditions and the following disclaimer =
in the\000"
+	.ascii "    documentation and/or other materials provided with the distri=
bution.\000"
+	.ascii "    \000"
+	.ascii " 3. The copyright holder's name must not be used to endorse or pr=
omote\000"
+	.ascii "    any products derived from this software without his specific =
prior\000"
+	.ascii "    written permission.\000"
+	.ascii "    \000"
+	.ascii " This software is provided 'as is' with no express or implied war=
ranties\000"
+	.ascii " of correctness or fitness for purpose.\000"
+	.ascii "    \000"
+
+#define tlen	1024	// length of each of 4 'xor' arrays (256 32-bit words)
+
+// offsets to parameters with one register pushed onto stack
+
+#define ctx	8	// AES context structure
+#define out_blk	12	// output byte array address parameter
+#define in_blk	16	// input byte array address parameter
+
+// offsets in context structure
+
+#define nkey	0	// key length, size 4
+#define nrnd	4	// number of rounds, size 4
+#define ekey	8	// encryption key schedule base address, size 256
+#define dkey	264	// decryption key schedule base address, size 256
+
+// This macro performs a forward encryption cycle. It is entered with
+// the first previous round column values in %eax, %ebx, %esi and %edi and
+// exits with the final values in the same registers.
+
+#define fwd_rnd(p1,p2)			 \
+	mov	%ebx,(%esp)		;\
+	movzbl	%al,%edx		;\
+	mov	%eax,%ecx		;\
+	mov	p2(%ebp),%eax		;\
+	mov	%edi,4(%esp)		;\
+	mov	p2+12(%ebp),%edi	;\
+	xor	p1(,%edx,4),%eax	;\
+	movzbl	%ch,%edx		;\
+	shr	$16,%ecx		;\
+	mov	p2+4(%ebp),%ebx		;\
+	xor	p1+tlen(,%edx,4),%edi	;\
+	movzbl	%cl,%edx		;\
+	movzbl	%ch,%ecx		;\
+	xor	p1+3*tlen(,%ecx,4),%ebx	;\
+	mov	%esi,%ecx		;\
+	mov	p1+2*tlen(,%edx,4),%esi	;\
+	movzbl	%cl,%edx		;\
+	xor	p1(,%edx,4),%esi	;\
+	movzbl	%ch,%edx		;\
+	shr	$16,%ecx		;\
+	xor	p1+tlen(,%edx,4),%ebx	;\
+	movzbl	%cl,%edx		;\
+	movzbl	%ch,%ecx		;\
+	xor	p1+2*tlen(,%edx,4),%eax	;\
+	mov	(%esp),%edx		;\
+	xor	p1+3*tlen(,%ecx,4),%edi ;\
+	movzbl	%dl,%ecx		;\
+	xor	p2+8(%ebp),%esi		;\
+	xor	p1(,%ecx,4),%ebx	;\
+	movzbl	%dh,%ecx		;\
+	shr	$16,%edx		;\
+	xor	p1+tlen(,%ecx,4),%eax	;\
+	movzbl	%dl,%ecx		;\
+	movzbl	%dh,%edx		;\
+	xor	p1+2*tlen(,%ecx,4),%edi	;\
+	mov	4(%esp),%ecx		;\
+	xor	p1+3*tlen(,%edx,4),%esi ;\
+	movzbl	%cl,%edx		;\
+	xor	p1(,%edx,4),%edi	;\
+	movzbl	%ch,%edx		;\
+	shr	$16,%ecx		;\
+	xor	p1+tlen(,%edx,4),%esi	;\
+	movzbl	%cl,%edx		;\
+	movzbl	%ch,%ecx		;\
+	xor	p1+2*tlen(,%edx,4),%ebx	;\
+	xor	p1+3*tlen(,%ecx,4),%eax
+
+// This macro performs an inverse encryption cycle. It is entered with
+// the first previous round column values in %eax, %ebx, %esi and %edi and
+// exits with the final values in the same registers.
+
+#define inv_rnd(p1,p2)			 \
+	movzbl	%al,%edx		;\
+	mov	%ebx,(%esp)		;\
+	mov	%eax,%ecx		;\
+	mov	p2(%ebp),%eax		;\
+	mov	%edi,4(%esp)		;\
+	mov	p2+4(%ebp),%ebx		;\
+	xor	p1(,%edx,4),%eax	;\
+	movzbl	%ch,%edx		;\
+	shr	$16,%ecx		;\
+	mov	p2+12(%ebp),%edi	;\
+	xor	p1+tlen(,%edx,4),%ebx	;\
+	movzbl	%cl,%edx		;\
+	movzbl	%ch,%ecx		;\
+	xor	p1+3*tlen(,%ecx,4),%edi	;\
+	mov	%esi,%ecx		;\
+	mov	p1+2*tlen(,%edx,4),%esi	;\
+	movzbl	%cl,%edx		;\
+	xor	p1(,%edx,4),%esi	;\
+	movzbl	%ch,%edx		;\
+	shr	$16,%ecx		;\
+	xor	p1+tlen(,%edx,4),%edi	;\
+	movzbl	%cl,%edx		;\
+	movzbl	%ch,%ecx		;\
+	xor	p1+2*tlen(,%edx,4),%eax	;\
+	mov	(%esp),%edx		;\
+	xor	p1+3*tlen(,%ecx,4),%ebx ;\
+	movzbl	%dl,%ecx		;\
+	xor	p2+8(%ebp),%esi		;\
+	xor	p1(,%ecx,4),%ebx	;\
+	movzbl	%dh,%ecx		;\
+	shr	$16,%edx		;\
+	xor	p1+tlen(,%ecx,4),%esi	;\
+	movzbl	%dl,%ecx		;\
+	movzbl	%dh,%edx		;\
+	xor	p1+2*tlen(,%ecx,4),%edi	;\
+	mov	4(%esp),%ecx		;\
+	xor	p1+3*tlen(,%edx,4),%eax ;\
+	movzbl	%cl,%edx		;\
+	xor	p1(,%edx,4),%edi	;\
+	movzbl	%ch,%edx		;\
+	shr	$16,%ecx		;\
+	xor	p1+tlen(,%edx,4),%eax	;\
+	movzbl	%cl,%edx		;\
+	movzbl	%ch,%ecx		;\
+	xor	p1+2*tlen(,%edx,4),%ebx	;\
+	xor	p1+3*tlen(,%ecx,4),%esi
+
+// AES (Rijndael) Encryption Subroutine
+
+	.text
+	.align	ALIGN32BYTES
+aes_encrypt:
+	push	%ebp
+	mov	ctx(%esp),%ebp		// pointer to context
+	mov	in_blk(%esp),%ecx
+	push	%ebx
+	push	%esi
+	push	%edi
+	mov	nrnd(%ebp),%edx		// number of rounds
+	lea	ekey+16(%ebp),%ebp	// key pointer
+
+// input four columns and xor in first round key
+
+	mov	(%ecx),%eax
+	mov	4(%ecx),%ebx
+	mov	8(%ecx),%esi
+	mov	12(%ecx),%edi
+	xor	-16(%ebp),%eax
+	xor	-12(%ebp),%ebx
+	xor	-8(%ebp),%esi
+	xor	-4(%ebp),%edi
+
+	sub	$8,%esp			// space for register saves on stack
+
+	sub	$10,%edx
+	je	aes_15
+	add	$32,%ebp
+	sub	$2,%edx
+	je	aes_13
+	add	$32,%ebp
+
+	fwd_rnd(aes_ft_tab,-64)		// 14 rounds for 256-bit key
+	fwd_rnd(aes_ft_tab,-48)
+aes_13:	fwd_rnd(aes_ft_tab,-32)		// 12 rounds for 192-bit key
+	fwd_rnd(aes_ft_tab,-16)
+aes_15:	fwd_rnd(aes_ft_tab,0)		// 10 rounds for 128-bit key
+	fwd_rnd(aes_ft_tab,16)
+	fwd_rnd(aes_ft_tab,32)
+	fwd_rnd(aes_ft_tab,48)
+	fwd_rnd(aes_ft_tab,64)
+	fwd_rnd(aes_ft_tab,80)
+	fwd_rnd(aes_ft_tab,96)
+	fwd_rnd(aes_ft_tab,112)
+	fwd_rnd(aes_ft_tab,128)
+	fwd_rnd(aes_fl_tab,144)		// last round uses a different table
+
+// move final values to the output array.
+
+	mov	out_blk+20(%esp),%ebp
+	add	$8,%esp
+	mov	%eax,(%ebp)
+	mov	%ebx,4(%ebp)
+	mov	%esi,8(%ebp)
+	mov	%edi,12(%ebp)
+	pop	%edi
+	pop	%esi
+	pop	%ebx
+	pop	%ebp
+	ret
+
+
+// AES (Rijndael) Decryption Subroutine
+
+	.align	ALIGN32BYTES
+aes_decrypt:
+	push	%ebp
+	mov	ctx(%esp),%ebp		// pointer to context
+	mov	in_blk(%esp),%ecx
+	push	%ebx
+	push	%esi
+	push	%edi
+	mov	nrnd(%ebp),%edx		// number of rounds
+	lea	dkey+16(%ebp),%ebp	// key pointer
+
+// input four columns and xor in first round key
+
+	mov	(%ecx),%eax
+	mov	4(%ecx),%ebx
+	mov	8(%ecx),%esi
+	mov	12(%ecx),%edi
+	xor	-16(%ebp),%eax
+	xor	-12(%ebp),%ebx
+	xor	-8(%ebp),%esi
+	xor	-4(%ebp),%edi
+
+	sub	$8,%esp			// space for register saves on stack
+
+	sub	$10,%edx
+	je	aes_25
+	add	$32,%ebp
+	sub	$2,%edx
+	je	aes_23
+	add	$32,%ebp
+
+	inv_rnd(aes_it_tab,-64)		// 14 rounds for 256-bit key
+	inv_rnd(aes_it_tab,-48)
+aes_23:	inv_rnd(aes_it_tab,-32)		// 12 rounds for 192-bit key
+	inv_rnd(aes_it_tab,-16)
+aes_25:	inv_rnd(aes_it_tab,0)		// 10 rounds for 128-bit key
+	inv_rnd(aes_it_tab,16)
+	inv_rnd(aes_it_tab,32)
+	inv_rnd(aes_it_tab,48)
+	inv_rnd(aes_it_tab,64)
+	inv_rnd(aes_it_tab,80)
+	inv_rnd(aes_it_tab,96)
+	inv_rnd(aes_it_tab,112)
+	inv_rnd(aes_it_tab,128)
+	inv_rnd(aes_il_tab,144)		// last round uses a different table
+
+// move final values to the output array.
+
+	mov	out_blk+20(%esp),%ebp
+	add	$8,%esp
+	mov	%eax,(%ebp)
+	mov	%ebx,4(%ebp)
+	mov	%esi,8(%ebp)
+	mov	%edi,12(%ebp)
+	pop	%edi
+	pop	%esi
+	pop	%ebx
+	pop	%ebp
+	ret
+
+// AES (Rijndael) Key Schedule Subroutine
+
+// input/output parameters
+
+#define aes_cx	12	// AES context
+#define in_key	16	// key input array address
+#define key_ln	20	// key length, bytes (16,24,32) or bits (128,192,256)
+#define ed_flg	24	// 0=3Dcreate both encr/decr keys, 1=3Dcreate encr key o=
nly
+
+// offsets for locals
+
+#define cnt	-4
+#define kpf	-8
+#define slen	8
+
+// This macro performs a column mixing operation on an input 32-bit
+// word to give a 32-bit result. It uses each of the 4 bytes in the
+// the input column to index 4 different tables of 256 32-bit words
+// that are xored together to form the output value.
+
+#define mix_col(p1)			 \
+	movzbl	%bl,%ecx		;\
+	mov	p1(,%ecx,4),%eax	;\
+	movzbl	%bh,%ecx		;\
+	ror	$16,%ebx		;\
+	xor	p1+tlen(,%ecx,4),%eax	;\
+	movzbl	%bl,%ecx		;\
+	xor	p1+2*tlen(,%ecx,4),%eax	;\
+	movzbl	%bh,%ecx		;\
+	xor	p1+3*tlen(,%ecx,4),%eax
+
+// Key Schedule Macros
+
+#define ksc4(p1)			 \
+	rol	$24,%ebx		;\
+	mix_col(aes_fl_tab)		;\
+	ror	$8,%ebx			;\
+	xor	4*p1+aes_rcon_tab,%eax	;\
+	xor	%eax,%esi		;\
+	xor	%esi,%ebp		;\
+	mov	%esi,16*p1(%edi)	;\
+	mov	%ebp,16*p1+4(%edi)	;\
+	xor	%ebp,%edx		;\
+	xor	%edx,%ebx		;\
+	mov	%edx,16*p1+8(%edi)	;\
+	mov	%ebx,16*p1+12(%edi)
+
+#define ksc6(p1)			 \
+	rol	$24,%ebx		;\
+	mix_col(aes_fl_tab)		;\
+	ror	$8,%ebx			;\
+	xor	4*p1+aes_rcon_tab,%eax	;\
+	xor	24*p1-24(%edi),%eax	;\
+	mov	%eax,24*p1(%edi)	;\
+	xor	24*p1-20(%edi),%eax	;\
+	mov	%eax,24*p1+4(%edi)	;\
+	xor	%eax,%esi		;\
+	xor	%esi,%ebp		;\
+	mov	%esi,24*p1+8(%edi)	;\
+	mov	%ebp,24*p1+12(%edi)	;\
+	xor	%ebp,%edx		;\
+	xor	%edx,%ebx		;\
+	mov	%edx,24*p1+16(%edi)	;\
+	mov	%ebx,24*p1+20(%edi)
+
+#define ksc8(p1)			 \
+	rol	$24,%ebx		;\
+	mix_col(aes_fl_tab)		;\
+	ror	$8,%ebx			;\
+	xor	4*p1+aes_rcon_tab,%eax	;\
+	xor	32*p1-32(%edi),%eax	;\
+	mov	%eax,32*p1(%edi)	;\
+	xor	32*p1-28(%edi),%eax	;\
+	mov	%eax,32*p1+4(%edi)	;\
+	xor	32*p1-24(%edi),%eax	;\
+	mov	%eax,32*p1+8(%edi)	;\
+	xor	32*p1-20(%edi),%eax	;\
+	mov	%eax,32*p1+12(%edi)	;\
+	push	%ebx			;\
+	mov	%eax,%ebx		;\
+	mix_col(aes_fl_tab)		;\
+	pop	%ebx			;\
+	xor	%eax,%esi		;\
+	xor	%esi,%ebp		;\
+	mov	%esi,32*p1+16(%edi)	;\
+	mov	%ebp,32*p1+20(%edi)	;\
+	xor	%ebp,%edx		;\
+	xor	%edx,%ebx		;\
+	mov	%edx,32*p1+24(%edi)	;\
+	mov	%ebx,32*p1+28(%edi)
+
+	.align	ALIGN32BYTES
+aes_set_key:
+	pushfl
+	push	%ebp
+	mov	%esp,%ebp
+	sub	$slen,%esp
+	push	%ebx
+	push	%esi
+	push	%edi
+
+	mov	aes_cx(%ebp),%edx	// edx -> AES context
+
+	mov	key_ln(%ebp),%ecx	// key length
+	cmpl	$128,%ecx
+	jb	aes_30
+	shr	$3,%ecx
+aes_30:	cmpl	$32,%ecx
+	je	aes_32
+	cmpl	$24,%ecx
+	je	aes_32
+	mov	$16,%ecx
+aes_32:	shr	$2,%ecx
+	mov	%ecx,nkey(%edx)
+
+	lea	6(%ecx),%eax		// 10/12/14 for 4/6/8 32-bit key length
+	mov	%eax,nrnd(%edx)
+
+	mov	in_key(%ebp),%esi	// key input array
+	lea	ekey(%edx),%edi		// key position in AES context
+	cld
+	push	%ebp
+	mov	%ecx,%eax		// save key length in eax
+	rep ;	movsl			// words in the key schedule
+	mov	-4(%esi),%ebx		// put some values in registers
+	mov	-8(%esi),%edx		// to allow faster code
+	mov	-12(%esi),%ebp
+	mov	-16(%esi),%esi
+
+	cmpl	$4,%eax			// jump on key size
+	je	aes_36
+	cmpl	$6,%eax
+	je	aes_35
+
+	ksc8(0)
+	ksc8(1)
+	ksc8(2)
+	ksc8(3)
+	ksc8(4)
+	ksc8(5)
+	ksc8(6)
+	jmp	aes_37
+aes_35:	ksc6(0)
+	ksc6(1)
+	ksc6(2)
+	ksc6(3)
+	ksc6(4)
+	ksc6(5)
+	ksc6(6)
+	ksc6(7)
+	jmp	aes_37
+aes_36:	ksc4(0)
+	ksc4(1)
+	ksc4(2)
+	ksc4(3)
+	ksc4(4)
+	ksc4(5)
+	ksc4(6)
+	ksc4(7)
+	ksc4(8)
+	ksc4(9)
+aes_37:	pop	%ebp
+	mov	aes_cx(%ebp),%edx	// edx -> AES context
+	cmpl	$0,ed_flg(%ebp)
+	jne	aes_39
+
+// compile decryption key schedule from encryption schedule - reverse
+// order and do mix_column operation on round keys except first and last
+
+	mov	nrnd(%edx),%eax		// kt =3D cx->d_key + nc * cx->Nrnd
+	shl	$2,%eax
+	lea	dkey(%edx,%eax,4),%edi
+	lea	ekey(%edx),%esi		// kf =3D cx->e_key
+
+	movsl				// copy first round key (unmodified)
+	movsl
+	movsl
+	movsl
+	sub	$32,%edi
+	movl	$1,cnt(%ebp)
+aes_38:					// do mix column on each column of
+	lodsl				// each round key
+	mov	%eax,%ebx
+	mix_col(aes_im_tab)
+	stosl
+	lodsl
+	mov	%eax,%ebx
+	mix_col(aes_im_tab)
+	stosl
+	lodsl
+	mov	%eax,%ebx
+	mix_col(aes_im_tab)
+	stosl
+	lodsl
+	mov	%eax,%ebx
+	mix_col(aes_im_tab)
+	stosl
+	sub	$32,%edi
+
+	incl	cnt(%ebp)
+	mov	cnt(%ebp),%eax
+	cmp	nrnd(%edx),%eax
+	jb	aes_38
+
+	movsl				// copy last round key (unmodified)
+	movsl
+	movsl
+	movsl
+aes_39:	pop	%edi
+	pop	%esi
+	pop	%ebx
+	mov	%ebp,%esp
+	pop	%ebp
+	popfl
+	ret
+
+
+// finite field multiplies by {02}, {04} and {08}
+
+#define f2(x)	((x<<1)^(((x>>7)&1)*0x11b))
+#define f4(x)	((x<<2)^(((x>>6)&1)*0x11b)^(((x>>6)&2)*0x11b))
+#define f8(x)	((x<<3)^(((x>>5)&1)*0x11b)^(((x>>5)&2)*0x11b)^(((x>>5)&4)*0x=
11b))
+
+// finite field multiplies required in table generation
+
+#define f3(x)	(f2(x) ^ x)
+#define f9(x)	(f8(x) ^ x)
+#define fb(x)	(f8(x) ^ f2(x) ^ x)
+#define fd(x)	(f8(x) ^ f4(x) ^ x)
+#define fe(x)	(f8(x) ^ f4(x) ^ f2(x))
+
+// These defines generate the forward table entries
+
+#define u0(x)	((f3(x) << 24) | (x << 16) | (x << 8) | f2(x))
+#define u1(x)	((x << 24) | (x << 16) | (f2(x) << 8) | f3(x))
+#define u2(x)	((x << 24) | (f2(x) << 16) | (f3(x) << 8) | x)
+#define u3(x)	((f2(x) << 24) | (f3(x) << 16) | (x << 8) | x)
+
+// These defines generate the inverse table entries
+
+#define v0(x)	((fb(x) << 24) | (fd(x) << 16) | (f9(x) << 8) | fe(x))
+#define v1(x)	((fd(x) << 24) | (f9(x) << 16) | (fe(x) << 8) | fb(x))
+#define v2(x)	((f9(x) << 24) | (fe(x) << 16) | (fb(x) << 8) | fd(x))
+#define v3(x)	((fe(x) << 24) | (fb(x) << 16) | (fd(x) << 8) | f9(x))
+
+// These defines generate entries for the last round tables
+
+#define w0(x)	(x)
+#define w1(x)	(x <<  8)
+#define w2(x)	(x << 16)
+#define w3(x)	(x << 24)
+
+// macro to generate inverse mix column tables (needed for the key schedul=
e)
+
+#define im_data0(p1) \
+	.long	p1(0x00),p1(0x01),p1(0x02),p1(0x03),p1(0x04),p1(0x05),p1(0x06),p1(0=
x07) ;\
+	.long	p1(0x08),p1(0x09),p1(0x0a),p1(0x0b),p1(0x0c),p1(0x0d),p1(0x0e),p1(0=
x0f) ;\
+	.long	p1(0x10),p1(0x11),p1(0x12),p1(0x13),p1(0x14),p1(0x15),p1(0x16),p1(0=
x17) ;\
+	.long	p1(0x18),p1(0x19),p1(0x1a),p1(0x1b),p1(0x1c),p1(0x1d),p1(0x1e),p1(0=
x1f)
+#define im_data1(p1) \
+	.long	p1(0x20),p1(0x21),p1(0x22),p1(0x23),p1(0x24),p1(0x25),p1(0x26),p1(0=
x27) ;\
+	.long	p1(0x28),p1(0x29),p1(0x2a),p1(0x2b),p1(0x2c),p1(0x2d),p1(0x2e),p1(0=
x2f) ;\
+	.long	p1(0x30),p1(0x31),p1(0x32),p1(0x33),p1(0x34),p1(0x35),p1(0x36),p1(0=
x37) ;\
+	.long	p1(0x38),p1(0x39),p1(0x3a),p1(0x3b),p1(0x3c),p1(0x3d),p1(0x3e),p1(0=
x3f)
+#define im_data2(p1) \
+	.long	p1(0x40),p1(0x41),p1(0x42),p1(0x43),p1(0x44),p1(0x45),p1(0x46),p1(0=
x47) ;\
+	.long	p1(0x48),p1(0x49),p1(0x4a),p1(0x4b),p1(0x4c),p1(0x4d),p1(0x4e),p1(0=
x4f) ;\
+	.long	p1(0x50),p1(0x51),p1(0x52),p1(0x53),p1(0x54),p1(0x55),p1(0x56),p1(0=
x57) ;\
+	.long	p1(0x58),p1(0x59),p1(0x5a),p1(0x5b),p1(0x5c),p1(0x5d),p1(0x5e),p1(0=
x5f)
+#define im_data3(p1) \
+	.long	p1(0x60),p1(0x61),p1(0x62),p1(0x63),p1(0x64),p1(0x65),p1(0x66),p1(0=
x67) ;\
+	.long	p1(0x68),p1(0x69),p1(0x6a),p1(0x6b),p1(0x6c),p1(0x6d),p1(0x6e),p1(0=
x6f) ;\
+	.long	p1(0x70),p1(0x71),p1(0x72),p1(0x73),p1(0x74),p1(0x75),p1(0x76),p1(0=
x77) ;\
+	.long	p1(0x78),p1(0x79),p1(0x7a),p1(0x7b),p1(0x7c),p1(0x7d),p1(0x7e),p1(0=
x7f)
+#define im_data4(p1) \
+	.long	p1(0x80),p1(0x81),p1(0x82),p1(0x83),p1(0x84),p1(0x85),p1(0x86),p1(0=
x87) ;\
+	.long	p1(0x88),p1(0x89),p1(0x8a),p1(0x8b),p1(0x8c),p1(0x8d),p1(0x8e),p1(0=
x8f) ;\
+	.long	p1(0x90),p1(0x91),p1(0x92),p1(0x93),p1(0x94),p1(0x95),p1(0x96),p1(0=
x97) ;\
+	.long	p1(0x98),p1(0x99),p1(0x9a),p1(0x9b),p1(0x9c),p1(0x9d),p1(0x9e),p1(0=
x9f)
+#define im_data5(p1) \
+	.long	p1(0xa0),p1(0xa1),p1(0xa2),p1(0xa3),p1(0xa4),p1(0xa5),p1(0xa6),p1(0=
xa7) ;\
+	.long	p1(0xa8),p1(0xa9),p1(0xaa),p1(0xab),p1(0xac),p1(0xad),p1(0xae),p1(0=
xaf) ;\
+	.long	p1(0xb0),p1(0xb1),p1(0xb2),p1(0xb3),p1(0xb4),p1(0xb5),p1(0xb6),p1(0=
xb7) ;\
+	.long	p1(0xb8),p1(0xb9),p1(0xba),p1(0xbb),p1(0xbc),p1(0xbd),p1(0xbe),p1(0=
xbf)
+#define im_data6(p1) \
+	.long	p1(0xc0),p1(0xc1),p1(0xc2),p1(0xc3),p1(0xc4),p1(0xc5),p1(0xc6),p1(0=
xc7) ;\
+	.long	p1(0xc8),p1(0xc9),p1(0xca),p1(0xcb),p1(0xcc),p1(0xcd),p1(0xce),p1(0=
xcf) ;\
+	.long	p1(0xd0),p1(0xd1),p1(0xd2),p1(0xd3),p1(0xd4),p1(0xd5),p1(0xd6),p1(0=
xd7) ;\
+	.long	p1(0xd8),p1(0xd9),p1(0xda),p1(0xdb),p1(0xdc),p1(0xdd),p1(0xde),p1(0=
xdf)
+#define im_data7(p1) \
+	.long	p1(0xe0),p1(0xe1),p1(0xe2),p1(0xe3),p1(0xe4),p1(0xe5),p1(0xe6),p1(0=
xe7) ;\
+	.long	p1(0xe8),p1(0xe9),p1(0xea),p1(0xeb),p1(0xec),p1(0xed),p1(0xee),p1(0=
xef) ;\
+	.long	p1(0xf0),p1(0xf1),p1(0xf2),p1(0xf3),p1(0xf4),p1(0xf5),p1(0xf6),p1(0=
xf7) ;\
+	.long	p1(0xf8),p1(0xf9),p1(0xfa),p1(0xfb),p1(0xfc),p1(0xfd),p1(0xfe),p1(0=
xff)
+
+// S-box data - 256 entries
+
+#define sb_data0(p1) \
+	.long	p1(0x63),p1(0x7c),p1(0x77),p1(0x7b),p1(0xf2),p1(0x6b),p1(0x6f),p1(0=
xc5) ;\
+	.long	p1(0x30),p1(0x01),p1(0x67),p1(0x2b),p1(0xfe),p1(0xd7),p1(0xab),p1(0=
x76) ;\
+	.long	p1(0xca),p1(0x82),p1(0xc9),p1(0x7d),p1(0xfa),p1(0x59),p1(0x47),p1(0=
xf0) ;\
+	.long	p1(0xad),p1(0xd4),p1(0xa2),p1(0xaf),p1(0x9c),p1(0xa4),p1(0x72),p1(0=
xc0)
+#define sb_data1(p1) \
+	.long	p1(0xb7),p1(0xfd),p1(0x93),p1(0x26),p1(0x36),p1(0x3f),p1(0xf7),p1(0=
xcc) ;\
+	.long	p1(0x34),p1(0xa5),p1(0xe5),p1(0xf1),p1(0x71),p1(0xd8),p1(0x31),p1(0=
x15) ;\
+	.long	p1(0x04),p1(0xc7),p1(0x23),p1(0xc3),p1(0x18),p1(0x96),p1(0x05),p1(0=
x9a) ;\
+	.long	p1(0x07),p1(0x12),p1(0x80),p1(0xe2),p1(0xeb),p1(0x27),p1(0xb2),p1(0=
x75)
+#define sb_data2(p1) \
+	.long	p1(0x09),p1(0x83),p1(0x2c),p1(0x1a),p1(0x1b),p1(0x6e),p1(0x5a),p1(0=
xa0) ;\
+	.long	p1(0x52),p1(0x3b),p1(0xd6),p1(0xb3),p1(0x29),p1(0xe3),p1(0x2f),p1(0=
x84) ;\
+	.long	p1(0x53),p1(0xd1),p1(0x00),p1(0xed),p1(0x20),p1(0xfc),p1(0xb1),p1(0=
x5b) ;\
+	.long	p1(0x6a),p1(0xcb),p1(0xbe),p1(0x39),p1(0x4a),p1(0x4c),p1(0x58),p1(0=
xcf)
+#define sb_data3(p1) \
+	.long	p1(0xd0),p1(0xef),p1(0xaa),p1(0xfb),p1(0x43),p1(0x4d),p1(0x33),p1(0=
x85) ;\
+	.long	p1(0x45),p1(0xf9),p1(0x02),p1(0x7f),p1(0x50),p1(0x3c),p1(0x9f),p1(0=
xa8) ;\
+	.long	p1(0x51),p1(0xa3),p1(0x40),p1(0x8f),p1(0x92),p1(0x9d),p1(0x38),p1(0=
xf5) ;\
+	.long	p1(0xbc),p1(0xb6),p1(0xda),p1(0x21),p1(0x10),p1(0xff),p1(0xf3),p1(0=
xd2)
+#define sb_data4(p1) \
+	.long	p1(0xcd),p1(0x0c),p1(0x13),p1(0xec),p1(0x5f),p1(0x97),p1(0x44),p1(0=
x17) ;\
+	.long	p1(0xc4),p1(0xa7),p1(0x7e),p1(0x3d),p1(0x64),p1(0x5d),p1(0x19),p1(0=
x73) ;\
+	.long	p1(0x60),p1(0x81),p1(0x4f),p1(0xdc),p1(0x22),p1(0x2a),p1(0x90),p1(0=
x88) ;\
+	.long	p1(0x46),p1(0xee),p1(0xb8),p1(0x14),p1(0xde),p1(0x5e),p1(0x0b),p1(0=
xdb)
+#define sb_data5(p1) \
+	.long	p1(0xe0),p1(0x32),p1(0x3a),p1(0x0a),p1(0x49),p1(0x06),p1(0x24),p1(0=
x5c) ;\
+	.long	p1(0xc2),p1(0xd3),p1(0xac),p1(0x62),p1(0x91),p1(0x95),p1(0xe4),p1(0=
x79) ;\
+	.long	p1(0xe7),p1(0xc8),p1(0x37),p1(0x6d),p1(0x8d),p1(0xd5),p1(0x4e),p1(0=
xa9) ;\
+	.long	p1(0x6c),p1(0x56),p1(0xf4),p1(0xea),p1(0x65),p1(0x7a),p1(0xae),p1(0=
x08)
+#define sb_data6(p1) \
+	.long	p1(0xba),p1(0x78),p1(0x25),p1(0x2e),p1(0x1c),p1(0xa6),p1(0xb4),p1(0=
xc6) ;\
+	.long	p1(0xe8),p1(0xdd),p1(0x74),p1(0x1f),p1(0x4b),p1(0xbd),p1(0x8b),p1(0=
x8a) ;\
+	.long	p1(0x70),p1(0x3e),p1(0xb5),p1(0x66),p1(0x48),p1(0x03),p1(0xf6),p1(0=
x0e) ;\
+	.long	p1(0x61),p1(0x35),p1(0x57),p1(0xb9),p1(0x86),p1(0xc1),p1(0x1d),p1(0=
x9e)
+#define sb_data7(p1) \
+	.long	p1(0xe1),p1(0xf8),p1(0x98),p1(0x11),p1(0x69),p1(0xd9),p1(0x8e),p1(0=
x94) ;\
+	.long	p1(0x9b),p1(0x1e),p1(0x87),p1(0xe9),p1(0xce),p1(0x55),p1(0x28),p1(0=
xdf) ;\
+	.long	p1(0x8c),p1(0xa1),p1(0x89),p1(0x0d),p1(0xbf),p1(0xe6),p1(0x42),p1(0=
x68) ;\
+	.long	p1(0x41),p1(0x99),p1(0x2d),p1(0x0f),p1(0xb0),p1(0x54),p1(0xbb),p1(0=
x16)
+
+// Inverse S-box data - 256 entries
+
+#define ib_data0(p1) \
+	.long	p1(0x52),p1(0x09),p1(0x6a),p1(0xd5),p1(0x30),p1(0x36),p1(0xa5),p1(0=
x38) ;\
+	.long	p1(0xbf),p1(0x40),p1(0xa3),p1(0x9e),p1(0x81),p1(0xf3),p1(0xd7),p1(0=
xfb) ;\
+	.long	p1(0x7c),p1(0xe3),p1(0x39),p1(0x82),p1(0x9b),p1(0x2f),p1(0xff),p1(0=
x87) ;\
+	.long	p1(0x34),p1(0x8e),p1(0x43),p1(0x44),p1(0xc4),p1(0xde),p1(0xe9),p1(0=
xcb)
+#define ib_data1(p1) \
+	.long	p1(0x54),p1(0x7b),p1(0x94),p1(0x32),p1(0xa6),p1(0xc2),p1(0x23),p1(0=
x3d) ;\
+	.long	p1(0xee),p1(0x4c),p1(0x95),p1(0x0b),p1(0x42),p1(0xfa),p1(0xc3),p1(0=
x4e) ;\
+	.long	p1(0x08),p1(0x2e),p1(0xa1),p1(0x66),p1(0x28),p1(0xd9),p1(0x24),p1(0=
xb2) ;\
+	.long	p1(0x76),p1(0x5b),p1(0xa2),p1(0x49),p1(0x6d),p1(0x8b),p1(0xd1),p1(0=
x25)
+#define ib_data2(p1) \
+	.long	p1(0x72),p1(0xf8),p1(0xf6),p1(0x64),p1(0x86),p1(0x68),p1(0x98),p1(0=
x16) ;\
+	.long	p1(0xd4),p1(0xa4),p1(0x5c),p1(0xcc),p1(0x5d),p1(0x65),p1(0xb6),p1(0=
x92) ;\
+	.long	p1(0x6c),p1(0x70),p1(0x48),p1(0x50),p1(0xfd),p1(0xed),p1(0xb9),p1(0=
xda) ;\
+	.long	p1(0x5e),p1(0x15),p1(0x46),p1(0x57),p1(0xa7),p1(0x8d),p1(0x9d),p1(0=
x84)
+#define ib_data3(p1) \
+	.long	p1(0x90),p1(0xd8),p1(0xab),p1(0x00),p1(0x8c),p1(0xbc),p1(0xd3),p1(0=
x0a) ;\
+	.long	p1(0xf7),p1(0xe4),p1(0x58),p1(0x05),p1(0xb8),p1(0xb3),p1(0x45),p1(0=
x06) ;\
+	.long	p1(0xd0),p1(0x2c),p1(0x1e),p1(0x8f),p1(0xca),p1(0x3f),p1(0x0f),p1(0=
x02) ;\
+	.long	p1(0xc1),p1(0xaf),p1(0xbd),p1(0x03),p1(0x01),p1(0x13),p1(0x8a),p1(0=
x6b)
+#define ib_data4(p1) \
+	.long	p1(0x3a),p1(0x91),p1(0x11),p1(0x41),p1(0x4f),p1(0x67),p1(0xdc),p1(0=
xea) ;\
+	.long	p1(0x97),p1(0xf2),p1(0xcf),p1(0xce),p1(0xf0),p1(0xb4),p1(0xe6),p1(0=
x73) ;\
+	.long	p1(0x96),p1(0xac),p1(0x74),p1(0x22),p1(0xe7),p1(0xad),p1(0x35),p1(0=
x85) ;\
+	.long	p1(0xe2),p1(0xf9),p1(0x37),p1(0xe8),p1(0x1c),p1(0x75),p1(0xdf),p1(0=
x6e)
+#define ib_data5(p1) \
+	.long	p1(0x47),p1(0xf1),p1(0x1a),p1(0x71),p1(0x1d),p1(0x29),p1(0xc5),p1(0=
x89) ;\
+	.long	p1(0x6f),p1(0xb7),p1(0x62),p1(0x0e),p1(0xaa),p1(0x18),p1(0xbe),p1(0=
x1b) ;\
+	.long	p1(0xfc),p1(0x56),p1(0x3e),p1(0x4b),p1(0xc6),p1(0xd2),p1(0x79),p1(0=
x20) ;\
+	.long	p1(0x9a),p1(0xdb),p1(0xc0),p1(0xfe),p1(0x78),p1(0xcd),p1(0x5a),p1(0=
xf4)
+#define ib_data6(p1) \
+	.long	p1(0x1f),p1(0xdd),p1(0xa8),p1(0x33),p1(0x88),p1(0x07),p1(0xc7),p1(0=
x31) ;\
+	.long	p1(0xb1),p1(0x12),p1(0x10),p1(0x59),p1(0x27),p1(0x80),p1(0xec),p1(0=
x5f) ;\
+	.long	p1(0x60),p1(0x51),p1(0x7f),p1(0xa9),p1(0x19),p1(0xb5),p1(0x4a),p1(0=
x0d) ;\
+	.long	p1(0x2d),p1(0xe5),p1(0x7a),p1(0x9f),p1(0x93),p1(0xc9),p1(0x9c),p1(0=
xef)
+#define ib_data7(p1) \
+	.long	p1(0xa0),p1(0xe0),p1(0x3b),p1(0x4d),p1(0xae),p1(0x2a),p1(0xf5),p1(0=
xb0) ;\
+	.long	p1(0xc8),p1(0xeb),p1(0xbb),p1(0x3c),p1(0x83),p1(0x53),p1(0x99),p1(0=
x61) ;\
+	.long	p1(0x17),p1(0x2b),p1(0x04),p1(0x7e),p1(0xba),p1(0x77),p1(0xd6),p1(0=
x26) ;\
+	.long	p1(0xe1),p1(0x69),p1(0x14),p1(0x63),p1(0x55),p1(0x21),p1(0x0c),p1(0=
x7d)
+
+// The rcon_table (needed for the key schedule)
+//
+// Here is original Dr Brian Gladman's source code:
+//	_rcon_tab:
+//	%assign x   1
+//	%rep 29
+//	    dd  x
+//	%assign x f2(x)
+//	%endrep
+//
+// Here is precomputed output (it's more portable this way):
+
+	.align	ALIGN32BYTES
+aes_rcon_tab:
+	.long	0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80
+	.long	0x1b,0x36,0x6c,0xd8,0xab,0x4d,0x9a,0x2f
+	.long	0x5e,0xbc,0x63,0xc6,0x97,0x35,0x6a,0xd4
+	.long	0xb3,0x7d,0xfa,0xef,0xc5
+
+// The forward xor tables
+
+	.align	ALIGN32BYTES
+aes_ft_tab:
+	sb_data0(u0)
+	sb_data1(u0)
+	sb_data2(u0)
+	sb_data3(u0)
+	sb_data4(u0)
+	sb_data5(u0)
+	sb_data6(u0)
+	sb_data7(u0)
+
+	sb_data0(u1)
+	sb_data1(u1)
+	sb_data2(u1)
+	sb_data3(u1)
+	sb_data4(u1)
+	sb_data5(u1)
+	sb_data6(u1)
+	sb_data7(u1)
+
+	sb_data0(u2)
+	sb_data1(u2)
+	sb_data2(u2)
+	sb_data3(u2)
+	sb_data4(u2)
+	sb_data5(u2)
+	sb_data6(u2)
+	sb_data7(u2)
+
+	sb_data0(u3)
+	sb_data1(u3)
+	sb_data2(u3)
+	sb_data3(u3)
+	sb_data4(u3)
+	sb_data5(u3)
+	sb_data6(u3)
+	sb_data7(u3)
+
+	.align	ALIGN32BYTES
+aes_fl_tab:
+	sb_data0(w0)
+	sb_data1(w0)
+	sb_data2(w0)
+	sb_data3(w0)
+	sb_data4(w0)
+	sb_data5(w0)
+	sb_data6(w0)
+	sb_data7(w0)
+
+	sb_data0(w1)
+	sb_data1(w1)
+	sb_data2(w1)
+	sb_data3(w1)
+	sb_data4(w1)
+	sb_data5(w1)
+	sb_data6(w1)
+	sb_data7(w1)
+
+	sb_data0(w2)
+	sb_data1(w2)
+	sb_data2(w2)
+	sb_data3(w2)
+	sb_data4(w2)
+	sb_data5(w2)
+	sb_data6(w2)
+	sb_data7(w2)
+
+	sb_data0(w3)
+	sb_data1(w3)
+	sb_data2(w3)
+	sb_data3(w3)
+	sb_data4(w3)
+	sb_data5(w3)
+	sb_data6(w3)
+	sb_data7(w3)
+
+// The inverse xor tables
+
+	.align	ALIGN32BYTES
+aes_it_tab:
+	ib_data0(v0)
+	ib_data1(v0)
+	ib_data2(v0)
+	ib_data3(v0)
+	ib_data4(v0)
+	ib_data5(v0)
+	ib_data6(v0)
+	ib_data7(v0)
+
+	ib_data0(v1)
+	ib_data1(v1)
+	ib_data2(v1)
+	ib_data3(v1)
+	ib_data4(v1)
+	ib_data5(v1)
+	ib_data6(v1)
+	ib_data7(v1)
+
+	ib_data0(v2)
+	ib_data1(v2)
+	ib_data2(v2)
+	ib_data3(v2)
+	ib_data4(v2)
+	ib_data5(v2)
+	ib_data6(v2)
+	ib_data7(v2)
+
+	ib_data0(v3)
+	ib_data1(v3)
+	ib_data2(v3)
+	ib_data3(v3)
+	ib_data4(v3)
+	ib_data5(v3)
+	ib_data6(v3)
+	ib_data7(v3)
+
+	.align	ALIGN32BYTES
+aes_il_tab:
+	ib_data0(w0)
+	ib_data1(w0)
+	ib_data2(w0)
+	ib_data3(w0)
+	ib_data4(w0)
+	ib_data5(w0)
+	ib_data6(w0)
+	ib_data7(w0)
+
+	ib_data0(w1)
+	ib_data1(w1)
+	ib_data2(w1)
+	ib_data3(w1)
+	ib_data4(w1)
+	ib_data5(w1)
+	ib_data6(w1)
+	ib_data7(w1)
+
+	ib_data0(w2)
+	ib_data1(w2)
+	ib_data2(w2)
+	ib_data3(w2)
+	ib_data4(w2)
+	ib_data5(w2)
+	ib_data6(w2)
+	ib_data7(w2)
+
+	ib_data0(w3)
+	ib_data1(w3)
+	ib_data2(w3)
+	ib_data3(w3)
+	ib_data4(w3)
+	ib_data5(w3)
+	ib_data6(w3)
+	ib_data7(w3)
+
+// The inverse mix column tables
+
+	.align	ALIGN32BYTES
+aes_im_tab:
+	im_data0(v0)
+	im_data1(v0)
+	im_data2(v0)
+	im_data3(v0)
+	im_data4(v0)
+	im_data5(v0)
+	im_data6(v0)
+	im_data7(v0)
+
+	im_data0(v1)
+	im_data1(v1)
+	im_data2(v1)
+	im_data3(v1)
+	im_data4(v1)
+	im_data5(v1)
+	im_data6(v1)
+	im_data7(v1)
+
+	im_data0(v2)
+	im_data1(v2)
+	im_data2(v2)
+	im_data3(v2)
+	im_data4(v2)
+	im_data5(v2)
+	im_data6(v2)
+	im_data7(v2)
+
+	im_data0(v3)
+	im_data1(v3)
+	im_data2(v3)
+	im_data3(v3)
+	im_data4(v3)
+	im_data5(v3)
+	im_data6(v3)
+	im_data7(v3)
diff --new-file -ru linux-2.6.6-orig/arch/i386/crypto/aes-i586-glue.c linux=
-2.6.6/arch/i386/crypto/aes-i586-glue.c
--- linux-2.6.6-orig/arch/i386/crypto/aes-i586-glue.c	1970-01-01 01:00:00.0=
00000000 +0100
+++ linux-2.6.6/arch/i386/crypto/aes-i586-glue.c	2004-05-14 14:49:24.636266=
552 +0200
@@ -0,0 +1,104 @@
+/*=20
+ *=20
+ * Glue Code for optimized 586 assembler version of AES
+ *
+ * Copyright (c) 2001, Dr Brian Gladman <brg@gladman.uk.net>, Worcester, U=
K.
+ * Copyright (c) 2003, Adam J. Richter <adam@yggdrasil.com> (conversion to
+ * 2.5 API).
+ * Copyright (c) 2003, 2004 Fruhwirth Clemens <clemens@endorphin.org>
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/crypto.h>
+
+#define AES_MIN_KEY_SIZE	16
+#define AES_MAX_KEY_SIZE	32
+#define AES_BLOCK_SIZE		16
+#define AES_KS_LENGTH   4 * AES_BLOCK_SIZE
+#define AES_RC_LENGTH   (9 * AES_BLOCK_SIZE) / 8 - 8
+
+typedef struct
+{
+    u_int32_t	 aes_Nkey;	// the number of words in the key input block
+    u_int32_t	 aes_Nrnd;	// the number of cipher rounds
+    u_int32_t	 aes_e_key[AES_KS_LENGTH];   // the encryption key schedule
+    u_int32_t	 aes_d_key[AES_KS_LENGTH];   // the decryption key schedule
+    u_int32_t	 aes_Ncol;	// the number of columns in the cipher state
+} aes_context;
+
+/*
+ * The Cipher Interface
+ */
+=20
+__attribute__((regparm(0))) void aes_set_key(void *, const unsigned char [=
], const int, const int);
+
+
+
+/* Actually:
+ * extern void aes_encrypt(const aes_context *, unsigned char [], const un=
signed char []);
+ * extern void aes_decrypt(const aes_context *, unsigned char [], const un=
signed char []);
+*/
+=20
+__attribute__((regparm(0))) void aes_encrypt(void*, unsigned char [], cons=
t unsigned char []);
+__attribute__((regparm(0))) void aes_decrypt(void*, unsigned char [], cons=
t unsigned char []);
+
+static int aes_set_key_glue(void *cx, const u8 *key,unsigned int key_lengt=
h, u32 *flags)
+{
+	if(key_length !=3D 16 && key_length !=3D 24 && key_length !=3D 32)
+	{
+ 		*flags |=3D CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -EINVAL;
+	}
+	aes_set_key(cx, key,key_length,0);
+	return 0;
+}
+
+#ifdef CONFIG_REGPARM
+static void aes_encrypt_glue(void* a, unsigned char b[], const unsigned ch=
ar c[]) {
+	aes_encrypt(a,b,c);
+}
+static void aes_decrypt_glue(void* a, unsigned char b[], const unsigned ch=
ar c[]) {
+	aes_decrypt(a,b,c);
+}
+#else
+#define aes_encrypt_glue aes_encrypt
+#define aes_decrypt_glue aes_decrypt
+#endif /* CONFIG_REGPARM */
+
+static struct crypto_alg aes_alg =3D {
+	.cra_name		=3D	"aes",
+	.cra_flags		=3D	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=3D	AES_BLOCK_SIZE,
+	.cra_ctxsize		=3D	sizeof(aes_context),
+	.cra_module		=3D	THIS_MODULE,
+	.cra_list		=3D	LIST_HEAD_INIT(aes_alg.cra_list),
+	.cra_u			=3D	{
+		.cipher =3D {
+			.cia_min_keysize	=3D	AES_MIN_KEY_SIZE,
+			.cia_max_keysize	=3D	AES_MAX_KEY_SIZE,
+			.cia_setkey	   	=3D 	aes_set_key_glue,
+			.cia_encrypt	 	=3D	aes_encrypt_glue,
+			.cia_decrypt	  	=3D	aes_decrypt_glue
+		}
+	}
+};
+
+static int __init aes_init(void)
+{
+	return crypto_register_alg(&aes_alg);
+}
+
+static void __exit aes_fini(void)
+{
+	crypto_unregister_alg(&aes_alg);
+}
+
+module_init(aes_init);
+module_exit(aes_fini);
+
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm, i586 asm optimized");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Fruhwirth Clemens");
+MODULE_ALIAS("aes");
diff --new-file -ru linux-2.6.6-orig/arch/i386/crypto/Makefile linux-2.6.6/=
arch/i386/crypto/Makefile
--- linux-2.6.6-orig/arch/i386/crypto/Makefile	1970-01-01 01:00:00.00000000=
0 +0100
+++ linux-2.6.6/arch/i386/crypto/Makefile	2004-05-13 10:24:36.000000000 +02=
00
@@ -0,0 +1,9 @@
+#=20
+# i386/crypto/Makefile=20
+#=20
+# Arch-specific CryptoAPI modules.
+#=20
+
+obj-$(CONFIG_CRYPTO_AES_586) +=3D aes-i586.o
+
+aes-i586-y :=3D aes-i586-asm.o aes-i586-glue.o
diff --new-file -ru linux-2.6.6-orig/arch/i386/Makefile linux-2.6.6/arch/i3=
86/Makefile
--- linux-2.6.6-orig/arch/i386/Makefile	2004-05-13 08:44:14.000000000 +0200
+++ linux-2.6.6/arch/i386/Makefile	2004-05-13 09:30:46.000000000 +0200
@@ -102,7 +102,8 @@
 libs-y 					+=3D arch/i386/lib/
 core-y					+=3D arch/i386/kernel/ \
 					   arch/i386/mm/ \
-					   arch/i386/$(mcore-y)/
+					   arch/i386/$(mcore-y)/ \
+					   arch/i386/crypto/
 drivers-$(CONFIG_MATH_EMULATION)	+=3D arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+=3D arch/i386/pci/
 # must be linked after kernel/
diff --new-file -ru linux-2.6.6-orig/crypto/Kconfig linux-2.6.6/crypto/Kcon=
fig
--- linux-2.6.6-orig/crypto/Kconfig	2004-05-13 08:44:14.000000000 +0200
+++ linux-2.6.6/crypto/Kconfig	2004-05-13 09:43:49.000000000 +0200
@@ -138,6 +138,26 @@
=20
 	  See http://csrc.nist.gov/CryptoToolkit/aes/ for more information.
=20
+config CRYPTO_AES_586
+	tristate "AES cipher algorithms (586)"
+	depends on CRYPTO && X86 && !X86_64=20
+	help
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael=20
+	  algorithm.
+
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing=20
+	  environments regardless of its use in feedback or non-feedback=20
+	  modes. Its key setup time is excellent, and its key agility is=20
+	  good. Rijndael's very low memory requirements make it very well=20
+	  suited for restricted-space environments, in which it also=20
+	  demonstrates excellent performance. Rijndael's operations are=20
+	  among the easiest to defend against power and timing attacks.=09
+
+	  The AES specifies three key sizes: 128, 192 and 256 bits	 =20
+
+	  See http://csrc.nist.gov/encryption/aes/ for more information.
+
 config CRYPTO_CAST5
 	tristate "CAST5 (CAST-128) cipher algorithm"
 	depends on CRYPTO

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFApMSMW7sr9DEJLk4RAucqAJ9VRaMSNKEVWN7iyQg8XoBWKhqFNgCfVoma
tRBL/H5/cILV1IPIWpTbdgY=
=q2R1
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
