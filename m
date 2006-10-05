Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWJESYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWJESYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWJESXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:51 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751379AbWJESXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:23:07 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 10/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 11:13:17 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051113.17079.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:43.0828 (UTC) FILETIME=[400CF340:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. Packet transmit code.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/drivers/net/vioc/vioc_transmit.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_transmit.c
--- linux-2.6.17/drivers/net/vioc/vioc_transmit.c	1969-12-31 
16:00:00.000000000 -0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_transmit.c	2006-10-04 
10:51:49.000000000 -0700
@@ -0,0 +1,1032 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/socket.h>
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/if_vlan.h>
+#include <linux/timex.h>
+#include <linux/ethtool.h>
+
+#include <net/dst.h>
+#include <net/arp.h>
+#include <net/sock.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/checksum.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/msr.h>
+
+#include "f7/vnic_defs.h"
+#include "f7/vioc_pkts_defs.h"
+
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+
+#define VNIC_MIN_MTU   64
+#define TXQ0            0
+#define NOT_SET        -1
+
+static inline u32 vnic_rd_txd_ctl(struct txq *txq)
+{
+	return readl(txq->va_of_vreg_veng_txd_ctl);
+}
+
+static inline void vnic_ring_tx_bell(struct txq *txq)
+{
+	writel(txq->shadow_VREG_VENG_TXD_CTL | VREG_VENG_TXD_CTL_QRING_MASK,
+	       txq->va_of_vreg_veng_txd_ctl);
+	txq->bells++;
+}
+
+static inline void vnic_reset_tx_ring_err(struct txq *txq)
+{
+	writel(txq->shadow_VREG_VENG_TXD_CTL |
+	       (VREG_VENG_TXD_CTL_QENABLE_MASK | VREG_VENG_TXD_CTL_CLEARMASK),
+	       txq->va_of_vreg_veng_txd_ctl);
+}
+
+static inline void vnic_enable_tx_ring(struct txq *txq)
+{
+	txq->shadow_VREG_VENG_TXD_CTL = VREG_VENG_TXD_CTL_QENABLE_MASK;
+	writel(txq->shadow_VREG_VENG_TXD_CTL, txq->va_of_vreg_veng_txd_ctl);
+}
+
+static inline void vnic_disable_tx_ring(struct txq *txq)
+{
+	txq->shadow_VREG_VENG_TXD_CTL = 0;
+	writel(0, txq->va_of_vreg_veng_txd_ctl);
+}
+
+static inline void vnic_pause_tx_ring(struct txq *txq)
+{
+	txq->shadow_VREG_VENG_TXD_CTL |= VREG_VENG_TXD_CTL_QPAUSE_MASK;
+	writel(txq->shadow_VREG_VENG_TXD_CTL, txq->va_of_vreg_veng_txd_ctl);
+}
+
+static inline void vnic_resume_tx_ring(struct txq *txq)
+{
+	txq->shadow_VREG_VENG_TXD_CTL &= ~VREG_VENG_TXD_CTL_QPAUSE_MASK;
+	writel(txq->shadow_VREG_VENG_TXD_CTL, txq->va_of_vreg_veng_txd_ctl);
+}
+
+
+/* TxQ must be locked */
+static void vnic_reset_txq(struct vnic_device *vnicdev, struct txq *txq)
+{
+
+	struct tx_pktBufDesc_Phys_w *txd;
+	int i;
+
+	vnic_reset_tx_ring_err(txq);
+
+	/* The reset of the code is not executing
+	 * because so far we can't reset individual VNICs.
+	 * Need to (SW) Reset the whole VIOC.
+	 */
+
+	vnic_disable_tx_ring(txq);
+	wmb();
+	/*
+	 * Clean-up all Tx Descriptors, take ownership of all
+	 * descriptors
+	 */
+	for (i = 0; i < txq->count; i++) {
+		if (txq->desc) {
+			txd = TXD_PTR(txq, i);
+			txd->word_1 = 0;
+			txd->word_0 = 0;
+		}
+		if (txq->vbuf) {
+			if (txq->vbuf[i].dma) {
+				pci_unmap_page(vnicdev->viocdev->pdev,
+					       txq->vbuf[i].dma,
+					       txq->vbuf[i].length,
+					       PCI_DMA_TODEVICE);
+				txq->vbuf[i].dma = 0;
+			}
+
+			/* Free skb , should be for SOP (in case of frags) only  */
+			if (txq->vbuf[i].skb) {
+				dev_kfree_skb_any((struct sk_buff *)txq->
+						  vbuf[i].skb);
+				txq->vbuf[i].skb = NULL;
+			}
+		}
+	}
+	txq->next_to_clean = 0;
+	txq->next_to_use = 0;
+	txq->empty = txq->count;
+	wmb();
+	vnic_enable_tx_ring(txq);
+}
+
+/* TxQ must be locked */
+static int vnic_clean_txq(struct vnic_device *vnicdev, struct txq *txq)
+{
+	struct tx_pktBufDesc_Phys_w *txd;
+	int clean_idx, pkt_len;
+	int sop_idx = NOT_SET;
+	int eop_idx = NOT_SET;
+	int reset_flag = 0;
+
+	if (unlikely(!txq->desc))
+		return reset_flag;
+
+	/*
+	 * Clean-up all Tx Descriptors, whose buffers where
+	 * transmitted by VIOC:
+	 * bit 30 (Valid) indicates if bits 27-29 (Status) have been set
+	 * by the VIOC HW, stating that descrptor was processed by HW.
+	 */
+	for (clean_idx = txq->next_to_clean;;
+	     clean_idx = VNIC_NEXT_IDX(clean_idx, txq->count)) {
+
+		txd = TXD_PTR(txq, clean_idx);
+
+		if (GET_VNIC_TX_HANDED(txd) != VNIC_TX_HANDED_HW_W)
+			/* This descriptor has NOT been handed to HW, done! */
+			break;
+
+		if (GET_VNIC_TX_SOP(txd) == VNIC_TX_SOP_W) {
+			if (sop_idx != NOT_SET) {
+				/* Problem - SOP back-to-back without EOP */
+				dev_err(&vnicdev->viocdev->pdev->dev,
+				       "vioc%d-vnic%d-txd%d ERROR (back-to-back SOP) 
(txd->word_1=%08x).\n",
+				       vnicdev->viocdev->viocdev_idx,
+				       vnicdev->vnic_id, clean_idx,
+				       txd->word_1);
+
+				vnicdev->net_stats.tx_errors++;
+				reset_flag = 1;
+				break;
+			}
+			sop_idx = clean_idx;
+		}
+
+		if (GET_VNIC_TX_EOP(txd) == VNIC_TX_EOP_W) {
+			eop_idx = clean_idx;
+			if (sop_idx == NOT_SET) {
+				/* Problem - EOP without SOP */
+				dev_err(&vnicdev->viocdev->pdev->dev,
+				       "vioc%d-vnic%d-txd%d ERROR (EOP without SOP)  
(txd->word_1=%08x).\n",
+				       vnicdev->viocdev->viocdev_idx,
+				       vnicdev->vnic_id, clean_idx,
+				       txd->word_1);
+
+				vnicdev->net_stats.tx_errors++;
+				reset_flag = 1;
+				break;
+			}
+			if (GET_VNIC_TX_VALID(txd) != VNIC_TX_VALID_W)
+				/* VIOC is still working on this descriptor */
+				break;
+		}
+
+		/*
+		 * Check for errors: regardless of whether an error detected
+		 * on SOP, MOP or EOP descritptor, reset the ring.
+		 */
+		if (GET_VNIC_TX_STS(txd) != VNIC_TX_TX_OK_W) {
+			dev_err(&vnicdev->viocdev->pdev->dev,
+			       "vioc%d-vnic%d TxD ERROR (txd->word_1=%08x).\n",
+			       vnicdev->viocdev->viocdev_idx, vnicdev->vnic_id,
+			       txd->word_1);
+
+			vnicdev->net_stats.tx_errors++;
+			reset_flag = 1;
+			break;
+		}
+
+		if (eop_idx != NOT_SET) {
+			/* Found EOP fragment: start CLEANING */
+			pkt_len = 0;
+			for (clean_idx = sop_idx;;
+			     clean_idx = VNIC_NEXT_IDX(clean_idx, txq->count)) {
+
+				txd = TXD_PTR(txq, clean_idx);
+
+				/* Clear TxD's Handed bit, indicating that SW owns it now */
+				CLR_VNIC_TX_HANDED(txd);
+
+				/* One more empty descriptor */
+				txq->empty++;
+
+				if (txq->vbuf[clean_idx].dma) {
+					pci_unmap_page(vnicdev->viocdev->pdev,
+						       txq->vbuf[clean_idx].dma,
+						       txq->vbuf[clean_idx].
+						       length,
+						       PCI_DMA_TODEVICE);
+					txq->vbuf[clean_idx].dma = 0;
+				}
+
+				/* Free skb , should be for SOP (in case of frags) only  */
+				if (txq->vbuf[clean_idx].skb) {
+					dev_kfree_skb_any((struct sk_buff *)
+							  txq->vbuf[clean_idx].
+							  skb);
+					txq->vbuf[clean_idx].skb = NULL;
+				}
+
+				pkt_len += txq->vbuf[clean_idx].length;
+
+				if (clean_idx == eop_idx)
+					goto set_pkt_stats;
+			}
+
+		      set_pkt_stats:
+			/*
+			 * Since this Tx Descriptor was already
+			 * transmitted, account for it - update stats.
+			 */
+			vnicdev->net_stats.tx_bytes += pkt_len;
+			vnicdev->net_stats.tx_packets++;
+			/*
+			 * This is the ONLY place, where txq->next_to_clean is
+			 * advanced.
+			 * It will point past EOP descriptor of the just cleaned pkt.
+			 */
+			txq->next_to_clean = VNIC_NEXT_IDX(eop_idx, txq->count);
+			/*
+			 * Reset sop_idx and eop_idx: start looking for next pkt
+			 */
+			sop_idx = eop_idx = NOT_SET;
+			/*
+			 * At this point clean_idx == eop_idx, it will be advanced
+			 * to the next descriptor at the top of the loop
+			 */
+		}
+	}
+
+	if (reset_flag) {
+		/* For DEBUGGING */
+	}
+
+	/*
+	 * If the queue was stopped, and if we have now enough room -
+	 * wake it up
+	 */
+	if ((netif_queue_stopped(vnicdev->netdev)) &&
+	    !txq->vbuf[txq->next_to_use].skb) {
+		netif_wake_queue(vnicdev->netdev);
+	}
+
+	return reset_flag;
+}
+
+/*
+ * Only called from interrupt context.
+ */
+static void vnic_tx_interrupt(struct vioc_device *viocdev, int vnic_id,
+			      int clean)
+{
+	struct vnic_device *vnicdev = viocdev->vnic_netdev[vnic_id]->priv;
+	u32 txd_ctl;
+	int txq_was_reset;
+	struct txq *txq;
+	char *txdesc_s = "";
+	char *txring_s = "";
+
+	txq = &vnicdev->txq;
+
+	if (!spin_trylock(&txq->lock)) {
+		/* Retry later */
+		return;
+	}
+
+	/* Get the TxD Control Register */
+	txd_ctl = vnic_rd_txd_ctl(txq);
+
+	if (txd_ctl & VREG_VENG_TXD_CTL_ERROR_MASK)
+		txring_s = "Tx Ring";
+
+	if (txd_ctl & VREG_VENG_TXD_CTL_INVDESC_MASK)
+		txdesc_s = "Tx Descriptor";
+
+	if (txd_ctl &
+	    (VREG_VENG_TXD_CTL_INVDESC_MASK | VREG_VENG_TXD_CTL_ERROR_MASK)) {
+		dev_err(&viocdev->pdev->dev,
+		       "vioc%d-vnic%d TxD Ctl=%08x, ERROR %s %s. Reset Tx Ring!\n",
+		       viocdev->viocdev_idx, vnic_id, txd_ctl, txdesc_s,
+		       txring_s);
+
+		vnic_reset_txq(vnicdev, txq);
+		netif_wake_queue(vnicdev->netdev);
+	} else {
+		/* No problem with HW, just clean-up the Tx Ring */
+		if (clean)
+			txq_was_reset = vnic_clean_txq(vnicdev, txq);
+	}
+
+	if ((txd_ctl & VREG_VENG_TXD_CTL_TXSTATE_MASK) ==
+	    VVAL_VENG_TXD_CTL_TXSTATE_EMPTY)
+		vnicdev->vnic_stats.tx_on_empty_interrupts++;
+
+	spin_unlock(&txq->lock);
+}
+
+/*
+ * Must only be called from interrupt context.
+ */
+void vioc_tx_interrupt(void *input_param)
+{
+	struct vioc_device *viocdev;
+	u32 vioc_idx;
+	u32 vnic_idx;
+	u32 vnic_map;
+
+	vioc_idx = VIOC_IRQ_PARAM_VIOC_ID(input_param);
+	viocdev = vioc_viocdev(vioc_idx);
+	// read_lock(&viocdev->lock); /* protect against vnic changes */
+	vnic_map = viocdev->vnics_map;
+	for (vnic_idx = 0; vnic_idx < VIOC_MAX_VNICS; vnic_idx++) {
+		if (vnic_map & (1 << vnic_idx))
+			vnic_tx_interrupt(viocdev, vnic_idx, 1);
+	}
+	viocdev->vioc_stats.tx_tasklets++;
+	// read_unlock(&viocdev->lock);
+}
+void vnic_enqueue_tx_pkt(struct vnic_device *vnicdev, struct txq *txq,
+			 struct sk_buff *skb, struct vioc_prov *prov)
+{
+	int idx, sop_idx, eop_idx, f;
+	struct tx_pktBufDesc_Phys_w *txd;
+
+	/*
+	 * Map Tx buffers vbuf queue.
+	 */
+	idx = txq->next_to_use;
+	sop_idx = idx;
+
+	txq->vbuf[idx].skb = skb;
+	txq->vbuf[idx].dma = pci_map_single(vnicdev->viocdev->pdev,
+					    skb->data,
+					    skb->len, PCI_DMA_TODEVICE);
+	txq->vbuf[idx].length = skb_headlen(skb);
+
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++) {
+		struct skb_frag_struct *frag;
+
+		frag = &skb_shinfo(skb)->frags[f];
+
+		idx = VNIC_NEXT_IDX(idx, txq->count);
+
+		txq->vbuf[idx].skb = NULL;
+
+		txq->vbuf[idx].dma = pci_map_page(vnicdev->viocdev->pdev,
+						  frag->page,
+						  frag->page_offset,
+						  frag->size, PCI_DMA_TODEVICE);
+		txq->vbuf[idx].length = frag->size;
+		txq->frags++;
+	}
+
+	eop_idx = idx;
+
+	txq->next_to_use = VNIC_NEXT_IDX(eop_idx, txq->count);
+
+	if (txq->next_to_use < sop_idx)
+		txq->empty -= ((txq->count + txq->next_to_use) - sop_idx);
+	else
+		txq->empty -= (txq->next_to_use - sop_idx);
+
+	/*
+	 * We are going backwards (from EOP to SOP) in setting up Tx Descriptors. 
+	 * (idx == eop_ied, when we enter the loop)
+	 * So, by the time we will transfer the SOP Tx Descriptor
+	 * fragment over to VIOC HW, ALL following fragments would have
+	 * been already transferred, and VIOC HW should not have trouble
+	 * picking all of them.
+	 */
+
+	for (;;) {
+		u32 word_1 = 0;
+
+		txd = TXD_PTR(txq, idx);
+
+		/* Set Tx buffer address */
+		*((dma_addr_t *) txd) = txq->vbuf[idx].dma;
+
+		/*
+		 * Force memory writes to complete (FENCE), before letting VIOC know,
+		 * that there are new descriptor(s). Do it ONLY for the
+		 * SOP descriptor:  no point "fencing" on every other descriptori
+		 * if, there were frags...
+		 */
+		/* Set SOP */
+		if (idx == sop_idx) {
+			word_1 |= VNIC_TX_SOP_W;
+			wmb();
+		}
+		/* Set EOP */
+		if (idx == eop_idx)
+			word_1 |= VNIC_TX_EOP_W;
+
+		/* Set Interrupt request (VNIC_TX_INTR_W), when needed */
+		if (prov->run_param.tx_pkts_per_irq > 0) {
+			if (txq->tx_pkts_til_irq == 0) {
+				txq->tx_pkts_til_irq =
+				    prov->run_param.tx_pkts_per_irq;
+				word_1 |= VNIC_TX_INTR_W;
+			} else {
+				txq->tx_pkts_til_irq--;
+			}
+		}
+
+		/* Now the rest of it */
+		txd->word_1 |= word_1 |
+		    VNIC_TX_HANDED_HW_W |
+		    ((txq->vbuf[idx].length << VNIC_TX_BUFLEN_SHIFT) &
+		     VNIC_TX_BUFLEN_MASK);
+
+		if (idx == sop_idx)
+			/* All done, if SOP descriptor was just set */
+			break;
+		else
+			/* Go back one more fragment */
+			idx = VNIC_PREV_IDX(idx, txq->count);
+	}
+
+	/*
+	 *  Ring bell here, before checking, if vnic_clean_txq() needs to
+	 *  be called.
+	 */
+	vnic_ring_tx_bell(txq);
+
+	if (txq->next_to_use == txq->next_to_clean) {
+		txq->wraps++;
+		vnic_clean_txq(vnicdev, txq);
+		if (txq->next_to_use == txq->next_to_clean) {
+			txq->full++;
+		}
+	}
+
+}
+
+void vnic_enqueue_tx_buffers(struct vnic_device *vnicdev, struct txq *txq,
+			     struct sk_buff *skb, struct vioc_prov *prov)
+{
+	int len;
+	int idx;
+	struct tx_pktBufDesc_Phys_w *txd;
+
+	idx = txq->next_to_use;
+	len = skb->len;
+
+	txq->vbuf[idx].skb = skb;
+	txq->vbuf[idx].dma = pci_map_single(vnicdev->viocdev->pdev,
+					    skb->data, len, PCI_DMA_TODEVICE);
+	txq->vbuf[idx].length = skb->len;
+
+	/*
+	 * We are going backwards in setting up Tx Descriptors.  So,
+	 * by the time we will trun the Tx Descriptor with the first
+	 * fragment over to VIOC, the following fragments would have
+	 * been already turned over.
+	 */
+	txd = TXD_PTR(txq, idx);
+
+	/*
+	 * Force memory writes to complete, before letting VIOC know,
+	 * that there are new descriptor(s), but do it ONLY for the
+	 * very first descriptor (in case there were frags). No point   
+	 * "fencing" on every descriptor in this request.
+	 */
+	wmb();
+
+	*((dma_addr_t *) txd) = txq->vbuf[idx].dma;
+
+	if (prov->run_param.tx_pkts_per_irq > 0) {
+		if (txq->tx_pkts_til_irq == 0) {
+			txq->tx_pkts_til_irq = prov->run_param.tx_pkts_per_irq;
+			/* Set Interrupt request: VNIC_TX_INTR_W */
+			txd->word_1 |=
+			    (VNIC_TX_HANDED_HW_W | VNIC_TX_SOP_W | VNIC_TX_EOP_W
+			     | VNIC_TX_INTR_W | ((len << VNIC_TX_BUFLEN_SHIFT) &
+						 VNIC_TX_BUFLEN_MASK));
+		} else {
+			/* Set NO Interrupt request... */
+			txd->word_1 |=
+			    (VNIC_TX_HANDED_HW_W | VNIC_TX_SOP_W | VNIC_TX_EOP_W
+			     | ((len << VNIC_TX_BUFLEN_SHIFT) &
+				VNIC_TX_BUFLEN_MASK));
+			txq->tx_pkts_til_irq--;
+		}
+	} else {
+		/* Set NO Interrupt request... */
+		txd->word_1 |=
+		    (VNIC_TX_HANDED_HW_W | VNIC_TX_SOP_W | VNIC_TX_EOP_W |
+		     ((len << VNIC_TX_BUFLEN_SHIFT) & VNIC_TX_BUFLEN_MASK));
+	}
+
+	/*
+	 *  Ring bell here, before checking, if vnic_clean_txq() needs to
+	 *  be called.
+	 */
+	vnic_ring_tx_bell(txq);
+
+	idx = VNIC_NEXT_IDX(idx, txq->count);
+	if (idx == txq->next_to_clean) {
+		txq->wraps++;
+		vnic_clean_txq(vnicdev, txq);
+		if (idx == txq->next_to_clean) {
+			txq->full++;
+		}
+	}
+
+	txq->next_to_use = idx;
+}
+
+static inline void init_f7_header(struct sk_buff *skb)
+{
+	struct vioc_f7pf_w *f7p;
+	unsigned char tag;
+
+	/*
+	 * Initialize F7 Header AFTER processing the skb + frags, because we
+	 * need the TOTAL pkt length in the F7 Header.
+	 */
+
+	/* Determine packet tag */
+	if (((struct ethhdr *)skb->mac.raw)->h_proto == ntohs(ETH_P_IP)) {
+		if (skb->ip_summed == CHECKSUM_HW) {
+			switch (skb->nh.iph->protocol) {
+			case IPPROTO_TCP:
+				tag = VIOC_F7PF_ET_ETH_IPV4_CKS;
+				skb->h.th->check = 0;
+				break;
+			case IPPROTO_UDP:
+				tag = VIOC_F7PF_ET_ETH_IPV4_CKS;
+				skb->h.uh->check = 0;
+				break;
+			default:
+				tag = VIOC_F7PF_ET_ETH_IPV4;
+				break;
+			}
+		} else {
+			tag = VIOC_F7PF_ET_ETH_IPV4;
+		}
+	} else {
+		tag = VIOC_F7PF_ET_ETH;
+	}
+
+	f7p = (struct vioc_f7pf_w *)skb->data;
+	memset((void *)skb->data, 0, F7PF_HLEN_STD);
+
+	/* Encapsulation Version */
+	SET_HTON_VIOC_F7PF_ENVER_SHIFTED(f7p, VIOC_F7PF_VERSION1);
+	/* Reserved */
+	SET_HTON_VIOC_F7PF_MC_SHIFTED(f7p, 0);
+	/* No Touch Flag */
+	SET_HTON_VIOC_F7PF_NOTOUCH_SHIFTED(f7p, 0);
+	/* Drop Precedence */
+	SET_HTON_VIOC_F7PF_F7DP_SHIFTED(f7p, 0);
+	/* Class of Service */
+	SET_HTON_VIOC_F7PF_F7COS_SHIFTED(f7p, 2);
+	/* Encapsulation Tag */
+	SET_HTON_VIOC_F7PF_ENTAG_SHIFTED(f7p, tag);
+	/* Key Length */
+	SET_HTON_VIOC_F7PF_EKLEN_SHIFTED(f7p, 1);
+	/* Packet Length */
+	SET_HTON_VIOC_F7PF_PKTLEN_SHIFTED(f7p, skb->len);
+
+	/* lifID */
+	SET_HTON_VIOC_F7PF_LIFID_SHIFTED(f7p, 0);
+}
+
+/**
+ * vioc_tx_timer - Tx Timer
+ * @data: pointer to viocdev cast into an unsigned long
+ **/
+void vioc_tx_timer(unsigned long data)
+{
+	struct vioc_device *viocdev = (struct vioc_device *)data;
+	u32 vnic_idx;
+
+	if (!viocdev->tx_timer_active)
+		return;
+
+	viocdev->vioc_stats.tx_timers++;
+
+	for (vnic_idx = 0; vnic_idx < VIOC_MAX_VNICS; vnic_idx++) {
+		if (viocdev->vnics_map & (1 << vnic_idx)) {
+			vnic_tx_interrupt(viocdev, vnic_idx, 1);
+		}		/* Process VNIC's TX interrupt */
+	}
+	/* Reset the timer */
+	mod_timer(&viocdev->tx_timer, jiffies + HZ / 4);
+}
+
+
+/*
+ * hard_start_xmit() routine.
+ * NOTE WELL: We don't take a read lock on the VIOC, but rely on the
+ * networking subsystem to guarantee we will not be asked to Tx if
+ * the interface is unregistered.  Revisit if this assumption does
+ * not hold - add a tx_enabled flag to the vnic struct protected
+ * by txq->lock.  Or just read-lock the VIOC.
+ */
+int vnic_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	struct txq *txq = &vnicdev->txq;
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	if (!spin_trylock(&txq->lock)) {
+		/* Retry later */
+		local_irq_restore(flags);
+		return NETDEV_TX_LOCKED;
+	}
+
+	if (unlikely(skb_headroom(skb) < F7PF_HLEN_STD)) {
+		vnicdev->vnic_stats.headroom_misses++;
+		if (unlikely(skb_cow(skb, F7PF_HLEN_STD))) {
+			dev_kfree_skb_any(skb);
+			vnicdev->vnic_stats.headroom_miss_drops++;
+			ret = NETDEV_TX_OK;	/* since we freed it */
+			goto end_start_xmit;
+		}
+	}
+
+	/* Don't rely on the skb pointers being set */
+	skb->mac.raw = skb->data;
+	skb->nh.raw = skb->data + ETH_HLEN;
+	skb_push(skb, F7PF_HLEN_STD);
+
+	init_f7_header(skb);
+
+	if (skb_shinfo(skb)->nr_frags)
+		vnic_enqueue_tx_pkt(vnicdev, txq, skb, &vnicdev->viocdev->prov);
+	else
+		vnic_enqueue_tx_buffers(vnicdev, txq, skb,
+					&vnicdev->viocdev->prov);
+
+	/*
+	 * Check if there is room on the queue.
+	 */
+	if (txq->empty < MAX_SKB_FRAGS) {
+		netif_stop_queue(netdev);
+		vnicdev->vnic_stats.netif_stops++;
+		ret = NETDEV_TX_BUSY;
+	} else {
+		ret = NETDEV_TX_OK;
+	}
+
+      end_start_xmit:
+	spin_unlock_irqrestore(&txq->lock, flags);
+	return ret;
+}
+
+/*
+ *      Create Ethernet header 
+ *
+ *      saddr=NULL      means use device source address
+ *      daddr=NULL      means leave destination address (eg unresolved arp)
+ */
+int vnic_eth_header(struct sk_buff *skb, struct net_device *dev,
+		    unsigned short type, void *daddr, void *saddr, unsigned len)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb_push(skb, ETH_HLEN);
+
+	skb->mac.raw = skb->data;
+
+	/*
+	 *      Set the protocol type. For a packet of type
+	 *      ETH_P_802_3 we put the length in here instead. It is
+	 *      up to the 802.2 layer to carry protocol information.
+	 */
+
+	if (type != ETH_P_802_3)
+		eth->h_proto = htons(type);
+	else
+		eth->h_proto = htons(len);
+
+	if (saddr)
+		memcpy(eth->h_source, saddr, ETH_ALEN);
+	else
+		memcpy(eth->h_source, dev->dev_addr, ETH_ALEN);
+
+	if (dev->flags & (IFF_LOOPBACK | IFF_NOARP)) {
+		memset(eth->h_dest, 0, ETH_ALEN);
+		return ETH_HLEN + F7PF_HLEN_STD;
+	}
+
+	if (daddr) {
+		memcpy(eth->h_dest, daddr, ETH_ALEN);
+		return ETH_HLEN + F7PF_HLEN_STD;
+	}
+
+	return -(ETH_HLEN + F7PF_HLEN_STD);	/* XXX */
+}
+
+
+
+/**
+ * vnic_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * Returns 0 on success, negative value on failure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).  At this point all resources needed
+ * for transmit and receive operations are allocated, the interrupt
+ * handler is registered with the OS, the watchdog timer is started,
+ * and the stack is notified that the interface is ready.
+ **/
+
+static int vnic_open(struct net_device *netdev)
+{
+	int ret = 0;
+	struct vnic_device *vnicdev = netdev->priv;
+
+	ret = vioc_set_vnic_cfg(vnicdev->viocdev->viocdev_idx,
+				vnicdev->vnic_id,
+				(VREG_BMC_VNIC_CFG_ENABLE_MASK |
+				 VREG_BMC_VNIC_CFG_PROMISCUOUS_MASK));
+
+	vnic_enable_tx_ring(&vnicdev->txq);
+
+	netif_start_queue(netdev);
+	netif_carrier_on(netdev);
+
+	return ret;
+}
+
+static int vnic_close(struct net_device *netdev)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	struct txq *txq = &vnicdev->txq;
+	unsigned long flags;
+
+	vioc_set_vnic_cfg(vnicdev->viocdev->viocdev_idx, vnicdev->vnic_id, 0);
+
+	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
+
+	spin_lock_irqsave(&txq->lock, flags);
+
+	vnic_reset_txq(vnicdev, txq);
+	vnic_disable_tx_ring(&vnicdev->txq);
+
+	spin_unlock_irqrestore(&txq->lock, flags);
+
+	return 0;
+}
+
+/*
+ * Set netdev->dev_addr to this interface's MAC Address
+ */
+static int vnic_set_mac_addr(struct net_device *netdev, void *p)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+
+	/*
+	 * Get HW MAC address form VIOC egisters
+	 */
+	vioc_get_vnic_mac(vnicdev->viocdev->viocdev_idx, vnicdev->vnic_id,
+			  &vnicdev->hw_mac[0]);
+
+	if (!is_valid_ether_addr(vnicdev->hw_mac)) {
+		dev_err(&vnicdev->viocdev->pdev->dev, "Invalid MAC Address\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * ...and install it in nedev structure
+	 */
+	memcpy(netdev->dev_addr, vnicdev->hw_mac, netdev->addr_len);
+	netdev->addr_len = ETH_ALEN;
+
+	return 0;
+}
+
+/*
+ * Set netdev->mtu to this interface's MTU
+ */
+static int vnic_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	int max_frame = new_mtu + ETH_HLEN + F7PF_HLEN_STD;
+
+	if ((max_frame < VNIC_MIN_MTU) || (max_frame > VNIC_MAX_MTU)) {
+		dev_err(&vnicdev->viocdev->pdev->dev, "Invalid MTU setting\n");
+		return -EINVAL;
+	}
+
+	netdev->mtu = new_mtu;
+	return 0;
+}
+
+/**
+ * vnic_get_stats - Get System Network Statistics
+ * @netdev: network interface device structure
+ *
+ * Returns the address of the device statistics structure.
+ * The statistics are actually updated from the timer callback.
+ **/
+
+static struct net_device_stats *vnic_get_stats(struct net_device *netdev)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	return &vnicdev->net_stats;
+}
+
+static int vnic_alloc_tx_resources(struct vnic_device *vnicdev)
+{
+	struct vioc_device *viocdev = vnicdev->viocdev;
+	struct net_device *netdev = viocdev->vnic_netdev[vnicdev->vnic_id];
+	struct txq *txq;
+	size_t size;
+
+	vnicdev->vnic_stats.tx_on_empty_interrupts = 0;
+
+	txq = &vnicdev->txq;
+
+	txq->txq_id = TXQ0;
+	txq->vnic_id = vnicdev->vnic_id;
+	txq->next_to_use = 0;
+	txq->next_to_clean = 0;
+	txq->empty = txq->count;
+	txq->tx_pkts_til_irq = viocdev->prov.run_param.tx_pkts_per_irq;
+	txq->tx_pkts_til_bell = viocdev->prov.run_param.tx_pkts_per_bell;
+	txq->do_ring_bell = 0;
+	txq->bells = 0;
+	txq->frags = 0;
+	txq->wraps = 0;
+	txq->full = 0;
+
+	size = TX_DESC_SIZE * txq->count;
+	txq->desc = pci_alloc_consistent(viocdev->pdev, size, &txq->dma);
+	if (!txq->desc) {
+		dev_err(&viocdev->pdev->dev, "%sError allocating Tx ring (size %d)\n",
+		       netdev->name, txq->count);
+		return -ENOMEM;
+	}
+
+	txq->vbuf = vmalloc(sizeof(struct vbuf) * txq->count);
+	if (!txq->vbuf) {
+		dev_err(&viocdev->pdev->dev, "%sError allocating Tx resource (size %d)\n",
+		       netdev->name, txq->count);
+		return -ENOMEM;
+	}
+	memset(txq->vbuf, 0, sizeof(struct vbuf) * txq->count);
+
+	txq->va_of_vreg_veng_txd_ctl =
+	    (&viocdev->ba)->virt +
+	    GETRELADDR(VIOC_VENG, vnicdev->vnic_id,
+		       (VREG_VENG_TXD_CTL + (TXQ0 * 0x14)));
+	spin_lock_init(&txq->lock);
+
+	/*
+	 * Tell VIOC where TxQ things are
+	 */
+	vioc_set_txq(viocdev->viocdev_idx, vnicdev->vnic_id, TXQ0,
+		     txq->dma, txq->count);
+	vnic_enable_tx_ring(txq);
+	vioc_ena_dis_tx_on_empty(viocdev->viocdev_idx,
+				 vnicdev->vnic_id,
+				 TXQ0,
+				 viocdev->prov.run_param.tx_intr_on_empty);
+	return 0;
+}
+
+static void vnic_free_tx_resources(struct vnic_device *vnicdev)
+{
+	pci_free_consistent(vnicdev->viocdev->pdev,
+			    vnicdev->txq.count * TX_DESC_SIZE,
+			    vnicdev->txq.desc, vnicdev->txq.dma);
+	vnicdev->txq.desc = NULL;
+	vnicdev->txq.dma = (dma_addr_t) NULL;
+	vfree(vnicdev->txq.vbuf);
+	vnicdev->txq.vbuf = NULL;
+}
+
+void vioc_reset_if_tx(struct net_device *netdev)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	struct txq *txq = &vnicdev->txq;
+
+	vnic_reset_txq(vnicdev, txq);
+}
+
+extern struct ethtool_ops vioc_ethtool_ops;
+
+/**
+ * vnic_uninit - Device Termination Routine
+ *
+ * Returns 0 on success, negative on failure
+ *
+ **/
+static void vnic_uninit(struct net_device *netdev)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	vnic_free_tx_resources(vnicdev);
+}
+
+/**
+ * vnic_init - Device Initialization Routine
+ *
+ * Returns 0 on success, negative on failure
+ *
+ **/
+int vioc_vnic_init(struct net_device *netdev)
+{
+	struct vnic_device *vnicdev = netdev->priv;
+	struct vioc_device *viocdev = vnicdev->viocdev;
+	int ret;
+
+	SET_ETHTOOL_OPS(netdev, &vioc_ethtool_ops);
+	/*
+	 * we're going to reset, so assume we have no link for now
+	 */
+	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
+
+	ether_setup(netdev);
+
+	netdev->hard_header_len = ETH_HLEN + F7PF_HLEN_STD;	/* XXX */
+	netdev->hard_header = &vnic_eth_header;
+	netdev->rebuild_header = NULL;	/* XXX */
+
+	vnic_change_mtu(netdev, 1500);	/* default */
+	vnic_set_mac_addr(netdev, NULL);
+
+	netdev->open = &vnic_open;
+	netdev->stop = &vnic_close;
+	netdev->get_stats = &vnic_get_stats;
+	netdev->uninit = &vnic_uninit;
+	netdev->set_mac_address = &vnic_set_mac_addr;
+	netdev->change_mtu = &vnic_change_mtu;
+	netdev->watchdog_timeo = HZ;
+	if (viocdev->highdma) {
+		netdev->features |= NETIF_F_HIGHDMA;
+	}
+	netdev->features |= NETIF_F_VLAN_CHALLENGED;	/* VLAN locked */
+	netdev->features |= NETIF_F_LLTX;	/* lockless Tx */
+
+	netdev->features |= NETIF_F_IP_CSUM;	/* Tx checksum */
+	dev_err(&viocdev->pdev->dev, "%s: HW IP checksum offload ENABLED\n", 
netdev->name);
+
+	/* allocate Tx descriptors, tell VIOC where */
+	if ((ret = vnic_alloc_tx_resources(vnicdev)))
+		goto vnic_init_err;
+
+	netdev->hard_start_xmit = &vnic_start_xmit;
+	/* Set standard  Rx callback */
+
+	return 0;
+
+      vnic_init_err:
+	dev_err(&viocdev->pdev->dev, "%s: Error initializing vnic resources\n",
+	       netdev->name);
+	return ret;
+}

-- 
Misha Tomushev
misha@fabric7.com


