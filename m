Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRBGTBD>; Wed, 7 Feb 2001 14:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130056AbRBGTAx>; Wed, 7 Feb 2001 14:00:53 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:7623 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S130054AbRBGTAr>; Wed, 7 Feb 2001 14:00:47 -0500
Date: Wed, 7 Feb 2001 19:00:29 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: <saw@saw.sw.com.sg>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] eepro100 reads pdev-> before pci_enable
Message-ID: <Pine.LNX.4.31.0102071858080.17466-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As in the previous patches, this driver also reads pdev->irq
and pdev->resource before doing a pci_enable.
This looks correct to me, and compiles, I lack the hardware
to test this though. Comments ?

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro100.c linux-dj/drivers/net/eepro100.c
--- linux/drivers/net/eepro100.c	Wed Feb  7 12:42:39 2001
+++ linux-dj/drivers/net/eepro100.c	Wed Feb  7 18:51:45 2001
@@ -557,6 +557,17 @@
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);

+	/* save power state b4 pci_enable_device overwrites it */
+	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	if (pm) {
+		u16 pwr_command;
+		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
+		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
+	}
+
+	if (pci_enable_device(pdev))
+		goto err_out_none;
+
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
 		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
@@ -586,17 +597,6 @@
 		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx, IRQ %d.\n",
 			   pci_resource_start(pdev, 0), irq);
 #endif
-
-	/* save power state b4 pci_enable_device overwrites it */
-	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
-	if (pm) {
-		u16 pwr_command;
-		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
-		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
-	}
-
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;

 	pci_set_master(pdev);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
