Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUHVPRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUHVPRh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUHVPRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:17:37 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:7049 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267413AbUHVPQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:16:40 -0400
Date: Sun, 22 Aug 2004 17:16:34 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1-mm3: Fix ACPI floppy enumeration
Message-ID: <20040822151634.GG24092@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  current acpi-based-floppy-controller-enumeration.patch assumes that in ACPI enumeration
floppy is listed as using I/O ports 0x3F2-0x3F5 or 0x3F2-0x3F7.  But on my notebook
(Compaq EVO N800C) it reports TWO ranges, 0x3F0-0x3F5 and 0x3F7-0x3F7.  Which breaks
floppy badly, as it then attempts to find floppy at 0x3F5-0x3FC (0x3F7-2), and dies
because 0x3F8-0x3FF is already used by serial port.  This also revealed some problems
in acpi unregistration, which did not occur, crashing system shortly after floppy driver
failed to load, or was unloaded...

  This change:

(1) Ignore three bottom bits on floppy regions. I cannot imagine anybody building
    floppy device with which would cross two 8 byte regions...  This solves primary
    problem I had with acpi enumeration.

(2) Unregister acpi bus driver on failure path in module_init.

(3) Unregister acpi bus driver in module's cleanup.

(4) Also moved #ifdef CONFIG_ACPI_BUS to the function declaration, providing
    dummy acpi_floppy_init() and acpi_floppy_stop() in the case ACPI bus
    enumeration is disabled.

inserting floppy driver for 2.6.8.1-mm3
floppy: controller ACPI C141 at I/O 0x3f2 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306

08057b2b:           Name C13E (\_SB_.C03C.C04F.C120.C141.C13E)
08057b30:             Buffer
08057b32:               0x18
08057b34:               ByteList <0x47 0x01 0xf0 0x03 0xf0 0x03 0x01 0x06
08057b34:                             0x47 0x01 0xf7 0x03 0xf7 0x03 0x01 0x01
08057b34:                             0x22 0x40 0x00 0x2a 0x04 0x00 0x79 0x00>
08057b34:               Interpreted as PnP Resource Descriptor:
08057b34:               I/O Ports: 16 bit address decoding,
08057b34:               minbase 0x3f0, maxbase 0x3f0, align 0x1, count 0x6
08057b34:               I/O Ports: 16 bit address decoding,
08057b34:               minbase 0x3f7, maxbase 0x3f7, align 0x1, count 0x1
08057b34:               IRQ mask: 0000000010000000
08057b34:               Info: high true edge sensitive
08057b34:               DMA mask: 00001000
08057b34:               DMA channel speed: compatibility mode; transfer type: 8-bit
08057b34:               Bad checksum 0x7c, should be 0

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urN linux/drivers/block/floppy.c linux/drivers/block/floppy.c
--- linux/drivers/block/floppy.c	2004-08-21 00:51:54.000000000 +0200
+++ linux/drivers/block/floppy.c	2004-08-21 15:18:00.000000000 +0200
@@ -150,6 +150,7 @@
 /* do print messages for unexpected interrupts */
 static int print_unex = 1;
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -4234,10 +4235,10 @@
 
 #ifdef CONFIG_ACPI_BUS
 static int acpi_floppies;
+static int acpi_floppy_registered;
 
 struct floppy_resources {
 	unsigned int port;
-	unsigned int nr_ports;
 	unsigned int irq;
 	unsigned int dma_channel;
 };
@@ -4253,8 +4254,23 @@
 	if (res->id == ACPI_RSTYPE_IO) {
 		io = &res->data.io;
 		if (io->range_length) {
-			floppy->port = io->min_base_address;
-			floppy->nr_ports = io->range_length;
+			/*
+			 * The driver assumes I/O port regions like 0x3f0-0x3f7, but it
+			 * ignores the first two ports (i.e., 0x3f0 and 0x3f1), which are
+			 * for PS/2 systems, and 0x3f6 used by IDE.
+			 *
+			 * There are following possible configurations:
+			 *
+			 * 1 region,  0x03F2-0x03F5        [ 0x03F7 is not reported at all ]
+			 * 1 region,  0x03F0-0x03F5        [ 0x03F7 is not reported at all ]
+			 * 1 region,  0x03F0-0x03F7        [ 0x03F6 is claimed as used ]
+			 * 2 regions, 0x03F2-0x03F5; 0x03F7-0x03F7
+			 * 2 regions, 0x03F0-0x03F5; 0x03F7-0x03F7
+			 *
+			 * Let's simple ignore low three bits of region base...
+			 */
+
+			floppy->port = io->min_base_address & ~7;
 		}
 	} else if (res->id == ACPI_RSTYPE_IRQ) {
 		irq = &res->data.irq;
@@ -4285,25 +4301,18 @@
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	printk("%s: controller ACPI %s at I/O 0x%x-0x%x irq %d dma channel %d\n",
+	printk("%s: controller ACPI %s at I/O 0x%x irq %d dma channel %d\n",
 		DEVICE_NAME, device->pnp.bus_id,
-		floppy.port, floppy.port + floppy.nr_ports - 1,
+		floppy.port + 2,
 		floppy.irq, floppy.dma_channel);
 
-	/*
-	 * The driver assumes I/O port regions like 0x3f0-0x3f5, but it
-	 * ignores the first two ports (i.e., 0x3f0 and 0x3f1), which are
-	 * for PS/2 systems.  Since no PS/2 systems have ACPI, we should
-	 * get a region like 0x3f2-0x3f5, so we adjust it down to what the
-	 * driver expects.
-	 */
 	acpi_floppies++;
 	if (acpi_floppies == 1) {
-		FDC1 = floppy.port - 2;
+		FDC1 = floppy.port;
 		FLOPPY_IRQ = floppy.irq;
 		FLOPPY_DMA = floppy.dma_channel;
 	} else if (acpi_floppies == 2) {
-		FDC2 = floppy.port - 2;
+		FDC2 = floppy.port;
 		if (floppy.irq != FLOPPY_IRQ || floppy.dma_channel != FLOPPY_DMA)
 			printk(KERN_WARNING "%s: different IRQ/DMA info for %s; may not work\n",
 				DEVICE_NAME, device->pnp.bus_id);
@@ -4334,10 +4343,25 @@
 
 static int acpi_floppy_init(void)
 {
+	int err;
+
 	if (no_acpi)
 		return -ENODEV;
-	return acpi_bus_register_driver(&acpi_floppy_driver);
+	err = acpi_bus_register_driver(&acpi_floppy_driver);
+	acpi_floppy_registered = err >= 0;
+	return err;
+}
+
+static void acpi_floppy_stop(void)
+{
+	if (acpi_floppy_registered) {
+		acpi_bus_unregister_driver(&acpi_floppy_driver);
+		acpi_floppy_registered = 0;
+	}
 }
+#else
+static int  acpi_floppy_init(void) { return -ENODEV; }
+static void acpi_floppy_stop(void) { }
 #endif
 
 int __init floppy_init(void)
@@ -4345,10 +4369,16 @@
 	int i, unit, drive;
 	int err, dr;
 
-#ifdef CONFIG_ACPI_BUS
-	if (acpi_floppy_init() == 0)
-		return -ENODEV;
-#endif
+	if (acpi_floppy_init() == 0) {
+		/*
+		 * Well, I do not know how author intended that as
+		 * it blocks floppy on systems with ACPI which do
+		 * not report floppy drive in its ACPI description,
+		 * but...
+		 */
+		err = -ENODEV;
+		goto out_put_acpi;
+	}
 
 	raw_cmd = NULL;
 
@@ -4527,6 +4557,8 @@
 		del_timer(&motor_off_timer[dr]);
 		put_disk(disks[dr]);
 	}
+out_put_acpi:
+	acpi_floppy_stop();
 	return err;
 }
 
@@ -4743,6 +4775,8 @@
 	/* eject disk, if any */
 	fd_eject(0);
 
+	acpi_floppy_stop();
+
 	wait_for_completion(&device_release);
 }
 
