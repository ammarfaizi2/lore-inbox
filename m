Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276535AbRJPRlb>; Tue, 16 Oct 2001 13:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276522AbRJPRlW>; Tue, 16 Oct 2001 13:41:22 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:7839 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S276535AbRJPRlJ>;
	Tue, 16 Oct 2001 13:41:09 -0400
Message-ID: <3BCC708E.3ADD3E2A@sun.com>
Date: Tue, 16 Oct 2001 10:38:22 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, alan@redhat.com, torvalds@transmeta.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE initialization fix
Content-Type: multipart/mixed;
 boundary="------------44D0F7D587156D0F46102FEE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------44D0F7D587156D0F46102FEE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre, Alan, Linus

We thought this bug was fixed for a long time, but apparently it is back! 
This patch makes sure we call the init for ALL chipsets that support it. 
Please apply this for the next 2.4.x, or let me know of problems.

thanks (more patches to come!)

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------44D0F7D587156D0F46102FEE
Content-Type: text/plain; charset=us-ascii;
 name="ide-init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-init.diff"

diff -ruN dist-2.4.12+patches/drivers/ide/ide-pci.c cvs-2.4.12+patches/drivers/ide/ide-pci.c
--- dist-2.4.12+patches/drivers/ide/ide-pci.c	Mon Oct 15 10:21:50 2001
+++ cvs-2.4.12+patches/drivers/ide/ide-pci.c	Mon Oct 15 10:21:49 2001
@@ -584,7 +584,8 @@
 	ide_hwif_t *hwif, *mate = NULL;
 	unsigned int class_rev;
 	static int secondpdc = 0;
-
+	int pci_class_ide;
+	
 #ifdef CONFIG_IDEDMA_AUTO
 	if (!noautodma)
 		autodma = 1;
@@ -653,7 +654,8 @@
 		/* Its attached to something else, just a random bridge. 
 		   Suspect a fastrak and fall through */
 	}
-	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
+	pci_class_ide = ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE);
+        if (!pci_class_ide && ((dev->class >> 8) != PCI_CLASS_STORAGE_OTHER)) {
 		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
 		/*
 		 * This allows offboard ide-pci cards the enable a BIOS,
@@ -666,8 +668,19 @@
 		printk("%s: will probe irqs later\n", d->name);
 		pciirq = 0;
 	} else if (!pciirq) {
-		printk("%s: bad irq (%d): will probe later\n", d->name, pciirq);
-		pciirq = 0;
+		if (pci_class_ide) {
+			/* this is the normal path for most IDE devices */
+			if (d->init_chipset) {
+				pciirq = d->init_chipset(dev, d->name);
+			} else {
+				printk(KERN_INFO 
+					"%s standard IDE device detected\n", 
+					d->name);
+			}
+		} else {
+			printk(KERN_WARNING 
+				"%s: bad irq (0): will probe later\n", d->name);
+		}
 	} else {
 		if (d->init_chipset)
 			(void) d->init_chipset(dev, d->name);

--------------44D0F7D587156D0F46102FEE--

