Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVCSWYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVCSWYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVCSWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:24:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55291 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261882AbVCSWYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:24:01 -0500
Message-ID: <423CA67E.3090301@mvista.com>
Date: Sat, 19 Mar 2005 14:23:58 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt-lock fix
References: <1109869828.2908.18.camel@mindpipe>	<20050303164520.0c0900df.akpm@osdl.org>	<1109899148.3630.5.camel@mindpipe>	<42283857.9050007@mvista.com>	<1109968985.6710.16.camel@mindpipe>	<4228CBFB.3000602@mvista.com>	<1110313644.4600.13.camel@mindpipe>	<422E33F0.6020403@mvista.com>	<4230087E.3080307@mvista.com>	<1110579830.19661.10.camel@mindpipe>	<20050311143459.54c74dd0.akpm@osdl.org>	<423BF1E6.9030902@mvista.com> <20050319132134.5953f176.akpm@osdl.org>
In-Reply-To: <20050319132134.5953f176.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>Did you pick this up?  First sent on 3-11.
> 
> 
> I did, although now looking at it I have issues.
> 
> 
>> I was not happy with the locking on this.  Two changes:
>> 1) Turn off irq while setting the clock.
>> 2) Call the timer code only through the timer interface 
>>    (set a short timer to do it from the ntp call).
> 
I wanted the calls to sync_cmos_clock() to be made in a consistent environment. 
  This was not true when calling it directly from the NTP call code.  The change 
means that sync_cmos_clock() is ALWAYS called from run_timers(), i.e. as a timer 
call back function.
> 
> I would consider this to be an inadequate description :(
> 
> 
>> Signed-off-by: George Anzinger <george@mvista.com>
>>
>>  time.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> Index: linux-2.6.12-rc/arch/i386/kernel/time.c
>> ===================================================================
>> --- linux-2.6.12-rc.orig/arch/i386/kernel/time.c
>> +++ linux-2.6.12-rc/arch/i386/kernel/time.c
>> @@ -176,12 +176,12 @@ static int set_rtc_mmss(unsigned long no
>>  	int retval;
>>  
>>  	/* gets recalled with irq locally disabled */
>> -	spin_lock(&rtc_lock);
>> +	spin_lock_irq(&rtc_lock);
>>  	if (efi_enabled)
>>  		retval = efi_set_rtc_mmss(nowtime);
>>  	else
>>  		retval = mach_set_rtc_mmss(nowtime);
>> -	spin_unlock(&rtc_lock);
>> +	spin_unlock_irq(&rtc_lock);
>>  
>>  	return retval;
>>  }
> 
> 
> If the comment is correct, and this code is called with local irq's
> disabled then this patch should be using spin_lock_irqsave()

With the change below, it is always called from the timer call back code which, 
I believe, is always called with irq on.  Looks like I missed the comment :(
> 
> 
>> @@ -338,7 +338,7 @@ static void sync_cmos_clock(unsigned lon
>>  }
>>  void notify_arch_cmos_timer(void)
>>  {
>> -	sync_cmos_clock(0);
>> +	mod_timer(&sync_cmos_timer, jiffies + 1);
>>  }
>>  static long clock_cmos_diff, sleep_start;
>>  
> 
> 
> Your description says what this does, but it doesn't way why it was done?
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

