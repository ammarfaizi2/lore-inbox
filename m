Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423034AbWJQEaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423034AbWJQEaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWJQE37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:29:59 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:12470 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1423028AbWJQE3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:29:38 -0400
Subject: [PATCH 2/2] arch/i386/kernel/time_hpet.c: ioremap balanced with
	iounmap
From: Amol Lad <amol@verismonetworks.com>
To: venkatesh.pallipadi@intel.com
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 10:02:51 +0530
Message-Id: <1161059571.20400.27.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/time_hpet.c linux-2.6.19-rc1/arch/i386/kernel/time_hpet.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/time_hpet.c	2006-10-05 14:00:38.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/time_hpet.c	2006-10-05 18:30:07.000000000 +0530
@@ -132,14 +132,20 @@ int __init hpet_enable(void)
 	 * the single HPET timer for system time.
 	 */
 #ifdef CONFIG_HPET_EMULATE_RTC
-	if (!(id & HPET_ID_NUMBER))
+	if (!(id & HPET_ID_NUMBER)) {
+		iounmap(hpet_virt_address);
+		hpet_virt_address = NULL;
 		return -1;
+	}
 #endif
 
 
 	hpet_period = hpet_readl(HPET_PERIOD);
-	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD))
+	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD)) {
+		iounmap(hpet_virt_address);
+		hpet_virt_address = NULL;
 		return -1;
+	}
 
 	/*
 	 * 64 bit math
@@ -156,8 +162,11 @@ int __init hpet_enable(void)
 
 	hpet_use_timer = id & HPET_ID_LEGSUP;
 
-	if (hpet_timer_stop_set_go(hpet_tick))
+	if (hpet_timer_stop_set_go(hpet_tick)) {
+		iounmap(hpet_virt_address);
+		hpet_virt_address = NULL;
 		return -1;
+	}
 
 	use_hpet = 1;
 


