Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAFMco>; Sat, 6 Jan 2001 07:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131701AbRAFMce>; Sat, 6 Jan 2001 07:32:34 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:50146 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131594AbRAFMcQ>; Sat, 6 Jan 2001 07:32:16 -0500
Message-ID: <3A5711AB.D258FEB5@uow.edu.au>
Date: Sat, 06 Jan 2001 23:38:03 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] drivers/net/359x.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

could you please give this a whizz in the 2.4.0-ac tree?

- Call pci_enable_device before we request our IRQ (Tobias Ringstrom)

- Added a hack to override the PCI latency timer for 3c590's (merge
  from Donald's drivers)

- Added (vastly) extended busywait for command completion for the 3c905CX.

  Typically 30 milliseconds.

  Yes, we'll call schedule() here one day, but given the amount of
  fun we've had with races around device probe, /sbin/hotplug
  and module unload, I don't want to add scheduling to 3c59x's
  open() method.

- Look for an MII on PHY index 24 first.

  This is now as-per the datasheet.  It used to work, but the
  3c905CX broke it.

- Add HAS_NWAY to 3cSOHO100-TX (Brett Frankenberger)

  Apparently this makes the SOHO NIC work.  Neither Donald
  nor I have the hardware.

- Don't free skbs we don't own on OOM path in vortex_open().

  This bug is probably fatal.  If the interface is opened
  and it hits an out-of-memory in the right place we end
  up passing NULL or old pointers to kfree_skb().


Thanks.



--- linux-2.4.0/drivers/net/3c59x.c	Tue Nov 21 20:11:20 2000
+++ linux-akpm/drivers/net/3c59x.c	Sat Jan  6 23:23:34 2001
@@ -118,6 +118,14 @@
    LK1.1.11 13 Nov 2000 andrewm
     - Dump MOD_INC/DEC_USE_COUNT, use SET_MODULE_OWNER
 
+   LK1.1.12 1 Jan 2001 andrewm
+    - Call pci_enable_device before we request our IRQ (Tobias Ringstrom)
+    - Add 3c590 PCI latency timer hack to vortex_probe1 (from 0.99Ra)
+    - Added extended wait_for_completion for the 3c905CX.
+    - Look for an MII on PHY index 24 first (3c905CX oddity).
+    - Add HAS_NWAY to 3cSOHO100-TX (Brett Frankenberger)
+    - Don't free skbs we don't own on oom path in vortex_open().
+
     - See http://www.uow.edu.au/~andrewm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 */
@@ -203,7 +211,7 @@
 #include <linux/delay.h>
 
 static char version[] __devinitdata =
-"3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html " "$Revision: 1.102.2.46 $\n";
+"3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html " "$Revision: 1.102.2.46 $\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c59x/3c90x/3c575 series Vortex/Boomerang/Cyclone driver");
@@ -424,7 +432,7 @@
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE, 128, },
 
 	{"3cSOHO100-TX Hurricane",
-	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE, 128, },
+	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY, 128, },
 	{"3c555 Laptop Hurricane",
 	 PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|EEPROM_8BIT, 128, },
 	{"3c556 Laptop Tornado",
@@ -843,10 +851,15 @@
 {
 	int rc;
 
-	rc = vortex_probe1 (pdev, pci_resource_start (pdev, 0), pdev->irq,
-			    ent->driver_data, vortex_cards_found);
-	if (rc == 0)
-		vortex_cards_found++;
+	/* wake up and enable device */		
+	if (pci_enable_device (pdev)) {
+		rc = -EIO;
+	} else {
+		rc = vortex_probe1 (pdev, pci_resource_start (pdev, 0), pdev->irq,
+				    ent->driver_data, vortex_cards_found);
+		if (rc == 0)
+			vortex_cards_found++;
+	}
 	return rc;
 }
 
@@ -863,7 +876,7 @@
 	struct vortex_private *vp;
 	int option;
 	unsigned int eeprom[0x40], checksum = 0;		/* EEPROM contents */
-	int i;
+	int i, step;
 	struct net_device *dev;
 	static int printed_version;
 	int retval;
@@ -889,7 +902,6 @@
 	       vci->name,
 	       ioaddr);
 
-	/* private struct aligned and zeroed by init_etherdev */
 	vp = dev->priv;
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
@@ -908,19 +920,29 @@
 	if (pdev) {
 		/* EISA resources already marked, so only PCI needs to do this here */
 		/* Ignore return value, because Cardbus drivers already allocate for us */
-		if (request_region(ioaddr, vci->io_size, dev->name) != NULL) {
+		if (request_region(ioaddr, vci->io_size, dev->name) != NULL)
 			vp->must_free_region = 1;
-		}
-
-		/* wake up and enable device */		
-		if (pci_enable_device (pdev)) {
-			retval = -EIO;
-			goto free_region;
-		}
 
 		/* enable bus-mastering if necessary */		
 		if (vci->flags & PCI_USES_MASTER)
 			pci_set_master (pdev);
+
+		if (vci->drv_flags & IS_VORTEX) {
+			u8 pci_latency;
+			u8 new_latency = 248;
+
+			/* Check the PCI latency value.  On the 3c590 series the latency timer
+			   must be set to the maximum value to avoid data corruption that occurs
+			   when the timer expires during a transfer.  This bug exists the Vortex
+			   chip only. */
+			pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &pci_latency);
+			if (pci_latency < new_latency) {
+				printk(KERN_INFO "%s: Overriding PCI latency"
+					" timer (CFLT) setting of %d, new value is %d.\n",
+					dev->name, pci_latency, new_latency);
+					pci_write_config_byte(pdev, PCI_LATENCY_TIMER, new_latency);
+			}
+		}
 	}
 
 	spin_lock_init(&vp->lock);
@@ -1025,6 +1047,13 @@
 			   dev->irq);
 #endif
 
+	EL3WINDOW(4);
+	step = (inb(ioaddr + Wn4_NetDiag) & 0x1e) >> 1;
+	printk(KERN_INFO "  product code '%c%c' rev %02x.%d date %02d-"
+		   "%02d-%02d\n", eeprom[6]&0xff, eeprom[6]>>8, eeprom[0x14],
+		   step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
+
+
 	if (pdev && vci->drv_flags & HAS_CB_FNS) {
 		unsigned long fn_st_addr;			/* Cardbus function status space */
 		unsigned short n;
@@ -1089,8 +1118,19 @@
 		mii_preamble_required++;
 		mii_preamble_required++;
 		mdio_read(dev, 24, 1);
-		for (phy = 1; phy <= 32 && phy_idx < sizeof(vp->phys); phy++) {
-			int mii_status, phyx = phy & 0x1f;
+		for (phy = 0; phy < 32 && phy_idx < 1; phy++) {
+			int mii_status, phyx;
+
+			/*
+			 * For the 3c905CX we look at index 24 first, because it bogusly
+			 * reports an external PHY at all indices
+			 */
+			if (phy == 0)
+				phyx = 24;
+			else if (phy <= 24)
+				phyx = phy - 1;
+			else
+				phyx = phy;
 			mii_status = mdio_read(dev, phyx, 1);
 			if (mii_status  &&  mii_status != 0xffff) {
 				vp->phys[phy_idx++] = phyx;
@@ -1135,12 +1175,13 @@
 	dev->set_multicast_list = set_rx_mode;
 	dev->tx_timeout = vortex_tx_timeout;
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
-
+//	publish_netdev(dev);
 	return 0;
 
 free_region:
 	if (vp->must_free_region)
 		release_region(ioaddr, vci->io_size);
+//	withdraw_netdev(dev);
 	unregister_netdev(dev);
 	kfree (dev);
 	printk(KERN_ERR PFX "vortex_probe1 fails.  Returns %d\n", retval);
@@ -1150,13 +1191,23 @@
 
 static void wait_for_completion(struct net_device *dev, int cmd)
 {
-	int i = 4000;
+	int i;
 
 	outw(cmd, dev->base_addr + EL3_CMD);
-	while (--i > 0) {
+	for (i = 0; i < 2000; i++) {
 		if (!(inw(dev->base_addr + EL3_STATUS) & CmdInProgress))
 			return;
 	}
+
+	/* OK, that didn't work.  Do it the slow way.  One second */
+	for (i = 0; i < 100000; i++) {
+		if (!(inw(dev->base_addr + EL3_STATUS) & CmdInProgress)) {
+			printk(KERN_INFO "%s: command 0x%04x took %d usecs! Please tell andrewm@uow.edu.au\n",
+					   dev->name, cmd, i * 10);
+			return;
+		}
+		udelay(10);
+	}
 	printk(KERN_ERR "%s: command 0x%04x did not complete! Status=0x%x\n",
 			   dev->name, cmd, inw(dev->base_addr + EL3_STATUS));
 }
@@ -1331,6 +1382,7 @@
 	set_rx_mode(dev);
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 
+//	wait_for_completion(dev, SetTxStart|0x07ff);
 	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
 	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
 	/* Allow status bits to be seen. */
@@ -1384,7 +1436,8 @@
 		}
 		if (i != RX_RING_SIZE) {
 			int j;
-			for (j = 0; j < RX_RING_SIZE; j++) {
+			printk(KERN_EMERG "%s: no memory for rx ring\n", dev->name);
+			for (j = 0; j < i; j++) {
 				if (vp->rx_skbuff[j]) {
 					dev_kfree_skb(vp->rx_skbuff[j]);
 					vp->rx_skbuff[j] = 0;
@@ -1532,7 +1585,10 @@
 	printk(KERN_ERR "%s: transmit timed out, tx_status %2.2x status %4.4x.\n",
 		   dev->name, inb(ioaddr + TxStatus),
 		   inw(ioaddr + EL3_STATUS));
-
+	EL3WINDOW(4);
+	printk(KERN_ERR "  diagnostics: net %04x media %04x dma %8.8x.\n",
+		   inw(ioaddr + Wn4_NetDiag), inw(ioaddr + Wn4_Media),
+		   inl(ioaddr + PktStatus));
 	/* Slight code bloat to be user friendly. */
 	if ((inb(ioaddr + TxStatus) & 0x88) == 0x88)
 		printk(KERN_ERR "%s: Transmitter encountered 16 collisions --"
@@ -1663,6 +1719,12 @@
 			   dev->name, fifo_diag);
 		/* Adapter failure requires Tx/Rx reset and reinit. */
 		if (vp->full_bus_master_tx) {
+			int bus_status = inl(ioaddr + PktStatus);
+			/* 0x80000000 PCI master abort. */
+			/* 0x40000000 PCI target abort. */
+			if (vortex_debug)
+				printk(KERN_ERR "%s: PCI bus error, bus status %8.8x\n", dev->name, bus_status);
+
 			/* In this case, blow the card away */
 			vortex_down(dev);
 			wait_for_completion(dev, TotalReset | 0xff);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
