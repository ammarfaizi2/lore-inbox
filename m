Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVEWG43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVEWG43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 02:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVEWG43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 02:56:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:16579 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261839AbVEWG4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 02:56:22 -0400
Subject: [PATCH] ppc64: Fix g5 hw timebase sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Mon, 23 May 2005 16:54:14 +1000
Message-Id: <1116831255.20084.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The hardware sync of the timebase on SMP G5s uses a black magic
incantation to the i2c clock chip that was inspired from what Darwin
does. However, this was an earlier version of Darwin that was ...
buggy ! heh. This cause the latest models to break though when starting
SMP, so it's worth fixing. Here's a new version of the incantation based
on careful transcription of the said incantations as found in the latest
version of apple's temple.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pmac_smp.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_smp.c	2005-01-24 17:09:25.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pmac_smp.c	2005-02-11 19:11:43.365862704 +1100
@@ -68,6 +68,7 @@
 
 static void (*pmac_tb_freeze)(int freeze);
 static struct device_node *pmac_tb_clock_chip_host;
+static u8 pmac_tb_pulsar_addr;
 static DEFINE_SPINLOCK(timebase_lock);
 static unsigned long timebase;
 
@@ -106,12 +107,9 @@
 	u8 data;
 	int rc;
 
-	/* Strangely, the device-tree says address is 0xd2, but darwin
-	 * accesses 0xd0 ...
-	 */
 	pmac_low_i2c_setmode(pmac_tb_clock_chip_host, pmac_low_i2c_mode_combined);
 	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
-			       0xd4 | pmac_low_i2c_read,
+			       pmac_tb_pulsar_addr | pmac_low_i2c_read,
 			       0x2e, &data, 1);
 	if (rc != 0)
 		goto bail;
@@ -120,7 +118,7 @@
 
 	pmac_low_i2c_setmode(pmac_tb_clock_chip_host, pmac_low_i2c_mode_stdsub);
 	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
-			       0xd4 | pmac_low_i2c_write,
+			       pmac_tb_pulsar_addr | pmac_low_i2c_write,
 			       0x2e, &data, 1);
  bail:
 	if (rc != 0) {
@@ -185,6 +183,12 @@
 	if (ncpus <= 1)
 		return 1;
 
+	/* HW sync only on these platforms */
+	if (!machine_is_compatible("PowerMac7,2") &&
+	    !machine_is_compatible("PowerMac7,3") &&
+	    !machine_is_compatible("RackMac3,1"))
+		goto nohwsync;
+
 	/* Look for the clock chip */
 	for (cc = NULL; (cc = of_find_node_by_name(cc, "i2c-hwclock")) != NULL;) {
 		struct device_node *p = of_get_parent(cc);
@@ -198,11 +202,18 @@
 			goto next;
 		switch (*reg) {
 		case 0xd2:
-			pmac_tb_freeze = smp_core99_cypress_tb_freeze;
-			printk(KERN_INFO "Timebase clock is Cypress chip\n");
+			if (device_is_compatible(cc, "pulsar-legacy-slewing")) {
+				pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
+				pmac_tb_pulsar_addr = 0xd2;
+				printk(KERN_INFO "Timebase clock is Pulsar chip\n");
+			} else if (device_is_compatible(cc, "cy28508")) {
+				pmac_tb_freeze = smp_core99_cypress_tb_freeze;
+				printk(KERN_INFO "Timebase clock is Cypress chip\n");
+			}
 			break;
 		case 0xd4:
 			pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
+			pmac_tb_pulsar_addr = 0xd4;
 			printk(KERN_INFO "Timebase clock is Pulsar chip\n");
 			break;
 		}
@@ -210,12 +221,15 @@
 			pmac_tb_clock_chip_host = p;
 			smp_ops->give_timebase = smp_core99_give_timebase;
 			smp_ops->take_timebase = smp_core99_take_timebase;
+			of_node_put(cc);
+			of_node_put(p);
 			break;
 		}
 	next:
 		of_node_put(p);
 	}
 
+ nohwsync:
 	mpic_request_ipis();
 
 	return ncpus;


