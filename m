Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUHRWOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUHRWOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 18:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUHRWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 18:14:19 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:21137 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267935AbUHRWOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 18:14:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ACPI-based floppy controller enumeration
Date: Wed, 18 Aug 2004 16:13:56 -0600
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, Len Brown <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408181613.56656.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI-based floppy controller enumeration.  This fixes
one problem exposed when I removed the unconditional ACPI
PCI IRQ routing.

ACPI-based enumeration can be disabled with "floppy=no_acpi".
That should only be required if your BIOS supplies incorrect
ACPI _CRS information about I/O ports, IRQs, or DMA channels.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== Documentation/floppy.txt 1.1 vs edited =====
--- 1.1/Documentation/floppy.txt	2002-02-05 10:40:38 -07:00
+++ edited/Documentation/floppy.txt	2004-08-18 15:41:37 -06:00
@@ -187,6 +187,11 @@
 	   It's been recommended that take about 1/4 of the default speed
 	   in some more extreme cases."
 
+ floppy=no_acpi
+	Don't enumerate floppy controllers using ACPI namespace.
+	You may need this if your ACPI is buggy and reports incorrect
+	I/O port, IRQ, or DMA information.
+
 
 
 Supporting utilities and additional documentation:
===== drivers/block/floppy.c 1.103 vs edited =====
--- 1.103/drivers/block/floppy.c	2004-08-02 02:00:45 -06:00
+++ edited/drivers/block/floppy.c	2004-08-18 15:54:41 -06:00
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
@@ -4222,10 +4232,123 @@
 	return get_disk(disks[drive]);
 }
 
+#ifdef CONFIG_ACPI_BUS
+static int acpi_floppies;
+
+struct floppy_resources {
+	unsigned int port;
+	unsigned int nr_ports;
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
+			floppy->port = io->min_base_address;
+			floppy->nr_ports = io->range_length;
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
+	printk("%s: controller ACPI %s at I/O 0x%x-0x%x irq %d dma channel %d\n",
+		DEVICE_NAME, device->pnp.bus_id,
+		floppy.port, floppy.port + floppy.nr_ports - 1,
+		floppy.irq, floppy.dma_channel);
+
+	/*
+	 * The driver assumes I/O port regions like 0x3f0-0x3f5, but it
+	 * ignores the first two ports (i.e., 0x3f0 and 0x3f1), which are
+	 * for PS/2 systems.  Since no PS/2 systems have ACPI, we should
+	 * get a region like 0x3f2-0x3f5, so we adjust it down to what the
+	 * driver expects.
+	 */
+	acpi_floppies++;
+	if (acpi_floppies == 1) {
+		FDC1 = floppy.port - 2;
+		FLOPPY_IRQ = floppy.irq;
+		FLOPPY_DMA = floppy.dma_channel;
+	} else if (acpi_floppies == 2) {
+		FDC2 = floppy.port - 2;
+		if (floppy.irq != FLOPPY_IRQ || floppy.dma_channel != FLOPPY_DMA)
+			printk(KERN_WARNING "%s: different IRQ/DMA info for %s; may not work\n",
+				DEVICE_NAME, device->pnp.bus_id);
+	} else {
+		printk(KERN_ERR "%s: only 2 controllers supported; %s ignored\n",
+			DEVICE_NAME, device->pnp.bus_id);
+		return -ENODEV;
+	}
+
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
 
