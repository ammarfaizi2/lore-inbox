Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbTG1V4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTG1V4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:56:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5623 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S271108AbTG1V41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:56:27 -0400
Message-ID: <3F259BE7.9070403@mvista.com>
Date: Mon, 28 Jul 2003 14:55:51 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Ulrich.Windl@rz.uni-regensburg.de
Subject: Re: Fw: missing #if for 1000 HZ
References: <20030725203843.569863bc.akpm@osdl.org>
In-Reply-To: <20030725203843.569863bc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Guys?

If I understand what is being done, he is right.  By this measure the 
current error in the div (by shifting) is 2.4%.

I wonder how this plays with(line 639):

	time_phase += time_adj;
	if (time_phase <= -FINENSEC) {
		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
		time_phase += ltemp << (SHIFT_SCALE - 10);
		delta_nsec -= ltemp;
	}

where, we are also using >>10 ~= /1000.  I _think_ this ladder 
approximation only delays part of the correction but does not loose 
it, but the more eyes the better.

-g
> 
> Begin forwarded message:
> 
> Date: 22 Jul 2003 21:01:16 -0400
> From: Albert Cahalan <albert@users.sourceforge.net>
> To: linux-kernel@vger.kernel.org, Ulrich.Windl@rz.uni-regensburg.de
> Cc: Andrew Morton <akpm@digeo.com>, alan@redhat.com
> Subject: missing #if for 1000 HZ
> 
> 
> This should improve timekeeping a bit @ 1000 HZ.
> 
> 
> diff -Naurd old/kernel/timer.c new/kernel/timer.c
> --- old/kernel/timer.c	2003-07-18 17:27:01.000000000 -0400
> +++ new/kernel/timer.c	2003-07-18 17:32:19.000000000 -0400
> @@ -606,6 +606,15 @@
>      else
>  	time_adj += (time_adj >> 2) + (time_adj >> 5);
>  #endif
> +#if HZ == 1000
> +    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
> +     * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
> +     */
> +    if (time_adj < 0)
> +	time_adj -= (-time_adj >> 6) + (-time_adj >> 7);
> +    else
> +	time_adj += (time_adj >> 6) + (time_adj >> 7);
> +#endif
>  }
>  
>  /* in the NTP reference this is called "hardclock()" */
> 
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

