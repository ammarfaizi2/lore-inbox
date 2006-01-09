Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWAIUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWAIUYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAIUYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:24:22 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:63723
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751315AbWAIUYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:24:22 -0500
Subject: [PATCH] synclink_gt remove unnecessary page alignment
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1136838251.5489.3.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 09 Jan 2006 14:24:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary and incorrectly implemented page
alignment of register base address before calling ioremap()

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.15/drivers/char/synclink_gt.c	2006-01-09 14:16:40.000000000 -0600
+++ linux-2.6.15-mg/drivers/char/synclink_gt.c	2006-01-09 14:16:10.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- * $Id: synclink_gt.c,v 4.20 2005/11/08 19:51:55 paulkf Exp $
+ * $Id: synclink_gt.c,v 4.22 2006/01/09 20:16:06 paulkf Exp $
  *
  * Device driver for Microgate SyncLink GT serial adapters.
  *
@@ -93,7 +93,7 @@
  * module identification
  */
 static char *driver_name     = "SyncLink GT";
-static char *driver_version  = "$Revision: 4.20 $";
+static char *driver_version  = "$Revision: 4.22 $";
 static char *tty_driver_name = "synclink_gt";
 static char *tty_dev_prefix  = "ttySLG";
 MODULE_LICENSE("GPL");
@@ -289,7 +289,6 @@ struct slgt_info {
 
 	unsigned char __iomem * reg_addr;  /* memory mapped registers address */
 	u32 phys_reg_addr;
-	u32 reg_offset;
 	int reg_addr_requested;
 
 	MGSL_PARAMS params;       /* communications parameters */
@@ -2978,14 +2977,13 @@ static int claim_resources(struct slgt_i
 	else
 		info->reg_addr_requested = 1;
 
-	info->reg_addr = ioremap(info->phys_reg_addr, PAGE_SIZE);
+	info->reg_addr = ioremap(info->phys_reg_addr, SLGT_REG_SIZE);
 	if (!info->reg_addr) {
 		DBGERR(("%s cant map device registers, addr=%08X\n",
 			info->device_name, info->phys_reg_addr));
 		info->init_error = DiagStatus_CantAssignPciResources;
 		goto errout;
 	}
-	info->reg_addr += info->reg_offset;
 	return 0;
 
 errout:
@@ -3006,7 +3004,7 @@ static void release_resources(struct slg
 	}
 
 	if (info->reg_addr) {
-		iounmap(info->reg_addr - info->reg_offset);
+		iounmap(info->reg_addr);
 		info->reg_addr = NULL;
 	}
 }
@@ -3110,12 +3108,6 @@ static struct slgt_info *alloc_dev(int a
 		info->irq_level = pdev->irq;
 		info->phys_reg_addr = pci_resource_start(pdev,0);
 
-		/* veremap works on page boundaries
-		 * map full page starting at the page boundary
-		 */
-		info->reg_offset    = info->phys_reg_addr & (PAGE_SIZE-1);
-		info->phys_reg_addr &= ~(PAGE_SIZE-1);
-
 		info->bus_type = MGSL_BUS_TYPE_PCI;
 		info->irq_flags = SA_SHIRQ;
 


