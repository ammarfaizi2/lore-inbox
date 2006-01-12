Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161463AbWALX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161463AbWALX0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWALX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:26:12 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:20204 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161463AbWALX0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:26:10 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060112220825.GA3490@inferi.kami.home>
References: <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <15632.83.103.117.254.1136989660.squirrel@picard.linux.it>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 15:26:01 -0800
Message-Id: <1137108362.2890.141.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 23:08 +0100, Mattia Dongili wrote:
> [cleaned up some Cc as this is not interesting to all MLs]
> 
> Andrew,
> 
> first bisection spotted the cause of the stalls at boot (happening while
> starting portmap and after usb-storage scan):
> 
> time-clocksource-infrastructure.patch
> time-generic-timekeeping-infrastructure.patch
> time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
> time-i386-conversion-part-2-rework-tsc-support.patch
> time-i386-conversion-part-3-enable-generic-timekeeping.patch
> time-i386-conversion-part-4-remove-old-timer_opts-code.patch
> time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
> time-i386-clocksource-drivers.patch
> time-fix-cpu-frequency-detection.patch
> 
> Cc-ed john stultz
> 
> actually git bisect[1] pointed to time-fix-cpu-frequency-detection.patch
> but it's clearly wrong. Reverting all the above patches (I suppose they
> are somewhat related) fixes the stalls I experience. I can test
> corrections if necessary.

Hmmm. I'm not quite understanding. Does reverting just
time-fix-cpu-frequency-detection.patch change anything? I just sent out
a fix for an error case that patch, but I doubt you'd be hitting it.

Looking at the log here:
http://oioio.altervista.org/linux/boot-2.6.15-mm2.3

I'm curious if you're getting cpufreq effects during interval while the
TSC is being used as a clocksource before we switch to using the acpi_pm
clocksource.

After the system boots up, does it keep accurate time? Time doesn't
obviously move too fast or to slow compared to a watch?

Few things to try (independently):
1. Does booting w/ idle=poll change the behavior?
2. Does booting w/ clocksource=jiffies change the behavior?
3. After booting up, run: 
   echo tsc > /sys/devices/system/clocksource/clocksource0/current_clocksource
   And check that the system keeps accurate time.


Thanks for the great testing and feedback!
-john

