Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266096AbRGGLKY>; Sat, 7 Jul 2001 07:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbRGGLKO>; Sat, 7 Jul 2001 07:10:14 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:41995 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S266086AbRGGLKD>; Sat, 7 Jul 2001 07:10:03 -0400
Date: Sat, 7 Jul 2001 06:10:00 -0500
To: Juergen Fischer <fischer@norbit.de>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] isapnp for aha152x
Message-ID: <20010707061000.R5893@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, so it's a hack, but device detection in aha152x is already a hack.
I haven't actually tested it (I have no devices on my card) but at
least insmod works. (:

Peter

--- drivers/scsi/aha152x.c~	Tue Mar  6 17:35:47 2001
+++ drivers/scsi/aha152x.c	Sat Jul  7 06:06:00 2001
@@ -238,6 +238,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/isapnp.h>
 #include <asm/semaphore.h>
 #include <linux/spinlock.h>
 
@@ -385,6 +386,16 @@
 MODULE_PARM_DESC(aha152x1, "parameters for second controller");
 static int aha152x1[]  = {0, 11, 7, 1, 1, 1, DELAY_DEFAULT, 0, DEBUG_DEFAULT};
 #endif /* !defined(AHA152X_DEBUG) */
+
+#ifdef __ISAPNP__
+
+static struct isapnp_device_id id_table[] __devinitdata = {
+	{ ISAPNP_DEVICE_SINGLE('A','D','P',0x1505, 'A','D','P',0x1505), },
+	{ ISAPNP_DEVICE_SINGLE_END, }
+};
+MODULE_DEVICE_TABLE(isapnp, id_table);
+
+#endif /* ISAPNP */
 #endif /* MODULE */
 
 /* set by aha152x_setup according to the command line */
@@ -940,12 +951,18 @@
 	SETPORT(DMACNTRL0, INTEN);
 }
 
-
+#ifdef __ISAPNP__
+static struct pci_dev *pnpdev[2];
+static int num_pnpdevs;
+#endif
 int aha152x_detect(Scsi_Host_Template * tpnt)
 {
 	int i, j, ok;
 #if defined(AUTOCONF)
 	aha152x_config conf;
+#ifdef __ISAPNP__
+	struct pci_dev *dev = NULL;
+#endif
 #endif
 	tpnt->proc_name = "aha152x"; 
 
@@ -962,6 +979,29 @@
 			}
 		printk("ok\n");
 	}
+#ifdef __ISAPNP__
+	while (setup_count <= 2 &&
+	       (dev = isapnp_find_dev (NULL, ISAPNP_VENDOR('A','D','P'),
+				       ISAPNP_FUNCTION(0x1505), dev))) {
+		if (dev->prepare(dev) < 0)
+			continue;
+		if (dev->active)
+			continue;
+		if (!(dev->resource[0].flags & IORESOURCE_IO))
+			continue;
+		dev->resource[0].flags |= IORESOURCE_AUTO;
+		if (dev->activate(dev) < 0)
+			continue;
+		setup[setup_count].io_port = dev->resource[0].start;
+		setup[setup_count].irq = dev->irq_resource[0].start;
+		pnpdev[num_pnpdevs++] = dev;
+		printk (KERN_INFO
+			"aha152x: found ISAPnP AVA-1505A at address 0x%03X, IRQ %d\n",
+			setup[setup_count].io_port, setup[setup_count].irq);
+		setup_count++;
+	}
+#endif
+
 #if defined(SETUP0)
 	if (setup_count < 2) {
 		struct aha152x_setup override = SETUP0;
@@ -1349,6 +1389,10 @@
 	if (shpnt->io_port)
 		release_region(shpnt->io_port, IO_RANGE);
 
+#ifdef __ISAPNP__
+	while (num_pnpdevs--)
+		pnpdev[num_pnpdevs]->deactivate(pnpdev[num_pnpdevs]);
+#endif
 	scsi_unregister(shpnt);
 
 	return 0;
