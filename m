Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbUKEO71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUKEO71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUKEO70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:59:26 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:8869 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261632AbUKEO6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:58:09 -0500
Message-ID: <418B94FF.3050208@free.fr>
Date: Fri, 05 Nov 2004 15:58:07 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] pnpapci 2.6.10-rc1-mm2
Content-Type: multipart/mixed;
 boundary="------------090509070503080507080404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090509070503080507080404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

these patches fix the problem the people encounter with mm2 :
it add a pnp driver for floppy and i8042 (I don't touch the acpi driver 
as I was ask by the acpi people).

The 2 others patches limit the devices that are add in the pnp layer. So 
now people could load other acpi driver.

It is repported to work [1].

Please try it, so I could know if there no other acpi driver that are 
blocked.

Thanks

Matthieu

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=109959238701702&w=2

PS : in the mm3, the acpi people remove the lock of the acpi device that 
are in pnp layer, so you can load a pnp driver and a acpi driver for the 
same device like before...
So don't apply these patches on mm3 or use drivers/pnp/pnpacpi/core.c 
form mm2

--------------090509070503080507080404
Content-Type: text/x-patch;
 name="floppy_pnp_acpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="floppy_pnp_acpi.patch"

--- linux-2.6.9/drivers/block/floppy.c.old	2004-11-04 16:13:41.000000000 +0100
+++ linux-2.6.9/drivers/block/floppy.c	2004-11-05 15:29:42.000000000 +0100
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
@@ -4232,10 +4241,7 @@
 	return get_disk(disks[drive]);
 }
 
-#ifdef CONFIG_ACPI
-static int acpi_floppy_registered;
-static int acpi_floppies;
-
+#if defined(CONFIG_PNP) || defined(CONFIG_ACPI)
 struct region {
 	unsigned int base;
 	unsigned int size;
@@ -4247,6 +4253,141 @@
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
+	if (pnp_port_valid(dev,0) &&
+		!(pnp_port_flags(dev,0) & IORESOURCE_DISABLED)) {
+		fd.io_region[0].base = pnp_port_start(dev,0);
+		fd.io_region[0].size = pnp_port_len(dev,0);
+		fd.nr_io_regions = 1;
+	}
+
+	if (pnp_port_valid(dev,1) &&
+		!(pnp_port_flags(dev,1) & IORESOURCE_DISABLED)) {
+		fd.io_region[1].base = pnp_port_start(dev,1);
+		fd.io_region[1].size = pnp_port_len(dev,1);
+		fd.nr_io_regions = 2;
+	}
+
+	if (pnp_irq_valid(dev,0) &&
+		!(pnp_irq_flags(dev,0) & IORESOURCE_DISABLED))
+		fd.irq = pnp_irq(dev,0);
+
+	if (pnp_dma_valid(dev,0) &&
+		!(pnp_dma_flags(dev,0) & IORESOURCE_DISABLED))
+		fd.dma_channel = pnp_dma(dev,0);
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
+		return -ENODEV;
+	}
+	err = pnp_register_driver(&pnp_floppy_driver);
+	if (err >= 0)
+		pnp_floppy_registered = 1;
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
+#else
+static inline int  pnp_floppy_init(void) { return -ENODEV; }
+static inline void pnp_floppy_exit(void) { }
+#endif
+
+#ifdef CONFIG_ACPI
+static int acpi_floppy_registered;
+static int acpi_floppies;
 
 static acpi_status acpi_floppy_resource(struct acpi_resource *res, void *data)
 {
@@ -4401,6 +4542,11 @@
 	int i, unit, drive;
 	int err, dr;
 
+	if (pnp_floppy_init() == 0) {
+		err = -ENODEV;
+		goto out_put_pnp;
+	}
+
 	if (acpi_floppy_init() == 0) {
 		err = -ENODEV;
 		goto out_put_acpi;
@@ -4590,6 +4736,9 @@
 		del_timer(&motor_off_timer[dr]);
 		put_disk(disks[dr]);
 	}
+out_put_pnp:
+	pnp_floppy_exit();
+	return err;
 out_put_acpi:
 	acpi_floppy_exit();
 	return err;
@@ -4808,6 +4957,8 @@
 	/* eject disk, if any */
 	fd_eject(0);
 
+	pnp_floppy_exit();
+
 	acpi_floppy_exit();
 
 	wait_for_completion(&device_release);

--------------090509070503080507080404
Content-Type: text/x-patch;
 name="i8042_pnp_acpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8042_pnp_acpi.patch"

--- linux-2.6.9/drivers/input/serio/i8042.c.old	2004-11-04 10:28:58.000000000 +0100
+++ linux-2.6.9/drivers/input/serio/i8042.c	2004-11-05 15:16:24.000000000 +0100
@@ -61,6 +61,12 @@
 MODULE_PARM_DESC(noacpi, "Do not use ACPI to detect controller settings");
 #endif
 
+#ifdef CONFIG_PNP
+static int i8042_nopnp;
+module_param_named(nopnp, i8042_nopnp, bool, 0);
+MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
+#endif
+
 #define DEBUG
 #ifdef DEBUG
 static int i8042_debug;
--- linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h.old	2004-11-04 10:29:11.000000000 +0100
+++ linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h	2004-11-05 15:20:03.000000000 +0100
@@ -88,6 +88,116 @@
 };
 #endif
 
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static int i8042_pnp_kbd_registered;
+static int i8042_pnp_aux_registered;
+
+
+static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_data_reg = pnp_port_start(dev,0);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no data port; default is 0x%x\n",
+			pnp_dev_name(dev), i8042_data_reg);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_command_reg = pnp_port_start(dev,1);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no command port; default is 0x%x\n",
+			pnp_dev_name(dev), i8042_command_reg);
+
+	if (pnp_irq_valid(dev,0))
+		i8042_kbd_irq = pnp_irq(dev,0);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no IRQ; default is %d\n",
+			pnp_dev_name(dev), i8042_kbd_irq);
+
+	printk("PNP: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
+		"PS/2 Keyboard Controller", pnp_dev_name(dev),
+		i8042_data_reg, i8042_command_reg, i8042_kbd_irq);
+
+	return 0;
+}
+
+static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_irq_valid(dev,0))
+		i8042_aux_irq = pnp_irq(dev,0);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no IRQ; default is %d\n",
+			pnp_dev_name(dev), i8042_aux_irq);
+
+	printk("PNP: %s [%s] at irq %d\n",
+		"PS/2 Mouse Controller", pnp_dev_name(dev), i8042_aux_irq);
+
+	return 0;
+}
+
+static struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver i8042_pnp_kbd_driver = {
+	.name           = "i8042 kbd",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+};
+
+static struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
+};
+
+static int i8042_pnp_init(void)
+{
+	int result;
+
+	if (i8042_nopnp) {
+		printk("i8042: PNP detection disabled\n");
+		return 0;
+	}
+
+	result = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (result < 0)
+		return result;
+
+	if (result == 0) {
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+		return -ENODEV;
+	}
+	i8042_pnp_kbd_registered = 1;
+
+	result = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (result >= 0)
+		i8042_pnp_aux_registered = 1;
+	if (result == 0)
+		i8042_noaux = 1;
+
+	return 0;
+}
+
+static void i8042_pnp_exit(void)
+{
+	if (i8042_pnp_kbd_registered)
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+
+	if (i8042_pnp_aux_registered)
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
+}
+#endif
+
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -281,6 +391,11 @@
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
+#ifdef CONFIG_PNP
+	if (i8042_pnp_init())
+		return -1;
+#endif
+
 #ifdef CONFIG_ACPI
 	if (i8042_acpi_init())
 		return -1;
@@ -300,6 +415,9 @@
 
 static inline void i8042_platform_exit(void)
 {
+#ifdef CONFIG_PNP
+	i8042_pnp_exit();
+#endif
 #ifdef CONFIG_ACPI
 	i8042_acpi_exit();
 #endif

--------------090509070503080507080404
Content-Type: text/x-patch;
 name="pnpacpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/core.c.old	2004-11-04 11:56:25.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-04 12:13:46.000000000 +0100
@@ -239,7 +239,11 @@
 static int acpi_pnp_match(struct acpi_device *device,
 	struct acpi_driver	*driver)
 {
-	return (!ispnpidacpi(acpi_device_hid(device)) ||
+	acpi_handle temp = NULL;
+	acpi_status status;
+	/* don't lock non standard pnp device */
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	return (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
 		is_exclusive_device(device));
 }
 

--------------090509070503080507080404
Content-Type: text/x-patch;
 name="pnpacpi1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi1.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/core.c.old	2004-11-04 11:56:25.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-04 19:46:30.000000000 +0100
@@ -27,14 +27,15 @@
 static int num = 0;
 
 static char excluded_id_list[] =
-	"PNP0C0A," /* Battery */
-	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C0A," /* Battery */ /* is there a CRS ?*/
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */ /* is there a CRS ?*/
+	"PNP0C0B," /* Fan */ /* is there a CRS ?*/
 	"PNP0C09," /* EC */
-	"PNP0C0B," /* Fan */
 	"PNP0A03," /* PCI root */
 	"PNP0C0F," /* Link device */
 	"PNP0000," /* PIC */
 	"PNP0100," /* Timer */
+	"PNP0103," /* hpet could be converted, but need work on irq/address */
 	;
 static inline int is_exclusive_device(struct acpi_device *dev)
 {

--------------090509070503080507080404--
