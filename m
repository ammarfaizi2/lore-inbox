Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264511AbRFZU2Z>; Tue, 26 Jun 2001 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbRFZU2U>; Tue, 26 Jun 2001 16:28:20 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:33540 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264511AbRFZUTm>; Tue, 26 Jun 2001 16:19:42 -0400
Message-ID: <3B38EE96.A6C11980@t-online.de>
Date: Tue, 26 Jun 2001 22:20:38 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
CC: andre@linux-ide.org
Subject: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes the hard hang (no SYSRQ) on inserting
any PCMCIA ATA/IDE card (e.g. CompactFlash, Clik40 etc)
to a PCI-Cardbus bridge add-in card.

Thanks David for his valuable explanation about what happens:
ide-probe registers it's irq handler too late! After it
triggers the interrupt during the probe the (shared) irq
loops forever, effectively wedging the machine completely.

Regards, Gunther



--- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
+++ linux/drivers/ide/ide-cs.c  Tue Jun 26 21:22:19 2001
@@ -324,6 +324,9 @@
     if (link->io.NumPorts2)
        release_region(link->io.BasePort2, link->io.NumPorts2);
 
+    outb(0x02, ctl_base); // Set nIEN = disable device interrupts
+                         // else it hangs on PCI-Cardbus add-in cards, wedging irq
+
     /* retry registration in case device is still spinning up */
     for (i = 0; i < 10; i++) {
        hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
--- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
+++ linux/drivers/ide/ide-probe.c       Tue Jun 26 21:25:07 2001
@@ -685,6 +685,8 @@
 #else /* !CONFIG_IDEPCI_SHARE_IRQ */
                int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
+
+               outb(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear nIEN == enable irqs
                if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
                        if (!match)
                                kfree(hwgroup);
