Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281068AbRKOV1j>; Thu, 15 Nov 2001 16:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRKOV1a>; Thu, 15 Nov 2001 16:27:30 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:38864 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S281074AbRKOV1M>;
	Thu, 15 Nov 2001 16:27:12 -0500
Date: Thu, 15 Nov 2001 22:27:02 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, jgarzik@mandrakesoft.com
Subject: [PATCH] 2.4.15-pre4 - recovery after timeout (drivers/net/fealnx.c)
Message-ID: <20011115222702.A14955@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current recovery code fails sometime. This patch performs a
gross stop/start cycle that helps. Thanks to tekjunky@cfl.rr.com and 
zzed@cyberdude.com for their patient testing.

--- linux-2.4.15-pre4.orig/drivers/net/fealnx.c	Tue Nov 13 16:15:43 2001
+++ linux-2.4.15-pre4/drivers/net/fealnx.c	Thu Nov 15 22:13:52 2001
@@ -431,7 +431,7 @@ static void set_rx_mode(struct net_devic
 static struct net_device_stats *get_stats(struct net_device *dev);
 static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int netdev_close(struct net_device *dev);
-
+static void reset_rx_descriptors(struct net_device *dev);
 
 void stop_nic_tx(long ioaddr, long crvalue)
 {
@@ -887,7 +887,8 @@ static int netdev_open(struct net_device
 	   1 1 0   128
 	   1 1 1   256
 	   Wait the specified 50 PCI cycles after a reset by initializing
-	   Tx and Rx queues and the address filter list. */
+	   Tx and Rx queues and the address filter list.
+	   FIXME (Ueimor): optimistic for alpha + posted writes ? */
 #if defined(__powerpc__) || defined(__sparc__)
 // 89/9/1 modify, 
 //   np->bcrvalue=0x04 | 0x0x38;  /* big-endian, 256 burst length */
@@ -1164,12 +1165,12 @@ static void tx_timeout(struct net_device
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+	int i;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
 	       " resetting...\n", dev->name, readl(ioaddr + ISR));
 
 	{
-		int i;
 
 		printk(KERN_DEBUG "  Rx ring %p: ", np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++)
@@ -1180,12 +1181,41 @@ static void tx_timeout(struct net_device
 		printk("\n");
 	}
 
-	/* Perhaps we should reinitialize the hardware here.  Just trigger a
-	   Tx demand for now. */
+	   + dev->if_port = np->default_port;
+	/* Reinit. Gross */
+
+	/* Reset the chip's Tx and Rx processes. */
+	stop_nic_tx(ioaddr, 0);
+	reset_rx_descriptors(dev);
+
+	/* Disable interrupts by clearing the interrupt mask. */
+	writel(0x0000, ioaddr + IMR);
+
+	/* Reset the chip to erase previous misconfiguration. */
+	writel(0x00000001, ioaddr + BCR);
+
+	/* Ueimor: wait for 50 PCI cycles (and flush posted writes btw). 
+	   We surely wait too long (address+data phase). Who cares ? */
+	for (i = 0; i < 50; i++) {
+		readl(ioaddr + BCR);
+		rmb();
+	}
+
+	writel((np->cur_tx - np->tx_ring)*sizeof(struct fealnx_desc) +
+		np->tx_ring_dma, ioaddr + TXLBA);
+	writel((np->cur_rx - np->rx_ring)*sizeof(struct fealnx_desc) +
+		np->rx_ring_dma, ioaddr + RXLBA);
+
+	writel(np->bcrvalue, ioaddr + BCR);
+
+	writel(0, dev->base_addr + RXPDR);
+	set_rx_mode(dev);
+	/* Clear and Enable interrupts by setting the interrupt mask. */
+	writel(FBE | TUNF | CNTOVF | RBU | TI | RI, ioaddr + ISR);
+	writel(np->imrvalue, ioaddr + IMR);
+
 	writel(0, dev->base_addr + TXPDR);
-	dev->if_port = 0;
 
-	/* Stop and restart the chip's Tx processes . */
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
 

