Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJQAl7>; Tue, 16 Oct 2001 20:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRJQAlt>; Tue, 16 Oct 2001 20:41:49 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:8688 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S273204AbRJQAlp>;
	Tue, 16 Oct 2001 20:41:45 -0400
Message-ID: <3BCCD31E.B94CA05A@sun.com>
Date: Tue, 16 Oct 2001 17:38:54 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE initialization fix
In-Reply-To: <Pine.LNX.4.10.10110161109450.807-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------CE7889DD2AFA93FD845E0F7D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CE7889DD2AFA93FD845E0F7D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre Hedrick wrote:
Andre, The summary of the change is this: without this change, the PCI init
for chipsets does not get called.  I'll speak specifically about the CSB5. 
The CSB5 in non-native mode has a PCI irqline register forced to 0.  The
PCI probe then skips it's PCI init and it never gets called.

We then see that there is no file in /proc/ide for the serverworks
chipset.  With this fix, there is.

Is there something else we aren't doing, instead?  This seems obvious -
there is NOWHERE else that calls the init_chipset() method.

I put a printk in the pci_init_svwks routine, and it doesn't get called.

> The real issue is that the initialization of the card/host has a problem,
> so that belongs in the pci_fix_up region in the arch/<>/kernel/pc-irq.c
> stuff, imho.  In general one should not be changing the interrupt lines at
> this stage of the INIT process.

Please show me what you mean - my desktop has an IRQ of zero, also.  I do
have some control over BIOS, too.

Please, I'd like to resolve this issue once and for all :)
 

Patch attached again for completeness..

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------CE7889DD2AFA93FD845E0F7D
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

--------------CE7889DD2AFA93FD845E0F7D--

