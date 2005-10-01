Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVJAUpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVJAUpd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 16:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVJAUpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 16:45:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53766 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750833AbVJAUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 16:45:32 -0400
Date: Sat, 1 Oct 2005 22:39:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] 2.6.14-rc2-mm1 : fixes for overflow in sys_poll()
Message-ID: <20051001203903.GB28113@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local> <20050924195205.GE26197@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924195205.GE26197@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 24, 2005 at 09:52:05PM +0200, Willy Tarreau wrote:
> This patch simplifies the overflow fix which was applied to sys_poll() in
> 2.6.14-rc2-mm1 by relying on the overflow detection code added to jiffies.h
> by patch 1/3. This also removes a useless divide for HZ <= 1000.
> 
> It might be worth applying too. It's only for -mm1, and does *not* apply
> to 2.6.14-rc2 because this code has already received patches in -mm1.

I noticed that the overflow check in the original code is either useless or
buggy, so this patch is even more worth applying. Look below at original
code : if HZ <= 1000, the overflow is set only when
msecs_to_jiffies() >= MAX_SCHEDULE_TIMEOUT.

But the maximal value that msecs_to_jiffies() can return is MAX_JIFFY_OFFSET.
Guess what ?

  include/linux/jiffies.h:#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
  include/linux/sched.h:#define    MAX_SCHEDULE_TIMEOUT    LONG_MAX
  include/linux/kernel.h:#define LONG_MAX  ((long)(~0UL>>1))

=> MAX_JIFFY_OFFSET == (MAX_SCHEDULE_TIMEOUT - 1)

=> So msecs_to_jiffies() cannot be >= MAX_SCHEDULE_TIMEOUT, and 'overflow'
   can never be set for HZ <= 1000.

Given how msecs_to_jiffies() is used everywhere, I wonder if we should not
provide a separate overflow detection function which would be used where
needed, and possibly remove the test from msecs_to_jiffies() which is mostly
called with constants or small delays which will never overflow.

Has anyone an opinion on this ?

Regards,
Willy

> diff -purN linux-2.6.14-rc2-mm1/fs/select.c linux-2.6.14-rc2-mm1-poll/fs/select.c
> --- linux-2.6.14-rc2-mm1/fs/select.c	Sat Sep 24 21:12:36 2005
> +++ linux-2.6.14-rc2-mm1-poll/fs/select.c	Sat Sep 24 21:23:21 2005
> @@ -469,7 +469,6 @@ asmlinkage long sys_poll(struct pollfd _
>  {
>  	struct poll_wqueues table;
>  	int fdcount, err;
> -	int overflow;
>   	unsigned int i;
>  	struct poll_list *head;
>   	struct poll_list *walk;
> @@ -486,22 +485,11 @@ asmlinkage long sys_poll(struct pollfd _
>  		return -EINVAL;
>  
>  	/*
> -	 * We compare HZ with 1000 to work out which side of the
> -	 * expression needs conversion.  Because we want to avoid
> -	 * converting any value to a numerically higher value, which
> -	 * could overflow.
> -	 */
> -#if HZ > 1000
> -	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
> -#else
> -	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
> -#endif
> -
> -	/*
>  	 * If we would overflow in the conversion or a negative timeout
> -	 * is requested, sleep indefinitely.
> +	 * is requested, sleep indefinitely. Note: msecs_to_jiffies checks
> +	 * for the overflow.
>  	 */
> -	if (overflow || timeout_msecs < 0)
> +	if (timeout_msecs < 0)
>  		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
>  	else
>  		timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
> 
> 
