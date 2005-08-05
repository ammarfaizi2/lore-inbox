Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVHEOEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVHEOEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbVHEOEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:04:22 -0400
Received: from spirit.analogic.com ([208.224.221.4]:32261 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S261751AbVHEOEV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:04:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050805135007.GA6985@vana.vc.cvut.cz>
References: <20050805135007.GA6985@vana.vc.cvut.cz>
X-OriginalArrivalTime: 05 Aug 2005 14:04:20.0207 (UTC) FILETIME=[93329FF0:01C599C6]
Content-class: urn:content-classes:message
Subject: Re: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
Date: Fri, 5 Aug 2005 10:03:41 -0400
Message-ID: <Pine.LNX.4.61.0508051000390.9772@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13-rc5-gitNOW] msleep() cannot be used from interrupt
thread-index: AcWZxpM8YUxOI0iqRQO4veA6ye08BA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Petr Vandrovec" <vandrove@vc.cvut.cz>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Petr Vandrovec wrote:

> Hello Linus,
>  can you apply patch below?
>
> Since beginning of July my Opteron box was randomly crashing and being rebooted
> by hardware watchdog.  Today it finally did it in front of me, and this patch
> will hopefully fix it.
>
> Problem is that at the end of June (28th, commit
> 47f176fdaf8924bc83fddcf9658f2fd3ef60d573, [PATCH] Using msleep() instead of HZ)
> rtc_get_rtc_time was converted to use msleep() instead of busy waiting.  But
> rtc_get_rtc_time is used by hpet_rtc_interrupt, and scheduling is not allowed
> during interrupt.  So I'm reverting this part of original change, replacing
> msleep() back with busy loop.
>
> Original old code was busy waiting for 20ms, while on my hardware in the worst
> case update-in-progress bit was asserted for at most 363 passes through loop
> (on 2GHz dual Opteron), much less than even one jiffie, not even talking
> about 20ms.  So I changed code to just wait only as long as necessary.  Otherwise
> when RTC was set to generate 8192Hz timer, it stopped doing anything for
> 20ms (160 pulses were skipped!) from time to time, and this is rather suboptimal
> as far as I can tell.
>
> 						Thanks,
> 							Petr Vandrovec
>
>

It this is called from an interrupt (I hope not), jiffies will
not change unless you have two or more CPUs. Please don't do this.
Just spin while rtc is updating some maximum number of loops.


> Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>
>
> diff -urdN linux/drivers/char/rtc.c linux/drivers/char/rtc.c
> --- linux/drivers/char/rtc.c	2005-08-05 12:43:54.000000000 +0000
> +++ linux/drivers/char/rtc.c	2005-08-05 13:26:48.000000000 +0000
> @@ -1209,6 +1209,7 @@
>
> void rtc_get_rtc_time(struct rtc_time *rtc_tm)
> {
> +	unsigned long uip_watchdog = jiffies;
> 	unsigned char ctrl;
> #ifdef CONFIG_MACH_DECSTATION
> 	unsigned int real_year;
> @@ -1224,8 +1225,10 @@
> 	 * Once the read clears, read the RTC time (again via ioctl). Easy.
> 	 */
>
> -	if (rtc_is_updating() != 0)
> -		msleep(20);
> +	while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100) {
> +		barrier();
> +		cpu_relax();
> +	}
>
> 	/*
> 	 * Only the values that we read from the RTC are set. We leave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
