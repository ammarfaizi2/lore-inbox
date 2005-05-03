Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVECGav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVECGav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 02:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVECGau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 02:30:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:53989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbVECGaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 02:30:08 -0400
Date: Mon, 2 May 2005 23:29:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: benh@kernel.crashing.org, jk@blackdown.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050502232925.752ad1d8.akpm@osdl.org>
In-Reply-To: <426B6C84.E8D41D57@tv-sign.ru>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de>
	<87u0m7aogx.fsf@blackdown.de>
	<1113607416.5462.212.camel@gaston>
	<877jj1aj99.fsf@blackdown.de>
	<20050423170152.6b308c74.akpm@osdl.org>
	<87fyxhj5p1.fsf@blackdown.de>
	<1114308928.5443.13.camel@gaston>
	<426B6C84.E8D41D57@tv-sign.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Benjamin Herrenschmidt wrote:
> >
> > I'll have a look at the timer patch next week, they might have some
> > subtle race caused by a lack of memory barrier. I've had to debug some
> > of those in early timer code, and those are really nasty, they usually
> > only trigger under some subtle conditions, like ... heavy networking.
> 
> Before this timer patch del_timer(pending_timer) worked as
> a memory barrier for the caller, now it does not.
> 
> For example, sk_stop_timer() does:
> 
> 	if (del_timer(timer))
> 		// no more wmb() here
> 		atomic_dec(&sk->sk_refcnt);
> 
> I think that this particular case is ok, but may be there is
> some user of timers which lacks the memory barrier?
> 
> ...
> --- 2.6.12-rc2+timer_patches/kernel/timer.c~	Sun Apr 24 11:59:31 2005
> +++ 2.6.12-rc2+timer_patches/kernel/timer.c	Sun Apr 24 13:35:01 2005
> @@ -341,6 +341,9 @@ int del_timer(struct timer_list *timer)
>  		spin_unlock_irqrestore(&base->lock, flags);
>  	}
>  
> +	if (ret)
> +		smp_wmb();
> +
>  	return ret;
>  }
>  
> @@ -387,6 +390,10 @@ unlock:
>  		spin_unlock_irqrestore(&base->lock, flags);
>  	} while (ret < 0);
>  
> +	if (ret)
> +		smp_wmb();
> +	smp_rmb();
> +
>  	return ret;
>  }
>  
> @@ -457,6 +464,7 @@ repeat:
>  
>  			set_running_timer(base, timer);
>  			detach_timer(timer, 1);
> +			smp_wmb();
>  			spin_unlock_irq(&base->t_base.lock);
>  			{
>  				u32 preempt_count = preempt_count();

I wonder if we should still do this?  It would seem to be a safer approach.

(This barrier stuff continues to give me the creeps.  Imagine being
dependent upon accidental barriers in the add/del/mod_timer code.  Ugh).

