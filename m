Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUCSNSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUCSNSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:18:21 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:36027 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262951AbUCSNSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:18:15 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: jim.houston@comcast.net, Andi Kleen <ak@suse.de>
Subject: Re: Fixes for .cfi directives for x86_64 kgdb
Date: Fri, 19 Mar 2004 18:47:43 +0530
User-Agent: KMail/1.5
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <m33c8788ac.fsf@new.localdomain> <m3ekrqdroy.fsf@new.localdomain>
In-Reply-To: <m3ekrqdroy.fsf@new.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403191847.43692.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Checked into kgdb.sourceforge.net cvs tree
-Amit

On Thursday 18 Mar 2004 10:21 pm, Jim Houston wrote:
> On Wed, 2004-03-17 at 18:53, Andi Kleen wrote:
> On 17 Mar 2004 16:37:15 -0500
>
> > Jim Houston <jim.houston@comcast.net> wrote:
> > > The attached patch fixes the .cfi directives for the common_interrupt
> > > path for opteron.  It seems that the existing .cfi directives in this
> > > path only work by accident.
> > >
> > > This patch makes the unwind data make sense and makes gdb/kgdb more
> > > likely to produce a useful stack traces.
> >
> > Thanks. I applied it. The calling.h part gave rejects, but I applied it
> > by hand. It would be nice if you could check in the final kernel if I
> > didn't make a mistake.
>
> Hi Andi, Andrew, Amit,
>
> The attached patch is updated to work with linux-2.6.5-rc1.
>
> Jim Houston - Concurrent Computer Corp.
>
> --
>
> diff -urN linux-2.6.5-rc1-mm2.orig/arch/x86_64/kernel/entry.S
> linux-2.6.5-rc1-mm2/arch/x86_64/kernel/entry.S ---
> linux-2.6.5-rc1-mm2.orig/arch/x86_64/kernel/entry.S	2004-03-18
> 09:37:13.830453136 -0500 +++
> linux-2.6.5-rc1-mm2/arch/x86_64/kernel/entry.S	2004-03-18
> 09:37:29.237110968 -0500 @@ -403,9 +403,9 @@
>  /* 0(%rsp): interrupt number */
>  	.macro interrupt func
>  	CFI_STARTPROC	simple
> -	CFI_DEF_CFA	rsp,(SS-ORIG_RAX)
> -	CFI_OFFSET	rsp,(RSP-SS)
> -	CFI_OFFSET	rip,(RIP-SS)
> +	CFI_DEF_CFA	rsp,(SS-RDI)
> +	CFI_REL_OFFSET	rsp,(RSP-ORIG_RAX)
> +	CFI_REL_OFFSET	rip,(RIP-ORIG_RAX)
>  	cld
>  #ifdef CONFIG_DEBUG_INFO
>  	SAVE_ALL
> diff -urN linux-2.6.5-rc1-mm2.orig/include/asm-x86_64/calling.h
> linux-2.6.5-rc1-mm2/include/asm-x86_64/calling.h ---
> linux-2.6.5-rc1-mm2.orig/include/asm-x86_64/calling.h	2004-03-18
> 09:36:21.635387992 -0500 +++
> linux-2.6.5-rc1-mm2/include/asm-x86_64/calling.h	2004-03-18
> 09:36:05.978768160 -0500 @@ -35,28 +35,28 @@
>  	subq  $9*8+\addskip,%rsp
>  	CFI_ADJUST_CFA_OFFSET	9*8+\addskip
>  	movq  %rdi,8*8(%rsp)
> -	CFI_OFFSET	rdi,8*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	rdi,8*8
>  	movq  %rsi,7*8(%rsp)
> -	CFI_OFFSET	rsi,7*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	rsi,7*8
>  	movq  %rdx,6*8(%rsp)
> -	CFI_OFFSET	rdx,6*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	rdx,6*8
>  	.if \norcx
>  	.else
>  	movq  %rcx,5*8(%rsp)
> -	CFI_OFFSET	rcx,5*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	rcx,5*8
>  	.endif
>  	movq  %rax,4*8(%rsp)
> -	CFI_OFFSET	rax,4*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	rax,4*8
>  	.if \nor891011
>  	.else
>  	movq  %r8,3*8(%rsp)
> -	CFI_OFFSET	r8,3*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	r8,3*8
>  	movq  %r9,2*8(%rsp)
> -	CFI_OFFSET	r9,2*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	r9,2*8
>  	movq  %r10,1*8(%rsp)
> -	CFI_OFFSET	r10,1*8-(9*8+\addskip)
> +	CFI_REL_OFFSET	r10,1*8
>  	movq  %r11,(%rsp)
> -	CFI_OFFSET	r11,-(9*8+\addskip)
> +	CFI_REL_OFFSET	r11,
>  	.endif
>  	.endm
>
> @@ -109,17 +109,17 @@
>  	subq $REST_SKIP,%rsp
>  	CFI_ADJUST_CFA_OFFSET	REST_SKIP
>  	movq %rbx,5*8(%rsp)
> -	CFI_OFFSET	rbx,5*8-(REST_SKIP)
> +	CFI_REL_OFFSET	rbx,5*8
>  	movq %rbp,4*8(%rsp)
> -	CFI_OFFSET	rbp,4*8-(REST_SKIP)
> +	CFI_REL_OFFSET	rbp,4*8
>  	movq %r12,3*8(%rsp)
> -	CFI_OFFSET	r12,3*8-(REST_SKIP)
> +	CFI_REL_OFFSET	r12,3*8
>  	movq %r13,2*8(%rsp)
> -	CFI_OFFSET	r13,2*8-(REST_SKIP)
> +	CFI_REL_OFFSET	r13,2*8
>  	movq %r14,1*8(%rsp)
> -	CFI_OFFSET	r14,1*8-(REST_SKIP)
> +	CFI_REL_OFFSET	r14,1*8
>  	movq %r15,(%rsp)
> -	CFI_OFFSET	r15,0*8-(REST_SKIP)
> +	CFI_REL_OFFSET	r15,0*8
>  	.endm
>
>  	.macro RESTORE_REST

