Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUKMNXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUKMNXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 08:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbUKMNXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 08:23:49 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:28599 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262730AbUKMNXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 08:23:37 -0500
Message-ID: <41960AD7.4000706@free.fr>
Date: Sat, 13 Nov 2004 14:23:35 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Adam Belay <ambx1@neo.rr.com>, bjorn.helgaas@hp.com
Subject: [PATCH] PNP support for floppy driver
Content-Type: multipart/mixed;
 boundary="------------000208050605040306040903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000208050605040306040903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this patch add PNP support for the floppy driver in 2.6.10-rc1-mm5. Acpi 
is try before the pnp driver so if you don't disable ACPI or apply 
others pnpacpi patches, it won't change anything.

On my computer the io resources are
io 0x3f2-0x3f3
io 0x3f4-0x3f5
io 0x3f7-0x3f7

so for avoiding the FD_DCR warning, I add a small fix that transform it 
in 0x3f2-0x3f5, 0x3f7-0x3f7. I hope it won't break anything.


Please review it and apply if possible.

thanks,

Matthieu CASTET


Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>

--------------000208050605040306040903
Content-Type: text/x-patch;
 name="floppy_pnp_acpi2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="floppy_pnp_acpi2.patch"

--- linux-2.6.9/drivers/block/floppy.c.orig	2004-11-12 22:55:09.000000000 +0100
+++ linux-2.6.9/drivers/block/floppy.c	2004-11-13 12:39:19.000000000 +0100
@@ -181,6 +181,12 @@
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
 
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static int no_pnp_floppy;
+#endif
+
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -4157,6 +4163,9 @@
 	{"slow", NULL, &slow_floppy, 1, 0},
 	{"unexpected_interrupts", NULL, &print_unex, 1, 0},
 	{"no_unexpected_interrupts", NULL, &print_unex, 0, 0},
+#ifdef CONFIG_PNP
+	{"no_pnp", NULL, &no_pnp_floppy, 1, 0},
+#endif
 #ifdef CONFIG_ACPI
 	{"no_acpi", NULL, &no_acpi_floppy, 1, 0},
 #endif
@@ -4232,9 +4241,7 @@
 	return get_disk(disks[drive]);
 }
 
-#ifdef CONFIG_ACPI
-static int acpi_floppies;
-
+#if defined(CONFIG_PNP) || defined(CONFIG_ACPI)
 struct region {
 	unsigned int base;
 	unsigned int size;
@@ -4246,6 +4253,157 @@
 	unsigned int irq;
 	unsigned int dma_channel;
 };
+#endif
+
+#ifdef CONFIG_PNP
+static int pnp_floppy_registered;
+static int pnp_floppies;
+
+static int pnp_floppy_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	struct floppy_resources fd;
+	unsigned int base, dcr;
+
+	memset(&fd, 0, sizeof(fd));
+	if (pnp_port_valid(dev, 0) &&
+		!(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
+		fd.io_region[0].base = pnp_port_start(dev, 0);
+		fd.io_region[0].size = pnp_port_len(dev, 0);
+		fd.nr_io_regions = 1;
+	}
+
+	if (pnp_port_valid(dev, 1) &&
+		!(pnp_port_flags(dev, 1) & IORESOURCE_DISABLED)) {
+		if (pnp_port_start(dev, 1) == (pnp_port_start(dev, 0) + pnp_port_len(dev, 0)))
+			fd.io_region[0].size += pnp_port_len(dev, 1);
+		else {
+			fd.io_region[1].base = pnp_port_start(dev, 1);
+			fd.io_region[1].size = pnp_port_len(dev, 1);
+			fd.nr_io_regions = 2;
+		}
+	}
+
+	if (pnp_port_valid(dev, 2) &&
+		!(pnp_port_flags(dev, 2) & IORESOURCE_DISABLED) &&
+		fd.nr_io_regions == 1) {
+		fd.io_region[1].base = pnp_port_start(dev, 2);
+		fd.io_region[1].size = pnp_port_len(dev, 2);
+		fd.nr_io_regions = 2;
+	}
+
+	if (pnp_irq_valid(dev, 0) &&
+		!(pnp_irq_flags(dev, 0) & IORESOURCE_DISABLED))
+		fd.irq = pnp_irq(dev, 0);
+
+	if (pnp_dma_valid(dev, 0) &&
+		!(pnp_dma_flags(dev, 0) & IORESOURCE_DISABLED))
+		fd.dma_channel = pnp_dma(dev, 0);
+
+	printk("PNP: %s [%s] at I/O 0x%x-0x%x",
+		"Floppy Controller", pnp_dev_name(dev),
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
+		printk(KERN_WARNING "PNP: [%s] doesn't declare FD_DCR; also claiming 0x%x\n",
+			pnp_dev_name(dev), dcr);
+	}
+
+#undef contains
+
+	if (pnp_floppies == 0) {
+		FDC1 = base;
+		FLOPPY_IRQ = fd.irq;
+		FLOPPY_DMA = fd.dma_channel;
+	} else if (pnp_floppies == 1) {
+		FDC2 = base;
+		if (fd.irq != FLOPPY_IRQ || fd.dma_channel != FLOPPY_DMA)
+			printk(KERN_WARNING "%s: different IRQ/DMA info for [%s]; may not work\n",
+				DEVICE_NAME, pnp_dev_name(dev));
+	} else {
+		printk(KERN_ERR "%s: only 2 controllers supported; [%s] ignored\n",
+			DEVICE_NAME, pnp_dev_name(dev));
+		return -ENODEV;
+	}
+
+	pnp_floppies++;
+	return 0;
+}
+
+static struct pnp_device_id pnp_floppy_devids[] = {
+	{ .id = "PNP0700", .driver_data = 0 },
+	{ .id = "", },
+};
+
+MODULE_DEVICE_TABLE(pnp, pnp_floppy_devids);
+
+static struct pnp_driver pnp_floppy_driver = {
+	.name           = "floppy",
+	.id_table       = pnp_floppy_devids,
+	.probe          = pnp_floppy_probe,
+};
+
+static int pnp_floppy_init(void)
+{
+	int err;
+
+	if (no_pnp_floppy) {
+		printk("%s: PNP detection disabled\n", DEVICE_NAME);
+		return 0;
+	}
+
+	err = pnp_register_driver(&pnp_floppy_driver);
+	if (err > 0) {
+		pnp_floppy_registered = 1;
+		err = 0;
+	}
+	else if (err == 0) {
+		pnp_unregister_driver(&pnp_floppy_driver);
+		err = -ENODEV;
+	}
+
+	return err;
+}
+
+static void pnp_floppy_exit(void)
+{
+	if (pnp_floppy_registered) {
+		pnp_unregister_driver(&pnp_floppy_driver);
+		pnp_floppy_registered = 0;
+	}
+}
+#endif
+
+#ifdef CONFIG_ACPI
+static int acpi_floppies;
 
 static acpi_status __init acpi_floppy_resource(struct acpi_resource *res, void *data)
 {
@@ -4404,9 +4562,19 @@
 
 #ifdef CONFIG_ACPI
 	err = acpi_floppy_init();
-	if (err < 0)
-		return err;
+	if (err < 0) /*ACPI don't detect floppy*/
 #endif
+#ifdef CONFIG_PNP
+	{
+		err = pnp_floppy_init();
+		if (err)
+			return err;
+	}
+#else
+#ifdef CONFIG_ACPI
+		return err;
+#endif	
+#endif	
 
 	raw_cmd = NULL;
 
@@ -4808,6 +4976,10 @@
 	/* eject disk, if any */
 	fd_eject(0);
 
+#ifdef CONFIG_PNP
+	pnp_floppy_exit();
+#endif
+
 	wait_for_completion(&device_release);
 }
 

--------------000208050605040306040903--
