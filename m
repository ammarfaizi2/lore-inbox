Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVCIU7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVCIU7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCIU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:58:55 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:13016 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262453AbVCIU5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:57:19 -0500
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: fix fatal error int handling
Message-Id: <20050309205714.DBED014FA3@lns1032.lss.emc.com>
Date: Wed,  9 Mar 2005 15:57:14 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the AHCI CI (cmd issue) reg wasn't getting cleared
after error ints resulting in no further commands being successfully
issued to the port.  This patch fixes.  All that's really needed is
the 1's complement but I also removed the disabling/enabling of the
FIS_RX b/c this isn't spec'd as necessary when handling error ints.

Signed-off-by: Brett Russ <russb@emc.com>

===== drivers/scsi/ahci.c 1.17 vs edited =====
--- 1.17/drivers/scsi/ahci.c	2005-02-24 14:52:41 -05:00
+++ edited/drivers/scsi/ahci.c	2005-03-09 15:30:06 -05:00
@@ -538,7 +538,7 @@
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
 	/* wait for engine to stop.  TODO: this could be
@@ -570,7 +570,7 @@
 
 	/* re-start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
