Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUHSUmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUHSUmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUHSUmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:42:32 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:2055 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S267386AbUHSUjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:39:47 -0400
Message-ID: <4125106A.2020903@nvidia.com>
Date: Thu, 19 Aug 2004 13:41:14 -0700
From: achew <achew@nvidia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH 2.6.8.1] sata_nv.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2004 20:39:45.0958 (UTC) FILETIME=[A9DAAC60:01C4862C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem introduced when CK804 support was added.  mmio_base can only be set in the CK804 case,
else libata will attempt to iounmap mmio_base, which isn't iomapped for the non-CK804 case.  Still need the bar 5
address, so steal from host_set->ports[0]->ioaddr.scr_addr.  Jeff, let me know if this is a bad thing to do.




--- linux-2.6.8.1/drivers/scsi/sata_nv.c	2004-08-19 13:38:27.630375944 -0700
+++ linux/drivers/scsi/sata_nv.c	2004-08-19 13:36:05.668957360 -0700
@@ -20,6 +20,10 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.03
+ *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
+ *       mmio_base, which is only set for the CK804/MCP04 case.
+ *
  *  0.02
  *     - Added support for CK804 SATA controller.
  *
@@ -40,7 +44,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.02"
+#define DRV_VERSION			"0.03"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -417,33 +421,33 @@
 	u8 intr_mask;
 
 	outb(NV_INT_STATUS_HOTPLUG,
-		(unsigned long)probe_ent->mmio_base + NV_INT_STATUS);
+		probe_ent->port[0].scr_addr + NV_INT_STATUS);
 
-	intr_mask = inb((unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+	intr_mask = inb(probe_ent->port[0].scr_addr + NV_INT_ENABLE);
 	intr_mask |= NV_INT_ENABLE_HOTPLUG;
 
-	outb(intr_mask, (unsigned long)probe_ent->mmio_base + NV_INT_ENABLE);
+	outb(intr_mask, probe_ent->port[0].scr_addr + NV_INT_ENABLE);
 }
 
 static void nv_disable_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_mask;
 
-	intr_mask = inb((unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+	intr_mask = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 
 	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
 
-	outb(intr_mask, (unsigned long)host_set->mmio_base + NV_INT_ENABLE);
+	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
 static void nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
-	intr_status = inb((unsigned long)host_set->mmio_base + NV_INT_STATUS);
+	intr_status = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
 
 	// Clear interrupt status.
-	outb(0xff, (unsigned long)host_set->mmio_base + NV_INT_STATUS);
+	outb(0xff, host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
 
 	if (intr_status & NV_INT_STATUS_HOTPLUG) {
 		if (intr_status & NV_INT_STATUS_PDEV_ADDED)


