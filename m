Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSL2WDM>; Sun, 29 Dec 2002 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSL2WDM>; Sun, 29 Dec 2002 17:03:12 -0500
Received: from ra.abo.fi ([130.232.213.1]:36084 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S262023AbSL2WDL>;
	Sun, 29 Dec 2002 17:03:11 -0500
Date: Mon, 30 Dec 2002 00:11:31 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: trivial@rustcorp.com.au
cc: jgarzik@mandrakesoft.com, <linux-kernel@vger.kernel.org>
Subject: [patch, 2.5] net/pcnet32.c remove check_region
Message-ID: <Pine.LNX.4.44.0212300008590.30703-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes check_region and fixes the error paths (I hope...)

#
# create_patch: pcnet32_region-2002-12-28-A.patch
# Date: Sat Dec 28 16:25:57 EET 2002
#
diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.53/drivers/net/pcnet32.c msa-2.5.53/drivers/net/pcnet32.c
--- linus-2.5.53/drivers/net/pcnet32.c	Tue Dec 17 20:23:51 2002
+++ msa-2.5.53/drivers/net/pcnet32.c	Sat Dec 28 14:24:15 2002
@@ -468,10 +468,13 @@
     
     /* search for PCnet32 VLB cards at known addresses */
     for (port = pcnet32_portlist; (ioaddr = *port); port++) {
-	if (!check_region(ioaddr, PCNET32_TOTAL_SIZE)) {
-	    /* check if there is really a pcnet chip on that ioaddr */
-	    if ((inb(ioaddr + 14) == 0x57) && (inb(ioaddr + 15) == 0x57))
-		pcnet32_probe1(ioaddr, 0, 0, NULL);
+	if (request_region(ioaddr, PCNET32_TOTAL_SIZE, "pcnet32_probe_vlbus")) {
+		/* check if there is really a pcnet chip on that ioaddr */
+		if ((inb(ioaddr + 14) == 0x57) && (inb(ioaddr + 15) == 0x57)) {
+			pcnet32_probe1(ioaddr, 0, 0, NULL);
+		} else {
+			release_region(ioaddr, PCNET32_TOTAL_SIZE);
+		}
 	}
     }
 }
@@ -500,6 +503,10 @@
 	printk(KERN_ERR PFX "architecture does not support 32bit PCI busmaster DMA\n");
 	return -ENODEV;
     }
+    if (request_region(ioaddr, PCNET32_TOTAL_SIZE, "pcnet32_probe_pci") == NULL) {
+	    printk(KERN_ERR PFX "io address range already allocated\n");
+	    return -EBUSY;
+    }
 
     return pcnet32_probe1(ioaddr, pdev->irq, 1, pdev);
 }
@@ -533,15 +540,19 @@
 	pcnet32_dwio_reset(ioaddr);
 	if (pcnet32_dwio_read_csr(ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
 	    a = &pcnet32_dwio;
-	} else
-	    return -ENODEV;
+	} else {
+		release_region(ioaddr, PCNET32_TOTAL_SIZE);
+		return -ENODEV;
+	}
     }
 
     chip_version = a->read_csr(ioaddr, 88) | (a->read_csr(ioaddr,89) << 16);
     if (pcnet32_debug > 2)
 	printk(KERN_INFO "  PCnet chip version is %#x.\n", chip_version);
-    if ((chip_version & 0xfff) != 0x003)
-	return -ENODEV;
+    if ((chip_version & 0xfff) != 0x003) {
+	    release_region(ioaddr, PCNET32_TOTAL_SIZE);
+	    return -ENODEV;
+    }
     
     /* initialize variables */
     fdx = mii = fset = dxsuflo = ltint = 0;
@@ -603,6 +614,7 @@
     default:
 	printk(KERN_INFO PFX "PCnet version %#x, no PCnet32 chip.\n",
 			chip_version);
+	release_region(ioaddr, PCNET32_TOTAL_SIZE);
 	return -ENODEV;
     }
 
@@ -622,8 +634,10 @@
     }
     
     dev = alloc_etherdev(0);
-    if(!dev)
-	return -ENOMEM;
+    if(!dev) {
+	    release_region(ioaddr, PCNET32_TOTAL_SIZE);
+	    return -ENOMEM;
+    }
 
     printk(KERN_INFO PFX "%s at %#3lx,", chipname, ioaddr);
 
@@ -691,9 +705,6 @@
     }
 
     dev->base_addr = ioaddr;
-    if (request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname) == NULL)
-	return -EBUSY;
-    
     /* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
     if ((lp = pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) == NULL) {
 	release_region(ioaddr, PCNET32_TOTAL_SIZE);

