Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWJDHqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWJDHqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWJDHqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:46:20 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:49822 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1030641AbWJDHqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:46:19 -0400
Date: Wed, 4 Oct 2006 16:45:36 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       rmk@arm.linux.org.uk, gregkh@suse.de, ysato@users.sourceforge.jp
Subject: [PATCH] Generic platform device IDE driver
Message-ID: <20061004074535.GA7180@localhost.hsdv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the platforms that have very simplistic needs for IDE devices
are forced to invent their own driver for adding the built-in devices.
At the moment ARM is the in-tree user in this category, h8300 could be
switched to something more generic, and SH is roughly in the same
category as ARM.

The only constant that really tends to change between these platforms
are the I/O base and the IRQ, with everything else rather constant. The
ctl base could also change, but everyone seems to keep it at 0x206, so
it's debatable whether it's worth leaving this configurable or not.

I've hacked together a quick driver, 'ide-platform' (for lack of a
better name), that allows for these specifics to be passed in via
platform device resources (registering a device per-port) rather than
having to add more of these things to drivers/ide.

With this we can remove ide_arm (and the h8300 driver can likely be
reworked to use this too), and I don't have to invent a new driver for
SH that does effectively the same thing.

This is intended purely for the simple NO_DMA ide_generic case.. nothing
complicated.

What do people think about this, is there a better way to do this?

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/ide/Makefile       |    3 +-
 drivers/ide/ide-platform.c |   60 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ide/ide.c          |    3 ++
 3 files changed, 65 insertions(+), 1 deletion(-)

commit f2da2c8c9b5e648ca9a43d9d3fed9bcd356f0efd
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Wed Oct 4 16:41:21 2006 +0900

    ide: Simple platform device IDE driver.
    
    This adds a trivial platform device IDE driver. Users are required to
    register a couple of resources:
    
    	- I/O Base
    	- CTL Base
    	- IRQ
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 569fae7..24c9a0f 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -13,7 +13,8 @@ EXTRA_CFLAGS				+= -Idrivers/ide
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
 
-ide-core-y += ide.o ide-io.o ide-iops.o ide-lib.o ide-probe.o ide-taskfile.o
+ide-core-y += ide.o ide-io.o ide-iops.o ide-lib.o ide-probe.o ide-taskfile.o \
+	      ide-platform.o
 
 ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
 
diff --git a/drivers/ide/ide-platform.c b/drivers/ide/ide-platform.c
new file mode 100644
index 0000000..6d89878
--- /dev/null
+++ b/drivers/ide/ide-platform.c
@@ -0,0 +1,60 @@
+/*
+ * Generic IDE platform device driver
+ *
+ * Copyright (C) 2006  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <linux/platform_device.h>
+
+/*
+ * Users use per-port registration with a simple set of 3 resources
+ * per port:
+ * 		- I/O Base (IORESOURCE_IO)
+ * 		- CTL Base (IORESOURCE_IO)
+ * 		- IRQ	   (IORESOURCE_IRQ)
+ */
+static int __devinit ide_platform_probe(struct platform_device *dev)
+{
+	struct resource *io_res, *ctl_res;
+	hw_regs_t hw;
+
+	if (unlikely(dev->num_resources != 3)) {
+		dev_err(&dev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	io_res = platform_get_resource(dev, IORESOURCE_IO, 0);
+	if (unlikely(io_res == NULL))
+		return -EINVAL;
+
+	ctl_res = platform_get_resource(dev, IORESOURCE_IO, 1);
+	if (unlikely(ctl_res == NULL))
+		return -EINVAL;
+
+	memset(&hw, 0, sizeof(hw_regs_t));
+	ide_std_init_ports(&hw, io_res->start, ctl_res->start);
+
+	hw.irq		= platform_get_irq(dev, 0);
+	hw.chipset	= ide_generic;
+
+	return ide_register_hw(&hw, NULL);
+}
+
+static struct platform_driver ide_platform_driver = {
+	.probe		= ide_platform_probe,
+	.driver		= {
+		.name	= "ide-platform",
+		.owner	= THIS_MODULE,
+	},
+};
+
+void __init ide_platform_init(void)
+{
+	printk(KERN_INFO "ide-platform: platform device IDE interface\n");
+	platform_driver_register(&ide_platform_driver);
+}
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 287a662..994cdd4 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1782,6 +1782,7 @@ done:
 }
 
 extern void pnpide_init(void);
+extern void ide_platform_init(void);
 extern void h8300_ide_init(void);
 
 /*
@@ -1793,6 +1794,8 @@ #ifdef CONFIG_BLK_DEV_IDEPCI
 	ide_scan_pcibus(ide_scan_direction);
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
+	ide_platform_init();
+
 #ifdef CONFIG_ETRAX_IDE
 	{
 		extern void init_e100_ide(void);
