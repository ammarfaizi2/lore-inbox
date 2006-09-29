Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161832AbWI2RSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161832AbWI2RSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161831AbWI2RSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:18:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28368 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161832AbWI2RSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:18:17 -0400
Subject: [PATCH] libata: test driver for Marvell PATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 18:43:29 +0100
Message-Id: <1159551809.13029.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should drive the Marvell PATA (and first two SATA ports) but I
don't have hardware to test so give it a spin. Currently it'll probably
clash with the AHCI driver if you are using the SATA ports but if we
know this code works for the PATA port that is fixable later on.

Alan

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/Kconfig linux-2.6.18-mm2/drivers/ata/Kconfig
--- linux.vanilla-2.6.18-mm2/drivers/ata/Kconfig	2006-09-28 14:33:46.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ata/Kconfig	2006-09-29 17:42:31.392428080 +0100
@@ -327,6 +327,15 @@
 
 	  If unsure, say N.
 
+config PATA_MARVELL
+	tristate "Marvell PATA support via legacy nmode"
+	depends on PCI
+	help
+	  This option enables limited support for the Marvell 88SE6145 ATA
+	  controller.
+
+	  If unsure, say N.
+
 config PATA_MPIIX
 	tristate "Intel PATA MPIIX support"
 	depends on PCI
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/Makefile linux-2.6.18-mm2/drivers/ata/Makefile
--- linux.vanilla-2.6.18-mm2/drivers/ata/Makefile	2006-09-28 14:33:46.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ata/Makefile	2006-09-29 16:12:08.000000000 +0100
@@ -38,6 +38,7 @@
 obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
 obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
 obj-$(CONFIG_PATA_OPTIDMA)	+= pata_optidma.o
+obj-$(CONFIG_PATA_MARVELL)	+= pata_marvell.o
 obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
 obj-$(CONFIG_PATA_OLDPIIX)	+= pata_oldpiix.o
 obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/pata_marvell.c linux-2.6.18-mm2/drivers/ata/pata_marvell.c
--- linux.vanilla-2.6.18-mm2/drivers/ata/pata_marvell.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ata/pata_marvell.c	2006-09-29 17:45:23.612246688 +0100
@@ -0,0 +1,210 @@
+/*
+ *	Marvell PATA driver.
+ *
+ *	For the moment we drive the PATA port in legacy mode. That
+ *	isn't making full use of the device functionality but it is
+ *	easy to get working.
+ *
+ *	(c) 2006 Red Hat  <alan@redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <linux/ata.h>
+
+#define DRV_NAME	"pata_marvell"
+#define DRV_VERSION	"0.0.3"
+
+/**
+ *	marvell_pre_reset	-	check for 40/80 pin
+ *	@ap: Port
+ *
+ *	Perform the PATA port setup we need.
+ */
+
+static int marvell_pre_reset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u32 devices;
+	unsigned long bar5;
+	void __iomem *barp;
+
+	/* Check if our port is enabled */
+
+	bar5 = pci_resource_start(pdev, 5);
+	barp = ioremap(bar5, 0x10);
+	if (barp == NULL)
+		return -ENOMEM;
+	devices = readl(barp + 0x0C);
+	iounmap(barp);
+	
+	if (ap->port_no == 0 && !(devices & 0x10))	/* PATA enable ? */
+		return -ENOENT;
+
+	/* Cable type */
+	switch(ap->port_no)
+	{
+		case 0:
+			/* Might be backward, docs unclear */
+			if(inb(ap->ioaddr.bmdma_addr + 1) & 1)
+				ap->cbl = ATA_CBL_PATA80;
+			else
+				ap->cbl = ATA_CBL_PATA40;
+			
+		case 1: /* Legacy SATA port */
+			ap->cbl = ATA_CBL_SATA;
+			break;
+	}
+	return ata_std_prereset(ap);
+}
+
+/**
+ *	marvell_error_handler - Setup and error handler
+ *	@ap: Port to handle
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void marvell_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, marvell_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+}
+
+/* No PIO or DMA methods needed for this device */
+
+static struct scsi_host_template marvell_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	/* Use standard CHS mapping rules */
+	.bios_param		= ata_std_bios_param,
+};
+
+static const struct ata_port_operations marvell_ops = {
+	.port_disable		= ata_port_disable,
+
+	/* Task file is PCI ATA format, use helpers */
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= marvell_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	/* BMDMA handling is PCI ATA format, use helpers */
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
+
+	/* Timeout handling */
+	.eng_timeout		= ata_eng_timeout,
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	/* Generic PATA PCI ATA helpers */
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+
+/**
+ *	marvell_init_one - Register Marvell ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in marvell_pci_tbl matching with @pdev
+ *
+ *	Called from kernel PCI layer.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	static struct ata_port_info info = {
+		.sht		= &marvell_sht,
+		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask 	= 0x3f,
+
+		.port_ops	= &marvell_ops,
+	};
+	static struct ata_port_info info_sata = {
+		.sht		= &marvell_sht,
+		/* Slave possible as its magically mapped not real */
+		.flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask 	= 0x7f,
+
+		.port_ops	= &marvell_ops,
+	};
+	struct ata_port_info *port_info[2] = { &info, &info_sata };
+	
+	return ata_pci_init_one(pdev, port_info, 2);
+}
+
+static const struct pci_device_id marvell_pci_tbl[] = {
+	{ PCI_DEVICE(0x11AB, 0x6145), },
+	{ }	/* terminate list */
+};
+
+static struct pci_driver marvell_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= marvell_pci_tbl,
+	.probe			= marvell_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static int __init marvell_init(void)
+{
+	return pci_register_driver(&marvell_pci_driver);
+}
+
+static void __exit marvell_exit(void)
+{
+	pci_unregister_driver(&marvell_pci_driver);
+}
+
+module_init(marvell_init);
+module_exit(marvell_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("SCSI low-level driver for Marvell ATA in legacy mode");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, marvell_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+

