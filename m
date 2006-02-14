Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWBNMWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWBNMWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWBNMWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:22:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35201 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161029AbWBNMWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:22:15 -0500
Date: Tue, 14 Feb 2006 13:20:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: [patch] hrtimer: round up relative start time on low-res arches
Message-ID: <20060214122031.GA30983@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home> <20060214074151.GA29426@elte.hu> <Pine.LNX.4.61.0602141113060.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602141113060.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

find below a patch with less impact than blanket upwards rounding of 
relatime timeouts. This i think is better for v2.6.16 - it accurately 
documents the problem architectures that have low-res do_gettimeofday(), 
and doesnt impact other architectures. This will go away with John's 
GTOD patchset. I've reviewed every architecture for the (worst-case) 
resolution of their do_gettimeofday() implementations, and this is the 
result of that review.

	Ingo

-----

CONFIG_TIME_LOW_RES is a temporary way for architectures to signal that 
they simply return xtime in do_gettimeoffset(). In this corner-case we 
want to round up by resolution when starting a relative timer, to avoid 
short timeouts. This will go away with the GTOD framework.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/frv/Kconfig       |    4 ++++
 arch/h8300/Kconfig     |    4 ++++
 arch/m68k/Kconfig      |    4 ++++
 arch/m68knommu/Kconfig |    4 ++++
 arch/parisc/Kconfig    |    5 +++++
 arch/v850/Kconfig      |    4 ++++
 kernel/hrtimer.c       |   13 ++++++++++++-
 7 files changed, 37 insertions(+), 1 deletion(-)

Index: linux/arch/frv/Kconfig
===================================================================
--- linux.orig/arch/frv/Kconfig
+++ linux/arch/frv/Kconfig
@@ -25,6 +25,10 @@ config GENERIC_HARDIRQS
 	bool
 	default n
 
+config TIME_LOW_RES
+	bool
+	default y
+
 mainmenu "Fujitsu FR-V Kernel Configuration"
 
 source "init/Kconfig"
Index: linux/arch/h8300/Kconfig
===================================================================
--- linux.orig/arch/h8300/Kconfig
+++ linux/arch/h8300/Kconfig
@@ -33,6 +33,10 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config TIME_LOW_RES
+	bool
+	default y
+
 config ISA
 	bool
 	default y
Index: linux/arch/m68k/Kconfig
===================================================================
--- linux.orig/arch/m68k/Kconfig
+++ linux/arch/m68k/Kconfig
@@ -21,6 +21,10 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config TIME_LOW_RES
+	bool
+	default y
+
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 	depends on Q40 || (BROKEN && SUN3X)
Index: linux/arch/m68knommu/Kconfig
===================================================================
--- linux.orig/arch/m68knommu/Kconfig
+++ linux/arch/m68knommu/Kconfig
@@ -29,6 +29,10 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config TIME_LOW_RES
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"
Index: linux/arch/parisc/Kconfig
===================================================================
--- linux.orig/arch/parisc/Kconfig
+++ linux/arch/parisc/Kconfig
@@ -29,6 +29,11 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config TIME_LOW_RES
+	bool
+	depends on SMP
+	default y
+
 config GENERIC_ISA_DMA
 	bool
 
Index: linux/arch/v850/Kconfig
===================================================================
--- linux.orig/arch/v850/Kconfig
+++ linux/arch/v850/Kconfig
@@ -28,6 +28,10 @@ config GENERIC_IRQ_PROBE
 	bool
 	default y
 
+config TIME_LOW_RES
+	bool
+	default y
+
 # Turn off some random 386 crap that can affect device config
 config ISA
 	bool
Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -418,8 +418,19 @@ hrtimer_start(struct hrtimer *timer, kti
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base);
 
-	if (mode == HRTIMER_REL)
+	if (mode == HRTIMER_REL) {
 		tim = ktime_add(tim, new_base->get_time());
+		/*
+		 * CONFIG_TIME_LOW_RES is a temporary way for architectures
+		 * to signal that they simply return xtime in
+		 * do_gettimeoffset(). In this case we want to round up by
+		 * resolution when starting a relative timer, to avoid short
+		 * timeouts. This will go away with the GTOD framework.
+		 */
+#ifdef CONFIG_TIME_LOW_RES
+		tim = ktime_add(tim, base->resolution);
+#endif
+	}
 	timer->expires = tim;
 
 	enqueue_hrtimer(timer, new_base);
