Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUHTRXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUHTRXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUHTRXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:23:24 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:7592 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267338AbUHTRWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:22:54 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Tomasz Torcz <zdzichu@irc.pl>
Subject: Re: Fw: 2.6.8.1-mm2: floppy magically disappaperd
Date: Fri, 20 Aug 2004 11:22:45 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <20040819121035.035be585.akpm@osdl.org>
In-Reply-To: <20040819121035.035be585.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201122.45779.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  My flopped disappeared with this kernel becaouse of ACPI. It was
> working earlier revisions. Modprobing floppy.ko fails:
> 
> (in dmesg)
> #v+
> inserting floppy driver for 2.6.8.1-mm2
> floppy: controller ACPI FDC0 at I/O 0x3f7-0x3f7 irq 6 dma channel 2
> Floppy drive(s): fd0 is 1.44M
> floppy0: Floppy io-port 0x03f7 in use
> #v-

Thanks for the bug report.  Can you try the attached patch please?
This replaces the floppy.c patch from the -mm set.

I'm interested in the dmesg output whether it works or not.

I suspect your ACPI is reporting two I/O regions for the floppy
controller: 0x3f2-0x3f5, and 0x3f7.  Strictly speaking, that's
probably the correct thing.  It happens that my box (an HP DL360)
only reports 0x3f2-0x3f5.  The driver uses 0x3f7, and I don't see
how it could get along without it, so I think the HP BIOS is broken.

In any case, the patch below should deal better with two I/O regions
being reported.

===== drivers/block/floppy.c 1.103 vs edited =====
--- 1.103/drivers/block/floppy.c	2004-08-02 02:00:45 -06:00
+++ edited/drivers/block/floppy.c	2004-08-20 11:04:56 -06:00
@@ -181,6 +181,13 @@
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
+#ifdef CONFIG_ACPI_BUS
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+static int no_acpi;
+#endif
+
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
  * It's been recommended that take about 1/4 of the default speed
@@ -4150,6 +4157,9 @@
 	{"slow", NULL, &slow_floppy, 1, 0},
 	{"unexpected_interrupts", NULL, &print_unex, 1, 0},
 	{"no_unexpected_interrupts", NULL, &print_unex, 0, 0},
+#ifdef CONFIG_ACPI_BUS
+	{"no_acpi", NULL, &no_acpi, 1, 0},
+#endif
 	{"L40SX", NULL, &print_unex, 0, 0}
 
 	EXTRA_FLOPPY_PARAMS
@@ -4222,10 +4232,152 @@
 	return get_disk(disks[drive]);
 }
 
+#ifdef CONFIG_ACPI_BUS
+static int acpi_floppies;
+
+struct floppy_resources {
+	unsigned int port1;
+	unsigned int nr_ports1;
+	unsigned int port2;
+	unsigned int nr_ports2;
+	unsigned int irq;
+	unsigned int dma_channel;
+};
+
+static acpi_status acpi_floppy_resource(struct acpi_resource *res, void *data)
+{
+	struct floppy_resources *floppy = (struct floppy_resources *) data;
+	struct acpi_resource_io *io;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_ext_irq *ext_irq;
+	struct acpi_resource_dma *dma;
+
+	if (res->id == ACPI_RSTYPE_IO) {
+		io = &res->data.io;
+		if (io->range_length) {
+			printk("%s: %d ioports at 0x%x\n", __FUNCTION__,
+				io->range_length, io->min_base_address);
+			if (floppy->port1) {
+				floppy->port2 = io->min_base_address;
+				floppy->nr_ports2 = io->range_length;
+			} else {
+				floppy->port1 = io->min_base_address;
+				floppy->nr_ports1 = io->range_length;
+			}
+		}
+	} else if (res->id == ACPI_RSTYPE_IRQ) {
+		irq = &res->data.irq;
+		if (irq->number_of_interrupts > 0)
+			floppy->irq = acpi_register_gsi(irq->interrupts[0],
+				irq->edge_level, irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+		ext_irq = &res->data.extended_irq;
+		if (ext_irq->number_of_interrupts > 0)
+			floppy->irq = acpi_register_gsi(ext_irq->interrupts[0],
+				ext_irq->edge_level, ext_irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_DMA) {
+		dma = &res->data.dma;
+		if (dma->number_of_channels > 0)
+			floppy->dma_channel = dma->channels[0];
+	}
+	return AE_OK;
+}
+
+static int acpi_floppy_add(struct acpi_device *device)
+{
+	struct floppy_resources floppy;
+	acpi_status status;
+
+	memset(&floppy, 0, sizeof(floppy));
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+		acpi_floppy_resource, &floppy);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	printk("%s: controller ACPI %s at I/O 0x%x-0x%x",
+		DEVICE_NAME, device->pnp.bus_id,
+		floppy.port1, floppy.port1 + floppy.nr_ports1 - 1);
+	if (floppy.nr_ports2)
+		printk(", 0x%x-0x%x",
+			floppy.port2, floppy.port2 + floppy.nr_ports2 - 1);
+	printk(" irq %d dma channel %d\n", floppy.irq, floppy.dma_channel);
+
+	/*
+	 * The driver assumes I/O port regions like 0x3f0-0x3f5 and 0x3f7,
+	 * but it ignores the first two ports (i.e., 0x3f0 and 0x3f1),
+	 * which are for PS/2 systems.  Since no PS/2 systems have
+	 * ACPI, we should get regions like 0x3f2-0x3f5 and 0x3f7.
+	 * Some boxes don't report 0x3f7 at all, so try to make sense
+	 * of whatever we get.
+	 */
+	if (floppy.nr_ports1 == 4) {		/* 0x3f2-0x3f5 */
+		floppy.port1 -= 2;
+		floppy.nr_ports1 = 6;
+	} else if (floppy.nr_ports1 == 6) {	/* 0x3f2-0x3f7 */
+		floppy.port1 -= 2;
+		floppy.nr_ports1 = 6;
+		floppy.nr_ports2 = 1;
+	} else if (floppy.nr_ports1 == 8) {	/* 0x3f0-0x3f7 */
+		floppy.nr_ports1 = 6;
+		floppy.nr_ports2 = 1;
+	}
+
+	if (floppy.nr_ports2 == 0)
+		printk(KERN_WARNING "%s: no FD_DIR/DCR port in %s _CRS, assuming 0x%x\n",
+			DEVICE_NAME, device->pnp.bus_id, floppy.port1 + 7);
+
+	if (acpi_floppies == 0) {
+		FDC1 = floppy.port1;
+		FLOPPY_IRQ = floppy.irq;
+		FLOPPY_DMA = floppy.dma_channel;
+	} else if (acpi_floppies == 1) {
+		FDC2 = floppy.port1;
+		if (floppy.irq != FLOPPY_IRQ || floppy.dma_channel != FLOPPY_DMA)
+			printk(KERN_WARNING "%s: different IRQ/DMA info for %s; may not work\n",
+				DEVICE_NAME, device->pnp.bus_id);
+	} else {
+		printk(KERN_ERR "%s: only 2 controllers supported; %s ignored\n",
+			DEVICE_NAME, device->pnp.bus_id);
+		return -ENODEV;
+	}
+
+	acpi_floppies++;
+	return 0;
+}
+
+static int acpi_floppy_remove(struct acpi_device *device, int type)
+{
+	printk(KERN_ERR "%s: remove ACPI %s not supported\n", DEVICE_NAME,
+		device->pnp.bus_id);
+	return -EINVAL;
+}
+
+static struct acpi_driver acpi_floppy_driver = {
+	.name	= "floppy",
+	.ids	= "PNP0700",
+	.ops	= {
+		.add	= acpi_floppy_add,
+		.remove	= acpi_floppy_remove,
+	},
+};
+
+static int acpi_floppy_init(void)
+{
+	if (no_acpi)
+		return -ENODEV;
+	return acpi_bus_register_driver(&acpi_floppy_driver);
+}
+#endif
+
 int __init floppy_init(void)
 {
 	int i, unit, drive;
 	int err, dr;
+
+#ifdef CONFIG_ACPI_BUS
+	if (acpi_floppy_init() == 0)
+		return -ENODEV;
+#endif
 
 	raw_cmd = NULL;
 
