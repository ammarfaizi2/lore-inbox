Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRGXHDe>; Tue, 24 Jul 2001 03:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbRGXHD0>; Tue, 24 Jul 2001 03:03:26 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:38569 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267009AbRGXHDN>; Tue, 24 Jul 2001 03:03:13 -0400
Date: Tue, 24 Jul 2001 00:03:13 -0700
From: "Daniel A. Nobuto" <ramune@bigfoot.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: natsemi.c patch
Message-ID: <20010724000313.A591@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Linus,

	Here's the patch Manfred Spraul made for natsemi.c
in 2.4.6 to work around a gcc bug, updated for 2.4.7.
Without this patch, my natsemi card just keeps spitting out
errors into syslog and doesn't send packets.

	Can this be put in for 2.4.8?

	Thanks,

-- DN
Daniel

--- linux/drivers/net/natsemi.c.original	Mon Jul 23 22:40:34 2001
+++ linux/drivers/net/natsemi.c	Mon Jul 23 23:04:55 2001
@@ -327,6 +327,8 @@
 	IntrNormalSummary=0x0251, IntrAbnormalSummary=0xED20,
 };
 
+#define DEFAULT_INTR 0x00f1cd65                                                             
+                                                                                            
 /* Bits in the RxMode register. */
 enum rx_mode_bits {
 	AcceptErr=0x20, AcceptRunt=0x10,
@@ -389,6 +391,7 @@
 static int  eeprom_read(long ioaddr, int location);
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void natsemi_reset(struct net_device *dev);
+static void natsemi_stop_rxtx(struct net_device *dev);                                      
 static int  netdev_open(struct net_device *dev);
 static void check_link(struct net_device *dev);
 static void netdev_timer(unsigned long data);
@@ -641,6 +644,26 @@
 	}
 }
 
+static void natsemi_stop_rxtx(struct net_device *dev)
+{
+long ioaddr = dev->base_addr;
+int i;
+
+	writel(RxOff | TxOff, ioaddr + ChipCmd);
+	for(i=0;i< NATSEMI_HW_TIMEOUT;i++) {
+		if ((readl(ioaddr + ChipCmd) & (TxOn|RxOn)) == 0)
+		break;
+		udelay(5);
+	}
+	if (i==NATSEMI_HW_TIMEOUT && debug) {
+		printk(KERN_INFO "%s: Tx/Rx process did not stop in %d usec.\n",
+		dev->name, i*5);
+	} else if (debug > 2) {
+		printk(KERN_DEBUG "%s: Tx/Rx process stopped in %d usec.\n",
+	dev->name, i*5);
+	}
+}
+
 
 static int netdev_open(struct net_device *dev)
 {
@@ -663,7 +686,9 @@
 		return i;
 	}
 	init_ring(dev);
+ spin_lock_irq(&np->lock);                                                                  
 	init_registers(dev);
+ spin_unlock_irq(&np->lock);                                                                
 
 	netif_start_queue(dev);
 
@@ -800,7 +825,7 @@
 	__set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
-	writel(IntrNormalSummary | IntrAbnormalSummary | 0x1f, ioaddr + IntrMask);
+ writel(DEFAULT_INTR, ioaddr + IntrMask);                                                   
 	writel(1, ioaddr + IntrEnable);
 
 	writel(RxOn | TxOn, ioaddr + ChipCmd);
@@ -827,30 +852,51 @@
 	add_timer(&np->timer);
 }
 
-static void tx_timeout(struct net_device *dev)
+static void dump_ring(struct net_device *dev)                                               
 {
 	struct netdev_private *np = dev->priv;
-	long ioaddr = dev->base_addr;
 
-	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
-		   " resetting...\n", dev->name, (int)readl(ioaddr + TxRingPtr));
-
-	{
+ if (debug > 2) {                                                                           
 		int i;
-		printk(KERN_DEBUG "  Rx ring %p: ", np->rx_ring);
-		for (i = 0; i < RX_RING_SIZE; i++)
-			printk(" %8.8x", (unsigned int)np->rx_ring[i].cmd_status);
-		printk("\n"KERN_DEBUG"  Tx ring %p: ", np->tx_ring);
+ printk(KERN_DEBUG " Tx ring at %8.8x:\n",                                                  
+ (int)np->tx_ring);                                                                         
 		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" %4.4x", np->tx_ring[i].cmd_status);
-		printk("\n");
-	}
+ printk(KERN_DEBUG " #%d desc. %8.8x %8.8x %8.8x.\n",                                       
+ i, np->tx_ring[i].next_desc,                                                               
+ np->tx_ring[i].cmd_status, np->tx_ring[i].addr);                                           
+ printk(KERN_DEBUG " Rx ring %8.8x:\n",                                                     
+ (int)np->rx_ring);                                                                         
+ for (i = 0; i < RX_RING_SIZE; i++) {                                                       
+ printk(KERN_DEBUG " #%d desc. %8.8x %8.8x %8.8x.\n",                                       
+ i, np->rx_ring[i].next_desc,                                                               
+ np->rx_ring[i].cmd_status, np->rx_ring[i].addr);                                           
+ }                                                                                          
+	}
+}                                                                                           
+                                                                                            
+static void tx_timeout(struct net_device *dev)                                              
+{                                                                                           
+ struct netdev_private *np = dev->priv;                                                     
+ long ioaddr = dev->base_addr;                                                              
+                                                                                            
+                                                                                            
+ disable_irq(dev->irq);                                                                     
 	spin_lock_irq(&np->lock);
-	natsemi_reset(dev);
-	drain_ring(dev);
-	init_ring(dev);
-	init_registers(dev);
+ if (netif_device_present(dev)) {                                                           
+ printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"                                
+ " resetting...\n", dev->name, readl(ioaddr + IntrStatus));                                 
+ dump_ring(dev);                                                                            
+                                                                                            
+ natsemi_reset(dev);                                                                        
+ drain_ring(dev);                                                                           
+ init_ring(dev);                                                                            
+ init_registers(dev);                                                                       
+ } else {                                                                                   
+ printk(KERN_WARNING "%s: tx_timeout while in suspended state?\n",                          
+ dev->name);                                                                                
+ }                                                                                          
 	spin_unlock_irq(&np->lock);
+ enable_irq(dev->irq);                                                                      
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
@@ -881,14 +927,17 @@
 	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
 	np->rx_head_desc = &np->rx_ring[0];
 
+ /* Please be carefull before changing this loop - at least gcc-2.95.1                      
+ * miscompiles it otherwise.                                                                
+ */                                                                                         
 	/* Initialize all Rx descriptors. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].next_desc = cpu_to_le32(np->ring_dma+sizeof(struct netdev_desc)*(i+1));
+ np->rx_ring[i].next_desc = cpu_to_le32(np->ring_dma                                        
+ +sizeof(struct netdev_desc)                                                                
+ *((i+1)%RX_RING_SIZE));                                                                    
 		np->rx_ring[i].cmd_status = cpu_to_le32(DescOwn);
 		np->rx_skbuff[i] = NULL;
 	}
-	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].next_desc = cpu_to_le32(np->ring_dma);
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -900,18 +949,18 @@
 		np->rx_dma[i] = pci_map_single(np->pci_dev,
 						skb->data, skb->len, PCI_DMA_FROMDEVICE);
 		np->rx_ring[i].addr = cpu_to_le32(np->rx_dma[i]);
-		np->rx_ring[i].cmd_status = cpu_to_le32(DescIntr | np->rx_buf_sz);
+ np->rx_ring[i].cmd_status = cpu_to_le32(np->rx_buf_sz);                                    
 	}
 	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_skbuff[i] = NULL;
 		np->tx_ring[i].next_desc = cpu_to_le32(np->ring_dma
-					+sizeof(struct netdev_desc)*(i+1+RX_RING_SIZE));
+ +sizeof(struct netdev_desc)                                                                
+ *((i+1)%TX_RING_SIZE+RX_RING_SIZE));                                                       
 		np->tx_ring[i].cmd_status = 0;
 	}
-	np->tx_ring[i-1].next_desc = cpu_to_le32(np->ring_dma
-					+sizeof(struct netdev_desc)*(RX_RING_SIZE));
+ dump_ring(dev);                                                                            
 }
 
 static void drain_ring(struct net_device *dev)
@@ -970,25 +1019,25 @@
 	np->tx_ring[entry].addr = cpu_to_le32(np->tx_dma[entry]);
 
 	spin_lock_irq(&np->lock);
-
-#if 0
-	np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | DescIntr | skb->len);
-#else
-	np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | skb->len);
-#endif
-	/* StrongARM: Explicitly cache flush np->tx_ring and skb->data,skb->len. */
-	wmb();
-	np->cur_tx++;
-	if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
-		netdev_tx_done(dev);
-		if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1)
-			netif_stop_queue(dev);
+                                                                                            
+ if (netif_device_present(dev)) {                                                           
+ np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | skb->len);                           
+ /* StrongARM: Explicitly cache flush np->tx_ring and skb->data,skb->len. */                
+ wmb();                                                                                     
+ np->cur_tx++;                                                                              
+ if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {                                       
+ netdev_tx_done(dev);                                                                       
+ if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1)                                         
+ netif_stop_queue(dev);                                                                     
+ }                                                                                          
+ /* Wake the potentially-idle transmit channel. */                                          
+ writel(TxOn, dev->base_addr + ChipCmd);                                                    
+ } else {                                                                                   
+ dev_kfree_skb_irq(skb);                                                                    
+ np->stats.tx_dropped++;                                                                    
 	}
 	spin_unlock_irq(&np->lock);
 
-	/* Wake the potentially-idle transmit channel. */
-	writel(TxOn, dev->base_addr + ChipCmd);
-
 	dev->trans_start = jiffies;
 
 	if (debug > 4) {
@@ -1050,7 +1099,9 @@
 
 	ioaddr = dev->base_addr;
 	np = dev->priv;
-
+                                                                                            
+ if (!netif_device_present(dev))                                                            
+ return;                                                                                    
 	do {
 		/* Reading automatically acknowledges all int sources. */
 		u32 intr_status = readl(ioaddr + IntrStatus);
@@ -1174,7 +1225,7 @@
 			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
 		}
 		np->rx_ring[entry].cmd_status =
-			cpu_to_le32(DescIntr | np->rx_buf_sz);
+ cpu_to_le32(np->rx_buf_sz);                                                                
 	}
 
 	/* Restart Rx engine if stopped. */
@@ -1230,20 +1281,20 @@
 
 	/* The chip only need report frame silently dropped. */
 	np->stats.rx_crc_errors	+= readl(ioaddr + RxCRCErrs);
-	np->stats.rx_missed_errors	+= readl(ioaddr + RxMissed);
+ np->stats.rx_missed_errors += readl(ioaddr + RxMissed);                                    
 }
 
 static struct net_device_stats *get_stats(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
 
-	/* The chip only need report frame silently dropped. */
 	spin_lock_irq(&np->lock);
-	__get_stats(dev);
+ if (netif_running(dev) && netif_device_present(dev))                                       
+ __get_stats(dev);                                                                          
 	spin_unlock_irq(&np->lock);
-
 	return &np->stats;
 }
+                                                                                            
 /* The little-endian AUTODIN II ethernet CRC calculations.
    A big-endian version is also available.
    This is slow but compact code.  Do not use this routine for bulk data,
@@ -1343,6 +1394,9 @@
 	struct netdev_private *np = dev->priv;
 	spin_lock_irq(&np->lock);
 	__set_rx_mode(dev);
+	if (netif_device_present(dev))
+	__set_rx_mode(dev);
+
 	spin_unlock_irq(&np->lock);
 }
 
@@ -1414,48 +1468,49 @@
 	netif_stop_queue(dev);
 
 	if (debug > 1) {
-		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.",
+ printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",                      
 			   dev->name, (int)readl(ioaddr + ChipCmd));
 		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
 	}
 
-	/* Disable interrupts using the mask. */
-	writel(0, ioaddr + IntrMask);
-	writel(0, ioaddr + IntrEnable);
-	writel(2, ioaddr + StatsCtrl); 					/* Freeze Stats */
-
-	/* Stop the chip's Tx and Rx processes. */
-	writel(RxOff | TxOff, ioaddr + ChipCmd);
-
 	del_timer_sync(&np->timer);
 
-#ifdef __i386__
-	if (debug > 2) {
-		int i;
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   (int)np->tx_ring);
-		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" #%d desc. %8.8x %8.8x.\n",
-				   i, np->tx_ring[i].cmd_status, np->tx_ring[i].addr);
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
-			   (int)np->rx_ring);
-		for (i = 0; i < RX_RING_SIZE; i++) {
-			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x\n",
-				   i, np->rx_ring[i].cmd_status, np->rx_ring[i].addr);
-		}
-	}
-#endif /* __i386__ debugging only */
-
+ disable_irq(dev->irq);                                                                     
+ spin_lock_irq(&np->lock);                                                                  
+ if (netif_device_present(dev)) {                                                           
+ writel(0, ioaddr + IntrMask);                                                              
+ writel(0, ioaddr + IntrEnable);                                                            
+ writel(2, ioaddr + StatsCtrl); /* Freeze Stats */                                          
+                                                                                            
+ natsemi_stop_rxtx(dev);                                                                    
+ __get_stats(dev);                                                                          
+	}
+ spin_unlock_irq(&np->lock);                                                                
+
+ /* race: shared irq and as most nics the DP83815                                           
+ * reports _all_ interrupt conditions in IntrStatus, even                                   
+ * disabled ones.                                                                           
+ * packet received after disable_irq, but before stop_rxtx                                  
+ * --> race. intr_handler would restart the rx process.                                     
+ * netif_device_{de,a}tach around {enable,free}_irq.                                        
+ */                                                                                         
+ netif_device_detach(dev);                                                                  
+ enable_irq(dev->irq);                                                                      
 	free_irq(dev->irq, dev);
+ netif_device_attach(dev);                                                                  
+                                                                                            
+ dump_ring(dev);                                                                            
 	drain_ring(dev);
 	free_ring(dev);
 
-	/* Restore PME enable bit */
-	writel(np->SavedClkRun, ioaddr + ClkRun);
+ if (netif_device_present(dev)) {                                                           
+ /* Restore PME enable bit */                                                               
+ writel(np->SavedClkRun, ioaddr + ClkRun);                                                  
 #if 0
-	writel(0x0200, ioaddr + ChipConfig); /* Power down Xcvr. */
+ writel(0x0200, ioaddr + ChipConfig); /* Power down Xcvr. */                                
 #endif
+ }                                                                                          
 
 	return 0;
 }
@@ -1474,49 +1529,54 @@
 
 #ifdef CONFIG_PM
 
+/*                                                                                          
+ * suspend/resume synchronization:                                                          
+ * entry points:                                                                            
+ * netdev_open, netdev_close, netdev_ioctl, set_rx_mode, intr_handler,                      
+ * start_tx, tx_timeout                                                                     
+ * - no function accesses the hardware without checking netif_device_present().             
+ * the check occurs under spin_lock_irq(&np->lock);                                         
+ * exceptions:                                                                              
+ * * netdev_ioctl, netdev_open.                                                             
+ * net/core checks netif_device_present() before calling them.                              
+ * * netdev_timer: timer stopped by natsemi_suspend.                                        
+ * * intr_handler: doesn't acquire the spinlock. suspend calls                              
+ * disable_irq() to enforce synchronization.                                                
+ *                                                                                          
+ * netif_device_detach must occur under spin_unlock_irq(), interrupts from a detached       
+ * device would cause an irq storm.                                                         
+ */                                                                                         
+                                                                                            
 static int natsemi_suspend (struct pci_dev *pdev, u32 state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
-	netif_device_detach(dev);
-	/* no more calls to tx_timeout, hard_start_xmit, set_rx_mode */
 	rtnl_lock();
-	rtnl_unlock();
-	/* noone within ->open */
 	if (netif_running (dev)) {
-		int i;
 		del_timer_sync(&np->timer);
-		/* no more link beat timer calls */
+                                                                                            
+ disable_irq(dev->irq);                                                                     
 		spin_lock_irq(&np->lock);
-		writel(RxOff | TxOff, ioaddr + ChipCmd);
-		for(i=0;i< NATSEMI_HW_TIMEOUT;i++) {
-			if ((readl(ioaddr + ChipCmd) & (TxOn|RxOn)) == 0)
-				break;
-			udelay(5);
-		}
-		if (i==NATSEMI_HW_TIMEOUT && debug) {
-			printk(KERN_INFO "%s: Tx/Rx process did not stop in %d usec.\n",
-					dev->name, i*5);
-		} else if (debug > 2) {
-			printk(KERN_DEBUG "%s: Tx/Rx process stopped in %d usec.\n",
-					dev->name, i*5);
-		}
-		/* Tx and Rx processes stopped */
 
 		writel(0, ioaddr + IntrEnable);
-		/* all irq events disabled. */
-		spin_unlock_irq(&np->lock);
-
-		synchronize_irq();
-
+ natsemi_stop_rxtx(dev);                                                                    
+ netif_stop_queue(dev);                                                                     
+ netif_device_detach(dev);                                                                  
+
+ spin_unlock_irq(&np->lock);                                                                
+ enable_irq(dev->irq);                                                                      
+                                                                                            
 		/* Update the error counts. */
 		__get_stats(dev);
 
 		/* pci_power_off(pdev, -1); */
 		drain_ring(dev);
+ } else {                                                                                   
+ netif_device_detach(dev);                                                                  
 	}
+ rtnl_unlock();                                                                             
 	return 0;
 }
 
@@ -1526,18 +1586,27 @@
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = dev->priv;
 
-	if (netif_running (dev)) {
+ rtnl_lock();                                                                               
+ if (netif_device_present(dev))                                                             
+ goto out;                                                                                  
+ if (netif_running(dev)) {                                                                  
 		pci_enable_device(pdev);
 	/*	pci_power_on(pdev); */
 		
 		natsemi_reset(dev);
 		init_ring(dev);
+ spin_lock_irq(&np->lock);                                                                  
 		init_registers(dev);
+ netif_device_attach(dev);                                                                  
+ spin_unlock_irq(&np->lock);                                                                
 
 		np->timer.expires = jiffies + 1*HZ;
 		add_timer(&np->timer);
+ } else {                                                                                   
+ netif_device_attach(dev);                                                                  
 	}
-	netif_device_attach(dev);
+out:                                                                                        
+ rtnl_unlock();                                                                             
 	return 0;
 }
 
