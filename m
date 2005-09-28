Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVI1VwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVI1VwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVI1VwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:52:20 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:24325 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750998AbVI1VwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:52:19 -0400
Date: Wed, 28 Sep 2005 17:50:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [patch 2.6.14-rc2] siimage: enable interrupts on Adaptec SA-1210 card
Message-ID: <09282005175050.10552@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The siimage driver proports to support the Adaptec SA-1210 SATA
controller. However, at least some of those cards boot-up with their
interrupts disabled internally. The siimage driver currently ignores
that fact, so that driver does not actually work with those cards. This
patch enables those interrupts on cards that need it.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This is implemented based on similar code in the libata-based sata_sil
driver.

 drivers/ide/pci/siimage.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -701,6 +701,7 @@ static unsigned int setup_mmio_siimage (
 	unsigned long barsize	= pci_resource_len(dev, 5);
 	u8 tmpbyte	= 0;
 	void __iomem *ioaddr;
+	u32 tmp, irq_mask;
 
 	/*
 	 *	Drop back to PIO if we can't map the mmio. Some
@@ -726,6 +727,14 @@ static unsigned int setup_mmio_siimage (
 	pci_set_drvdata(dev, (void *) ioaddr);
 
 	if (pdev_is_sata(dev)) {
+		/* make sure IDE0/1 interrupts are not masked */
+		irq_mask = (1 << 22) | (1 << 23);
+		tmp = readl(ioaddr + 0x48);
+		if (tmp & irq_mask) {
+			tmp &= ~irq_mask;
+			writel(tmp, ioaddr + 0x48);
+			readl(ioaddr + 0x48); /* flush */
+		}
 		writel(0, ioaddr + 0x148);
 		writel(0, ioaddr + 0x1C8);
 	}
