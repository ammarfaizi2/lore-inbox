Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWATQjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWATQjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWATQjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:39:18 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:42220 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751069AbWATQjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:39:17 -0500
Message-ID: <43D110C3.6020604@wildturkeyranch.net>
Date: Fri, 20 Jan 2006 08:33:07 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@mwildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/7] [hrtimers] Set correct initial expiry time for relative
 SIGEV_NONE timers
References: <20060120021336.134802000@tglx.tec.linutronix.de> <20060120021343.296071000@tglx.tec.linutronix.de>
In-Reply-To: <20060120021343.296071000@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> The expiry time for relative timers with SIGEV_NONE set was never
> updated to the correct value.
> 
> Pointed out by George Anzinger.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
> 
>  kernel/posix-timers.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> a1f15939b7af18c5abcd4810ccd512467c77a6b1
> diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
> index 28e72fd..e2fa4c0 100644
> --- a/kernel/posix-timers.c
> +++ b/kernel/posix-timers.c
> @@ -724,8 +724,13 @@ common_timer_set(struct k_itimer *timr, 
>  	timr->it.real.interval = timespec_to_ktime(new_setting->it_interval);
>  
>  	/* SIGEV_NONE timers are not queued ! See common_timer_get */
> -	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
> +	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
> +		/* Setup correct expiry time for relative timers */
> +		if (mode == HRTIMER_REL)
> +			timer->expires = ktime_add(timer-expires,
> +						   timer->base->get_time());
This is only part of the problem.  When the user does a timer_gettime() the 
expiry time is taken from the hrtimer field and NOT the posix-timer part. 
Somewhere this value needs to be copied to the hrtimer sub structure.

George
-- 

>  		return 0;
> +	}
>  
>  	hrtimer_start(timer, timer->expires, mode);
>  	return 0;

-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
