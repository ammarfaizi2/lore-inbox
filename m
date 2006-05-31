Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWEaXH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWEaXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWEaXH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:07:57 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:31642 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965230AbWEaXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:07:56 -0400
Date: Wed, 31 May 2006 19:01:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.17-rc5 1/2] i386 memcpy: use as few moves as 
  possible for I/O
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Chris Lesiak <chris.lesiak@licor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200605311905_MC3-1-C141-B5CF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <447D1094.20409@zytor.com>

On Tue, 30 May 2006 20:42:12 -0700, H. Peter Anvin wrote:

> I was thinking some more about that, and I suspect the "right" way to do 
> this looks something like the attached code.  Note that it assymetric, 
> and that it's probably too long to inline.
> 
> I haven't tested this yet, and I probably won't have time to do so this 
> evening.

There were some small problems, but I think I fixed them:


/*
 * arch/i386/lib/memcpy_io.S
 *
 * The most general form of memory copy to/from I/O space, used for
 * devices which can handle arbitrary transactions with appropriate
 * handling of byte enables.  The goal is to produce the minimum
 * number of naturally aligned transactions on the bus.
 */
	
#include <linux/config.h>
#include <linux/linkage.h>
	
.macro	build_memcpy_io_fn fn_name,align_reg

	.globl	\fn_name
	.type	\fn_name, @function
	
	ALIGN
\fn_name:

	ebp_space=0
#ifdef CONFIG_FRAME_POINTER
	pushl	%ebp
	movl	%esp,%ebp
	ebp_space=4
#endif

	pushl	%edi
	pushl	%esi
	
#ifdef CONFIG_REGPARM
	movl	%eax, %edi
	movl	%edx, %esi
#else
	movl	12+ebp_space(%esp), %edi
	movl	20+ebp_space(%esp), %ecx
	movl	16+ebp_space(%esp), %esi
#endif

	jecxz	1f
	
	testl	$1, \align_reg
	jz	2f
	movsb
	decl	%ecx
2:
	cmpl	$2, %ecx
	jb	3f
	testl	$2, \align_reg
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

#ifdef CONFIG_FRAME_POINTER
	leave
#endif

	ret

	.size	\fn_name, .-\fn_name

.endm

	build_memcpy_io_fn fn_name=memcpy_fromio,align_reg=%esi
	build_memcpy_io_fn fn_name=memcpy_toio,align_reg=%edi
-- 
Chuck
