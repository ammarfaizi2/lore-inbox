Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWGQRg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWGQRg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 13:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWGQRg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 13:36:28 -0400
Received: from havoc.gtf.org ([69.61.125.42]:1505 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751086AbWGQRg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 13:36:26 -0400
Date: Mon, 17 Jul 2006 13:36:20 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060717173620.GA18444@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frankly, I am surprised at the low volume of complains for 2.6.18-rc1,
and now 2.6.18-rc2.  I keep worrying, waiting for the tide of complaints
to wash in...

Anyway.  Here is the next batch of net driver fixes.  The e1000 'remove
CRC' fix is probably the biggest one; that fixes a recently-introduced
bug (though, thankfully, not deadly for the common use case).

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/e1000/e1000.h      |    3 
 drivers/net/e1000/e1000_main.c |   52 +--
 drivers/net/sky2.c             |    7 
 drivers/net/spider_net.c       |  580 +++++++++++++++++------------------------
 drivers/net/spider_net.h       |   73 +----
 net/core/ethtool.c             |    2 
 6 files changed, 307 insertions(+), 410 deletions(-)

Auke Kok:
      e1000: Redo netpoll fix to address community concerns
      e1000: remove CRC bytes from measured packet length
      e1000: fix panic on large frame receive when mtu=default
      e1000: bump version to 7.1.9-k4

Jeff Garzik:
      [NET] ethtool: fix oops by testing correct struct member

Jens Osterkamp:
      spidernet: bug fix for init code
      spidernet: rework tx queue handling

Stephen Hemminger:
      sky2: NAPI poll fix

diff --git a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
index f411bbb..d304297 100644
--- a/drivers/net/e1000/e1000.h
+++ b/drivers/net/e1000/e1000.h
@@ -110,6 +110,9 @@ #define E1000_MAX_RXD                   
 #define E1000_MIN_RXD                       80
 #define E1000_MAX_82544_RXD               4096
 
+/* this is the size past which hardware will drop packets when setting LPE=0 */
+#define MAXIMUM_ETHERNET_VLAN_SIZE 1522
+
 /* Supported Rx Buffer Sizes */
 #define E1000_RXBUFFER_128   128    /* Used for packet split */
 #define E1000_RXBUFFER_256   256    /* Used for packet split */
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 6d3d419..da62db8 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -36,7 +36,7 @@ #define DRIVERNAPI
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-#define DRV_VERSION "7.1.9-k2"DRIVERNAPI
+#define DRV_VERSION "7.1.9-k4"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
 static char e1000_copyright[] = "Copyright (c) 1999-2006 Intel Corporation.";
 
@@ -1068,7 +1068,7 @@ #endif
 
 	pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);
 
-	adapter->rx_buffer_len = MAXIMUM_ETHERNET_FRAME_SIZE;
+	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
 	adapter->rx_ps_bsize0 = E1000_RXBUFFER_128;
 	hw->max_frame_size = netdev->mtu +
 			     ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
@@ -3148,7 +3148,6 @@ #define MAX_STD_JUMBO_FRAME_SIZE 9234
 		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
 
 	/* adjust allocation if LPE protects us, and we aren't using SBP */
-#define MAXIMUM_ETHERNET_VLAN_SIZE 1522
 	if (!adapter->hw.tbi_compatibility_on &&
 	    ((max_frame == MAXIMUM_ETHERNET_FRAME_SIZE) ||
 	     (max_frame == MAXIMUM_ETHERNET_VLAN_SIZE)))
@@ -3387,8 +3386,8 @@ #ifdef CONFIG_E1000_NAPI
 		E1000_WRITE_REG(hw, IMC, ~0);
 		E1000_WRITE_FLUSH(hw);
 	}
-	if (likely(netif_rx_schedule_prep(&adapter->polling_netdev[0])))
-		__netif_rx_schedule(&adapter->polling_netdev[0]);
+	if (likely(netif_rx_schedule_prep(netdev)))
+		__netif_rx_schedule(netdev);
 	else
 		e1000_irq_enable(adapter);
 #else
@@ -3431,34 +3430,26 @@ e1000_clean(struct net_device *poll_dev,
 {
 	struct e1000_adapter *adapter;
 	int work_to_do = min(*budget, poll_dev->quota);
-	int tx_cleaned = 0, i = 0, work_done = 0;
+	int tx_cleaned = 0, work_done = 0;
 
 	/* Must NOT use netdev_priv macro here. */
 	adapter = poll_dev->priv;
 
 	/* Keep link state information with original netdev */
-	if (!netif_carrier_ok(adapter->netdev))
+	if (!netif_carrier_ok(poll_dev))
 		goto quit_polling;
 
-	while (poll_dev != &adapter->polling_netdev[i]) {
-		i++;
-		BUG_ON(i == adapter->num_rx_queues);
+	/* e1000_clean is called per-cpu.  This lock protects
+	 * tx_ring[0] from being cleaned by multiple cpus
+	 * simultaneously.  A failure obtaining the lock means
+	 * tx_ring[0] is currently being cleaned anyway. */
+	if (spin_trylock(&adapter->tx_queue_lock)) {
+		tx_cleaned = e1000_clean_tx_irq(adapter,
+		                                &adapter->tx_ring[0]);
+		spin_unlock(&adapter->tx_queue_lock);
 	}
 
-	if (likely(adapter->num_tx_queues == 1)) {
-		/* e1000_clean is called per-cpu.  This lock protects
-		 * tx_ring[0] from being cleaned by multiple cpus
-		 * simultaneously.  A failure obtaining the lock means
-		 * tx_ring[0] is currently being cleaned anyway. */
-		if (spin_trylock(&adapter->tx_queue_lock)) {
-			tx_cleaned = e1000_clean_tx_irq(adapter,
-							&adapter->tx_ring[0]);
-			spin_unlock(&adapter->tx_queue_lock);
-		}
-	} else
-		tx_cleaned = e1000_clean_tx_irq(adapter, &adapter->tx_ring[i]);
-
-	adapter->clean_rx(adapter, &adapter->rx_ring[i],
+	adapter->clean_rx(adapter, &adapter->rx_ring[0],
 	                  &work_done, work_to_do);
 
 	*budget -= work_done;
@@ -3466,7 +3457,7 @@ e1000_clean(struct net_device *poll_dev,
 
 	/* If no Tx and not enough Rx work done, exit the polling mode */
 	if ((!tx_cleaned && (work_done == 0)) ||
-	   !netif_running(adapter->netdev)) {
+	   !netif_running(poll_dev)) {
 quit_polling:
 		netif_rx_complete(poll_dev);
 		e1000_irq_enable(adapter);
@@ -3681,6 +3672,9 @@ #endif
 
 		length = le16_to_cpu(rx_desc->length);
 
+		/* adjust length to remove Ethernet CRC */
+		length -= 4;
+
 		if (unlikely(!(status & E1000_RXD_STAT_EOP))) {
 			/* All receives must fit into a single buffer */
 			E1000_DBG("%s: Receive packet consumed multiple"
@@ -3885,8 +3879,9 @@ #endif
 			pci_dma_sync_single_for_device(pdev,
 				ps_page_dma->ps_page_dma[0],
 				PAGE_SIZE, PCI_DMA_FROMDEVICE);
+			/* remove the CRC */
+			l1 -= 4;
 			skb_put(skb, l1);
-			length += l1;
 			goto copydone;
 		} /* if */
 		}
@@ -3905,6 +3900,10 @@ #endif
 			skb->truesize += length;
 		}
 
+		/* strip the ethernet crc, problem is we're using pages now so
+		 * this whole operation can get a little cpu intensive */
+		pskb_trim(skb, skb->len - 4);
+
 copydone:
 		e1000_rx_checksum(adapter, staterr,
 				  le16_to_cpu(rx_desc->wb.lower.hi_dword.csum_ip.csum), skb);
@@ -4752,6 +4751,7 @@ static void
 e1000_netpoll(struct net_device *netdev)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
+
 	disable_irq(adapter->pdev->irq);
 	e1000_intr(adapter->pdev->irq, netdev, NULL);
 	e1000_clean_tx_irq(adapter, adapter->tx_ring);
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index d98f28c..de91609 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -50,7 +50,7 @@ #endif
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"1.4"
+#define DRV_VERSION		"1.5"
 #define PFX			DRV_NAME " "
 
 /*
@@ -2204,9 +2204,6 @@ static int sky2_poll(struct net_device *
 	int work_done = 0;
 	u32 status = sky2_read32(hw, B0_Y2_SP_EISR);
 
-	if (!~status)
-		goto out;
-
 	if (status & Y2_IS_HW_ERR)
 		sky2_hw_intr(hw);
 
@@ -2243,7 +2240,7 @@ static int sky2_poll(struct net_device *
 
 	if (sky2_more_work(hw))
 		return 1;
-out:
+
 	netif_rx_complete(dev0);
 
 	sky2_read32(hw, B0_Y2_SP_LISR);
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
index fb1d5a8..647f62e 100644
--- a/drivers/net/spider_net.c
+++ b/drivers/net/spider_net.c
@@ -84,7 +84,7 @@ MODULE_DEVICE_TABLE(pci, spider_net_pci_
  *
  * returns the content of the specified SMMIO register.
  */
-static u32
+static inline u32
 spider_net_read_reg(struct spider_net_card *card, u32 reg)
 {
 	u32 value;
@@ -101,7 +101,7 @@ spider_net_read_reg(struct spider_net_ca
  * @reg: register to write to
  * @value: value to write into the specified SMMIO register
  */
-static void
+static inline void
 spider_net_write_reg(struct spider_net_card *card, u32 reg, u32 value)
 {
 	value = cpu_to_le32(value);
@@ -259,39 +259,10 @@ spider_net_get_mac_address(struct net_de
  *
  * returns the status as in the dmac_cmd_status field of the descriptor
  */
-static enum spider_net_descr_status
+static inline int
 spider_net_get_descr_status(struct spider_net_descr *descr)
 {
-	u32 cmd_status;
-
-	cmd_status = descr->dmac_cmd_status;
-	cmd_status >>= SPIDER_NET_DESCR_IND_PROC_SHIFT;
-	/* no need to mask out any bits, as cmd_status is 32 bits wide only
-	 * (and unsigned) */
-	return cmd_status;
-}
-
-/**
- * spider_net_set_descr_status -- sets the status of a descriptor
- * @descr: descriptor to change
- * @status: status to set in the descriptor
- *
- * changes the status to the specified value. Doesn't change other bits
- * in the status
- */
-static void
-spider_net_set_descr_status(struct spider_net_descr *descr,
-			    enum spider_net_descr_status status)
-{
-	u32 cmd_status;
-	/* read the status */
-	cmd_status = descr->dmac_cmd_status;
-	/* clean the upper 4 bits */
-	cmd_status &= SPIDER_NET_DESCR_IND_PROC_MASKO;
-	/* add the status to it */
-	cmd_status |= ((u32)status)<<SPIDER_NET_DESCR_IND_PROC_SHIFT;
-	/* and write it back */
-	descr->dmac_cmd_status = cmd_status;
+	return descr->dmac_cmd_status & SPIDER_NET_DESCR_IND_PROC_MASK;
 }
 
 /**
@@ -328,24 +299,23 @@ spider_net_free_chain(struct spider_net_
 static int
 spider_net_init_chain(struct spider_net_card *card,
 		       struct spider_net_descr_chain *chain,
-		       struct spider_net_descr *start_descr, int no)
+		       struct spider_net_descr *start_descr,
+		       int direction, int no)
 {
 	int i;
 	struct spider_net_descr *descr;
 	dma_addr_t buf;
 
-	atomic_set(&card->rx_chain_refill,0);
-
 	descr = start_descr;
 	memset(descr, 0, sizeof(*descr) * no);
 
 	/* set up the hardware pointers in each descriptor */
 	for (i=0; i<no; i++, descr++) {
-		spider_net_set_descr_status(descr, SPIDER_NET_DESCR_NOT_IN_USE);
+		descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 
 		buf = pci_map_single(card->pdev, descr,
 				     SPIDER_NET_DESCR_SIZE,
-				     PCI_DMA_BIDIRECTIONAL);
+				     direction);
 
 		if (buf == DMA_ERROR_CODE)
 			goto iommu_error;
@@ -360,10 +330,11 @@ spider_net_init_chain(struct spider_net_
 	start_descr->prev = descr-1;
 
 	descr = start_descr;
-	for (i=0; i < no; i++, descr++) {
-		descr->next_descr_addr = descr->next->bus_addr;
-	}
+	if (direction == PCI_DMA_FROMDEVICE)
+		for (i=0; i < no; i++, descr++)
+			descr->next_descr_addr = descr->next->bus_addr;
 
+	spin_lock_init(&chain->lock);
 	chain->head = start_descr;
 	chain->tail = start_descr;
 
@@ -375,7 +346,7 @@ iommu_error:
 		if (descr->bus_addr)
 			pci_unmap_single(card->pdev, descr->bus_addr,
 					 SPIDER_NET_DESCR_SIZE,
-					 PCI_DMA_BIDIRECTIONAL);
+					 direction);
 	return -ENOMEM;
 }
 
@@ -396,7 +367,7 @@ spider_net_free_rx_chain_contents(struct
 			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->buf_addr,
 					 SPIDER_NET_MAX_FRAME,
-					 PCI_DMA_BIDIRECTIONAL);
+					 PCI_DMA_FROMDEVICE);
 		}
 		descr = descr->next;
 	}
@@ -446,15 +417,16 @@ spider_net_prepare_rx_descr(struct spide
 		skb_reserve(descr->skb, SPIDER_NET_RXBUF_ALIGN - offset);
 	/* io-mmu-map the skb */
 	buf = pci_map_single(card->pdev, descr->skb->data,
-			     SPIDER_NET_MAX_FRAME, PCI_DMA_BIDIRECTIONAL);
+			SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 	descr->buf_addr = buf;
 	if (buf == DMA_ERROR_CODE) {
 		dev_kfree_skb_any(descr->skb);
 		if (netif_msg_rx_err(card) && net_ratelimit())
 			pr_err("Could not iommu-map rx buffer\n");
-		spider_net_set_descr_status(descr, SPIDER_NET_DESCR_NOT_IN_USE);
+		descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	} else {
-		descr->dmac_cmd_status = SPIDER_NET_DMAC_RX_CARDOWNED;
+		descr->dmac_cmd_status = SPIDER_NET_DESCR_CARDOWNED |
+					 SPIDER_NET_DMAC_NOINTR_COMPLETE;
 	}
 
 	return error;
@@ -468,7 +440,7 @@ spider_net_prepare_rx_descr(struct spide
  * chip by writing to the appropriate register. DMA is enabled in
  * spider_net_enable_rxdmac.
  */
-static void
+static inline void
 spider_net_enable_rxchtails(struct spider_net_card *card)
 {
 	/* assume chain is aligned correctly */
@@ -483,7 +455,7 @@ spider_net_enable_rxchtails(struct spide
  * spider_net_enable_rxdmac enables the DMA controller by setting RX_DMA_EN
  * in the GDADMACCNTR register
  */
-static void
+static inline void
 spider_net_enable_rxdmac(struct spider_net_card *card)
 {
 	wmb();
@@ -500,23 +472,24 @@ spider_net_enable_rxdmac(struct spider_n
 static void
 spider_net_refill_rx_chain(struct spider_net_card *card)
 {
-	struct spider_net_descr_chain *chain;
-
-	chain = &card->rx_chain;
+	struct spider_net_descr_chain *chain = &card->rx_chain;
+	unsigned long flags;
 
 	/* one context doing the refill (and a second context seeing that
 	 * and omitting it) is ok. If called by NAPI, we'll be called again
 	 * as spider_net_decode_one_descr is called several times. If some
 	 * interrupt calls us, the NAPI is about to clean up anyway. */
-	if (atomic_inc_return(&card->rx_chain_refill) == 1)
-		while (spider_net_get_descr_status(chain->head) ==
-		       SPIDER_NET_DESCR_NOT_IN_USE) {
-			if (spider_net_prepare_rx_descr(card, chain->head))
-				break;
-			chain->head = chain->head->next;
-		}
+	if (!spin_trylock_irqsave(&chain->lock, flags))
+		return;
+
+	while (spider_net_get_descr_status(chain->head) ==
+			SPIDER_NET_DESCR_NOT_IN_USE) {
+		if (spider_net_prepare_rx_descr(card, chain->head))
+			break;
+		chain->head = chain->head->next;
+	}
 
-	atomic_dec(&card->rx_chain_refill);
+	spin_unlock_irqrestore(&chain->lock, flags);
 }
 
 /**
@@ -554,111 +527,6 @@ error:
 }
 
 /**
- * spider_net_release_tx_descr - processes a used tx descriptor
- * @card: card structure
- * @descr: descriptor to release
- *
- * releases a used tx descriptor (unmapping, freeing of skb)
- */
-static void
-spider_net_release_tx_descr(struct spider_net_card *card,
-			    struct spider_net_descr *descr)
-{
-	struct sk_buff *skb;
-
-	/* unmap the skb */
-	skb = descr->skb;
-	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
-			 PCI_DMA_BIDIRECTIONAL);
-
-	dev_kfree_skb_any(skb);
-
-	/* set status to not used */
-	spider_net_set_descr_status(descr, SPIDER_NET_DESCR_NOT_IN_USE);
-}
-
-/**
- * spider_net_release_tx_chain - processes sent tx descriptors
- * @card: adapter structure
- * @brutal: if set, don't care about whether descriptor seems to be in use
- *
- * returns 0 if the tx ring is empty, otherwise 1.
- *
- * spider_net_release_tx_chain releases the tx descriptors that spider has
- * finished with (if non-brutal) or simply release tx descriptors (if brutal).
- * If some other context is calling this function, we return 1 so that we're
- * scheduled again (if we were scheduled) and will not loose initiative.
- */
-static int
-spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
-{
-	struct spider_net_descr_chain *tx_chain = &card->tx_chain;
-	enum spider_net_descr_status status;
-
-	if (atomic_inc_return(&card->tx_chain_release) != 1) {
-		atomic_dec(&card->tx_chain_release);
-		return 1;
-	}
-
-	for (;;) {
-		status = spider_net_get_descr_status(tx_chain->tail);
-		switch (status) {
-		case SPIDER_NET_DESCR_CARDOWNED:
-			if (!brutal)
-				goto out;
-			/* fallthrough, if we release the descriptors
-			 * brutally (then we don't care about
-			 * SPIDER_NET_DESCR_CARDOWNED) */
-		case SPIDER_NET_DESCR_RESPONSE_ERROR:
-		case SPIDER_NET_DESCR_PROTECTION_ERROR:
-		case SPIDER_NET_DESCR_FORCE_END:
-			if (netif_msg_tx_err(card))
-				pr_err("%s: forcing end of tx descriptor "
-				       "with status x%02x\n",
-				       card->netdev->name, status);
-			card->netdev_stats.tx_dropped++;
-			break;
-
-		case SPIDER_NET_DESCR_COMPLETE:
-			card->netdev_stats.tx_packets++;
-			card->netdev_stats.tx_bytes +=
-				tx_chain->tail->skb->len;
-			break;
-
-		default: /* any other value (== SPIDER_NET_DESCR_NOT_IN_USE) */
-			goto out;
-		}
-		spider_net_release_tx_descr(card, tx_chain->tail);
-		tx_chain->tail = tx_chain->tail->next;
-	}
-out:
-	atomic_dec(&card->tx_chain_release);
-
-	netif_wake_queue(card->netdev);
-
-	if (status == SPIDER_NET_DESCR_CARDOWNED)
-		return 1;
-	return 0;
-}
-
-/**
- * spider_net_cleanup_tx_ring - cleans up the TX ring
- * @card: card structure
- *
- * spider_net_cleanup_tx_ring is called by the tx_timer (as we don't use
- * interrupts to cleanup our TX ring) and returns sent packets to the stack
- * by freeing them
- */
-static void
-spider_net_cleanup_tx_ring(struct spider_net_card *card)
-{
-	if ( (spider_net_release_tx_chain(card, 0)) &&
-	      (card->netdev->flags & IFF_UP) ) {
-		mod_timer(&card->tx_timer, jiffies + SPIDER_NET_TX_TIMER);
-	}
-}
-
-/**
  * spider_net_get_multicast_hash - generates hash for multicast filter table
  * @addr: multicast address
  *
@@ -761,97 +629,6 @@ spider_net_disable_rxdmac(struct spider_
 }
 
 /**
- * spider_net_stop - called upon ifconfig down
- * @netdev: interface device structure
- *
- * always returns 0
- */
-int
-spider_net_stop(struct net_device *netdev)
-{
-	struct spider_net_card *card = netdev_priv(netdev);
-
-	tasklet_kill(&card->rxram_full_tl);
-	netif_poll_disable(netdev);
-	netif_carrier_off(netdev);
-	netif_stop_queue(netdev);
-	del_timer_sync(&card->tx_timer);
-
-	/* disable/mask all interrupts */
-	spider_net_write_reg(card, SPIDER_NET_GHIINT0MSK, 0);
-	spider_net_write_reg(card, SPIDER_NET_GHIINT1MSK, 0);
-	spider_net_write_reg(card, SPIDER_NET_GHIINT2MSK, 0);
-
-	/* free_irq(netdev->irq, netdev);*/
-	free_irq(to_pci_dev(netdev->class_dev.dev)->irq, netdev);
-
-	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_DMA_TX_FEND_VALUE);
-
-	/* turn off DMA, force end */
-	spider_net_disable_rxdmac(card);
-
-	/* release chains */
-	spider_net_release_tx_chain(card, 1);
-
-	spider_net_free_chain(card, &card->tx_chain);
-	spider_net_free_chain(card, &card->rx_chain);
-
-	return 0;
-}
-
-/**
- * spider_net_get_next_tx_descr - returns the next available tx descriptor
- * @card: device structure to get descriptor from
- *
- * returns the address of the next descriptor, or NULL if not available.
- */
-static struct spider_net_descr *
-spider_net_get_next_tx_descr(struct spider_net_card *card)
-{
-	/* check, if head points to not-in-use descr */
-	if ( spider_net_get_descr_status(card->tx_chain.head) ==
-	     SPIDER_NET_DESCR_NOT_IN_USE ) {
-		return card->tx_chain.head;
-	} else {
-		return NULL;
-	}
-}
-
-/**
- * spider_net_set_txdescr_cmdstat - sets the tx descriptor command field
- * @descr: descriptor structure to fill out
- * @skb: packet to consider
- *
- * fills out the command and status field of the descriptor structure,
- * depending on hardware checksum settings.
- */
-static void
-spider_net_set_txdescr_cmdstat(struct spider_net_descr *descr,
-			       struct sk_buff *skb)
-{
-	/* make sure the other fields in the descriptor are written */
-	wmb();
-
-	if (skb->ip_summed != CHECKSUM_HW) {
-		descr->dmac_cmd_status = SPIDER_NET_DMAC_CMDSTAT_NOCS;
-		return;
-	}
-
-	/* is packet ip?
-	 * if yes: tcp? udp? */
-	if (skb->protocol == htons(ETH_P_IP)) {
-		if (skb->nh.iph->protocol == IPPROTO_TCP)
-			descr->dmac_cmd_status = SPIDER_NET_DMAC_CMDSTAT_TCPCS;
-		else if (skb->nh.iph->protocol == IPPROTO_UDP)
-			descr->dmac_cmd_status = SPIDER_NET_DMAC_CMDSTAT_UDPCS;
-		else /* the stack should checksum non-tcp and non-udp
-			packets on his own: NETIF_F_IP_CSUM */
-			descr->dmac_cmd_status = SPIDER_NET_DMAC_CMDSTAT_NOCS;
-	}
-}
-
-/**
  * spider_net_prepare_tx_descr - fill tx descriptor with skb data
  * @card: card structure
  * @descr: descriptor structure to fill out
@@ -864,13 +641,12 @@ spider_net_set_txdescr_cmdstat(struct sp
  */
 static int
 spider_net_prepare_tx_descr(struct spider_net_card *card,
-			    struct spider_net_descr *descr,
 			    struct sk_buff *skb)
 {
+	struct spider_net_descr *descr = card->tx_chain.head;
 	dma_addr_t buf;
 
-	buf = pci_map_single(card->pdev, skb->data,
-			     skb->len, PCI_DMA_BIDIRECTIONAL);
+	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
 	if (buf == DMA_ERROR_CODE) {
 		if (netif_msg_tx_err(card) && net_ratelimit())
 			pr_err("could not iommu-map packet (%p, %i). "
@@ -880,10 +656,101 @@ spider_net_prepare_tx_descr(struct spide
 
 	descr->buf_addr = buf;
 	descr->buf_size = skb->len;
+	descr->next_descr_addr = 0;
 	descr->skb = skb;
 	descr->data_status = 0;
 
-	spider_net_set_txdescr_cmdstat(descr,skb);
+	descr->dmac_cmd_status =
+			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
+	if (skb->protocol == htons(ETH_P_IP))
+		switch (skb->nh.iph->protocol) {
+		case IPPROTO_TCP:
+			descr->dmac_cmd_status |= SPIDER_NET_DMAC_TCP;
+			break;
+		case IPPROTO_UDP:
+			descr->dmac_cmd_status |= SPIDER_NET_DMAC_UDP;
+			break;
+		}
+
+	descr->prev->next_descr_addr = descr->bus_addr;
+
+	return 0;
+}
+
+/**
+ * spider_net_release_tx_descr - processes a used tx descriptor
+ * @card: card structure
+ * @descr: descriptor to release
+ *
+ * releases a used tx descriptor (unmapping, freeing of skb)
+ */
+static inline void
+spider_net_release_tx_descr(struct spider_net_card *card)
+{
+	struct spider_net_descr *descr = card->tx_chain.tail;
+	struct sk_buff *skb;
+
+	card->tx_chain.tail = card->tx_chain.tail->next;
+	descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
+
+	/* unmap the skb */
+	skb = descr->skb;
+	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
+			PCI_DMA_TODEVICE);
+	dev_kfree_skb_any(skb);
+}
+
+/**
+ * spider_net_release_tx_chain - processes sent tx descriptors
+ * @card: adapter structure
+ * @brutal: if set, don't care about whether descriptor seems to be in use
+ *
+ * returns 0 if the tx ring is empty, otherwise 1.
+ *
+ * spider_net_release_tx_chain releases the tx descriptors that spider has
+ * finished with (if non-brutal) or simply release tx descriptors (if brutal).
+ * If some other context is calling this function, we return 1 so that we're
+ * scheduled again (if we were scheduled) and will not loose initiative.
+ */
+static int
+spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
+{
+	struct spider_net_descr_chain *chain = &card->tx_chain;
+	int status;
+
+	spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR);
+
+	while (chain->tail != chain->head) {
+		status = spider_net_get_descr_status(chain->tail);
+		switch (status) {
+		case SPIDER_NET_DESCR_COMPLETE:
+			card->netdev_stats.tx_packets++;
+			card->netdev_stats.tx_bytes += chain->tail->skb->len;
+			break;
+
+		case SPIDER_NET_DESCR_CARDOWNED:
+			if (!brutal)
+				return 1;
+			/* fallthrough, if we release the descriptors
+			 * brutally (then we don't care about
+			 * SPIDER_NET_DESCR_CARDOWNED) */
+
+		case SPIDER_NET_DESCR_RESPONSE_ERROR:
+		case SPIDER_NET_DESCR_PROTECTION_ERROR:
+		case SPIDER_NET_DESCR_FORCE_END:
+			if (netif_msg_tx_err(card))
+				pr_err("%s: forcing end of tx descriptor "
+				       "with status x%02x\n",
+				       card->netdev->name, status);
+			card->netdev_stats.tx_errors++;
+			break;
+
+		default:
+			card->netdev_stats.tx_dropped++;
+			return 1;
+		}
+		spider_net_release_tx_descr(card);
+	}
 
 	return 0;
 }
@@ -896,18 +763,32 @@ spider_net_prepare_tx_descr(struct spide
  * spider_net_kick_tx_dma writes the current tx chain head as start address
  * of the tx descriptor chain and enables the transmission DMA engine
  */
-static void
-spider_net_kick_tx_dma(struct spider_net_card *card,
-		       struct spider_net_descr *descr)
+static inline void
+spider_net_kick_tx_dma(struct spider_net_card *card)
 {
-	/* this is the only descriptor in the output chain.
-	 * Enable TX DMA */
+	struct spider_net_descr *descr;
 
-	spider_net_write_reg(card, SPIDER_NET_GDTDCHA,
-			     descr->bus_addr);
+	if (spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR) &
+			SPIDER_NET_TX_DMA_EN)
+		goto out;
 
-	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_DMA_TX_VALUE);
+	descr = card->tx_chain.tail;
+	for (;;) {
+		if (spider_net_get_descr_status(descr) ==
+				SPIDER_NET_DESCR_CARDOWNED) {
+			spider_net_write_reg(card, SPIDER_NET_GDTDCHA,
+					descr->bus_addr);
+			spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
+					SPIDER_NET_DMA_TX_VALUE);
+			break;
+		}
+		if (descr == card->tx_chain.head)
+			break;
+		descr = descr->next;
+	}
+
+out:
+	mod_timer(&card->tx_timer, jiffies + SPIDER_NET_TX_TIMER);
 }
 
 /**
@@ -915,47 +796,69 @@ spider_net_kick_tx_dma(struct spider_net
  * @skb: packet to send out
  * @netdev: interface device structure
  *
- * returns 0 on success, <0 on failure
+ * returns 0 on success, !0 on failure
  */
 static int
 spider_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct spider_net_card *card = netdev_priv(netdev);
-	struct spider_net_descr *descr;
+	struct spider_net_descr_chain *chain = &card->tx_chain;
+	struct spider_net_descr *descr = chain->head;
+	unsigned long flags;
 	int result;
 
+	spin_lock_irqsave(&chain->lock, flags);
+
 	spider_net_release_tx_chain(card, 0);
 
-	descr = spider_net_get_next_tx_descr(card);
+	if (chain->head->next == chain->tail->prev) {
+		card->netdev_stats.tx_dropped++;
+		result = NETDEV_TX_LOCKED;
+		goto out;
+	}
 
-	if (!descr)
-		goto error;
+	if (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) {
+		result = NETDEV_TX_LOCKED;
+		goto out;
+	}
 
-	result = spider_net_prepare_tx_descr(card, descr, skb);
-	if (result)
-		goto error;
+	if (spider_net_prepare_tx_descr(card, skb) != 0) {
+		card->netdev_stats.tx_dropped++;
+		result = NETDEV_TX_BUSY;
+		goto out;
+	}
+
+	result = NETDEV_TX_OK;
 
+	spider_net_kick_tx_dma(card);
 	card->tx_chain.head = card->tx_chain.head->next;
 
-	if (spider_net_get_descr_status(descr->prev) !=
-	    SPIDER_NET_DESCR_CARDOWNED) {
-		/* make sure the current descriptor is in memory. Then
-		 * kicking it on again makes sense, if the previous is not
-		 * card-owned anymore. Check the previous descriptor twice
-		 * to omit an mb() in heavy traffic cases */
-		mb();
-		if (spider_net_get_descr_status(descr->prev) !=
-		    SPIDER_NET_DESCR_CARDOWNED)
-			spider_net_kick_tx_dma(card, descr);
-	}
+out:
+	spin_unlock_irqrestore(&chain->lock, flags);
+	netif_wake_queue(netdev);
+	return result;
+}
 
-	mod_timer(&card->tx_timer, jiffies + SPIDER_NET_TX_TIMER);
+/**
+ * spider_net_cleanup_tx_ring - cleans up the TX ring
+ * @card: card structure
+ *
+ * spider_net_cleanup_tx_ring is called by the tx_timer (as we don't use
+ * interrupts to cleanup our TX ring) and returns sent packets to the stack
+ * by freeing them
+ */
+static void
+spider_net_cleanup_tx_ring(struct spider_net_card *card)
+{
+	unsigned long flags;
 
-	return NETDEV_TX_OK;
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
 
-error:
-	card->netdev_stats.tx_dropped++;
-	return NETDEV_TX_BUSY;
+	if ((spider_net_release_tx_chain(card, 0) != 0) &&
+	    (card->netdev->flags & IFF_UP))
+		spider_net_kick_tx_dma(card);
+
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
 }
 
 /**
@@ -1002,7 +905,7 @@ spider_net_pass_skb_up(struct spider_net
 
 	/* unmap descriptor */
 	pci_unmap_single(card->pdev, descr->buf_addr, SPIDER_NET_MAX_FRAME,
-			 PCI_DMA_BIDIRECTIONAL);
+			PCI_DMA_FROMDEVICE);
 
 	/* the cases we'll throw away the packet immediately */
 	if (data_error & SPIDER_NET_DESTROY_RX_FLAGS) {
@@ -1067,14 +970,11 @@ #define SPIDER_MISALIGN		2
 static int
 spider_net_decode_one_descr(struct spider_net_card *card, int napi)
 {
-	enum spider_net_descr_status status;
-	struct spider_net_descr *descr;
-	struct spider_net_descr_chain *chain;
+	struct spider_net_descr_chain *chain = &card->rx_chain;
+	struct spider_net_descr *descr = chain->tail;
+	int status;
 	int result;
 
-	chain = &card->rx_chain;
-	descr = chain->tail;
-
 	status = spider_net_get_descr_status(descr);
 
 	if (status == SPIDER_NET_DESCR_CARDOWNED) {
@@ -1103,7 +1003,7 @@ spider_net_decode_one_descr(struct spide
 			       card->netdev->name, status);
 		card->netdev_stats.rx_dropped++;
 		pci_unmap_single(card->pdev, descr->buf_addr,
-				 SPIDER_NET_MAX_FRAME, PCI_DMA_BIDIRECTIONAL);
+				SPIDER_NET_MAX_FRAME, PCI_DMA_FROMDEVICE);
 		dev_kfree_skb_irq(descr->skb);
 		goto refill;
 	}
@@ -1119,7 +1019,7 @@ spider_net_decode_one_descr(struct spide
 	/* ok, we've got a packet in descr */
 	result = spider_net_pass_skb_up(descr, card, napi);
 refill:
-	spider_net_set_descr_status(descr, SPIDER_NET_DESCR_NOT_IN_USE);
+	descr->dmac_cmd_status = SPIDER_NET_DESCR_NOT_IN_USE;
 	/* change the descriptor state: */
 	if (!napi)
 		spider_net_refill_rx_chain(card);
@@ -1291,21 +1191,6 @@ spider_net_set_mac(struct net_device *ne
 }
 
 /**
- * spider_net_enable_txdmac - enables a TX DMA controller
- * @card: card structure
- *
- * spider_net_enable_txdmac enables the TX DMA controller by setting the
- * descriptor chain tail address
- */
-static void
-spider_net_enable_txdmac(struct spider_net_card *card)
-{
-	/* assume chain is aligned correctly */
-	spider_net_write_reg(card, SPIDER_NET_GDTDCHA,
-			     card->tx_chain.tail->bus_addr);
-}
-
-/**
  * spider_net_handle_rxram_full - cleans up RX ring upon RX RAM full interrupt
  * @card: card structure
  *
@@ -1653,7 +1538,6 @@ spider_net_enable_card(struct spider_net
 		{ SPIDER_NET_GMRWOLCTRL, 0 },
 		{ SPIDER_NET_GTESTMD, 0x10000000 },
 		{ SPIDER_NET_GTTQMSK, 0x00400040 },
-		{ SPIDER_NET_GTESTMD, 0 },
 
 		{ SPIDER_NET_GMACINTEN, 0 },
 
@@ -1692,9 +1576,6 @@ spider_net_enable_card(struct spider_net
 
 	spider_net_write_reg(card, SPIDER_NET_GRXDMAEN, SPIDER_NET_WOL_VALUE);
 
-	/* set chain tail adress for TX chain */
-	spider_net_enable_txdmac(card);
-
 	spider_net_write_reg(card, SPIDER_NET_GMACLENLMT,
 			     SPIDER_NET_LENLMT_VALUE);
 	spider_net_write_reg(card, SPIDER_NET_GMACMODE,
@@ -1709,6 +1590,9 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT1_MASK_VALUE);
 	spider_net_write_reg(card, SPIDER_NET_GHIINT2MSK,
 			     SPIDER_NET_INT2_MASK_VALUE);
+
+	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
+			     SPIDER_NET_GDTDCEIDIS);
 }
 
 /**
@@ -1728,10 +1612,12 @@ spider_net_open(struct net_device *netde
 
 	result = -ENOMEM;
 	if (spider_net_init_chain(card, &card->tx_chain,
-			  card->descr, tx_descriptors))
+			card->descr,
+			PCI_DMA_TODEVICE, tx_descriptors))
 		goto alloc_tx_failed;
 	if (spider_net_init_chain(card, &card->rx_chain,
-			  card->descr + tx_descriptors, rx_descriptors))
+			card->descr + tx_descriptors,
+			PCI_DMA_FROMDEVICE, rx_descriptors))
 		goto alloc_rx_failed;
 
 	/* allocate rx skbs */
@@ -1938,7 +1824,7 @@ spider_net_workaround_rxramfull(struct s
 	/* empty sequencer data */
 	for (sequencer = 0; sequencer < SPIDER_NET_FIRMWARE_SEQS;
 	     sequencer++) {
-		spider_net_write_reg(card, SPIDER_NET_GSnPRGDAT +
+		spider_net_write_reg(card, SPIDER_NET_GSnPRGADR +
 				     sequencer * 8, 0x0);
 		for (i = 0; i < SPIDER_NET_FIRMWARE_SEQWORDS; i++) {
 			spider_net_write_reg(card, SPIDER_NET_GSnPRGDAT +
@@ -1955,6 +1841,49 @@ spider_net_workaround_rxramfull(struct s
 }
 
 /**
+ * spider_net_stop - called upon ifconfig down
+ * @netdev: interface device structure
+ *
+ * always returns 0
+ */
+int
+spider_net_stop(struct net_device *netdev)
+{
+	struct spider_net_card *card = netdev_priv(netdev);
+
+	tasklet_kill(&card->rxram_full_tl);
+	netif_poll_disable(netdev);
+	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
+	del_timer_sync(&card->tx_timer);
+
+	/* disable/mask all interrupts */
+	spider_net_write_reg(card, SPIDER_NET_GHIINT0MSK, 0);
+	spider_net_write_reg(card, SPIDER_NET_GHIINT1MSK, 0);
+	spider_net_write_reg(card, SPIDER_NET_GHIINT2MSK, 0);
+
+	/* free_irq(netdev->irq, netdev);*/
+	free_irq(to_pci_dev(netdev->class_dev.dev)->irq, netdev);
+
+	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
+			     SPIDER_NET_DMA_TX_FEND_VALUE);
+
+	/* turn off DMA, force end */
+	spider_net_disable_rxdmac(card);
+
+	/* release chains */
+	if (spin_trylock(&card->tx_chain.lock)) {
+		spider_net_release_tx_chain(card, 1);
+		spin_unlock(&card->tx_chain.lock);
+	}
+
+	spider_net_free_chain(card, &card->tx_chain);
+	spider_net_free_chain(card, &card->rx_chain);
+
+	return 0;
+}
+
+/**
  * spider_net_tx_timeout_task - task scheduled by the watchdog timeout
  * function (to be called not under interrupt status)
  * @data: data, is interface device structure
@@ -1982,7 +1911,7 @@ spider_net_tx_timeout_task(void *data)
 		goto out;
 
 	spider_net_open(netdev);
-	spider_net_kick_tx_dma(card, card->tx_chain.head);
+	spider_net_kick_tx_dma(card);
 	netif_device_attach(netdev);
 
 out:
@@ -2065,7 +1994,6 @@ spider_net_setup_netdev(struct spider_ne
 
 	pci_set_drvdata(card->pdev, netdev);
 
-	atomic_set(&card->tx_chain_release,0);
 	card->rxram_full_tl.data = (unsigned long) card;
 	card->rxram_full_tl.func =
 		(void (*)(unsigned long)) spider_net_handle_rxram_full;
@@ -2079,7 +2007,7 @@ spider_net_setup_netdev(struct spider_ne
 
 	spider_net_setup_netdev_ops(netdev);
 
-	netdev->features = NETIF_F_HW_CSUM;
+	netdev->features = NETIF_F_HW_CSUM | NETIF_F_LLTX;
 	/* some time: NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX |
 	 *		NETIF_F_HW_VLAN_FILTER */
 
diff --git a/drivers/net/spider_net.h b/drivers/net/spider_net.h
index 3b8d951..f6dcf18 100644
--- a/drivers/net/spider_net.h
+++ b/drivers/net/spider_net.h
@@ -208,7 +208,10 @@ #define SPIDER_NET_BURSTLMT_VALUE	0x0000
 #define SPIDER_NET_DMA_RX_VALUE		0x80000000
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
-#define SPIDER_NET_DMA_TX_VALUE		0x80000000
+#define SPIDER_NET_TX_DMA_EN		0x80000000
+#define SPIDER_NET_GDTDCEIDIS		0x00000002
+#define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
+					SPIDER_NET_GDTDCEIDIS
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
 /* SPIDER_NET_UA_DESCR_VALUE is OR'ed with the unicast address */
@@ -329,55 +332,23 @@ #define SPIDER_NET_ERRINT	( 0xffffffff &
 				  (~SPIDER_NET_TXINT) & \
 				  (~SPIDER_NET_RXINT) )
 
-#define SPIDER_NET_GPREXEC		0x80000000
-#define SPIDER_NET_GPRDAT_MASK		0x0000ffff
+#define SPIDER_NET_GPREXEC			0x80000000
+#define SPIDER_NET_GPRDAT_MASK			0x0000ffff
 
-/* descriptor bits
- *
- * 1010					descriptor ready
- *     0				descr in middle of chain
- *      000				fixed to 0
- *
- *         0				no interrupt on completion
- *          000				fixed to 0
- *             1			no ipsec processing
- *              1			last descriptor for this frame
- *               00			no checksum
- *               10			tcp checksum
- *               11			udp checksum
- *
- *                 00			fixed to 0
- *                   0			fixed to 0
- *                    0			no interrupt on response errors
- *                     0		no interrupt on invalid descr
- *                      0		no interrupt on dma process termination
- *                       0		no interrupt on descr chain end
- *                        0		no interrupt on descr complete
- *
- *                         000		fixed to 0
- *                            0		response error interrupt status
- *                             0	invalid descr status
- *                              0	dma termination status
- *                               0	descr chain end status
- *                                0	descr complete status */
-#define SPIDER_NET_DMAC_CMDSTAT_NOCS	0xa00c0000
-#define SPIDER_NET_DMAC_CMDSTAT_TCPCS	0xa00e0000
-#define SPIDER_NET_DMAC_CMDSTAT_UDPCS	0xa00f0000
-#define SPIDER_NET_DESCR_IND_PROC_SHIFT	28
-#define SPIDER_NET_DESCR_IND_PROC_MASKO	0x0fffffff
-
-/* descr ready, descr is in middle of chain, get interrupt on completion */
-#define SPIDER_NET_DMAC_RX_CARDOWNED	0xa0800000
-
-enum spider_net_descr_status {
-	SPIDER_NET_DESCR_COMPLETE		= 0x00, /* used in rx and tx */
-	SPIDER_NET_DESCR_RESPONSE_ERROR		= 0x01, /* used in rx and tx */
-	SPIDER_NET_DESCR_PROTECTION_ERROR	= 0x02, /* used in rx and tx */
-	SPIDER_NET_DESCR_FRAME_END		= 0x04, /* used in rx */
-	SPIDER_NET_DESCR_FORCE_END		= 0x05, /* used in rx and tx */
-	SPIDER_NET_DESCR_CARDOWNED		= 0x0a, /* used in rx and tx */
-	SPIDER_NET_DESCR_NOT_IN_USE /* any other value */
-};
+#define SPIDER_NET_DMAC_NOINTR_COMPLETE		0x00800000
+#define SPIDER_NET_DMAC_NOCS			0x00040000
+#define SPIDER_NET_DMAC_TCP			0x00020000
+#define SPIDER_NET_DMAC_UDP			0x00030000
+#define SPIDER_NET_TXDCEST			0x08000000
+
+#define SPIDER_NET_DESCR_IND_PROC_MASK		0xF0000000
+#define SPIDER_NET_DESCR_COMPLETE		0x00000000 /* used in rx and tx */
+#define SPIDER_NET_DESCR_RESPONSE_ERROR		0x10000000 /* used in rx and tx */
+#define SPIDER_NET_DESCR_PROTECTION_ERROR	0x20000000 /* used in rx and tx */
+#define SPIDER_NET_DESCR_FRAME_END		0x40000000 /* used in rx */
+#define SPIDER_NET_DESCR_FORCE_END		0x50000000 /* used in rx and tx */
+#define SPIDER_NET_DESCR_CARDOWNED		0xA0000000 /* used in rx and tx */
+#define SPIDER_NET_DESCR_NOT_IN_USE		0xF0000000
 
 struct spider_net_descr {
 	/* as defined by the hardware */
@@ -398,7 +369,7 @@ struct spider_net_descr {
 } __attribute__((aligned(32)));
 
 struct spider_net_descr_chain {
-	/* we walk from tail to head */
+	spinlock_t lock;
 	struct spider_net_descr *head;
 	struct spider_net_descr *tail;
 };
@@ -453,8 +424,6 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
-	atomic_t rx_chain_refill;
-	atomic_t tx_chain_release;
 
 	struct net_device_stats netdev_stats;
 
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 27ce168..2797e28 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -437,7 +437,7 @@ static int ethtool_set_pauseparam(struct
 {
 	struct ethtool_pauseparam pauseparam;
 
-	if (!dev->ethtool_ops->get_pauseparam)
+	if (!dev->ethtool_ops->set_pauseparam)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&pauseparam, useraddr, sizeof(pauseparam)))
