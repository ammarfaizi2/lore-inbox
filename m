Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUJOIKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUJOIKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 04:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUJOIKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 04:10:05 -0400
Received: from havoc.gtf.org ([69.28.190.101]:26016 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266505AbUJOIEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 04:04:04 -0400
Date: Fri, 15 Oct 2004 04:04:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [SATA] libata-dev queue updated
Message-ID: <20041015080402.GA5938@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch should show up at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/
eventually.

This will update the following files:

 drivers/pci/quirks.c        |    4 
 drivers/scsi/Kconfig        |    8 
 drivers/scsi/Makefile       |    1 
 drivers/scsi/ahci.c         | 1023 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |   69 ++
 drivers/scsi/libata-scsi.c  |  453 +++++++++++++++++--
 drivers/scsi/libata.h       |    7 
 drivers/scsi/sata_promise.c |   56 ++
 drivers/scsi/sata_sil.c     |    2 
 drivers/scsi/sata_vsc.c     |    8 
 include/linux/ata.h         |   37 -
 include/linux/libata.h      |   14 
 include/scsi/scsi.h         |    3 
 13 files changed, 1601 insertions(+), 84 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<lsml:rtr.ca>:
  o Export ata_scsi_simulate() for use by non-libata drivers

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o Fix build breakage related to hand-merging Brad Campbell's and Mark Lord's changes.
  o [libata] fix printk warning
  o [ata piix] enable ICH5/6 combined mode quirk based on BLK_DEV_IDE_SATA
  o [libata ahci] more updates
  o [libata ahci] fix several bugs
  o [libata] add AHCI driver

Jeremy Higdon:
  o per-port LED control for sata_vsc

John W. Linville:
  o libata: SMART support via ATA pass-thru

diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-10-15 03:08:20 -04:00
+++ b/drivers/pci/quirks.c	2004-10-15 03:08:20 -04:00
@@ -904,7 +904,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
-#ifdef CONFIG_SCSI_SATA
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
@@ -976,7 +976,7 @@
 		request_region(0x170, 8, "libata");	/* port 1 */
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,	  quirk_intel_ide_combined );
-#endif /* CONFIG_SCSI_SATA */
+#endif /* CONFIG_BLK_DEV_IDE_SATA */
 
 int pciehp_msi_quirk;
 
diff -Nru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/Kconfig	2004-10-15 03:08:20 -04:00
@@ -406,6 +406,14 @@
 
 	  If unsure, say N.
 
+config SCSI_SATA_AHCI
+	tristate "AHCI SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for AHCI Serial ATA.
+
+	  If unsure, say N.
+
 config SCSI_SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL)"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/Makefile	2004-10-15 03:08:20 -04:00
@@ -121,6 +121,7 @@
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
 obj-$(CONFIG_SCSI_IPR)		+= ipr.o
 obj-$(CONFIG_SCSI_IBMVSCSI)	+= ibmvscsi/
+obj-$(CONFIG_SCSI_SATA_AHCI)	+= libata.o ahci.o
 obj-$(CONFIG_SCSI_SATA_SVW)	+= libata.o sata_svw.o
 obj-$(CONFIG_SCSI_ATA_PIIX)	+= libata.o ata_piix.o
 obj-$(CONFIG_SCSI_SATA_PROMISE)	+= libata.o sata_promise.o
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/ahci.c	2004-10-15 03:08:20 -04:00
@@ -0,0 +1,1023 @@
+/*
+ *  ahci.c - AHCI SATA support
+ *
+ *  Copyright 2004 Red Hat, Inc.
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the terms
+ *  of the GNU General Public License version 2 (the "GPL") as distributed
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above and
+ *  replace them with the notice and other provisions required by the GPL.
+ *  If you do not delete the provisions above, a recipient may use your
+ *  version of this file under either the OSL or the GPL.
+ *
+ * Version 1.0 of the AHCI specification:
+ * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <asm/io.h>
+
+#define DRV_NAME	"ahci"
+#define DRV_VERSION	"0.11"
+
+
+enum {
+	AHCI_PCI_BAR		= 5,
+	AHCI_MAX_SG		= 168, /* hardware max is 64K */
+	AHCI_DMA_BOUNDARY	= 0xffffffff,
+	AHCI_USE_CLUSTERING	= 0,
+	AHCI_CMD_SLOT_SZ	= 32 * 32,
+	AHCI_RX_FIS_SZ		= 256,
+	AHCI_CMD_TBL_HDR	= 0x80,
+	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
+	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
+				  AHCI_RX_FIS_SZ,
+	AHCI_IRQ_ON_SG		= (1 << 31),
+	AHCI_CMD_ATAPI		= (1 << 5),
+	AHCI_CMD_WRITE		= (1 << 6),
+
+	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
+
+	board_ahci		= 0,
+
+	/* global controller registers */
+	HOST_CAP		= 0x00, /* host capabilities */
+	HOST_CTL		= 0x04, /* global host control */
+	HOST_IRQ_STAT		= 0x08, /* interrupt status */
+	HOST_PORTS_IMPL		= 0x0c, /* bitmap of implemented ports */
+	HOST_VERSION		= 0x10, /* AHCI spec. version compliancy */
+
+	/* HOST_CTL bits */
+	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
+	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+
+	/* HOST_CAP bits */
+	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+
+	/* registers for each SATA port */
+	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
+	PORT_LST_ADDR_HI	= 0x04, /* command list DMA addr hi */
+	PORT_FIS_ADDR		= 0x08, /* FIS rx buf addr */
+	PORT_FIS_ADDR_HI	= 0x0c, /* FIS rx buf addr hi */
+	PORT_IRQ_STAT		= 0x10, /* interrupt status */
+	PORT_IRQ_MASK		= 0x14, /* interrupt enable/disable mask */
+	PORT_CMD		= 0x18, /* port command */
+	PORT_TFDATA		= 0x20,	/* taskfile data */
+	PORT_SIG		= 0x24,	/* device TF signature */
+	PORT_CMD_ISSUE		= 0x38, /* command issue */
+	PORT_SCR		= 0x28, /* SATA phy register block */
+	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
+	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
+	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
+
+	/* PORT_IRQ_{STAT,MASK} bits */
+	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
+	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
+	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+
+	PORT_IRQ_FATAL		= PORT_IRQ_TF_ERR |
+				  PORT_IRQ_HBUS_ERR |
+				  PORT_IRQ_HBUS_DATA_ERR |
+				  PORT_IRQ_IF_ERR,
+	DEF_PORT_IRQ		= PORT_IRQ_FATAL | PORT_IRQ_PHYRDY |
+				  PORT_IRQ_D2H_REG_FIS,
+
+	/* PORT_CMD bits */
+	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
+	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
+	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
+	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
+
+	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+};
+
+struct ahci_cmd_hdr {
+	u32			opts;
+	u32			status;
+	u32			tbl_addr;
+	u32			tbl_addr_hi;
+	u32			reserved[4];
+};
+
+struct ahci_sg {
+	u32			addr;
+	u32			addr_hi;
+	u32			reserved;
+	u32			flags_size;
+};
+
+struct ahci_host_priv {
+	unsigned long		flags;
+	u32			cap;	/* cache of HOST_CAP register */
+	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+};
+
+struct ahci_port_priv {
+	struct ahci_cmd_hdr	*cmd_slot;
+	dma_addr_t		cmd_slot_dma;
+	void			*cmd_tbl;
+	dma_addr_t		cmd_tbl_dma;
+	struct ahci_sg		*cmd_tbl_sg;
+	void			*rx_fis;
+	dma_addr_t		rx_fis_dma;
+};
+
+static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int ahci_qc_issue(struct ata_queued_cmd *qc);
+static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static void ahci_phy_reset(struct ata_port *ap);
+static void ahci_irq_clear(struct ata_port *ap);
+static void ahci_eng_timeout(struct ata_port *ap);
+static int ahci_port_start(struct ata_port *ap);
+static void ahci_port_stop(struct ata_port *ap);
+static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_qc_prep(struct ata_queued_cmd *qc);
+static u8 ahci_check_status(struct ata_port *ap);
+static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+
+static Scsi_Host_Template ahci_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= AHCI_MAX_SG,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= AHCI_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= AHCI_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations ahci_ops = {
+	.port_disable		= ata_port_disable,
+
+	.check_status		= ahci_check_status,
+	.dev_select		= ata_noop_dev_select,
+
+	.phy_reset		= ahci_phy_reset,
+
+	.qc_prep		= ahci_qc_prep,
+	.qc_issue		= ahci_qc_issue,
+
+	.eng_timeout		= ahci_eng_timeout,
+
+	.irq_handler		= ahci_interrupt,
+	.irq_clear		= ahci_irq_clear,
+
+	.scr_read		= ahci_scr_read,
+	.scr_write		= ahci_scr_write,
+
+	.port_start		= ahci_port_start,
+	.port_stop		= ahci_port_stop,
+	.host_stop		= ahci_host_stop,
+};
+
+static struct ata_port_info ahci_port_info[] = {
+	/* board_ahci */
+	{
+		.sht		= &ahci_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03, /* pio3-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
+};
+
+static struct pci_device_id ahci_pci_tbl[] = {
+	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },
+	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },
+	{ }	/* terminate list */
+};
+
+
+static struct pci_driver ahci_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= ahci_pci_tbl,
+	.probe			= ahci_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+
+static inline unsigned long ahci_port_base_ul (unsigned long base, unsigned int port)
+{
+	return base + 0x100 + (port * 0x80);
+}
+
+static inline void *ahci_port_base (void *base, unsigned int port)
+{
+	return (void *) ahci_port_base_ul((unsigned long)base, port);
+}
+
+static void ahci_host_stop(struct ata_host_set *host_set)
+{
+	struct ahci_host_priv *hpriv = host_set->private_data;
+	kfree(hpriv);
+}
+
+static int ahci_port_start(struct ata_port *ap)
+{
+	struct pci_dev *pdev = ap->host_set->pdev;
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp;
+	int rc;
+	void *mem, *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	dma_addr_t mem_dma;
+
+	rc = ata_port_start(ap);
+	if (rc)
+		return rc;
+
+	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+	memset(pp, 0, sizeof(*pp));
+
+	mem = pci_alloc_consistent(pdev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma);
+	if (!mem) {
+		rc = -ENOMEM;
+		goto err_out_kfree;
+	}
+	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
+
+	/*
+	 * First item in chunk of DMA memory: 32-slot command table,
+	 * 32 bytes each in size
+	 */
+	pp->cmd_slot = mem;
+	pp->cmd_slot_dma = mem_dma;
+
+	mem += AHCI_CMD_SLOT_SZ;
+	mem_dma += AHCI_CMD_SLOT_SZ;
+
+	/*
+	 * Second item: Received-FIS area
+	 */
+	pp->rx_fis = mem;
+	pp->rx_fis_dma = mem_dma;
+
+	mem += AHCI_RX_FIS_SZ;
+	mem_dma += AHCI_RX_FIS_SZ;
+
+	/*
+	 * Third item: data area for storing a single command
+	 * and its scatter-gather table
+	 */
+	pp->cmd_tbl = mem;
+	pp->cmd_tbl_dma = mem_dma;
+
+	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR;
+
+	ap->private_data = pp;
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio + PORT_LST_ADDR_HI);
+	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	if (hpriv->cap & HOST_CAP_64)
+		writel((pp->rx_fis_dma >> 16) >> 16, port_mmio + PORT_FIS_ADDR_HI);
+	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
+	readl(port_mmio + PORT_LST_ADDR); /* flush */
+
+	writel(PORT_CMD_ICC_ACTIVE | PORT_CMD_FIS_RX |
+	       PORT_CMD_POWER_ON | PORT_CMD_SPIN_UP |
+	       PORT_CMD_START, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	return 0;
+
+err_out_kfree:
+	kfree(pp);
+err_out:
+	ata_port_stop(ap);
+	return rc;
+}
+
+
+static void ahci_port_stop(struct ata_port *ap)
+{
+	struct pci_dev *pdev = ap->host_set->pdev;
+	struct ahci_port_priv *pp = ap->private_data;
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~(PORT_CMD_START | PORT_CMD_FIS_RX);
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	/* spec says 500 msecs for each PORT_CMD_{START,FIS_RX} bit, so
+	 * this is slightly incorrect.
+	 */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout((HZ / 2) + 1);
+
+	ap->private_data = NULL;
+	pci_free_consistent(pdev, AHCI_PORT_PRIV_DMA_SZ,
+			    pp->cmd_slot, pp->cmd_slot_dma);
+	kfree(pp);
+	ata_port_stop(ap);
+}
+
+static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
+{
+	unsigned int sc_reg;
+
+	switch (sc_reg_in) {
+	case SCR_STATUS:	sc_reg = 0; break;
+	case SCR_CONTROL:	sc_reg = 1; break;
+	case SCR_ERROR:		sc_reg = 2; break;
+	case SCR_ACTIVE:	sc_reg = 3; break;
+	default:
+		return 0xffffffffU;
+	}
+
+	return readl((void *) ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+
+static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
+			       u32 val)
+{
+	unsigned int sc_reg;
+
+	switch (sc_reg_in) {
+	case SCR_STATUS:	sc_reg = 0; break;
+	case SCR_CONTROL:	sc_reg = 1; break;
+	case SCR_ERROR:		sc_reg = 2; break;
+	case SCR_ACTIVE:	sc_reg = 3; break;
+	default:
+		return;
+	}
+
+	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+static void ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ata_taskfile tf;
+	struct ata_device *dev = &ap->device[0];
+	u32 tmp;
+
+	__sata_phy_reset(ap);
+
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	tmp = readl(port_mmio + PORT_SIG);
+	tf.lbah		= (tmp >> 24)	& 0xff;
+	tf.lbam		= (tmp >> 16)	& 0xff;
+	tf.lbal		= (tmp >> 8)	& 0xff;
+	tf.nsect	= (tmp)		& 0xff;
+
+	dev->class = ata_dev_classify(&tf);
+	if (!ata_dev_present(dev))
+		ata_port_disable(ap);
+}
+
+static u8 ahci_check_status(struct ata_port *ap)
+{
+	void *mmio = (void *) ap->ioaddr.cmd_addr;
+
+	return readl(mmio + PORT_TFDATA) & 0xFF;
+}
+
+static void ahci_fill_sg(struct ata_queued_cmd *qc)
+{
+	struct ahci_port_priv *pp = qc->ap->private_data;
+	unsigned int i;
+
+	VPRINTK("ENTER\n");
+
+	/*
+	 * Next, the S/G list.
+	 */
+	for (i = 0; i < qc->n_elem; i++) {
+		u32 sg_len;
+		dma_addr_t addr;
+
+		addr = sg_dma_address(&qc->sg[i]);
+		sg_len = sg_dma_len(&qc->sg[i]);
+
+		pp->cmd_tbl_sg[i].addr = cpu_to_le32(addr & 0xffffffff);
+		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
+		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
+	}
+}
+
+static void ahci_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct ahci_port_priv *pp = qc->ap->private_data;
+	u32 opts;
+	const u32 cmd_fis_len = 5; /* five dwords */
+
+	/*
+	 * Fill in command slot information (currently only one slot,
+	 * slot 0, is currently since we don't do queueing)
+	 */
+
+	opts = (qc->n_elem << 16) | cmd_fis_len;
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		opts |= AHCI_CMD_WRITE;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_NODATA:
+	case ATA_PROT_ATAPI_DMA:
+		opts |= AHCI_CMD_ATAPI;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	pp->cmd_slot[0].opts = cpu_to_le32(opts);
+	pp->cmd_slot[0].status = 0;
+	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+
+	/*
+	 * Fill in command table information.  First, the header,
+	 * a SATA Register - Host to Device command FIS.
+	 */
+	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+
+	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
+		return;
+
+	ahci_fill_sg(qc);
+}
+
+static inline void ahci_dma_complete (struct ata_port *ap,
+                                     struct ata_queued_cmd *qc,
+				     int have_err)
+{
+	/* get drive status; clear intr; complete txn */
+	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
+			have_err ? ATA_ERR : 0);
+}
+
+static void ahci_intr_error(struct ata_port *ap, u32 irq_stat)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+	int work;
+
+	/* stop DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop.  TODO: this could be
+	 * as long as 500 msec
+	 */
+	work = 1000;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			break;
+		udelay(10);
+	}
+
+	/* clear SATA phy error, if any */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* if DRQ/BSY is set, device needs to be reset.
+	 * if so, issue COMRESET
+	 */
+	tmp = readl(port_mmio + PORT_TFDATA);
+	if (tmp & (ATA_BUSY | ATA_DRQ)) {
+		writel(0x301, port_mmio + PORT_SCR_CTL);
+		readl(port_mmio + PORT_SCR_CTL); /* flush */
+		udelay(10);
+		writel(0x300, port_mmio + PORT_SCR_CTL);
+		readl(port_mmio + PORT_SCR_CTL); /* flush */
+	}
+
+	/* re-start DMA */
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
+}
+
+static void ahci_eng_timeout(struct ata_port *ap)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ata_queued_cmd *qc;
+
+	DPRINTK("ENTER\n");
+
+	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (!qc) {
+		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
+		       ap->id);
+	} else {
+		/* hack alert!  We cannot use the supplied completion
+	 	 * function from inside the ->eh_strategy_handler() thread.
+	 	 * libata is the only user of ->eh_strategy_handler() in
+	 	 * any kernel, so the default scsi_done() assumes it is
+	 	 * not being called from the SCSI EH.
+	 	 */
+		qc->scsidone = scsi_finish_command;
+		ata_qc_complete(qc, ATA_ERR);
+	}
+
+}
+
+static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	void *mmio = ap->host_set->mmio_base;
+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 status, serr, ci;
+
+	serr = readl(port_mmio + PORT_SCR_ERR);
+	writel(serr, port_mmio + PORT_SCR_ERR);
+
+	status = readl(port_mmio + PORT_IRQ_STAT);
+	writel(status, port_mmio + PORT_IRQ_STAT);
+
+	ci = readl(port_mmio + PORT_CMD_ISSUE);
+	if (likely((ci & 0x1) == 0)) {
+		if (qc) {
+			ata_qc_complete(qc, 0);
+			qc = NULL;
+		}
+	}
+
+	if (status & PORT_IRQ_FATAL) {
+		ahci_intr_error(ap, status);
+		if (qc)
+			ata_qc_complete(qc, ATA_ERR);
+	}
+
+	return 1;
+}
+
+static void ahci_irq_clear(struct ata_port *ap)
+{
+	/* TODO */
+}
+
+static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	struct ahci_host_priv *hpriv;
+	unsigned int i, handled = 0;
+	void *mmio;
+	u32 irq_stat, irq_ack = 0;
+
+	VPRINTK("ENTER\n");
+
+	hpriv = host_set->private_data;
+	mmio = host_set->mmio_base;
+
+	/* sigh.  0xffffffff is a valid return from h/w */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	irq_stat &= hpriv->port_map;
+	if (!irq_stat)
+		return IRQ_NONE;
+
+        spin_lock(&host_set->lock);
+
+        for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+		u32 tmp;
+
+		VPRINTK("port %u\n", i);
+		ap = host_set->ports[i];
+		tmp = irq_stat & (1 << i);
+		if (tmp && ap) {
+			struct ata_queued_cmd *qc;
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (ahci_host_intr(ap, qc))
+				irq_ack |= (1 << i);
+		}
+	}
+
+	if (irq_ack) {
+		writel(irq_ack, mmio + HOST_IRQ_STAT);
+		handled = 1;
+	}
+
+        spin_unlock(&host_set->lock);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(handled);
+}
+
+static int ahci_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *mmio = (void *) ap->ioaddr.cmd_addr;
+
+	writel(1, mmio + PORT_CMD_ISSUE);
+	readl(mmio + PORT_CMD_ISSUE);	/* flush */
+
+	return 0;
+}
+
+static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
+			    unsigned int port_idx)
+{
+	VPRINTK("ENTER, base==0x%lx, port_idx %u\n", base, port_idx);
+	base = ahci_port_base_ul(base, port_idx);
+	VPRINTK("base now==0x%lx\n", base);
+
+	port->cmd_addr		= base;
+	port->scr_addr		= base + PORT_SCR;
+
+	VPRINTK("EXIT\n");
+}
+
+static int ahci_host_init(struct ata_probe_ent *probe_ent)
+{
+	struct ahci_host_priv *hpriv = probe_ent->private_data;
+	struct pci_dev *pdev = probe_ent->pdev;
+	void __iomem *mmio = probe_ent->mmio_base;
+	u32 tmp, cap_save;
+	u16 tmp16;
+	unsigned int i, j, using_dac;
+	int rc;
+	void __iomem *port_mmio;
+
+	cap_save = readl(mmio + HOST_CAP);
+	cap_save &= ( (1<<28) | (1<<17) );
+	cap_save |= (1 << 27);
+
+	/* global controller reset */
+	tmp = readl(mmio + HOST_CTL);
+	if ((tmp & HOST_RESET) == 0) {
+		writel(tmp | HOST_RESET, mmio + HOST_CTL);
+		readl(mmio + HOST_CTL); /* flush */
+	}
+
+	/* reset must complete within 1 second, or
+	 * the hardware should be considered fried.
+	 */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ + 1);
+
+	tmp = readl(mmio + HOST_CTL);
+	if (tmp & HOST_RESET) {
+		printk(KERN_ERR DRV_NAME "(%s): controller reset failed (0x%x)\n",
+			pci_name(pdev), tmp);
+		return -EIO;
+	}
+
+	writel(HOST_AHCI_EN, mmio + HOST_CTL);
+	(void) readl(mmio + HOST_CTL);	/* flush */
+	writel(cap_save, mmio + HOST_CAP);
+	writel(0xf, mmio + HOST_PORTS_IMPL);
+	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
+
+	pci_read_config_word(pdev, 0x92, &tmp16);
+	tmp16 |= 0xf;
+	pci_write_config_word(pdev, 0x92, tmp16);
+
+	hpriv->cap = readl(mmio + HOST_CAP);
+	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
+	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+
+	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
+		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
+
+	using_dac = hpriv->cap & HOST_CAP_64;
+	if (using_dac &&
+	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
+		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+		if (rc) {
+			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+			if (rc) {
+				printk(KERN_ERR DRV_NAME "(%s): 64-bit DMA enable failed\n",
+					pci_name(pdev));
+				return rc;
+			}
+		}
+
+		hpriv->flags |= HOST_CAP_64;
+	} else {
+		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		if (rc) {
+			printk(KERN_ERR DRV_NAME "(%s): 32-bit DMA enable failed\n",
+				pci_name(pdev));
+			return rc;
+		}
+		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+		if (rc) {
+			printk(KERN_ERR DRV_NAME "(%s): 32-bit consistent DMA enable failed\n",
+				pci_name(pdev));
+			return rc;
+		}
+	}
+
+	for (i = 0; i < probe_ent->n_ports; i++) {
+		if (!(hpriv->port_map & (1 << i)))
+			continue;
+
+		port_mmio = ahci_port_base(mmio, i);
+		VPRINTK("mmio %p  port_mmio %p\n", mmio, port_mmio);
+
+		ahci_setup_port(&probe_ent->port[i],
+				(unsigned long) mmio, i);
+
+		/* make sure port is not active */
+		tmp = readl(port_mmio + PORT_CMD);
+		VPRINTK("PORT_CMD 0x%x\n", tmp);
+		if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
+			   PORT_CMD_FIS_RX | PORT_CMD_START)) {
+			tmp &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
+				 PORT_CMD_FIS_RX | PORT_CMD_START);
+			writel(tmp, port_mmio + PORT_CMD);
+			readl(port_mmio + PORT_CMD); /* flush */
+
+			/* spec says 500 msecs for each bit, so
+			 * this is slightly incorrect.
+			 */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout((HZ / 2) + 1);
+		}
+
+		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
+
+		j = 0;
+		while (j < 100) {
+			msleep(10);
+			tmp = readl(port_mmio + PORT_SCR_STAT);
+			if ((tmp & 0xf) == 0x3)
+				break;
+			j++;
+		}
+
+		tmp = readl(port_mmio + PORT_SCR_ERR);
+		VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
+		writel(tmp, port_mmio + PORT_SCR_ERR);
+
+		/* ack any pending irq events for this port */
+		tmp = readl(port_mmio + PORT_IRQ_STAT);
+		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		if (tmp)
+			writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+		writel(1 << i, mmio + HOST_IRQ_STAT);
+
+		/* set irq mask (enables interrupts) */
+		writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
+	}
+
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
+/* move to PCI layer, integrate w/ MSI stuff */
+static void pci_enable_intx(struct pci_dev *pdev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+	}
+}
+
+static void ahci_print_info(struct ata_probe_ent *probe_ent)
+{
+	struct ahci_host_priv *hpriv = probe_ent->private_data;
+	struct pci_dev *pdev = probe_ent->pdev;
+	void *mmio = probe_ent->mmio_base;
+	u32 vers, cap, impl, speed;
+	const char *speed_s;
+
+	vers = readl(mmio + HOST_VERSION);
+	cap = hpriv->cap;
+	impl = hpriv->port_map;
+
+	speed = (cap >> 20) & 0xf;
+	if (speed == 1)
+		speed_s = "1.5";
+	else if (speed == 2)
+		speed_s = "3";
+	else
+		speed_s = "?";
+
+	printk(KERN_INFO DRV_NAME "(%s) AHCI %02x%02x.%02x%02x "
+		"%u slots %u ports %s Gbps 0x%x impl\n"
+	       	,
+	       	pci_name(pdev),
+
+	       	(vers >> 24) & 0xff,
+	       	(vers >> 16) & 0xff,
+	       	(vers >> 8) & 0xff,
+	       	vers & 0xff,
+
+		((cap >> 8) & 0x1f) + 1,
+		(cap & 0x1f) + 1,
+		speed_s,
+		impl);
+
+	printk(KERN_INFO DRV_NAME "(%s) flags: "
+	       	"%s%s%s%s%s%s"
+	       	"%s%s%s%s%s%s%s\n"
+	       	,
+	       	pci_name(pdev),
+
+		cap & (1 << 31) ? "64bit " : "",
+		cap & (1 << 30) ? "ncq " : "",
+		cap & (1 << 28) ? "ilck " : "",
+		cap & (1 << 27) ? "stag " : "",
+		cap & (1 << 26) ? "pm " : "",
+		cap & (1 << 25) ? "led " : "",
+
+		cap & (1 << 24) ? "clo " : "",
+		cap & (1 << 19) ? "nz " : "",
+		cap & (1 << 18) ? "only " : "",
+		cap & (1 << 17) ? "pmp " : "",
+		cap & (1 << 15) ? "pio " : "",
+		cap & (1 << 14) ? "slum " : "",
+		cap & (1 << 13) ? "part " : ""
+		);
+}
+
+static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version;
+	struct ata_probe_ent *probe_ent = NULL;
+	struct ahci_host_priv *hpriv;
+	unsigned long base;
+	void *mmio_base;
+	unsigned int board_idx = (unsigned int) ent->driver_data;
+	int rc;
+
+	VPRINTK("ENTER\n");
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	/*
+	 * If this driver happens to only be useful on Apple's K2, then
+	 * we should check that here as it has a normal Serverworks ID
+	 */
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+	pci_enable_intx(pdev);
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->pdev = pdev;
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	mmio_base = ioremap(pci_resource_start(pdev, AHCI_PCI_BAR),
+		            pci_resource_len(pdev, AHCI_PCI_BAR));
+	if (mmio_base == NULL) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+	base = (unsigned long) mmio_base;
+
+	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		rc = -ENOMEM;
+		goto err_out_iounmap;
+	}
+	memset(hpriv, 0, sizeof(*hpriv));
+
+	probe_ent->sht		= ahci_port_info[board_idx].sht;
+	probe_ent->host_flags	= ahci_port_info[board_idx].host_flags;
+	probe_ent->pio_mask	= ahci_port_info[board_idx].pio_mask;
+	probe_ent->udma_mask	= ahci_port_info[board_idx].udma_mask;
+	probe_ent->port_ops	= ahci_port_info[board_idx].port_ops;
+
+       	probe_ent->irq = pdev->irq;
+       	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->mmio_base = mmio_base;
+	probe_ent->private_data = hpriv;
+
+	/* initialize adapter */
+	rc = ahci_host_init(probe_ent);
+	if (rc)
+		goto err_out_hpriv;
+
+	ahci_print_info(probe_ent);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+	kfree(probe_ent);
+
+	return 0;
+
+err_out_hpriv:
+	kfree(hpriv);
+err_out_iounmap:
+	iounmap(mmio_base);
+err_out_free_ent:
+	kfree(probe_ent);
+err_out_regions:
+	pci_release_regions(pdev);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+
+static int __init ahci_init(void)
+{
+	return pci_module_init(&ahci_pci_driver);
+}
+
+
+static void __exit ahci_exit(void)
+{
+	pci_unregister_driver(&ahci_pci_driver);
+}
+
+
+MODULE_AUTHOR("Jeff Garzik");
+MODULE_DESCRIPTION("AHCI SATA low-level driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, ahci_pci_tbl);
+
+module_init(ahci_init);
+module_exit(ahci_exit);
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/libata-core.c	2004-10-15 03:08:20 -04:00
@@ -829,17 +829,17 @@
  *	caller.
  */
 
-void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+void ata_dev_id_string(u16 *id, unsigned char *s,
 		       unsigned int ofs, unsigned int len)
 {
 	unsigned int c;
 
 	while (len > 0) {
-		c = dev->id[ofs] >> 8;
+		c = id[ofs] >> 8;
 		*s = c;
 		s++;
 
-		c = dev->id[ofs] & 0xff;
+		c = id[ofs] & 0xff;
 		*s = c;
 		s++;
 
@@ -1082,7 +1082,7 @@
 	 */
 
 	/* we require LBA and DMA support (bits 8 & 9 of word 49) */
-	if (!ata_id_has_dma(dev) || !ata_id_has_lba(dev)) {
+	if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {
 		printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);
 		goto err_out_nosup;
 	}
@@ -1100,7 +1100,7 @@
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
-		if (!ata_id_is_ata(dev))	/* sanity check */
+		if (!ata_id_is_ata(dev->id))	/* sanity check */
 			goto err_out_nosup;
 
 		tmp = dev->id[ATA_ID_MAJOR_VER];
@@ -1114,11 +1114,11 @@
 			goto err_out_nosup;
 		}
 
-		if (ata_id_has_lba48(dev)) {
+		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
-			dev->n_sectors = ata_id_u64(dev, 100);
+			dev->n_sectors = ata_id_u64(dev->id, 100);
 		} else {
-			dev->n_sectors = ata_id_u32(dev, 60);
+			dev->n_sectors = ata_id_u32(dev->id, 60);
 		}
 
 		ap->host->max_cmd_len = 16;
@@ -1133,7 +1133,7 @@
 
 	/* ATAPI-specific feature tests */
 	else {
-		if (ata_id_is_ata(dev))		/* sanity check */
+		if (ata_id_is_ata(dev->id))		/* sanity check */
 			goto err_out_nosup;
 
 		rc = atapi_cdb_len(dev->id);
@@ -1162,6 +1162,49 @@
 	DPRINTK("EXIT, err\n");
 }
 
+
+static inline u8 ata_dev_knobble(struct ata_port *ap)
+{
+	struct ata_device *dev;
+	int i;
+
+	if (ap->cbl != ATA_CBL_SATA)
+		return 0;
+	
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+		if (ata_dev_present(dev) && (!ata_id_is_sata(dev->id)))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * 	ata_dev_config - Run device specific handlers and check for
+ * 			 SATA->PATA bridges
+ * 	@ap: Bus 
+ * 	@i:  Device
+ *
+ * 	LOCKING:
+ */
+ 
+void ata_dev_config(struct ata_port *ap, unsigned int i)
+{
+	/* limit bridge transfers to udma5, 200 sectors */
+	if (ata_dev_knobble(ap)) {
+		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
+			ap->id, ap->device->devno);
+		ap->udma_mask &= ATA_UDMA5;
+		ap->host->max_sectors = ATA_MAX_SECTORS;
+		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
+		ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+	}
+
+	if (ap->ops->dev_config)
+		ap->ops->dev_config(ap, &ap->device[i]);
+}
+
 /**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
@@ -1184,8 +1227,7 @@
 		ata_dev_identify(ap, i);
 		if (ata_dev_present(&ap->device[i])) {
 			found = 1;
-			if (ap->ops->dev_config)
-				ap->ops->dev_config(ap, &ap->device[i]);
+			ata_dev_config(ap,i);
 		}
 	}
 
@@ -1946,7 +1988,7 @@
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
 	sg_dma_len(sg) = buflen;
 
-	WARN_ON(buflen > PAGE_SIZE);
+//    WARN_ON(buflen > PAGE_SIZE);
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -3038,6 +3080,7 @@
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
+	ap->flags |= ent->port_flags[port_no];
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
@@ -3660,6 +3703,8 @@
 EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
+EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_config);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-15 03:08:20 -04:00
@@ -29,14 +29,14 @@
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/hdreg.h>
 #include <asm/uaccess.h>
 
 #include "libata.h"
 
+#define SECTOR_SIZE	512
+
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *));
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev);
 
@@ -70,6 +70,146 @@
 	return 0;
 }
 
+/**
+ *	ata_cmd_ioctl - Handler for HDIO_DRIVE_CMD ioctl
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+
+int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[4], *argbuf = NULL;
+	int argsize = 0;
+	struct scsi_request *sreq;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (copy_from_user(args, arg, sizeof(args)))
+		return -EFAULT;
+
+	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
+	if (!sreq)
+		return -EINTR;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+
+	if (args[3]) {
+		argsize = SECTOR_SIZE * args[3];
+		argbuf = kmalloc(argsize, GFP_KERNEL);
+		if (argbuf == NULL)
+			return -ENOMEM;
+
+		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+		sreq->sr_data_direction = DMA_FROM_DEVICE;
+	} else {
+		scsi_cmd[1]  = (3 << 1); /* Non-data */
+		sreq->sr_data_direction = DMA_NONE;
+	}
+
+	scsi_cmd[0] = ATA_16;
+	scsi_cmd[2] = 0x1f;     /* no off.line or cc, yes all registers */
+
+	scsi_cmd[4] = args[2];
+	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
+		scsi_cmd[6]  = args[3];
+		scsi_cmd[8]  = args[1];
+		scsi_cmd[10] = 0x4f;
+		scsi_cmd[12] = 0xc2;
+	} else {
+		scsi_cmd[6]  = args[1];
+	}
+	scsi_cmd[14] = args[0];
+
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+	if ((argbuf)
+	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
+		rc = -EFAULT;
+error:
+	scsi_release_request(sreq);
+
+	if (argbuf)
+		kfree(argbuf);
+
+	return rc;
+}
+
+/**
+ *	ata_task_ioctl - Handler for HDIO_DRIVE_TASK ioctl
+ *	@dev: Device to whom we are issuing command
+ *	@arg: User provided data for issuing command
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	u8 args[7];
+	struct scsi_request *sreq;
+
+	if (NULL == (void *)arg)
+		return -EINVAL;
+
+	if (copy_from_user(args, arg, sizeof(args)))
+		return -EFAULT;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[1]  = (3 << 1); /* Non-data */
+	scsi_cmd[2]  = 0x1f;     /* no off.line or cc, yes all registers */
+	scsi_cmd[4]  = args[1];
+	scsi_cmd[6]  = args[2];
+	scsi_cmd[8]  = args[3];
+	scsi_cmd[10] = args[4];
+	scsi_cmd[12] = args[5];
+	scsi_cmd[14] = args[0];
+
+	sreq = scsi_allocate_request(scsidev, GFP_KERNEL);
+	if (!sreq) {
+		rc = -EINTR;
+		goto error;
+	}
+
+	sreq->sr_data_direction = DMA_NONE;
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
+
+	if (sreq->sr_result) {
+		rc = -EIO;
+		goto error;
+	}
+
+	/* Need code to retrieve data from check condition? */
+
+error:
+	scsi_release_request(sreq);
+	return rc;
+}
+
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
 	struct ata_port *ap;
@@ -99,6 +239,16 @@
 			return -EINVAL;
 		return 0;
 
+	case HDIO_DRIVE_CMD:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_cmd_ioctl(scsidev, arg);
+
+	case HDIO_DRIVE_TASK:
+		if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			return -EACCES;
+		return ata_task_ioctl(scsidev, arg);
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;
@@ -315,6 +465,85 @@
 	}
 }
 
+/*
+ *	ata_pass_thru_cc - Generate check condition sense block.
+ *	@qc: Command that completed.
+ *
+ *	Regardless of whether the command errored or not, return
+ *	a sense block. Copy all controller registers into
+ *	the sense block. Clear sense key, ASC & ASCQ if
+ *	there is no error.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_pass_thru_cc(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+	unsigned char *desc = sb + 8 ;
+
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq. We will overwrite some
+	 * (many) of the fields later.
+	 *
+	 * TODO: reorganise better, by splitting ata_to_sense_error()
+	 */
+	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc, drv_stat) ;
+	} else {
+		sb[3] = sb[2] = sb[1] = 0x00 ;
+	}
+
+	/*
+	 * Sense data is current and format is
+	 * descriptor.
+	 */
+	sb[0] = 0x72 ;
+
+	desc[0] = 0x8e ;	/* TODO: replace with official value. */
+
+	/*
+	 * Set length of additional sense data.
+	 * Since we only populate descriptor 0, the total
+	 * length is the same (fixed) length as descriptor 0.
+	 */
+	desc[1] = sb[7] = 14 ;
+
+	/*
+	 * Read the controller registers.
+	 */
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Copy registers into sense buffer.
+	 */
+	desc[2] = 0x00 ;
+	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
+	desc[5] = tf->nsect ;
+	desc[7] = tf->lbal ;
+	desc[9] = tf->lbam ;
+	desc[11] = tf->lbah ;
+	desc[12] = tf->device ;
+	desc[13] = drv_stat ;
+
+	/*
+	 * Fill in Extend bit, and the high order bytes
+	 * if applicable.
+	 */
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		desc[2] |= 0x01 ;
+		desc[4] = tf->hob_nsect ;
+		desc[6] = tf->hob_lbal ;
+		desc[8] = tf->hob_lbam ;
+		desc[10] = tf->hob_lbah ;
+	}
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -411,7 +640,7 @@
 	tf->protocol = ATA_PROT_NODATA;
 
 	if ((tf->flags & ATA_TFLAG_LBA48) &&
-	    (ata_id_has_flush_ext(qc->dev)))
+	    (ata_id_has_flush_ext(qc->dev->id)))
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
 		tf->command = ATA_CMD_FLUSH;
@@ -623,10 +852,23 @@
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc, drv_stat);
-	else
-		cmd->result = SAM_STAT_GOOD;
+	/*
+	 * If this was a pass-thru command, and the user requested
+	 * a check condition return including register values.
+	 * Note that check condition is generated, and the ATA
+	 * register values are returned, whether the command completed
+	 * successfully or not. If there was no error, SK, ASC and
+	 * ASCQ will all be zero.
+	 */
+	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
+						(cmd->cmnd[2] & 0x20)) {
+		ata_pass_thru_cc(qc, drv_stat) ;
+	} else {
+		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
+			ata_to_sense_error(qc, drv_stat);
+		else
+			cmd->result = SAM_STAT_GOOD;
+	}
 
 	qc->scsidone(cmd);
 
@@ -688,7 +930,6 @@
 
 	if (xlat_func(qc, scsicmd))
 		goto err_out;
-
 	/* select device, send command to hardware */
 	if (ata_qc_issue(qc))
 		goto err_out;
@@ -757,7 +998,7 @@
 
 /**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@actor: Callback hook for desired SCSI command simulator
  *
  *	Takes care of the hard work of simulating a SCSI command...
@@ -793,7 +1034,7 @@
 
 /**
  *	ata_scsiop_inq_std - Simulate INQUIRY command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -807,8 +1048,6 @@
 unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen)
 {
-	struct ata_device *dev = args->dev;
-
 	u8 hdr[] = {
 		TYPE_DISK,
 		0,
@@ -818,7 +1057,7 @@
 	};
 
 	/* set scsi removeable (RMB) bit per ata bit */
-	if (ata_id_removeable(dev))
+	if (ata_id_removeable(args->id))
 		hdr[1] |= (1 << 7);
 
 	VPRINTK("ENTER\n");
@@ -827,8 +1066,8 @@
 
 	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_dev_id_string(dev, &rbuf[16], ATA_ID_PROD_OFS, 16);
-		ata_dev_id_string(dev, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
+		ata_dev_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
+		ata_dev_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
 		if (rbuf[32] == 0 || rbuf[32] == ' ')
 			memcpy(&rbuf[32], "n/a ", 4);
 	}
@@ -852,7 +1091,7 @@
 
 /**
  *	ata_scsiop_inq_00 - Simulate INQUIRY EVPD page 0, list of pages
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -880,7 +1119,7 @@
 
 /**
  *	ata_scsiop_inq_80 - Simulate INQUIRY EVPD page 80, device serial number
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -902,7 +1141,7 @@
 	memcpy(rbuf, hdr, sizeof(hdr));
 
 	if (buflen > (ATA_SERNO_LEN + 4))
-		ata_dev_id_string(args->dev, (unsigned char *) &rbuf[4],
+		ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
 				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
 	return 0;
@@ -912,7 +1151,7 @@
 
 /**
  *	ata_scsiop_inq_83 - Simulate INQUIRY EVPD page 83, device identity
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -941,7 +1180,7 @@
 
 /**
  *	ata_scsiop_noop -
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -989,7 +1228,7 @@
 
 /**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
- *	@dev: Device associated with this MODE SENSE command
+ *	@id: device IDENTIFY data
  *	@ptr_io: (input/output) Location to store more output data
  *	@last: End of output data buffer
  *
@@ -1001,7 +1240,7 @@
  *	None.
  */
 
-static unsigned int ata_msense_caching(struct ata_device *dev, u8 **ptr_io,
+static unsigned int ata_msense_caching(u16 *id, u8 **ptr_io,
 				       const u8 *last)
 {
 	u8 page[] = {
@@ -1011,9 +1250,9 @@
 		0, 0, 0, 0, 0, 0, 0, 0		/* 8 zeroes */
 	};
 
-	if (ata_id_wcache_enabled(dev))
+	if (ata_id_wcache_enabled(id))
 		page[2] |= (1 << 2);	/* write cache enable */
-	if (!ata_id_rahead_enabled(dev))
+	if (!ata_id_rahead_enabled(id))
 		page[12] |= (1 << 5);	/* disable read ahead */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
@@ -1067,7 +1306,7 @@
 
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1081,7 +1320,6 @@
 				  unsigned int buflen)
 {
 	u8 *scsicmd = args->cmd->cmnd, *p, *last;
-	struct ata_device *dev = args->dev;
 	unsigned int page_control, six_byte, output_len;
 
 	VPRINTK("ENTER\n");
@@ -1109,7 +1347,7 @@
 		break;
 
 	case 0x08:		/* caching */
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		break;
 
 	case 0x0a: {		/* control mode */
@@ -1119,7 +1357,7 @@
 
 	case 0x3f:		/* all pages */
 		output_len += ata_msense_rw_recovery(&p, last);
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		output_len += ata_msense_ctl_mode(&p, last);
 		break;
 
@@ -1141,7 +1379,7 @@
 
 /**
  *	ata_scsiop_read_cap - Simulate READ CAPACITY[ 16] commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1154,11 +1392,15 @@
 unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf,
 			        unsigned int buflen)
 {
-	u64 n_sectors = args->dev->n_sectors;
+	u64 n_sectors;
 	u32 tmp;
 
 	VPRINTK("ENTER\n");
 
+	if (ata_id_has_lba48(args->id))
+		n_sectors = ata_id_u64(args->id, 100);
+	else
+		n_sectors = ata_id_u32(args->id, 60);
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
 	tmp = n_sectors;	/* note: truncates, if lba48 */
@@ -1196,7 +1438,7 @@
 
 /**
  *	ata_scsiop_report_luns - Simulate REPORT LUNS command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1368,6 +1610,135 @@
 	return dev;
 }
 
+/*
+ *	ata_scsi_map_proto - Map pass-thru protocol value to taskfile value.
+ *	@byte1: Byte 1 from pass-thru CDB.
+ *
+ *	RETURNS:
+ *	ATA_PROT_UNKNOWN if mapping failed/unimplemented, protocol otherwise.
+ */
+static u8
+ata_scsi_map_proto(u8 byte1)
+{
+	switch((byte1 & 0x1e) >> 1) {
+		case 3:		/* Non-data */
+			return ATA_PROT_NODATA;
+
+		case 6:		/* DMA */
+			return ATA_PROT_DMA;
+
+		case 4:		/* PIO Data-in */
+		case 5:		/* PIO Data-out */
+			if (byte1 & 0xe0) {
+				return ATA_PROT_PIO_MULT;
+			}
+			return ATA_PROT_PIO;
+
+		case 10:	/* Device Reset */
+		case 0:		/* Hard Reset */
+		case 1:		/* SRST */
+		case 2:		/* Bus Idle */
+		case 7:		/* Packet */
+		case 8:		/* DMA Queued */
+		case 9:		/* Device Diagnostic */
+		case 11:	/* UDMA Data-in */
+		case 12:	/* UDMA Data-Out */
+		case 13:	/* FPDMA */
+		default:	/* Reserved */
+			break;
+	}
+
+	return ATA_PROT_UNKNOWN;
+}
+
+/**
+ *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
+ *	@qc: command structure to be initialized
+ *	@cmd: SCSI command to convert
+ *
+ *	Handles either 12 or 16-byte versions of the CDB.
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on failure.
+ */
+static unsigned int
+ata_scsi_pass_thru(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &(qc->tf);
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN) {
+		return 1;
+	}
+
+	/*
+	 * 12 and 16 byte CDBs use different offsets to
+	 * provide the various register values.
+	 */
+	if (scsicmd[0] == ATA_16) {
+		/*
+		 * 16-byte CDB - may contain extended commands.
+		 *
+		 * If that is the case, copy the upper byte register values.
+		 */
+		if (scsicmd[1] & 0x01) {
+			tf->hob_feature = scsicmd[3];
+			tf->hob_nsect = scsicmd[5];
+			tf->hob_lbal = scsicmd[7];
+			tf->hob_lbam = scsicmd[9];
+			tf->hob_lbah = scsicmd[11];
+			tf->flags |= ATA_TFLAG_LBA48 ;
+		} else {
+			tf->flags &= ~ATA_TFLAG_LBA48 ;
+		}
+
+		/*
+		 * Always copy low byte, device and command registers.
+		 */
+		tf->feature = scsicmd[4];
+		tf->nsect = scsicmd[6];
+		tf->lbal = scsicmd[8];
+		tf->lbam = scsicmd[10];
+		tf->lbah = scsicmd[12];
+		tf->device = scsicmd[13];
+		tf->command = scsicmd[14];
+	} else {
+		/*
+		 * 12-byte CDB - incapable of extended commands.
+		 */
+		tf->flags &= ~ATA_TFLAG_LBA48 ;
+
+		tf->feature = scsicmd[3];
+		tf->nsect = scsicmd[4];
+		tf->lbal = scsicmd[5];
+		tf->lbam = scsicmd[6];
+		tf->lbah = scsicmd[7];
+		tf->device = scsicmd[8];
+		tf->command = scsicmd[9];
+	}
+
+	/*
+	 * Set flags so that all registers will be written,
+	 * and pass on write indication (used for PIO/DMA
+	 * setup.)
+	 */
+	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE) ;
+
+	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
+		tf->flags |= ATA_TFLAG_WRITE;
+	}
+
+	/*
+	 * Set transfer length.
+	 *
+	 * TODO: find out if we need to do more here to
+	 *       cover scatter/gather case.
+	 */
+	qc->nsect = cmd->bufflen / ATA_SECT_SIZE ;
+
+	return 0;
+}
+
 /**
  *	ata_get_xlat_func - check if SCSI to ATA translation is possible
  *	@dev: ATA device
@@ -1400,6 +1771,10 @@
 	case VERIFY:
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
+
+	case ATA_12:
+	case ATA_16:
+		return ata_scsi_pass_thru ;
 	}
 
 	return NULL;
@@ -1472,7 +1847,7 @@
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
 		else
-			ata_scsi_simulate(ap, dev, cmd, done);
+			ata_scsi_simulate(dev->id, cmd, done);
 	} else
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
@@ -1482,8 +1857,7 @@
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@ap: Port to which ATA device is attached.
- *	@dev: Target device for CDB.
+ *	@id: current IDENTIFY data for target device.
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
@@ -1494,15 +1868,14 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *))
+void ata_scsi_simulate(u16 *id,
+		      struct scsi_cmnd *cmd,
+		      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_scsi_args args;
 	u8 *scsicmd = cmd->cmnd;
 
-	args.ap = ap;
-	args.dev = dev;
+	args.id = id;
 	args.cmd = cmd;
 	args.done = done;
 
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/libata.h	2004-10-15 03:08:20 -04:00
@@ -29,9 +29,8 @@
 #define DRV_VERSION	"1.02"	/* must be exactly four chars */
 
 struct ata_scsi_args {
-	struct ata_port		*ap;
-	struct ata_device	*dev;
-	struct scsi_cmnd		*cmd;
+	u16			*id;
+	struct scsi_cmnd	*cmd;
 	void			(*done)(struct scsi_cmnd *);
 };
 
@@ -43,6 +42,8 @@
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
+extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
 
 /* libata-scsi.c */
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-10-15 03:08:20 -04:00
@@ -79,6 +79,8 @@
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
 static void pdc_phy_reset(struct ata_port *ap);
+static void pdc_pata_phy_reset(struct ata_port *ap);
+static void pdc_pata_cbl_detect(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
@@ -127,7 +129,7 @@
 	/* board_2037x */
 	{
 		.sht		= &pdc_sata_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+		.host_flags	= /* ATA_FLAG_SATA | */ ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
@@ -244,7 +246,35 @@
 static void pdc_phy_reset(struct ata_port *ap)
 {
 	pdc_reset_port(ap);
-	sata_phy_reset(ap);
+	if (ap->flags & ATA_FLAG_SATA)
+		sata_phy_reset(ap);
+	else
+		pdc_pata_phy_reset(ap);
+}
+
+static void pdc_pata_cbl_detect(struct ata_port *ap)
+{
+	u8 tmp;
+	void *mmio = (void *) ap->ioaddr.cmd_addr + PDC_CTLSTAT + 0x03;
+
+	tmp = readb(mmio);
+	
+	if (tmp & 0x01)
+	{
+		ap->cbl = ATA_CBL_PATA40;
+		ap->udma_mask &= ATA_UDMA_MASK_40C;
+	}
+	else
+		ap->cbl = ATA_CBL_PATA80;
+}
+		
+static void pdc_pata_phy_reset(struct ata_port *ap)
+{
+	pdc_pata_cbl_detect(ap);
+
+	ata_port_probe(ap);
+	
+	ata_bus_reset(ap);
 }
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
@@ -547,6 +577,7 @@
 	void *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int rc;
+	u8 tmp;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -605,6 +636,9 @@
 	probe_ent->port[0].scr_addr = base + 0x400;
 	probe_ent->port[1].scr_addr = base + 0x500;
 
+	probe_ent->port_flags[0] = ATA_FLAG_SATA;
+	probe_ent->port_flags[1] = ATA_FLAG_SATA;
+	
 	/* notice 4-port boards */
 	switch (board_idx) {
 	case board_20319:
@@ -615,9 +649,25 @@
 
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
+	
+		probe_ent->port_flags[2] = ATA_FLAG_SATA;
+		probe_ent->port_flags[3] = ATA_FLAG_SATA;
 		break;
 	case board_2037x:
-       		probe_ent->n_ports = 2;
+		/* Some boards have also PATA port */
+		tmp = readb(base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80))
+		{
+			probe_ent->n_ports = 3;
+			
+			pdc_sata_setup_port(&probe_ent->port[2], base + 0x300);
+
+			probe_ent->port_flags[2] = ATA_FLAG_SLAVE_POSS;
+			
+			printk(KERN_INFO DRV_NAME " PATA port found\n");
+		}
+		else
+       			probe_ent->n_ports = 2;
 		break;
 	default:
 		BUG();
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-10-15 03:08:20 -04:00
@@ -287,7 +287,7 @@
 	const char *s;
 	unsigned int len;
 
-	ata_dev_id_string(dev, model_num, ATA_ID_PROD_OFS,
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-10-15 03:08:20 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-10-15 03:08:20 -04:00
@@ -333,6 +333,14 @@
 
 	pci_set_master(pdev);
 
+	/* 
+	 * Config offset 0x98 is "Extended Control and Status Register 0"
+	 * Default value is (1 << 28).  All bits except bit 28 are reserved in
+	 * DPA mode.  If bit 28 is set, LED 0 reflects all ports' activity.
+	 * If bit 28 is clear, each port has its own LED.
+	 */
+	pci_write_config_dword(pdev, 0x98, 0);
+
 	/* FIXME: check ata_device_add return value */
 	ata_device_add(probe_ent);
 	kfree(probe_ent);
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-10-15 03:08:20 -04:00
+++ b/include/linux/ata.h	2004-10-15 03:08:20 -04:00
@@ -217,24 +217,25 @@
 	u8			command;	/* IO operation */
 };
 
-#define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
-#define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
-#define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
-#define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
-#define ata_id_has_flush_ext(dev) ((dev)->id[83] & (1 << 13))
-#define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
-#define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
-#define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
-#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 9))
-#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 8))
-#define ata_id_removeable(dev)	((dev)->id[0] & (1 << 7))
-#define ata_id_u32(dev,n)	\
-	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
-#define ata_id_u64(dev,n)	\
-	( ((u64) dev->id[(n) + 3] << 48) |	\
-	  ((u64) dev->id[(n) + 2] << 32) |	\
-	  ((u64) dev->id[(n) + 1] << 16) |	\
-	  ((u64) dev->id[(n) + 0]) )
+#define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(id)	((id)[93] == 0)
+#define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
+#define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
+#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
+#define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
+#define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
+#define ata_id_has_pm(id)	((id)[82] & (1 << 3))
+#define ata_id_has_lba(id)	((id)[49] & (1 << 9))
+#define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_u32(id,n)	\
+	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
+#define ata_id_u64(id,n)	\
+	( ((u64) (id)[(n) + 3] << 48) |	\
+	  ((u64) (id)[(n) + 2] << 32) |	\
+	  ((u64) (id)[(n) + 1] << 16) |	\
+	  ((u64) (id)[(n) + 0]) )
 
 static inline int atapi_cdb_len(u16 *dev_id)
 {
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-15 03:08:20 -04:00
+++ b/include/linux/libata.h	2004-10-15 03:08:20 -04:00
@@ -197,6 +197,7 @@
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
+	unsigned long		port_flags[ATA_MAX_PORTS];
 	void __iomem		*mmio_base;
 	void			*private_data;
 };
@@ -405,8 +406,9 @@
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
-extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+extern void ata_dev_id_string(u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
@@ -417,7 +419,9 @@
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
-
+extern void ata_scsi_simulate(u16 *id,
+			      struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *));
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
@@ -615,9 +619,9 @@
 
 static inline int ata_try_flush_cache(struct ata_device *dev)
 {
-	return ata_id_wcache_enabled(dev) ||
-	       ata_id_has_flush(dev) ||
-	       ata_id_has_flush_ext(dev);
+	return ata_id_wcache_enabled(dev->id) ||
+	       ata_id_has_flush(dev->id) ||
+	       ata_id_has_flush_ext(dev->id);
 }
 
 #endif /* __LINUX_LIBATA_H__ */
diff -Nru a/include/scsi/scsi.h b/include/scsi/scsi.h
--- a/include/scsi/scsi.h	2004-10-15 03:08:20 -04:00
+++ b/include/scsi/scsi.h	2004-10-15 03:08:20 -04:00
@@ -113,6 +113,9 @@
 /* values for service action in */
 #define	SAI_READ_CAPACITY_16  0x10
 
+/* Temporary values for T10/04-262 until official values are allocated */
+#define	ATA_16		      0x85	/* 16-byte pass-thru [0x85 == unused]*/
+#define	ATA_12		      0xb3	/* 12-byte pass-thru [0xb3 == obsolete set limits command] */
 
 /*
  *  SCSI Architecture Model (SAM) Status codes. Taken from SAM-3 draft
