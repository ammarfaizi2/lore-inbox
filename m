Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVHOWOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVHOWOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVHOWOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:14:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65002 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965007AbVHOWOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:14:49 -0400
Subject: Re: [PATCH] pmtmr and PRINTK_TIME timings display
From: john stultz <johnstul@us.ibm.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200508041459.43500.petkov@uni-muenster.de>
References: <200508041459.43500.petkov@uni-muenster.de>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 15:14:45 -0700
Message-Id: <1124144086.8630.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 14:59 +0200, Borislav Petkov wrote:
> Hi,
> 
> on my laptop ASUS M6B00N PRINTK_TIME is enabled in order to show timing 
> information in all the boottime printk's. However, all output looks like this
> 
> <snip>
> [4294667.997000] CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 
> 00000000 00000180 00000000 00000000
> [4294667.997000] CPU: After vendor identify, caps: a7e9fbbf 00000000 00000000 
> 00000000 00000180 00000000 00000000
> [4294667.997000] CPU: L1 I cache: 32K, L1 D cache: 32K
> [4294667.997000] CPU: L2 cache: 1024K
> [4294667.997000] CPU: After all inits, caps: a7e9fbbf 00000000 00000000 
> 00000040 00000180 00000000 00000000
> [4294667.997000] CPU: Intel(R) Pentium(R) M processor 1500MHz stepping 05
> [4294667.997000] Enabling fast FPU save and restore... done.
> [4294667.997000] Enabling unmasked SIMD FPU exception support... done.
> [4294667.997000] Checking 'hlt' instruction... OK.
> [4294668.041000] ACPI: setting ELCR to 0200 (from 0c30)
> </snip>
> 
> If I'm not wrong, the time value that gets printed is actually the jiffies_64 
> value set to INITIAL_JIFFIES, which in turn is set to wrap 5 minutes after 
> boot so that "jiffies wrap bugs show up earlier." This is because 
> sched_clock() in <arch/i386/kernel/timers/timer_tsc.c> returns the jiffies_64 
> value converted to nanoseconds after checking use_tsc. This, in turn, is 0 
> because my machine selects the power management timer as the high-res 
> timesource before reading the timestamp counter for printk timing.
> 
[snip]
> After applying it, printk timing looks like this:
> 
> <snip>
> [    0.000000] Detected 1500.132 MHz processor.
> [    0.000000] Using pmtmr for high-res timesource
> [    0.000000] Console: colour VGA+ 80x25
> [    1.890000] Dentry cache hash table entries: 131072 (order: 7, 524288 
> bytes)
> [    1.891000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    1.906000] Memory: 513756k/523520k available (2839k kernel code, 9276k 
> reserved, 1148k data, 152k init, 0k highmem)
> [    1.906000] Checking if this processor honours the WP bit even in 
> supervisor mode... Ok.
> [    1.906000] Calibrating delay loop... 2973.69 BogoMIPS (lpj=1486848)
> [    1.928000] Security Framework v1.0.0 initialized
> </snip>
> 
> 
> Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> --- arch/i386/kernel/timers/timer_tsc.c.orig	2005-08-04 12:57:37.000000000 
> +0200
> +++ arch/i386/kernel/timers/timer_tsc.c	2005-08-04 14:19:48.000000000 +0200
> @@ -146,7 +146,7 @@ unsigned long long sched_clock(void)
>  	if (!use_tsc)
>  #endif
>  		/* no locking but a rare wrong value is not a big deal */
> -		return jiffies_64 * (1000000000 / HZ);
> +		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
>  
>  	/* Read the Time Stamp Counter */
>  	rdtscll(this_offset);
> 
> 

This patch looks fine to me.
-john


