Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUCRSim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbUCRSim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:38:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262872AbUCRSeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:34:50 -0500
Message-ID: <4059EBB8.4010807@pobox.com>
Date: Thu, 18 Mar 2004 13:34:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH,RFT] latest libata (includes Silicon Image work)
Content-Type: multipart/mixed;
 boundary="------------060404020804060107060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060404020804060107060906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Attached is the latest libata patch against 2.6.x mainline.  Although 
not 100% of content, most of this patch resolves around getting Silicon 
Image into better shape.  As I mentioned in my last post, this patch 
affects all libata users, so plenty of testing is requested.

Silicon Image-related changes:

* Only set/clear the BMDMA bits we care about (got a report last night 
this fixed 3114 for him)

* mask all SATA interrupts

* after determining drive speed, write that information to a special SII 
register Data Transfer Mode

* (style) make port base address setup a loop, shortening the code and 
making the code more readable

* limit SII to UDMA5 (reading info on FreeBSD lists and source code 
scared me about chip errata), mainly related to PATA->SATA bridges.



--------------060404020804060107060906
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/ata_piix.c	Thu Mar 18 13:28:00 2004
@@ -16,7 +16,7 @@
     May be copied or modified under the terms of the GNU General Public License
 
  */
-#include <linux/config.h>
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -125,7 +125,6 @@
 	.exec_command		= ata_exec_command_pio,
 
 	.phy_reset		= piix_pata_phy_reset,
-	.phy_config		= pata_phy_config,
 
 	.bmdma_start		= ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
@@ -148,7 +147,6 @@
 	.exec_command		= ata_exec_command_pio,
 
 	.phy_reset		= piix_sata_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
 
 	.bmdma_start		= ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/libata-core.c	Thu Mar 18 13:28:00 2004
@@ -58,6 +58,7 @@
 static void ata_host_set_udma(struct ata_port *ap);
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
 static void ata_dev_set_udma(struct ata_port *ap, unsigned int device);
+static void ata_set_mode(struct ata_port *ap);
 
 static unsigned int ata_unique_id = 1;
 
@@ -1031,7 +1032,7 @@
 	if ((!found) || (ap->flags & ATA_FLAG_PORT_DISABLED))
 		goto err_out_disable;
 
-	ap->ops->phy_config(ap);
+	ata_set_mode(ap);
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out_disable;
 
@@ -1120,13 +1121,13 @@
 }
 
 /**
- *	pata_phy_config -
- *	@ap:
+ *	ata_set_mode - Program timings and issue SET FEATURES - XFER
+ *	@ap: port on which timings will be programmed
  *
  *	LOCKING:
  *
  */
-void pata_phy_config(struct ata_port *ap)
+static void ata_set_mode(struct ata_port *ap)
 {
 	unsigned int force_pio;
 
@@ -1158,6 +1159,8 @@
 			return;
 	}
 
+	if (ap->ops->post_set_mode)
+		ap->ops->post_set_mode(ap);
 }
 
 /**
@@ -2263,9 +2266,12 @@
 	mb();	/* make sure PRD table writes are visible to controller */
 	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
 
-	/* specify data direction */
-	/* FIXME: redundant to later start-dma command? */
-	writeb(rw ? 0 : ATA_DMA_WR, mmio + ATA_DMA_CMD);
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	writeb(dmactl, mmio + ATA_DMA_CMD);
 
 	/* clear interrupt, error bits */
 	host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2275,7 +2281,6 @@
 	ap->ops->exec_command(ap, &qc->tf);
 
 	/* start host DMA transaction */
-	dmactl = readb(mmio + ATA_DMA_CMD);
 	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
 
 	/* Strictly, one may wish to issue a readb() here, to
@@ -2308,9 +2313,12 @@
 	/* load PRD table addr. */
 	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
 
-	/* specify data direction */
-	/* FIXME: redundant to later start-dma command? */
-	outb(rw ? 0 : ATA_DMA_WR, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* clear interrupt, error bits */
 	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
@@ -2321,7 +2329,6 @@
 	ap->ops->exec_command(ap, &qc->tf);
 
 	/* start host DMA transaction */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	outb(dmactl | ATA_DMA_START,
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
@@ -2344,14 +2351,16 @@
 		void *mmio = (void *) ap->ioaddr.bmdma_addr;
 
 		/* clear start/stop bit */
-		writeb(0, mmio + ATA_DMA_CMD);
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+		       mmio + ATA_DMA_CMD);
 
 		/* ack intr, err bits */
 		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
 		       mmio + ATA_DMA_STATUS);
 	} else {
 		/* clear start/stop bit */
-		outb(0, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+		     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 		/* ack intr, err bits */
 		outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
@@ -3381,7 +3390,6 @@
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
-EXPORT_SYMBOL_GPL(pata_phy_config);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/sata_promise.c	Thu Mar 18 13:28:00 2004
@@ -21,7 +21,6 @@
  *
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -201,7 +200,6 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
 	.bmdma_start            = pdc_dma_start,
 	.fill_sg		= pdc_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
@@ -219,7 +217,6 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_20621_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
 	.bmdma_start            = pdc20621_dma_start,
 	.fill_sg		= pdc20621_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/sata_sil.c	Thu Mar 18 13:28:00 2004
@@ -22,7 +22,6 @@
  *
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -50,27 +49,9 @@
 	SIL_MASK_4PORT		= SIL_MASK_2PORT |
 				  SIL_MASK_IDE2_INT | SIL_MASK_IDE3_INT,
 
-	SIL_IDE0_TF		= 0x80,
-	SIL_IDE0_CTL		= 0x8A,
-	SIL_IDE0_BMDMA		= 0x00,
-	SIL_IDE0_SCR		= 0x100,
-
-	SIL_IDE1_TF		= 0xC0,
-	SIL_IDE1_CTL		= 0xCA,
-	SIL_IDE1_BMDMA		= 0x08,
-	SIL_IDE1_SCR		= 0x180,
-
-	SIL_IDE2_TF		= 0x280,
-	SIL_IDE2_CTL		= 0x28A,
 	SIL_IDE2_BMDMA		= 0x200,
-	SIL_IDE2_SCR		= 0x300,
-	SIL_INTR_STEERING	= (1 << 1),
-
-	SIL_IDE3_TF		= 0x2C0,
-	SIL_IDE3_CTL		= 0x2CA,
-	SIL_IDE3_BMDMA		= 0x208,
-	SIL_IDE3_SCR		= 0x380,
 
+	SIL_INTR_STEERING	= (1 << 1),
 	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
@@ -79,6 +60,7 @@
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void sil_post_set_mode (struct ata_port *ap);
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
@@ -142,7 +124,7 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= ata_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
+	.post_set_mode		= sil_post_set_mode,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
@@ -160,7 +142,7 @@
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x03,			/* pio3-4 */
-		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
 	{
@@ -168,16 +150,61 @@
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x03,			/* pio3-4 */
-		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
 	},
 };
 
+/* per-port register offsets */
+/* TODO: we can probably calculate rather than use a table */
+static const struct {
+	unsigned long tf;	/* ATA taskfile register block */
+	unsigned long ctl;	/* ATA control/altstatus register block */
+	unsigned long bmdma;	/* DMA register block */
+	unsigned long scr;	/* SATA control register block */
+	unsigned long sien;	/* SATA Interrupt Enable register */
+	unsigned long xfer_mode;/* data transfer mode register */
+} sil_port[] = {
+	/* port 0 ... */
+	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
+	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
+	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
+	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
+	/* ... port 3 */
+};
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 
+static void sil_post_set_mode (struct ata_port *ap)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct ata_device *dev;
+	void *addr = host_set->mmio_base + sil_port[ap->port_no].xfer_mode;
+	u32 tmp, dev_mode[2];
+	unsigned int i;
+
+	for (i = 0; i < 2; i++) {
+		dev = &ap->device[i];
+		if (!ata_dev_present(dev))
+			dev_mode[i] = 0;	/* PIO0/1/2 */
+		else if (dev->flags & ATA_DFLAG_PIO)
+			dev_mode[i] = 1;	/* PIO3/4 */
+		else
+			dev_mode[i] = 3;	/* UDMA */
+		/* value 2 indicates MDMA */
+	}
+
+	tmp = readl(addr);
+	tmp &= ~((1<<5) | (1<<4) | (1<<1) | (1<<0));
+	tmp |= dev_mode[0];
+	tmp |= (dev_mode[1] << 4);
+	writel(tmp, addr);
+	readl(addr);	/* flush */
+}
+
 static inline unsigned long sil_scr_addr(struct ata_port *ap, unsigned int sc_reg)
 {
 	unsigned long offset = ap->ioaddr.scr_addr;
@@ -283,6 +310,7 @@
 	unsigned long base;
 	void *mmio_base;
 	int rc;
+	unsigned int i;
 	u32 tmp, irq_mask;
 
 	if (!printed_version++)
@@ -332,35 +360,17 @@
 	probe_ent->mmio_base = mmio_base;
 
 	base = (unsigned long) mmio_base;
-	probe_ent->port[0].cmd_addr = base + SIL_IDE0_TF;
-	probe_ent->port[0].altstatus_addr =
-	probe_ent->port[0].ctl_addr = base + SIL_IDE0_CTL;
-	probe_ent->port[0].bmdma_addr = base + SIL_IDE0_BMDMA;
-	probe_ent->port[0].scr_addr = base + SIL_IDE0_SCR;
-	ata_std_ports(&probe_ent->port[0]);
-
-	probe_ent->port[1].cmd_addr = base + SIL_IDE1_TF;
-	probe_ent->port[1].altstatus_addr =
-	probe_ent->port[1].ctl_addr = base + SIL_IDE1_CTL;
-	probe_ent->port[1].bmdma_addr = base + SIL_IDE1_BMDMA;
-	probe_ent->port[1].scr_addr = base + SIL_IDE1_SCR;
-	ata_std_ports(&probe_ent->port[1]);
 
-	if (ent->driver_data == sil_3114) {
-		probe_ent->port[2].cmd_addr = base + SIL_IDE2_TF;
-		probe_ent->port[2].altstatus_addr =
-		probe_ent->port[2].ctl_addr = base + SIL_IDE2_CTL;
-		probe_ent->port[2].bmdma_addr = base + SIL_IDE2_BMDMA;
-		probe_ent->port[2].scr_addr = base + SIL_IDE2_SCR;
-		ata_std_ports(&probe_ent->port[2]);
-
-		probe_ent->port[3].cmd_addr = base + SIL_IDE3_TF;
-		probe_ent->port[3].altstatus_addr =
-		probe_ent->port[3].ctl_addr = base + SIL_IDE3_CTL;
-		probe_ent->port[3].bmdma_addr = base + SIL_IDE3_BMDMA;
-		probe_ent->port[3].scr_addr = base + SIL_IDE3_SCR;
-		ata_std_ports(&probe_ent->port[3]);
+	for (i = 0; i < probe_ent->n_ports; i++) {
+		probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
+		probe_ent->port[i].altstatus_addr =
+		probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
+		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
+		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
+		ata_std_ports(&probe_ent->port[i]);
+	}
 
+	if (ent->driver_data == sil_3114) {
 		irq_mask = SIL_MASK_4PORT;
 
 		/* flip the magic "make 4 ports work" bit */
@@ -380,6 +390,11 @@
 		writel(tmp, mmio_base + SIL_SYSCFG);
 		readl(mmio_base + SIL_SYSCFG);	/* flush */
 	}
+
+	/* mask all SATA phy-related interrupts */
+	/* TODO: unmask bit 6 (SError N bit) for hotplug */
+	for (i = 0; i < probe_ent->n_ports; i++)
+		writel(0, mmio_base + sil_port[i].sien);
 
 	pci_set_master(pdev);
 
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/sata_svw.c	Thu Mar 18 13:28:00 2004
@@ -226,7 +226,6 @@
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/sata_via.c	Thu Mar 18 13:28:00 2004
@@ -22,7 +22,6 @@
 
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -32,19 +31,31 @@
 #include "scsi.h"
 #include "hosts.h"
 #include <linux/libata.h>
+#include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"0.11"
+#define DRV_VERSION	"0.20"
 
 enum {
 	via_sata		= 0,
+
+	SATA_CHAN_ENAB		= 0x40,
+	SATA_INT_GATE		= 0x41,
+	SATA_NATIVE_MODE	= 0x42,
+
+	PORT0			= (1 << 1),
+	PORT1			= (1 << 0),
+
+	ENAB_ALL		= PORT0 | PORT1,
+
+	INT_GATE_ALL		= PORT0 | PORT1,
+
+	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void svia_sata_phy_reset(struct ata_port *ap);
-static void svia_port_disable(struct ata_port *ap);
-
-static unsigned int in_module_init = 1;
+static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
@@ -78,15 +89,14 @@
 };
 
 static struct ata_port_operations svia_sata_ops = {
-	.port_disable		= svia_port_disable,
+	.port_disable		= ata_port_disable,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
 	.check_status		= ata_check_status_pio,
 	.exec_command		= ata_exec_command_pio,
 
-	.phy_reset		= svia_sata_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
+	.phy_reset		= sata_phy_reset,
 
 	.bmdma_start            = ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
@@ -94,70 +104,45 @@
 
 	.irq_handler		= ata_interrupt,
 
+	.scr_read		= svia_scr_read,
+	.scr_write		= svia_scr_write,
+
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
 };
 
-static struct ata_port_info svia_port_info[] = {
-	/* via_sata */
-	{
-		.sht		= &svia_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY
-				  | ATA_FLAG_SRST,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
-		.port_ops	= &svia_sata_ops,
-	},
-};
-
-static struct pci_bits svia_enable_bits[] = {
-	{ 0x40U, 1U, 0x02UL, 0x02UL },	/* port 0 */
-	{ 0x40U, 1U, 0x01UL, 0x01UL },	/* port 1 */
-};
-
-
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("SCSI low-level driver for VIA SATA controllers");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, svia_pci_tbl);
 
-/**
- *	svia_sata_phy_reset -
- *	@ap:
- *
- *	LOCKING:
- *
- */
-
-static void svia_sata_phy_reset(struct ata_port *ap)
+static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &svia_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return;
-	}
+	if (sc_reg > SCR_CONTROL)
+		return 0xffffffffU;
+	return inl(ap->ioaddr.scr_addr + (4 * sc_reg));
+}
 
-	ata_port_probe(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	if (sc_reg > SCR_CONTROL)
 		return;
-
-	ata_bus_reset(ap);
+	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
-/**
- *	svia_port_disable -
- *	@ap:
- *
- *	LOCKING:
- *
- */
+static const unsigned int svia_bar_sizes[] = {
+	8, 4, 8, 4, 16, 256
+};
 
-static void svia_port_disable(struct ata_port *ap)
+static unsigned long svia_scr_addr(unsigned long addr, unsigned int port)
 {
-	ata_port_disable(ap);
+	if (port >= 4)
+		return 0;	/* invalid port */
 
-	/* FIXME */
+	addr &= ~((1 << 7) | (1 << 6));
+	addr |= ((unsigned long)port << 6);
+
+	return addr;
 }
 
 /**
@@ -174,19 +159,124 @@
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info *port_info[1];
-	unsigned int n_ports = 1;
+	unsigned int i;
+	int rc;
+	struct ata_probe_ent *probe_ent;
+	u8 tmp8;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
-	/* no hotplugging support (FIXME) */
-	if (!in_module_init)
-		return -ENODEV;
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+
+	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
+		if ((pci_resource_start(pdev, i) == 0) ||
+		    (pci_resource_len(pdev, i) < svia_bar_sizes[i])) {
+			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
+			       pci_name(pdev), i,
+			       pci_resource_start(pdev, i),
+			       pci_resource_len(pdev, i));
+			rc = -ENODEV;
+			goto err_out_regions;
+		}
+
+	rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+	if (rc)
+		goto err_out_regions;
+	rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+	if (rc)
+		goto err_out_regions;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent) {
+		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
+		       pci_name(pdev));
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	INIT_LIST_HEAD(&probe_ent->node);
+	probe_ent->pdev = pdev;
+	probe_ent->sht = &svia_sht;
+	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+				ATA_FLAG_NO_LEGACY;
+	probe_ent->port_ops = &svia_sata_ops;
+	probe_ent->n_ports = 2;
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->pio_mask = 0x1f;
+	probe_ent->udma_mask = 0x7f;
+
+	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+	ata_std_ports(&probe_ent->port[0]);
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr =
+		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+	probe_ent->port[0].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 0);
+
+	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+	ata_std_ports(&probe_ent->port[1]);
+	probe_ent->port[1].altstatus_addr =
+	probe_ent->port[1].ctl_addr =
+		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+	probe_ent->port[1].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 1);
+
+	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
+	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
+	       pci_name(pdev),
+	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
+
+	/* make sure SATA channels are enabled */
+	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
+	if ((tmp8 & ENAB_ALL) != ENAB_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= ENAB_ALL;
+		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
+	}
+
+	/* make sure interrupts for each channel sent to us */
+	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
+	if ((tmp8 & INT_GATE_ALL) != INT_GATE_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= INT_GATE_ALL;
+		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
+	}
+
+	/* make sure native mode is enabled */
+	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
+	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel native mode (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= NATIVE_MODE_ALL;
+		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
+	}
 
-	port_info[0] = &svia_port_info[ent->driver_data];
+	pci_set_master(pdev);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+	kfree(probe_ent);
+
+	return 0;
 
-	return ata_pci_init_one(pdev, port_info, n_ports);
+err_out_regions:
+	pci_release_regions(pdev);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
 }
 
 /**
@@ -200,17 +290,7 @@
 
 static int __init svia_init(void)
 {
-	int rc;
-
-	DPRINTK("pci_module_init\n");
-	rc = pci_module_init(&svia_pci_driver);
-	if (rc)
-		return rc;
-
-	in_module_init = 0;
-
-	DPRINTK("done\n");
-	return 0;
+	return pci_module_init(&svia_pci_driver);
 }
 
 /**
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	Thu Mar 18 13:28:00 2004
+++ b/drivers/scsi/sata_vsc.c	Thu Mar 18 13:28:00 2004
@@ -207,7 +207,6 @@
 	.exec_command		= ata_exec_command_mmio,
 	.check_status		= ata_check_status_mmio,
 	.phy_reset		= sata_phy_reset,
-	.phy_config		= pata_phy_config,	/* not a typo */
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
@@ -268,10 +267,10 @@
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
-	rc = pci_set_dma_mask(pdev, 0xFFFFFFFF);
+	rc = pci_set_dma_mask(pdev, 0xFFFFFFFFULL);
 	if (rc)
 		goto err_out_regions;
-	rc = pci_set_consistent_dma_mask(pdev, 0xFFFFFFFF);
+	rc = pci_set_consistent_dma_mask(pdev, 0xFFFFFFFFULL);
 	if (rc)
 		goto err_out_regions;
 
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Thu Mar 18 13:28:00 2004
+++ b/include/linux/libata.h	Thu Mar 18 13:28:00 2004
@@ -362,7 +362,7 @@
 	u8   (*check_status)(struct ata_port *ap);
 
 	void (*phy_reset) (struct ata_port *ap);
-	void (*phy_config) (struct ata_port *ap);
+	void (*post_set_mode) (struct ata_port *ap);
 
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 	void (*fill_sg) (struct ata_queued_cmd *qc);
@@ -396,7 +396,6 @@
 };
 
 extern void ata_port_probe(struct ata_port *);
-extern void pata_phy_config(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 extern void ata_port_disable(struct ata_port *);

--------------060404020804060107060906--

