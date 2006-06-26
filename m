Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbWFZTBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbWFZTBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbWFZTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:01:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932751AbWFZTBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:01:05 -0400
Date: Mon, 26 Jun 2006 12:00:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, peter@palfrader.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] IPMI: use schedule in kthread
Message-Id: <20060626120048.cff87fac.akpm@osdl.org>
In-Reply-To: <20060626140819.GA17804@localdomain>
References: <20060626140819.GA17804@localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 09:08:19 -0500
MAILER-DAEMON@osdl.org wrote:

> The kthread used to speed up polling for IPMI was using udelay
> when the lower-level state machine told it to do a short delay.
> This just used CPU and didn't help scheduling, thus causing bad
> problems with other tasks.  Call schedule() instead.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> 
> Index: linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux-2.6.17.orig/drivers/char/ipmi/ipmi_si_intf.c
> +++ linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
> @@ -809,7 +809,7 @@ static int ipmi_thread(void *data)
>  			/* do nothing */
>  		}
>  		else if (smi_result == SI_SM_CALL_WITH_DELAY)
> -			udelay(1);
> +			schedule();
>  		else
>  			schedule_timeout_interruptible(1);
>  	}

calling schedule() isn't a lot of use either.

If CONFIG_PREEMPT it's of no benefit and will just chew CPU.

If !CONFIG_PREEMPT && !need_resched() then it's a no-op and will chew CPU.

If !CONFIG_PREEMPT && need_resched() then yes, it'll schedule away.  This
is pretty much the only time that a simple schedule() is useful.



What are we actually trying to do in here?
