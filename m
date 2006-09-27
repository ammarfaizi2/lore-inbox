Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWI0C4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWI0C4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 22:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWI0C4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 22:56:41 -0400
Received: from havoc.gtf.org ([69.61.125.42]:25265 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932328AbWI0C4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 22:56:40 -0400
Date: Tue, 26 Sep 2006 22:56:39 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFT] libata AHCI reset speed-up, improvements
Message-ID: <20060927025639.GA16969@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch, diff'd against 2.6.18-git5 (or later), attempts the
following improvements:

* Speed up reset, by polling rather than unconditionally sleeping
  for one seconds.
* Save the Ports-Implemented register across controller resets.
* Verify that AHCI mode was truly enabled.

I'm quite interested in hearing people's test feedback on this patch.
On my own ICH7 machine, it introduces a "softreset failed" error, but
EH recovers nicely and nonetheless configures everything successfully.
Probably just a slow ATAPI device, but I may have exposed a latent
problem in the driver that was hidden until now by the ssleep(1).

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1aabc81..1def9c9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -40,6 +40,7 @@ #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
@@ -593,11 +594,13 @@ static int ahci_deinit_port(void __iomem
 
 static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 {
-	u32 cap_save, tmp;
+	u32 cap_save, impl_save, tmp;
+	unsigned long end_time;
 
 	cap_save = readl(mmio + HOST_CAP);
 	cap_save &= ( (1<<28) | (1<<17) );
 	cap_save |= (1 << 27);
+	impl_save = readl(mmio + HOST_PORTS_IMPL);
 
 	/* global controller reset */
 	tmp = readl(mmio + HOST_CTL);
@@ -609,19 +612,36 @@ static int ahci_reset_controller(void __
 	/* reset must complete within 1 second, or
 	 * the hardware should be considered fried.
 	 */
-	ssleep(1);
+	end_time = jiffies + HZ;
+	while (1) {
+		msleep(100);
+
+		tmp = readl(mmio + HOST_CTL);
+		if (!(tmp & HOST_RESET))
+			break;
+		if (time_after(jiffies, end_time))
+			break;
+
+	}
 
-	tmp = readl(mmio + HOST_CTL);
 	if (tmp & HOST_RESET) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "controller reset failed (0x%x)\n", tmp);
 		return -EIO;
 	}
 
+	/* turn on AHCI mode */
 	writel(HOST_AHCI_EN, mmio + HOST_CTL);
 	(void) readl(mmio + HOST_CTL);	/* flush */
+
+	/*
+	 * these write-once registers are normally cleared
+	 * on reset.  Restore BIOS values... which we HOPE
+	 * were present before reset.
+	 */
+
 	writel(cap_save, mmio + HOST_CAP);
-	writel(0xf, mmio + HOST_PORTS_IMPL);
+	writel(impl_save, mmio + HOST_PORTS_IMPL);
 	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
@@ -633,6 +653,19 @@ static int ahci_reset_controller(void __
 		pci_write_config_word(pdev, 0x92, tmp16);
 	}
 
+	/*
+	 * if AHCI failed to enable, AHCI function may not
+	 * be present in the chipset.  This is true of certain
+	 * ICHx chipsets, which export the SATA phy registers
+	 * via the AHCI memory space, but don't support full AHCI.
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_AHCI_EN)) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "AHCI enable failed (0x%x)\n", tmp);
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
