Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424260AbWKIXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424260AbWKIXng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424207AbWKIXjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:39 -0500
Received: from www.osadl.org ([213.239.205.134]:3485 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161874AbWKIXjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:14 -0500
Message-Id: <20061109233035.569684000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:30 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Content-Disposition: inline;
	filename=gtod-mark-tsc-unusable-for-highres-timers.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The TSC is too unstable and unreliable to be used with high resolution timers.
The automatic detection of TSC unstability fails once we switched to high
resolution mode, because the tick emulation would use the TSC as reference. 
This results in a circular dependency.  Mark it unusable for high res upfront.

[akpm@osdl.org: updated for i386-time-avoid-pit-smp-lockups.patch]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff -puN arch/i386/kernel/tsc.c~gtod-mark-tsc-unusable-for-highres-timers arch/i386/kernel/tsc.c
--- a/arch/i386/kernel/tsc.c~gtod-mark-tsc-unusable-for-highres-timers
+++ a/arch/i386/kernel/tsc.c
@@ -459,10 +459,23 @@ static int __init init_tsc_clocksource(v
 		current_tsc_khz = tsc_khz;
 		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
 							clocksource_tsc.shift);
+#ifndef CONFIG_HIGH_RES_TIMERS
 		/* lower the rating if we already know its unstable: */
 		if (check_tsc_unstable())
 			clocksource_tsc.rating = 0;
-
+#else
+		/*
+		 * Mark TSC unsuitable for high resolution timers. TSC has so
+		 * many pitfalls: frequency changes, stop in idle ...  When we
+		 * switch to high resolution mode we can not longer detect a
+		 * firmware caused frequency change, as the emulated tick uses
+		 * TSC as reference. This results in a circular dependency.
+		 * Switch only to high resolution mode, if pm_timer or such
+		 * is available.
+		 */
+		clocksource_tsc.rating = 50;
+		clocksource_tsc.is_continuous = 0;
+#endif
 		init_timer(&verify_tsc_freq_timer);
 		verify_tsc_freq_timer.function = verify_tsc_freq;
 		verify_tsc_freq_timer.expires =
_

--

