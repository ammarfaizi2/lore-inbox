Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWFPUSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWFPUSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWFPUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 16:18:04 -0400
Received: from science.horizon.com ([192.35.100.1]:64823 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751514AbWFPUSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 16:18:03 -0400
Date: 16 Jun 2006 13:29:01 -0400
Message-ID: <20060616172901.23566.qmail@science.horizon.com>
From: linux@horizon.com
To: jfritschi@freenet.de, linux@horizon.com
Subject: Re: [PATCH  3/4] Twofish cipher - i586 assembler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606081935.14649.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice push/pop design!

A couple of questions:

1) Would it be worth moving encrypt_round's pop %edi earlier, like
   encrypt_first_round does?  Scheduling loads as early as possible is
   just good general principles.

2) Is it really worth having special first & last round definitions?

   encrypt_first round just has one more instruction that encrypt_round
   (ror $16,%eax) that could be moved to the pre-round setup, thereby
   eliminating the entire encrypt_first_round macro.

   And the only difference in encrypt_last_round is the absence of a
   "push b ### D" that could be delayed until the end of the macro and
   moved into the start of the next encrypt_round.

   Oh... and a change from "rol $15, c ## D" to "ror $1, c ## D".
   It might be worth living with the single extra instruction for
   the code simplicity.

   Then you'd have a single encrypt_round of:

/*
a input register containing a (prerotated 16 bits)
b input register containing b
c input register containing c
d input register containing d (prerotated 1 bit left)
operations on a and b are interleaved to increase performance
*/
#define encrypt_round(a,b,c,d,round)\
push	d ## D;\
movzx	b ## B,		%edi;\
mov	s1(%ebp,%edi,4),d ## D;\
movzx	a ## B,		%edi;\
mov	s2(%ebp,%edi,4),%esi;\
movzx	b ## H,		%edi;\
ror	$16,		b ## D;\
xor	s2(%ebp,%edi,4),d ## D;\
movzx	a ## H,		%edi;\
ror	$16,		a ## D;\
xor	s3(%ebp,%edi,4),%esi;\
movzx	b ## B,		%edi;\
xor	s3(%ebp,%edi,4),d ## D;\
movzx	a ## B,		%edi;\
xor	(%ebp,%edi,4),	%esi;\
movzx	b ## H,		%edi;\
ror	$15,		b ## D;\
xor	(%ebp,%edi,4),	d ## D;\
movzx	a ## H,		%edi;\
xor	s1(%ebp,%edi,4),%esi;\
pop	%edi;\
add	d ## D,		%esi;\
add	%esi,		d ## D;\
add	k+round(%ebp),	%esi;\
xor	%esi,		c ## D;\
rol	$15,		c ## D;\
add	k+4+round(%ebp),d ## D;\
xor	%edi,		d ## D;

which would be called by:
twofish_enc_blk:
	push	%ebp			/* save registers according to calling convention*/
	push    %edi
	push    %ebx
	push    %esi			
		
	mov	ctx + 16(%esp),	%ebp	/* abuse the base pointer: set new base bointer to the crypto ctx */
	mov     in_blk+16(%esp),%edi	/* input adress in edi */

	mov	(%edi),		%eax
	mov	b_offset(%edi),	%ebx
	mov	c_offset(%edi),	%ecx
	mov	d_offset(%edi),	%edx
	input_whitening(%eax,%ebp,a_offset)
	input_whitening(%ebx,%ebp,b_offset)
	input_whitening(%ecx,%ebp,c_offset)
	input_whitening(%edx,%ebp,d_offset)
	rol	$16,		%eax

	encrypt_round(R0,R1,R2,R3,0)
	encrypt_round(R2,R3,R0,R1,8)
	encrypt_round(R0,R1,R2,R3,2*8)
	encrypt_round(R2,R3,R0,R1,3*8)
	encrypt_round(R0,R1,R2,R3,4*8)
	encrypt_round(R2,R3,R0,R1,5*8)
	encrypt_round(R0,R1,R2,R3,6*8)
	encrypt_round(R2,R3,R0,R1,7*8)
	encrypt_round(R0,R1,R2,R3,8*8)
	encrypt_round(R2,R3,R0,R1,9*8)
	encrypt_round(R0,R1,R2,R3,10*8)
	encrypt_round(R2,R3,R0,R1,11*8)
	encrypt_round(R0,R1,R2,R3,12*8)
	encrypt_round(R2,R3,R0,R1,13*8)
	encrypt_round(R0,R1,R2,R3,14*8)
	encrypt_round(R2,R3,R0,R1,15*8)

	rol	$16,		%ecx
	output_whitening(%eax,%ebp,c_offset)
	output_whitening(%ebx,%ebp,d_offset)
	output_whitening(%ecx,%ebp,a_offset)
	output_whitening(%edx,%ebp,b_offset)

	mov	out_blk+16(%esp),%edi;
	mov	%ecx,		(%edi)
	mov	%edx,		b_offset(%edi)
	mov	%eax,		c_offset(%edi)
	mov	%ebx,		d_offset(%edi)

	pop	%edi
	pop	%esi
	pop	%ebx
	pop	%ebp
	mov	$1,	%eax
	ret

I'm also trying to figure out why the encrypt_round and decrypt_round
macros are different.  Normally, a Feistel cipher just requires that
the round subkeys be reversed to reverse the cipher; the F function is
unmodified.
