Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272287AbTHDWiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272288AbTHDWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:38:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62460 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S272287AbTHDWiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:38:50 -0400
Message-ID: <3F2EE053.1020600@mvista.com>
Date: Mon, 04 Aug 2003 15:38:11 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Patrick Moor <pmoor@netpeople.ch>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: time jumps (again)
References: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
>>Some days ago I started noticing strange time jumps on my Athlon system.
>>(Asus board, VIA chipset, AMD Athlon 650MHz processor). I haven't
>>noticed them before and I am pretty sure there weren't any for the last
>>few years! Uptime of the machine is now 218 days, and problems began
>>appearing after 215 days approximately.
>>
>>What happens: when doing a
>>  $ while true; do date; done
>>I'm noticing time jumps _exactly_ at the beginning of a "new" second (or
>>at the end of an "old" one). the jump is exactly 4294 (4295) seconds
>>into the future. Example:
>>...
>>Mon Aug  4 18:11:06 CEST 2003
>>Mon Aug  4 18:11:06 CEST 2003
>>Mon Aug  4 19:22:41 CEST 2003
>>Mon Aug  4 19:22:41 CEST 2003
>>Mon Aug  4 19:22:41 CEST 2003
>>Mon Aug  4 18:11:07 CEST 2003
>>Mon Aug  4 18:11:07 CEST 2003
>>...
>>
> 
> 
> Wild guess - does the following patch fix it?

And your theory is that wall_jiffies > jiffies.  How does this happen? 
  Both of these are only changed under the write_irq lock....

I would feel better with a patch that made jiffies volatile, but it 
already is.

I agree that the jump implies overflow here, but just HOW is it happening?

Time for some dianostic code...

  Tim
> 
> 
> --- linux-2.4.20/arch/i386/kernel/time.c.orig	Mon Aug  4 23:38:47 2003
> +++ linux-2.4.20/arch/i386/kernel/time.c	Mon Aug  4 23:40:53 2003
> @@ -274,8 +274,8 @@
>  	read_lock_irqsave(&xtime_lock, flags);
>  	usec = do_gettimeoffset();
>  	{
> -		unsigned long lost = jiffies - wall_jiffies;
> -		if (lost)
> +		long lost = jiffies - wall_jiffies;
> +		if (lost>0)
>  			usec += lost * (1000000 / HZ);
>  	}
>  	sec = xtime.tv_sec;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

