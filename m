Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290259AbSAOTB2>; Tue, 15 Jan 2002 14:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290265AbSAOTAt>; Tue, 15 Jan 2002 14:00:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49630 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290255AbSAOTAl>;
	Tue, 15 Jan 2002 14:00:41 -0500
Message-ID: <3C447C1F.39165500@ibm.com>
Date: Tue, 15 Jan 2002 12:59:43 -0600
From: David Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; AIX 4.3)
X-Accept-Language: en
MIME-Version: 1.0
To: tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixes for pcnet32 driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch against 2.4.18-pre3 which fixes a couple of problems hit when running pcnet32.  Most of the problems can be found by running tcpdump or doing ifconfig operations on an SMP.  The specific problems addressed include:

1. PCI address leak in pcnet32_init_ring.  This function can be called under certain error conditions and indirectly by tcpdump.   pci_map_single should only be called during initialization.

2. Locking.  A number of functions (pcnet32_set_multicast_list, pcnet32_close) can be called under one processor while another processor is in pcnet32_interrupt.  This can result in skb's being freed while in use on the other path.

3. dev_skb_free in pcnet32_purge_tx_ring can be called under an interrupt path.  Change to use the _any version to account for this.

Dave Engebretsen.


diff -Naur linux.orig/drivers/net/pcnet32.c linuxppc64_2_4/drivers/net/pcnet32.c
--- linux.orig/drivers/net/pcnet32.c    Tue Jan 15 10:31:55 2002
+++ linuxppc64_2_4/drivers/net/pcnet32.c        Tue Jan 15 10:57:36 2002
@@ -944,7 +961,7 @@
     for (i = 0; i < TX_RING_SIZE; i++) {
        if (lp->tx_skbuff[i]) {
             pci_unmap_single(lp->pci_dev, lp->tx_dma_addr[i], lp->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
-           dev_kfree_skb(lp->tx_skbuff[i]);
+           dev_kfree_skb_any(lp->tx_skbuff[i]);
            lp->tx_skbuff[i] = NULL;
             lp->tx_dma_addr[i] = 0;
        }
@@ -973,7 +990,10 @@
            }
            skb_reserve (rx_skbuff, 2);
        }
-        lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, rx_skbuff->len, PCI_DMA_FROMDEVICE);
+
+       if (lp->rx_dma_addr[i] == NULL)
+               lp->rx_dma_addr[i] = pci_map_single(lp->pci_dev, rx_skbuff->tail, rx_skbuff->len, PCI_DMA_FROMDEVICE);
+
        lp->rx_ring[i].base = (u32)le32_to_cpu(lp->rx_dma_addr[i]);
        lp->rx_ring[i].buf_length = le16_to_cpu(-PKT_BUF_SZ);
        lp->rx_ring[i].status = le16_to_cpu(0x8000);
@@ -1008,7 +1028,7 @@
     /* ReInit Ring */
     lp->a.write_csr (ioaddr, 0, 1);
     i = 0;
-    while (i++ < 100)
+    while (1)
        if (lp->a.read_csr (ioaddr, 0) & 0x0100)
            break;

@@ -1020,8 +1040,9 @@
 pcnet32_tx_timeout (struct net_device *dev)
 {
     struct pcnet32_private *lp = dev->priv;
-    unsigned int ioaddr = dev->base_addr;
+    unsigned long ioaddr = dev->base_addr, flags;

+        spin_lock_irqsave(&lp->lock, flags);
     /* Transmitter timeout, serious problems. */
        printk(KERN_ERR "%s: transmit timed out, status %4.4x, resetting.\n",
               dev->name, lp->a.read_csr (ioaddr, 0));
@@ -1046,6 +1067,8 @@

        dev->trans_start = jiffies;
        netif_start_queue(dev);
+
+        spin_unlock_irqrestore(&lp->lock, flags);
 }


@@ -1053,7 +1076,7 @@
 pcnet32_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
     struct pcnet32_private *lp = dev->priv;
-    unsigned int ioaddr = dev->base_addr;
+    unsigned long ioaddr = dev->base_addr;
     u16 status;
     int entry;
     unsigned long flags;
@@ -1307,7 +1330,8 @@
                        skb_put (skb, pkt_len);
                        lp->rx_skbuff[entry] = newskb;
                        newskb->dev = dev;
-                        lp->rx_dma_addr[entry] = pci_map_single(lp->pci_dev, newskb->tail, newskb->len, PCI_DMA_FROMDEVICE);
+                       pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[entry], lp->rx_skbuff[entry]->len, PCI_DMA_FROMDEVICE);
+                        lp->rx_dma_addr[entry] = pci_map_single(lp->pci_dev, newskb->tail, newskb->len, PCI_DMA_FROMDEVICE);
                        lp->rx_ring[entry].base = le32_to_cpu(lp->rx_dma_addr[entry]);
                        rx_in_place = 1;
                    } else
@@ -1359,7 +1383,7 @@
 static int
 pcnet32_close(struct net_device *dev)
 {
-    unsigned long ioaddr = dev->base_addr;
+    unsigned long ioaddr = dev->base_addr, flags;
     struct pcnet32_private *lp = dev->priv;
     int i;

@@ -1381,12 +1405,15 @@
     lp->a.write_bcr (ioaddr, 20, 4);

     free_irq(dev->irq, dev);
-
+
+    /* Lock after free_irq to avoid deadlock with interrupt handler. */
+    spin_lock_irqsave(&lp->lock, flags);
+
     /* free all allocated skbuffs */
     for (i = 0; i < RX_RING_SIZE; i++) {
        lp->rx_ring[i].status = 0;
        if (lp->rx_skbuff[i]) {
-            pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], lp->rx_skbuff[i]->len, PCI_DMA_FROMDEVICE);
+            pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i], lp->rx_skbuff[i]->len, PCI_DMA_FROMDEVICE);
            dev_kfree_skb(lp->rx_skbuff[i]);
         }
        lp->rx_skbuff[i] = NULL;
@@ -1402,6 +1429,8 @@
         lp->tx_dma_addr[i] = 0;
     }

+    spin_unlock_irqrestore(&lp->lock, flags);
+
     MOD_DEC_USE_COUNT;

     return 0;
@@ -1479,9 +1508,10 @@
  */
 static void pcnet32_set_multicast_list(struct net_device *dev)
 {
-    unsigned long ioaddr = dev->base_addr;
+    unsigned long ioaddr = dev->base_addr, flags;
     struct pcnet32_private *lp = dev->priv;

+    spin_lock_irqsave(&lp->lock, flags);
     if (dev->flags&IFF_PROMISC) {
        /* Log any net taps. */
        printk(KERN_INFO "%s: Promiscuous mode enabled.\n", dev->name);
@@ -1494,6 +1524,7 @@
     lp->a.write_csr (ioaddr, 0, 0x0004); /* Temporarily stop the lance. */

     pcnet32_restart(dev, 0x0042); /*  Resume normal operation */
+    spin_unlock_irqrestore(&lp->lock, flags);
 }

 #ifdef HAVE_PRIVATE_IOCTL


