Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUATV1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbUATV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:27:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:34043 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265784AbUATV1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:27:30 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: hauan@cmu.edu
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
Content-Type: text/plain
Message-Id: <1074633977.16374.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jan 2004 13:26:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 12:36, Steinar Hauan wrote:
>   i've started to test the 2.6 series of kernels and observed a
>   strange thing: with moderate background load, the system clock
>   (i.e. time) seems to slow down to about 60% of normal speed
>   and the normally reliable ntp process (v4.2.0)
> 
>   details: working interactively with a couple of background dummy
>   processes (*1), my system clock slowed down approx 90 mins over
>   a period of approx 4 hrs real time.
>  
> (*1) infinite loop: 1 rip, 1 encode -- both run at nice 10
> 
>   the kernel logs show messages on the form:
> 
> localhost kernel: Losing too many ticks!
> localhost kernel: TSC cannot be used as a timesource.
>                        (Are you running with SpeedStep?)

How quickly do you see this message? Does it happen right at boot time,
or during load?


> localhost kernel: Falling back to a sane timesource.
> localhost kernel: set_rtc_mmss: can't update from 5 to 58
> 
>   without the background load, the system keeps perfect time.
> 
> ==> any ideas of what could be going on would be appreciated.

You seem to be losing lots of timer ticks. If this happens enough, the
system will fall back to the PIT thinking that your cpu frequency must
have changed w/o notification. 

You might want to try the attached patch to see if we're overreacting
when we fall back to the PIT or if your system really is having trouble.
Basically I'm just disabling the lost tick compensation code, which
means if your system is really having issues, you'll still lose time.

>   hardware details
>     Intel P4 2.53gz on Supermicro P4SAA mobo (Intel 7205 chipset)
>     1gb memory; multiple drives; Promise Ultra/133 raid controller
>   software
>     kernel 2.6.1 w/APIC and PREEMPT options turned on.

Also, do you see the problem when preempt is disabled (without using the
attached patch?)

thanks
-john

===== arch/i386/kernel/timers/timer_tsc.c 1.35 vs edited =====
--- 1.35/arch/i386/kernel/timers/timer_tsc.c	Wed Jan  7 00:31:11 2004
+++ edited/arch/i386/kernel/timers/timer_tsc.c	Tue Jan 20 13:22:54 2004
@@ -226,7 +226,7 @@
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
+	if (0 && (lost >= 2)) {
 		jiffies_64 += lost-1;
 
 		/* sanity check to ensure we're not always losing ticks */


