Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSFYNxD>; Tue, 25 Jun 2002 09:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFYNxC>; Tue, 25 Jun 2002 09:53:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:32767 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315481AbSFYNxB>; Tue, 25 Jun 2002 09:53:01 -0400
Date: Tue, 25 Jun 2002 15:52:58 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <bcollins@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in ieee1394/ohci1394.c
Message-ID: <Pine.NEB.4.44.0206251547300.14220-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following error occured at the final linking of 2.4.19-rc1:

<--  snip  -->

...
drivers/ieee1394/ieee1394drv.o: In function `ohci1394_pci_probe':
drivers/ieee1394/ieee1394drv.o(.text.init+0xdb7): undefined reference
to `local symbols in discarded section .text.exit'
drivers/ieee1394/ieee1394drv.o(.text.init+0x109a): undefined reference
to `local symbols in discarded section .text.exit'...

<--  snip  -->


The problem is that ohci1394_pci_remove is __devexit but via the FAIL
macro it gets called from ohci1394_pci_probe that isn't __devexit (it's
__devinit). If you compile this driver statically into a kernel without
CONFIG_HOTPLUG the error above occurs.

I suggest to simply remove the __devexit from ohci1394_pci_remove:


--- drivers/ieee1394/ohci1394.c.old	Tue Jun 25 13:03:14 2002
+++ drivers/ieee1394/ohci1394.c	Tue Jun 25 15:42:19 2002
@@ -171,7 +171,7 @@
 static void dma_trm_tasklet(unsigned long data);
 static void dma_trm_reset(struct dma_trm_ctx *d);

-static void __devexit ohci1394_pci_remove(struct pci_dev *pdev);
+static void ohci1394_pci_remove(struct pci_dev *pdev);

 static inline void ohci1394_run_irq_hooks(struct ti_ohci *ohci,
 					  quadlet_t isoRecvEvent,
@@ -2209,7 +2209,7 @@
 #undef FAIL
 }

-static void __devexit ohci1394_pci_remove(struct pci_dev *pdev)
+static void ohci1394_pci_remove(struct pci_dev *pdev)
 {
 	struct ti_ohci *ohci;
 	quadlet_t buf;
@@ -2314,7 +2314,7 @@
 	name:		OHCI1394_DRIVER_NAME,
 	id_table:	ohci1394_pci_tbl,
 	probe:		ohci1394_pci_probe,
-	remove:		__devexit_p(ohci1394_pci_remove),
+	remove:		ohci1394_pci_remove,
 };




cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

