Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTDGXEU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTDGXC1 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:02:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46976
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263784AbTDGWyk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:54:40 -0400
Date: Tue, 8 Apr 2003 01:12:48 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080012.h380Cmqg008993@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: unversion.h and compatmac applicom.c
Cc: dwmw2@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/char/applicom.c linux-2.5.67-ac1/drivers/char/applicom.c
--- linux-2.5.67/drivers/char/applicom.c	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.67-ac1/drivers/char/applicom.c	2003-04-04 00:03:46.000000000 +0100
@@ -29,22 +29,12 @@
 #include <linux/pci.h>
 #include <linux/wait.h>
 #include <linux/init.h>
-#include <linux/compatmac.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
 #include "applicom.h"
 
-#if LINUX_VERSION_CODE < 0x20300 
-/* These probably want adding to <linux/compatmac.h> */
-#define init_waitqueue_head(x) do { *(x) = NULL; } while (0)
-#define PCI_BASE_ADDRESS(dev) (dev->base_address[0])
-#define DECLARE_WAIT_QUEUE_HEAD(x) struct wait_queue *x
-#define __setup(x,y) /* */
-#else
-#define PCI_BASE_ADDRESS(dev) (dev->resource[0].start)
-#endif
 
 /* NOTE: We use for loops with {write,read}b() instead of 
    memcpy_{from,to}io throughout this driver. This is because
@@ -220,18 +210,18 @@
 		if (pci_enable_device(dev))
 			return -EIO;
 
-		RamIO = ioremap(PCI_BASE_ADDRESS(dev), LEN_RAM_IO);
+		RamIO = ioremap(dev->resource[0].start, LEN_RAM_IO);
 
 		if (!RamIO) {
-			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", PCI_BASE_ADDRESS(dev));
+			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", dev->resource[0].start);
 			return -EIO;
 		}
 
 		printk(KERN_INFO "Applicom %s found at mem 0x%lx, irq %d\n",
-		       applicom_pci_devnames[dev->device-1], PCI_BASE_ADDRESS(dev), 
+		       applicom_pci_devnames[dev->device-1], dev->resource[0].start, 
 		       dev->irq);
 
-		if (!(boardno = ac_register_board(PCI_BASE_ADDRESS(dev),
+		if (!(boardno = ac_register_board(dev->resource[0].start,
 						  (unsigned long)RamIO,0))) {
 			printk(KERN_INFO "ac.o: PCI Applicom device doesn't have correct signature.\n");
 			iounmap(RamIO);
