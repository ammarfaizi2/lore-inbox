Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937355AbWLDUPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937355AbWLDUPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937333AbWLDUPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:15:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46208 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937355AbWLDUPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:15:21 -0500
Subject: Re: PMTMR running too fast
From: john stultz <johnstul@us.ibm.com>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <1165261226.5499.54.camel@localhost.localdomain>
References: <1165153834.5499.40.camel@localhost.localdomain>
	 <1165259962.6152.5.camel@localhost.localdomain>
	 <1165261226.5499.54.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 12:14:56 -0800
Message-Id: <1165263296.6152.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 19:40 +0000, Ian Campbell wrote:
> On Mon, 2006-12-04 at 11:19 -0800, john stultz wrote:
> > On Sun, 2006-12-03 at 13:50 +0000, Ian Campbell wrote:
> > > In older kernels arch/i386/kernel/timers/timer_pm.c:verify_pmtmr_rate
> > > contained a check for sensible PMTMR rate and disabled that clocksource
> > > if it was found to be out of spec[0]. This check seems to have been lost
> > > in the transition to drivers/clocksource/acpi_pm.c, the removal is in
> > > 61743fe445213b87fb55a389c8d073785323ca3e "Time: i386 Conversion - part
> > > 4: Remove Old timer_opts Code"[1] and the check is not present in the
> > > replacement 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa "Time: i386
> > > Clocksource Drivers"[2].
> > 
> > Fedora has a bug covering this:
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=211902
> 
> > > Is there a specific reason the check was removed (I couldn't see on in
> > > the archives) or was it simply overlooked? Without it I need to pass
> > > clocksource=tsc to have 2.6.18 work correctly on an older K6 system with
> > > an Aladdin chipset (will dig out the precise details if required). Would
> > > a patch to reintroduce the check be acceptable or would some sort of
> > > blacklist based solution be more acceptable?
> > 
> > If I recall correctly, it was pulled because there was some question as
> > to if it was actually needed (x86_64 didn't need it) and it slows down
> > the boot time (although not by much). 
> > 
> > I'm fine just re-adding it. Although if the number of affected systems
> > are small we could just blacklist it (Ian, mind sending dmidecode
> > output?).

I don't have a dev box to test on at the moment, but here's a quick hack
attempt at re-adding the code. Does the following work for you? 

thanks
-john


diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 7fcb77a..3379b5f 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -21,9 +21,12 @@ #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
+#include "mach_timer.h"
 
 /* Number of PMTMR ticks expected during calibration run */
 #define PMTMR_TICKS_PER_SEC 3579545
+#define PMTMR_EXPECTED_RATE \
+  ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
 
 /*
  * The I/O port the PMTMR resides at.
@@ -142,6 +145,36 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SE
 			acpi_pm_check_graylist);
 #endif
 
+#ifndef CONFIG_X86_64
+/*
+ * Some boards have the PMTMR running way too fast. We check
+ * the PMTMR rate against PIT channel 2 to catch these cases.
+ */
+static int verify_pmtmr_rate(void)
+{
+	u32 value1, value2;
+	unsigned long count, delta;
+
+	mach_prepare_counter();
+	value1 = read_pmtmr();
+	mach_countup(&count);
+	value2 = read_pmtmr();
+	delta = (value2 - value1) & ACPI_PM_MASK;
+
+	/* Check that the PMTMR delta is within 5% of what we expect */
+	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
+	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
+		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% "
+			"of normal - aborting.\n",
+			100UL * delta / PMTMR_EXPECTED_RATE);
+		return -1;
+	}
+
+	return 0;
+}
+#else
+#define verify_pmtmr_rate() (0)
+#endif
 
 static int __init init_acpi_pm_clocksource(void)
 {
@@ -173,6 +206,9 @@ static int __init init_acpi_pm_clocksour
 	return -ENODEV;
 
 pm_good:
+	if (verify_pmtmr_rate() != 0)
+		return -ENODEV;
+
 	return clocksource_register(&clocksource_acpi_pm);
 }
 


