Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbVIOPMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbVIOPMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVIOPMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:12:42 -0400
Received: from thunk.org ([69.25.196.29]:14735 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030488AbVIOPMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:12:42 -0400
Date: Thu, 15 Sep 2005 11:11:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] s390: kernel stack corruption.
Message-ID: <20050915151119.GB22503@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	peter.oberparleiter@de.ibm.com, linux-kernel@vger.kernel.org
References: <20050915145303.GA5959@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915145303.GA5959@skybase.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 04:53:03PM +0200, Martin Schwidefsky wrote:
> Hi Andrew,
> Peter discoverd another rather critical bug in entry.S.
> This should go into 2.6.14 if possible.

This might be a good thing for the 2.6.13.x stable series.

Regards,

					- Ted

> blue skies,
>   Martin.
> 
> ---
> 
> [patch] s390: kernel stack corruption.
> 
> From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
> 
> When an asynchronous interruption occurs during the execution
> of the 'critical section' within the generic interruption
> handling code (entry.S), a faulty check for a userspace PSW may
> result in a corrupted kernel stack pointer which subsequently
> triggers a stack overflow check.
> 
> Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> diffstat:
>  arch/s390/kernel/entry.S   |    2 +-
>  arch/s390/kernel/entry64.S |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
> --- linux-2.6/arch/s390/kernel/entry64.S	2005-09-15 15:31:03.000000000 +0200
> +++ linux-2.6-patched/arch/s390/kernel/entry64.S	2005-09-15 15:31:26.000000000 +0200
> @@ -101,7 +101,7 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
>  	clc	\psworg+8(8),BASED(.Lcritical_start)
>  	jl	0f
>  	brasl	%r14,cleanup_critical
> -	tm	0(%r12),0x01		# retest problem state after cleanup
> +	tm	1(%r12),0x01		# retest problem state after cleanup
>  	jnz	1f
>  0:	lg	%r14,__LC_ASYNC_STACK	# are we already on the async. stack ?
>  	slgr	%r14,%r15
> diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
> --- linux-2.6/arch/s390/kernel/entry.S	2005-09-15 15:31:03.000000000 +0200
> +++ linux-2.6-patched/arch/s390/kernel/entry.S	2005-09-15 15:31:26.000000000 +0200
> @@ -108,7 +108,7 @@ STACK_SIZE  = 1 << STACK_SHIFT
>  	bl	BASED(0f)
>  	l	%r14,BASED(.Lcleanup_critical)
>  	basr	%r14,%r14
> -	tm	0(%r12),0x01		# retest problem state after cleanup
> +	tm	1(%r12),0x01		# retest problem state after cleanup
>  	bnz	BASED(1f)
>  0:	l	%r14,__LC_ASYNC_STACK	# are we already on the async stack ?
>  	slr	%r14,%r15
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
