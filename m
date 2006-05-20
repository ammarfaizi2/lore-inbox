Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWETRhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWETRhs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWETRhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 13:37:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751462AbWETRhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 13:37:47 -0400
Date: Sat, 20 May 2006 10:37:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Lundkvist <p.lundkvist@telia.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Message-Id: <20060520103728.6f3b3798.akpm@osdl.org>
In-Reply-To: <20060520130326.GA6092@localhost>
References: <20060520130326.GA6092@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Lundkvist <p.lundkvist@telia.com> wrote:
>
> Hi,
> I have noticed for some time that nr_dirty never drops but
> increases except when VM pressure forces it down. This only
> occurs after a resume, never on a freshly booted system.
> 
> It seems the wb_timer is lost when the timer function is
> trying to start a frozen pdflush thread, and this occurs
> during suspend or resume.
> 
> I have included a patch which work for me. Don't know if the
> test also should include a check for freezing to be safe, ie
>   if ( !frozen(..) && !freezing(..) )
> 
> 
> 
> diff -ru linux-2.6.17.org/mm/pdflush.c linux-2.6.17/mm/pdflush.c
> --- linux-2.6.17.org/mm/pdflush.c	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.17/mm/pdflush.c	2006-05-20 14:22:35.000000000 +0200
> @@ -213,12 +213,16 @@
>  		struct pdflush_work *pdf;
>  
>  		pdf = list_entry(pdflush_list.next, struct pdflush_work, list);
> -		list_del_init(&pdf->list);
> -		if (list_empty(&pdflush_list))
> -			last_empty_jifs = jiffies;
> -		pdf->fn = fn;
> -		pdf->arg0 = arg0;
> -		wake_up_process(pdf->who);
> +		if (!frozen(pdf->who)) {
> +			list_del_init(&pdf->list);
> +			if (list_empty(&pdflush_list))
> +				last_empty_jifs = jiffies;
> +			pdf->fn = fn;
> +			pdf->arg0 = arg0;
> +			wake_up_process(pdf->who);
> +		}
> +		else
> +			ret = -1;
>  		spin_unlock_irqrestore(&pdflush_lock, flags);
>  	}
>  	return ret;

Maybe the code over in page-writeback.c should just rearm the timee within
the timer handler rather than waiting for a pdflush thread to do it.  I'll
think about that.

But the main questions is: what on earth is going on here?  We've taken a
kernel thread and we've done a wake_up_process() on it, but because it was
in a frozen state it just never gets to run, even after the resume. 
Presumably it goes back into interruptible sleep after the resume.  We took
it off the list (in the expectation that it'd run again) so we've lost
control of it.

Pavel, Rafael: this amounts to a lost wakeup.  What's the story?
