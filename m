Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760200AbWLDBmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760200AbWLDBmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760203AbWLDBmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:42:06 -0500
Received: from havoc.gtf.org ([69.61.125.42]:2435 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1760200AbWLDBmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:42:03 -0500
Date: Sun, 3 Dec 2006 20:42:03 -0500
From: Jeff Garzik <jeff@garzik.org>
To: kkeil@suse.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISDN: fix warnings
Message-ID: <20061204014203.GA6938@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* diva, sedlbauer: the 'ready' label is only used in certain configurations
* hfc_pci:
	- cast 'arg' to proper size for testing and printing
	- print out 'void __iomem *' variables with %p,
	  rather than using incorrect casts that throw warnings

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/isdn/hisax/diva.c b/drivers/isdn/hisax/diva.c
index 3dacfff..6eebeb4 100644
--- a/drivers/isdn/hisax/diva.c
+++ b/drivers/isdn/hisax/diva.c
@@ -1121,7 +1121,11 @@ #endif /* CONFIG_PCI */
 			bytecnt = 32;
 		}
 	}
+
+#ifdef __ISAPNP__
 ready:
+#endif
+
 	printk(KERN_INFO
 		"Diva: %s card configured at %#lx IRQ %d\n",
 		(cs->subtyp == DIVA_PCI) ? "PCI" :
diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 93f60b5..463b8ac 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1211,7 +1211,7 @@ #endif
 			break;
 		case (HW_TESTLOOP | REQUEST):
 			spin_lock_irqsave(&cs->lock, flags);
-			switch ((int) arg) {
+			switch ((long) arg) {
 				case (1):
 					Write_hfc(cs, HFCPCI_B1_SSL, 0x80);	/* tx slot */
 					Write_hfc(cs, HFCPCI_B1_RSL, 0x80);	/* rx slot */
@@ -1229,7 +1229,7 @@ #endif
 				default:
 					spin_unlock_irqrestore(&cs->lock, flags);
 					if (cs->debug & L1_DEB_WARN)
-						debugl1(cs, "hfcpci_l1hw loop invalid %4x", (int) arg);
+						debugl1(cs, "hfcpci_l1hw loop invalid %4lx", (long) arg);
 					return;
 			}
 			cs->hw.hfcpci.trm |= 0x80;	/* enable IOM-loop */
@@ -1709,9 +1709,9 @@ #ifdef CONFIG_PCI
 		pci_write_config_dword(cs->hw.hfcpci.dev, 0x80, (u_int) virt_to_bus(cs->hw.hfcpci.fifos));
 		cs->hw.hfcpci.pci_io = ioremap((ulong) cs->hw.hfcpci.pci_io, 256);
 		printk(KERN_INFO
-		       "HFC-PCI: defined at mem %#x fifo %#x(%#x) IRQ %d HZ %d\n",
-		       (u_int) cs->hw.hfcpci.pci_io,
-		       (u_int) cs->hw.hfcpci.fifos,
+		       "HFC-PCI: defined at mem %p fifo %p(%#x) IRQ %d HZ %d\n",
+		       cs->hw.hfcpci.pci_io,
+		       cs->hw.hfcpci.fifos,
 		       (u_int) virt_to_bus(cs->hw.hfcpci.fifos),
 		       cs->irq, HZ);
 		spin_lock_irqsave(&cs->lock, flags);
diff --git a/drivers/isdn/hisax/sedlbauer.c b/drivers/isdn/hisax/sedlbauer.c
index 9522141..030d162 100644
--- a/drivers/isdn/hisax/sedlbauer.c
+++ b/drivers/isdn/hisax/sedlbauer.c
@@ -677,7 +677,11 @@ #else
 		return (0);
 #endif /* CONFIG_PCI */
 	}	
+
+#ifdef __ISAPNP__
 ready:	
+#endif
+
 	/* In case of the sedlbauer pcmcia card, this region is in use,
 	 * reserved for us by the card manager. So we do not check it
 	 * here, it would fail.

