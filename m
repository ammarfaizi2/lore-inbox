Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVLENLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVLENLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVLENL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:11:29 -0500
Received: from tim.rpsys.net ([194.106.48.114]:39095 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932411AbVLENLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:11:19 -0500
Subject: [RFC PATCH 8/8] LED: Add NAND MTD activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:10:58 +0000
Message-Id: <1133788258.8101.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LED trigger for MTD NAND activity to the MTD subsystem.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.15-rc2/drivers/mtd/nand/nand_base.c
===================================================================
--- linux-2.6.15-rc2.orig/drivers/mtd/nand/nand_base.c	2005-11-20 03:25:03.000000000 +0000
+++ linux-2.6.15-rc2/drivers/mtd/nand/nand_base.c	2005-11-28 15:55:57.000000000 +0000
@@ -80,6 +80,7 @@
 #include <linux/mtd/compatmac.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/leds.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_MTD_PARTITIONS
@@ -515,6 +516,8 @@
 	return nand_isbad_bbt (mtd, ofs, allowbbt);
 }
 
+INIT_LED_TRIGGER(nand_led_trigger);
+
 /*
  * Wait for the ready pin, after a command
  * The timeout is catched later.
@@ -524,12 +527,14 @@
 	struct nand_chip *this = mtd->priv;
 	unsigned long	timeo = jiffies + 2;
 
+	led_trigger_event(nand_led_trigger, 100);
 	/* wait until command is processed or timeout occures */
 	do {
 		if (this->dev_ready(mtd))
-			return;
+			break;
 		touch_softlockup_watchdog();
 	} while (time_before(jiffies, timeo));
+	led_trigger_event(nand_led_trigger, 0);
 }
 
 /**
@@ -817,6 +822,8 @@
 	else
 		 timeo += (HZ * 20) / 1000;
 
+	led_trigger_event(nand_led_trigger, 100);
+
 	/* Apply this short delay always to ensure that we do wait tWB in
 	 * any case on any machine. */
 	ndelay (100);
@@ -840,6 +847,8 @@
 		}
 		cond_resched();
 	}
+	led_trigger_event(nand_led_trigger, 0);
+	
 	status = (int) this->read_byte(mtd);
 	return status;
 }
@@ -2724,6 +2733,21 @@
 EXPORT_SYMBOL_GPL (nand_scan);
 EXPORT_SYMBOL_GPL (nand_release);
 
+
+static int __init nand_base_init(void)
+{
+	led_trigger_register_simple("nand-disk", &nand_led_trigger);
+	return 0;
+}
+    
+static void nand_base_exit(void)
+{
+	led_trigger_unregister_simple(nand_led_trigger);
+}
+
+module_init(nand_base_init);
+module_exit(nand_base_exit);
+
 MODULE_LICENSE ("GPL");
 MODULE_AUTHOR ("Steven J. Hill <sjhill@realitydiluted.com>, Thomas Gleixner <tglx@linutronix.de>");
 MODULE_DESCRIPTION ("Generic NAND flash driver code");


