Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbULMWd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbULMWd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbULMWWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:22:22 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:40600 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261206AbULMWPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:15:43 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:15:41 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH 3/6] mv643xx_eth: fix hw checksum generation on transmit
Message-ID: <20041213221541.GC19951@xyzzy>
References: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213220949.GA19609@xyzzy>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the code that enables hardware checksum generation.
The previous code has so many problems that it appears to never have worked.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.c	2004-12-13 14:29:55.829024727 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.c	2004-12-13 14:30:34.651531163 -0700
@@ -29,6 +29,7 @@
  */
 #include <linux/init.h>
 #include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/etherdevice.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -57,6 +58,11 @@
 #define INT_CAUSE_CHECK_BITS		INT_CAUSE_UNMASK_ALL
 #define INT_CAUSE_CHECK_BITS_EXT	INT_CAUSE_UNMASK_ALL_EXT
 #endif
+#ifdef MV64340_CHECKSUM_OFFLOAD_TX
+#define MAX_DESCS_PER_SKB	(MAX_SKB_FRAGS + 1)
+#else
+#define MAX_DESCS_PER_SKB	1
+#endif
 
 /* Static function declarations */
 static int mv64340_eth_real_open(struct net_device *);
@@ -333,25 +339,29 @@
 		 * last skb releases the whole chain.
 		 */
 		if (pkt_info.return_info) {
-			dev_kfree_skb_irq((struct sk_buff *)
-					  pkt_info.return_info);
-			released = 0;
 			if (skb_shinfo(pkt_info.return_info)->nr_frags)
 				pci_unmap_page(NULL, pkt_info.buf_ptr,
 					pkt_info.byte_cnt, PCI_DMA_TODEVICE);
+			else
+				pci_unmap_single(NULL, pkt_info.buf_ptr,
+					pkt_info.byte_cnt, PCI_DMA_TODEVICE);
 
-			if (mp->tx_ring_skbs != 1)
-				mp->tx_ring_skbs--;
+			dev_kfree_skb_irq((struct sk_buff *)
+					  pkt_info.return_info);
+			released = 0;
+
+			/* 
+			 * Decrement the number of outstanding skbs counter on
+			 * the TX queue.
+			 */
+			if (mp->tx_ring_skbs == 0)
+				panic("ERROR - TX outstanding SKBs"
+						"counter is corrupted");
+			mp->tx_ring_skbs--;
 		} else 
 			pci_unmap_page(NULL, pkt_info.buf_ptr,
 					pkt_info.byte_cnt, PCI_DMA_TODEVICE);
 
-		/* 
-		 * Decrement the number of outstanding skbs counter on
-		 * the TX queue.
-		 */
-		if (mp->tx_ring_skbs == 0)
-			panic("ERROR - TX outstanding SKBs counter is corrupted");
 
 	}
 
@@ -489,7 +499,8 @@
 		/* UDP change : We may need this */
 		if ((eth_int_cause_ext & 0x0000ffff) &&
 		    (mv64340_eth_free_tx_queue(dev, eth_int_cause_ext) == 0) &&
-		    (MV64340_TX_QUEUE_SIZE > mp->tx_ring_skbs + 1))
+		    (MV64340_TX_QUEUE_SIZE >
+					mp->tx_ring_skbs + MAX_DESCS_PER_SKB))
                                          netif_wake_queue(dev);
 #ifdef MV64340_NAPI
 	} else {
@@ -1004,22 +1015,27 @@
 
 	while (eth_tx_return_desc(mp, &pkt_info) == ETH_OK) {
 		if (pkt_info.return_info) {
-			dev_kfree_skb_irq((struct sk_buff *)
-                                                  pkt_info.return_info);
 			if (skb_shinfo(pkt_info.return_info)->nr_frags) 
                                  pci_unmap_page(NULL, pkt_info.buf_ptr,
                                              pkt_info.byte_cnt,
                                              PCI_DMA_TODEVICE);
+			else
+                                 pci_unmap_single(NULL, pkt_info.buf_ptr,
+                                             pkt_info.byte_cnt,
+                                             PCI_DMA_TODEVICE);
 
-                         if (mp->tx_ring_skbs != 1)
-                                  mp->tx_ring_skbs--;
+			dev_kfree_skb_irq((struct sk_buff *)
+                                                  pkt_info.return_info);
+
+                        if (mp->tx_ring_skbs != 0)
+                                mp->tx_ring_skbs--;
                 } else 
                        pci_unmap_page(NULL, pkt_info.buf_ptr, pkt_info.byte_cnt,
                                       PCI_DMA_TODEVICE);
 	}
 
 	if (netif_queue_stopped(dev) &&
-            MV64340_TX_QUEUE_SIZE > mp->tx_ring_skbs + 1)
+            MV64340_TX_QUEUE_SIZE > mp->tx_ring_skbs + MAX_DESCS_PER_SKB)
                        netif_wake_queue(dev);
 }
 
@@ -1118,39 +1134,75 @@
 
 	/* Update packet info data structure -- DMA owned, first last */
 #ifdef MV64340_CHECKSUM_OFFLOAD_TX
-	if (!skb_shinfo(skb)->nr_frags || (skb_shinfo(skb)->nr_frags > 3)) {
-#endif
-		pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT |
-	    	                   ETH_TX_FIRST_DESC | ETH_TX_LAST_DESC;
+	if (!skb_shinfo(skb)->nr_frags) {
+		if (skb->ip_summed != CHECKSUM_HW)
+			pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT |
+							   ETH_TX_FIRST_DESC |
+							   ETH_TX_LAST_DESC;
+		else {
+			u32		ipheader = skb->nh.iph->ihl << 11;
 
+			pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT |
+					ETH_TX_FIRST_DESC | ETH_TX_LAST_DESC |
+					ETH_GEN_TCP_UDP_CHECKSUM |
+					ETH_GEN_IP_V_4_CHECKSUM |
+					ipheader;
+			/* CPU already calculated pseudo header checksum. */
+			if (skb->nh.iph->protocol == IPPROTO_UDP) {
+				pkt_info.cmd_sts |= ETH_UDP_FRAME;
+				pkt_info.l4i_chk = skb->h.uh->check;
+			}
+			else if (skb->nh.iph->protocol == IPPROTO_TCP)
+				pkt_info.l4i_chk = skb->h.th->check;
+			else {
+				printk(KERN_ERR
+				       "%s: chksum proto != TCP or UDP\n",
+				       dev->name);
+				spin_unlock_irqrestore(&mp->lock, flags);
+				return 1;
+			}
+		}
 		pkt_info.byte_cnt = skb->len;
 		pkt_info.buf_ptr = pci_map_single(0, skb->data, skb->len,
 		                                  PCI_DMA_TODEVICE);
-
-
 		pkt_info.return_info = skb;
 		status = eth_port_send(mp, &pkt_info);
 		if ((status == ETH_ERROR) || (status == ETH_QUEUE_FULL))
 			printk(KERN_ERR "%s: Error on transmitting packet\n",
 				       dev->name);
 		mp->tx_ring_skbs++;
-#ifdef MV64340_CHECKSUM_OFFLOAD_TX
 	} else {
 		unsigned int    frag;
-		u32		ipheader;
+		u32		ipheader = skb->nh.iph->ihl << 11;
 
                 /* first frag which is skb header */
                 pkt_info.byte_cnt = skb_headlen(skb);
                 pkt_info.buf_ptr = pci_map_single(0, skb->data,
                                         skb_headlen(skb), PCI_DMA_TODEVICE);
                 pkt_info.return_info = 0;
-                ipheader = skb->nh.iph->ihl << 11;
-                pkt_info.cmd_sts = ETH_TX_FIRST_DESC | 
-					ETH_GEN_TCP_UDP_CHECKSUM |
+                pkt_info.cmd_sts = ETH_TX_FIRST_DESC;
+
+		if (skb->ip_summed == CHECKSUM_HW) {
+			/* CPU already calculated pseudo header checksum. */
+			pkt_info.cmd_sts |= ETH_GEN_TCP_UDP_CHECKSUM |
 					ETH_GEN_IP_V_4_CHECKSUM |
-                                        ipheader;
-		/* CPU already calculated pseudo header checksum. So, use it */
-                pkt_info.l4i_chk = skb->h.th->check;
+					ipheader;
+			/* CPU already calculated pseudo header checksum. */
+			if (skb->nh.iph->protocol == IPPROTO_UDP) {
+				pkt_info.cmd_sts |= ETH_UDP_FRAME;
+				pkt_info.l4i_chk = skb->h.uh->check;
+			}
+			else if (skb->nh.iph->protocol == IPPROTO_TCP)
+				pkt_info.l4i_chk = skb->h.th->check;
+			else {
+				printk(KERN_ERR
+				       "%s: chksum proto != TCP or UDP\n",
+				       dev->name);
+				spin_unlock_irqrestore(&mp->lock, flags);
+				return 1;
+			}
+		}
+
                 status = eth_port_send(mp, &pkt_info);
 		if (status != ETH_OK) {
 	                if ((status == ETH_ERROR))
@@ -1178,8 +1230,6 @@
                                 pkt_info.return_info = 0;
                         }
                         pkt_info.byte_cnt = this_frag->size;
-                        if (this_frag->size < 8)
-                                printk("%d : \n", skb_shinfo(skb)->nr_frags);
 
                         pkt_info.buf_ptr = pci_map_page(NULL, this_frag->page,
                                         this_frag->page_offset,
@@ -1199,12 +1249,24 @@
 			}
                 }
         }
+#else
+	pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT | ETH_TX_FIRST_DESC |
+							ETH_TX_LAST_DESC;
+	pkt_info.byte_cnt = skb->len;
+	pkt_info.buf_ptr = pci_map_single(0, skb->data, skb->len,
+							PCI_DMA_TODEVICE);
+	pkt_info.return_info = skb;
+	status = eth_port_send(mp, &pkt_info);
+	if ((status == ETH_ERROR) || (status == ETH_QUEUE_FULL))
+		printk(KERN_ERR "%s: Error on transmitting packet\n",
+			       dev->name);
+	mp->tx_ring_skbs++;
 #endif
 
 	/* Check if TX queue can handle another skb. If not, then
 	 * signal higher layers to stop requesting TX
 	 */
-	if (MV64340_TX_QUEUE_SIZE <= (mp->tx_ring_skbs + 1))
+	if (MV64340_TX_QUEUE_SIZE <= (mp->tx_ring_skbs + MAX_DESCS_PER_SKB))
 		/* 
 		 * Stop getting skb's from upper layers.
 		 * Getting skb's from upper layers will be enabled again after
@@ -2180,84 +2242,60 @@
                                          struct pkt_info * p_pkt_info)
 {
 	int tx_desc_curr, tx_desc_used, tx_first_desc, tx_next_desc;
-	volatile struct eth_tx_desc *current_descriptor;
-	volatile struct eth_tx_desc *first_descriptor;
-	u32 command_status, first_chip_ptr;
+	struct eth_tx_desc *current_descriptor;
+	struct eth_tx_desc *first_descriptor;
+	u32 command;
 
 	/* Do not process Tx ring in case of Tx ring resource error */
 	if (mp->tx_resource_err)
 		return ETH_QUEUE_FULL;
 
+	/*
+	 * The hardware requires that each buffer that is <= 8 bytes
+	 * in length must be aligned on an 8 byte boundary.
+	 */
+        if (p_pkt_info->byte_cnt <= 8 && p_pkt_info->buf_ptr & 0x7) {
+                printk(KERN_ERR
+			"mv64340_eth port %d: packet size <= 8 problem\n",
+			mp->port_num);
+                return ETH_ERROR;
+        }
+
 	/* Get the Tx Desc ring indexes */
 	tx_desc_curr = mp->tx_curr_desc_q;
 	tx_desc_used = mp->tx_used_desc_q;
 
 	current_descriptor = &mp->p_tx_desc_area[tx_desc_curr];
-	if (current_descriptor == NULL)
-		return ETH_ERROR;
 
 	tx_next_desc = (tx_desc_curr + 1) % MV64340_TX_QUEUE_SIZE;
-	command_status = p_pkt_info->cmd_sts | ETH_ZERO_PADDING | ETH_GEN_CRC;
-
-	if (command_status & ETH_TX_FIRST_DESC) {
-		tx_first_desc = tx_desc_curr;
-		mp->tx_first_desc_q = tx_first_desc;
-
-                /* fill first descriptor */
-                first_descriptor = &mp->p_tx_desc_area[tx_desc_curr];
-                first_descriptor->l4i_chk = p_pkt_info->l4i_chk;
-                first_descriptor->cmd_sts = command_status;
-                first_descriptor->byte_cnt = p_pkt_info->byte_cnt;
-                first_descriptor->buf_ptr = p_pkt_info->buf_ptr;
-                first_descriptor->next_desc_ptr = mp->tx_desc_dma +
-			tx_next_desc * sizeof(struct eth_tx_desc);
-		wmb();
-        } else {
-                tx_first_desc = mp->tx_first_desc_q;
-                first_descriptor = &mp->p_tx_desc_area[tx_first_desc];
-                if (first_descriptor == NULL) {
-                        printk("First desc is NULL !!\n");
-                        return ETH_ERROR;
-                }
-                if (command_status & ETH_TX_LAST_DESC)
-                        current_descriptor->next_desc_ptr = 0x00000000;
-                else {
-                        command_status |= ETH_BUFFER_OWNED_BY_DMA;
-                        current_descriptor->next_desc_ptr = mp->tx_desc_dma +
-				tx_next_desc * sizeof(struct eth_tx_desc);
-                }
-        }
-
-        if (p_pkt_info->byte_cnt < 8) {
-                printk(" < 8 problem \n");
-                return ETH_ERROR;
-        }
 
         current_descriptor->buf_ptr = p_pkt_info->buf_ptr;
         current_descriptor->byte_cnt = p_pkt_info->byte_cnt;
         current_descriptor->l4i_chk = p_pkt_info->l4i_chk;
-        current_descriptor->cmd_sts = command_status;
-
         mp->tx_skb[tx_desc_curr] = (struct sk_buff*) p_pkt_info->return_info;
 
-        wmb();
+	command = p_pkt_info->cmd_sts | ETH_ZERO_PADDING | ETH_GEN_CRC |
+							ETH_BUFFER_OWNED_BY_DMA;
+	if (command & ETH_TX_LAST_DESC)
+		command |= ETH_TX_ENABLE_INTERRUPT;
 
-        /* Set last desc with DMA ownership and interrupt enable. */
-        if (command_status & ETH_TX_LAST_DESC) {
-                current_descriptor->cmd_sts = command_status |
-                                        ETH_TX_ENABLE_INTERRUPT |
-                                        ETH_BUFFER_OWNED_BY_DMA;
+	if (command & ETH_TX_FIRST_DESC) {
+		tx_first_desc = tx_desc_curr;
+		mp->tx_first_desc_q = tx_first_desc;
+                first_descriptor = current_descriptor;
+		mp->tx_first_command = command;
+        } else {
+                tx_first_desc = mp->tx_first_desc_q;
+                first_descriptor = &mp->p_tx_desc_area[tx_first_desc];
+		BUG_ON(first_descriptor == NULL);
+		current_descriptor->cmd_sts = command;
+        }
 
-		if (!(command_status & ETH_TX_FIRST_DESC))
-			first_descriptor->cmd_sts |= ETH_BUFFER_OWNED_BY_DMA;
+        if (command & ETH_TX_LAST_DESC) {
 		wmb();
+		first_descriptor->cmd_sts = mp->tx_first_command;
 
-		first_chip_ptr = MV_READ(MV64340_ETH_CURRENT_SERVED_TX_DESC_PTR(mp->port_num));
-
-		/* Apply send command */
-		if (first_chip_ptr == 0x00000000)
-			MV_WRITE(MV64340_ETH_TX_CURRENT_QUEUE_DESC_PTR_0(mp->port_num), (struct eth_tx_desc *) mp->tx_desc_dma + tx_first_desc);
-
+		wmb();
                 ETH_ENABLE_TX_QUEUE(mp->port_num);
 
 		/*
@@ -2265,13 +2303,9 @@
 		 * error */
                 tx_first_desc = tx_next_desc;
                 mp->tx_first_desc_q = tx_first_desc;
-	} else {
-		if (! (command_status & ETH_TX_FIRST_DESC) ) {
-			current_descriptor->cmd_sts = command_status;
-			wmb();
-		}
 	}
 
+
         /* Check for ring index overlap in the Tx desc ring */
         if (tx_next_desc == tx_desc_used) {
                 mp->tx_resource_err = 1;
@@ -2281,7 +2315,6 @@
 	}
 
         mp->tx_curr_desc_q = tx_next_desc;
-        wmb();
 
         return ETH_OK;
 }
@@ -2291,7 +2324,7 @@
 {
 	int tx_desc_curr;
 	int tx_desc_used;
-	volatile struct eth_tx_desc* current_descriptor;
+	struct eth_tx_desc *current_descriptor;
 	unsigned int command_status;
 
 	/* Do not process Tx ring in case of Tx ring resource error */
@@ -2303,32 +2336,18 @@
 	tx_desc_used = mp->tx_used_desc_q;
 	current_descriptor = &mp->p_tx_desc_area[tx_desc_curr];
 
-	if (current_descriptor == NULL)
-		return ETH_ERROR;
-
 	command_status = p_pkt_info->cmd_sts | ETH_ZERO_PADDING | ETH_GEN_CRC;
-
-/* XXX Is this for real ?!?!? */
-	/* Buffers with a payload smaller than 8 bytes must be aligned to a
-	 * 64-bit boundary. We use the memory allocated for Tx descriptor.
-	 * This memory is located in TX_BUF_OFFSET_IN_DESC offset within the
-	 * Tx descriptor. */
-	if (p_pkt_info->byte_cnt <= 8) {
-		printk(KERN_ERR
-		       "You have failed in the < 8 bytes errata - fixme\n");
-		return ETH_ERROR;
-	}
 	current_descriptor->buf_ptr = p_pkt_info->buf_ptr;
 	current_descriptor->byte_cnt = p_pkt_info->byte_cnt;
 	mp->tx_skb[tx_desc_curr] = (struct sk_buff *) p_pkt_info->return_info;
 
-	mb();
 
 	/* Set last desc with DMA ownership and interrupt enable. */
+	wmb();
 	current_descriptor->cmd_sts = command_status |
 			ETH_BUFFER_OWNED_BY_DMA | ETH_TX_ENABLE_INTERRUPT;
 
-	/* Apply send command */
+	wmb();
 	ETH_ENABLE_TX_QUEUE(mp->port_num);
 
 	/* Finish Tx packet. Update first desc in case of Tx resource error */
@@ -2374,40 +2393,33 @@
 static ETH_FUNC_RET_STATUS eth_tx_return_desc(struct mv64340_private * mp,
 					      struct pkt_info * p_pkt_info)
 {
-	int tx_desc_used, tx_desc_curr;
+	int tx_desc_used;
 #ifdef MV64340_CHECKSUM_OFFLOAD_TX
-        int tx_first_desc;
+        int tx_busy_desc = mp->tx_first_desc_q;
+#else
+	int tx_busy_desc = mp->tx_curr_desc_q;
 #endif
-	volatile struct eth_tx_desc *p_tx_desc_used;
+	struct eth_tx_desc *p_tx_desc_used;
 	unsigned int command_status;
 
 	/* Get the Tx Desc ring indexes */
-	tx_desc_curr = mp->tx_curr_desc_q;
 	tx_desc_used = mp->tx_used_desc_q;
-#ifdef MV64340_CHECKSUM_OFFLOAD_TX
-        tx_first_desc = mp->tx_first_desc_q;
-#endif
+
 	p_tx_desc_used = &mp->p_tx_desc_area[tx_desc_used];
 
-	/* XXX Sanity check */
+	/* Sanity check */
 	if (p_tx_desc_used == NULL)
 		return ETH_ERROR;
 
+	/* Stop release. About to overlap the current available Tx descriptor */
+	if (tx_desc_used == tx_busy_desc && !mp->tx_resource_err)
+		return ETH_END_OF_JOB;
+
 	command_status = p_tx_desc_used->cmd_sts;
 
 	/* Still transmitting... */
-#ifndef MV64340_CHECKSUM_OFFLOAD_TX
 	if (command_status & (ETH_BUFFER_OWNED_BY_DMA))
 		return ETH_RETRY;
-#endif
-	/* Stop release. About to overlap the current available Tx descriptor */
-#ifdef MV64340_CHECKSUM_OFFLOAD_TX
-	if (tx_desc_used == tx_first_desc && !mp->tx_resource_err)
-		return ETH_END_OF_JOB;
-#else
-	if (tx_desc_used == tx_desc_curr && !mp->tx_resource_err)
-		return ETH_END_OF_JOB;
-#endif
 
 	/* Pass the packet information to the caller */
 	p_pkt_info->cmd_sts = command_status;
@@ -2488,7 +2500,7 @@
 	if (rx_next_curr_desc == rx_used_desc)
 		mp->rx_resource_err = 1;
 
-	mb();
+	rmb();
 	return ETH_OK;
 }
 
@@ -2527,14 +2539,12 @@
 	mp->rx_skb[used_rx_desc] = p_pkt_info->return_info;
 
 	/* Flush the write pipe */
-	mb();
 
 	/* Return the descriptor to DMA ownership */
+	wmb();
 	p_used_rx_desc->cmd_sts =
 		ETH_BUFFER_OWNED_BY_DMA | ETH_RX_ENABLE_INTERRUPT;
-
-	/* Flush descriptor and CPU pipe */
-	mb();
+	wmb();
 
 	/* Move the used descriptor pointer to the next descriptor */
 	mp->rx_used_desc_q = (used_rx_desc + 1) % MV64340_RX_QUEUE_SIZE;
Index: linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h
===================================================================
--- linux-2.5-marvell-submit.orig/drivers/net/mv643xx_eth.h	2004-12-13 14:30:28.455727084 -0700
+++ linux-2.5-marvell-submit/drivers/net/mv643xx_eth.h	2004-12-13 14:30:34.652530970 -0700
@@ -511,18 +511,19 @@
 	int tx_curr_desc_q, tx_used_desc_q;
 #ifdef MV64340_CHECKSUM_OFFLOAD_TX
         int tx_first_desc_q;
+	u32 tx_first_command;
 #endif
 
 #ifdef MV64340_TX_FAST_REFILL
 	u32	tx_clean_threshold;
 #endif
 
-	volatile struct eth_rx_desc	* p_rx_desc_area;
+	struct eth_rx_desc		* p_rx_desc_area;
 	dma_addr_t			rx_desc_dma;
 	unsigned int			rx_desc_area_size;
 	struct sk_buff			* rx_skb[MV64340_RX_QUEUE_SIZE];
 
-	volatile struct eth_tx_desc	* p_tx_desc_area;
+	struct eth_tx_desc		* p_tx_desc_area;
 	dma_addr_t			tx_desc_dma;
 	unsigned int			tx_desc_area_size;
 	struct sk_buff			* tx_skb[MV64340_TX_QUEUE_SIZE];
