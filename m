Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVCDKba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVCDKba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVCDKb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:31:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51191 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262711AbVCDK2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:28:45 -0500
Message-ID: <42283857.9050007@mvista.com>
Date: Fri, 04 Mar 2005 02:28:39 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
References: <1109869828.2908.18.camel@mindpipe>	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>
In-Reply-To: <1109899148.3630.5.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-03-03 at 16:45 -0800, Andrew Morton wrote:
> 
>>If efi_enabled is true and efi_set_rtc_mmss(xtime.tv_sec) returns zero, the
>>new code will run set_rtc_mmss(xtime.tv_sec) whereas the old code won't.
> 
> 
> Argh, I should know better then to send patches before having coffee.
> 
> Here's a new patch.  Still ugly, but might be a worthwhile cleanup.

Lets ask the obvious question: Why isn't this update hung on a timer?  It seems 
silly to check this 6000 times per update.  I am sure we can sync a timer to the 
same degree we do timer interrupts, so there _must_ be some other reason.  Right?

George
> 
> Lee
> 
> --- linux-2.6.11-rc4-V0.7.39-02/arch/i386/kernel/time.c	2005-02-14 18:10:49.000000000 -0500
> +++ linux-2.6.11-rc4/arch/i386/kernel/time.c	2005-03-03 20:15:39.000000000 -0500
> @@ -254,16 +254,12 @@
>  			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
>  	    (xtime.tv_nsec / 1000)
>  			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
> -		/* horrible...FIXME */
> +	        last_rtc_update = xtime.tv_sec;
>  		if (efi_enabled) {
> -	 		if (efi_set_rtc_mmss(xtime.tv_sec) == 0)
> -				last_rtc_update = xtime.tv_sec;
> -			else
> -				last_rtc_update = xtime.tv_sec - 600;
> -		} else if (set_rtc_mmss(xtime.tv_sec) == 0)
> -			last_rtc_update = xtime.tv_sec;
> -		else
> -			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
> +		    if (efi_set_rtc_mmss(xtime.tv_sec))
> +			last_rtc_update -= 600;
> +		} else if (set_rtc_mmss(xtime.tv_sec))
> +			last_rtc_update -= 600;
>  	}
>  
>  	if (MCA_bus) {
> 
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

