Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbUCZDdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbUCZDdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:33:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:61576 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263913AbUCZDb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:31:26 -0500
Subject: [PATCH] powerbook via-pmu races
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080271749.1196.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:29:09 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes some racy code in the management of asynchronous
brightness and battery requests in the via-pmu driver used on
powerbooks. This should fix some preempt related problems (there
is no SMP powerbook yet :)

Ben.

diff -urN linux-2.5/drivers/macintosh/via-pmu.c linuxppc-2.5-benh/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2004-03-01 18:11:44.000000000 +1100
+++ linuxppc-2.5-benh/drivers/macintosh/via-pmu.c	2004-03-25 18:52:00.000000000 +1100
@@ -137,7 +137,8 @@
 static int data_len;
 static volatile int adb_int_pending;
 static volatile int disable_poll;
-static struct adb_request bright_req_1, bright_req_2, bright_req_3;
+static struct adb_request bright_req_1, bright_req_2;
+static unsigned long async_req_locks;
 static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited = 0;
@@ -404,7 +405,6 @@
 
 	bright_req_1.complete = 1;
 	bright_req_2.complete = 1;
-	bright_req_3.complete = 1;
 #ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
 	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
@@ -710,6 +710,8 @@
 	pmu_batteries[pmu_cur_battery].amperage = amperage;
 	pmu_batteries[pmu_cur_battery].voltage = voltage;
 	pmu_batteries[pmu_cur_battery].time_remaining = time;
+
+	clear_bit(0, &async_req_locks);
 }
 
 static void __pmac
@@ -785,12 +787,14 @@
 		pmu_batteries[pmu_cur_battery].time_remaining = 0;
 
 	pmu_cur_battery = (pmu_cur_battery + 1) % pmu_battery_count;
+
+	clear_bit(0, &async_req_locks);
 }
 
 static void __pmac
 query_battery_state(void)
 {
-	if (!batt_req.complete)
+	if (test_and_set_bit(0, &async_req_locks))
 		return;
 	if (pmu_kind == PMU_OHARE_BASED)
 		pmu_request(&batt_req, done_battery_state_ohare,
@@ -1690,20 +1694,30 @@
 	return 0;
 }
 
+static void __openfirmware
+pmu_bright_complete(struct adb_request *req)
+{
+	if (req == &bright_req_1)
+		clear_bit(1, &async_req_locks);
+	if (req == &bright_req_2)
+		clear_bit(2, &async_req_locks);
+}
+
 static int __openfirmware
 pmu_set_backlight_level(int level, void* data)
 {
 	if (vias == NULL)
 		return -ENODEV;
 
-	if (!bright_req_1.complete)
+	if (test_and_set_bit(1, &async_req_locks))
 		return -EAGAIN;
-	pmu_request(&bright_req_1, NULL, 2, PMU_BACKLIGHT_BRIGHT,
+	pmu_request(&bright_req_1, pmu_bright_complete, 2, PMU_BACKLIGHT_BRIGHT,
 		backlight_to_bright[level]);
-	if (!bright_req_2.complete)
+	if (test_and_set_bit(2, &async_req_locks))
 		return -EAGAIN;
-	pmu_request(&bright_req_2, NULL, 2, PMU_POWER_CTRL, PMU_POW_BACKLIGHT
-		| (level > BACKLIGHT_OFF ? PMU_POW_ON : PMU_POW_OFF));
+	pmu_request(&bright_req_2, pmu_bright_complete, 2, PMU_POWER_CTRL,
+		    PMU_POW_BACKLIGHT | (level > BACKLIGHT_OFF ?
+					 PMU_POW_ON : PMU_POW_OFF));
 
 	return 0;
 }
@@ -2330,6 +2344,8 @@
 		return -EBUSY;
 	}
 	
+	preempt_disable();
+	
 	/* Make sure the decrementer won't interrupt us */
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 	/* Make sure any pending DEC interrupt occurring while we did
@@ -2352,6 +2368,7 @@
 	if (ret) {
 		wakeup_decrementer();
 		local_irq_enable();
+		preempt_enable();
 		device_resume();
 		broadcast_wake();
 		printk(KERN_ERR "Driver powerdown failed\n");
@@ -2360,7 +2377,8 @@
 
 	/* Wait for completion of async backlight requests */
 	while (!bright_req_1.complete || !bright_req_2.complete ||
-		!bright_req_3.complete || !batt_req.complete)
+
+			!batt_req.complete)
 		pmu_poll();
 
 	/* Giveup the lazy FPU & vec so we don't have to back them
@@ -2398,6 +2416,8 @@
 
 	pmu_blink(1);
 
+	preempt_enable();
+
 	/* Resume devices */
 	device_resume();
 
@@ -2673,9 +2693,9 @@
 		mb();
 
 	pmac_wakeup_devices();
-
 	pbook_free_pci_save();
 	iounmap(mem_ctrl);
+
 	return 0;
 }
 


