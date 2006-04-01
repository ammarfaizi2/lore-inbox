Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWDAXn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWDAXn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 18:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWDAXn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 18:43:26 -0500
Received: from users.ccur.com ([66.10.65.2]:55520 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932297AbWDAXn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 18:43:26 -0500
Date: Sat, 1 Apr 2006 18:43:13 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Dan Aloni <da-x@monatomic.org>
Cc: Keith Owens <kaos@sgi.com>, Nathan Scott <nathans@sgi.com>,
       kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.16
Message-ID: <20060401234313.GA22482@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <28258.1142920764@kao2.melbourne.sgi.com> <20060401170430.GA14715@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401170430.GA14715@localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 08:04:30PM +0300, Dan Aloni wrote:
> > Current versions are :-
> > 
> >   kdb-v4.4-2.6.16-common-1.bz2
> >   kdb-v4.4-2.6.16-i386-1.bz2
> >   kdb-v4.4-2.6.16-ia64-1.bz2
> 
> Thanks for this new version, however I'm looking forward to see
> kdb maintained also for the x86_64 architecture. Currently I have 
> got as far as forward-porting it to a level where it "works" except 
> for one annoying issue where setjmp/longjmp looks to be broken:

Problem is due to the mixed C/asm implementation of setjmp/longjmp.
Replace that with one written entirely in assemply and it will work.
Here's mine:

/* setjmp / longjmp for the kernel.
 * Inspired by the glibc version.
 */
	.text
	.globl	__kernel_setjmp
	.p2align 4
__kernel_setjmp:
	movq	%rbx,0x0(%rdi)
	movq	%rbp,0x8(%rdi)
	movq	%r12,0x10(%rdi)
	movq	%r13,0x18(%rdi)
	movq	%r14,0x20(%rdi)
	movq	%r15,0x28(%rdi)
	leaq	0x8(%rsp),%rdx
	movq	%rdx,0x30(%rdi)
	movq	(%rsp),%rax
	movq	%rax,0x38(%rdi)
	xorq	%rax,%rax
	ret

	.globl	__kernel_longjmp
__kernel_longjmp:
	movq	0x0(%rdi),%rbx
	movq	0x8(%rdi),%rbp
	movq	0x10(%rdi),%r12
	movq	0x18(%rdi),%r13
	movq	0x20(%rdi),%r14
	movq	0x28(%rdi),%r15
	test	%esi,%esi
	mov	$1,%eax
	cmove	%eax,%esi
	mov	%esi,%eax
	movq	0x38(%rdi),%rdx
	movq	0x30(%rdi),%rsp
	jmpq	*%rdx
