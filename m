Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVCGMcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVCGMcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 07:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVCGMcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 07:32:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29674 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261443AbVCGMbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 07:31:52 -0500
Subject: PATCH: Fibre attached pcnet/32
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110198605.28860.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Mar 2005 12:30:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver does workarounds for errata that do not work with
fibre attached devices. This patch avoids doing the workaround on the
only known fibre attach pcnet/32 hardware. All handling is automated on
pci sub-ids

Patch by: Guido Guenther
Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.11/drivers/net/pcnet32.c linux-2.6.11/drivers/net/pcnet32.c
--- linux.vanilla-2.6.11/drivers/net/pcnet32.c	2005-03-05 15:15:10.000000000 +0000
+++ linux-2.6.11/drivers/net/pcnet32.c	2005-03-05 16:12:01.000000000 +0000
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

