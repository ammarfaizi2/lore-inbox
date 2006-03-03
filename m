Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752172AbWCCCq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbWCCCq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWCCCq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:46:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752172AbWCCCq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:46:26 -0500
Date: Thu, 2 Mar 2006 18:45:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ram.gupta5@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix potential jiffies overflow
Message-Id: <20060302184502.5177c9db.akpm@osdl.org>
In-Reply-To: <20060303.113246.01208537.nemoto@toshiba-tops.co.jp>
References: <20060303.000306.08077845.anemo@mba.ocn.ne.jp>
	<728201270603020843s4feacb1cv3a8acc620e636ffa@mail.gmail.com>
	<20060303.113246.01208537.nemoto@toshiba-tops.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> >>>>> On Thu, 2 Mar 2006 10:43:12 -0600, "Ram Gupta" <ram.gupta5@gmail.com> said:
> >> I found i386 timer_resume is updating jiffies, not jiffies_64.  It
> >> looks there is a potential overflow problem.  Is this a correct
> >> fix?
> 
> ram> The 64-bit jiffies value is not atomic. You need to hold
> ram> xtime_lock to read it.
> 
> OK, and I guess wall_jiffies also needs xtime_lock.
> 
> 
> I found i386 timer_resume is updating jiffies, not jiffies_64.  It
> looks there is a potential overflow problem.  And jiffies_64 and
> wall_jiffies should be protected by xtime_lock.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> index a14d594..9d30747 100644
> --- a/arch/i386/kernel/time.c
> +++ b/arch/i386/kernel/time.c
> @@ -412,9 +412,9 @@ static int timer_resume(struct sys_devic
>  	write_seqlock_irqsave(&xtime_lock, flags);
>  	xtime.tv_sec = sec;
>  	xtime.tv_nsec = 0;
> -	write_sequnlock_irqrestore(&xtime_lock, flags);
> -	jiffies += sleep_length;
> +	jiffies_64 += sleep_length;
>  	wall_jiffies += sleep_length;
> +	write_sequnlock_irqrestore(&xtime_lock, flags);
>  	if (last_timer->resume)
>  		last_timer->resume();
>  	cur_timer = last_timer;

Thanks, that looks like 2.6.16 material.

What happens if the machine slept for more than 49.7 days?

