Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWF1Xle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWF1Xle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWF1Xle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:41:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:1761 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751783AbWF1Xlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:41:31 -0400
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606281218130.12900@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271212150.17704@scrub.home>
	 <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0606271903320.12900@scrub.home>
	 <Pine.LNX.4.64.0606271919450.17704@scrub.home>
	 <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu>
	 <1151453231.24656.49.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606281218130.12900@scrub.home>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 16:41:24 -0700
Message-Id: <1151538084.5317.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 12:35 +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 27 Jun 2006, john stultz wrote:
> 
> > > [   92.087113] ACPI: CPU0 (power states: C1[C1] C2[C2])
> > > [   92.087122] ACPI: Processor [CPU0] (supports 8 throttling states)
> > > [   92.120270] ACPI: Thermal Zone [THM] (70 C)
> > > [   72.242000] Time: acpi_pm clocksource has been installed.
> > > 
> > > and the timestamps steps back about 20 seconds.... 
> > 
> > Yea, that bit is expected. Basically the cpufreq driver is loading, and
> > when we detect cpufreq changes we mark the TSC as unstable and we fall
> > back to an alternative clocksource (acpi_pm in your case). At the same
> > time, sched_clock sees that the TSC is unstable and it falls back to
> > using jiffies, which causes the small jump in the printk timestamps.
> 
> Frequency changes are IMO currently the most likely reason for this 
> behaviour. If the cpu speeds down too much, the adjustment code might 
> actually attempt to go backwards in time, the old adjustment code might 
> have survived that, because it reacts slower to changes.
> The patch below should prevent this.

I agree cpufreq changes could be the source. However, things still
aren't making sense, since the accumulation is cycle based to begin
with, so any cpufreq caused drift in time won't be noticed until NTPd
starts adjusting the output from current_tick_len().

Vladis: I don't want to overwhelm you with patches to try, I think
Roman's debug patches should help show where the issue is. But if you've
got the time, try the patch below to quickly see if the cpufreq changes
are indeed causing the problem.

> Looking through the log file, I noticed other things:
> 
> [   17.942330] speedstep: frequency transition measured seems out of range (0 nSec), falling back to a safe one of 500000 nSec.
> ...
> [   21.869356] Time: tsc clocksource has been installed.
> 
> The speedstep code uses do_gettimeofday() but there is no real clock 
> source installed, so it gets confused.
> IMO it would be better to install the PIT timer very early and later avoid 
> switching to tsc at all, if there is any possibility of speed changes.

Hmm. Yea, while I'm not sure this is the issue at hand, it does look
like I need to get some of the boot ordering worked out here. Using the
PIT early on probably isn't the best solution as the 18us access latency
might not be the best for the transition calibration. Currently jiffies
is the default clocksource until late_initcall time, which was done to
minimize the clocksource churn at boot time.  I'm not quite recalling
the details, but I think the motivation was to avoid confusion when
looking at the dmesg, so we could instead allow clocksources to be
selected as they load, but disable printing anything to dmesg until
after late_initcall.

I'll start working on that.

thanks
-john




This patch tries blocking the cpufreq changes to see if its causing the
accounting issue.

diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index 7e0d8da..24af443 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -356,7 +356,7 @@ static int tsc_update_callback(void)
 	}
 
 	/* only update if tsc_khz has changed: */
-	if (current_tsc_khz != tsc_khz) {
+	if (0 && current_tsc_khz != tsc_khz) {
 		current_tsc_khz = tsc_khz;
 		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
 							clocksource_tsc.shift);


