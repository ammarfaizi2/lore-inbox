Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVCGDox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVCGDox (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 22:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVCGDox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 22:44:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:6021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261483AbVCGDov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 22:44:51 -0500
Date: Sun, 6 Mar 2005 19:44:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>
Subject: Re: [patch 12/14] drivers/dmapool: use TASK_UNINTERRUPTIBLE instead
 of TASK_INTERRUPTIBLE
Message-Id: <20050306194414.68239e90.akpm@osdl.org>
In-Reply-To: <20050306223654.3EE871EC90@trashy.coderock.org>
References: <20050306223654.3EE871EC90@trashy.coderock.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
>  use TASK_UNINTERRUPTIBLE  instead of TASK_INTERRUPTIBLE
> 
>  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>  Signed-off-by: Domen Puncer <domen@coderock.org>
>  ---
> 
> 
>   kj-domen/drivers/base/dmapool.c |    2 +-
>   1 files changed, 1 insertion(+), 1 deletion(-)
> 
>  diff -puN drivers/base/dmapool.c~task_unint-drivers_base_dmapool drivers/base/dmapool.c
>  --- kj/drivers/base/dmapool.c~task_unint-drivers_base_dmapool	2005-03-05 16:11:21.000000000 +0100
>  +++ kj-domen/drivers/base/dmapool.c	2005-03-05 16:11:21.000000000 +0100
>  @@ -293,7 +293,7 @@ restart:
>   		if (mem_flags & __GFP_WAIT) {
>   			DECLARE_WAITQUEUE (wait, current);
>   
>  -			current->state = TASK_INTERRUPTIBLE;
>  +			set_current_state(TASK_UNINTERRUPTIBLE);
>   			add_wait_queue (&pool->waitq, &wait);
>   			spin_unlock_irqrestore (&pool->lock, flags);

This code is alread a bit odd.  If we're prepared to sleep in there, then
why use GFP_ATOMIC?

If it is so that we can dig a bit deeper into the free page pools then
something like __GFP_WAIT|__GFP_HIGH would be preferable.

And why isn't mem_flags passed into pool_alloc_page() verbatim?

I agree on the TASK_UNINTERRUPTIBLE change: if the calling task happens to
have signal_pending() then the schedule_timeout() will fall right through. 
Why should we change kernel memory allocation strategy if the user hit ^C? 

Also, __set_current_state() can be user here: the add_wait_queue() contains
the necessary barriers.  (Grubby, but we do that in quite a few places with
this particular code sequence (we should have an add_wait_queue() variant
which does the add_wait_queue+__set_current_state all in one hit (but let's
not, else I'll be buried in another 1000 cleanuplets))).

