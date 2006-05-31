Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWEaDob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWEaDob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWEaDob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:44:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2502 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751608AbWEaDob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:44:31 -0400
Message-ID: <447D1094.20409@zytor.com>
Date: Tue, 30 May 2006 20:42:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Lesiak <chris.lesiak@licor.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.17-rc5 1/2] i386 memcpy: use as few moves as  possible
 for I/O
References: <200605302103_MC3-1-BF0E-59B@compuserve.com>
In-Reply-To: <200605302103_MC3-1-BF0E-59B@compuserve.com>
Content-Type: multipart/mixed;
 boundary="------------080607040506070707060604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607040506070707060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chuck Ebbert wrote:
> Chris Lesiak reported that changes to i386's __memcpy() broke his device
> because it can't handle byte moves and the new code uses them for
> all trailing bytes when the length is not divisible by four.  The old
> code tried to use a 16-bit move and/or a byte move as needed.
> 
> H. Peter Anvin:
> "There are only a few semantics that make sense: fixed 8, 16, 32, or 64
> bits, plus "optimal"; the latter to be used for anything that doesn't
> require a specific transfer size.  Logically, an unqualified
> "memcpy_to/fromio" should be the optimal size (as few transfers as
> possible)"
> 
> So add back the old code as __minimal_memcpy and have IO transfers
> use that.
> 

I was thinking some more about that, and I suspect the "right" way to do 
this looks something like the attached code.  Note that it assymetric, 
and that it's probably too long to inline.

I haven't tested this yet, and I probably won't have time to do so this 
evening.

	-hpa

--------------080607040506070707060604
Content-Type: text/plain;
 name="memcpy_io.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memcpy_io.S"

/*
 * arch/i386/lib/memcpy_io.S
 *
 * The most general form of memory copy to/from I/O space, used for
 * devices which can handle arbitrary transactions with appropriate
 * handling of byte enables.  The goal is to produce the minimum
 * number of naturally aligned transactions on the bus.
 */
	
#include <linux/config.h>
	
	.globl	memcpy_toio
	.type	memcpy_toio, @function
	
memcpy_toio:
	pushl	%edi
	pushl	%esi
	
#ifdef CONFIG_REGPARM
	movl	%eax, %edi
	movl	%edx, %esi
#else	
	movl	12(%esp), %eax
	movl	16(%esp), %edx
	movl	20(%esp), %ecx
#endif

	jecxz	1f
	
	testl	$1, %edi
	jz	2f
	movsb
	decl	%ecx
2:
	cmpl	$2, %ecx
	jb	3f
	testl	$2, %edi
	jz	4f
	movsw
	decl	%ecx
	decl	%ecx
4:
	movl	%ecx, %edx
	shrl	$2, %ecx
	jz	5f
	rep ; movsl
5:
	movl	%edx, %ecx
	testb	$2, %cl
	jz	3f
	movsw
3:
	testb	$1, %cl
	jz	1f
	movsb
1:
	pop	%esi
	pop	%edi
	ret

	.size	memcpy_toio, .-memcpy_toio

	.globl	memcpy_toio
	.type	memcpy_fromio, @function
	
memcpy_fromio:
	pushl	%edi
	pushl	%esi
	
#ifdef CONFIG_REGPARM
	movl	%eax, %edi
	movl	%edx, %esi
#else	
	movl	12(%esp), %eax
	movl	16(%esp), %edx
	movl	20(%esp), %ecx
#endif

	jecxz	1f
	
	testl	$1, %esi
	jz	2f
	movsb
	decl	%ecx
2:
	cmpl	$2, %ecx
	jb	3f
	testl	$2, %esi
	jz	4f
	movsw
	decl	%ecx
	decl	%ecx
4:
	movl	%ecx, %edx
	shrl	$2, %ecx
	jz	5f
	rep ; movsl
5:
	movl	%edx, %ecx
	testb	$2, %cl
	jz	3f
	movsw
3:
	testb	$1, %cl
	jz	1f
	movsb
1:
	pop	%esi
	pop	%edi
	ret

	.size	memcpy_fromio, .-memcpy_fromio

--------------080607040506070707060604--
