Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbUKOX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUKOX7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUKOX6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:58:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:34762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261658AbUKOXyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:54:55 -0500
Date: Mon, 15 Nov 2004 15:58:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: bunk@stusta.de, torvalds@osdl.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.10-rc2 doesn't boot
Message-Id: <20041115155845.3872391e.akpm@osdl.org>
In-Reply-To: <20041115152721.U14339@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
	<20041115040710.GA2235@stusta.de>
	<Pine.LNX.4.58.0411142040470.2222@ppc970.osdl.org>
	<20041115052920.GB7510@stusta.de>
	<20041115152721.U14339@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Adrian Bunk (bunk@stusta.de) wrote:
> > It seems Bjorns "PCI: remove unconditional PCI ACPI IRQ routing" was 
> > merged now into your tree, but his patch to fix floppy.c wasn't 
> > merged...
> 
> What's the likelihood of getting some derivative of Bjorn's patch
> merged?  W/out the patch (and w/ floppy built) I've the same issue.
> 

I've had no bug reports against it for some time, but I was hoping to talk
Len into merging it up because ACPI makes my head swim.


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This can be disabled with "floppy=no_acpi", which should only be required
if your BIOS supplies incorrect ACPI _CRS information about I/O ports,
IRQs, or DMA channels.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/floppy.txt |    6 +
 25-akpm/drivers/block/floppy.c   |  183 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

diff -puN Documentation/floppy.txt~add-acpi-based-floppy-controller-enumeration Documentation/floppy.txt
--- 25/Documentation/floppy.txt~add-acpi-based-floppy-controller-enumeration	2004-11-11 01:19:18.835616160 -0800
+++ 25-akpm/Documentation/floppy.txt	2004-11-11 01:19:18.840615400 -0800
@@ -204,6 +204,12 @@ in /etc/modprobe.conf.
 	   It's been recommended that take about 1/4 of the default speed
 	   in some more extreme cases."
 
+ floppy=no_acpi
+	Don't enumerate floppy controllers using ACPI namespace.
+	You may need this if your ACPI is buggy and doesn't report
+	a floppy controller when it actually exists, or if it
+	reports incorrect I/O port, IRQ, or DMA information.
+
 
 Supporting utilities and additional documentation:
 ==================================================
diff -puN drivers/block/floppy.c~add-acpi-based-floppy-controller-enumeration drivers/block/floppy.c
--- 25/drivers/block/floppy.c~add-acpi-based-floppy-controller-enumeration	2004-11-11 01:19:18.837615856 -0800
+++ 25-akpm/drivers/block/floppy.c	2004-11-11 01:31:30.094447920 -0800
@@ -181,6 +181,13 @@ static int print_unex = 1;
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+static int no_acpi_floppy;
+#endif
+
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
  * It's been recommended that take about 1/4 of the default speed
@@ -4150,6 +4157,9 @@ static struct param_table {
 	{"slow", NULL, &slow_floppy, 1, 0},
 	{"unexpected_interrupts", NULL, &print_unex, 1, 0},
 	{"no_unexpected_interrupts", NULL, &print_unex, 0, 0},
+#ifdef CONFIG_ACPI
+	{"no_acpi", NULL, &no_acpi_floppy, 1, 0},
+#endif
 	{"L40SX", NULL, &print_unex, 0, 0}
 
 	EXTRA_FLOPPY_PARAMS
@@ -4222,11 +4232,180 @@ static struct kobject *floppy_find(dev_t
 	return get_disk(disks[drive]);
 }
 
+#ifdef CONFIG_ACPI
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
+	strncpy(acpi_device_name(device), "Floppy Controller",
+		sizeof(acpi_device_name(device)));
+	printk("ACPI: %s [%s] at I/O 0x%x-0x%x",
+		acpi_device_name(device), acpi_device_bid(device),
+		fd.io_region[0].base,
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
+		printk(KERN_WARNING "ACPI: [%s] doesn't declare FD_DCR; also claiming 0x%x\n",
+			acpi_device_bid(device), dcr);
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
+			printk(KERN_WARNING "%s: different IRQ/DMA info for [%s]; may not work\n",
+				DEVICE_NAME, acpi_device_bid(device));
+	} else {
+		printk(KERN_ERR "%s: only 2 controllers supported; [%s] ignored\n",
+			DEVICE_NAME, acpi_device_bid(device));
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
+	if (no_acpi_floppy) {
+		printk("%s: ACPI detection disabled\n", DEVICE_NAME);
+		return -ENODEV;
+	}
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
+static inline int  acpi_floppy_init(void) { return -ENODEV; }
+static inline void acpi_floppy_exit(void) { }
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
@@ -4411,6 +4590,8 @@ out_put_disk:
 		del_timer(&motor_off_timer[dr]);
 		put_disk(disks[dr]);
 	}
+out_put_acpi:
+	acpi_floppy_exit();
 	return err;
 }
 
@@ -4627,6 +4808,8 @@ void cleanup_module(void)
 	/* eject disk, if any */
 	fd_eject(0);
 
+	acpi_floppy_exit();
+
 	wait_for_completion(&device_release);
 }
 
_

