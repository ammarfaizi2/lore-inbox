Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKHPDx>; Wed, 8 Nov 2000 10:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbQKHPDn>; Wed, 8 Nov 2000 10:03:43 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:13316 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S129076AbQKHPDc>; Wed, 8 Nov 2000 10:03:32 -0500
Date: Wed, 8 Nov 2000 18:05:17 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] net drivers check_region() removal continues
Message-ID: <20001108180517.B4729@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii


Hi all,

lots of patches attached:
3c503.c, ac3200.c, cs89x0.c, e2100.c, hp.c, hp-plus.c, lne390.c, ne.c, wd.c

Best regards,
	    Andrey

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c503

diff -urN /mnt/disk/linux/drivers/net/3c503.c /linux/drivers/net/3c503.c
--- /mnt/disk/linux/drivers/net/3c503.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/3c503.c	Mon Nov  6 01:20:40 2000
@@ -101,8 +101,6 @@
 		break;
 	if (base_bits != 1)
 	    continue;
-	if (check_region(netcard_portlist[i], EL2_IO_EXTENT))
-	    continue;
 	if (el2_probe1(dev, netcard_portlist[i]) == 0)
 	    return 0;
     }
@@ -126,13 +124,9 @@
     else if (base_addr != 0)	/* Don't probe at all. */
 	return -ENXIO;
 
-    for (i = 0; netcard_portlist[i]; i++) {
-	int ioaddr = netcard_portlist[i];
-	if (check_region(ioaddr, EL2_IO_EXTENT))
-	    continue;
-	if (el2_probe1(dev, ioaddr) == 0)
+    for (i = 0; netcard_portlist[i]; i++)
+	if (el2_probe1(dev, netcard_portlist[i]) == 0)
 	    return 0;
-    }
 
     return -ENODEV;
 }
@@ -143,14 +137,18 @@
 int __init 
 el2_probe1(struct net_device *dev, int ioaddr)
 {
-    int i, iobase_reg, membase_reg, saved_406, wordlength;
-    static unsigned version_printed = 0;
+    int i, iobase_reg, membase_reg, saved_406, wordlength, retval;
+    static unsigned version_printed;
     unsigned long vendor_id;
 
+    if (!request_region(ioaddr, EL2_IO_EXTENT, dev->name))
+	return -EBUSY;
+
     /* Reset and/or avoid any lurking NE2000 */
     if (inb(ioaddr + 0x408) == 0xff) {
     	mdelay(1);
-	return -ENODEV;
+	retval = -ENODEV;
+	goto out;
     }
 
     /* We verify that it's a 3C503 board by checking the first three octets
@@ -160,7 +158,8 @@
     /* ASIC location registers should be 0 or have only a single bit set. */
     if (   (iobase_reg  & (iobase_reg - 1))
 	|| (membase_reg & (membase_reg - 1))) {
-	return -ENODEV;
+	retval = -ENODEV;
+	goto out;
     }
     saved_406 = inb_p(ioaddr + 0x406);
     outb_p(ECNTRL_RESET|ECNTRL_THIN, ioaddr + 0x406); /* Reset it... */
@@ -172,7 +171,8 @@
     if ((vendor_id != OLD_3COM_ID) && (vendor_id != NEW_3COM_ID)) {
 	/* Restore the register we frobbed. */
 	outb(saved_406, ioaddr + 0x406);
-	return -ENODEV;
+	retval = -ENODEV;
+	goto out;
     }
 
     if (ei_debug  &&  version_printed++ == 0)
@@ -182,8 +182,9 @@
     /* Allocate dev->priv and fill in 8390 specific dev fields. */
     if (ethdev_init(dev)) {
 	printk ("3c503: unable to allocate memory for dev->priv.\n");
-	return -ENOMEM;
-     }
+	retval = -ENOMEM;
+	goto out;
+    }
 
     printk("%s: 3c503 at i/o base %#3x, node ", dev->name, ioaddr);
 
@@ -282,8 +283,6 @@
     ei_status.block_input = &el2_block_input;
     ei_status.block_output = &el2_block_output;
 
-    request_region(ioaddr, EL2_IO_EXTENT, ei_status.name);
-
     if (dev->irq == 2)
 	dev->irq = 9;
     else if (dev->irq > 5 && dev->irq != 9) {
@@ -310,11 +309,15 @@
 	       dev->name, ei_status.name, (wordlength+1)<<3);
     }
     return 0;
+out:
+    release_region(ioaddr, EL2_IO_EXTENT);
+    return retval;
 }
 
 static int
 el2_open(struct net_device *dev)
 {
+    int retval = -EAGAIN;
 
     if (dev->irq < 2) {
 	int irqlist[] = {5, 9, 3, 4, 0};
@@ -327,18 +330,19 @@
 		autoirq_setup(0);
 		outb_p(0x04 << ((*irqp == 9) ? 2 : *irqp), E33G_IDCFR);
 		outb_p(0x00, E33G_IDCFR);
-		if (*irqp == autoirq_report(0)	 /* It's a good IRQ line! */
-		    && request_irq (dev->irq = *irqp, ei_interrupt, 0, ei_status.name, dev) == 0)
+		if (*irqp == autoirq_report(0)	/* It's a good IRQ line! */
+		    && ((retval = request_irq(dev->irq = *irqp, 
+		    ei_interrupt, 0, dev->name, dev)) == 0))
 		    break;
 	    }
 	} while (*++irqp);
 	if (*irqp == 0) {
 	    outb(EGACFR_IRQOFF, E33G_GACFR);	/* disable interrupts. */
-	    return -EAGAIN;
+	    return retval;
 	}
     } else {
-	if (request_irq(dev->irq, ei_interrupt, 0, ei_status.name, dev)) {
-	    return -EAGAIN;
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
+	    return retval;
 	}
     }
 

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ac3200

diff -urN /mnt/disk/linux/drivers/net/ac3200.c /linux/drivers/net/ac3200.c
--- /mnt/disk/linux/drivers/net/ac3200.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/ac3200.c	Mon Nov  6 18:45:54 2000
@@ -121,8 +118,8 @@
 {
 	int i, retval;
 
-	if (!request_region(ioaddr, AC_IO_EXTENT, "ac3200"))
-		return -ENODEV;
+	if (!request_region(ioaddr, AC_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 	if (inb_p(ioaddr + AC_ID_PORT) == 0xff) {
 		retval = -ENODEV;
@@ -172,9 +169,8 @@
 		printk(", assigning");
 	}
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "ac3200", dev)) {
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 		printk (" nothing! Unable to get IRQ %d.\n", dev->irq);
-		retval = -EAGAIN;
 		goto out1;
 	}
 
@@ -260,11 +256,13 @@
 static int ac_open(struct net_device *dev)
 {
 #ifdef notyet
+	int retval;
+
 	/* Someday we may enable the IRQ and shared memory here. */
 	int ioaddr = dev->base_addr;
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "ac3200", dev))
-		return -EAGAIN;
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev)))
+		return retval;
 #endif
 
 	ei_open(dev);

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-cs89x0

diff -urN /mnt/disk/linux/drivers/net/cs89x0.c /linux/drivers/net/cs89x0.c
--- /mnt/disk/linux/drivers/net/cs89x0.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/cs89x0.c	Mon Nov  6 18:58:00 2000
@@ -378,8 +378,8 @@
 	lp = (struct net_local *)dev->priv;
 
 	/* Grab the region so we can find another board if autoIRQ fails. */
-	if (!request_region(ioaddr, NETCARD_IO_EXTENT, "cs89x0")) {
-		retval = -ENODEV;
+	if (!request_region(ioaddr, NETCARD_IO_EXTENT, dev->name)) {
+		retval = -EBUSY;
 		goto out1;
 	}
 
@@ -1028,10 +1028,10 @@
 		writereg(dev, PP_BusCTL, ENABLE_IRQ | MEMORY_ON);
 
 		for (i = 2; i < CS8920_NO_INTS; i++) if ((1 << dev->irq) & lp->irq_map) {
-			if (request_irq (i, NULL, 0, "cs89x0", dev) != -EBUSY) {
+			if (request_irq (i, NULL, 0, dev->name, dev) != -EBUSY) {
 				write_irq(dev, lp->chip_type, i);
 				writereg(dev, PP_BufCFG, GENERATE_SW_INTERRUPT);
-				if (request_irq (dev->irq = i, &net_interrupt, 0, "cs89x0", dev) == 0)
+				if (request_irq (dev->irq = i, &net_interrupt, 0, dev->name, dev) == 0)
 					break;
 			}
 		}
@@ -1058,7 +1058,7 @@
 		writereg(dev, PP_BusCTL, ENABLE_IRQ | MEMORY_ON);
 #endif
 		write_irq(dev, lp->chip_type, dev->irq);
-		if (request_irq(dev->irq, &net_interrupt, 0, "cs89x0", dev)) {
+		if (request_irq(dev->irq, &net_interrupt, 0, dev->name, dev)) {
 			if (net_debug)
 				printk("cs89x0: request_irq(%d) failed\n", dev->irq);
 			ret = -EAGAIN;
@@ -1089,7 +1089,7 @@
 				goto release_irq;
 			}
 			memset(lp->dma_buff, 0, lp->dmasize * 1024);	/* Why? */
-			if (request_dma(dev->dma, "cs89x0")) {
+			if (request_dma(dev->dma, dev->name)) {
 				printk(KERN_ERR "%s: cannot get dma channel %d\n", dev->name, dev->dma);
 				goto release_irq;
 			}

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-e2100

diff -urN /mnt/disk/linux/drivers/net/e2100.c /linux/drivers/net/e2100.c
--- /mnt/disk/linux/drivers/net/e2100.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/e2100.c	Mon Nov  6 18:59:33 2000
@@ -140,8 +140,8 @@
 	unsigned char *station_addr = dev->dev_addr;
 	static unsigned version_printed = 0;
 
-	if (!request_region(ioaddr, E21_IO_EXTENT, "e2100"))
-		return -ENODEV;
+	if (!request_region(ioaddr, E21_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 	/* First check the station address for the Ctron prefix. */
 	if (inb(ioaddr + E21_SAPROM + 0) != 0x00
@@ -255,10 +255,10 @@
 e21_open(struct net_device *dev)
 {
 	short ioaddr = dev->base_addr;
+	int retval;
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "e2100", dev)) {
-		return -EBUSY;
-	}
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev)))
+		return retval;
 
 	/* Set the interrupt line and memory base on the hardware. */
 	inb(ioaddr + E21_IRQ_LOW);

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hp

diff -urN /mnt/disk/linux/drivers/net/hp.c /linux/drivers/net/hp.c
--- /mnt/disk/linux/drivers/net/hp.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/hp.c	Mon Nov  6 19:06:29 2000
@@ -101,10 +101,10 @@
 {
 	int i, retval, board_id, wordmode;
 	const char *name;
-	static unsigned version_printed = 0;
+	static unsigned version_printed;
 
-	if (!request_region(ioaddr, HP_IO_EXTENT, "hp"))
-		return -ENODEV;
+	if (!request_region(ioaddr, HP_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 	/* Check for the HP physical address, 08 00 09 xx xx xx. */
 	/* This really isn't good enough: we may pick up HP LANCE boards
@@ -155,7 +155,7 @@
 				outb_p(irqmap[irq] | HP_RUN, ioaddr + HP_CONFIGURE);
 				outb_p( 0x00 | HP_RUN, ioaddr + HP_CONFIGURE);
 				if (irq == autoirq_report(0)		 /* It's a good IRQ line! */
-					&& request_irq (irq, ei_interrupt, 0, "hp", dev) == 0) {
+					&& request_irq (irq, ei_interrupt, 0, dev->name, dev) == 0) {
 					printk(" selecting IRQ %d.\n", irq);
 					dev->irq = *irqp;
 					break;
@@ -170,9 +170,8 @@
 	} else {
 		if (dev->irq == 2)
 			dev->irq = 9;
-		if (request_irq(dev->irq, ei_interrupt, 0, "hp", dev)) {
+		if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 			printk (" unable to get IRQ %d.\n", dev->irq);
-			retval = -EBUSY;
 			goto out1;
 		}
 	}

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hp-plus

diff -urN /mnt/disk/linux/drivers/net/hp-plus.c /linux/drivers/net/hp-plus.c
--- /mnt/disk/linux/drivers/net/hp-plus.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/hp-plus.c	Mon Nov  6 00:51:11 2000
@@ -141,10 +141,10 @@
 	unsigned char checksum = 0;
 	const char *name = "HP-PC-LAN+";
 	int mem_start;
-	static unsigned version_printed = 0;
+	static unsigned version_printed;
 
-	if (!request_region(ioaddr, HP_IO_EXTENT, "hp-plus"))
-		return -ENODEV;
+	if (!request_region(ioaddr, HP_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 	/* Check for the HP+ signature, 50 48 0x 53. */
 	if (inw(ioaddr + HP_ID) != 0x4850
@@ -249,9 +249,10 @@
 {
 	int ioaddr = dev->base_addr - NIC_OFFSET;
 	int option_reg;
+	int retval;
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "hp-plus", dev)) {
-	    return -EAGAIN;
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
+	    return retval;
 	}
 
 	/* Reset the 8390 and HP chip. */

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-lne390

diff -urN /mnt/disk/linux/drivers/net/lne390.c /linux/drivers/net/lne390.c
--- /mnt/disk/linux/drivers/net/lne390.c	Thu Nov  2 22:01:06 2000
+++ /linux/drivers/net/lne390.c	Mon Nov  6 19:10:14 2000
@@ -109,7 +109,7 @@
 	int ret;
 
 	if (ioaddr > 0x1ff) {		/* Check a single specified location. */
-		if (!request_region(ioaddr, LNE390_IO_EXTENT, "lne390"))
+		if (!request_region(ioaddr, LNE390_IO_EXTENT, dev->name))
 			return -EBUSY;
 		ret = lne390_probe1(dev, ioaddr);
 		if (ret)
@@ -128,7 +128,7 @@
 
 	/* EISA spec allows for up to 16 slots, but 8 is typical. */
 	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000) {
-		if (!request_region(ioaddr, LNE390_IO_EXTENT, "lne390"))
+		if (!request_region(ioaddr, LNE390_IO_EXTENT, dev->name))
 			continue;
 		if (lne390_probe1(dev, ioaddr) == 0)
 			return 0;
@@ -195,11 +195,11 @@
 	}
 	printk(" IRQ %d,", dev->irq);
 
-	if (request_irq(dev->irq, ei_interrupt, 0, "lne390", dev)) {
+	if ((ret = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
 		kfree(dev->priv);
 		dev->priv = NULL;
-		return -EAGAIN;
+		return ret;
 	}
 
 	if (dev->mem_start == 0) {

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ne

diff -urN /mnt/disk/linux/drivers/net/ne.c /linux/drivers/net/ne.c
--- /mnt/disk/linux/drivers/net/ne.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/ne.c	Mon Nov  6 19:14:49 2000
@@ -133,7 +133,7 @@
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
 /* Non-zero only if the current card is a PCI with BIOS-set IRQ. */
-static unsigned int pci_irq_line = 0;
+static unsigned int pci_irq_line;
 
 int ne_probe(struct net_device *dev);
 static int ne_probe1(struct net_device *dev, int ioaddr);
@@ -204,13 +204,9 @@
 
 #ifndef MODULE
 	/* Last resort. The semi-risky ISA auto-probe. */
-	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
-		int ioaddr = netcard_portlist[base_addr];
-		if (check_region(ioaddr, NE_IO_EXTENT))
-			continue;
-		if (ne_probe1(dev, ioaddr) == 0)
+	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++)
+		if (ne_probe1(dev, netcard_portlist[base_addr]) == 0)
 			return 0;
-	}
 #endif
 
 	return -ENODEV;
@@ -229,9 +225,6 @@
 			if (pci_enable_device(pdev))
 				continue;
 			pci_ioaddr = pci_resource_start (pdev, 0);
-			/* Avoid already found cards from previous calls */
-			if (check_region(pci_ioaddr, NE_IO_EXTENT))
-				continue;
 			pci_irq_line = pdev->irq;
 			if (pci_irq_line) break;	/* Found it */
 		}
@@ -295,17 +288,22 @@
 
 static int __init ne_probe1(struct net_device *dev, int ioaddr)
 {
-	int i;
+	int i, retval;
 	unsigned char SA_prom[32];
 	int wordlength = 2;
 	const char *name = NULL;
 	int start_page, stop_page;
 	int neX000, ctron, copam, bad_card;
-	int reg0 = inb_p(ioaddr);
-	static unsigned version_printed = 0;
+	int reg0;
+	static unsigned version_printed;
+
+	if (!request_region(ioaddr, NE_IO_EXTENT, dev->name))
+		return -EBUSY;
 
-	if (reg0 == 0xFF)
-		return -ENODEV;
+	if ((reg0 = inb_p(ioaddr)) == 0xFF) {
+		retval = -ENODEV;
+		goto out;
+	}
 
 	/* Do a preliminary verification that we have a 8390. */
 	{
@@ -318,7 +316,8 @@
 		if (inb_p(ioaddr + EN0_COUNTER0) != 0) {
 			outb_p(reg0, ioaddr);
 			outb_p(regd, ioaddr + 0x0d);	/* Restore the old values. */
-			return -ENODEV;
+			retval = -ENODEV;
+			goto out;
 		}
 	}
 
@@ -350,7 +349,8 @@
 				break;
 			} else {
 				printk(" not found (no reset ack).\n");
-				return -ENODEV;
+				retval = -ENODEV;
+				goto out;
 			}
 		}
 	
@@ -452,11 +452,13 @@
 		{
 			printk(" not found (invalid signature %2.2x %2.2x).\n",
 				SA_prom[14], SA_prom[15]);
-			return -ENXIO;
+			retval = -ENXIO;
+			goto out;
 		}
 #else
 		printk(" not found.\n");
-		return -ENXIO;
+		retval = -ENXIO;
+		goto out;
 #endif
 	}
 
@@ -482,31 +484,30 @@
 
 	if (! dev->irq) {
 		printk(" failed to detect IRQ line.\n");
-		return -EAGAIN;
+		retval = -EAGAIN;
+		goto out;
 	}
 
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) 
 	{
         	printk (" unable to get memory for dev->priv.\n");
-        	return -ENOMEM;
+        	retval = -ENOMEM;
+		goto out;
 	}
    
 	/* Snarf the interrupt now.  There's no point in waiting since we cannot
 	   share and the board will usually be enabled. */
-
-	{
-		int irqval = request_irq(dev->irq, ei_interrupt,
-				 pci_irq_line ? SA_SHIRQ : 0, name, dev);
-		if (irqval) {
-			printk (" unable to get IRQ %d (irqval=%d).\n", dev->irq, irqval);
-			kfree(dev->priv);
-			dev->priv = NULL;
-			return -EAGAIN;
-		}
+	retval = request_irq(dev->irq, ei_interrupt,
+			     pci_irq_line ? SA_SHIRQ : 0, dev->name, dev);
+	if (retval) {
+		printk (" unable to get IRQ %d (irqval=%d).\n", dev->irq, retval);
+		kfree(dev->priv);
+		dev->priv = NULL;
+		goto out;
 	}
+
 	dev->base_addr = ioaddr;
-	request_region(ioaddr, NE_IO_EXTENT, name);
 
 	for(i = 0; i < ETHER_ADDR_LEN; i++) {
 		printk(" %2.2x", SA_prom[i]);
@@ -536,6 +537,9 @@
 	dev->stop = &ne_close;
 	NS8390_init(dev, 0);
 	return 0;
+out:
+	release_region(ioaddr, NE_IO_EXTENT);
+	return retval;
 }
 
 static int ne_open(struct net_device *dev)

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-wd

diff -urN /mnt/disk/linux/drivers/net/wd.c /linux/drivers/net/wd.c
--- /mnt/disk/linux/drivers/net/wd.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/wd.c	Sat Nov  4 19:18:03 2000
@@ -91,32 +91,33 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
-	for (i = 0; wd_portlist[i]; i++) {
-		int ioaddr = wd_portlist[i];
-		if (check_region(ioaddr, WD_IO_EXTENT))
-			continue;
-		if (wd_probe1(dev, ioaddr) == 0)
+	for (i = 0; wd_portlist[i]; i++)
+		if (wd_probe1(dev, wd_portlist[i]) == 0)
 			return 0;
-	}
 
 	return -ENODEV;
 }
 
 static int __init wd_probe1(struct net_device *dev, int ioaddr)
 {
-	int i;
+	int i, retval;
 	int checksum = 0;
 	int ancient = 0;			/* An old card without config registers. */
 	int word16 = 0;				/* 0 = 8 bit, 1 = 16 bit */
 	const char *model_name;
-	static unsigned version_printed = 0;
+	static unsigned version_printed;
+
+	if (!request_region(ioaddr, WD_IO_EXTENT, dev->name))
+		return -EBUSY;
 
 	for (i = 0; i < 8; i++)
 		checksum += inb(ioaddr + 8 + i);
 	if (inb(ioaddr + 8) == 0xff 	/* Extra check to avoid soundcard. */
 		|| inb(ioaddr + 9) == 0xff
-		|| (checksum & 0xff) != 0xFF)
-		return -ENODEV;
+		|| (checksum & 0xff) != 0xFF) {
+		retval = -ENODEV;
+		goto out;
+	}
 
 	/* Check for semi-valid mem_start/end values if supplied. */
 	if ((dev->mem_start % 0x2000) || (dev->mem_end % 0x2000)) {
@@ -243,21 +244,20 @@
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
 		printk (" unable to get memory for dev->priv.\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto out;
 	}
 
 	/* Snarf the interrupt now.  There's no point in waiting since we cannot
 	   share and the board will usually be enabled. */
-	if (request_irq(dev->irq, ei_interrupt, 0, model_name, dev)) {
+	if ((retval = request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
 		kfree(dev->priv);
 		dev->priv = NULL;
-		return -EAGAIN;
+		goto out;
 	}
 
 	/* OK, were are certain this is going to work.  Setup the device. */
-	request_region(ioaddr, WD_IO_EXTENT, model_name);
-
 	ei_status.name = model_name;
 	ei_status.word16 = word16;
 	ei_status.tx_start_page = WD_START_PG;
@@ -294,6 +294,9 @@
 #endif
 
 	return 0;
+out:
+	release_region(ioaddr, WD_IO_EXTENT);
+	return retval;
 }
 
 static int

--3V7upXqbjpZ4EhLz--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
