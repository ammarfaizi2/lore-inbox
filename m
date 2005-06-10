Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVFJEGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVFJEGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 00:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVFJEGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 00:06:05 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:42456 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262462AbVFJEFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:05:40 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 9 Jun 2005 21:05:13 -0700
From: Tony Lindgren <tony@atomide.com>
To: Bernard Blackham <b-lkml@blackham.com.au>
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050610040513.GB18103@atomide.com>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <200506022203.27734.mail@earthworm.de> <20050605040627.GA28376@ucc.gu.uwa.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605040627.GA28376@ucc.gu.uwa.edu.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bernard Blackham <b-lkml@blackham.com.au> [050604 21:07]:
> On Thu, Jun 02, 2005 at 10:03:18PM +0200, Christian Hesse wrote:
> > > > > Please let me know of any issues with the patch. I'll continue to do
> > > > > more clean-up on it, but I think the basic functionality is done.
> 
> If CONFIG_NO_IDLE_HZ and CONFIG_X86_UP_APIC is set, but
> CONFIG_DYN_TICK_USE_APIC is *not* set, there's still one case where
> reprogram_apic_timer was still being called. This was causing my system
> to seize for around a second or so when doing some things (most notably
> probing for devices on boot, and when suspending/resuming PCI devices).
> Attached patch fixes those hangs for me.

Thanks, I've added it to the patch I'll post shortly.

> However, "using APIC" is still reported as 1 in sysfs. This is cosmetic,
> but still incorrect :)

Urhg, yes it still needs some cleaning up...

> > - using software suspend 2.1.8.10 I can suspend the system, but it
> >   hangs while resuming
> 
> When software suspend resumes, it suspends (more correctly, "freezes")
> all devices, copies the old kernel over the top of itself with
> interrupts off (which includes the value of xtime from suspend-time),
> and then resumes all devices.  The resuming all devices bit includes
> calling timer_resume in arch/i386/kernel/time.c which winds xtime
> forwards by the amount of time we were asleep for (according to the CMOS
> clock). I think this may be one source of confusion to the dyntick code.
> 
> Turning on dyn_tick_dbg and some extra printk's shows that it hangs
> inside this loop in dyn_tick_timer_interrupt:
> 
>     while (now - last_tick >= NS_TICK_LEN) {
> 		last_tick += NS_TICK_LEN;
> 		[... call do_timer_interrupt and stuff ... ]
> 	}
> 
> I haven't pinned it down yet, but I'm curious if perhaps now <
> last_tick, in which case the loop will take until the end of the
> universe to terminate (well, nearly). There's reference in timer_tsc.c
> to APM doing magic to ensure monotonic_clock is infact monotonic when
> suspending to disk (as the TSC counter itself will get reset to zero on
> boot), but I'm not sure what this magic is, or if the magic is done if
> we're not using APM.

Again, it suspend and resume worked fine on my laptop. No APIC timer on it
though.

Tony
