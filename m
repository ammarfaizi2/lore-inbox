Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130101AbQKCMLU>; Fri, 3 Nov 2000 07:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbQKCMLL>; Fri, 3 Nov 2000 07:11:11 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:3337 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130101AbQKCMKy>; Fri, 3 Nov 2000 07:10:54 -0500
Date: Fri, 3 Nov 2000 16:08:44 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ac3200.c, ne3210.c, fmv18x.c & sis900.c check_region() removal
Message-ID: <20001103160843.A6349@server.ipt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

new check_region() removal patchset (for 2.4.0-test10) is here :)

Best regards,
	    Andrey
-- 
Andrey Panin 		| Embedded systems software engineer
pazke@orbita1.ru	| PGP key: http://www.orbita1.ru/~pazke/AndreyPanin.asc

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ac3200

diff -urN /mnt/disk/linux/drivers/net/ac3200.c /linux/drivers/net/ac3200.c
--- /mnt/disk/linux/drivers/net/ac3200.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/ac3200.c	Thu Nov  2 22:36:48 2000
@@ -107,12 +107,9 @@
 	if ( ! EISA_bus)
 		return -ENXIO;
 
-	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000) {
-		if (check_region(ioaddr, AC_IO_EXTENT))
-			continue;
+	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000)
 		if (ac_probe1(ioaddr, dev) == 0)
 			return 0;
-	}
 
 	return -ENODEV;
 }

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ne3210

diff -urN /mnt/disk/linux/drivers/net/ne3210.c /linux/drivers/net/ne3210.c
--- /mnt/disk/linux/drivers/net/ne3210.c	Thu Nov  2 22:01:06 2000
+++ /linux/drivers/net/ne3210.c	Thu Nov  2 23:00:17 2000
@@ -112,23 +112,26 @@
 	}
 
 	/* EISA spec allows for up to 16 slots, but 8 is typical. */
-	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000) {
-		if (check_region(ioaddr , NE3210_IO_EXTENT))
-			continue;
+	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000)
 		if (ne3210_probe1(dev, ioaddr) == 0)
 			return 0;
-	}
 
 	return -ENODEV;
 }
 
 int __init ne3210_probe1(struct net_device *dev, int ioaddr)
 {
-	int i;
+	int i, retval;
 	unsigned long eisa_id;
 	const char *ifmap[] = {"UTP", "?", "BNC", "AUI"};
 
-	if (inb_p(ioaddr + NE3210_ID_PORT) == 0xff) return -ENODEV;
+	if (!request_region(dev->base_addr, NE3210_IO_EXTENT, "ne3210"))
+		return -ENODEV;
+
+	if (inb_p(ioaddr + NE3210_ID_PORT) == 0xff) {
+		retval = -ENODEV;
+		goto out;
+	}
 
 #if NE3210_DEBUG & NE3210_D_PROBE
 	printk("ne3210-debug: probe at %#x, ID %#8x\n", ioaddr, inl(ioaddr + NE3210_ID_PORT));
@@ -140,7 +143,8 @@
 /*	Check the EISA ID of the card. */
 	eisa_id = inl(ioaddr + NE3210_ID_PORT);
 	if (eisa_id != NE3210_ID) {
-		return -ENODEV;
+		retval = -ENODEV;
+		goto out;
 	}
 
 	
@@ -153,14 +157,16 @@
 		for(i = 0; i < ETHER_ADDR_LEN; i++)
 			printk(" %02x", inb(ioaddr + NE3210_SA_PROM + i));
 		printk(" (invalid prefix).\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto out;
 	}
 #endif
 
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
 		printk ("ne3210.c: unable to allocate memory for dev->priv!\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto out;
 	}
 
 	printk("ne3210.c: NE3210 in EISA slot %d, media: %s, addr:",
@@ -183,9 +189,8 @@
 
 	if (request_irq(dev->irq, ei_interrupt, 0, "ne3210", dev)) {
 		printk (" unable to get IRQ %d.\n", dev->irq);
-		kfree(dev->priv);
-		dev->priv = NULL;
-		return -EAGAIN;
+		retval = -EAGAIN;
+		goto out1;
 	}
 
 	if (dev->mem_start == 0) {
@@ -211,20 +216,16 @@
 			printk(KERN_CRIT "ne3210.c: Use EISA SCU to set card memory below 1MB,\n");
 			printk(KERN_CRIT "ne3210.c: or to an address above 0x%lx.\n", virt_to_bus(high_memory));
 			printk(KERN_CRIT "ne3210.c: Driver NOT installed.\n");
-			free_irq(dev->irq, dev);
-			kfree(dev->priv);
-			dev->priv = NULL;
-			return -EINVAL;
+			retval = -EINVAL;
+			goto out2;
 		}
 		dev->mem_start = (unsigned long)ioremap(dev->mem_start, NE3210_STOP_PG*0x100);
 		if (dev->mem_start == 0) {
 			printk(KERN_ERR "ne3210.c: Unable to remap card memory above 1MB !!\n");
 			printk(KERN_ERR "ne3210.c: Try using EISA SCU to set memory below 1MB.\n");
 			printk(KERN_ERR "ne3210.c: Driver NOT installed.\n");
-			free_irq(dev->irq, dev);
-			kfree(dev->priv);
-			dev->priv = NULL;
-			return -EAGAIN;
+			retval = -EAGAIN;
+			goto out2;
 		}
 		ei_status.reg0 = 1;	/* Use as remap flag */
 		printk("ne3210.c: remapped %dkB card memory to virtual address %#lx\n",
@@ -237,7 +238,6 @@
 
 	/* The 8390 offset is zero for the NE3210 */
 	dev->base_addr = ioaddr;
-	request_region(dev->base_addr, NE3210_IO_EXTENT, "ne3210");
 
 	ei_status.name = "NE3210";
 	ei_status.tx_start_page = NE3210_START_PG;
@@ -257,6 +257,14 @@
 	dev->stop = &ne3210_close;
 	NS8390_init(dev, 0);
 	return 0;
+out2:
+	free_irq(dev->irq, dev);	
+out1:
+	kfree(dev->priv);
+	dev->priv = NULL;
+out:
+	release_region(ioaddr, NE3210_IO_EXTENT);
+	return retval;
 }
 
 /*

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-fmv18x

diff -urN /mnt/disk/linux/drivers/net/fmv18x.c /linux/drivers/net/fmv18x.c
--- /mnt/disk/linux/drivers/net/fmv18x.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/fmv18x.c	Thu Nov  2 23:30:26 2000
@@ -139,13 +139,9 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
-	for (i = 0; fmv18x_probe_list[i]; i++) {
-		int ioaddr = fmv18x_probe_list[i];
- 		if (check_region(ioaddr, FMV18X_IO_EXTENT))
-			continue;
-		if (fmv18x_probe1(dev, ioaddr) == 0)
+	for (i = 0; fmv18x_probe_list[i]; i++)
+		if (fmv18x_probe1(dev, fmv18x_probe_list[i]) == 0)
 			return 0;
-	}
 
 	return -ENODEV;
 }
@@ -162,17 +158,22 @@
 {
 	char irqmap[4] = {3, 7, 10, 15};
 	char irqmap_pnp[8] = {3, 4, 5, 7, 9, 10, 11, 15};
-	unsigned int i, irq;
+	unsigned int i, irq, retval;
 
 	/* Resetting the chip doesn't reset the ISA interface, so don't bother.
 	   That means we have to be careful with the register values we probe for.
 	   */
 
+	if (!request_region(ioaddr, FMV18X_IO_EXTENT, "fmv18x"))
+		return -ENODEV;
+
 	/* Check I/O address configuration and Fujitsu vendor code */
 	if (inb(ioaddr+FJ_MACADDR  ) != 0x00
 	||  inb(ioaddr+FJ_MACADDR+1) != 0x00
-	||  inb(ioaddr+FJ_MACADDR+2) != 0x0e)
-		return -ENODEV;
+	||  inb(ioaddr+FJ_MACADDR+2) != 0x0e) {
+		retval = -ENODEV;
+		goto out;
+	}
 
 	/* Check PnP mode for FMV-183/184/183A/184A. */
 	/* This PnP routine is very poor. IO and IRQ should be known. */
@@ -182,8 +183,10 @@
 			if (irq == irqmap_pnp[i])
 				break;
 		}
-		if (i == 8)
-			return -ENODEV;
+		if (i == 8) {
+			retval = -ENODEV;
+			goto out;
+		}
 	} else {
 		if (fmv18x_probe_list[inb(ioaddr + FJ_CONFIG0) & 0x07] != ioaddr)
 			return -ENODEV;
@@ -194,13 +197,10 @@
 	if (request_irq(irq, &net_interrupt, 0, "fmv18x", dev)) {
 		printk ("FMV-18x found at %#3x, but it's unusable due to a conflict on"
 				"IRQ %d.\n", ioaddr, irq);
-		return -EAGAIN;
+		retval = -EAGAIN;
+		goto out;
 	}
 
-	/* Grab the region so that we can find another board if the IRQ request
-	   fails. */
- 	request_region(ioaddr, FMV18X_IO_EXTENT, "fmv18x");
-
 	printk("%s: FMV-18x found at %#3x, IRQ %d, address ", dev->name,
 		   ioaddr, irq);
 
@@ -261,8 +261,11 @@
 
 	/* Initialize the device structure. */
 	dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
-	if (dev->priv == NULL)
-		return -ENOMEM;
+	if (dev->priv == NULL) {
+		free_irq(irq, dev);
+		retval = -ENOMEM;
+		goto out;
+	}
 	memset(dev->priv, 0, sizeof(struct net_local));
 
 	dev->open		= net_open;
@@ -277,6 +280,9 @@
 
 	ether_setup(dev);
 	return 0;
+out:
+	release_region(ioaddr, FMV18X_IO_EXTENT);
+	return retval;
 }
 
 

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sis900

diff -urN /mnt/disk/linux/drivers/net/sis900.c /linux/drivers/net/sis900.c
--- /mnt/disk/linux/drivers/net/sis900.c	Fri Oct 13 21:40:08 2000
+++ /linux/drivers/net/sis900.c	Sun Oct 15 11:45:55 2000
@@ -62,7 +62,7 @@
 static int multicast_filter_limit = 128;
 
 #define sis900_debug debug
-static int sis900_debug = 0;
+static int sis900_debug;
 
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (4*HZ)
@@ -172,6 +172,8 @@
 static void sis900_reset(struct net_device *net_dev);
 static void sis630e_set_eq(struct net_device *net_dev);
 
+#define SIS900_MODULE_NAME "sis900"
+
 /* walk through every ethernet PCI devices to see if some of them are matched with our card list*/
 static int __init sis900_probe (struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
 {
@@ -184,7 +186,7 @@
 	}
 
 	pci_io_base = pci_resource_start(pci_dev, 0);
-	if (check_region(pci_io_base, SIS900_TOTAL_SIZE)) {
+	if (!request_region(pci_io_base, SIS900_TOTAL_SIZE, SIS900_MODULE_NAME)) {
 		printk(KERN_ERR "sis900.c: can't allocate I/O space at 0x%08x\n",
 		       pci_io_base);
 		return -ENODEV;
@@ -192,14 +194,17 @@
 
 	/* setup various bits in PCI command register */
 	if (pci_enable_device (pci_dev))
-		return -ENODEV;
+		goto out;
 	pci_set_master(pci_dev);
 
 	/* do the real low level jobs */
 	if (sis900_mac_probe(pci_dev, card_names[pci_id->driver_data]) == NULL)
-		return -ENODEV;
+		goto out;
 
 	return 0;
+out:
+	release_region(pci_io_base, SIS900_TOTAL_SIZE);
+	return -ENODEV;
 }
 
 /* older SiS900 and friends, use EEPROM to store MAC address */
@@ -287,8 +292,6 @@
 	sis_priv = net_dev->priv;
 	memset(sis_priv, 0, sizeof(struct sis900_private));
 
-	/* We do a request_region() to register /proc/ioports info. */
-	request_region(ioaddr, SIS900_TOTAL_SIZE, net_dev->name);
 	net_dev->base_addr = ioaddr;
 	net_dev->irq = irq;
 	sis_priv->pci_dev = pci_dev;
@@ -298,7 +301,6 @@
 	if (sis900_mii_probe(net_dev) == 0) {
 		unregister_netdev(net_dev);
 		kfree(sis_priv);
-		release_region(ioaddr, SIS900_TOTAL_SIZE);
 		return NULL;
 	}
 
@@ -1442,8 +1444,6 @@
 	kfree(sis_priv);
 	kfree(net_dev);
 }
-
-#define SIS900_MODULE_NAME "sis900"
 
 static struct pci_driver sis900_pci_driver = {
 	name:		SIS900_MODULE_NAME,

--1LKvkjL3sHcu1TtY--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
