Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUL0PPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUL0PPN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUL0PPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:15:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37019 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261900AbUL0POp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:14:45 -0500
Subject: PATCH: 2.6.10 - fibre based PCNet32 fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, tsbogend@alpha.franken.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104156646.20944.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:10:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The workarounds done for the 79C97x don't appear to work on fibre based
PCNET32 devices like the AT2701FX. This patch uses subvendor ID's to
spot the known fibre card type and avoids losing the link.

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/net/pcnet32.c linux-2.6.10/drivers/net/pcnet32.c
--- linux.vanilla-2.6.10/drivers/net/pcnet32.c	2004-12-25 21:15:40.000000000 +0000
+++ linux-2.6.10/drivers/net/pcnet32.c	2004-12-26 17:18:20.886713024 +0000
@@ -1429,26 +1429,32 @@
 	val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);
 
-    /* 24 Jun 2004 according AMD, in order to change the PHY,
-     * DANAS (or DISPM for 79C976) must be set; then select the speed,
-     * duplex, and/or enable auto negotiation, and clear DANAS */
-    if (lp->mii && !(lp->options & PCNET32_PORT_ASEL)) {
-	lp->a.write_bcr(ioaddr, 32, lp->a.read_bcr(ioaddr, 32) | 0x0080);
-	/* disable Auto Negotiation, set 10Mpbs, HD */
-	val = lp->a.read_bcr(ioaddr, 32) & ~0xb8;
-	if (lp->options & PCNET32_PORT_FD)
-	    val |= 0x10;
-	if (lp->options & PCNET32_PORT_100)
-	    val |= 0x08;
-	lp->a.write_bcr (ioaddr, 32, val);
+    /* Skip PHY selection on AT2701FX, looses link otherwise */
+    if(lp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_AT && 
+       lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FX ) {
+    	printk(KERN_DEBUG "pcnet32: Skipping PHY selection.\n");
     } else {
-	if (lp->options & PCNET32_PORT_ASEL) {
-	    lp->a.write_bcr(ioaddr, 32, lp->a.read_bcr(ioaddr, 32) | 0x0080);
-	    /* enable auto negotiate, setup, disable fd */
-	    val = lp->a.read_bcr(ioaddr, 32) & ~0x98;
-	    val |= 0x20;
-	    lp->a.write_bcr(ioaddr, 32, val);
-	}
+        /* 24 Jun 2004 according AMD, in order to change the PHY,
+         * DANAS (or DISPM for 79C976) must be set; then select the speed,
+         * duplex, and/or enable auto negotiation, and clear DANAS */
+        if (lp->mii && !(lp->options & PCNET32_PORT_ASEL)) {
+    	lp->a.write_bcr(ioaddr, 32, lp->a.read_bcr(ioaddr, 32) | 0x0080);
+    	/* disable Auto Negotiation, set 10Mpbs, HD */
+    	val = lp->a.read_bcr(ioaddr, 32) & ~0xb8;
+    	if (lp->options & PCNET32_PORT_FD)
+    	    val |= 0x10;
+    	if (lp->options & PCNET32_PORT_100)
+    	    val |= 0x08;
+    	lp->a.write_bcr (ioaddr, 32, val);
+        } else {
+    	    if (lp->options & PCNET32_PORT_ASEL) {
+    	        lp->a.write_bcr(ioaddr, 32, lp->a.read_bcr(ioaddr, 32) | 0x0080);
+    	        /* enable auto negotiate, setup, disable fd */
+    	        val = lp->a.read_bcr(ioaddr, 32) & ~0x98;
+    	        val |= 0x20;
+    	        lp->a.write_bcr(ioaddr, 32, val);
+    	    }
+        }
     }
 
 #ifdef DO_DXSUFLO
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/include/linux/pci_ids.h linux-2.6.10/include/linux/pci_ids.h
--- linux.vanilla-2.6.10/include/linux/pci_ids.h	2004-12-25 21:15:46.000000000 +0000
+++ linux-2.6.10/include/linux/pci_ids.h	2004-12-26 21:13:31.884515288 +0000
@@ -1631,6 +1636,10 @@
 #define PCI_DEVICE_ID_OPTIBASE_VPLEXCC	0x2120
 #define PCI_DEVICE_ID_OPTIBASE_VQUEST	0x2130
 
+/* Allied Telesyn */
+#define PCI_VENDOR_ID_AT    		0x1259
+#define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
+
 #define PCI_VENDOR_ID_ESS		0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
 #define PCI_DEVICE_ID_ESS_AUDIOPCI	0x1969

