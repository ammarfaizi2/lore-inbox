Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265147AbRFUTXA>; Thu, 21 Jun 2001 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265145AbRFUTWu>; Thu, 21 Jun 2001 15:22:50 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:12041 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S265147AbRFUTWh>;
	Thu, 21 Jun 2001 15:22:37 -0400
Date: Thu, 21 Jun 2001 21:21:39 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jon Forsberg <zzed@cyberdude.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fealnx problem
Message-ID: <20010621212139.A13297@se1.cogenit.fr>
In-Reply-To: <20010621145759.B10047@naut>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621145759.B10047@naut>; from zzed@cyberdude.com on Thu, Jun 21, 2001 at 02:57:59PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Forsberg <zzed@cyberdude.com> écrit :
> I have an Surecom EP-320X-S Ethernet adapter which apparently uses a
> Myson MTD-8xx chip. It works well with the "fealnx" driver (labeled
> "Myson MTD-8xx PCI Ethernet support" in kernel config) except for one thing:
> After a while in use it stops working and prints
> 
> Jun 21 12:18:18 naut kernel: NETDEV WATCHDOG: eth0: transmit timed out
[...]

Could you give this a try please ?
It may crash.
 
--- linux-2.4.5.orig/drivers/net/fealnx.c	Wed Jun  6 09:13:43 2001
+++ linux-2.4.5/drivers/net/fealnx.c	Thu Jun 21 21:18:59 2001
@@ -418,7 +418,7 @@
 static struct net_device_stats *get_stats(struct net_device *dev);
 static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int netdev_close(struct net_device *dev);
-
+static void reset_rx_descriptors(struct net_device *dev);
 
 void stop_nic_tx(long ioaddr, long crvalue)
 {
@@ -1121,14 +1121,13 @@
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+	int i;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
 	       " resetting...\n", dev->name, readl(ioaddr + ISR));
 
 #ifndef __alpha__
 	{
-		int i;
-
 		printk(KERN_DEBUG "  Rx ring %8.8x: ", (int) np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++)
 			printk(" %8.8x", (unsigned int) np->rx_ring[i].status);
@@ -1139,12 +1138,36 @@
 	}
 #endif
 
-	/* Perhaps we should reinitialize the hardware here.  Just trigger a
-	   Tx demand for now. */
+	dev->if_port = np->default_port;
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
+	for (i = 0; i < 50; i++) {
+		readl(ioaddr + BCR);
+		rmb();
+	}
+
+	writel(virt_to_bus(np->cur_tx), ioaddr + TXLBA);
+	writel(virt_to_bus(np->cur_rx), ioaddr + RXLBA);
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
 

-- 
Ueimor
