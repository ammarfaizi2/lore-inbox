Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSKJVyM>; Sun, 10 Nov 2002 16:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSKJVyM>; Sun, 10 Nov 2002 16:54:12 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:8633 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S265196AbSKJVxv>; Sun, 10 Nov 2002 16:53:51 -0500
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: Re: [PATCH] sysfs stuff for eisa bus [3/3]
References: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 10 Nov 2002 23:00:16 +0100
Message-ID: <wrp1y5tgk5r.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Third (and last) ptch is the 3c59x driver ported to the sysfs EISA
infrastructure :


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=eisa-3c59x.patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.804   -> 1.805  
#	 drivers/net/3c59x.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/10	maz@hina.wild-wind.fr.eu.org	1.805
# Ported to sysfs EISA intrastructure.
# --------------------------------------------
#
diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	Sun Nov 10 22:49:33 2002
+++ b/drivers/net/3c59x.c	Sun Nov 10 22:49:33 2002
@@ -180,6 +180,9 @@
 
     - See http://www.zip.com.au/~akpm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
+
+   LK1.1.19 10Nov09 Marc Zyngier <maz@wild-wind.fr.eu.org>
+    - EISA sysfs integration.
 */
 
 /*
@@ -193,8 +196,8 @@
 
 
 #define DRV_NAME	"3c59x"
-#define DRV_VERSION	"LK1.1.18"
-#define DRV_RELDATE	"1 Jul 2002"
+#define DRV_VERSION	"LK1.1.19"
+#define DRV_RELDATE	"10 Nov 2002"
 
 
 
@@ -260,6 +263,7 @@
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
 #include <linux/highmem.h>
+#include <linux/eisa.h>
 #include <asm/irq.h>			/* For NR_IRQS only. */
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -764,7 +768,6 @@
 	/* The addresses of transmit- and receive-in-place skbuffs. */
 	struct sk_buff* rx_skbuff[RX_RING_SIZE];
 	struct sk_buff* tx_skbuff[TX_RING_SIZE];
-	struct net_device *next_module;		/* NULL if PCI device */
 	unsigned int cur_rx, cur_tx;		/* The next free ring entry */
 	unsigned int dirty_rx, dirty_tx;	/* The ring entries to be free()ed. */
 	struct net_device_stats stats;
@@ -772,7 +775,7 @@
 	dma_addr_t tx_skb_dma;				/* Allocated DMA address for bus master ctrl DMA.   */
 
 	/* PCI configuration space information. */
-	struct pci_dev *pdev;
+	struct device *gendev;
 	char *cb_fn_base;					/* CardBus function status addr space. */
 
 	/* Some values here only for performance evaluation and path-coverage */
@@ -811,6 +814,18 @@
 	u32 power_state[16];
 };
 
+#define DEVICE_PCI(dev) (((dev)->bus == &pci_bus_type) ? to_pci_dev((dev)) : NULL)
+
+#define VORTEX_PCI(vp) (((vp)->gendev) ? DEVICE_PCI((vp)->gendev) : NULL)
+
+#ifdef CONFIG_EISA
+#define DEVICE_EISA(dev) (((dev)->bus == &eisa_bus_type) ? to_eisa_device((dev)) : NULL)
+#else
+#define DEVICE_EISA(dev) NULL
+#endif
+
+#define VORTEX_EISA(vp) (((vp)->gendev) ? DEVICE_EISA((vp)->gendev) : NULL)
+
 /* The action to take with a media selection timer tick.
    Note that we deviate from the 3Com order by checking 10base2 before AUI.
  */
@@ -839,7 +854,7 @@
   { "Default",	 0,			0xFF, XCVR_10baseT, 10000},
 };
 
-static int vortex_probe1(struct pci_dev *pdev, long ioaddr, int irq,
+static int vortex_probe1(struct device *gendev, long ioaddr, int irq,
 				   int chip_idx, int card_idx);
 static void vortex_up(struct net_device *dev);
 static void vortex_down(struct net_device *dev);
@@ -878,11 +893,9 @@
 
 /* #define dev_alloc_skb dev_alloc_skb_debug */
 
-/* A list of all installed Vortex EISA devices, for removing the driver module. */
-static struct net_device *root_vortex_eisa_dev;
-
 /* Variables to work-around the Compaq PCI BIOS32 problem. */
 static int compaq_ioaddr, compaq_irq, compaq_device_id = 0x5900;
+static struct net_device *compaq_net_device;
 
 static int vortex_cards_found;
 
@@ -916,44 +929,89 @@
 
 #endif /* CONFIG_PM */
 
-/* returns count found (>= 0), or negative on error */
-static int __init vortex_eisa_init (void)
+#ifdef CONFIG_EISA
+static struct eisa_device_id vortex_eisa_ids[] = {
+	{ "TCM5920" },
+	{ "TCM5970" },
+	{ "" }
+};
+
+static int vortex_eisa_probe (struct device *device);
+static int vortex_eisa_remove (struct device *device);
+
+static struct eisa_driver vortex_eisa_driver = {
+	.id_table = vortex_eisa_ids,
+	.driver   = {
+		.name    = "3c59x",
+		.probe   = vortex_eisa_probe,
+		.remove  = vortex_eisa_remove
+	}
+};
+
+static int vortex_eisa_probe (struct device *device)
 {
 	long ioaddr;
-	int rc;
-	int orig_cards_found = vortex_cards_found;
+	struct eisa_device *edev;
 
-	/* Now check all slots of the EISA bus. */
-	if (!EISA_bus)
-		return 0;
+	edev = to_eisa_device (device);
+	ioaddr = edev->base_addr;
 
-	for (ioaddr = 0x1000; ioaddr < 0x9000; ioaddr += 0x1000) {
-		int device_id;
+	if (!request_region(ioaddr, VORTEX_TOTAL_SIZE, DRV_NAME))
+		return -EBUSY;
 
-		if (request_region(ioaddr, VORTEX_TOTAL_SIZE, DRV_NAME) == NULL)
-			continue;
+	if (vortex_probe1(device, ioaddr, inw(ioaddr + 0xC88) >> 12,
+					  EISA_TBL_OFFSET, vortex_cards_found)) {
+		release_region (ioaddr, VORTEX_TOTAL_SIZE);
+		return -ENODEV;
+	}
 
-		/* Check the standard EISA ID register for an encoded '3Com'. */
-		if (inw(ioaddr + 0xC80) != 0x6d50) {
-			release_region (ioaddr, VORTEX_TOTAL_SIZE);
-			continue;
-		}
+	vortex_cards_found++;
 
-		/* Check for a product that we support, 3c59{2,7} any rev. */
-		device_id = (inb(ioaddr + 0xC82)<<8) + inb(ioaddr + 0xC83);
-		if ((device_id & 0xFF00) != 0x5900) {
-			release_region (ioaddr, VORTEX_TOTAL_SIZE);
-			continue;
-		}
+	return 0;
+}
 
-		rc = vortex_probe1(NULL, ioaddr, inw(ioaddr + 0xC88) >> 12,
-				   EISA_TBL_OFFSET, vortex_cards_found);
-		if (rc == 0)
-			vortex_cards_found++;
-		else
-			release_region (ioaddr, VORTEX_TOTAL_SIZE);
+static int vortex_eisa_remove (struct device *device)
+{
+	struct eisa_device *edev;
+	struct net_device *dev;
+	struct vortex_private *vp;
+	long ioaddr;
+
+	edev = to_eisa_device (device);
+	dev = eisa_get_drvdata (edev);
+
+	if (!dev) {
+		printk("vortex_eisa_remove called for Compaq device!\n");
+		BUG();
 	}
 
+	vp = dev->priv;
+	ioaddr = dev->base_addr;
+	
+	unregister_netdev (dev);
+	outw (TotalReset|0x14, ioaddr + EL3_CMD);
+	release_region (ioaddr, VORTEX_TOTAL_SIZE);
+
+	kfree (dev);
+	return 0;
+}
+#endif
+
+/* returns count found (>= 0), or negative on error */
+static int __init vortex_eisa_init (void)
+{
+	int orig_cards_found = vortex_cards_found;
+
+	/* Now check all slots of the EISA bus. */
+	if (!EISA_bus)
+		return 0;
+
+#ifdef CONFIG_EISA
+	if (eisa_driver_register (&vortex_eisa_driver) < 0) {
+		eisa_driver_unregister (&vortex_eisa_driver);
+	}
+#endif
+	
 	/* Special code to work-around the Compaq PCI BIOS32 problem. */
 	if (compaq_ioaddr) {
 		vortex_probe1(NULL, compaq_ioaddr, compaq_irq,
@@ -973,8 +1031,8 @@
 	if (pci_enable_device (pdev)) {
 		rc = -EIO;
 	} else {
-		rc = vortex_probe1 (pdev, pci_resource_start (pdev, 0), pdev->irq,
-				    ent->driver_data, vortex_cards_found);
+		rc = vortex_probe1 (&pdev->dev, pci_resource_start (pdev, 0),
+							pdev->irq, ent->driver_data, vortex_cards_found);
 		if (rc == 0)
 			vortex_cards_found++;
 	}
@@ -982,12 +1040,12 @@
 }
 
 /*
- * Start up the PCI device which is described by *pdev.
+ * Start up the PCI/EISA device which is described by *gendev.
  * Return 0 on success.
  *
- * NOTE: pdev can be NULL, for the case of an EISA driver
+ * NOTE: pdev can be NULL, for the case of a Compaq device
  */
-static int __devinit vortex_probe1(struct pci_dev *pdev,
+static int __devinit vortex_probe1(struct device *gendev,
 				   long ioaddr, int irq,
 				   int chip_idx, int card_idx)
 {
@@ -999,14 +1057,24 @@
 	static int printed_version;
 	int retval, print_info;
 	struct vortex_chip_info * const vci = &vortex_info_tbl[chip_idx];
-	char *print_name;
+	char *print_name = "3c59x";
+	struct pci_dev *pdev = NULL;
+	struct eisa_device *edev = NULL;
 
 	if (!printed_version) {
 		printk (version);
 		printed_version = 1;
 	}
 
-	print_name = pdev ? pdev->slot_name : "3c59x";
+	if (gendev) {
+		if ((pdev = DEVICE_PCI(gendev))) {
+			print_name = pdev->slot_name;
+		}
+
+		if ((edev = DEVICE_EISA(gendev))) {
+			print_name = edev->dev.bus_id;
+		}
+	}
 
 	dev = alloc_etherdev(sizeof(*vp));
 	retval = -ENOMEM;
@@ -1059,10 +1127,9 @@
 	vp->io_size = vci->io_size;
 	vp->card_idx = card_idx;
 
-	/* module list only for EISA devices */
-	if (pdev == NULL) {
-		vp->next_module = root_vortex_eisa_dev;
-		root_vortex_eisa_dev = dev;
+	/* module list only for Compaq device */
+	if (gendev == NULL) {
+		compaq_net_device = dev;
 	}
 
 	/* PCI-only startup logic */
@@ -1096,7 +1163,7 @@
 
 	spin_lock_init(&vp->lock);
 	spin_lock_init(&vp->mdio_lock);
-	vp->pdev = pdev;
+	vp->gendev = gendev;
 
 	/* Makes sure rings are at least 16 byte aligned. */
 	vp->rx_ring = pci_alloc_consistent(pdev, sizeof(struct boom_rx_desc) * RX_RING_SIZE
@@ -1113,6 +1180,8 @@
 	 * instead of a module list */	
 	if (pdev)
 		pci_set_drvdata(pdev, dev);
+	if (edev)
+		eisa_set_drvdata (edev, dev);
 
 	vp->media_override = 7;
 	if (option >= 0) {
@@ -1365,7 +1434,7 @@
 	dev->watchdog_timeo = (watchdog * HZ) / 1000;
 	if (pdev && vp->enable_wol) {
 		vp->pm_state_valid = 1;
- 		pci_save_state(vp->pdev, vp->power_state);
+ 		pci_save_state(VORTEX_PCI(vp), vp->power_state);
  		acpi_set_WOL(dev);
 	}
 	retval = register_netdev(dev);
@@ -1420,9 +1489,9 @@
 	unsigned int config;
 	int i;
 
-	if (vp->pdev && vp->enable_wol) {
-		pci_set_power_state(vp->pdev, 0);	/* Go active */
-		pci_restore_state(vp->pdev, vp->power_state);
+	if (VORTEX_PCI(vp) && vp->enable_wol) {
+		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
+		pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 
 	/* Before initializing select the active media port. */
@@ -1639,7 +1708,7 @@
 				break;			/* Bad news!  */
 			skb->dev = dev;			/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			vp->rx_ring[i].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
+			vp->rx_ring[i].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
 		}
 		if (i != RX_RING_SIZE) {
 			int j;
@@ -1976,7 +2045,7 @@
 	if (vp->bus_master) {
 		/* Set the bus-master controller to transfer the packet. */
 		int len = (skb->len + 3) & ~3;
-		outl(	vp->tx_skb_dma = pci_map_single(vp->pdev, skb->data, len, PCI_DMA_TODEVICE),
+		outl(	vp->tx_skb_dma = pci_map_single(VORTEX_PCI(vp), skb->data, len, PCI_DMA_TODEVICE),
 				ioaddr + Wn7_MasterAddr);
 		outw(len, ioaddr + Wn7_MasterLen);
 		vp->tx_skb = skb;
@@ -2055,13 +2124,13 @@
 			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum | AddUDPChksum);
 
 	if (!skb_shinfo(skb)->nr_frags) {
-		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,
+		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->data,
 										skb->len, PCI_DMA_TODEVICE));
 		vp->tx_ring[entry].frag[0].length = cpu_to_le32(skb->len | LAST_FRAG);
 	} else {
 		int i;
 
-		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,
+		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->data,
 										skb->len-skb->data_len, PCI_DMA_TODEVICE));
 		vp->tx_ring[entry].frag[0].length = cpu_to_le32(skb->len-skb->data_len);
 
@@ -2069,7 +2138,7 @@
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 			vp->tx_ring[entry].frag[i+1].addr =
-					cpu_to_le32(pci_map_single(vp->pdev,
+					cpu_to_le32(pci_map_single(VORTEX_PCI(vp),
 											   (void*)page_address(frag->page) + frag->page_offset,
 											   frag->size, PCI_DMA_TODEVICE));
 
@@ -2080,7 +2149,7 @@
 		}
 	}
 #else
-	vp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE));
+	vp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->data, skb->len, PCI_DMA_TODEVICE));
 	vp->tx_ring[entry].length = cpu_to_le32(skb->len | LAST_FRAG);
 	vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded);
 #endif
@@ -2168,7 +2237,7 @@
 		if (status & DMADone) {
 			if (inw(ioaddr + Wn7_MasterStatus) & 0x1000) {
 				outw(0x1000, ioaddr + Wn7_MasterStatus); /* Ack the event. */
-				pci_unmap_single(vp->pdev, vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, PCI_DMA_TODEVICE);
+				pci_unmap_single(VORTEX_PCI(vp), vp->tx_skb_dma, (vp->tx_skb->len + 3) & ~3, PCI_DMA_TODEVICE);
 				dev_kfree_skb_irq(vp->tx_skb); /* Release the transferred buffer */
 				if (inw(ioaddr + TxFree) > 1536) {
 					/*
@@ -2289,12 +2358,12 @@
 #if DO_ZEROCOPY					
 					int i;
 					for (i=0; i<=skb_shinfo(skb)->nr_frags; i++)
-							pci_unmap_single(vp->pdev,
+							pci_unmap_single(VORTEX_PCI(vp),
 											 le32_to_cpu(vp->tx_ring[entry].frag[i].addr),
 											 le32_to_cpu(vp->tx_ring[entry].frag[i].length)&0xFFF,
 											 PCI_DMA_TODEVICE);
 #else
-					pci_unmap_single(vp->pdev,
+					pci_unmap_single(VORTEX_PCI(vp),
 						le32_to_cpu(vp->tx_ring[entry].addr), skb->len, PCI_DMA_TODEVICE);
 #endif
 					dev_kfree_skb_irq(skb);
@@ -2381,14 +2450,14 @@
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				if (vp->bus_master &&
 					! (inw(ioaddr + Wn7_MasterStatus) & 0x8000)) {
-					dma_addr_t dma = pci_map_single(vp->pdev, skb_put(skb, pkt_len),
+					dma_addr_t dma = pci_map_single(VORTEX_PCI(vp), skb_put(skb, pkt_len),
 									   pkt_len, PCI_DMA_FROMDEVICE);
 					outl(dma, ioaddr + Wn7_MasterAddr);
 					outw((skb->len + 3) & ~3, ioaddr + Wn7_MasterLen);
 					outw(StartDMAUp, ioaddr + EL3_CMD);
 					while (inw(ioaddr + Wn7_MasterStatus) & 0x8000)
 						;
-					pci_unmap_single(vp->pdev, dma, pkt_len, PCI_DMA_FROMDEVICE);
+					pci_unmap_single(VORTEX_PCI(vp), dma, pkt_len, PCI_DMA_FROMDEVICE);
 				} else {
 					insl(ioaddr + RX_FIFO, skb_put(skb, pkt_len),
 						 (pkt_len + 3) >> 2);
@@ -2454,7 +2523,7 @@
 			if (pkt_len < rx_copybreak && (skb = dev_alloc_skb(pkt_len + 2)) != 0) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-				pci_dma_sync_single(vp->pdev, dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				/* 'skb_put()' points to the start of sk_buff data area. */
 				memcpy(skb_put(skb, pkt_len),
 					   vp->rx_skbuff[entry]->tail,
@@ -2465,7 +2534,7 @@
 				skb = vp->rx_skbuff[entry];
 				vp->rx_skbuff[entry] = NULL;
 				skb_put(skb, pkt_len);
-				pci_unmap_single(vp->pdev, dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				pci_unmap_single(VORTEX_PCI(vp), dma, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				vp->rx_nocopy++;
 			}
 			skb->protocol = eth_type_trans(skb, dev);
@@ -2502,7 +2571,7 @@
 			}
 			skb->dev = dev;			/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			vp->rx_ring[entry].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
+			vp->rx_ring[entry].addr = cpu_to_le32(pci_map_single(VORTEX_PCI(vp), skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE));
 			vp->rx_skbuff[entry] = skb;
 		}
 		vp->rx_ring[entry].status = 0;	/* Clear complete bit. */
@@ -2561,8 +2630,8 @@
 	if (vp->full_bus_master_tx)
 		outl(0, ioaddr + DownListPtr);
 
-	if (vp->pdev && vp->enable_wol) {
-		pci_save_state(vp->pdev, vp->power_state);
+	if (VORTEX_PCI(vp) && vp->enable_wol) {
+		pci_save_state(VORTEX_PCI(vp), vp->power_state);
 		acpi_set_WOL(dev);
 	}
 }
@@ -2598,7 +2667,7 @@
 	if (vp->full_bus_master_rx) { /* Free Boomerang bus master Rx buffers. */
 		for (i = 0; i < RX_RING_SIZE; i++)
 			if (vp->rx_skbuff[i]) {
-				pci_unmap_single(	vp->pdev, le32_to_cpu(vp->rx_ring[i].addr),
+				pci_unmap_single(	VORTEX_PCI(vp), le32_to_cpu(vp->rx_ring[i].addr),
 									PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 				dev_kfree_skb(vp->rx_skbuff[i]);
 				vp->rx_skbuff[i] = 0;
@@ -2612,12 +2681,12 @@
 				int k;
 
 				for (k=0; k<=skb_shinfo(skb)->nr_frags; k++)
-						pci_unmap_single(vp->pdev,
+						pci_unmap_single(VORTEX_PCI(vp),
 										 le32_to_cpu(vp->tx_ring[i].frag[k].addr),
 										 le32_to_cpu(vp->tx_ring[i].frag[k].length)&0xFFF,
 										 PCI_DMA_TODEVICE);
 #else
-				pci_unmap_single(vp->pdev, le32_to_cpu(vp->tx_ring[i].addr), skb->len, PCI_DMA_TODEVICE);
+				pci_unmap_single(VORTEX_PCI(vp), le32_to_cpu(vp->tx_ring[i].addr), skb->len, PCI_DMA_TODEVICE);
 #endif
 				dev_kfree_skb(skb);
 				vp->tx_skbuff[i] = 0;
@@ -2736,11 +2805,15 @@
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strcpy(info.driver, DRV_NAME);
 		strcpy(info.version, DRV_VERSION);
-		if (vp->pdev)
-			strcpy(info.bus_info, vp->pdev->slot_name);
-		else
-			sprintf(info.bus_info, "EISA 0x%lx %d",
-				dev->base_addr, dev->irq);
+		if (VORTEX_PCI(vp))
+			strcpy(info.bus_info, VORTEX_PCI(vp)->slot_name);
+		else {
+			if (VORTEX_EISA(vp))
+				sprintf (info.bus_info, vp->gendev->bus_id);
+			else
+				sprintf(info.bus_info, "EISA 0x%lx %d",
+						dev->base_addr, dev->irq);
+		}
 		if (copy_to_user(useraddr, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
@@ -2922,8 +2995,8 @@
 	outw(RxEnable, ioaddr + EL3_CMD);
 
 	/* Change the power state to D3; RxEnable doesn't take effect. */
-	pci_enable_wake(vp->pdev, 0, 1);
-	pci_set_power_state(vp->pdev, 3);
+	pci_enable_wake(VORTEX_PCI(vp), 0, 1);
+	pci_set_power_state(VORTEX_PCI(vp), 3);
 }
 
 
@@ -2933,7 +3006,7 @@
 	struct vortex_private *vp;
 
 	if (!dev) {
-		printk("vortex_remove_one called for EISA device!\n");
+		printk("vortex_remove_one called for Compaq device!\n");
 		BUG();
 	}
 
@@ -2947,10 +3020,10 @@
 	/* Should really use issue_and_wait() here */
 	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
 
-	if (vp->pdev && vp->enable_wol) {
-		pci_set_power_state(vp->pdev, 0);	/* Go active */
+	if (VORTEX_PCI(vp) && vp->enable_wol) {
+		pci_set_power_state(VORTEX_PCI(vp), 0);	/* Go active */
 		if (vp->pm_state_valid)
-			pci_restore_state(vp->pdev, vp->power_state);
+			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 
 	pci_free_consistent(pdev,
@@ -2998,24 +3071,23 @@
 
 static void __exit vortex_eisa_cleanup (void)
 {
-	struct net_device *dev, *tmp;
 	struct vortex_private *vp;
 	long ioaddr;
 
-	dev = root_vortex_eisa_dev;
-
-	while (dev) {
-		vp = dev->priv;
-		ioaddr = dev->base_addr;
+#ifdef CONFIG_EISA
+	/* Take care of the EISA devices */
+	eisa_driver_unregister (&vortex_eisa_driver);
+#endif
+	
+	if (compaq_net_device) {
+		vp = compaq_net_device->priv;
+		ioaddr = compaq_net_device->base_addr;
 
-		unregister_netdev (dev);
+		unregister_netdev (compaq_net_device);
 		outw (TotalReset, ioaddr + EL3_CMD);
 		release_region (ioaddr, VORTEX_TOTAL_SIZE);
 
-		tmp = dev;
-		dev = vp->next_module;
-
-		kfree (tmp);
+		kfree (compaq_net_device);
 	}
 }
 

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
