Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUDRLrc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 07:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbUDRLrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 07:47:32 -0400
Received: from verein.lst.de ([212.34.189.10]:23245 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264044AbUDRLrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 07:47:00 -0400
Date: Sun, 18 Apr 2004 13:46:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: dafastidio@libero.it
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [CFT] dmx3191 updates
Message-ID: <20040418114657.GA11466@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, dafastidio@libero.it,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.849 () BAYES_00,DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the dmx3191 driver to modern PCI and SCSI APIs.
While I don't see how this c ould break I'd like to get some positive
feedback first.


--- 1.15/drivers/scsi/dmx3191d.c	Thu Sep 11 02:07:25 2003
+++ edited/drivers/scsi/dmx3191d.c	Sun Apr 18 12:35:57 2004
@@ -1,7 +1,7 @@
-
 /*
-    dmx3191d.c - midlevel driver for the Domex DMX3191D SCSI card.
+    dmx3191d.c - driver for the Domex DMX3191D SCSI card.
     Copyright (C) 2000 by Massimo Piccioni <dafastidio@libero.it>
+    Copyright (C) 2004 by Christoph Hellwig <hch@lst.de> (Updates for Linux 2.6)
 
     Based on the generic NCR5380 driver by Drew Eckhardt et al.
 
@@ -20,117 +20,153 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <asm/io.h>
-#include <asm/system.h>
-#include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/stat.h>
 #include <linux/interrupt.h>
-#include <linux/delay.h>
+#include <asm/io.h>
 
-#include "scsi.h"
-#include "hosts.h"
+#include <scsi/scsi_host.h>
 
-#include "dmx3191d.h"
+/*
+ * Defintions for the generic 5380 driver.
+ */
+#define AUTOSENSE
+
+#define NCR5380_read(reg)			inb(port + reg)
+#define NCR5380_write(reg, value)		outb(value, port + reg)
+
+#define NCR5380_implementation_fields		unsigned int port
+#define NCR5380_local_declare()			NCR5380_implementation_fields
+#define NCR5380_setup(instance)			port = instance->io_port
 
-/* play with these values to tune up your system performances */
-/* default setting from g_NCR5380.c */
 /*
-#define USLEEP
-#define USLEEP_POLL		1
-#define USLEEP_SLEEP		20
-#define USLEEP_WAITLONG		500
-*/
+ * Includes needed for NCR5380.[ch] (XXX: Move them to NCR5380.h)
+ */
+#include <linux/delay.h>
+#include "scsi.h"
 
-#define AUTOSENSE
+/*
+ * Generic 5380 core.  For now we compile a separate copy per driver.
+ */
 #include "NCR5380.h"
 #include "NCR5380.c"
 
 
-static int __init dmx3191d_detect(Scsi_Host_Template *tmpl) {
-	int boards = 0;
-	struct Scsi_Host *instance = NULL;
-	struct pci_dev *pdev = NULL;
-
-	tmpl->proc_name = DMX3191D_DRIVER_NAME;
-
-	while ((pdev = pci_find_device(PCI_VENDOR_ID_DOMEX,
-			PCI_DEVICE_ID_DOMEX_DMX3191D, pdev))) {
-
-		unsigned long port;
-		if (pci_enable_device(pdev))
-			continue;
-
-		port = pci_resource_start (pdev, 0);
-		
-		if (!request_region(port, DMX3191D_REGION, DMX3191D_DRIVER_NAME)) {
-			printk(KERN_ERR "dmx3191: region 0x%lx-0x%lx already reserved\n",
-				port, port + DMX3191D_REGION);
-			continue;
-		}
-
-		instance = scsi_register(tmpl, sizeof(struct NCR5380_hostdata));
-		if(instance == NULL)
-		{
-			release_region(port, DMX3191D_REGION);
-			continue;
-		}
-		scsi_set_device(instance, &pdev->dev);
-		instance->io_port = port;
-		instance->irq = pdev->irq;
-		NCR5380_init(instance, FLAG_NO_PSEUDO_DMA | FLAG_DTC3181E);
-
-		if (request_irq(pdev->irq, dmx3191d_intr, SA_SHIRQ,
-				DMX3191D_DRIVER_NAME, instance)) {
-			printk(KERN_WARNING "dmx3191: IRQ %d not available - switching to polled mode.\n", pdev->irq);
-			/* Steam powered scsi controllers run without an IRQ
-			   anyway */
-			instance->irq = SCSI_IRQ_NONE;
-		}
+#define DMX3191D_DRIVER_NAME	"dmx3191d"
+#define DMX3191D_REGION		8
+
+static struct scsi_host_template dmx3191d_driver_template = {
+	.proc_name		= DMX3191D_DRIVER_NAME,
+	.name			= "Domex DMX3191D",
+	.queuecommand		= NCR5380_queue_command,
+	.eh_abort_handler	= NCR5380_abort,
+	.eh_bus_reset_handler	= NCR5380_bus_reset,
+	.eh_device_reset_handler= NCR5380_device_reset,
+	.eh_host_reset_handler	= NCR5380_host_reset,
+	.can_queue		= 32,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 2,
+	.use_clustering		= DISABLE_CLUSTERING,
+};
 
-		boards++;
+static int __devinit dmx3191d_probe_one(struct pci_dev *pdev,
+		const struct pci_device_id *id)
+{
+	struct Scsi_Host *shost;
+	unsigned long io;
+	int error = -ENODEV;
+
+	if (pci_enable_device(pdev))
+		goto out;
+
+	io = pci_resource_start(pdev, 0);
+	if (!request_region(io, DMX3191D_REGION, DMX3191D_DRIVER_NAME)) {
+		printk(KERN_ERR "dmx3191: region 0x%lx-0x%lx already reserved\n",
+			io, io + DMX3191D_REGION);
+		goto out_disable_device;
 	}
-	return boards;
-}
 
-static const char * dmx3191d_info(struct Scsi_Host *host) {
-	static const char *info ="Domex DMX3191D";
+	shost = scsi_host_alloc(&dmx3191d_driver_template,
+			sizeof(struct NCR5380_hostdata));
+	if (!shost)
+		goto out_release_region;
+	
+	shost->io_port = io;
+	shost->irq = pdev->irq;
+
+	NCR5380_init(shost, FLAG_NO_PSEUDO_DMA | FLAG_DTC3181E);
+
+	if (request_irq(pdev->irq, NCR5380_intr, SA_SHIRQ,
+			DMX3191D_DRIVER_NAME, shost)) {
+		/*
+		 * Steam powered scsi controllers run without an IRQ anyway
+		 */
+		printk(KERN_WARNING "dmx3191: IRQ %d not available - "
+				"switching to polled mode.\n", pdev->irq);
+		shost->irq = SCSI_IRQ_NONE;
+	}
+
+	error = scsi_add_host(shost, &pdev->dev);
+	if (error)
+		goto out_free_irq;
 
-	return info;
+	pci_set_drvdata(pdev, shost);
+	scsi_scan_host(shost);
+	return 0;
+
+ out_free_irq:
+	free_irq(shost->irq, shost);
+ out_release_region:
+	release_region(shost->io_port, DMX3191D_REGION);
+ out_disable_device:
+	pci_disable_device(pdev);
+ out:
+	return error;
 }
 
-static int dmx3191d_release_resources(struct Scsi_Host *instance)
+static void __devexit dmx3191d_remove_one(struct pci_dev *pdev)
 {
-	release_region(instance->io_port, DMX3191D_REGION);
-	if(instance->irq!=SCSI_IRQ_NONE)
-		free_irq(instance->irq, instance);
+	struct Scsi_Host *shost = pci_get_drvdata(pdev);
 
-	return 0;
+	scsi_remove_host(shost);
+
+	if (shost->irq != SCSI_IRQ_NONE)
+		free_irq(shost->irq, shost);
+	release_region(shost->io_port, DMX3191D_REGION);
+	pci_disable_device(pdev);
+
+	scsi_host_put(shost);
 }
 
-MODULE_LICENSE("GPL");
+static struct pci_device_id dmx3191d_pci_tbl[] = {
+	{PCI_VENDOR_ID_DOMEX, PCI_DEVICE_ID_DOMEX_DMX3191D,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+	{0,}
+};
 
-static Scsi_Host_Template driver_template = {
-	.proc_info		= dmx3191d_proc_info,
-	.name			= "Domex DMX3191D",
-	.detect			= dmx3191d_detect,
-	.release		= dmx3191d_release_resources,
-	.info			= dmx3191d_info,
-	.queuecommand		= dmx3191d_queue_command,
-	.eh_abort_handler	= dmx3191d_abort,
-	.eh_bus_reset_handler	= dmx3191d_bus_reset,
-	.eh_device_reset_handler = dmx3191d_device_reset,
-	.eh_host_reset_handler	= dmx3191d_host_reset,
-	.can_queue		= 32,
-        .this_id		= 7,
-        .sg_tablesize		= SG_ALL,
-	.cmd_per_lun		= 2,
-        .use_clustering		= DISABLE_CLUSTERING,
+static struct pci_driver dmx3191d_pci_driver = {
+	.name		= DMX3191D_DRIVER_NAME,
+	.id_table	= dmx3191d_pci_tbl,
+	.probe		= dmx3191d_probe_one,
+	.remove		= __devexit_p(dmx3191d_remove_one),
 };
-#include "scsi_module.c"
 
+static int __init dmx3191d_init(void)
+{
+	return pci_module_init(&dmx3191d_pci_driver);
+}
+
+static void __exit dmx3191d_exit(void)
+{
+	pci_unregister_driver(&dmx3191d_pci_driver);
+}
+
+module_init(dmx3191d_init);
+module_exit(dmx3191d_exit);
+
+MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_DESCRIPTION("Domex DMX3191D SCSI driver");
+MODULE_LICENSE("GPL");
--- 1.7/drivers/scsi/dmx3191d.h	Mon May 12 17:01:09 2003
+++ edited/drivers/scsi/dmx3191d.h	Sun Apr 18 12:29:43 2004
@@ -1,48 +0,0 @@
-/*
-    dmx3191d.h - defines for the Domex DMX3191D SCSI card.
-    Copyright (C) 2000 by Massimo Piccioni <dafastidio@libero.it>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-*/
-
-#ifndef __DMX3191D_H
-#define __DMX3191D_H
-
-#define DMX3191D_DRIVER_NAME	"dmx3191d"
-#define DMX3191D_REGION		8
-
-#ifndef PCI_VENDOR_ID_DOMEX
-#define PCI_VENDOR_ID_DOMEX		0x134a
-#define PCI_DEVICE_ID_DOMEX_DMX3191D	0x0001
-#endif
-
-static int dmx3191d_abort(Scsi_Cmnd *);
-static int dmx3191d_detect(Scsi_Host_Template *);
-static const char* dmx3191d_info(struct Scsi_Host *);
-static int dmx3191d_queue_command(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-static int dmx3191d_release_resources(struct Scsi_Host *);
-static int dmx3191d_bus_reset(Scsi_Cmnd *);
-static int dmx3191d_host_reset(Scsi_Cmnd *);
-static int dmx3191d_device_reset(Scsi_Cmnd *);
-
-#define NCR5380_read(reg)			inb(port + reg)
-#define NCR5380_write(reg, value)		outb(value, port + reg)
-
-#define NCR5380_implementation_fields		unsigned int port
-#define NCR5380_local_declare()			NCR5380_implementation_fields
-#define NCR5380_setup(instance)			port = instance->io_port
-
-#define NCR5380_abort				dmx3191d_abort
-#define do_NCR5380_intr				dmx3191d_do_intr
-#define NCR5380_intr				dmx3191d_intr
-#define NCR5380_proc_info			dmx3191d_proc_info
-#define NCR5380_queue_command			dmx3191d_queue_command
-#define NCR5380_host_reset			dmx3191d_host_reset
-#define NCR5380_bus_reset			dmx3191d_bus_reset
-#define NCR5380_device_reset			dmx3191d_device_reset
-
-#endif	/* __DMX3191D_H */
-
