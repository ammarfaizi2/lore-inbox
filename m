Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSGCDCv>; Tue, 2 Jul 2002 23:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSGCDCu>; Tue, 2 Jul 2002 23:02:50 -0400
Received: from DHCP-144-56.resnet.ua.edu ([130.160.144.56]:4484 "EHLO
	monket.dyndns.org") by vger.kernel.org with ESMTP
	id <S314451AbSGCDCp>; Tue, 2 Jul 2002 23:02:45 -0400
Date: Tue, 2 Jul 2002 22:05:08 -0500
From: Crutcher Dunnavant <crutcher+lkml@eng.ua.edu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] init_etherdev cleanups
Message-ID: <20020702220508.B14578@monket.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm walking through the network drivers, and cleaning up use of
init_etherdev() and its friends. That said, I gotta say I don't
have any of this hardware, and half of it is for arches I don't
have access to. The x86 stuff compiles, at least.

Attached is a block of patches, and below are my reasons:

skge.c:
	Should be NULL, not zero. Wouldn't bother if I wasn't
	churning this stuff.

xircom_cb.c:
	This driver does lots of cute shit to try and avoid
	malloc failures, but all it accomplishes is to re-order
	the cases so that it has to twice as much work, without
	gaining any protection.

bmac.c:
	This driver is calling memset to zero a chunk of its
	private data structure, but memset has already
	been called on it by init_etherdev.

au1000_eth.c:
	This driver is just a mess. My favorite part of it reads:

	kfree(dev);
	printk(KERN_ERR "%s: au1000_probe1 failed.  Returns %d\n",
	       dev->name, retval);

sunbmac.c:
	This driver checked for dev == NULL twice in a row,
	called ether_setup() redundantly, failed to free
	dev->priv, and did some meaningless stuff in bigmac_probe

atari_bionet.c:
	This driver includes a prototype to init_etherdev(),
	which A) comes from the headers, and B) it doesn't use.

sb1000.c:
	This driver is just alloctaing its own private structure.

myri_sbus.c:
	This driver is calling ether_setup() redundantly,
	and doesn't free dev->priv in its error handler.

macsonic.c:
	redundantly calls ether_setup(), and redundantly mallocs
	its own private structures, based upon this well meaning,
	but dumb, reasoning:

	/* methinks this will always be true but better safe than sorry */

etherh.c
	This driver is alloctaing its own private structure,
	and doesn't free dev->priv in its error handler.

-- 
Crutcher Dunnavant <crutcher+spam@eng.ua.edu>
ECSS System Hacker / UA COE CS Senior

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Description: linux-2.5.24.init_netdev.A.patch
Content-Disposition: attachment; filename="linux-2.5.24.init_netdev.A.patch"

--- linux-2.5.24.patch/drivers/net/sk98lin/skge.c.init_netdev	Mon Jul  1 21:54:10 2002
+++ linux-2.5.24.patch/drivers/net/sk98lin/skge.c	Mon Jul  1 21:58:37 2002
@@ -448,7 +448,7 @@
 		    pci_set_dma_mask(pdev, (u64) 0xffffffff))
 				continue;
 
-		if ((dev = init_etherdev(dev, sizeof(DEV_NET))) == 0) {
+		if ((dev = init_etherdev(dev, sizeof(DEV_NET))) == NULL) {
 			printk(KERN_ERR "Unable to allocate etherdev "
 			       "structure!\n");
 			break;
--- linux-2.5.24.patch/drivers/net/tulip/xircom_cb.c.init_netdev	Mon Jul  1 22:02:03 2002
+++ linux-2.5.24.patch/drivers/net/tulip/xircom_cb.c	Tue Jul  2 20:43:32 2002
@@ -219,32 +219,24 @@
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
-	private = kmalloc(sizeof(*private),GFP_KERNEL);
-	memset(private, 0, sizeof(struct xircom_private));
+	if ((dev = init_etherdev(dev, sizeof(struct xircom_private))) == NULL) {
+		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
+		goto device_fail;
+	}
+	private = dev->priv;
 	
 	/* Allocate the send/receive buffers */
 	private->rx_buffer = pci_alloc_consistent(pdev,8192,&private->rx_dma_handle);
-	
 	if (private->rx_buffer == NULL) {
  		printk(KERN_ERR "xircom_probe: no memory for rx buffer \n");
- 		kfree(private);
-		return -ENODEV;
+		goto rx_buf_fail;
 	}	
 	private->tx_buffer = pci_alloc_consistent(pdev,8192,&private->tx_dma_handle);
 	if (private->tx_buffer == NULL) {
 		printk(KERN_ERR "xircom_probe: no memory for tx buffer \n");
-		kfree(private->rx_buffer);
-		kfree(private);
-		return -ENODEV;
-	}
-	dev = init_etherdev(dev, 0);
-	if (dev == NULL) {
-		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
-		kfree(private->rx_buffer);
-		kfree(private->tx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto tx_buf_fail;
 	}
+
 	SET_MODULE_OWNER(dev);
 	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
 
@@ -281,6 +273,15 @@
 	
 	leave("xircom_probe");
 	return 0;
+
+tx_buf_fail:
+	kfree(private->tx_buffer);
+rx_buf_fail:
+	kfree(private->rx_buffer);
+	kfree(private);
+	kfree(dev);
+device_fail:
+	return -ENODEV;
 }
 
 
--- linux-2.5.24.patch/drivers/net/tc35815.c.init_netdev	Mon Jul  1 22:15:10 2002
+++ linux-2.5.24.patch/drivers/net/tc35815.c	Mon Jul  1 22:16:56 2002
@@ -540,10 +540,15 @@
 	struct net_device *dev;
 
 	/* Allocate a new 'dev' if needed. */
-	dev = init_etherdev(NULL, 0);
+	dev = init_etherdev(NULL, sizeof(struct tc35815_local));
 	if (dev == NULL)
 		return -ENOMEM;
 
+	/*
+	 * init_etherdev allocs and zeros dev->priv
+	 */
+	lp = dev->priv;
+
 	if (tc35815_debug  &&  version_printed++ == 0)
 		printk(KERN_DEBUG "%s", version);
 
@@ -575,17 +580,7 @@
 	printk("\n");
 
 	/* Initialize the device structure. */
-	if (dev->priv == NULL) {
-		dev->priv = kmalloc(sizeof(struct tc35815_local), GFP_KERNEL);
-		if (dev->priv == NULL)
-			return -ENODEV;
-	}
-	lp = dev->priv;
-
 	lp->pdev = pdev;
-
-	memset(lp, 0, sizeof(struct tc35815_local));
-
 	lp->next_module = root_tc35815_dev;
 	root_tc35815_dev = dev;
 
--- linux-2.5.24.patch/drivers/net/bmac.c.init_netdev	Tue Jul  2 15:18:13 2002
+++ linux-2.5.24.patch/drivers/net/bmac.c	Tue Jul  2 15:20:16 2002
@@ -1401,8 +1401,10 @@
 	bp->queue = (struct sk_buff_head *)(bp->rx_cmds + N_RX_RING + 1);
 	skb_queue_head_init(bp->queue);
 
+	/* zeroed in init_etherdev
 	memset((char *) bp->tx_cmds, 0,
 	       (N_TX_RING + N_RX_RING + 2) * sizeof(struct dbdma_cmd));
+	*/
 	/*     init_timer(&bp->tx_timeout); */
 	/*     bp->timeout_active = 0; */
 
--- linux-2.5.24.patch/drivers/net/au1000_eth.c.init_netdev	Mon Jul  1 22:20:18 2002
+++ linux-2.5.24.patch/drivers/net/au1000_eth.c	Tue Jul  2 13:46:48 2002
@@ -67,7 +67,7 @@
 static void dma_free(void *, size_t);
 static void hard_stop(struct net_device *);
 static void enable_rx_tx(struct net_device *dev);
-static int __init au1000_probe1(struct net_device *, long, int, int);
+static int __init au1000_probe1(long, int, int);
 static int au1000_init(struct net_device *);
 static int au1000_open(struct net_device *);
 static int au1000_close(struct net_device *);
@@ -641,7 +641,7 @@
 			printk(KERN_ERR "au1000 eth: unknown Processor ID\n");
 			return -ENODEV;
 		}
-		if (au1000_probe1(NULL, base_addr, irq, i) != 0) {
+		if (au1000_probe1(base_addr, irq, i) != 0) {
 			return -ENODEV;
 		}
 	}
@@ -649,52 +649,40 @@
 }
 
 static int __init
-au1000_probe1(struct net_device *dev, long ioaddr, int irq, int port_num)
+au1000_probe1(long ioaddr, int irq, int port_num)
 {
+	struct net_device *dev;
 	static unsigned version_printed = 0;
 	struct au1000_private *aup = NULL;
-	int i, retval = 0;
+	int i;
 	db_dest_t *pDB, *pDBfree;
 	char *pmac, *argptr;
 	char ethaddr[6];
 
-	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET")) {
-		 return -ENODEV;
-	}
-
 	if (version_printed++ == 0) printk(version);
 
-	if (!dev) {
-		dev = init_etherdev(0, sizeof(struct au1000_private));
-	}
-	if (!dev) {
-		 printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
-		 return -ENODEV;
+	dev = init_etherdev(NULL, sizeof(struct au1000_private));
+	if (dev == NULL) {
+		printk (KERN_ERR "au1000 eth: init_etherdev failed\n");  
+		goto device_fail;
 	}
 
-	printk("%s: Au1xxx ethernet found at 0x%lx, irq %d\n", 
-			dev->name, ioaddr, irq);
+	/* 
+	 * init_etherdev allocs and zeros dev->priv
+	 */
+	aup = dev->priv;
 
-	/* Initialize our private structure */
-	if (dev->priv == NULL) {
-		aup = (struct au1000_private *) 
-			kmalloc(sizeof(*aup), GFP_KERNEL);
-		if (aup == NULL) {
-			retval = -ENOMEM;
-			goto free_region;
-		}
-		dev->priv = aup;
+	if (!request_region(ioaddr, MAC_IOSIZE, "Au1000 ENET")) {
+		goto region_fail;
 	}
 
-	aup = dev->priv;
-	memset(aup, 0, sizeof(*aup));
-
+	printk("%s: Au1xxx ethernet found at 0x%lx, irq %d\n", 
+			dev->name, ioaddr, irq);
 
 	/* Allocate the data buffers */
 	aup->vaddr = (u32)dma_alloc(MAX_BUF_SIZE * 
 			(NUM_TX_BUFFS+NUM_RX_BUFFS), &aup->dma_addr);
 	if (!aup->vaddr) {
-		retval = -ENOMEM;
 		goto free_region;
 	}
 
@@ -800,10 +788,6 @@
 	dev->tx_timeout = au1000_tx_timeout;
 	dev->watchdog_timeo = ETH_TX_TIMEOUT;
 
-
-	/* Fill in the fields of the device structure with ethernet values. */
-	ether_setup(dev);
-
 	/* 
 	 * The boot code uses the ethernet controller, so reset it to start 
 	 * fresh.  au1000_init() expects that the device is in reset state.
@@ -817,12 +801,11 @@
 	if (aup->vaddr) 
 		dma_free((void *)aup->vaddr, 
 				MAX_BUF_SIZE * (NUM_TX_BUFFS+NUM_RX_BUFFS));
-	if (dev->priv != NULL)
-		kfree(dev->priv);
+region_fail:
+	kfree(dev->priv);
 	kfree(dev);
-	printk(KERN_ERR "%s: au1000_probe1 failed.  Returns %d\n",
-	       dev->name, retval);
-	return retval;
+device_fail:
+	return -ENODEV;
 }
 
 
--- linux-2.5.24.patch/drivers/net/sunbmac.c.init_netdev	Mon Jul  1 22:50:40 2002
+++ linux-2.5.24.patch/drivers/net/sunbmac.c	Mon Jul  1 23:00:59 2002
@@ -1036,8 +1036,9 @@
 	sbus_writel(tmp, bregs + BMAC_RXCFG);
 }
 
-static int __init bigmac_ether_init(struct net_device *dev, struct sbus_dev *qec_sdev)
+static int __init bigmac_ether_init(struct sbus_dev *qec_sdev)
 {
+	struct net_device *dev;
 	static int version_printed;
 	struct bigmac *bp;
 	u8 bsizes, bsizes_more;
@@ -1052,9 +1053,6 @@
 	if (version_printed++ == 0)
 		printk(KERN_INFO "%s", version);
 
-	if (!dev)
-		return -ENOMEM;
-
 	/* Report what we have found to the user. */
 	printk(KERN_INFO "%s: BigMAC 100baseT Ethernet ", dev->name);
 	dev->base_addr = (long) qec_sdev;
@@ -1183,7 +1181,6 @@
 	/* Finish net device registration. */
 	dev->irq = bp->bigmac_sdev->irqs[0];
 	dev->dma = 0;
-	ether_setup(dev);
 
 	/* Put us into the list of instances attached for later driver
 	 * exit.
@@ -1212,6 +1209,7 @@
 				     bp->bblock_dvma);
 
 	unregister_netdev(dev);
+	kfree(dev->priv);
 	kfree(dev);
 	return -ENODEV;
 }
@@ -1237,7 +1235,6 @@
 
 static int __init bigmac_probe(void)
 {
-	struct net_device *dev = NULL;
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev = 0;
 	static int called;
@@ -1251,12 +1248,9 @@
 
 	for_each_sbus(sbus) {
 		for_each_sbusdev(sdev, sbus) {
-			if (cards)
-				dev = NULL;
-
 			if (bigmac_match(sdev)) {
 				cards++;
-				if ((v = bigmac_ether_init(dev, sdev)))
+				if ((v = bigmac_ether_init(sdev)))
 					return v;
 			}
 		}
--- linux-2.5.24.patch/drivers/net/atari_bionet.c.init_netdev	Tue Jul  2 15:38:52 2002
+++ linux-2.5.24.patch/drivers/net/atari_bionet.c	Tue Jul  2 15:24:35 2002
@@ -115,8 +115,6 @@
 #include <asm/atari_stdma.h>
 
 
-extern struct net_device *init_etherdev(struct net_device *dev, int sizeof_private);
-
 /* use 0 for production, 1 for verification, >2 for debug
  */
 #ifndef NET_DEBUG
--- linux-2.5.24.patch/drivers/net/sb1000.c.init_netdev	Tue Jul  2 15:53:47 2002
+++ linux-2.5.24.patch/drivers/net/sb1000.c	Tue Jul  2 15:54:31 2002
@@ -221,17 +221,11 @@
 				"S/N %#8.8x, IRQ %d.\n", dev->name, dev->base_addr,
 				dev->mem_start, serial_number, dev->irq);
 
-		dev = init_etherdev(dev, 0);
+		dev = init_etherdev(dev, sizeof(struct sb1000_private));
 		if (!dev)
 			return -ENOMEM;
 		SET_MODULE_OWNER(dev);
 
-		/* Make up a SB1000-specific-data structure. */
-		dev->priv = kmalloc(sizeof(struct sb1000_private), GFP_KERNEL);
-		if (dev->priv == NULL)
-			return -ENOMEM;
-		memset(dev->priv, 0, sizeof(struct sb1000_private));
-
 		if (sb1000_debug > 0)
 			printk(KERN_NOTICE "%s", version);
 
--- linux-2.5.24.patch/drivers/net/myri_sbus.c.init_netdev	Tue Jul  2 15:55:45 2002
+++ linux-2.5.24.patch/drivers/net/myri_sbus.c	Tue Jul  2 16:01:17 2002
@@ -1064,9 +1064,6 @@
 		goto err;
 	}
 
-	DET(("ether_setup()\n"));
-	ether_setup(dev);
-
 	dev->mtu		= MYRINET_MTU;
 	dev->change_mtu		= myri_change_mtu;
 	dev->hard_header	= myri_header;
@@ -1086,6 +1083,7 @@
 #endif
 	return 0;
 err:	unregister_netdev(dev);
+	kfree(dev->priv);
 	kfree(dev);
 	return -ENODEV;
 }
@@ -1143,6 +1141,7 @@
 
 		unregister_netdev(root_myri_dev->dev);
 		kfree(root_myri_dev->dev);
+		kfree(root_myri_dev);
 		root_myri_dev = next;
 	}
 #endif /* MODULE */
--- linux-2.5.24.patch/drivers/net/macsonic.c.init_netdev	Tue Jul  2 16:03:48 2002
+++ linux-2.5.24.patch/drivers/net/macsonic.c	Tue Jul  2 16:14:01 2002
@@ -200,8 +200,6 @@
 	sonic_write(dev, SONIC_FAET, 0xffff);
 	sonic_write(dev, SONIC_MPT, 0xffff);
 
-	/* Fill in the fields of the device structure with ethernet values. */
-	ether_setup(dev);
 	return 0;
 }
 
@@ -316,28 +314,13 @@
 
 	printk("yes\n");	
 
-	if (dev) {
-		dev = init_etherdev(dev, sizeof(struct sonic_local));
-		if (!dev)
-			return -ENOMEM;
-		/* methinks this will always be true but better safe than sorry */
-		if (dev->priv == NULL) {
-			dev->priv = kmalloc(sizeof(struct sonic_local), GFP_KERNEL);
-			if (!dev->priv)
-				return -ENOMEM;
-		}
-	} else {
-		dev = init_etherdev(NULL, sizeof(struct sonic_local));
-	}
-
+	dev = init_etherdev(dev, sizeof(struct sonic_local));
 	if (dev == NULL)
 		return -ENOMEM;
-
 	lp = (struct sonic_local*) dev->priv;
-	memset(lp, 0, sizeof(struct sonic_local));
+
 	/* Danger!  My arms are flailing wildly!  You *must* set this
            before using sonic_read() */
-
 	dev->base_addr = ONBOARD_SONIC_REGISTERS;
 	if (via_alt_mapping)
 		dev->irq = IRQ_AUTO_3;
@@ -517,27 +500,14 @@
 		return -ENODEV;
 	}
 
-	if (dev) {
-		dev = init_etherdev(dev, sizeof(struct sonic_local));
-		if (!dev)
-			return -ENOMEM;
-		/* methinks this will always be true but better safe than sorry */
-		if (dev->priv == NULL) {
-			dev->priv = kmalloc(sizeof(struct sonic_local), GFP_KERNEL);
-			if (!dev->priv) /* FIXME: kfree dev if necessary */
-				return -ENOMEM;
-		}
-	} else {
-		dev = init_etherdev(NULL, sizeof(struct sonic_local));
-	}
-
+	dev = init_etherdev(dev, sizeof(struct sonic_local));
 	if (dev == NULL)
 		return -ENOMEM;
-
 	lp = (struct sonic_local*) dev->priv;
-	memset(lp, 0, sizeof(struct sonic_local));
+
 	/* Danger!  My arms are flailing wildly!  You *must* set this
            before using sonic_read() */
+
 	lp->reg_offset = reg_offset;
 	lp->dma_bitmode = dma_bitmode;
 	dev->base_addr = base_addr;
--- linux-2.5.24.patch/drivers/acorn/net/etherh.c.init_netdev	Mon Jul  1 21:30:18 2002
+++ linux-2.5.24.patch/drivers/acorn/net/etherh.c	Mon Jul  1 22:10:01 2002
@@ -553,15 +553,15 @@
 
 	ecard_claim(ec);
 	
-	dev = init_etherdev(NULL, 0);
+	dev = init_etherdev(NULL, sizeof(struct etherh_priv));
 	if (!dev)
 		goto out;
 
-	eh = kmalloc(sizeof(struct etherh_priv), GFP_KERNEL);
-	if (!eh)
-		goto out_nopriv;
+	/*
+	 * init_etherdev allocs and zeros dev->priv
+	 */
+	eh = dev->priv;
 
-	memset(eh, 0, sizeof(struct etherh_priv));
 	spin_lock_init(&eh->eidev.page_lock);
 
 	SET_MODULE_OWNER(dev);
@@ -695,9 +695,8 @@
 release:
 	release_region(dev->base_addr, 16);
 free:
-	kfree(eh);
-out_nopriv:
 	unregister_netdev(dev);
+	kfree(dev->priv);
 	kfree(dev);
 out:
 	ecard_release(ec);

--0OAP2g/MAC+5xKAE--
