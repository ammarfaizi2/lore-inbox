Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRICMnF>; Mon, 3 Sep 2001 08:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271686AbRICMmz>; Mon, 3 Sep 2001 08:42:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:30219 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271685AbRICMmi>;
	Mon, 3 Sep 2001 08:42:38 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15251.31040.478167.658461@tango.paulus.ozlabs.org>
Date: Mon, 3 Sep 2001 22:36:16 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: trini@kernel.crashing.org, benh@kernel.crashing.org
Subject: [PATCH] [RESEND] remove rubbish from sl82c105.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, drivers/ide/sl82c105.c has two sets of code in it: some
good code done by Russell King, and some old rubbishy code.  Russell's
code is inside #ifdef CONFIG_ARCH_NETWINDER.  I tried Russell's code
on my Longtrail CHRP PPC box and it not only compiles and links ok
(which the old code doesn't), it also works just fine.

So the patch below takes out the CONFIG_ARCH_NETWINDER and the old
code, so we use Russell's code on all platforms.  I put this patch out
on linux-kernel a couple of weeks ago and no one has complained since.
The old code won't link at the moment anyway (it references
ide_special_settings which isn't exported from ide-pci.c).

Linus, please apply this patch to your tree.

Paul.

diff -urN linux/drivers/ide/sl82c105.c linuxppc_2_4/drivers/ide/sl82c105.c
--- linux/drivers/ide/sl82c105.c	Wed Jul  4 14:33:21 2001
+++ linuxppc_2_4/drivers/ide/sl82c105.c	Sun Jul 22 17:58:43 2001
@@ -28,7 +28,6 @@
 
 extern char *ide_xfer_verbose (byte xfer_rate);
 
-#ifdef CONFIG_ARCH_NETWINDER
 /*
  * Convert a PIO mode and cycle time to the required on/off
  * times for the interface.  This has protection against run-away
@@ -272,37 +271,4 @@
 {
 	hwif->tuneproc = tune_sl82c105;
 }
-
-#else
-
-unsigned int pci_init_sl82c105(struct pci_dev *dev, const char *msg)
-{
-	return ide_special_settings(dev, msg);
-}
-
-void dma_init_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
-{
-	ide_setup_dma(hwif, dma_base, 8);
-}
-
-void __init ide_init_sl82c105(ide_hwif_t *hwif)
-{
-	struct pci_dev *dev = hwif->pci_dev;
-	unsigned short t16;
-	unsigned int t32;
-	pci_read_config_word(dev, PCI_COMMAND, &t16);
-	printk("SL82C105 command word: %x\n",t16);
-        t16 |= PCI_COMMAND_IO;
-        pci_write_config_word(dev, PCI_COMMAND, t16);
-	/* IDE timing */
-	pci_read_config_dword(dev, 0x44, &t32);
-	printk("IDE timing: %08x, resetting to PIO0 timing\n",t32);
-	pci_write_config_dword(dev, 0x44, 0x03e4);
-#ifndef CONFIG_MBX
-	pci_read_config_dword(dev, 0x40, &t32);
-	printk("IDE control/status register: %08x\n",t32);
-	pci_write_config_dword(dev, 0x40, 0x10ff08a1);
-#endif /* CONFIG_MBX */
-}
-#endif

