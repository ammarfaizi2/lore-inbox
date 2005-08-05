Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVHEOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVHEOnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVHEOk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:40:58 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:60827 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262272AbVHEOjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:39:42 -0400
Message-ID: <42F37A2D.3090908@vc.cvut.cz>
Date: Fri, 05 Aug 2005 16:39:41 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
References: <20050805135007.GA6985@vana.vc.cvut.cz> <Pine.LNX.4.61.0508051000390.9772@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508051000390.9772@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Fri, 5 Aug 2005, Petr Vandrovec wrote:
> 
> 
>>Hello Linus,
>> can you apply patch below?
>>
>>Since beginning of July my Opteron box was randomly crashing and being rebooted
>>by hardware watchdog.  Today it finally did it in front of me, and this patch
>>will hopefully fix it.
>>
>>Problem is that at the end of June (28th, commit
>>47f176fdaf8924bc83fddcf9658f2fd3ef60d573, [PATCH] Using msleep() instead of HZ)
>>rtc_get_rtc_time was converted to use msleep() instead of busy waiting.  But
>>rtc_get_rtc_time is used by hpet_rtc_interrupt, and scheduling is not allowed
>>during interrupt.  So I'm reverting this part of original change, replacing
>>msleep() back with busy loop.
>>
>>Original old code was busy waiting for 20ms, while on my hardware in the worst
>>case update-in-progress bit was asserted for at most 363 passes through loop
>>(on 2GHz dual Opteron), much less than even one jiffie, not even talking
>>about 20ms.  So I changed code to just wait only as long as necessary.  Otherwise
>>when RTC was set to generate 8192Hz timer, it stopped doing anything for
>>20ms (160 pulses were skipped!) from time to time, and this is rather suboptimal
>>as far as I can tell.
>>
>>						Thanks,
>>							Petr Vandrovec
>>
>>
> 
> 
> It this is called from an interrupt (I hope not), jiffies will
> not change unless you have two or more CPUs. Please don't do this.
> Just spin while rtc is updating some maximum number of loops.

It is called from rtc interrupt (hpet_rtc_interrupt calls it, if
you really want I'll reproduce oopses about scheduling in the
interrupt again and post it here for you convience).  But
being inside rtc interrupt should not prevent jiffies from being
incremented as system timer has higher priority than rtc.  We had
code which looped around until jiffies expired for years and as far
as I know nobody complained that boxes deadlock from time to time.
I just added test for 'rtc_is_updating()' to the test.
							Petr

> 
> 
> 
>>Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>
>>
>>diff -urdN linux/drivers/char/rtc.c linux/drivers/char/rtc.c
>>--- linux/drivers/char/rtc.c	2005-08-05 12:43:54.000000000 +0000
>>+++ linux/drivers/char/rtc.c	2005-08-05 13:26:48.000000000 +0000
>>@@ -1209,6 +1209,7 @@
>>
>>void rtc_get_rtc_time(struct rtc_time *rtc_tm)
>>{
>>+	unsigned long uip_watchdog = jiffies;
>>	unsigned char ctrl;
>>#ifdef CONFIG_MACH_DECSTATION
>>	unsigned int real_year;
>>@@ -1224,8 +1225,10 @@
>>	 * Once the read clears, read the RTC time (again via ioctl). Easy.
>>	 */
>>
>>-	if (rtc_is_updating() != 0)
>>-		msleep(20);
>>+	while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100) {
>>+		barrier();
>>+		cpu_relax();
>>+	}
>>
>>	/*
>>	 * Only the values that we read from the RTC are set. We leave
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> I apologize for the following. I tried to kill it with the above dot :
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> 


