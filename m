Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWF1AHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWF1AHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWF1AHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:07:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24472 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750837AbWF1AHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:07:16 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 17:07:06 -0700
Message-Id: <1151453231.24656.49.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 15:07 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Jun 2006 19:23:53 +0200, Roman Zippel said:
> 
> I finished bisecting - the problem code is somewhere in
> fix-and-optimize-clock-source-update.patch (which should narrow things
> down a bunch).

Thanks so much for narrowing this down!


> > Could you please try the patch below? This should better locate which of 
> > the values goes wrong.
> 
> 
> > +	if (ts->tv_nsec < 0 || nsecs < 0)
> > +		printk("unexpected nsec: %ld,%Ld\n", ts->tv_nsec, nsecs);
> >  	timespec_add_ns(ts, nsecs);
> 
> I changed it slightly to also do a dump_stack() in case that mattered. I get:
> 
> [   22.562394] Time: tsc clocksource has been installed.
> 
> (Does the clocksource matter here?)

It might be related. Quick test to check: boot w/ "clocksource=acpi_pm"
and let me know if the problem still appears. Then try booting w/
"clocksource=tsc" and see if the system still corrects itself.


> [   25.241589] audit(1151434000.4294965869:2): policy loaded auid=4294967295
> [   25.260931] audit(1151434020.4294967250:3): avc:  granted  { load_policy } for  pid=1 comm="init" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=security
> [   25.326263] unexpected nsec: -925155963,1574943831

Hmm. Yea, the negative xtime nsec value is problematic. However the 1.5
seconds worth of nanoseconds that has accumulated is worrisome as well.


> [   92.087113] ACPI: CPU0 (power states: C1[C1] C2[C2])
> [   92.087122] ACPI: Processor [CPU0] (supports 8 throttling states)
> [   92.120270] ACPI: Thermal Zone [THM] (70 C)
> [   72.242000] Time: acpi_pm clocksource has been installed.
> 
> and the timestamps steps back about 20 seconds.... 

Yea, that bit is expected. Basically the cpufreq driver is loading, and
when we detect cpufreq changes we mark the TSC as unstable and we fall
back to an alternative clocksource (acpi_pm in your case). At the same
time, sched_clock sees that the TSC is unstable and it falls back to
using jiffies, which causes the small jump in the printk timestamps.

Thanks again for the testing and feedback!
-john

