Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268948AbRHBOSA>; Thu, 2 Aug 2001 10:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268952AbRHBORv>; Thu, 2 Aug 2001 10:17:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268948AbRHBORf>; Thu, 2 Aug 2001 10:17:35 -0400
Subject: Re: PCMCIA IDE_CS in 2.4.7
To: alan@clueserver.org (Alan Olsen)
Date: Thu, 2 Aug 2001 15:18:43 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.10.10107312226590.26170-100000@clueserver.org> from "Alan Olsen" at Jul 31, 2001 10:42:48 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJJD-0000eB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I insert the card, I get a beep from the cardmgr program seeing the
> card being inserted.  Then the whole system refuses to respond to anything
> on the keyboard.  (I have not tested if the system is reachable by network
> when that happens.) 

Gunther posted this patch ages ago which seems to solve the problem

--- linux245.orig/drivers/ide/ide-cs.c  Fri Feb  9 20:40:02 2001
+++ linux/drivers/ide/ide-cs.c  Tue Jun 26 21:22:19 2001
@@ -324,6 +324,9 @@
     if (link->io.NumPorts2)
        release_region(link->io.BasePort2, link->io.NumPorts2);
 
+    outb(0x02, ctl_base); // Set nIEN = disable device interrupts
+                         // else it hangs on PCI-Cardbus add-in cards,
wedging irq
+
     /* retry registration in case device is still spinning up */
     for (i = 0; i < 10; i++) {
        hd = ide_register(io_base, ctl_base, link->irq.AssignedIRQ);
--- linux245.orig/drivers/ide/ide-probe.c       Sun Mar 18 18:25:02 2001
+++ linux/drivers/ide/ide-probe.c       Tue Jun 26 21:25:07 2001
@@ -685,6 +685,8 @@
 #else /* !CONFIG_IDEPCI_SHARE_IRQ */
                int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ
: SA_INTERRUPT;
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
+
+               outb(0x00, hwif->io_ports[IDE_CONTROL_OFFSET]); // clear
nIEN == enable irqs
                if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name,
hwgroup)) {
                        if (!match)
                                kfree(hwgroup);
