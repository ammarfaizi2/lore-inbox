Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131634AbQKUWzq>; Tue, 21 Nov 2000 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbQKUWzh>; Tue, 21 Nov 2000 17:55:37 -0500
Received: from styx.suse.cz ([195.70.145.226]:38646 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131634AbQKUWza>;
	Tue, 21 Nov 2000 17:55:30 -0500
Date: Tue, 21 Nov 2000 23:25:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        tsbogend@alpha.franken.de
Subject: [patch] Fix AMD PCNet32 printk's
Message-ID: <20001121232509.A252@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Someone overzealously added too many KERN_INFOs to pcnet32, so that they
appear not only at the beginning of each line, but also many times in
between words. This is wrong.

This patch removes the extraneous KERN_* from pcnet32. It leaves all
those that should be there in place. It does not change anything else.

It's against 2.4.0-test11.

-- 
Vojtech Pavlik
SuSE Labs

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcnet32-printk.diff"

diff -urN linux-2.4.0-test11/drivers/net/pcnet32.c linux/drivers/net/pcnet32.c
--- linux-2.4.0-test11/drivers/net/pcnet32.c	Tue Nov 21 23:04:24 2000
+++ linux/drivers/net/pcnet32.c	Tue Nov 21 20:56:57 2000
@@ -483,7 +483,7 @@
     printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);
 
     ioaddr = pci_resource_start (pdev, 0);
-    printk(KERN_INFO "  ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
+    printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
     if (!ioaddr) {
         printk (KERN_ERR "no PCI IO resources, aborting\n");
         return -ENODEV;
@@ -627,29 +627,29 @@
     /* There is a 16 byte station address PROM at the base address.
        The first six bytes are the station address. */
     for (i = 0; i < 6; i++)
-	printk( KERN_INFO " %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
+	printk(" %2.2x", dev->dev_addr[i] = inb(ioaddr + i));
 
     if (((chip_version + 1) & 0xfffe) == 0x2624) { /* Version 0x2623 or 0x2624 */
 	i = a->read_csr(ioaddr, 80) & 0x0C00;  /* Check tx_start_pt */
-	printk(KERN_INFO"\n    tx_start_pt(0x%04x):",i);
+	printk("\n" KERN_INFO "    tx_start_pt(0x%04x):",i);
 	switch(i>>10) {
-	    case 0: printk(KERN_INFO "  20 bytes,"); break;
-	    case 1: printk(KERN_INFO "  64 bytes,"); break;
-	    case 2: printk(KERN_INFO " 128 bytes,"); break;
-	    case 3: printk(KERN_INFO "~220 bytes,"); break;
+	    case 0: printk("  20 bytes,"); break;
+	    case 1: printk("  64 bytes,"); break;
+	    case 2: printk(" 128 bytes,"); break;
+	    case 3: printk("~220 bytes,"); break;
 	}
 	i = a->read_bcr(ioaddr, 18);  /* Check Burst/Bus control */
-	printk(KERN_INFO" BCR18(%x):",i&0xffff);
-	if (i & (1<<5)) printk(KERN_INFO "BurstWrEn ");
-	if (i & (1<<6)) printk(KERN_INFO "BurstRdEn ");
-	if (i & (1<<7)) printk(KERN_INFO "DWordIO ");
-	if (i & (1<<11)) printk(KERN_INFO"NoUFlow ");
+	printk(" BCR18(%x):",i&0xffff);
+	if (i & (1<<5)) printk("BurstWrEn ");
+	if (i & (1<<6)) printk("BurstRdEn ");
+	if (i & (1<<7)) printk("DWordIO ");
+	if (i & (1<<11)) printk("NoUFlow ");
 	i = a->read_bcr(ioaddr, 25);
-	printk(KERN_INFO "\n    SRAMSIZE=0x%04x,",i<<8);
+	printk("\n" KERN_INFO "    SRAMSIZE=0x%04x,",i<<8);
 	i = a->read_bcr(ioaddr, 26);
-	printk(KERN_INFO " SRAM_BND=0x%04x,",i<<8);
+	printk(" SRAM_BND=0x%04x,",i<<8);
 	i = a->read_bcr(ioaddr, 27);
-	if (i & (1<<14)) printk(KERN_INFO "LowLatRx,");
+	if (i & (1<<14)) printk("LowLatRx");
     }
 
     dev->base_addr = ioaddr;
@@ -662,7 +662,7 @@
     memset(lp, 0, sizeof(*lp));
     lp->dma_addr = lp_dma_addr;
     lp->pci_dev = pdev;
-    printk(KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x\n", lp, lp_dma_addr);
+    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x", lp, lp_dma_addr);
 
     spin_lock_init(&lp->lock);
     
@@ -713,7 +713,7 @@
     }
     
     if (dev->irq >= 2)
-	printk(KERN_INFO " assigned IRQ %d.\n", dev->irq);
+	printk(" assigned IRQ %d.\n", dev->irq);
     else {
 	unsigned long irq_mask = probe_irq_on();
 	
@@ -728,9 +728,9 @@
 	
 	dev->irq = probe_irq_off (irq_mask);
 	if (dev->irq)
-	    printk(KERN_INFO ", probed IRQ %d.\n", dev->irq);
+	    printk(", probed IRQ %d.\n", dev->irq);
 	else {
-	    printk(KERN_ERR ", failed to detect IRQ line.\n");
+	    printk(", failed to detect IRQ line.\n");
 	    return -ENODEV;
 	}
     }
@@ -978,14 +978,14 @@
 	       lp->dirty_tx, lp->cur_tx, lp->tx_full ? " (full)" : "",
 	       lp->cur_rx);
 	    for (i = 0 ; i < RX_RING_SIZE; i++)
-	    printk(KERN_DEBUG "%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
+	    printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
 		   lp->rx_ring[i].base, -lp->rx_ring[i].buf_length,
 		   lp->rx_ring[i].msg_length, (unsigned)lp->rx_ring[i].status);
 	    for (i = 0 ; i < TX_RING_SIZE; i++)
-	    printk(KERN_DEBUG "%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
+	    printk("%s %08x %04x %08x %04x", i & 1 ? "" : "\n ",
 		   lp->tx_ring[i].base, -lp->tx_ring[i].length,
 		   lp->tx_ring[i].misc, (unsigned)lp->tx_ring[i].status);
-	    printk(KERN_DEBUG "\n");
+	    printk("\n");
 	}
 	pcnet32_restart(dev, 0x0042);
 

--82I3+IH0IqGh5yIs--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
