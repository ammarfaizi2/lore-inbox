Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbWFWBki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWFWBki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWFWBki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:40:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932763AbWFWBkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:40:37 -0400
Date: Thu, 22 Jun 2006 18:40:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [patch] lock validator: rtmutex unlock order annotation
Message-Id: <20060622184025.3110879c.akpm@osdl.org>
In-Reply-To: <20060622085706.GA29136@elte.hu>
References: <20060622085706.GA29136@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 10:57:06 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> rtmutex.c does a tricky piece of 'lock chain' logic spiced with trylock,
> which has one particular codepath where we intentionally release the
> locks in a different order as acquired. Annotate this for the lock
> validator to not complain if CONFIG_DEBUG_NON_NESTED_UNLOCKS=y.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/rtmutex.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux/kernel/rtmutex.c
> ===================================================================
> --- linux.orig/kernel/rtmutex.c
> +++ linux/kernel/rtmutex.c
> @@ -243,7 +243,8 @@ static int rt_mutex_adjust_prio_chain(ta
>  	plist_add(&waiter->list_entry, &lock->wait_list);
>  
>  	/* Release the task */
> -	spin_unlock_irqrestore(&task->pi_lock, flags);
> +	spin_unlock_non_nested(&task->pi_lock);
> +	local_irq_restore(flags);

y'know, if an innocent civilian were to stumble across this code he or she
would wonder "wtf is that doing"?

He or she would then go to the definition of spin_unlock_non_nested() and
would find it to be 100% comment-free.

IOW, hasty hackery is flying in all directions and the kernel is getting
crappier as a result.

And that's OK for now, because at some stage I'll be dropping the whole lot
so you can redo the series.  But I just don't know what's in there any more
and we'll need to re-changelog, re-document, re-comment and re-review
everything in the for-real patch series.  (ISTR having some minor comments
and questions against the initial patch series?)

We'll need to review it for comprehensibility (hence maintainability).

We'll need to measure the configged-off code size increase.

I think we have quite a long way to go yet on this stuff.
