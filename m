Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUEKU20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUEKU20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUEKU20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:28:26 -0400
Received: from fmr04.intel.com ([143.183.121.6]:57269 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263616AbUEKU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:27:20 -0400
Message-Id: <200405112027.i4BKR5F18656@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>
Cc: <geoff@linux.jf.intel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] [PATCH] Performance of del_timer_sync
Date: Tue, 11 May 2004 13:27:07 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQ3lEN7sH5Gd+8hTimOvuBOAbDBCQAAVxlA
In-Reply-To: <20040511131137.2390ffa8.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton wrote on Tuesday, May 11, 2004 1:12 PM
> > > Ingo, why is this not sufficient?
> >
> > it's not sufficient because a timer might be running on another CPU even
> > if it has not been deleted. We delete a timer prior running it (so that
> > the timer fn can re-activate the timer). So del_timer_sync() has to
> > synchronize independently of whether the timer was removed or not.
> >
>
> Ah, OK, the timer handler may re-add itself.  Really, that's a bug in the
> caller: once they've decided to shoot down the timer the caller should have
> made state changes which prevent the handler from re-adding the timer.
>
> Still, too late to change that.
>
> Neither AIO nor schedule_timeout() actually re-add the timer so they don't
> need the full treatment, yes?
>
>
> diff -puN kernel/timer.c~del-timer-speedup kernel/timer.c
> --- 25/kernel/timer.c~del-timer-speedup	2004-05-11 13:05:41.997859088 -0700
> +++ 25-akpm/kernel/timer.c	2004-05-11 13:07:32.493061264 -0700
> @@ -348,8 +348,13 @@ del_again:
>
>  	return ret;
>  }
> -
>  EXPORT_SYMBOL(del_timer_sync);
> +
> +int del_single_shot_timer(struct timer_struct *timer)
> +{
> +	if (del_timer(timer))
> +		del_timer_sync(timer);
> +}
>  #endif

I'm confused, isn't the polarity of del_timer() need to be reversed?
Also propagate the return value of del_timer_sync()?

- Ken


