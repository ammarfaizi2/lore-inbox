Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVKQQ0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVKQQ0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVKQQ0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:26:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:39648 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932394AbVKQQ0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:26:05 -0500
Date: Thu, 17 Nov 2005 11:26:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fixes
Message-ID: <20051117162604.GA1131@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes:
* Didn't realize how broken sata_mv was.  Ouch.  Fixed now.
* Fix ugly EIDE timing bug.
* Fix longstanding could-wait-forever bug.
* Fix AHCI ATAPI error printk spew.

Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/Kconfig        |    2 
 drivers/scsi/ahci.c         |   30 -
 drivers/scsi/ata_piix.c     |    2 
 drivers/scsi/libata-core.c  |   38 +
 drivers/scsi/libata.h       |    2 
 drivers/scsi/sata_mv.c      |  991 ++++++++++++++++++++++++++++++++++++--------
 drivers/scsi/sata_promise.c |    2 
 drivers/scsi/sata_qstor.c   |    2 
 drivers/scsi/sata_sil24.c   |   21 
 drivers/scsi/sata_svw.c     |    2 
 drivers/scsi/sata_sx4.c     |    2 
 drivers/scsi/sata_vsc.c     |    2 
 12 files changed, 898 insertions(+), 198 deletions(-)

Albert Lee:
      libata: honor the transfer cycle time speficied by the EIDE device

Jeff Garzik:
      [libata sata_mv] minor fixes
      [libata sata_mv] trim trailing whitespace
      [libata sata_mv] note driver is "HIGHLY EXPERIMENTAL" in Kconfig
      [libata sata_mv] implement a bunch of errata workarounds
      [libata sata_mv] move code around
      [libata sata_mv] mv_hw_ops for hardware families; new errata
      [libata sata_mv] hardware initialization work
      [libata sata_mv] move code around
      [libata sata_mv] call phy fixups during init, as well as phy reset
      [libata sata_mv] fix tons of 50XX bugs
      [libata ahci] tone down ATAPI errors
      [libata] bump versions
      [libata] add timeout to commands for which we call wait_completion()
      [libata sata_mv] SATA probe, DMA boundary fixes
      [libata sata_mv] handle lack of hardware nIEN support

Tejun Heo:
      sil24: add constants

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 84c42c4..20dd85a 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -497,7 +497,7 @@ config SCSI_ATA_PIIX
 	  If unsure, say N.
 
 config SCSI_SATA_MV
-	tristate "Marvell SATA support"
+	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 894e711..83467a0 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -48,7 +48,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"1.01"
+#define DRV_VERSION	"1.2"
 
 
 enum {
@@ -558,23 +558,25 @@ static void ahci_qc_prep(struct ata_queu
 	pp->cmd_slot[0].opts |= cpu_to_le32(n_elem << 16);
 }
 
-static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
+static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
 {
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
 	int work;
 
-	printk(KERN_WARNING "ata%u: port reset, "
-	       "p_is %x is %x pis %x cmd %x tf %x ss %x se %x\n",
-		ap->id,
-		irq_stat,
-		readl(mmio + HOST_IRQ_STAT),
-		readl(port_mmio + PORT_IRQ_STAT),
-		readl(port_mmio + PORT_CMD),
-		readl(port_mmio + PORT_TFDATA),
-		readl(port_mmio + PORT_SCR_STAT),
-		readl(port_mmio + PORT_SCR_ERR));
+	if ((ap->device[0].class != ATA_DEV_ATAPI) ||
+	    ((irq_stat & PORT_IRQ_TF_ERR) == 0))
+		printk(KERN_WARNING "ata%u: port reset, "
+		       "p_is %x is %x pis %x cmd %x tf %x ss %x se %x\n",
+			ap->id,
+			irq_stat,
+			readl(mmio + HOST_IRQ_STAT),
+			readl(port_mmio + PORT_IRQ_STAT),
+			readl(port_mmio + PORT_CMD),
+			readl(port_mmio + PORT_TFDATA),
+			readl(port_mmio + PORT_SCR_STAT),
+			readl(port_mmio + PORT_SCR_ERR));
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -632,7 +634,7 @@ static void ahci_eng_timeout(struct ata_
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 	} else {
-		ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+		ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
 
 		/* hack alert!  We cannot use the supplied completion
 	 	 * function from inside the ->eh_strategy_handler() thread.
@@ -677,7 +679,7 @@ static inline int ahci_host_intr(struct 
 			err_mask = AC_ERR_HOST_BUS;
 
 		/* command processing has stopped due to error; restart */
-		ahci_intr_error(ap, status);
+		ahci_restart_port(ap, status);
 
 		if (qc)
 			ata_qc_complete(qc, err_mask);
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 855428f..333d69d 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -50,7 +50,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"1.04"
+#define DRV_VERSION	"1.05"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ba1eb8b..665ae79 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1046,6 +1046,30 @@ static unsigned int ata_pio_modes(const 
 	return modes;
 }
 
+static int ata_qc_wait_err(struct ata_queued_cmd *qc,
+			   struct completion *wait)
+{
+	int rc = 0;
+
+	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
+		/* timeout handling */
+		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
+
+		if (!err_mask) {
+			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
+			       qc->ap->id, qc->tf.command);
+		} else {
+			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
+			       qc->ap->id, qc->tf.command);
+			rc = -EIO;
+		}
+
+		ata_qc_complete(qc, err_mask);
+	}
+
+	return rc;
+}
+
 /**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
@@ -1125,7 +1149,7 @@ retry:
 	if (rc)
 		goto err_out;
 	else
-		wait_for_completion(&wait);
+		ata_qc_wait_err(qc, &wait);
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	ap->ops->tf_read(ap, &qc->tf);
@@ -1570,11 +1594,13 @@ int ata_timing_compute(struct ata_device
 
 	/*
 	 * Find the mode. 
-	*/
+	 */
 
 	if (!(s = ata_timing_find_mode(speed)))
 		return -EINVAL;
 
+	memcpy(t, s, sizeof(*s));
+
 	/*
 	 * If the drive is an EIDE drive, it can tell us it needs extended
 	 * PIO/MW_DMA cycle timing.
@@ -1595,7 +1621,7 @@ int ata_timing_compute(struct ata_device
 	 * Convert the timing to bus clock counts.
 	 */
 
-	ata_timing_quantize(s, t, T, UT);
+	ata_timing_quantize(t, t, T, UT);
 
 	/*
 	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
@@ -2267,7 +2293,7 @@ static void ata_dev_set_xfermode(struct 
 	if (rc)
 		ata_port_disable(ap);
 	else
-		wait_for_completion(&wait);
+		ata_qc_wait_err(qc, &wait);
 
 	DPRINTK("EXIT\n");
 }
@@ -2315,7 +2341,7 @@ static void ata_dev_reread_id(struct ata
 	if (rc)
 		goto err_out;
 
-	wait_for_completion(&wait);
+	ata_qc_wait_err(qc, &wait);
 
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
@@ -2371,7 +2397,7 @@ static void ata_dev_init_params(struct a
 	if (rc)
 		ata_port_disable(ap);
 	else
-		wait_for_completion(&wait);
+		ata_qc_wait_err(qc, &wait);
 
 	DPRINTK("EXIT\n");
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 74a84e0..8ebaa69 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -29,7 +29,7 @@
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"1.12"	/* must be exactly four chars */
+#define DRV_VERSION	"1.20"	/* must be exactly four chars */
 
 struct ata_scsi_args {
 	u16			*id;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 257c128..ac184e6 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1,7 +1,7 @@
 /*
  * sata_mv.c - Marvell SATA support
  *
- * Copyright 2005: EMC Corporation, all rights reserved. 
+ * Copyright 2005: EMC Corporation, all rights reserved.
  *
  * Please ALWAYS copy linux-ide@vger.kernel.org on emails.
  *
@@ -50,6 +50,9 @@ enum {
 	MV_PCI_REG_BASE		= 0,
 	MV_IRQ_COAL_REG_BASE	= 0x18000,	/* 6xxx part only */
 	MV_SATAHC0_REG_BASE	= 0x20000,
+	MV_FLASH_CTL		= 0x1046c,
+	MV_GPIO_PORT_CTL	= 0x104f0,
+	MV_RESET_CFG		= 0x180d8,
 
 	MV_PCI_REG_SZ		= MV_MAJOR_REG_AREA_SZ,
 	MV_SATAHC_REG_SZ	= MV_MAJOR_REG_AREA_SZ,
@@ -72,11 +75,6 @@ enum {
 	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
 	MV_PORT_PRIV_DMA_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ + MV_SG_TBL_SZ),
 
-	/* Our DMA boundary is determined by an ePRD being unable to handle
-	 * anything larger than 64KB
-	 */
-	MV_DMA_BOUNDARY		= 0xffffU,
-
 	MV_PORTS_PER_HC		= 4,
 	/* == (port / MV_PORTS_PER_HC) to determine HC from 0-7 port */
 	MV_PORT_HC_SHIFT	= 2,
@@ -86,16 +84,9 @@ enum {
 	/* Host Flags */
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
-	MV_FLAG_GLBL_SFT_RST	= (1 << 28),  /* Global Soft Reset support */
 	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO),
-	MV_6XXX_FLAGS		= (MV_FLAG_IRQ_COALESCE | 
-				   MV_FLAG_GLBL_SFT_RST),
-
-	chip_504x		= 0,
-	chip_508x		= 1,
-	chip_604x		= 2,
-	chip_608x		= 3,
+	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
 	CRQB_FLAG_READ		= (1 << 0),
 	CRQB_TAG_SHIFT		= 1,
@@ -116,8 +107,19 @@ enum {
 	PCI_MASTER_EMPTY	= (1 << 3),
 	GLOB_SFT_RST		= (1 << 4),
 
-	PCI_IRQ_CAUSE_OFS	= 0x1d58,
-	PCI_IRQ_MASK_OFS	= 0x1d5c,
+	MV_PCI_MODE		= 0xd00,
+	MV_PCI_EXP_ROM_BAR_CTL	= 0xd2c,
+	MV_PCI_DISC_TIMER	= 0xd04,
+	MV_PCI_MSI_TRIGGER	= 0xc38,
+	MV_PCI_SERR_MASK	= 0xc28,
+	MV_PCI_XBAR_TMOUT	= 0x1d04,
+	MV_PCI_ERR_LOW_ADDRESS	= 0x1d40,
+	MV_PCI_ERR_HIGH_ADDRESS	= 0x1d44,
+	MV_PCI_ERR_ATTRIBUTE	= 0x1d48,
+	MV_PCI_ERR_COMMAND	= 0x1d50,
+
+	PCI_IRQ_CAUSE_OFS		= 0x1d58,
+	PCI_IRQ_MASK_OFS		= 0x1d5c,
 	PCI_UNMASK_ALL_IRQS	= 0x7fffff,	/* bits 22-0 */
 
 	HC_MAIN_IRQ_CAUSE_OFS	= 0x1d60,
@@ -134,7 +136,7 @@ enum {
 	SELF_INT		= (1 << 23),
 	TWSI_INT		= (1 << 24),
 	HC_MAIN_RSVD		= (0x7f << 25),	/* bits 31-25 */
-	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE | 
+	HC_MAIN_MASKED_IRQS	= (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
 
@@ -153,6 +155,15 @@ enum {
 	/* SATA registers */
 	SATA_STATUS_OFS		= 0x300,  /* ctrl, err regs follow status */
 	SATA_ACTIVE_OFS		= 0x350,
+	PHY_MODE3		= 0x310,
+	PHY_MODE4		= 0x314,
+	PHY_MODE2		= 0x330,
+	MV5_PHY_MODE		= 0x74,
+	MV5_LT_MODE		= 0x30,
+	MV5_PHY_CTL		= 0x0C,
+	SATA_INTERFACE_CTL	= 0x050,
+
+	MV_M2_PREAMP_MASK	= 0x7e0,
 
 	/* Port registers */
 	EDMA_CFG_OFS		= 0,
@@ -182,17 +193,16 @@ enum {
 	EDMA_ERR_LNK_CTRL_TX	= (0x1f << 21),
 	EDMA_ERR_LNK_DATA_TX	= (0x1f << 26),
 	EDMA_ERR_TRANS_PROTO	= (1 << 31),
-	EDMA_ERR_FATAL		= (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR | 
+	EDMA_ERR_FATAL		= (EDMA_ERR_D_PAR | EDMA_ERR_PRD_PAR |
 				   EDMA_ERR_DEV_DCON | EDMA_ERR_CRBQ_PAR |
 				   EDMA_ERR_CRPB_PAR | EDMA_ERR_INTRL_PAR |
-				   EDMA_ERR_IORDY | EDMA_ERR_LNK_CTRL_RX_2 | 
+				   EDMA_ERR_IORDY | EDMA_ERR_LNK_CTRL_RX_2 |
 				   EDMA_ERR_LNK_DATA_RX |
-				   EDMA_ERR_LNK_DATA_TX | 
+				   EDMA_ERR_LNK_DATA_TX |
 				   EDMA_ERR_TRANS_PROTO),
 
 	EDMA_REQ_Q_BASE_HI_OFS	= 0x10,
 	EDMA_REQ_Q_IN_PTR_OFS	= 0x14,		/* also contains BASE_LO */
-	EDMA_REQ_Q_BASE_LO_MASK	= 0xfffffc00U,
 
 	EDMA_REQ_Q_OUT_PTR_OFS	= 0x18,
 	EDMA_REQ_Q_PTR_SHIFT	= 5,
@@ -200,7 +210,6 @@ enum {
 	EDMA_RSP_Q_BASE_HI_OFS	= 0x1c,
 	EDMA_RSP_Q_IN_PTR_OFS	= 0x20,
 	EDMA_RSP_Q_OUT_PTR_OFS	= 0x24,		/* also contains BASE_LO */
-	EDMA_RSP_Q_BASE_LO_MASK	= 0xffffff00U,
 	EDMA_RSP_Q_PTR_SHIFT	= 3,
 
 	EDMA_CMD_OFS		= 0x28,
@@ -208,14 +217,44 @@ enum {
 	EDMA_DS			= (1 << 1),
 	ATA_RST			= (1 << 2),
 
+	EDMA_IORDY_TMOUT	= 0x34,
+	EDMA_ARB_CFG		= 0x38,
+
 	/* Host private flags (hp_flags) */
 	MV_HP_FLAG_MSI		= (1 << 0),
+	MV_HP_ERRATA_50XXB0	= (1 << 1),
+	MV_HP_ERRATA_50XXB2	= (1 << 2),
+	MV_HP_ERRATA_60X1B2	= (1 << 3),
+	MV_HP_ERRATA_60X1C0	= (1 << 4),
+	MV_HP_50XX		= (1 << 5),
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),
 	MV_PP_FLAG_EDMA_DS_ACT	= (1 << 1),
 };
 
+#define IS_50XX(hpriv) ((hpriv)->hp_flags & MV_HP_50XX)
+#define IS_60XX(hpriv) (((hpriv)->hp_flags & MV_HP_50XX) == 0)
+
+enum {
+	/* Our DMA boundary is determined by an ePRD being unable to handle
+	 * anything larger than 64KB
+	 */
+	MV_DMA_BOUNDARY		= 0xffffU,
+
+	EDMA_REQ_Q_BASE_LO_MASK	= 0xfffffc00U,
+
+	EDMA_RSP_Q_BASE_LO_MASK	= 0xffffff00U,
+};
+
+enum chip_type {
+	chip_504x,
+	chip_508x,
+	chip_5080,
+	chip_604x,
+	chip_608x,
+};
+
 /* Command ReQuest Block: 32B */
 struct mv_crqb {
 	u32			sg_addr;
@@ -252,14 +291,37 @@ struct mv_port_priv {
 	u32			pp_flags;
 };
 
+struct mv_port_signal {
+	u32			amps;
+	u32			pre;
+};
+
+struct mv_host_priv;
+struct mv_hw_ops {
+	void (*phy_errata)(struct mv_host_priv *hpriv, void __iomem *mmio,
+			   unsigned int port);
+	void (*enable_leds)(struct mv_host_priv *hpriv, void __iomem *mmio);
+	void (*read_preamp)(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio);
+	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,
+			unsigned int n_hc);
+	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);
+	void (*reset_bus)(struct pci_dev *pdev, void __iomem *mmio);
+};
+
 struct mv_host_priv {
 	u32			hp_flags;
+	struct mv_port_signal	signal[8];
+	const struct mv_hw_ops	*ops;
 };
 
 static void mv_irq_clear(struct ata_port *ap);
 static u32 mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in);
 static void mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
+static u32 mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in);
+static void mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
 static void mv_phy_reset(struct ata_port *ap);
+static void __mv_phy_reset(struct ata_port *ap, int can_sleep);
 static void mv_host_stop(struct ata_host_set *host_set);
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
@@ -270,6 +332,29 @@ static irqreturn_t mv_interrupt(int irq,
 static void mv_eng_timeout(struct ata_port *ap);
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
+static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
+			   unsigned int port);
+static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio);
+static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio);
+static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+			unsigned int n_hc);
+static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
+static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio);
+
+static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
+			   unsigned int port);
+static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio);
+static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio);
+static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+			unsigned int n_hc);
+static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
+static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio);
+static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
+			     unsigned int port_no);
+static void mv_stop_and_reset(struct ata_port *ap);
+
 static struct scsi_host_template mv_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -278,7 +363,7 @@ static struct scsi_host_template mv_sht 
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= MV_USE_Q_DEPTH,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= MV_MAX_SG_CT,
+	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.max_sectors		= ATA_MAX_SECTORS,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
@@ -290,7 +375,34 @@ static struct scsi_host_template mv_sht 
 	.ordered_flush		= 1,
 };
 
-static const struct ata_port_operations mv_ops = {
+static const struct ata_port_operations mv5_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= mv_phy_reset,
+
+	.qc_prep		= mv_qc_prep,
+	.qc_issue		= mv_qc_issue,
+
+	.eng_timeout		= mv_eng_timeout,
+
+	.irq_handler		= mv_interrupt,
+	.irq_clear		= mv_irq_clear,
+
+	.scr_read		= mv5_scr_read,
+	.scr_write		= mv5_scr_write,
+
+	.port_start		= mv_port_start,
+	.port_stop		= mv_port_stop,
+	.host_stop		= mv_host_stop,
+};
+
+static const struct ata_port_operations mv6_ops = {
 	.port_disable		= ata_port_disable,
 
 	.tf_load		= ata_tf_load,
@@ -322,37 +434,44 @@ static struct ata_port_info mv_port_info
 		.sht		= &mv_sht,
 		.host_flags	= MV_COMMON_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0,	/* 0x7f (udma0-6 disabled for now) */
-		.port_ops	= &mv_ops,
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_508x */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio0-4 */
-		.udma_mask	= 0,	/* 0x7f (udma0-6 disabled for now) */
-		.port_ops	= &mv_ops,
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &mv5_ops,
+	},
+	{  /* chip_5080 */
+		.sht		= &mv_sht,
+		.host_flags	= (MV_COMMON_FLAGS | MV_FLAG_DUAL_HC),
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &mv5_ops,
 	},
 	{  /* chip_604x */
 		.sht		= &mv_sht,
 		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &mv_ops,
+		.port_ops	= &mv6_ops,
 	},
 	{  /* chip_608x */
 		.sht		= &mv_sht,
-		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS | 
+		.host_flags	= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
 				   MV_FLAG_DUAL_HC),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
-		.port_ops	= &mv_ops,
+		.port_ops	= &mv6_ops,
 	},
 };
 
 static const struct pci_device_id mv_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_508x},
+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_5080},
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5081), 0, 0, chip_508x},
 
 	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
@@ -371,6 +490,24 @@ static struct pci_driver mv_pci_driver =
 	.remove			= ata_pci_remove_one,
 };
 
+static const struct mv_hw_ops mv5xxx_ops = {
+	.phy_errata		= mv5_phy_errata,
+	.enable_leds		= mv5_enable_leds,
+	.read_preamp		= mv5_read_preamp,
+	.reset_hc		= mv5_reset_hc,
+	.reset_flash		= mv5_reset_flash,
+	.reset_bus		= mv5_reset_bus,
+};
+
+static const struct mv_hw_ops mv6xxx_ops = {
+	.phy_errata		= mv6_phy_errata,
+	.enable_leds		= mv6_enable_leds,
+	.read_preamp		= mv6_read_preamp,
+	.reset_hc		= mv6_reset_hc,
+	.reset_flash		= mv6_reset_flash,
+	.reset_bus		= mv_reset_pci_bus,
+};
+
 /*
  * Functions
  */
@@ -386,11 +523,27 @@ static inline void __iomem *mv_hc_base(v
 	return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
 }
 
+static inline unsigned int mv_hc_from_port(unsigned int port)
+{
+	return port >> MV_PORT_HC_SHIFT;
+}
+
+static inline unsigned int mv_hardport_from_port(unsigned int port)
+{
+	return port & MV_PORT_MASK;
+}
+
+static inline void __iomem *mv_hc_base_from_port(void __iomem *base,
+						 unsigned int port)
+{
+	return mv_hc_base(base, mv_hc_from_port(port));
+}
+
 static inline void __iomem *mv_port_base(void __iomem *base, unsigned int port)
 {
-	return (mv_hc_base(base, port >> MV_PORT_HC_SHIFT) +
-		MV_SATAHC_ARBTR_REG_SZ + 
-		((port & MV_PORT_MASK) * MV_PORT_REG_SZ));
+	return  mv_hc_base_from_port(base, port) +
+		MV_SATAHC_ARBTR_REG_SZ +
+		(mv_hardport_from_port(port) * MV_PORT_REG_SZ);
 }
 
 static inline void __iomem *mv_ap_base(struct ata_port *ap)
@@ -398,9 +551,9 @@ static inline void __iomem *mv_ap_base(s
 	return mv_port_base(ap->host_set->mmio_base, ap->port_no);
 }
 
-static inline int mv_get_hc_count(unsigned long hp_flags)
+static inline int mv_get_hc_count(unsigned long host_flags)
 {
-	return ((hp_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
+	return ((host_flags & MV_FLAG_DUAL_HC) ? 2 : 1);
 }
 
 static void mv_irq_clear(struct ata_port *ap)
@@ -452,7 +605,7 @@ static void mv_stop_dma(struct ata_port 
 	} else {
 		assert(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
   	}
-	
+
 	/* now properly wait for the eDMA to stop */
 	for (i = 1000; i > 0; i--) {
 		reg = readl(port_mmio + EDMA_CMD_OFS);
@@ -503,7 +656,7 @@ static void mv_dump_all_regs(void __iome
 			     struct pci_dev *pdev)
 {
 #ifdef ATA_DEBUG
-	void __iomem *hc_base = mv_hc_base(mmio_base, 
+	void __iomem *hc_base = mv_hc_base(mmio_base,
 					   port >> MV_PORT_HC_SHIFT);
 	void __iomem *port_base;
 	int start_port, num_ports, p, start_hc, num_hcs, hc;
@@ -517,7 +670,7 @@ static void mv_dump_all_regs(void __iome
 		start_port = port;
 		num_ports = num_hcs = 1;
 	}
-	DPRINTK("All registers for port(s) %u-%u:\n", start_port, 
+	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
 		num_ports > 1 ? num_ports - 1 : start_port);
 
 	if (NULL != pdev) {
@@ -585,70 +738,6 @@ static void mv_scr_write(struct ata_port
 }
 
 /**
- *      mv_global_soft_reset - Perform the 6xxx global soft reset
- *      @mmio_base: base address of the HBA
- *
- *      This routine only applies to 6xxx parts.
- *
- *      LOCKING:
- *      Inherited from caller.
- */
-static int mv_global_soft_reset(void __iomem *mmio_base)
-{
-	void __iomem *reg = mmio_base + PCI_MAIN_CMD_STS_OFS;
-	int i, rc = 0;
-	u32 t;
-
-	/* Following procedure defined in PCI "main command and status
-	 * register" table.
-	 */
-	t = readl(reg);
-	writel(t | STOP_PCI_MASTER, reg);
-
-	for (i = 0; i < 1000; i++) {
-		udelay(1);
-		t = readl(reg);
-		if (PCI_MASTER_EMPTY & t) {
-			break;
-		}
-	}
-	if (!(PCI_MASTER_EMPTY & t)) {
-		printk(KERN_ERR DRV_NAME ": PCI master won't flush\n");
-		rc = 1;
-		goto done;
-	}
-
-	/* set reset */
-	i = 5;
-	do {
-		writel(t | GLOB_SFT_RST, reg);
-		t = readl(reg);
-		udelay(1);
-	} while (!(GLOB_SFT_RST & t) && (i-- > 0));
-
-	if (!(GLOB_SFT_RST & t)) {
-		printk(KERN_ERR DRV_NAME ": can't set global reset\n");
-		rc = 1;
-		goto done;
-	}
-
-	/* clear reset and *reenable the PCI master* (not mentioned in spec) */
-	i = 5;
-	do {
-		writel(t & ~(GLOB_SFT_RST | STOP_PCI_MASTER), reg);
-		t = readl(reg);
-		udelay(1);
-	} while ((GLOB_SFT_RST & t) && (i-- > 0));
-
-	if (GLOB_SFT_RST & t) {
-		printk(KERN_ERR DRV_NAME ": can't clear global reset\n");
-		rc = 1;
-	}
-done:
-	return rc;
-}
-
-/**
  *      mv_host_stop - Host specific cleanup/stop routine.
  *      @host_set: host data structure
  *
@@ -701,7 +790,7 @@ static int mv_port_start(struct ata_port
 		goto err_out;
 	memset(pp, 0, sizeof(*pp));
 
-	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma, 
+	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
 				 GFP_KERNEL);
 	if (!mem)
 		goto err_out_pp;
@@ -711,7 +800,7 @@ static int mv_port_start(struct ata_port
 	if (rc)
 		goto err_out_priv;
 
-	/* First item in chunk of DMA memory: 
+	/* First item in chunk of DMA memory:
 	 * 32-slot command request table (CRQB), 32 bytes each in size
 	 */
 	pp->crqb = mem;
@@ -719,7 +808,7 @@ static int mv_port_start(struct ata_port
 	mem += MV_CRQB_Q_SZ;
 	mem_dma += MV_CRQB_Q_SZ;
 
-	/* Second item: 
+	/* Second item:
 	 * 32-slot command response table (CRPB), 8 bytes each in size
 	 */
 	pp->crpb = mem;
@@ -733,18 +822,18 @@ static int mv_port_start(struct ata_port
 	pp->sg_tbl = mem;
 	pp->sg_tbl_dma = mem_dma;
 
-	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT | 
+	writelfl(EDMA_CFG_Q_DEPTH | EDMA_CFG_RD_BRST_EXT |
 		 EDMA_CFG_WR_BUFF_LEN, port_mmio + EDMA_CFG_OFS);
 
 	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
-	writelfl(pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK, 
+	writelfl(pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
 	writelfl(0, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
 	writelfl(0, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
 
 	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
-	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK, 
+	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	pp->req_producer = pp->rsp_consumer = 0;
@@ -805,20 +894,30 @@ static void mv_fill_sg(struct ata_queued
 	struct scatterlist *sg;
 
 	ata_for_each_sg(sg, qc) {
-		u32 sg_len;
 		dma_addr_t addr;
+		u32 sg_len, len, offset;
 
 		addr = sg_dma_address(sg);
 		sg_len = sg_dma_len(sg);
 
-		pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
-		pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-		assert(0 == (sg_len & ~MV_DMA_BOUNDARY));
-		pp->sg_tbl[i].flags_size = cpu_to_le32(sg_len);
-		if (ata_sg_is_last(sg, qc))
-			pp->sg_tbl[i].flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
+		while (sg_len) {
+			offset = addr & MV_DMA_BOUNDARY;
+			len = sg_len;
+			if ((offset + sg_len) > 0x10000)
+				len = 0x10000 - offset;
+
+			pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
+			pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
+			pp->sg_tbl[i].flags_size = cpu_to_le32(len);
+
+			sg_len -= len;
+			addr += len;
 
-		i++;
+			if (!sg_len && ata_sg_is_last(sg, qc))
+				pp->sg_tbl[i].flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
+
+			i++;
+		}
 	}
 }
 
@@ -859,7 +958,7 @@ static void mv_qc_prep(struct ata_queued
 	}
 
 	/* the req producer index should be the same as we remember it */
-	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >> 
+	assert(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
 		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->req_producer);
 
@@ -871,9 +970,9 @@ static void mv_qc_prep(struct ata_queued
 	assert(MV_MAX_Q_DEPTH > qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	pp->crqb[pp->req_producer].sg_addr = 
+	pp->crqb[pp->req_producer].sg_addr =
 		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	pp->crqb[pp->req_producer].sg_addr_hi = 
+	pp->crqb[pp->req_producer].sg_addr_hi =
 		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
 	pp->crqb[pp->req_producer].ctrl_flags = cpu_to_le16(flags);
 
@@ -896,7 +995,7 @@ static void mv_qc_prep(struct ata_queued
 #ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */
 	case ATA_CMD_FPDMA_READ:
 	case ATA_CMD_FPDMA_WRITE:
-		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0); 
+		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0);
 		mv_crqb_pack_cmd(cw++, tf->feature, ATA_REG_FEATURE, 0);
 		break;
 #endif				/* FIXME: remove this line when NCQ added */
@@ -962,7 +1061,7 @@ static int mv_qc_issue(struct ata_queued
 	       pp->req_producer);
 	/* until we do queuing, the queue should be empty at this point */
 	assert(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
-	       ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >> 
+	       ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
 		 EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
 	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
@@ -999,15 +1098,15 @@ static u8 mv_get_crpb_status(struct ata_
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* the response consumer index should be the same as we remember it */
-	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == 
+	assert(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
-	
+
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
-	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> 
-		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == 
+	assert(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
+		 EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) ==
 	       pp->rsp_consumer);
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
@@ -1055,7 +1154,7 @@ static void mv_err_intr(struct ata_port 
 
 	/* check for fatal here and recover if needed */
 	if (EDMA_ERR_FATAL & edma_err_cause) {
-		mv_phy_reset(ap);
+		mv_stop_and_reset(ap);
 	}
 }
 
@@ -1120,6 +1219,10 @@ static void mv_host_intr(struct ata_host
 			handled++;
 		}
 
+		if (ap &&
+		    (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)))
+			continue;
+
 		err_mask = ac_err_mask(ata_status);
 
 		shift = port << 1;		/* (port * 2) */
@@ -1131,14 +1234,15 @@ static void mv_host_intr(struct ata_host
 			err_mask |= AC_ERR_OTHER;
 			handled++;
 		}
-		
+
 		if (handled && ap) {
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (NULL != qc) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				ata_qc_complete(qc, err_mask);
+				if (!(qc->tf.ctl & ATA_NIEN))
+					ata_qc_complete(qc, err_mask);
 			}
 		}
 	}
@@ -1146,7 +1250,7 @@ static void mv_host_intr(struct ata_host
 }
 
 /**
- *      mv_interrupt - 
+ *      mv_interrupt -
  *      @irq: unused
  *      @dev_instance: private data; in this case the host structure
  *      @regs: unused
@@ -1156,7 +1260,7 @@ static void mv_host_intr(struct ata_host
  *      routine to handle.  Also check for PCI errors which are only
  *      reported here.
  *
- *      LOCKING: 
+ *      LOCKING:
  *      This routine holds the host_set lock while processing pending
  *      interrupts.
  */
@@ -1202,8 +1306,422 @@ static irqreturn_t mv_interrupt(int irq,
 	return IRQ_RETVAL(handled);
 }
 
+static void __iomem *mv5_phy_base(void __iomem *mmio, unsigned int port)
+{
+	void __iomem *hc_mmio = mv_hc_base_from_port(mmio, port);
+	unsigned long ofs = (mv_hardport_from_port(port) + 1) * 0x100UL;
+
+	return hc_mmio + ofs;
+}
+
+static unsigned int mv5_scr_offset(unsigned int sc_reg_in)
+{
+	unsigned int ofs;
+
+	switch (sc_reg_in) {
+	case SCR_STATUS:
+	case SCR_ERROR:
+	case SCR_CONTROL:
+		ofs = sc_reg_in * sizeof(u32);
+		break;
+	default:
+		ofs = 0xffffffffU;
+		break;
+	}
+	return ofs;
+}
+
+static u32 mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
+{
+	void __iomem *mmio = mv5_phy_base(ap->host_set->mmio_base, ap->port_no);
+	unsigned int ofs = mv5_scr_offset(sc_reg_in);
+
+	if (ofs != 0xffffffffU)
+		return readl(mmio + ofs);
+	else
+		return (u32) ofs;
+}
+
+static void mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
+{
+	void __iomem *mmio = mv5_phy_base(ap->host_set->mmio_base, ap->port_no);
+	unsigned int ofs = mv5_scr_offset(sc_reg_in);
+
+	if (ofs != 0xffffffffU)
+		writelfl(val, mmio + ofs);
+}
+
+static void mv5_reset_bus(struct pci_dev *pdev, void __iomem *mmio)
+{
+	u8 rev_id;
+	int early_5080;
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev_id);
+
+	early_5080 = (pdev->device == 0x5080) && (rev_id == 0);
+
+	if (!early_5080) {
+		u32 tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
+		tmp |= (1 << 0);
+		writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
+	}
+
+	mv_reset_pci_bus(pdev, mmio);
+}
+
+static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	writel(0x0fcfffff, mmio + MV_FLASH_CTL);
+}
+
+static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio)
+{
+	void __iomem *phy_mmio = mv5_phy_base(mmio, idx);
+	u32 tmp;
+
+	tmp = readl(phy_mmio + MV5_PHY_MODE);
+
+	hpriv->signal[idx].pre = tmp & 0x1800;	/* bits 12:11 */
+	hpriv->signal[idx].amps = tmp & 0xe0;	/* bits 7:5 */
+}
+
+static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	u32 tmp;
+
+	writel(0, mmio + MV_GPIO_PORT_CTL);
+
+	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
+
+	tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
+	tmp |= ~(1 << 0);
+	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
+}
+
+static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
+			   unsigned int port)
+{
+	void __iomem *phy_mmio = mv5_phy_base(mmio, port);
+	const u32 mask = (1<<12) | (1<<11) | (1<<7) | (1<<6) | (1<<5);
+	u32 tmp;
+	int fix_apm_sq = (hpriv->hp_flags & MV_HP_ERRATA_50XXB0);
+
+	if (fix_apm_sq) {
+		tmp = readl(phy_mmio + MV5_LT_MODE);
+		tmp |= (1 << 19);
+		writel(tmp, phy_mmio + MV5_LT_MODE);
+
+		tmp = readl(phy_mmio + MV5_PHY_CTL);
+		tmp &= ~0x3;
+		tmp |= 0x1;
+		writel(tmp, phy_mmio + MV5_PHY_CTL);
+	}
+
+	tmp = readl(phy_mmio + MV5_PHY_MODE);
+	tmp &= ~mask;
+	tmp |= hpriv->signal[port].pre;
+	tmp |= hpriv->signal[port].amps;
+	writel(tmp, phy_mmio + MV5_PHY_MODE);
+}
+
+
+#undef ZERO
+#define ZERO(reg) writel(0, port_mmio + (reg))
+static void mv5_reset_hc_port(struct mv_host_priv *hpriv, void __iomem *mmio,
+			     unsigned int port)
+{
+	void __iomem *port_mmio = mv_port_base(mmio, port);
+
+	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
+
+	mv_channel_reset(hpriv, mmio, port);
+
+	ZERO(0x028);	/* command */
+	writel(0x11f, port_mmio + EDMA_CFG_OFS);
+	ZERO(0x004);	/* timer */
+	ZERO(0x008);	/* irq err cause */
+	ZERO(0x00c);	/* irq err mask */
+	ZERO(0x010);	/* rq bah */
+	ZERO(0x014);	/* rq inp */
+	ZERO(0x018);	/* rq outp */
+	ZERO(0x01c);	/* respq bah */
+	ZERO(0x024);	/* respq outp */
+	ZERO(0x020);	/* respq inp */
+	ZERO(0x02c);	/* test control */
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+}
+#undef ZERO
+
+#define ZERO(reg) writel(0, hc_mmio + (reg))
+static void mv5_reset_one_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+			unsigned int hc)
+{
+	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
+	u32 tmp;
+
+	ZERO(0x00c);
+	ZERO(0x010);
+	ZERO(0x014);
+	ZERO(0x018);
+
+	tmp = readl(hc_mmio + 0x20);
+	tmp &= 0x1c1c1c1c;
+	tmp |= 0x03030303;
+	writel(tmp, hc_mmio + 0x20);
+}
+#undef ZERO
+
+static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+			unsigned int n_hc)
+{
+	unsigned int hc, port;
+
+	for (hc = 0; hc < n_hc; hc++) {
+		for (port = 0; port < MV_PORTS_PER_HC; port++)
+			mv5_reset_hc_port(hpriv, mmio,
+					  (hc * MV_PORTS_PER_HC) + port);
+
+		mv5_reset_one_hc(hpriv, mmio, hc);
+	}
+
+	return 0;
+}
+
+#undef ZERO
+#define ZERO(reg) writel(0, mmio + (reg))
+static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio)
+{
+	u32 tmp;
+
+	tmp = readl(mmio + MV_PCI_MODE);
+	tmp &= 0xff00ffff;
+	writel(tmp, mmio + MV_PCI_MODE);
+
+	ZERO(MV_PCI_DISC_TIMER);
+	ZERO(MV_PCI_MSI_TRIGGER);
+	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT);
+	ZERO(HC_MAIN_IRQ_MASK_OFS);
+	ZERO(MV_PCI_SERR_MASK);
+	ZERO(PCI_IRQ_CAUSE_OFS);
+	ZERO(PCI_IRQ_MASK_OFS);
+	ZERO(MV_PCI_ERR_LOW_ADDRESS);
+	ZERO(MV_PCI_ERR_HIGH_ADDRESS);
+	ZERO(MV_PCI_ERR_ATTRIBUTE);
+	ZERO(MV_PCI_ERR_COMMAND);
+}
+#undef ZERO
+
+static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	u32 tmp;
+
+	mv5_reset_flash(hpriv, mmio);
+
+	tmp = readl(mmio + MV_GPIO_PORT_CTL);
+	tmp &= 0x3;
+	tmp |= (1 << 5) | (1 << 6);
+	writel(tmp, mmio + MV_GPIO_PORT_CTL);
+}
+
+/**
+ *      mv6_reset_hc - Perform the 6xxx global soft reset
+ *      @mmio: base address of the HBA
+ *
+ *      This routine only applies to 6xxx parts.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
+static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+			unsigned int n_hc)
+{
+	void __iomem *reg = mmio + PCI_MAIN_CMD_STS_OFS;
+	int i, rc = 0;
+	u32 t;
+
+	/* Following procedure defined in PCI "main command and status
+	 * register" table.
+	 */
+	t = readl(reg);
+	writel(t | STOP_PCI_MASTER, reg);
+
+	for (i = 0; i < 1000; i++) {
+		udelay(1);
+		t = readl(reg);
+		if (PCI_MASTER_EMPTY & t) {
+			break;
+		}
+	}
+	if (!(PCI_MASTER_EMPTY & t)) {
+		printk(KERN_ERR DRV_NAME ": PCI master won't flush\n");
+		rc = 1;
+		goto done;
+	}
+
+	/* set reset */
+	i = 5;
+	do {
+		writel(t | GLOB_SFT_RST, reg);
+		t = readl(reg);
+		udelay(1);
+	} while (!(GLOB_SFT_RST & t) && (i-- > 0));
+
+	if (!(GLOB_SFT_RST & t)) {
+		printk(KERN_ERR DRV_NAME ": can't set global reset\n");
+		rc = 1;
+		goto done;
+	}
+
+	/* clear reset and *reenable the PCI master* (not mentioned in spec) */
+	i = 5;
+	do {
+		writel(t & ~(GLOB_SFT_RST | STOP_PCI_MASTER), reg);
+		t = readl(reg);
+		udelay(1);
+	} while ((GLOB_SFT_RST & t) && (i-- > 0));
+
+	if (GLOB_SFT_RST & t) {
+		printk(KERN_ERR DRV_NAME ": can't clear global reset\n");
+		rc = 1;
+	}
+done:
+	return rc;
+}
+
+static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio)
+{
+	void __iomem *port_mmio;
+	u32 tmp;
+
+	tmp = readl(mmio + MV_RESET_CFG);
+	if ((tmp & (1 << 0)) == 0) {
+		hpriv->signal[idx].amps = 0x7 << 8;
+		hpriv->signal[idx].pre = 0x1 << 5;
+		return;
+	}
+
+	port_mmio = mv_port_base(mmio, idx);
+	tmp = readl(port_mmio + PHY_MODE2);
+
+	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
+	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
+}
+
+static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio)
+{
+	writel(0x00000060, mmio + MV_GPIO_PORT_CTL);
+}
+
+static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
+			   unsigned int port)
+{
+	void __iomem *port_mmio = mv_port_base(mmio, port);
+
+	u32 hp_flags = hpriv->hp_flags;
+	int fix_phy_mode2 =
+		hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);
+	int fix_phy_mode4 =
+		hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);
+	u32 m2, tmp;
+
+	if (fix_phy_mode2) {
+		m2 = readl(port_mmio + PHY_MODE2);
+		m2 &= ~(1 << 16);
+		m2 |= (1 << 31);
+		writel(m2, port_mmio + PHY_MODE2);
+
+		udelay(200);
+
+		m2 = readl(port_mmio + PHY_MODE2);
+		m2 &= ~((1 << 16) | (1 << 31));
+		writel(m2, port_mmio + PHY_MODE2);
+
+		udelay(200);
+	}
+
+	/* who knows what this magic does */
+	tmp = readl(port_mmio + PHY_MODE3);
+	tmp &= ~0x7F800000;
+	tmp |= 0x2A800000;
+	writel(tmp, port_mmio + PHY_MODE3);
+
+	if (fix_phy_mode4) {
+		u32 m4;
+
+		m4 = readl(port_mmio + PHY_MODE4);
+
+		if (hp_flags & MV_HP_ERRATA_60X1B2)
+			tmp = readl(port_mmio + 0x310);
+
+		m4 = (m4 & ~(1 << 1)) | (1 << 0);
+
+		writel(m4, port_mmio + PHY_MODE4);
+
+		if (hp_flags & MV_HP_ERRATA_60X1B2)
+			writel(tmp, port_mmio + 0x310);
+	}
+
+	/* Revert values of pre-emphasis and signal amps to the saved ones */
+	m2 = readl(port_mmio + PHY_MODE2);
+
+	m2 &= ~MV_M2_PREAMP_MASK;
+	m2 |= hpriv->signal[port].amps;
+	m2 |= hpriv->signal[port].pre;
+	m2 &= ~(1 << 16);
+
+	writel(m2, port_mmio + PHY_MODE2);
+}
+
+static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem *mmio,
+			     unsigned int port_no)
+{
+	void __iomem *port_mmio = mv_port_base(mmio, port_no);
+
+	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
+
+	if (IS_60XX(hpriv)) {
+		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
+		ifctl |= (1 << 12) | (1 << 7);
+		writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
+	}
+
+	udelay(25);		/* allow reset propagation */
+
+	/* Spec never mentions clearing the bit.  Marvell's driver does
+	 * clear the bit, however.
+	 */
+	writelfl(0, port_mmio + EDMA_CMD_OFS);
+
+	hpriv->ops->phy_errata(hpriv, mmio, port_no);
+
+	if (IS_50XX(hpriv))
+		mdelay(1);
+}
+
+static void mv_stop_and_reset(struct ata_port *ap)
+{
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+
+	mv_stop_dma(ap);
+
+	mv_channel_reset(hpriv, mmio, ap->port_no);
+
+	__mv_phy_reset(ap, 0);
+}
+
+static inline void __msleep(unsigned int msec, int can_sleep)
+{
+	if (can_sleep)
+		msleep(msec);
+	else
+		mdelay(msec);
+}
+
 /**
- *      mv_phy_reset - Perform eDMA reset followed by COMRESET
+ *      __mv_phy_reset - Perform eDMA reset followed by COMRESET
  *      @ap: ATA channel to manipulate
  *
  *      Part of this is taken from __sata_phy_reset and modified to
@@ -1213,41 +1731,47 @@ static irqreturn_t mv_interrupt(int irq,
  *      Inherited from caller.  This is coded to safe to call at
  *      interrupt level, i.e. it does not sleep.
  */
-static void mv_phy_reset(struct ata_port *ap)
+static void __mv_phy_reset(struct ata_port *ap, int can_sleep)
 {
+	struct mv_port_priv *pp	= ap->private_data;
+	struct mv_host_priv *hpriv = ap->host_set->private_data;
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct ata_taskfile tf;
 	struct ata_device *dev = &ap->device[0];
 	unsigned long timeout;
+	int retry = 5;
+	u32 sstatus;
 
 	VPRINTK("ENTER, port %u, mmio 0x%p\n", ap->port_no, port_mmio);
 
-	mv_stop_dma(ap);
-
-	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
-	udelay(25);		/* allow reset propagation */
-
-	/* Spec never mentions clearing the bit.  Marvell's driver does
-	 * clear the bit, however.
-	 */
-	writelfl(0, port_mmio + EDMA_CMD_OFS);
-
-	VPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
+	DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
-	/* proceed to init communications via the scr_control reg */
+	/* Issue COMRESET via SControl */
+comreset_retry:
 	scr_write_flush(ap, SCR_CONTROL, 0x301);
-	mdelay(1);
+	__msleep(1, can_sleep);
+
 	scr_write_flush(ap, SCR_CONTROL, 0x300);
-	timeout = jiffies + (HZ * 1);
+	__msleep(20, can_sleep);
+
+	timeout = jiffies + msecs_to_jiffies(200);
 	do {
-		mdelay(10);
-		if ((scr_read(ap, SCR_STATUS) & 0xf) != 1)
+		sstatus = scr_read(ap, SCR_STATUS) & 0x3;
+		if ((sstatus == 3) || (sstatus == 0))
 			break;
+
+		__msleep(1, can_sleep);
 	} while (time_before(jiffies, timeout));
 
-	VPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
+	/* work around errata */
+	if (IS_60XX(hpriv) &&
+	    (sstatus != 0x0) && (sstatus != 0x113) && (sstatus != 0x123) &&
+	    (retry-- > 0))
+		goto comreset_retry;
+
+	DPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
 		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
 		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
 
@@ -1261,6 +1785,21 @@ static void mv_phy_reset(struct ata_port
 	}
 	ap->cbl = ATA_CBL_SATA;
 
+	/* even after SStatus reflects that device is ready,
+	 * it seems to take a while for link to be fully
+	 * established (and thus Status no longer 0x80/0x7F),
+	 * so we poll a bit for that, here.
+	 */
+	retry = 20;
+	while (1) {
+		u8 drv_stat = ata_check_status(ap);
+		if ((drv_stat != 0x80) && (drv_stat != 0x7f))
+			break;
+		__msleep(500, can_sleep);
+		if (retry-- <= 0)
+			break;
+	}
+
 	tf.lbah = readb((void __iomem *) ap->ioaddr.lbah_addr);
 	tf.lbam = readb((void __iomem *) ap->ioaddr.lbam_addr);
 	tf.lbal = readb((void __iomem *) ap->ioaddr.lbal_addr);
@@ -1271,9 +1810,19 @@ static void mv_phy_reset(struct ata_port
 		VPRINTK("Port disabled post-sig: No device present.\n");
 		ata_port_disable(ap);
 	}
+
+	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+
+	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
+
 	VPRINTK("EXIT\n");
 }
 
+static void mv_phy_reset(struct ata_port *ap)
+{
+	__mv_phy_reset(ap, 1);
+}
+
 /**
  *      mv_eng_timeout - Routine called by libata when SCSI times out I/O
  *      @ap: ATA channel to manipulate
@@ -1291,16 +1840,16 @@ static void mv_eng_timeout(struct ata_po
 
 	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
 	DPRINTK("All regs @ start of eng_timeout\n");
-	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no, 
+	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no,
 			 to_pci_dev(ap->host_set->dev));
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
         printk(KERN_ERR "mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
-	       ap->host_set->mmio_base, ap, qc, qc->scsicmd, 
+	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
 	mv_err_intr(ap);
-	mv_phy_reset(ap);
+	mv_stop_and_reset(ap);
 
 	if (!qc) {
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
@@ -1336,17 +1885,17 @@ static void mv_port_init(struct ata_iopo
 	unsigned long shd_base = (unsigned long) port_mmio + SHD_BLK_OFS;
 	unsigned serr_ofs;
 
-	/* PIO related setup 
+	/* PIO related setup
 	 */
 	port->data_addr = shd_base + (sizeof(u32) * ATA_REG_DATA);
-	port->error_addr = 
+	port->error_addr =
 		port->feature_addr = shd_base + (sizeof(u32) * ATA_REG_ERR);
 	port->nsect_addr = shd_base + (sizeof(u32) * ATA_REG_NSECT);
 	port->lbal_addr = shd_base + (sizeof(u32) * ATA_REG_LBAL);
 	port->lbam_addr = shd_base + (sizeof(u32) * ATA_REG_LBAM);
 	port->lbah_addr = shd_base + (sizeof(u32) * ATA_REG_LBAH);
 	port->device_addr = shd_base + (sizeof(u32) * ATA_REG_DEVICE);
-	port->status_addr = 
+	port->status_addr =
 		port->command_addr = shd_base + (sizeof(u32) * ATA_REG_STATUS);
 	/* special case: control/altstatus doesn't have ATA_REG_ address */
 	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST_OFS;
@@ -1362,14 +1911,92 @@ static void mv_port_init(struct ata_iopo
 	/* unmask all EDMA error interrupts */
 	writelfl(~0, port_mmio + EDMA_ERR_IRQ_MASK_OFS);
 
-	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n", 
+	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n",
 		readl(port_mmio + EDMA_CFG_OFS),
 		readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS),
 		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));
 }
 
+static int mv_chip_id(struct pci_dev *pdev, struct mv_host_priv *hpriv,
+		      unsigned int board_idx)
+{
+	u8 rev_id;
+	u32 hp_flags = hpriv->hp_flags;
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &rev_id);
+
+	switch(board_idx) {
+	case chip_5080:
+		hpriv->ops = &mv5xxx_ops;
+		hp_flags |= MV_HP_50XX;
+
+		switch (rev_id) {
+		case 0x1:
+			hp_flags |= MV_HP_ERRATA_50XXB0;
+			break;
+		case 0x3:
+			hp_flags |= MV_HP_ERRATA_50XXB2;
+			break;
+		default:
+			dev_printk(KERN_WARNING, &pdev->dev,
+			   "Applying 50XXB2 workarounds to unknown rev\n");
+			hp_flags |= MV_HP_ERRATA_50XXB2;
+			break;
+		}
+		break;
+
+	case chip_504x:
+	case chip_508x:
+		hpriv->ops = &mv5xxx_ops;
+		hp_flags |= MV_HP_50XX;
+
+		switch (rev_id) {
+		case 0x0:
+			hp_flags |= MV_HP_ERRATA_50XXB0;
+			break;
+		case 0x3:
+			hp_flags |= MV_HP_ERRATA_50XXB2;
+			break;
+		default:
+			dev_printk(KERN_WARNING, &pdev->dev,
+			   "Applying B2 workarounds to unknown rev\n");
+			hp_flags |= MV_HP_ERRATA_50XXB2;
+			break;
+		}
+		break;
+
+	case chip_604x:
+	case chip_608x:
+		hpriv->ops = &mv6xxx_ops;
+
+		switch (rev_id) {
+		case 0x7:
+			hp_flags |= MV_HP_ERRATA_60X1B2;
+			break;
+		case 0x9:
+			hp_flags |= MV_HP_ERRATA_60X1C0;
+			break;
+		default:
+			dev_printk(KERN_WARNING, &pdev->dev,
+				   "Applying B2 workarounds to unknown rev\n");
+			hp_flags |= MV_HP_ERRATA_60X1B2;
+			break;
+		}
+		break;
+
+	default:
+		printk(KERN_ERR DRV_NAME ": BUG: invalid board index %u\n", board_idx);
+		return 1;
+	}
+
+	hpriv->hp_flags = hp_flags;
+
+	return 0;
+}
+
 /**
- *      mv_host_init - Perform some early initialization of the host.
+ *      mv_init_host - Perform some early initialization of the host.
+ *	@pdev: host PCI device
  *      @probe_ent: early data struct representing the host
  *
  *      If possible, do an early global reset of the host.  Then do
@@ -1378,23 +2005,48 @@ static void mv_port_init(struct ata_iopo
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_host_init(struct ata_probe_ent *probe_ent)
+static int mv_init_host(struct pci_dev *pdev, struct ata_probe_ent *probe_ent,
+			unsigned int board_idx)
 {
 	int rc = 0, n_hc, port, hc;
 	void __iomem *mmio = probe_ent->mmio_base;
-	void __iomem *port_mmio;
+	struct mv_host_priv *hpriv = probe_ent->private_data;
 
-	if ((MV_FLAG_GLBL_SFT_RST & probe_ent->host_flags) && 
-	    mv_global_soft_reset(probe_ent->mmio_base)) {
-		rc = 1;
+	/* global interrupt mask */
+	writel(0, mmio + HC_MAIN_IRQ_MASK_OFS);
+
+	rc = mv_chip_id(pdev, hpriv, board_idx);
+	if (rc)
 		goto done;
-	}
 
 	n_hc = mv_get_hc_count(probe_ent->host_flags);
 	probe_ent->n_ports = MV_PORTS_PER_HC * n_hc;
 
+	for (port = 0; port < probe_ent->n_ports; port++)
+		hpriv->ops->read_preamp(hpriv, port, mmio);
+
+	rc = hpriv->ops->reset_hc(hpriv, mmio, n_hc);
+	if (rc)
+		goto done;
+
+	hpriv->ops->reset_flash(hpriv, mmio);
+	hpriv->ops->reset_bus(pdev, mmio);
+	hpriv->ops->enable_leds(hpriv, mmio);
+
 	for (port = 0; port < probe_ent->n_ports; port++) {
-		port_mmio = mv_port_base(mmio, port);
+		if (IS_60XX(hpriv)) {
+			void __iomem *port_mmio = mv_port_base(mmio, port);
+
+			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
+			ifctl |= (1 << 12);
+			writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
+		}
+
+		hpriv->ops->phy_errata(hpriv, mmio, port);
+	}
+
+	for (port = 0; port < probe_ent->n_ports; port++) {
+		void __iomem *port_mmio = mv_port_base(mmio, port);
 		mv_port_init(&probe_ent->port[port], port_mmio);
 	}
 
@@ -1418,11 +2070,12 @@ static int mv_host_init(struct ata_probe
 	writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
 
 	VPRINTK("HC MAIN IRQ cause/mask=0x%08x/0x%08x "
-		"PCI int cause/mask=0x%08x/0x%08x\n", 
+		"PCI int cause/mask=0x%08x/0x%08x\n",
 		readl(mmio + HC_MAIN_IRQ_CAUSE_OFS),
 		readl(mmio + HC_MAIN_IRQ_MASK_OFS),
 		readl(mmio + PCI_IRQ_CAUSE_OFS),
 		readl(mmio + PCI_IRQ_MASK_OFS));
+
 done:
 	return rc;
 }
@@ -1458,7 +2111,7 @@ static void mv_print_info(struct ata_pro
 
 	dev_printk(KERN_INFO, &pdev->dev,
 	       "%u slots %u ports %s mode IRQ via %s\n",
-	       (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports, 
+	       (unsigned)MV_MAX_Q_DEPTH, probe_ent->n_ports,
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }
 
@@ -1528,7 +2181,7 @@ static int mv_init_one(struct pci_dev *p
 	probe_ent->private_data = hpriv;
 
 	/* initialize adapter */
-	rc = mv_host_init(probe_ent);
+	rc = mv_init_host(pdev, probe_ent, board_idx);
 	if (rc) {
 		goto err_out_hpriv;
 	}
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 242d906..8a8e3e3 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -46,7 +46,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"1.02"
+#define DRV_VERSION	"1.03"
 
 
 enum {
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 4a6d306..a8987f5 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -41,7 +41,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_qstor"
-#define DRV_VERSION	"0.04"
+#define DRV_VERSION	"0.05"
 
 enum {
 	QS_PORTS		= 4,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 55e744d..cb1933a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -139,6 +139,7 @@ enum {
 	PORT_CS_DEV_RST		= (1 << 1), /* device reset */
 	PORT_CS_INIT		= (1 << 2), /* port initialize */
 	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
+	PORT_CS_CDB16		= (1 << 5), /* 0=12b cdb, 1=16b cdb */
 	PORT_CS_RESUME		= (1 << 6), /* port resume */
 	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
 	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
@@ -188,11 +189,29 @@ enum {
 	PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during transfer */
 	PORT_CERR_SENDSERVICE	= 36, /* FIS received while sending service */
 
+	/* bits of PRB control field */
+	PRB_CTRL_PROTOCOL	= (1 << 0), /* override def. ATA protocol */
+	PRB_CTRL_PACKET_READ	= (1 << 4), /* PACKET cmd read */
+	PRB_CTRL_PACKET_WRITE	= (1 << 5), /* PACKET cmd write */
+	PRB_CTRL_NIEN		= (1 << 6), /* Mask completion irq */
+	PRB_CTRL_SRST		= (1 << 7), /* Soft reset request (ign BSY?) */
+
+	/* PRB protocol field */
+	PRB_PROT_PACKET		= (1 << 0),
+	PRB_PROT_TCQ		= (1 << 1),
+	PRB_PROT_NCQ		= (1 << 2),
+	PRB_PROT_READ		= (1 << 3),
+	PRB_PROT_WRITE		= (1 << 4),
+	PRB_PROT_TRANSPARENT	= (1 << 5),
+
 	/*
 	 * Other constants
 	 */
 	SGE_TRM			= (1 << 31), /* Last SGE in chain */
-	PRB_SOFT_RST		= (1 << 7),  /* Soft reset request (ign BSY?) */
+	SGE_LNK			= (1 << 30), /* linked list
+						Points to SGT, not SGE */
+	SGE_DRD			= (1 << 29), /* discard data read (/dev/null)
+						data address ignored */
 
 	/* board id */
 	BID_SIL3124		= 0,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 57e5a9d..6e7f7c8 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -54,7 +54,7 @@
 #endif /* CONFIG_PPC_OF */
 
 #define DRV_NAME	"sata_svw"
-#define DRV_VERSION	"1.06"
+#define DRV_VERSION	"1.07"
 
 /* Taskfile registers offsets */
 #define K2_SATA_TF_CMD_OFFSET		0x00
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index b4bbe48..dcc3ad9 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -46,7 +46,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_sx4"
-#define DRV_VERSION	"0.7"
+#define DRV_VERSION	"0.8"
 
 
 enum {
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 77a6e4b..fcfa486 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -47,7 +47,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_vsc"
-#define DRV_VERSION	"1.0"
+#define DRV_VERSION	"1.1"
 
 /* Interrupt register offsets (from chip base address) */
 #define VSC_SATA_INT_STAT_OFFSET	0x00
