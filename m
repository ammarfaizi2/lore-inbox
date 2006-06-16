Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWFPXWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWFPXWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWFPXWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:22:46 -0400
Received: from mout1.freenet.de ([194.97.50.132]:1739 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932476AbWFPXWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:22:45 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux@horizon.com
Subject: Re: [PATCH  3/4] Twofish cipher - i586 assembler
Date: Sat, 17 Jun 2006 01:22:42 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060616172901.23566.qmail@science.horizon.com>
In-Reply-To: <20060616172901.23566.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606170122.42788.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 19:29, linux@horizon.com wrote:
> Nice push/pop design!
>
> A couple of questions:
>
> 1) Would it be worth moving encrypt_round's pop %edi earlier, like
>    encrypt_first_round does?  Scheduling loads as early as possible is
>    just good general principles.
I guess i missed that :/. Will be fixed.
>
> 2) Is it really worth having special first & last round definitions?
>
>    encrypt_first round just has one more instruction that encrypt_round
>    (ror $16,%eax) that could be moved to the pre-round setup, thereby
>    eliminating the entire encrypt_first_round macro.
Good idea.
>
>    And the only difference in encrypt_last_round is the absence of a
>    "push b ### D" that could be delayed until the end of the macro and
>    moved into the start of the next encrypt_round.
>
>    Oh... and a change from "rol $15, c ## D" to "ror $1, c ## D".
>    It might be worth living with the single extra instruction for
>    the code simplicity.
There are 2 rotate changes. ( you missed "ror $15,	b ## D;" to "ror $16, b ## 
D;")  That's 2 instructions (expensive ones) vs. a little more simplicity in 
code. Not worth it imho since this patch is aimed for maximum perfomance and 
adding 2 workaround wont make it much simpler to understand, just a little 
less patchsize.
>    Then you'd have a single encrypt_round of:
>
> /*
> a input register containing a (prerotated 16 bits)
> b input register containing b
> c input register containing c
> d input register containing d (prerotated 1 bit left)
> operations on a and b are interleaved to increase performance
> */
> #define encrypt_round(a,b,c,d,round)\
> push	d ## D;\
> movzx	b ## B,		%edi;\
> mov	s1(%ebp,%edi,4),d ## D;\
> movzx	a ## B,		%edi;\
> mov	s2(%ebp,%edi,4),%esi;\
> movzx	b ## H,		%edi;\
> ror	$16,		b ## D;\
> xor	s2(%ebp,%edi,4),d ## D;\
> movzx	a ## H,		%edi;\
> ror	$16,		a ## D;\
> xor	s3(%ebp,%edi,4),%esi;\
> movzx	b ## B,		%edi;\
> xor	s3(%ebp,%edi,4),d ## D;\
> movzx	a ## B,		%edi;\
> xor	(%ebp,%edi,4),	%esi;\
> movzx	b ## H,		%edi;\
> ror	$15,		b ## D;\
> xor	(%ebp,%edi,4),	d ## D;\
> movzx	a ## H,		%edi;\
> xor	s1(%ebp,%edi,4),%esi;\
> pop	%edi;\
> add	d ## D,		%esi;\
> add	%esi,		d ## D;\
> add	k+round(%ebp),	%esi;\
> xor	%esi,		c ## D;\
> rol	$15,		c ## D;\
> add	k+4+round(%ebp),d ## D;\
> xor	%edi,		d ## D;
>
> which would be called by:
> twofish_enc_blk:
> 	push	%ebp			/* save registers according to calling convention*/
> 	push    %edi
> 	push    %ebx
> 	push    %esi
>
> 	mov	ctx + 16(%esp),	%ebp	/* abuse the base pointer: set new base bointer
> to the crypto ctx */ mov     in_blk+16(%esp),%edi	/* input adress in edi */
>
> 	mov	(%edi),		%eax
> 	mov	b_offset(%edi),	%ebx
> 	mov	c_offset(%edi),	%ecx
> 	mov	d_offset(%edi),	%edx
> 	input_whitening(%eax,%ebp,a_offset)
> 	input_whitening(%ebx,%ebp,b_offset)
> 	input_whitening(%ecx,%ebp,c_offset)
> 	input_whitening(%edx,%ebp,d_offset)
> 	rol	$16,		%eax
>
> 	encrypt_round(R0,R1,R2,R3,0)
> 	encrypt_round(R2,R3,R0,R1,8)
> 	encrypt_round(R0,R1,R2,R3,2*8)
> 	encrypt_round(R2,R3,R0,R1,3*8)
> 	encrypt_round(R0,R1,R2,R3,4*8)
> 	encrypt_round(R2,R3,R0,R1,5*8)
> 	encrypt_round(R0,R1,R2,R3,6*8)
> 	encrypt_round(R2,R3,R0,R1,7*8)
> 	encrypt_round(R0,R1,R2,R3,8*8)
> 	encrypt_round(R2,R3,R0,R1,9*8)
> 	encrypt_round(R0,R1,R2,R3,10*8)
> 	encrypt_round(R2,R3,R0,R1,11*8)
> 	encrypt_round(R0,R1,R2,R3,12*8)
> 	encrypt_round(R2,R3,R0,R1,13*8)
> 	encrypt_round(R0,R1,R2,R3,14*8)
> 	encrypt_round(R2,R3,R0,R1,15*8)
>
> 	rol	$16,		%ecx
> 	output_whitening(%eax,%ebp,c_offset)
> 	output_whitening(%ebx,%ebp,d_offset)
> 	output_whitening(%ecx,%ebp,a_offset)
> 	output_whitening(%edx,%ebp,b_offset)
>
> 	mov	out_blk+16(%esp),%edi;
> 	mov	%ecx,		(%edi)
> 	mov	%edx,		b_offset(%edi)
> 	mov	%eax,		c_offset(%edi)
> 	mov	%ebx,		d_offset(%edi)
>
> 	pop	%edi
> 	pop	%esi
> 	pop	%ebx
> 	pop	%ebp
> 	mov	$1,	%eax
> 	ret
>
> I'm also trying to figure out why the encrypt_round and decrypt_round
> macros are different.  Normally, a Feistel cipher just requires that
> the round subkeys be reversed to reverse the cipher; the F function is
> unmodified.
The rotates (1 left and 1 right) at the end of the round are exchanged, while 
the sbox lookups and roundkeys stay the same. This makes a the reuse of the 
code impossible.


