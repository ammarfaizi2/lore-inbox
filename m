Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278422AbRJXA0p>; Tue, 23 Oct 2001 20:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278423AbRJXA0g>; Tue, 23 Oct 2001 20:26:36 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:13719 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S278422AbRJXA0X>;
	Tue, 23 Oct 2001 20:26:23 -0400
Message-ID: <3BD609DC.CC2AE22B@sun.com>
Date: Tue, 23 Oct 2001 17:22:52 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE PCI probe
Content-Type: multipart/mixed;
 boundary="------------E4F370938FD6A902B1104A63"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E4F370938FD6A902B1104A63
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre,

Here is the patch as we discussed - it works, it is good.  Needed for
controllers that can do native mode but not native PCI IRQs.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------E4F370938FD6A902B1104A63
Content-Type: text/plain; charset=us-ascii;
 name="ide-init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-init.diff"

--- virgin-2.4.12/drivers/ide/ide-pci.c	Wed Oct 10 14:37:29 2001
+++ CVS-checkout/drivers/ide/ide-pci.c	Thu Oct 18 10:22:53 2001
@@ -653,32 +653,44 @@
 		/* Its attached to something else, just a random bridge. 
 		   Suspect a fastrak and fall through */
 	}
-	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
-		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
-		/*
-		 * This allows offboard ide-pci cards the enable a BIOS,
-		 * verify interrupt settings of split-mirror pci-config
-		 * space, place chipset into init-mode, and/or preserve
-		 * an interrupt if the card is not native ide support.
-		 */
-		pciirq = (d->init_chipset) ? d->init_chipset(dev, d->name) : ide_special_settings(dev, d->name);
+
+	if (!tried_config && 
+	   (dev->class >> 8 == PCI_CLASS_STORAGE_IDE ||
+	    dev->class >> 8 == PCI_CLASS_STORAGE_OTHER)) {
+		if ((dev->class & 0x5) == 0x5 && pciirq) {
+			if (d->init_chipset) {
+				(void) d->init_chipset(dev, d->name);
+			}
+#ifdef __sparc__
+			printk("%s: 100%% native mode on irq %s\n",
+				d->name, __irq_itoa(pciirq));
+#else
+			printk("%s: 100%% native mode on irq %d\n", 
+				d->name, pciirq);
+#endif
+		} else if ((dev->class & 0x5) == 0x5) {
+			if (d->init_chipset) {
+				pciirq = d->init_chipset(dev, d->name);
+			}
+			printk("%s: native mode: will probe irqs later\n", 
+				d->name);
+		} else {
+			if (d->init_chipset) {
+				pciirq = d->init_chipset(dev, d->name);
+			} else {
+				pciirq = ide_special_settings(dev, d->name);
+			}
+			printk("%s: non-native mode: will probe irqs later\n", 
+				d->name);
+		}
 	} else if (tried_config) {
 		printk("%s: will probe irqs later\n", d->name);
 		pciirq = 0;
-	} else if (!pciirq) {
-		printk("%s: bad irq (%d): will probe later\n", d->name, pciirq);
-		pciirq = 0;
 	} else {
-		if (d->init_chipset)
-			(void) d->init_chipset(dev, d->name);
-#ifdef __sparc__
-		printk("%s: 100%% native mode on irq %s\n",
-		       d->name, __irq_itoa(pciirq));
-#else
-		printk("%s: 100%% native mode on irq %d\n", d->name, pciirq);
-#endif
+		printk("%s: what am I expected to do with this?\n", d->name);
+		pciirq = 0;
 	}
-
+		
 	/*
 	 * Set up the IDE ports
 	 */
@@ -784,6 +796,7 @@
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD648) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD649) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_OSB4) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB5) ||
 		    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))) {
 			unsigned long dma_base = ide_get_or_set_dma_base(hwif, (!mate && d->extra) ? d->extra : 0, d->name);
 			if (dma_base && !(pcicmd & PCI_COMMAND_MASTER)) {

--------------E4F370938FD6A902B1104A63--

