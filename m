Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSDGJnw>; Sun, 7 Apr 2002 05:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313020AbSDGJnv>; Sun, 7 Apr 2002 05:43:51 -0400
Received: from codepoet.org ([166.70.14.212]:32708 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S313019AbSDGJnv>;
	Sun, 7 Apr 2002 05:43:51 -0400
Date: Sun, 7 Apr 2002 03:43:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.4.19-pre6 + 1394 compile failure
Message-ID: <20020407094351.GA11303@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Ben Collins <bcollins@debian.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 2.4.19-pre6:
    CONFIG_IEEE1394=y
    CONFIG_IEEE1394_PCILYNX=y
    CONFIG_IEEE1394_OHCI1394=y
    CONFIG_IEEE1394_SBP2=m

results in 

drivers/ieee1394/ieee1394drv.o: In function `ohci1394_pci_probe':
drivers/ieee1394/ieee1394drv.o(.text.init+0xa37): undefined reference to `local symbols in discarded section .text.exit'
drivers/ieee1394/ieee1394drv.o(.text.init+0xcda): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

ohci1394_pci_probe() calls ohci1394_pci_remove() via the FAIL
macro, but ohci1394_pci_remove() is marked __devexit and thus
gets tossed at link time.  Seems it needs to stick around.


--- linux/drivers/ieee1394/ohci1394.c~	Sun Apr  7 03:41:39 2002
+++ linux/drivers/ieee1394/ohci1394.c	Sun Apr  7 03:41:50 2002
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
 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
