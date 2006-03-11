Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWCKSlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWCKSlB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 13:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWCKSlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 13:41:01 -0500
Received: from havoc.gtf.org ([69.61.125.42]:48841 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750800AbWCKSlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 13:41:00 -0500
Date: Sat, 11 Mar 2006 13:40:50 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060311184049.GA27731@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/3c509.c            |   13 ++++++++-----
 drivers/net/Kconfig            |    3 ++-
 drivers/net/de620.c            |    2 +-
 drivers/net/dl2k.c             |   25 +++++++++++++++----------
 drivers/net/e1000/e1000_main.c |    2 +-
 drivers/net/sky2.c             |   32 +++++++++++++++++++++-----------
 drivers/net/tulip/de2104x.c    |   26 +++++++++++++-------------
 7 files changed, 61 insertions(+), 42 deletions(-)

Andrew Morton:
      3c509: bus registration fix

David S. Miller:
      Wrong return value corrupts free object in e1000 driver

Francois Romieu:
      de2104x: prevent interrupt before the interrupt handler is registered
      de2104x: fix the TX watchdog

Jesper Juhl:
      NE2000 Kconfig help entry improvement

Jon Mason:
      dl2k: DMA freeing error

Sam Ravnborg:
      de620: fix section mismatch warning

Stephen Hemminger:
      sky2: not random enough
      sky2: force early transmit interrupts
      sky2: truncate oversize packets

diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
index 824e430..830528d 100644
--- a/drivers/net/3c509.c
+++ b/drivers/net/3c509.c
@@ -1574,6 +1574,7 @@ MODULE_LICENSE("GPL");
 
 static int __init el3_init_module(void)
 {
+	int ret = 0;
 	el3_cards = 0;
 
 	if (debug >= 0)
@@ -1589,14 +1590,16 @@ static int __init el3_init_module(void)
 	}
 
 #ifdef CONFIG_EISA
-	if (eisa_driver_register (&el3_eisa_driver) < 0) {
-		eisa_driver_unregister (&el3_eisa_driver);
-	}
+	ret = eisa_driver_register(&el3_eisa_driver);
 #endif
 #ifdef CONFIG_MCA
-	mca_register_driver(&el3_mca_driver);
+	{
+		int err = mca_register_driver(&el3_mca_driver);
+		if (ret == 0)
+			ret = err;
+	}
 #endif
-	return 0;
+	return ret;
 }
 
 static void __exit el3_cleanup_module(void)
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e45a8f9..aa633fa 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1087,7 +1087,8 @@ config NE2000
 	  without a specific driver are compatible with NE2000.
 
 	  If you have a PCI NE2000 card however, say N here and Y to "PCI
-	  NE2000 support", above. If you have a NE2000 card and are running on
+	  NE2000 and clone support" under "EISA, VLB, PCI and on board
+	  controllers" below. If you have a NE2000 card and are running on
 	  an MCA system (a bus system used on some IBM PS/2 computers and
 	  laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
 	  below.
diff --git a/drivers/net/de620.c b/drivers/net/de620.c
index 0069f5f..22fc5b8 100644
--- a/drivers/net/de620.c
+++ b/drivers/net/de620.c
@@ -1012,7 +1012,7 @@ static int __init read_eeprom(struct net
 #ifdef MODULE
 static struct net_device *de620_dev;
 
-int init_module(void)
+int __init init_module(void)
 {
 	de620_dev = de620_probe(-1);
 	if (IS_ERR(de620_dev))
diff --git a/drivers/net/dl2k.c b/drivers/net/dl2k.c
index 430c628..fb9dae3 100644
--- a/drivers/net/dl2k.c
+++ b/drivers/net/dl2k.c
@@ -50,8 +50,8 @@
 
 */
 #define DRV_NAME	"D-Link DL2000-based linux driver"
-#define DRV_VERSION	"v1.17a"
-#define DRV_RELDATE	"2002/10/04"
+#define DRV_VERSION	"v1.17b"
+#define DRV_RELDATE	"2006/03/10"
 #include "dl2k.h"
 
 static char version[] __devinitdata =
@@ -765,7 +765,7 @@ rio_free_tx (struct net_device *dev, int
 			break;
 		skb = np->tx_skbuff[entry];
 		pci_unmap_single (np->pdev,
-				  np->tx_ring[entry].fraginfo,
+				  np->tx_ring[entry].fraginfo & 0xffffffffffff,
 				  skb->len, PCI_DMA_TODEVICE);
 		if (irq)
 			dev_kfree_skb_irq (skb);
@@ -892,14 +892,16 @@ receive_packet (struct net_device *dev)
 
 			/* Small skbuffs for short packets */
 			if (pkt_len > copy_thresh) {
-				pci_unmap_single (np->pdev, desc->fraginfo,
+				pci_unmap_single (np->pdev,
+						  desc->fraginfo & 0xffffffffffff,
 						  np->rx_buf_sz,
 						  PCI_DMA_FROMDEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			} else if ((skb = dev_alloc_skb (pkt_len + 2)) != NULL) {
 				pci_dma_sync_single_for_cpu(np->pdev,
-							    desc->fraginfo,
+				  			    desc->fraginfo & 
+							    	0xffffffffffff,
 							    np->rx_buf_sz,
 							    PCI_DMA_FROMDEVICE);
 				skb->dev = dev;
@@ -910,7 +912,8 @@ receive_packet (struct net_device *dev)
 						  pkt_len, 0);
 				skb_put (skb, pkt_len);
 				pci_dma_sync_single_for_device(np->pdev,
-							       desc->fraginfo,
+				  			       desc->fraginfo &
+							       	 0xffffffffffff,
 							       np->rx_buf_sz,
 							       PCI_DMA_FROMDEVICE);
 			}
@@ -1796,8 +1799,9 @@ rio_close (struct net_device *dev)
 		np->rx_ring[i].fraginfo = 0;
 		skb = np->rx_skbuff[i];
 		if (skb) {
-			pci_unmap_single (np->pdev, np->rx_ring[i].fraginfo,
-					  skb->len, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(np->pdev, 
+					 np->rx_ring[i].fraginfo & 0xffffffffffff,
+					 skb->len, PCI_DMA_FROMDEVICE);
 			dev_kfree_skb (skb);
 			np->rx_skbuff[i] = NULL;
 		}
@@ -1805,8 +1809,9 @@ rio_close (struct net_device *dev)
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		skb = np->tx_skbuff[i];
 		if (skb) {
-			pci_unmap_single (np->pdev, np->tx_ring[i].fraginfo,
-					  skb->len, PCI_DMA_TODEVICE);
+			pci_unmap_single(np->pdev, 
+					 np->tx_ring[i].fraginfo & 0xffffffffffff,
+					 skb->len, PCI_DMA_TODEVICE);
 			dev_kfree_skb (skb);
 			np->tx_skbuff[i] = NULL;
 		}
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 5b7d0f4..4c4db96 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -2917,7 +2917,7 @@ e1000_xmit_frame(struct sk_buff *skb, st
 			if (!__pskb_pull_tail(skb, pull_size)) {
 				printk(KERN_ERR "__pskb_pull_tail failed.\n");
 				dev_kfree_skb_any(skb);
-				return -EFAULT;
+				return NETDEV_TX_OK;
 			}
 			len = skb->len - skb->data_len;
 		}
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 72c1630..7326036 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -74,7 +74,7 @@
 #define TX_RING_SIZE		512
 #define TX_DEF_PENDING		(TX_RING_SIZE - 1)
 #define TX_MIN_PENDING		64
-#define MAX_SKB_TX_LE		(4 + 2*MAX_SKB_FRAGS)
+#define MAX_SKB_TX_LE		(4 + (sizeof(dma_addr_t)/sizeof(u32))*MAX_SKB_FRAGS)
 
 #define STATUS_RING_SIZE	2048	/* 2 ports * (TX + 2*RX) */
 #define STATUS_LE_BYTES		(STATUS_RING_SIZE*sizeof(struct sky2_status_le))
@@ -622,8 +622,8 @@ static void sky2_mac_init(struct sky2_hw
 
 	/* Configure Rx MAC FIFO */
 	sky2_write8(hw, SK_REG(port, RX_GMF_CTRL_T), GMF_RST_CLR);
-	sky2_write16(hw, SK_REG(port, RX_GMF_CTRL_T),
-		     GMF_RX_CTRL_DEF);
+	sky2_write32(hw, SK_REG(port, RX_GMF_CTRL_T),
+		     GMF_OPER_ON | GMF_RX_F_FL_ON);
 
 	/* Flush Rx MAC FIFO on any flow control or error */
 	sky2_write16(hw, SK_REG(port, RX_GMF_FL_MSK), GMR_FS_ANY_ERR);
@@ -995,6 +995,10 @@ static int sky2_rx_start(struct sky2_por
 		sky2_rx_add(sky2, re->mapaddr);
 	}
 
+ 	/* Truncate oversize frames */
+ 	sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), sky2->rx_bufsize - 8);
+ 	sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
+
 	/* Tell chip about available buffers */
 	sky2_write16(hw, Y2_QADDR(rxq, PREF_UNIT_PUT_IDX), sky2->rx_put);
 	sky2->rx_last_put = sky2_read16(hw, Y2_QADDR(rxq, PREF_UNIT_PUT_IDX));
@@ -1145,6 +1149,7 @@ static int sky2_xmit_frame(struct sk_buf
 	struct sky2_tx_le *le = NULL;
 	struct tx_ring_info *re;
 	unsigned i, len;
+	int avail;
 	dma_addr_t mapping;
 	u32 addr64;
 	u16 mss;
@@ -1287,12 +1292,16 @@ static int sky2_xmit_frame(struct sk_buf
 	re->idx = sky2->tx_prod;
 	le->ctrl |= EOP;
 
+	avail = tx_avail(sky2);
+	if (mss != 0 || avail < TX_MIN_PENDING) {
+ 		le->ctrl |= FRC_STAT;
+		if (avail <= MAX_SKB_TX_LE)
+			netif_stop_queue(dev);
+	}
+
 	sky2_put_idx(hw, txqaddr[sky2->port], sky2->tx_prod,
 		     &sky2->tx_last_put, TX_RING_SIZE);
 
-	if (tx_avail(sky2) <= MAX_SKB_TX_LE)
-		netif_stop_queue(dev);
-
 out_unlock:
 	spin_unlock(&sky2->tx_lock);
 
@@ -1707,10 +1716,12 @@ static void sky2_tx_timeout(struct net_d
 
 
 #define roundup(x, y)   ((((x)+((y)-1))/(y))*(y))
-/* Want receive buffer size to be multiple of 64 bits, and incl room for vlan */
+/* Want receive buffer size to be multiple of 64 bits
+ * and incl room for vlan and truncation
+ */
 static inline unsigned sky2_buf_size(int mtu)
 {
-	return roundup(mtu + ETH_HLEN + 4, 8);
+	return roundup(mtu + ETH_HLEN + VLAN_HLEN, 8) + 8;
 }
 
 static int sky2_change_mtu(struct net_device *dev, int new_mtu)
@@ -1793,7 +1804,7 @@ static struct sk_buff *sky2_receive(stru
 	if (!(status & GMR_FS_RX_OK))
 		goto resubmit;
 
-	if ((status >> 16) != length || length > sky2->rx_bufsize)
+	if (length > sky2->netdev->mtu + ETH_HLEN)
 		goto oversize;
 
 	if (length < copybreak) {
@@ -3243,8 +3254,7 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
-	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ | SA_SAMPLE_RANDOM,
-			  DRV_NAME, hw);
+	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ, DRV_NAME, hw);
 	if (err) {
 		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
 		       pci_name(pdev), pdev->irq);
diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index d7fb3ff..2d0cfbc 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -1362,7 +1362,6 @@ static int de_open (struct net_device *d
 {
 	struct de_private *de = dev->priv;
 	int rc;
-	unsigned long flags;
 
 	if (netif_msg_ifup(de))
 		printk(KERN_DEBUG "%s: enabling interface\n", dev->name);
@@ -1376,18 +1375,20 @@ static int de_open (struct net_device *d
 		return rc;
 	}
 
-	rc = de_init_hw(de);
-	if (rc) {
-		printk(KERN_ERR "%s: h/w init failure, err=%d\n",
-		       dev->name, rc);
-		goto err_out_free;
-	}
+	dw32(IntrMask, 0);
 
 	rc = request_irq(dev->irq, de_interrupt, SA_SHIRQ, dev->name, dev);
 	if (rc) {
 		printk(KERN_ERR "%s: IRQ %d request failure, err=%d\n",
 		       dev->name, dev->irq, rc);
-		goto err_out_hw;
+		goto err_out_free;
+	}
+
+	rc = de_init_hw(de);
+	if (rc) {
+		printk(KERN_ERR "%s: h/w init failure, err=%d\n",
+		       dev->name, rc);
+		goto err_out_free_irq;
 	}
 
 	netif_start_queue(dev);
@@ -1395,11 +1396,8 @@ static int de_open (struct net_device *d
 
 	return 0;
 
-err_out_hw:
-	spin_lock_irqsave(&de->lock, flags);
-	de_stop_hw(de);
-	spin_unlock_irqrestore(&de->lock, flags);
-
+err_out_free_irq:
+	free_irq(dev->irq, dev);
 err_out_free:
 	de_free_rings(de);
 	return rc;
@@ -1455,6 +1453,8 @@ static void de_tx_timeout (struct net_de
 	synchronize_irq(dev->irq);
 	de_clean_rings(de);
 
+	de_init_rings(de);
+
 	de_init_hw(de);
 	
 	netif_wake_queue(dev);
