Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWJWG72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWJWG72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWJWG72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:59:28 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:18853 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751624AbWJWG70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:59:26 -0400
Date: Mon, 23 Oct 2006 15:59:07 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk@arm.linux.org.uk>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ata: Generic platform_device libata driver, take 2.
Message-ID: <20061023065907.GA22029@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second attempt at a generic platform_device libata driver,
attempting to take in to account issues raised by Matthias Fuchs and rmk.

Changes in this version include adding a small pata_platform.h header for
the private data (which at the moment is limited to a register shift
that's needed by ARM), though other things can be added in here if
platforms start having other needs.

At the moment this takes care of the IDE needs across some PPC and SH,
and with this change, hopefully ARM as well. H8300 should still be
trivial to move over to this.

Comments?

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/ata/Kconfig           |    9 +
 drivers/ata/Makefile          |    1 
 drivers/ata/pata_platform.c   |  295 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pata_platform.h |   13 +
 4 files changed, 318 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 03f6338..ac4aa73 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -483,6 +483,15 @@ config PATA_WINBOND
 
 	  If unsure, say N.
 
+config PATA_PLATFORM
+	tristate "Generic platform device PATA support"
+	depends on EMBEDDED
+	help
+	  This option enables support for generic directly connected ATA
+	  devices commonly found on embedded systems.
+
+	  If unsure, say N.
+
 endif
 endmenu
 
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 72243a6..408c8c9 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PATA_VIA)		+= pata_via.o
 obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c105.o
 obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
 obj-$(CONFIG_PATA_TRIFLEX)	+= pata_triflex.o
+obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 # Should be last but one libata driver
 obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
 # Should be last libata driver
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
new file mode 100644
index 0000000..63d6687
--- /dev/null
+++ b/drivers/ata/pata_platform.c
@@ -0,0 +1,295 @@
+/*
+ * Generic platform device PATA driver
+ *
+ * Copyright (C) 2006  Paul Mundt
+ *
+ * Based on pata_pcmcia:
+ *
+ *   Copyright 2005-2006 Red Hat Inc <alan@redhat.com>, all rights reserved.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <scsi/scsi_host.h>
+#include <linux/ata.h>
+#include <linux/libata.h>
+#include <linux/platform_device.h>
+#include <linux/pata_platform.h>
+
+#define DRV_NAME "pata_platform"
+#define DRV_VERSION "0.1.2"
+
+static int pio_mask = 1;
+
+/*
+ * Provide our own set_mode() as we don't want to change anything that has
+ * already been configured..
+ */
+static void pata_platform_set_mode(struct ata_port *ap)
+{
+	int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (ata_dev_enabled(dev)) {
+			/* We don't really care */
+			dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			dev->flags |= ATA_DFLAG_PIO;
+		}
+	}
+}
+
+static void pata_platform_host_stop(struct ata_host *host)
+{
+	int i;
+
+	/*
+	 * Unmap the bases for MMIO
+	 */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->flags & ATA_FLAG_MMIO) {
+			iounmap((void __iomem *)ap->ioaddr.ctl_addr);
+			iounmap((void __iomem *)ap->ioaddr.cmd_addr);
+		}
+	}
+}
+
+static struct scsi_host_template pata_platform_sht = {
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
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations pata_platform_port_ops = {
+	.set_mode		= pata_platform_set_mode,
+
+	.port_disable		= ata_port_disable,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.data_xfer		= ata_pio_data_xfer_noirq,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= pata_platform_host_stop
+};
+
+static void pata_platform_setup_port(struct ata_ioports *ioaddr,
+				     struct pata_platform_info *info)
+{
+	unsigned int shift = 0;
+
+	/* Fixup the port shift for platforms that need it */
+	if (info && info->ioport_shift)
+		shift = info->ioport_shift;
+
+	ioaddr->data_addr	= ioaddr->cmd_addr + (ATA_REG_DATA    << shift);
+	ioaddr->error_addr	= ioaddr->cmd_addr + (ATA_REG_ERR     << shift);
+	ioaddr->feature_addr	= ioaddr->cmd_addr + (ATA_REG_FEATURE << shift);
+	ioaddr->nsect_addr	= ioaddr->cmd_addr + (ATA_REG_NSECT   << shift);
+	ioaddr->lbal_addr	= ioaddr->cmd_addr + (ATA_REG_LBAL    << shift);
+	ioaddr->lbam_addr	= ioaddr->cmd_addr + (ATA_REG_LBAM    << shift);
+	ioaddr->lbah_addr	= ioaddr->cmd_addr + (ATA_REG_LBAH    << shift);
+	ioaddr->device_addr	= ioaddr->cmd_addr + (ATA_REG_DEVICE  << shift);
+	ioaddr->status_addr	= ioaddr->cmd_addr + (ATA_REG_STATUS  << shift);
+	ioaddr->command_addr	= ioaddr->cmd_addr + (ATA_REG_CMD     << shift);
+}
+
+/**
+ *	pata_platform_probe		-	attach a platform interface
+ *	@pdev: platform device
+ *
+ *	Register a platform bus IDE interface. Such interfaces are PIO and we
+ *	assume do not support IRQ sharing.
+ *
+ *	Platform devices are expected to contain 3 resources per port:
+ *
+ *		- I/O Base (IORESOURCE_IO or IORESOURCE_MEM)
+ *		- CTL Base (IORESOURCE_IO or IORESOURCE_MEM)
+ *		- IRQ	   (IORESOURCE_IRQ)
+ *
+ *	If the base resources are both mem types, the ioremap() is handled
+ *	here. For IORESOURCE_IO, it's assumed that there's no remapping
+ *	necessary.
+ */
+static int __devinit pata_platform_probe(struct platform_device *pdev)
+{
+	struct resource *io_res, *ctl_res;
+	struct ata_probe_ent ae;
+	unsigned int mmio;
+	int ret;
+
+	/*
+	 * Simple resource validation ..
+	 */
+	if (unlikely(pdev->num_resources != 3)) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get the I/O base first
+	 */
+	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (io_res == NULL) {
+		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (unlikely(io_res == NULL))
+			return -EINVAL;
+	}
+
+	/*
+	 * Then the CTL base
+	 */
+	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
+	if (ctl_res == NULL) {
+		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (unlikely(ctl_res == NULL))
+			return -EINVAL;
+	}
+
+	/*
+	 * Check for MMIO
+	 */
+	mmio = (( io_res->flags == IORESOURCE_MEM) &&
+		(ctl_res->flags == IORESOURCE_MEM));
+
+	/*
+	 * Now that that's out of the way, wire up the port..
+	 */
+	memset(&ae, 0, sizeof(struct ata_probe_ent));
+	INIT_LIST_HEAD(&ae.node);
+	ae.dev = &pdev->dev;
+	ae.port_ops = &pata_platform_port_ops;
+	ae.sht = &pata_platform_sht;
+	ae.n_ports = 1;
+	ae.pio_mask = pio_mask;
+	ae.irq = platform_get_irq(pdev, 0);
+	ae.irq_flags = 0;
+	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
+
+	/*
+	 * Handle the MMIO case
+	 */
+	if (mmio) {
+		ae.port_flags |= ATA_FLAG_MMIO;
+
+		ae.port[0].cmd_addr = (unsigned long)ioremap(io_res->start,
+				io_res->end - io_res->start + 1);
+		if (unlikely(!ae.port[0].cmd_addr)) {
+			dev_err(&pdev->dev, "failed to remap IO base\n");
+			return -ENXIO;
+		}
+
+		ae.port[0].ctl_addr = (unsigned long)ioremap(ctl_res->start,
+				ctl_res->end - ctl_res->start + 1);
+		if (unlikely(!ae.port[0].ctl_addr)) {
+			dev_err(&pdev->dev, "failed to remap CTL base\n");
+			ret = -ENXIO;
+			goto bad_remap;
+		}
+	} else {
+		ae.port[0].cmd_addr = io_res->start;
+		ae.port[0].ctl_addr = ctl_res->start;
+	}
+
+	ae.port[0].altstatus_addr = ae.port[0].ctl_addr;
+
+	pata_platform_setup_port(&ae.port[0], pdev->dev.platform_data);
+
+	if (unlikely(ata_device_add(&ae) == 0)) {
+		ret = -ENODEV;
+		goto add_failed;
+	}
+
+	return 0;
+
+add_failed:
+	if (ae.port[0].ctl_addr && mmio)
+		iounmap((void __iomem *)ae.port[0].ctl_addr);
+bad_remap:
+	if (ae.port[0].cmd_addr && mmio)
+		iounmap((void __iomem *)ae.port[0].cmd_addr);
+
+	return ret;
+}
+
+/**
+ *	pata_platform_remove	-	unplug a platform interface
+ *	@pdev: platform device
+ *
+ *	A platform bus ATA device has been unplugged. Perform the needed
+ *	cleanup. Also called on module unload for any active devices.
+ */
+static int __devexit pata_platform_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	ata_host_remove(host);
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver pata_platform_driver = {
+	.probe		= pata_platform_probe,
+	.remove		= __devexit_p(pata_platform_remove),
+	.driver = {
+		.name		= DRV_NAME,
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init pata_platform_init(void)
+{
+	return platform_driver_register(&pata_platform_driver);
+}
+
+static void __exit pata_platform_exit(void)
+{
+	platform_driver_unregister(&pata_platform_driver);
+}
+module_init(pata_platform_init);
+module_exit(pata_platform_exit);
+
+module_param(pio_mask, int, 0);
+
+MODULE_AUTHOR("Paul Mundt");
+MODULE_DESCRIPTION("low-level driver for platform device ATA");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
diff --git a/include/linux/pata_platform.h b/include/linux/pata_platform.h
new file mode 100644
index 0000000..2d5fd64
--- /dev/null
+++ b/include/linux/pata_platform.h
@@ -0,0 +1,13 @@
+#ifndef __LINUX_PATA_PLATFORM_H
+#define __LINUX_PATA_PLATFORM_H
+
+struct pata_platform_info {
+	/*
+	 * I/O port shift, for platforms with ports that are
+	 * constantly spaced and need larger than the 1-byte
+	 * spacing used by ata_std_ports().
+	 */
+	unsigned int ioport_shift;
+};
+
+#endif /* __LINUX_PATA_PLATFORM_H */
