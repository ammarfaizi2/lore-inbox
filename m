Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWBRWIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWBRWIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWBRWIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:08:06 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:2945 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932210AbWBRWIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:08:05 -0500
Message-ID: <43F79AC1.4020909@drzeus.cx>
Date: Sat, 18 Feb 2006 23:08:01 +0100
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-25993-1140300484-0001-2"
To: Sergey Vlasov <vsu@altlinux.ru>, Andrew Morton <akpm@osdl.org>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2/2] [MMC] Secure Digital Host Controller Interface driver
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>	<20060211001525.10315.30769.stgit@poseidon.drzeus.cx> <20060212201407.70761172.vsu@altlinux.ru>
In-Reply-To: <20060212201407.70761172.vsu@altlinux.ru>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-25993-1140300484-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Patch with your suggested improvements.

Rgds
Pierre


--=_hermes.drzeus.cx-25993-1140300484-0001-2
Content-Type: text/x-patch; name="sdhci-fix.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdhci-fix.patch"



From: Pierre Ossman <drzeus@drzeus.cx>


---

 drivers/mmc/sdhci.c |   53 ++++++++++++++++++++++++++++++++++++---------------
 drivers/mmc/sdhci.h |   12 +++++++++---
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 4e12fe0..667928d 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -204,6 +204,9 @@ static void sdhci_transfer_pio(struct sd
 				"Please report this to "
 				BUGMAIL ".\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
+
+			sdhci_kunmap_sg(host);
+
 			host->data->error = MMC_ERR_FAILED;
 			sdhci_finish_data(host);
 			return;
@@ -578,8 +581,12 @@ static void sdhci_set_ios(struct mmc_hos
 	 * Reset the chip on each power off.
 	 * Should clear out any weird states.
 	 */
-	if (ios->power_mode == MMC_POWER_OFF)
+	if (ios->power_mode == MMC_POWER_OFF) {
+		writel(0, host->ioaddr + SDHCI_SIGNAL_ENABLE);
+		spin_unlock_irqrestore(&host->lock, flags);
 		sdhci_init(host);
+		spin_lock_irqsave(&host->lock, flags);
+	}
 
 	sdhci_set_clock(host, ios->clock);
 
@@ -970,6 +977,21 @@ static int __devinit sdhci_probe_slot(st
 
 	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
 
+	if (first_bar > 5) {
+		printk(KERN_ERR DRIVER_NAME ": Invalid first BAR. Aborting.\n");
+		return -ENODEV;
+	}
+
+	if (!(pci_resource_flags(pdev, first_bar + slot) & IORESOURCE_MEM)) {
+		printk(KERN_ERR DRIVER_NAME ": BAR is not iomem. Aborting.\n");
+		return -ENODEV;
+	}
+
+	if (pci_resource_len(pdev, first_bar + slot) != 0x100) {
+		printk(KERN_ERR DRIVER_NAME ": Invalid iomem size. Aborting.\n");
+		return -ENODEV;
+	}
+
 	mmc = mmc_alloc_host(sizeof(struct sdhci_host), &pdev->dev);
 	if (!mmc)
 		return -ENOMEM;
@@ -984,8 +1006,6 @@ static int __devinit sdhci_probe_slot(st
 
 	DBG("slot %d at 0x%08lx, irq %d\n", slot, host->addr, host->irq);
 
-	BUG_ON(!(pci_resource_flags(pdev, first_bar + slot) & IORESOURCE_MEM));
-
 	snprintf(host->slot_descr, 20, "sdhci:slot%d", slot);
 
 	ret = pci_request_region(pdev, host->bar, host->slot_descr);
@@ -999,11 +1019,6 @@ static int __devinit sdhci_probe_slot(st
 		goto release;
 	}
 
-	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
-		host->slot_descr, host);
-	if (ret)
-		goto unmap;
-
 	caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
 
 	if ((caps & SDHCI_CAN_DO_DMA) && ((pdev->class & 0x0000FF) == 0x01))
@@ -1065,9 +1080,12 @@ static int __devinit sdhci_probe_slot(st
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
-	init_timer(&host->timer);
-	host->timer.data = (unsigned long)host;
-	host->timer.function = sdhci_timeout_timer;
+	setup_timer(&host->timer, sdhci_timeout_timer, (int)host);
+
+	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
+		host->slot_descr, host);
+	if (ret)
+		goto unmap;
 
 	sdhci_init(host);
 
@@ -1087,6 +1105,9 @@ static int __devinit sdhci_probe_slot(st
 	return 0;
 
 unmap:
+	tasklet_kill(&host->card_tasklet);
+	tasklet_kill(&host->finish_tasklet);
+
 	iounmap(host->ioaddr);
 release:
 	pci_release_region(pdev, host->bar);
@@ -1110,10 +1131,12 @@ static void sdhci_remove_slot(struct pci
 
 	mmc_remove_host(mmc);
 
-	del_timer_sync(&host->timer);
-
 	sdhci_reset(host, SDHCI_RESET_ALL);
 
+	free_irq(host->irq, host);
+
+	del_timer_sync(&host->timer);
+
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
@@ -1121,8 +1144,6 @@ static void sdhci_remove_slot(struct pci
 
 	pci_release_region(pdev, host->bar);
 
-	free_irq(host->irq, host);
-
 	mmc_free_host(mmc);
 }
 
@@ -1152,7 +1173,7 @@ static int __devinit sdhci_probe(struct 
 		return ret;
 
 	chip = kzalloc(sizeof(struct sdhci_chip) +
-		sizeof(sdhci_host_p) * slots, GFP_KERNEL);
+		sizeof(struct sdhci_host*) * slots, GFP_KERNEL);
 	if (!chip) {
 		ret = -ENOMEM;
 		goto err;
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index 286d4d1..3b270ef 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -9,6 +9,14 @@
  */
 
 /*
+ * PCI registers
+ */
+
+#define PCI_SLOT_INFO			0x40	/* 8 bits */
+#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
+#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
+
+/*
  * Controller registers
  */
 
@@ -169,11 +177,9 @@ struct sdhci_host {
 	struct timer_list	timer;		/* Timer for timeouts */
 };
 
-typedef struct sdhci_host *sdhci_host_p;
-
 struct sdhci_chip {
 	struct pci_dev		*pdev;
 
 	int			num_slots;	/* Slots on controller */
-	sdhci_host_p		hosts[0];	/* Pointers to hosts */
+	struct sdhci_host	*hosts[0];	/* Pointers to hosts */
 };

--=_hermes.drzeus.cx-25993-1140300484-0001-2--
