Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbRGGBnE>; Fri, 6 Jul 2001 21:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbRGGBmp>; Fri, 6 Jul 2001 21:42:45 -0400
Received: from customers.imt.ru ([212.16.0.33]:43293 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S264644AbRGGBmd>;
	Fri, 6 Jul 2001 21:42:33 -0400
Message-ID: <20010706184042.D257@saw.sw.com.sg>
Date: Fri, 6 Jul 2001 18:40:42 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eepro100 PCI/PM fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Could you apply the following patch, please?

	Andrey

----- Forwarded message from Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> -----

Delivered-To: saw-main@saw.sw.com.sg
Date: Fri, 6 Jul 2001 22:51:02 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: <saw@saw.sw.com.sg>
Subject: [PATCH] eepro100 PCI/PM fixes


Hi!

Appened patch against 2.4.7-pre3 fixes a couple of issues in the eepro100 
driver. I realize some of the changes may be not appropriate due to 
compatibility concerns or whatever.

o call pci_enable_device before accessing resources/irqs. 
  pci_enable_device needs to be called, because it may change/assign the 
  IRQ / resources (not yet).
o call pci_disable_device at appropriate places. Not urgently needed but
  cleaner anyway.
o pci_set_power_state is provided by include/linux/pci.h even if
  CONFIG_PM is not set
o .acpi_pwr was never really used
o don't do the acpi_idle_state thing. Drivers shouldn't need to care about
  this level of things. After an open/close cycle, the chip will be placed
  in D2. So it's just consistent to do so before the first open as well.
 
--Kai


diff -urN linux-2.4.7-pre3.1/drivers/net/eepro100.c linux-2.4.7-pre3.work/drivers/net/eepro100.c
--- linux-2.4.7-pre3.1/drivers/net/eepro100.c	Wed Jul  4 12:37:13 2001
+++ linux-2.4.7-pre3.work/drivers/net/eepro100.c	Fri Jul  6 22:41:26 2001
@@ -139,16 +139,6 @@
 
 #define RUN_AT(x) (jiffies + (x))
 
-/* ACPI power states don't universally work (yet) */
-#ifndef CONFIG_PM
-#undef pci_set_power_state
-#define pci_set_power_state null_set_power_state
-static inline int null_set_power_state(struct pci_dev *dev, int state)
-{
-	return 0;
-}
-#endif /* CONFIG_PM */
-
 #define netdevice_start(dev)
 #define netdevice_stop(dev)
 #define netif_set_tx_timeout(dev, tf, tm) \
@@ -165,7 +155,7 @@
 #endif
 
 
-int speedo_debug = 1;
+static int speedo_debug = 1;
 
 /*
 				Theory of Operation
@@ -281,7 +271,7 @@
 
 */
 
-static int speedo_found1(struct pci_dev *pdev, long ioaddr, int fnd_cnt, int acpi_idle_state);
+static int speedo_found1(struct pci_dev *pdev, long ioaddr, int fnd_cnt);
 
 enum pci_flags_bit {
 	PCI_USES_IO=1, PCI_USES_MEM=2, PCI_USES_MASTER=4,
@@ -480,7 +470,6 @@
 	struct speedo_mc_block *mc_setup_head;/* Multicast setup frame list head. */
 	struct speedo_mc_block *mc_setup_tail;/* Multicast setup frame list tail. */
 	long in_interrupt;					/* Word-aligned dev->interrupt */
-	unsigned char acpi_pwr;
 	signed char rx_mode;					/* Current PROMISC/ALLMULTI setting. */
 	unsigned int tx_full:1;				/* The Tx queue is full. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
@@ -559,17 +548,21 @@
 {
 	unsigned long ioaddr;
 	int irq;
-	int acpi_idle_state = 0, pm;
 	static int cards_found /* = 0 */;
 
 	static int did_version /* = 0 */;		/* Already printed version info. */
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);
 
+	if (pci_enable_device(pdev))
+		goto err_out_none;
+
+	pci_set_master(pdev);
+
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
 		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
-		goto err_out_none;
+		goto err_out_disable;
 	}
 	if (!request_mem_region(pci_resource_start(pdev, 0),
 			pci_resource_len(pdev, 0), "eepro100")) {
@@ -596,20 +589,7 @@
 			   pci_resource_start(pdev, 0), irq);
 #endif
 
-	/* save power state b4 pci_enable_device overwrites it */
-	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
-	if (pm) {
-		u16 pwr_command;
-		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
-		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
-	}
-
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;
-
-	pci_set_master(pdev);
-
-	if (speedo_found1(pdev, ioaddr, cards_found, acpi_idle_state) == 0)
+	if (speedo_found1(pdev, ioaddr, cards_found) == 0)
 		cards_found++;
 	else
 		goto err_out_iounmap;
@@ -624,12 +604,14 @@
 	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 err_out_free_pio_region:
 	release_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+err_out_disable:
+	pci_disable_device(pdev);
 err_out_none:
 	return -ENODEV;
 }
 
 static int speedo_found1(struct pci_dev *pdev,
-		long ioaddr, int card_idx, int acpi_idle_state)
+						 long ioaddr, int card_idx)
 {
 	struct net_device *dev;
 	struct speedo_private *sp;
@@ -795,8 +777,8 @@
 	inl(ioaddr + SCBPort);
 	udelay(10);
 
-	/* Return the chip to its original power state. */
-	pci_set_power_state(pdev, acpi_idle_state);
+	/* Put chip into power state D2 until we open() it. */
+	pci_set_power_state(pdev, 2);
 
 	pci_set_drvdata (pdev, dev);
 
@@ -805,7 +787,6 @@
 
 	sp = dev->priv;
 	sp->pdev = pdev;
-	sp->acpi_pwr = acpi_idle_state;
 	sp->tx_ring = tx_ring_space;
 	sp->tx_ring_dma = tx_ring_dma;
 	sp->lstats = (struct speedo_stats *)(sp->tx_ring + TX_RING_SIZE);
@@ -1920,7 +1900,8 @@
 		   access from the timeout handler.
 		   They are currently serialized only with MDIO access from the
 		   timer routine.  2000/05/09 SAW */
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = sp->pdev->current_state;
+		pci_set_power_state(sp->pdev, 0);
 		t = del_timer_sync(&sp->timer);
 		data->val_out = mdio_read(ioaddr, data->phy_id & 0x1f, data->reg_num & 0x1f);
 		if (t)
@@ -1932,7 +1913,8 @@
 	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		saved_acpi = pci_set_power_state(sp->pdev, 0);
+		saved_acpi = sp->pdev->current_state;
+		pci_set_power_state(sp->pdev, 0);
 		t = del_timer_sync(&sp->timer);
 		mdio_write(ioaddr, data->phy_id, data->reg_num, data->val_in);
 		if (t)
@@ -2202,6 +2184,7 @@
 	pci_free_consistent(pdev, TX_RING_SIZE * sizeof(struct TxFD)
 								+ sizeof(struct speedo_stats),
 						sp->tx_ring, sp->tx_ring_dma);
+	pci_disable_device(pdev);
 	kfree(dev);
 }
 


----- End forwarded message -----
