Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161935AbWJDRkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161935AbWJDRkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161915AbWJDRi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:26 -0400
Received: from www.osadl.org ([213.239.205.134]:38629 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161916AbWJDRiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:05 -0400
Message-Id: <20061004172223.808104000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:47 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 17/22] GTOD: Mark TSC unusable for highres timers
Content-Disposition: inline; filename=gtod-mark-tsc-unusable-for-highres.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The TSC is too unstable and unreliable to be used with high
resolution timers. The automatic detection of TSC unstability
fails once we switched to high resolution mode, because the
tick emulation would use the TSC as reference. This results in
a circular dependency. Mark it unusable for high res upfront.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
 arch/i386/kernel/tsc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm3/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.18-mm3.orig/arch/i386/kernel/tsc.c	2006-10-04 18:20:12.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/kernel/tsc.c	2006-10-04 18:26:38.000000000 +0200
@@ -459,10 +459,23 @@ static int __init init_tsc_clocksource(v
 		current_tsc_khz = tsc_khz;
 		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
 							clocksource_tsc.shift);
+#ifndef CONFIG_HIGH_RES_TIMERS
 		/* lower the rating if we already know its unstable: */
 		if (check_tsc_unstable())
 			clocksource_tsc.rating = 50;
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

--

