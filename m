Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWFPVYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWFPVYC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWFPVYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:24:02 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:21400 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751507AbWFPVYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:24:01 -0400
Date: Fri, 16 Jun 2006 23:24:10 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, p.lundkvist@telia.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, Mark Lord <lkml@rtr.ca>
Message-ID: <20060616212410.GA6821@linuxtv.org>
References: <20060520130326.GA6092@localhost> <20060520103728.6f3b3798.akpm@osdl.org> <20060520225018.GC8490@elf.ucw.cz> <20060520171244.4399bc54.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520171244.4399bc54.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.235.27
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006, Andrew Morton wrote:
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


I've tested this patch for about a week now, by applying it to
the 2.6.17-rc3 kernel on my laptop, which I've been using
for more than a month now. This patch seems to cure the
mysterious symptoms reported in February:

http://lkml.org/lkml/2006/2/6/167
http://lkml.org/lkml/2006/2/6/170
http://lkml.org/lkml/2006/2/13/424
etc.

Actually I didn't remember to check "Dirty:" in /proc/meminfo,
but when I "sync"ed at the end of my workday, just prior to
swsupending it, sync returned immediately. with unpatched
2.6.17-rc3, sync would take half a minute. Maybe Mark can give
this patch a spin to check if it cures his problem, too.
(I still use vmware, so vmware was not the culprit.)


Thanks,
Johannes


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
> 
