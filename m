Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbVBEOdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbVBEOdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbVBEOdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:33:53 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:19632 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S273712AbVBEOdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:33:04 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manish Lachwani <mlachwani@mvista.com>
In-Reply-To: <20050205075936.GA22103@elte.hu>
References: <20041207141123.GA12025@elte.hu>
	 <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
	 <20050122122915.GA7098@elte.hu> <20050201201402.GA31930@elte.hu>
	 <1107481908.27584.448.camel@localhost.localdomain>
	 <1107483490.27584.459.camel@localhost.localdomain>
	 <1107583350.27584.473.camel@localhost.localdomain>
	 <20050205075936.GA22103@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 05 Feb 2005 09:32:44 -0500
Message-Id: <1107613964.27584.481.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-05 at 08:59 +0100, Ingo Molnar wrote:

> hm - i had a fix in this area in the -V0.7 series. Then i thought this
> is a performance fix only and dropped it eventually, but could you give
> it a go - does it fix the deadlock?
> 
> 	Ingo

Yep, it worked! I tried a similar fix earlier but I put the preempt
disable before the setting of q->status (duh!) and it didn't work. But
it was late and I was tired of looking at it.  I was about to say that I
already tried it, but then noticed the placement of preempt_disable, and
thought, I better try yours anyway. Well, it seems to fix it. By the
way, I just put in the disable and enable in -37. I haven't gotten to
your 38 yet, but this fixed 37.

Thanks,

-- Steve

> 
> --- linux/ipc/sem.c.orig
> +++ linux/ipc/sem.c
> @@ -359,12 +371,18 @@ static void update_queue (struct sem_arr
>  			struct sem_queue *n;
>  			remove_from_queue(sma,q);
>  			n = q->next;
> +			/*
> +			 * Make sure that the wakeup doesnt preempt
> +			 * _this_ CPU prematurely. (on PREEMPT_RT)
> +			 */
> +			preempt_disable();
>  			q->status = IN_WAKEUP;
>  			wake_up_process(q->sleeper);
>  			/* hands-off: q will disappear immediately after
>  			 * writing q->status.
>  			 */
>  			q->status = error;
> +			preempt_enable();
>  			q = n;
>  		} else {
>  			q = q->next;

