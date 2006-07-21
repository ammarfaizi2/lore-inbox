Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWGTP7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWGTP7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGTP7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:59:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19632 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030347AbWGTP7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:59:45 -0400
Date: Fri, 21 Jul 2006 02:58:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: forrest.zhao@intel.com, axboe@suse.de, linux-ide@vger.kernel.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: AHCI suspend/resume on thinkpad x60
Message-ID: <20060721005855.GB1889@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I applied patch from Forrest Zhao, and suspend/resume to disk/RAM now
works for me on thinkpad x60. I had to do some hand-tuning; this is
version against recent vanilla-git. Thanks for the patch! (I think
this is on its way to mainline, anyway, so this is just FYI).
								Pavel

This is the take 5 of AHCI suspend/resume patches.
The patch is against libata #upstream.

Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit f15f82c3a5709f4ffc81c884a000f86c5b103508
tree 6e92d57e3c3b36fcf1bf0d415203a5ed445f7cab
parent 6414eba4f65ded35f3a8f2d61261d1134e292506
author <pavel@amd.ucw.cz> Fri, 21 Jul 2006 02:29:01 +0200
committer <pavel@amd.ucw.cz> Fri, 21 Jul 2006 02:29:01 +0200

 drivers/scsi/ahci.c |  480 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 415 insertions(+), 65 deletions(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 77e7202..7c1b43d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -92,7 +92,9 @@ enum {
 	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
+	HOST_CAP_SSC		= (1 << 14), /* Slumber capable */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
+	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
 	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
 
@@ -155,6 +157,7 @@ enum {
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
 
+	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
@@ -205,6 +208,12 @@ static irqreturn_t ahci_interrupt (int i
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
+static int ahci_start_engine(void __iomem *port_mmio);
+static int ahci_stop_engine(void __iomem *port_mmio);
+static void ahci_start_fis_rx(void __iomem *port_mmio,
+			      struct ahci_port_priv *pp,
+			      struct ahci_host_priv *hpriv);
+static int ahci_stop_fis_rx(void __iomem *port_mmio);
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
@@ -212,6 +221,12 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+static int ahci_pci_device_resume(struct pci_dev *pdev);
+static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
+static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
+static int ahci_port_resume(struct ata_port *ap);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -231,6 +246,8 @@ static struct scsi_host_template ahci_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static const struct ata_port_operations ahci_ops = {
@@ -359,6 +376,8 @@ static struct pci_driver ahci_pci_driver
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.suspend		= ahci_pci_device_suspend,
+	.resume			= ahci_pci_device_resume,
 };
 
 
@@ -430,42 +449,30 @@ static int ahci_port_start(struct ata_po
 
 	ap->private_data = pp;
 
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
-	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
-	readl(port_mmio + PORT_LST_ADDR); /* flush */
-
-	if (hpriv->cap & HOST_CAP_64)
-		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
-	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
-	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+	/*
+	 * Driver is setup; initialize the HBA
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
 
-	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
-	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
-	       PORT_CMD_START, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
+	rc = ahci_port_spinup(port_mmio, hpriv->cap);
+	if (rc) 
+		ata_port_printk(ap, KERN_WARNING,
+				"Could not spinup port (%d)\n", rc);
+
+	rc = ahci_start_engine(port_mmio); 
+	if (rc) 
+		ata_port_printk(ap, KERN_WARNING, "Could not start DMA engine"
+			        "of port (%d)\n", rc);
 
 	return 0;
 }
 
-
 static void ahci_port_stop(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
 	struct ahci_port_priv *pp = ap->private_data;
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 tmp;
 
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
-
-	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
-	 * this is slightly incorrect.
-	 */
-	msleep(500);
+	ahci_port_suspend(ap, PMSG_SUSPEND);
 
 	ap->private_data = NULL;
 	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
@@ -474,6 +481,90 @@ static void ahci_port_stop(struct ata_po
 	kfree(pp);
 }
 
+static int ahci_port_suspend(struct ata_port *ap, pm_message_t state)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	int rc;
+
+	/*
+	 * Disable DMA
+	 */
+	rc = ahci_stop_engine(port_mmio);
+	if (rc) {
+		ata_port_printk(ap, KERN_WARNING, "DMA engine busy\n");
+		return rc;
+	}
+
+	/*
+	 * Disable FIS reception
+	 */
+	rc = ahci_stop_fis_rx(port_mmio);
+	if (rc)
+		ata_port_printk(ap, KERN_WARNING, "FIS RX still running"
+				" (%d)\n", rc);
+
+	/*
+	 * Put device into slumber mode
+	 */
+	if (!rc && state.event != PM_EVENT_FREEZE)
+		ahci_port_standby(port_mmio, hpriv->cap);
+
+	return rc;
+}
+
+static int ahci_port_resume(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	int rc;
+	u32 tmp;
+
+	/*
+	 * Enable FIS reception
+	 */
+	ahci_start_fis_rx(port_mmio, pp, hpriv);
+
+	rc = ahci_port_spinup(port_mmio, hpriv->cap);
+	if (rc)
+		ata_port_printk(ap, KERN_WARNING, "Could not spinup device"
+				" (%d)\n", rc);
+
+	/*
+	 * Clear error status
+	 */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+	/*
+	 * Clear interrupt status
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_IRQ_EN)) {
+		u32 irq_stat;
+
+		/* ack any pending irq events for this port */
+		irq_stat = readl(port_mmio + PORT_IRQ_STAT);
+		if (irq_stat)
+			writel(irq_stat, port_mmio + PORT_IRQ_STAT);
+
+		/* set irq mask (enables interrupts) */
+		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
+	}
+
+	/*
+	 * Enable DMA
+	 */
+	rc = ahci_start_engine(port_mmio);
+	if (rc)
+		ata_port_printk(ap, KERN_WARNING, "Can't start DMA engine"
+				" (%d)\n", rc);
+
+	return rc;
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -508,41 +599,228 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static int ahci_stop_engine(struct ata_port *ap)
+static int ahci_stop_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
-	int work;
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
+
+	/* Check if the HBA is idle */
+	if ((tmp & (PORT_CMD_START | PORT_CMD_LIST_ON)) == 0)
+		return 0;
+
+	/* Setting HBA to idle */
 	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
-	/* wait for engine to stop.  TODO: this could be
+	/* wait for engine to stop. This could be
 	 * as long as 500 msec
 	 */
-	work = 1000;
-	while (work-- > 0) {
-		tmp = readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) == 0)
-			return 0;
-		udelay(10);
-	}
+	tmp = ata_wait_register(port_mmio + PORT_CMD,
+			        PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1, 500);
+	if(tmp & PORT_CMD_LIST_ON)
+		return -EIO;
 
-	return -EIO;
+	return 0;
 }
 
-static void ahci_start_engine(struct ata_port *ap)
+static int ahci_start_engine(void __iomem *port_mmio)
 {
-	void __iomem *mmio = ap->host_set->mmio_base;
-	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
 
+	/*
+	 * Get current status
+	 */
 	tmp = readl(port_mmio + PORT_CMD);
+
+	/*
+	 * AHCI rev 1.1 section 10.3.1:
+	 * Software shall not set PxCMD.ST to '1' until it verifies
+	 * that PxCMD.CR is '0' and has set PxCMD.FRE to '1'
+	 */
+	if ((tmp & PORT_CMD_FIS_RX) == 0)
+		return -EPERM;
+
+	/*
+	 * wait for engine to become idle.
+	 */
+	tmp = ata_wait_register(port_mmio + PORT_CMD,
+				PORT_CMD_LIST_ON, PORT_CMD_LIST_ON, 1,500);
+	if(tmp & PORT_CMD_LIST_ON)
+		return -EBUSY;
+
+	/*
+	 * Start DMA
+	 */
 	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
+
+	return 0;
+}
+
+static int ahci_stop_fis_rx(void __iomem *port_mmio)
+{
+	u32 tmp;
+
+	/*
+	 * Get current status
+	 */
+	tmp = readl(port_mmio + PORT_CMD);
+
+	/* Check if FIS RX is already disabled */
+	if ((tmp & PORT_CMD_FIS_RX) == 0)
+		return 0;
+
+	/*
+	 * AHCI Rev 1.1 section 10.3.2
+	 * Software shall not clear PxCMD.FRE while
+	 * PxCMD.ST or PxCMD.CR is set to '1'
+	 */
+	if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_START)) {
+		return -EPERM;
+	}
+
+	/*
+	 * Disable FIS reception
+	 *
+	 * AHCI Rev 1.1 Section 10.1.2:
+	 * If PxCMD.FRE is set to '1', software should clear it
+	 * to '0' and wait at least 500 milliseconds for PxCMD.FR
+	 * to return '0' when read. If PxCMD.FR does not clear
+	 * '0' correctly, then software may attempt a port reset
+	 * of a full HBA reset to recover.
+	 */
+	tmp &= ~(PORT_CMD_FIS_RX);
+	writel(tmp, port_mmio + PORT_CMD);
+
+	tmp = ata_wait_register(port_mmio + PORT_CMD, PORT_CMD_FIS_ON,
+				PORT_CMD_FIS_ON, 1, 1000);
+	if(tmp & PORT_CMD_FIS_ON)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void ahci_start_fis_rx(void __iomem *port_mmio,
+                             struct ahci_port_priv *pp,
+                             struct ahci_host_priv *hpriv)
+{
+	u32 tmp;
+
+	/*
+	 * Set FIS registers
+	 */
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
+	readl(port_mmio + PORT_FIS_ADDR); /* flush */
+
+	/*
+	 * Enable FIS reception
+	 */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_FIS_RX;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
+static int ahci_port_standby(void __iomem *port_mmio, u32 cap)
+{
+	u32 tmp, scontrol, sstatus;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	/*
+	 * AHCI Rev1.1 Section 5.3.2.3:
+	 * Software is only allowed to program the PxCMD.FRE,
+	 * PxCMD.POD, PxSCTL.DET, and PxCMD.SUD register bits
+	 * when PxCMD.ST is set to '0'
+	 */
+	if (tmp & PORT_CMD_START)
+		return -EBUSY;
+
+	if (cap & HOST_CAP_SSC) {
+		/*
+		 * Enable transitions to slumber mode
+		 */
+		scontrol = readl(port_mmio + PORT_SCR_CTL);
+		if ((scontrol & 0x0f00) > 0x100) {
+			scontrol &= ~0xf00;
+			writel(scontrol, port_mmio + PORT_SCR_CTL);
+		}
+		/*
+		 * Put device into slumber mode
+		 */
+		tmp |= PORT_CMD_ICC_SLUMBER;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+
+		/*
+		 * Actually, we should wait for the device to
+		 * enter slumber mode by checking
+		 * sstatus & 0xf00 == 6
+		 */
+		sstatus = readl(port_mmio + PORT_SCR_STAT);
+	}
+
+	/*
+	 * Put device into listen mode
+	 */
+	if (cap & HOST_CAP_SSS) {
+		/* 
+		 * first set PxSCTL.DET to 0
+		 */
+		scontrol = readl(port_mmio + PORT_SCR_CTL);
+		scontrol &= ~0xf;
+		writel(scontrol, port_mmio + PORT_SCR_CTL);
+
+		/*
+		 * then set PxCMD.SUD to 0
+		 */
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp &= ~PORT_CMD_SPIN_UP;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+	}
+
+	return 0;
+}
+
+static int ahci_port_spinup(void __iomem *port_mmio, u32 cap)
+{
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	/*
+	 * AHCI Rev1.1 Section 5.3.2.3:
+	 * Software is only allowed to program the PxCMD.FRE,
+	 * PxCMD.POD, PxSCTL.DET, and PxCMD.SUD register bits
+	 * when PxCMD.ST is set to '0'
+	 */
+	if (tmp & PORT_CMD_START)
+		return -EBUSY;
+
+	/*
+	 * Spin up device
+	 */
+	if (cap & HOST_CAP_SSS) {
+		tmp |= PORT_CMD_SPIN_UP;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+	}
+
+	if ((tmp & PORT_CMD_ICC_MASK) != PORT_CMD_ICC_ACTIVE) {
+		tmp |= PORT_CMD_ICC_ACTIVE;
+		writel(tmp, port_mmio + PORT_CMD);
+		tmp = readl(port_mmio + PORT_CMD);
+	}
+
+	return 0;
 }
 
 static unsigned int ahci_dev_classify(struct ata_port *ap)
@@ -626,7 +904,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
-	rc = ahci_stop_engine(ap);
+	rc = ahci_stop_engine(port_mmio);
 	if (rc) {
 		reason = "failed to stop engine";
 		goto fail_restart;
@@ -647,7 +925,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* restart engine */
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	ata_tf_init(ap->device, &tf);
 	fis = pp->cmd_tbl;
@@ -706,7 +984,7 @@ static int ahci_softreset(struct ata_por
 	return 0;
 
  fail_restart:
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
  fail:
 	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
 	return rc;
@@ -717,11 +995,13 @@ static int ahci_hardreset(struct ata_por
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	ahci_stop_engine(port_mmio);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(ap->device, &tf);
@@ -730,7 +1010,7 @@ static int ahci_hardreset(struct ata_por
 
 	rc = sata_std_hardreset(ap, class);
 
-	ahci_start_engine(ap);
+	ahci_start_engine(port_mmio);
 
 	if (rc == 0 && ata_port_online(ap))
 		*class = ahci_dev_classify(ap);
@@ -802,6 +1082,75 @@ static unsigned int ahci_fill_sg(struct 
 	return n_sg;
 }
 
+int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	void __iomem *mmio = host_set->mmio_base;
+	u32 tmp;
+	int i;
+
+	/* First suspend all ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host_set->ports[i];
+		ahci_port_suspend(ap, state);
+	}
+
+	/*
+	 * AHCI spec rev1.1 section 8.3.3:
+	 * Software must disable interrupts prior to
+	 * requesting a transition of the HBA to
+	 * D3 state.
+	 */
+	tmp = readl(mmio + HOST_CTL);
+	tmp &= ~HOST_IRQ_EN;
+	writel(tmp, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL); /* flush */
+
+	ata_pci_device_do_suspend(pdev, state);
+
+	return 0;
+}
+
+int ahci_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	void __iomem *mmio = host_set->mmio_base;
+	struct ata_port *ap;
+	u32 i, tmp, irq_stat;
+
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_AHCI_EN)) {
+		tmp |= HOST_AHCI_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	ata_pci_device_do_resume(pdev);
+
+	/* Resume all ports */
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+		ahci_port_resume(ap);
+	}
+
+	/*
+	 * Clear interrupt status and enable interrupt
+	 */
+	if (!(tmp & HOST_IRQ_EN)) {
+		irq_stat = readl(mmio + HOST_IRQ_STAT);
+		if (irq_stat)
+			writel(irq_stat, mmio + HOST_IRQ_STAT);
+		tmp |= HOST_IRQ_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);
+	}
+
+	return 0;
+}
+
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -1052,10 +1401,13 @@ static void ahci_thaw(struct ata_port *a
 
 static void ahci_error_handler(struct ata_port *ap)
 {
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
+		ahci_stop_engine(port_mmio);
+		ahci_start_engine(port_mmio);
 	}
 
 	/* perform recovery */
@@ -1066,14 +1418,16 @@ static void ahci_error_handler(struct at
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 
 	if (qc->flags & ATA_QCFLAG_FAILED)
 		qc->err_mask |= AC_ERR_OTHER;
 
 	if (qc->err_mask) {
 		/* make DMA engine forget about the failed command */
-		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
+		ahci_stop_engine(port_mmio);
+		ahci_start_engine(port_mmio);
 	}
 }
 
@@ -1184,20 +1538,16 @@ static int ahci_host_init(struct ata_pro
 				(unsigned long) mmio, i);
 
 		/* make sure port is not active */
-		tmp = readl(port_mmio + PORT_CMD);
-		VPRINTK("PORT_CMD 0x%x\n", tmp);
-		if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
-			   PORT_CMD_FIS_RX | PORT_CMD_START)) {
-			tmp &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
-				 PORT_CMD_FIS_RX | PORT_CMD_START);
-			writel(tmp, port_mmio + PORT_CMD);
-			readl(port_mmio + PORT_CMD); /* flush */
-
-			/* spec says 500 msecs for each bit, so
-			 * this is slightly incorrect.
-			 */
-			msleep(500);
-		}
+
+		rc = ahci_stop_engine(port_mmio);
+		if (rc)
+			printk(KERN_WARNING "ata%u: DMA engine busy (%d)\n",
+			       i, rc);
+
+		rc = ahci_stop_fis_rx(port_mmio);
+		if (rc)
+			printk(KERN_WARNING "ata%u: FIS RX not stopped (%d)\n",
+			       i, rc);
 
 		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
