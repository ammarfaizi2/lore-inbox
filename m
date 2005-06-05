Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVFEEGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFEEGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 00:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFEEGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 00:06:46 -0400
Received: from asclepius3.uwa.edu.au ([130.95.128.60]:59057 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S261446AbVFEEGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 00:06:42 -0400
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Sun, 5 Jun 2005 12:06:27 +0800
From: Bernard Blackham <b-lkml@blackham.com.au>
To: Christian Hesse <mail@earthworm.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050605040627.GA28376@ucc.gu.uwa.edu.au>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <200506022203.27734.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <200506022203.27734.mail@earthworm.de>
User-Agent: Mutt/1.5.9i
X-SpamTest-Info: Profile: Formal (239/050529)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 02, 2005 at 10:03:18PM +0200, Christian Hesse wrote:
> > > > Please let me know of any issues with the patch. I'll continue to do
> > > > more clean-up on it, but I think the basic functionality is done.

If CONFIG_NO_IDLE_HZ and CONFIG_X86_UP_APIC is set, but
CONFIG_DYN_TICK_USE_APIC is *not* set, there's still one case where
reprogram_apic_timer was still being called. This was causing my system
to seize for around a second or so when doing some things (most notably
probing for devices on boot, and when suspending/resuming PCI devices).
Attached patch fixes those hangs for me.

However, "using APIC" is still reported as 1 in sysfs. This is cosmetic,
but still incorrect :)

> - using software suspend 2.1.8.10 I can suspend the system, but it
>   hangs while resuming

When software suspend resumes, it suspends (more correctly, "freezes")
all devices, copies the old kernel over the top of itself with
interrupts off (which includes the value of xtime from suspend-time),
and then resumes all devices.  The resuming all devices bit includes
calling timer_resume in arch/i386/kernel/time.c which winds xtime
forwards by the amount of time we were asleep for (according to the CMOS
clock). I think this may be one source of confusion to the dyntick code.

Turning on dyn_tick_dbg and some extra printk's shows that it hangs
inside this loop in dyn_tick_timer_interrupt:

    while (now - last_tick >= NS_TICK_LEN) {
		last_tick += NS_TICK_LEN;
		[... call do_timer_interrupt and stuff ... ]
	}

I haven't pinned it down yet, but I'm curious if perhaps now <
last_tick, in which case the loop will take until the end of the
universe to terminate (well, nearly). There's reference in timer_tsc.c
to APM doing magic to ensure monotonic_clock is infact monotonic when
suspending to disk (as the TSC counter itself will get reset to zero on
boot), but I'm not sure what this magic is, or if the magic is done if
we're not using APM.

Bernard.

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dyntick-fixes-brb-1.diff"

Index: linux/kernel/dyn-tick.c
===================================================================
--- linux.orig/kernel/dyn-tick.c	2005-06-05 00:51:53.000000000 +0800
+++ linux/kernel/dyn-tick.c	2005-06-05 01:02:55.000000000 +0800
@@ -54,7 +54,8 @@
 
 	/* Check if we are already skipping ticks and can idle other cpus */
 	if (dyn_tick->state & DYN_TICK_SKIPPING) {
-		reprogram_apic_timer(dyn_tick->skip);
+		if (cpu_has_local_apic())
+			reprogram_apic_timer(dyn_tick->skip);
 		return 0;
 	}
 

--zYM0uCDKw75PZbzx--

