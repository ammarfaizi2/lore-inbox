Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUKZVOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUKZVOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUKZUTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:19:40 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:56236 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S263963AbUKZT5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:57:20 -0500
Date: Fri, 26 Nov 2004 10:21:40 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jonmason@us.ibm.com, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: pcnet32: 79c976 with fiber optic
Message-ID: <20041126092139.GA760@bogon.ms20.nix>
References: <20041124171427.GA29693@bogon.ms20.nix> <1101420214.18354.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101420214.18354.69.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 10:03:36PM +0000, Alan Cox wrote:
> 
> Use lspci -v to find the subvendor/subdevice ID for the particular board
> assembly and then skip the fixup for that device alone. That should let
> you produce a diff that is safely mergable
You mean like:

Skip PHY selection on Allied Telesyn 2701FX, it looses the link
otherwise.

Signed-Off-By: Guido Guenther <agx@sigxcpu.org>

--- tmp/linux-2.6.9/include/linux/pci_ids.h	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.9/include/linux/pci_ids.h	2004-11-26 10:11:23.000000000 +0100
@@ -1622,6 +1622,10 @@
 #define PCI_DEVICE_ID_OPTIBASE_VPLEXCC	0x2120
 #define PCI_DEVICE_ID_OPTIBASE_VQUEST	0x2130
 
+/* Allied Telesyn */
+#define PCI_VENDOR_ID_AT    		0x1259
+#define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
+
 #define PCI_VENDOR_ID_ESS		0x125d
 #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
 #define PCI_DEVICE_ID_ESS_AUDIOPCI	0x1969
--- tmp/linux-2.6.9/drivers/net/pcnet32.c	2004-10-18 23:53:45.000000000 +0200
+++ linux-2.6.9/drivers/net/pcnet32.c	2004-11-26 10:18:09.000000000 +0100
@@ -1425,26 +1425,32 @@
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

Cheers,
 -- Guido
