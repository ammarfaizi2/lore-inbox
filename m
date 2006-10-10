Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWJJRJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJJRJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWJJRJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:09:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34976 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964773AbWJJRJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:09:30 -0400
Date: Tue, 10 Oct 2006 12:09:25 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] ioc4: Remove SN2 feature and config dependencies
Message-ID: <20061010120419.U71367@pkunk.americas.sgi.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI PCI-RT card, based on the SGI IOC4 chip, will be made available
on Altix XE (x86_64) platforms in the near future.  As such dependencies
on SN2-specific features and config dependencies need to be removed.

This patch updates the Kconfig files to remove the config dependency, and
updates the IOC4 bus speed detection routine to use universally available
time interfaces instead of mmtimer.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
---
 drivers/sn/Kconfig |   13 ++++++-------
 drivers/sn/ioc4.c  |   36 +++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 26 deletions(-)
---
Index: top/drivers/sn/Kconfig
===================================================================
--- top.orig/drivers/sn/Kconfig	2006-10-09 17:28:17.740084084 -0500
+++ top/drivers/sn/Kconfig	2006-10-09 17:46:07.535130727 -0500
@@ -7,16 +7,15 @@
 
 config SGI_IOC4
 	tristate "SGI IOC4 Base IO support"
-	depends on MMTIMER
 	default m
 	---help---
-	This option enables basic support for the SGI IOC4-based Base IO
-	controller card.  This option does not enable any specific
-	functions on such a card, but provides necessary infrastructure
-	for other drivers to utilize.
+	This option enables basic support for the IOC4 chip on certain
+	SGI IO controller cards (IO9, IO10, and PCI-RT).  This option
+	does not enable any specific functions on such a card, but provides
+	necessary infrastructure for other drivers to utilize.
 
-	If you have an SGI Altix with an IOC4-based
-	I/O controller say Y.  Otherwise say N.
+	If you have an SGI Altix with an IOC4-based card say Y.
+	Otherwise say N.
 
 config SGI_IOC3
 	tristate "SGI IOC3 Base IO support"
Index: top/drivers/sn/ioc4.c
===================================================================
--- top.orig/drivers/sn/ioc4.c	2006-10-09 17:28:17.740084084 -0500
+++ top/drivers/sn/ioc4.c	2006-10-09 17:41:25.672657192 -0500
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (C) 2005-2006 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /* This file contains the master driver module for use by SGI IOC4 subdrivers.
@@ -29,9 +29,9 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ioc4.h>
-#include <linux/mmtimer.h>
-#include <linux/rtc.h>
+#include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <linux/time.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/clksupport.h>
 #include <asm/sn/shub_mmr.h>
@@ -43,7 +43,7 @@
 /* Tweakable values */
 
 /* PCI bus speed detection/calibration */
-#define IOC4_CALIBRATE_COUNT 63	/* Calibration cycle period */
+#define IOC4_CALIBRATE_COUNT 63		/* Calibration cycle period */
 #define IOC4_CALIBRATE_CYCLES 256	/* Average over this many cycles */
 #define IOC4_CALIBRATE_DISCARD 2	/* Discard first few cycles */
 #define IOC4_CALIBRATE_LOW_MHZ 25	/* Lower bound on bus speed sanity */
@@ -143,11 +143,11 @@
 static void
 ioc4_clock_calibrate(struct ioc4_driver_data *idd)
 {
-	extern unsigned long sn_rtc_cycles_per_second;
 	union ioc4_int_out int_out;
 	union ioc4_gpcr gpcr;
 	unsigned int state, last_state = 1;
-	uint64_t start = 0, end, period;
+	struct timespec start_ts, end_ts;
+	uint64_t start, end, period;
 	unsigned int count = 0;
 
 	/* Enable output */
@@ -175,30 +175,28 @@
 		if (!last_state && state) {
 			count++;
 			if (count == IOC4_CALIBRATE_END) {
-				end = rtc_time();
+				ktime_get_ts(&end_ts);
 				break;
 			} else if (count == IOC4_CALIBRATE_DISCARD)
-				start = rtc_time();
+				ktime_get_ts(&start_ts);
 		}
 		last_state = state;
 	} while (1);
 
 	/* Calculation rearranged to preserve intermediate precision.
 	 * Logically:
-	 * 1. "end - start" gives us number of RTC cycles over all the
-	 *    square wave cycles measured.
-	 * 2. Divide by number of square wave cycles to get number of
-	 *    RTC cycles per square wave cycle.
+	 * 1. "end - start" gives us the measurement period over all
+	 *    the square wave cycles.
+	 * 2. Divide by number of square wave cycles to get the period
+	 *    of a square wave cycle.
 	 * 3. Divide by 2*(int_out.fields.count+1), which is the formula
 	 *    by which the IOC4 generates the square wave, to get the
-	 *    number of RTC cycles per IOC4 INT_OUT count.
-	 * 4. Divide by sn_rtc_cycles_per_second to get seconds per
-	 *    count.
-	 * 5. Multiply by 1E9 to get nanoseconds per count.
+	 *    period of an IOC4 INT_OUT count.
 	 */
-	period = ((end - start) * 1000000000) /
-	    (IOC4_CALIBRATE_CYCLES * 2 * (IOC4_CALIBRATE_COUNT + 1)
-	     * sn_rtc_cycles_per_second);
+	end = end_ts.tv_sec * NSEC_PER_SEC + end_ts.tv_nsec;
+	start = start_ts.tv_sec * NSEC_PER_SEC + start_ts.tv_nsec;
+	period = (end - start) /
+		(IOC4_CALIBRATE_CYCLES * 2 * (IOC4_CALIBRATE_COUNT + 1));
 
 	/* Bounds check the result. */
 	if (period > IOC4_CALIBRATE_LOW_LIMIT ||
