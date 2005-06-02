Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVFBWnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFBWnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVFBWnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:43:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:27076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261487AbVFBWmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:42:51 -0400
Date: Thu, 2 Jun 2005 15:43:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 6/11] s390: in_interrupt vs. in_atomic.
Message-Id: <20050602154333.33df8335.akpm@osdl.org>
In-Reply-To: <20050601180323.GF6418@localhost.localdomain>
References: <20050601180323.GF6418@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> [patch 6/11] s390: in_interrupt vs. in_atomic.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> The condition for no context in do_exception checks for hard and
> soft interrupts by using in_interrupt() but not for preemption.
> This is bad for the users of __copy_from/to_user_inatomic because
> the fault handler might call schedule although the preemption
> count is != 0. Use in_atomic() instead in_interrupt().
> 

hm.  Under what circumstances do you expect this test to trigger?

We have the in_atomic() test in x86's do_page_fault() because as a
super-special case, kmap_atomic() will increment preempt_count() even if
!CONFIG_PREEMPT.  This is how x86 handles faults during
pagecache<->userspace copies into a kmap_atomically-mapped page.  s390
doesn't do any of that.

So.  What's going on in here?

> 
> diffstat:
>  arch/s390/mm/fault.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
> --- linux-2.6/arch/s390/mm/fault.c	2005-06-01 19:42:54.000000000 +0200
> +++ linux-2.6-patched/arch/s390/mm/fault.c	2005-06-01 19:43:18.000000000 +0200
> @@ -207,7 +207,7 @@ do_exception(struct pt_regs *regs, unsig
>  	 * we are not in an interrupt and that there is a 
>  	 * user context.
>  	 */

Comment needs updating...

> -        if (user_address == 0 || in_interrupt() || !mm)
> +        if (user_address == 0 || in_atomic() || !mm)
>                  goto no_context;
>  
>  	/*
