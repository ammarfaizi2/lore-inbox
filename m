Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRBGT5n>; Wed, 7 Feb 2001 14:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbRBGT5d>; Wed, 7 Feb 2001 14:57:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62472 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130392AbRBGT5Y>;
	Wed, 7 Feb 2001 14:57:24 -0500
Message-ID: <3A81A89C.DFD09434@mandrakesoft.com>
Date: Wed, 07 Feb 2001 14:57:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.31.0102071951060.17788-100000@athlon.local>
Content-Type: multipart/mixed;
 boundary="------------051BC21F8CB6D5A9D9FBD6AD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------051BC21F8CB6D5A9D9FBD6AD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

davej@suse.de wrote:
> 
> > rejected -- ioaddr assigned a value before pci_enable_device is called
> 
> Better ?

Here's the patch I have, against vanilla 2.4.2-pre1, with the
pci_enable_device preferred changes included...

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------051BC21F8CB6D5A9D9FBD6AD
Content-Type: text/plain; charset=us-ascii;
 name="starfire.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="starfire.patch"

Index: linux_2_4/drivers/net/starfire.c
diff -u linux_2_4/drivers/net/starfire.c:1.1.1.5 linux_2_4/drivers/net/starfire.c:1.1.1.5.2.5
--- linux_2_4/drivers/net/starfire.c:1.1.1.5	Sun Feb  4 09:38:52 2001
+++ linux_2_4/drivers/net/starfire.c	Wed Feb  7 11:51:25 2001
@@ -88,25 +88,31 @@
 
 #define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
 
+/*
+ * The ia64 doesn't allow for unaligned loads even of integers being
+ * misaligned on a 2 byte boundary. Thus always force copying of
+ * packets as the starfire doesn't allow for misaligned DMAs ;-(
+ * 23/10/2000 - Jes
+ */
+#ifdef __ia64__
+#define PKT_SHOULD_COPY(pkt_len)	1
+#else
+#define PKT_SHOULD_COPY(pkt_len)	(pkt_len < rx_copybreak)
+#endif
+
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
 #warning  See the last lines of the source file.
 #error You must compile this driver with "-O".
 #endif
 
-/* Include files, designed to support most kernel versions 2.0.0 and later. */
-#include <linux/version.h>
 #include <linux/module.h>
-#if LINUX_VERSION_CODE < 0x20300  &&  defined(MODVERSIONS)
-#include <linux/modversions.h>
-#endif
-
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
@@ -394,11 +400,14 @@
 
 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
-	
+
 	if (!printed_version++)
 		printk(KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
 		       version1, version2, version3);
 
+	if (pci_enable_device (pdev))
+		return -EIO;
+
 	ioaddr = pci_resource_start (pdev, 0);
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
 		printk (KERN_ERR "starfire %d: no PCI MEM resources, aborting\n", card_idx);
@@ -410,6 +419,7 @@
 		printk (KERN_ERR "starfire %d: cannot alloc etherdev, aborting\n", card_idx);
 		return -ENOMEM;
 	}
+	SET_MODULE_OWNER(dev);
 	
 	irq = pdev->irq; 
 
@@ -419,9 +429,6 @@
 		goto err_out_free_netdev;
 	}
 	
-	if (pci_enable_device (pdev))
-		goto err_out_free_res;
-	
 	ioaddr = (long) ioremap (ioaddr, io_size);
 	if (!ioaddr) {
 		printk (KERN_ERR "starfire %d: cannot remap 0x%x @ 0x%lx, aborting\n",
@@ -540,19 +547,15 @@
 
 static int netdev_open(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int i, retval;
 
 	/* Do we ever need to reset the chip??? */
 
-	MOD_INC_USE_COUNT;
-
 	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
-	if (retval) {
-		MOD_DEC_USE_COUNT;
+	if (retval)
 		return retval;
-	}
 
 	/* Disable the Rx and Tx, and reset the chip. */
 	writel(0, ioaddr + GenCtrl);
@@ -583,7 +586,6 @@
 		if (np->rx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
 								np->rx_ring, np->rx_ring_dma);
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
@@ -669,7 +671,7 @@
 
 static void check_duplex(struct net_device *dev, int startup)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int new_tx_mode ;
 
@@ -702,7 +704,7 @@
 static void netdev_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;		/* Check before driver release. */
 
@@ -730,7 +732,7 @@
 
 static void tx_timeout(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
@@ -757,14 +759,14 @@
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
-	return;
+	netif_wake_queue(dev);
 }
 
 
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
 static void init_ring(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int i;
 
 	np->tx_full = 0;
@@ -812,8 +814,8 @@
 
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
-	unsigned entry;
+	struct netdev_private *np = dev->priv;
+	unsigned int entry;
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -843,6 +845,9 @@
 #endif
 
 	/* Non-x86: explicitly flush descriptor cache lines here. */
+	/* Ensure everything is written back above before the transmit is
+	   initiated. - Jes */
+	wmb();
 
 	/* Update the producer index. */
 	writel(++entry, dev->base_addr + TxProducerIdx);
@@ -977,7 +982,7 @@
    for clarity and better register allocation. */
 static int netdev_rx(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	u32 desc_status;
 
@@ -1015,7 +1020,7 @@
 #endif
 			/* Check if the packet is long enough to accept without copying
 			   to a minimally-sized skbuff. */
-			if (pkt_len < rx_copybreak
+			if (PKT_SHOULD_COPY(pkt_len)
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
@@ -1037,14 +1042,6 @@
 				temp = skb_put(skb, pkt_len);
 				np->rx_info[entry].skb = NULL;
 				np->rx_info[entry].mapping = 0;
-#ifndef final_version				/* Remove after testing. */
-				if (le32_to_cpu(np->rx_ring[entry].rxaddr & ~3) != ((unsigned long) temp))
-					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-						   "do not match in netdev_rx: %d vs. %p / %p.\n",
-						   dev->name,
-						   le32_to_cpu(np->rx_ring[entry].rxaddr),
-						   skb->head, temp);
-#endif
 			}
 #ifndef final_version				/* Remove after testing. */
 			/* You will want this info for the initial debug. */
@@ -1107,7 +1104,7 @@
 
 static void netdev_error(struct net_device *dev, int intr_status)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 
 	if (intr_status & LinkChange) {
 		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
@@ -1136,7 +1133,7 @@
 static struct net_device_stats *get_stats(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 
 	/* This adapter architecture needs no SMP locks. */
 	np->stats.tx_bytes = readl(ioaddr + 0x57010);
@@ -1241,7 +1238,7 @@
 
 static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	u16 *data = (u16 *)&rq->ifr_data;
 
 	switch(cmd) {
@@ -1279,7 +1276,7 @@
 static int netdev_close(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int i;
 
 	netif_stop_queue(dev);
@@ -1340,8 +1337,6 @@
 		np->tx_info[i].skb = NULL;
 		np->tx_info[i].mapping = 0;
 	}
-
-	MOD_DEC_USE_COUNT;
 
 	return 0;
 }

--------------051BC21F8CB6D5A9D9FBD6AD--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
