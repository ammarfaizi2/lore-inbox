Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVAVFgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVAVFgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 00:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAVFgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 00:36:13 -0500
Received: from ozlabs.org ([203.10.76.45]:14318 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262664AbVAVFgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 00:36:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.58546.219540.506298@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 16:29:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, nacc@us.ibm.com
Subject: [PATCH] PPC64 replace schedule_timeout in iSeries_pci_reset
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nishanth Aravamudan <nacc@us.ibm.com>.

Replace schedule_timeout() with msleep to simplify the code and to
express the delay in milliseconds instead of HZ.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- 2.6.11-rc1-kj-v/arch/ppc64/kernel/iSeries_pci_reset.c	2005-01-15 16:55:41.000000000 -0800
+++ 2.6.11-rc1-kj/arch/ppc64/kernel/iSeries_pci_reset.c	2005-01-15 17:17:54.000000000 -0800
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/iSeries/HvCallPci.h>
@@ -49,7 +50,7 @@
 int iSeries_Device_ToggleReset(struct pci_dev *PciDev, int AssertTime,
 		int DelayTime)
 {
-	unsigned long AssertDelay, WaitDelay;
+	unsigned int AssertDelay, WaitDelay;
 	struct iSeries_Device_Node *DeviceNode =
 		(struct iSeries_Device_Node *)PciDev->sysdata;
 
@@ -62,14 +63,14 @@ int iSeries_Device_ToggleReset(struct pc
 	 * Set defaults, Assert is .5 second, Wait is 3 seconds.
 	 */
 	if (AssertTime == 0)
-		AssertDelay = (5 * HZ) / 10;
+		AssertDelay = 500;
 	else
-		AssertDelay = (AssertTime * HZ) / 10;
+		AssertDelay = AssertTime * 100;
 
 	if (DelayTime == 0)
-		WaitDelay = (30 * HZ) / 10;
+		WaitDelay = 3000;
 	else
-		WaitDelay = (DelayTime * HZ) / 10;
+		WaitDelay = DelayTime * 100;
 
 	/*
 	 * Assert reset
@@ -77,8 +78,7 @@ int iSeries_Device_ToggleReset(struct pc
 	DeviceNode->ReturnCode = HvCallPci_setSlotReset(ISERIES_BUS(DeviceNode),
 			0x00, DeviceNode->AgentId, 1);
 	if (DeviceNode->ReturnCode == 0) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(AssertDelay);       /* Sleep for the time */
+		msleep(AssertDelay);			/* Sleep for the time */
 		DeviceNode->ReturnCode =
 			HvCallPci_setSlotReset(ISERIES_BUS(DeviceNode),
 					0x00, DeviceNode->AgentId, 0);
@@ -86,8 +86,7 @@ int iSeries_Device_ToggleReset(struct pc
 		/*
    		 * Wait for device to reset
 		 */
-		set_current_state(TASK_UNINTERRUPTIBLE);  
-		schedule_timeout(WaitDelay);
+		msleep(WaitDelay);
 	}
 	if (DeviceNode->ReturnCode == 0)
 		PCIFR("Slot 0x%04X.%02 Reset\n", ISERIES_BUS(DeviceNode),
