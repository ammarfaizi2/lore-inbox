Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWEUGxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWEUGxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 02:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWEUGxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 02:53:00 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:18644 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751491AbWEUGw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 02:52:59 -0400
Date: Sun, 21 May 2006 08:52:48 +0200
From: Peter Lundkvist <p.lundkvist@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Message-ID: <20060521065248.GA5659@localhost>
References: <20060520130326.GA6092@localhost> <20060520103728.6f3b3798.akpm@osdl.org> <20060520225018.GC8490@elf.ucw.cz> <20060520171244.4399bc54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520171244.4399bc54.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 05:12:44PM -0700, Andrew Morton wrote:
> 
> Peter, does this fix it?
> 

Yes, it does fix the problem.

Hopefully we'll see this fix in the next stable update, because
of the risk of data loss.

> 
> From: Andrew Morton <akpm@osdl.org>
> 
> pdflush is carefully designed to ensure that all wakeups have some
> corresponding work to do - if a woken-up pdflush thread discovers that it
> hasn't been given any work to do then this is considered an error.
> 
> That all broke when swsusp came along - because a timer-delivered wakeup to a
> frozen pdflush thread will just get lost.  This causes the pdflush thread to
> get lost as well: the writeback timer is supposed to be re-armed by pdflush in
> process context, but pdflush doesn't execute the callout which does this.
> 
> Fix that up by ignoring the return value from try_to_freeze(): jsut proceed,
> see if we have any work pending and only go back to sleep if that is not the
> case.
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  mm/pdflush.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff -puN mm/pdflush.c~pdflush-handle-resume-wakeups mm/pdflush.c
> --- devel/mm/pdflush.c~pdflush-handle-resume-wakeups	2006-05-20 17:02:21.000000000 -0700
> +++ devel-akpm/mm/pdflush.c	2006-05-20 17:11:25.000000000 -0700
> @@ -104,13 +104,8 @@ static int __pdflush(struct pdflush_work
>  		list_move(&my_work->list, &pdflush_list);
>  		my_work->when_i_went_to_sleep = jiffies;
>  		spin_unlock_irq(&pdflush_lock);
> -
>  		schedule();
> -		if (try_to_freeze()) {
> -			spin_lock_irq(&pdflush_lock);
> -			continue;
> -		}
> -
> +		try_to_freeze();
>  		spin_lock_irq(&pdflush_lock);
>  		if (!list_empty(&my_work->list)) {
>  			printk("pdflush: bogus wakeup!\n");
> @@ -118,7 +113,7 @@ static int __pdflush(struct pdflush_work
>  			continue;
>  		}
>  		if (my_work->fn == NULL) {
> -			printk("pdflush: NULL work function\n");
> +			printk("pflush: resuming\n");
>  			continue;
>  		}
>  		spin_unlock_irq(&pdflush_lock);
> _
> 
> 
> 
