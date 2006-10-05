Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWJEJQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWJEJQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWJEJQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:16:51 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:39878 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751553AbWJEJQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:16:49 -0400
Date: Thu, 5 Oct 2006 18:16:31 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de,
       ysato@users.sourceforge.jp
Subject: Re: [PATCH] Generic platform device IDE driver
Message-ID: <20061005091631.GA8631@localhost.hsdv.com>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159962084.25772.14.camel@localhost.localdomain> <20061004200501.GB6664@localhost.Internal.Linux-SH.ORG> <1159972725.25772.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159972725.25772.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 03:38:45PM +0100, Alan Cox wrote:
> Ar Iau, 2006-10-05 am 05:05 +0900, ysgrifennodd Paul Mundt:
> > Ok, I wasn't sure if libata was intended for anything outside of the
> > SATA case (especially non-PCI), but if that's the way to go, I'll look
> > at hacking something up under libata.
> 
> Take a look at 2.6.18-mm or 2.6.19-* and you should see all you need in
> that including the pcmcia driver and other users who set up much the
> same way a generic platform device driver would.
> 
Ok, just hacked this together quickly, how does it look? I'm booting
this on an SH-4A (R7780RP) from current git and all works fine..

Thankfully you did most of the heavy lifting :-)

--

 drivers/ata/Kconfig         |    9 ++
 drivers/ata/Makefile        |    1 
 drivers/ata/pata_platform.c |  198 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

commit f257da330416413947c65dac20cefbd39231eb30
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Thu Oct 5 18:13:27 2006 +0900

    ata: Simple generic platform device libata driver.
    
    This adds a simple generic libata driver for directly-connected
    and pre-configured platform devices commonly found on embedded
    systems.
    
    For most of these devices, the only variation ends up being the
    I/O and CTL bases as well as the IRQ, with everything else
    effectively behaving as a standard ISA bus PIO device.
    
    Users of 'pata_platform' are required to pack in 3 resources per
    port, namely, the aforementioned variations. Each port must be
    registered independently, which doesn't end up being a big problem,
    as most of the embedded use cases don't have more than one or two
    ports anyways.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 3f4aa0c..70a5a08 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -482,6 +482,15 @@ config PATA_WINBOND
 
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
index 0000000..b9de610
--- /dev/null
+++ b/drivers/ata/pata_platform.c
@@ -0,0 +1,198 @@
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
+
+#define DRV_NAME "pata_platform"
+#define DRV_VERSION "0.1.0"
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
+	.check_status 		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select 		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.qc_prep 		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.data_xfer		= ata_pio_data_xfer_noirq,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop
+};
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
+ *		- I/O Base (IORESOURCE_IO)
+ *		- CTL Base (IORESOURCE_IO)
+ *		- IRQ	   (IORESOURCE_IRQ)
+ */
+static int __devinit pata_platform_probe(struct platform_device *pdev)
+{
+	struct resource *io_res, *ctl_res;
+	struct ata_probe_ent ae;
+	int ret = -EBUSY;
+
+	/*
+	 * Simple resource validation ..
+	 */
+	if (unlikely(pdev->num_resources != 3)) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (unlikely(io_res == NULL))
+		return -EINVAL;
+
+	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
+	if (unlikely(ctl_res == NULL))
+		return -EINVAL;
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
+	ae.port[0].cmd_addr = io_res->start;
+	ae.port[0].altstatus_addr = ctl_res->start;
+	ae.port[0].ctl_addr = ctl_res->start;
+	ata_std_ports(&ae.port[0]);
+
+	ret = ata_device_add(&ae);
+	if (unlikely(ret == 0))
+		return -ENODEV;
+
+	return 0;
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
