Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269176AbUHZQ21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269176AbUHZQ21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269181AbUHZQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:26:08 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:53448 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S269151AbUHZQSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:18:09 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Aric Cyr <acyr@alumni.uwaterloo.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: ACPI + Floppy detection problem in 2.6.8.1-mm4
Date: Thu, 26 Aug 2004 10:17:33 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Len Brown <len.brown@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <20040825002220.4867cd17.akpm@osdl.org> <200408251424.43575.bjorn.helgaas@hp.com> <20040826070417.GA8898@alumni.uwaterloo.ca>
In-Reply-To: <20040826070417.GA8898@alumni.uwaterloo.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408261017.33339.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's something that I think should be suitable for the next -mm
patchset.

We report exactly what ACPI tells us about I/O port regions.  We mask
off the low three bits of the first region, so we can handle all the
reasonable ACPI weirdnesses.  We warn only about the case where we claim
a port ACPI didn't tell us about.  All the acpi_strict stuff is gone,
at least for now.  The module unload stuff should be fixed.


Add ACPI-based floppy controller enumeration.

This can be disabled with "floppy=no_acpi", which should only be
required if your BIOS supplies incorrect ACPI _CRS information about
I/O ports, IRQs, or DMA channels.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== Documentation/floppy.txt 1.1 vs edited =====
--- 1.1/Documentation/floppy.txt	2002-02-05 10:40:38 -07:00
+++ edited/Documentation/floppy.txt	2004-08-26 10:01:51 -06:00
@@ -187,6 +187,12 @@
 	   It's been recommended that take about 1/4 of the default speed
 	   in some more extreme cases."
 
+ floppy=no_acpi
+	Don't enumerate floppy controllers using ACPI namespace.
+	You may need this if your ACPI is buggy and doesn't report
+	a floppy controller when it actually exists, or if it
+	reports incorrect I/O port, IRQ, or DMA information.
+
 
 
 Supporting utilities and additional documentation:
===== drivers/block/floppy.c 1.103 vs edited =====
--- 1.103/drivers/block/floppy.c	2004-08-02 02:00:45 -06:00
+++ edited/drivers/block/floppy.c	2004-08-26 10:08:58 -06:00
@@ -181,6 +181,13 @@
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
+#ifdef CONFIG_ACPI_BUS
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+static int no_acpi_floppy;
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
+	{"no_acpi", NULL, &no_acpi_floppy, 1, 0},
+#endif
 	{"L40SX", NULL, &print_unex, 0, 0}
 
 	EXTRA_FLOPPY_PARAMS
@@ -4222,11 +4232,175 @@
 	return get_disk(disks[drive]);
 }
 
+#ifdef CONFIG_ACPI_BUS
+static int acpi_floppy_registered;
+static int acpi_floppies;
+
+struct region {
+	unsigned int base;
+	unsigned int size;
+};
+
+struct floppy_resources {
+	unsigned int nr_io_regions;
+	struct region io_region[2];
+	unsigned int irq;
+	unsigned int dma_channel;
+};
+
+static acpi_status acpi_floppy_resource(struct acpi_resource *res, void *data)
+{
+	struct floppy_resources *fd = (struct floppy_resources *) data;
+	struct acpi_resource_io *io;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_ext_irq *ext_irq;
+	struct acpi_resource_dma *dma;
+	int n;
+
+	if (res->id == ACPI_RSTYPE_IO) {
+		io = &res->data.io;
+		if (io->range_length) {
+			n = fd->nr_io_regions;
+			if (n < 2) {
+				fd->io_region[n].base = io->min_base_address;
+				fd->io_region[n].size = io->range_length;
+				fd->nr_io_regions++;
+			} else {
+				printk(KERN_WARNING "%s: ignoring I/O port region 0x%x-0x%x\n",
+					DEVICE_NAME, io->min_base_address,
+					io->min_base_address + io->range_length - 1);
+			}
+		}
+	} else if (res->id == ACPI_RSTYPE_IRQ) {
+		irq = &res->data.irq;
+		if (irq->number_of_interrupts > 0)
+			fd->irq = acpi_register_gsi(irq->interrupts[0],
+				irq->edge_level, irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+		ext_irq = &res->data.extended_irq;
+		if (ext_irq->number_of_interrupts > 0)
+			fd->irq = acpi_register_gsi(ext_irq->interrupts[0],
+				ext_irq->edge_level, ext_irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_DMA) {
+		dma = &res->data.dma;
+		if (dma->number_of_channels > 0)
+			fd->dma_channel = dma->channels[0];
+	}
+	return AE_OK;
+}
+
+static int acpi_floppy_add(struct acpi_device *device)
+{
+	struct floppy_resources fd;
+	acpi_status status;
+	unsigned int base, dcr;
+
+	memset(&fd, 0, sizeof(fd));
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+		acpi_floppy_resource, &fd);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	printk("%s: controller ACPI %s at I/O 0x%x-0x%x",
+		DEVICE_NAME, device->pnp.bus_id, fd.io_region[0].base,
+		fd.io_region[0].base + fd.io_region[0].size - 1);
+	if (fd.nr_io_regions > 1) {
+		if (fd.io_region[1].size == 1)
+			printk(", 0x%x", fd.io_region[1].base);
+		else
+			printk(", 0x%x-0x%x", fd.io_region[1].base,
+				fd.io_region[1].base + fd.io_region[1].size - 1);
+	}
+	printk(" irq %d dma channel %d\n", fd.irq, fd.dma_channel);
+
+	/*
+	 * The most correct resource description is probably of the form
+	 *    0x3f2-0x3f5, 0x3f7
+	 * Those are the only ports this driver actually uses.
+	 *
+	 * 0x3f0 and 0x3f1 were apparently used on PS/2 systems (though
+	 * this driver doesn't touch them), and 0x3f6 is used by IDE.
+	 * Some BIOS's erroneously include those ports, or omit 0x3f7,
+	 * so we should also be able to handle the following:
+	 *    0x3f0-0x3f5
+	 *    0x3f0-0x3f5, 0x3f7
+	 *    0x3f0-0x3f7
+	 *    0x3f2-0x3f7
+	 */
+	base = fd.io_region[0].base & ~0x7;
+	dcr = base + 7;
+
+#define contains(region, port)	((region).base <= (port) && \
+				 (port) < (region).base + (region).size)
+
+	if (!(contains(fd.io_region[0], dcr) || contains(fd.io_region[1], dcr))) {
+		printk(KERN_WARNING "%s: %s _CRS doesn't include FD_DCR; also claiming 0x%x\n",
+			DEVICE_NAME, device->pnp.bus_id, dcr);
+	}
+
+#undef contains
+
+	if (acpi_floppies == 0) {
+		FDC1 = base;
+		FLOPPY_IRQ = fd.irq;
+		FLOPPY_DMA = fd.dma_channel;
+	} else if (acpi_floppies == 1) {
+		FDC2 = base;
+		if (fd.irq != FLOPPY_IRQ || fd.dma_channel != FLOPPY_DMA)
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
+static struct acpi_driver acpi_floppy_driver = {
+	.name	= "floppy",
+	.ids	= "PNP0700",
+	.ops	= {
+		.add	= acpi_floppy_add,
+	},
+};
+
+static int acpi_floppy_init(void)
+{
+	int err;
+
+	if (no_acpi_floppy)
+		return -ENODEV;
+	err = acpi_bus_register_driver(&acpi_floppy_driver);
+	if (err >= 0)
+		acpi_floppy_registered = 1;
+	return err;
+}
+
+static void acpi_floppy_exit(void)
+{
+	if (acpi_floppy_registered) {
+		acpi_bus_unregister_driver(&acpi_floppy_driver);
+		acpi_floppy_registered = 0;
+	}
+}
+#else
+static int  acpi_floppy_init(void) { return -ENODEV; }
+static void acpi_floppy_stop(void) { }
+#endif
+
 int __init floppy_init(void)
 {
 	int i, unit, drive;
 	int err, dr;
 
+	if (acpi_floppy_init() == 0) {
+		err = -ENODEV;
+		goto out_put_acpi;
+	}
+
 	raw_cmd = NULL;
 
 	for (dr = 0; dr < N_DRIVE; dr++) {
@@ -4404,6 +4578,8 @@
 		del_timer(&motor_off_timer[dr]);
 		put_disk(disks[dr]);
 	}
+out_put_acpi:
+	acpi_floppy_exit();
 	return err;
 }
 
@@ -4619,6 +4795,8 @@
 
 	/* eject disk, if any */
 	fd_eject(0);
+
+	acpi_floppy_exit();
 
 	wait_for_completion(&device_release);
 }
