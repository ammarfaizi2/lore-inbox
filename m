Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWJESXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWJESXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWJESXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:09 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751375AbWJESXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:23:05 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 9/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 11:12:17 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051112.17447.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:43.0672 (UTC) FILETIME=[3FF52580:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. Packet receive code.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/drivers/net/vioc/vioc_receive.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_receive.c
--- linux-2.6.17/drivers/net/vioc/vioc_receive.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_receive.c	2006-10-04 
10:39:10.000000000 -0700
@@ -0,0 +1,365 @@
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include "f7/vnic_hw_registers.h"
+#include "f7/vnic_defs.h"
+
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+
+/*
+ * Receive one packet.  The VIOC is read-locked.  Since RxDQs are
+ * partitioned into independent RxSets and VNICs assigned to exactly
+ * one RxSet, no locking is needed on RxDQs or RxCQs.
+ * Return true if we got a packet, false if the queue is empty.
+ */
+int vioc_rx_pkt(struct vioc_device *viocdev, struct rxc *rxc, u32 sw_idx)
+{
+	u32 rx_status;
+	u32 vnic_id;
+	u32 rxdq_id;
+	u32 rxd_id;
+	u32 pkt_len;
+	u32 dmap_idx;
+	struct sk_buff *in_skb, *out_skb;
+	struct vnic_device *vnicdev;
+	struct rxdq *rxdq;
+	struct rxc_pktDesc_Phys_w *rxcd;
+	struct rx_pktBufDesc_Phys_w *rxd;
+
+	rxcd = &rxc->desc[sw_idx];
+	if (GET_VNIC_RXC_FLAGGED(rxcd) != VNIC_RXC_FLAGGED_HW_W)
+		return 0;	/* ring empty */
+
+	vnic_id = GET_VNIC_RXC_VNIC_ID_SHIFTED(rxcd);
+	rxdq_id = GET_VNIC_RXC_RXQ_ID_SHIFTED(rxcd);
+	rxd_id = GET_VNIC_RXC_IDX_SHIFTED(rxcd);
+	rxdq = viocdev->rxd_p[rxdq_id];
+	rxd = &rxdq->desc[rxd_id];
+
+	in_skb = (struct sk_buff *)rxdq->vbuf[rxd_id].skb;
+	BUG_ON(in_skb == NULL);
+	out_skb = in_skb;	/* default it here */
+
+	/*
+	 * Reset HW FLAG in this RxC Descriptor, marking it as "SW
+	 * acknowledged HW completion".
+	 */
+	CLR_VNIC_RXC_FLAGGED(rxcd);
+
+	if (!(viocdev->vnics_map & (1 << vnic_id)))
+		/* VNIC is not enabled - silently drop packet */
+		goto out;
+
+	in_skb->dev = viocdev->vnic_netdev[vnic_id];
+	vnicdev = in_skb->dev->priv;
+	BUG_ON(vnicdev == NULL);
+
+	rx_status = GET_VNIC_RXC_STATUS(rxcd);
+
+	if (likely(rx_status == VNIC_RXC_STATUS_OK_W)) {
+
+		pkt_len = GET_NTOH_VIOC_F7PF_PKTLEN_SHIFTED(in_skb->data);
+
+		/* Copy out mice packets in ALL rings, even small */
+		if (pkt_len <= VIOC_COPYOUT_THRESHOLD) {
+			out_skb = dev_alloc_skb(pkt_len);
+			if (!out_skb)
+				goto drop;
+			out_skb->dev = in_skb->dev;
+			memcpy(out_skb->data, in_skb->data, pkt_len);
+		}
+
+		vnicdev->net_stats.rx_bytes += pkt_len;
+		vnicdev->net_stats.rx_packets++;
+		/* Set ->len and ->tail to reflect packet size */
+		skb_put(out_skb, pkt_len);
+
+		skb_pull(out_skb, F7PF_HLEN_STD);
+		out_skb->protocol = eth_type_trans(out_skb, out_skb->dev);
+
+		/* Checksum offload */
+		if (GET_VNIC_RXC_ENTAG_SHIFTED(rxcd) ==
+		    VIOC_F7PF_ET_ETH_IPV4_CKS)
+			out_skb->ip_summed = CHECKSUM_UNNECESSARY;
+		else {
+			out_skb->ip_summed = CHECKSUM_HW;
+			out_skb->csum =
+			    ntohs(~GET_VNIC_RXC_CKSUM_SHIFTED(rxcd) & 0xffff);
+		}
+
+		netif_receive_skb(out_skb);
+	} else {
+		vnicdev->net_stats.rx_errors++;
+		if (rx_status & VNIC_RXC_ISBADLENGTH_W)
+			vnicdev->net_stats.rx_length_errors++;
+		if (rx_status & VNIC_RXC_ISBADCRC_W)
+			vnicdev->net_stats.rx_crc_errors++;
+		vnicdev->net_stats.rx_missed_errors++;
+	      drop:
+		vnicdev->net_stats.rx_dropped++;
+	}
+
+      out:
+	CLR_VNIC_RX_OWNED(rxd);
+
+	/* Deallocate only if we did not copy skb above */
+	if (in_skb == out_skb) {
+		pci_unmap_single(viocdev->pdev,
+				 rxdq->vbuf[rxd_id].dma,
+				 rxdq->rx_buf_size, PCI_DMA_FROMDEVICE);
+		rxdq->vbuf[rxd_id].skb = NULL;
+		rxdq->vbuf[rxd_id].dma = (dma_addr_t) NULL;
+	}
+
+	dmap_idx = rxd_id / VIOC_RXD_BATCH_BITS;
+	rxdq->dmap[dmap_idx] &= ~(1 << (rxd_id % VIOC_RXD_BATCH_BITS));
+
+	if (!rxdq->skip_fence_run)
+		vioc_next_fence_run(rxdq);
+	else
+		rxdq->skip_fence_run--;
+
+	return 1;		/* got a packet */
+}
+
+/*
+ * Refill one batch of VIOC_RXD_BATCH_BITS descriptors with skb's as
+ * needed.  Transfer this batch to HW.  Return -1 on success, the
+ * batch id otherwise (which means this batch must be retried.)
+ */
+static u32 _vioc_fill_n_xfer(struct rxdq *rxdq, unsigned batch_idx)
+{
+	unsigned first_idx, idx;
+	int i;
+	struct rx_pktBufDesc_Phys_w *rxd;
+	struct sk_buff *skb;
+	u64 x;
+	unsigned size;
+
+	first_idx = batch_idx * VIOC_RXD_BATCH_BITS;
+	size = rxdq->rx_buf_size;
+	i = VIOC_RXD_BATCH_BITS;
+
+	while (--i >= 0) {
+		idx = first_idx + i;
+		/* Check if that slot is unallocated */
+		if (rxdq->vbuf[idx].skb == NULL) {
+			skb = dev_alloc_skb(size + 64);
+			if (skb == NULL) {
+				goto undo_refill;
+			}
+			/* Cache align */
+			x = (u64) skb->data;
+			skb->data = (unsigned char *)ALIGN(x, 64);
+			rxdq->vbuf[idx].skb = skb;
+			rxdq->vbuf[idx].dma =
+			    pci_map_single(rxdq->viocdev->pdev,
+					   skb->data, size, PCI_DMA_FROMDEVICE);
+		}
+
+		rxd = RXD_PTR(rxdq, idx);
+
+		if (idx == first_idx)
+			/*
+			 * Making sure that all writes to the Rx
+			 * Descriptor Queue where completed before
+			 * turning over up the last (i.e the first)
+			 * descriptor to HW.
+			 */
+			wmb();
+
+		/* Set the address of the Rx buffer and HW FLAG */
+		SET_VNIC_RX_BUFADDR_HW(rxd, rxdq->vbuf[idx].dma);
+	}
+
+	rxdq->dmap[batch_idx] = ALL_BATCH_HW_OWNED;
+	return VIOC_NONE_TO_HW;	/* XXX success */
+
+      undo_refill:
+	/*
+	 * Just turn descriptors over to SW.  Leave skb's allocated,
+	 * they will be used when we retry.  Uses idx!
+	 */
+	for (; idx < (first_idx + VIOC_RXD_BATCH_BITS); idx++) {
+		rxd = RXD_PTR(rxdq, idx);
+		CLR_VNIC_RX_OWNED(rxd);
+	}
+
+	rxdq->starvations++;
+	return batch_idx;	/* failure - retry this batch */
+}
+
+#define IDX_PLUS_DELTA(idx, count, delta) \
+       (((idx) + (delta)) % (count))
+#define IDX_MINUS_DELTA(idx, count, delta) \
+       (((idx) == 0) ? ((count) - (delta)): ((idx) - (delta)))
+
+/*
+ * Returns 0 on success, or a negative errno on failure
+ */
+int vioc_next_fence_run(struct rxdq *rxdq)
+{
+	unsigned dmap_idx, dmap_start, dmap_end, dmap_count;
+	unsigned to_hw = rxdq->to_hw;
+
+	if (to_hw != VIOC_NONE_TO_HW)
+		to_hw = _vioc_fill_n_xfer(rxdq, to_hw);
+	if (to_hw != VIOC_NONE_TO_HW) {
+		/* Problem! Can't refill the Rx queue. */
+		rxdq->to_hw = to_hw;
+		return -ENOMEM;
+	}
+
+	dmap_count = rxdq->dmap_count;
+	dmap_start = rxdq->fence;
+	dmap_end = IDX_MINUS_DELTA(dmap_start, dmap_count, 1);
+	dmap_idx = dmap_start;
+
+	while (rxdq->dmap[dmap_idx] == ALL_BATCH_SW_OWNED) {
+		dmap_idx = IDX_PLUS_DELTA(dmap_idx, dmap_count, 1);
+		if (dmap_idx == dmap_end) {
+			rxdq->run_to_end++;
+			break;
+		}
+	}
+
+	dmap_idx = IDX_MINUS_DELTA(dmap_idx, dmap_count, 1);
+
+	/* If are back at the fence - nothing to do */
+	if (dmap_idx == dmap_start)
+		return 0;
+	/*
+	 * Now dmap_idx points to the "last" batch, that is
+	 * 100% owned by SW, this will become a new fence.
+	 */
+	rxdq->fence = dmap_idx;
+	rxdq->skip_fence_run = dmap_count / 4;
+
+	/*
+	 * Go back up tp dmap_start (old fence) and refill and
+	 * turn over to HW Rx Descriptors
+	 */
+	while (dmap_idx != dmap_start) {
+		dmap_idx = IDX_MINUS_DELTA(dmap_idx, dmap_count, 1);
+		to_hw = _vioc_fill_n_xfer(rxdq, dmap_idx);
+		if (to_hw != VIOC_NONE_TO_HW) {
+			rxdq->to_hw = to_hw;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * NAPI poll method. RxC interrupt for this queue is disabled.
+ * The only lock we need is a read-lock on the VIOC.
+ */
+int vioc_rx_poll(struct net_device *dev, int *budget)
+{
+	struct napi_poll *napi = dev->priv;
+	struct rxc *rxc = napi->rxc;
+	struct vioc_device *viocdev = rxc->viocdev;	/* safe */
+	u32 sw_idx, count;
+	int rxflag = 0;
+	int quota, work_done = 0;
+
+	if (!napi->enabled) {
+		/* If NOT enabled - do nothing.
+		 * ACK by setting stopped.
+		 */
+		napi->stopped = 1;
+		netif_rx_complete(dev);
+		return 0;
+	}
+
+	quota = min(*budget, dev->quota);
+
+	sw_idx = rxc->sw_idx;
+	count = rxc->count;
+	while (work_done <= quota) {
+		rxflag = vioc_rx_pkt(viocdev, rxc, sw_idx);
+		if (unlikely(!rxflag))
+			break;	/* no work left */
+		sw_idx++;
+		if (unlikely(sw_idx == count))
+			sw_idx = 0;
+		work_done++;
+	}
+	rxc->sw_idx = sw_idx;
+	dev->quota -= work_done;
+	*budget -= work_done;
+	if (rxflag)
+		return 1;	/* keep going */
+
+	netif_rx_complete(dev);
+	dev->weight = POLL_WEIGHT;
+
+	vioc_rxc_interrupt_enable(rxc);
+
+	return 0;		/* poll done */
+}
+
+void vioc_rxc_interrupt(void *input_param)
+{
+	unsigned vioc_idx = VIOC_IRQ_PARAM_VIOC_ID(input_param);
+	struct vioc_device *viocdev = vioc_viocdev(vioc_idx);
+	unsigned rxc_id = VIOC_IRQ_PARAM_PARAM_ID(input_param);
+	struct rxc *rxc = viocdev->rxc_p[rxc_id];
+	struct napi_poll *napi = &rxc->napi;
+
+	napi->rx_interrupts++;
+	/* Schedule NAPI poll */
+	if (netif_rx_schedule_prep(&napi->poll_dev)) {
+		vioc_rxc_interrupt_disable(rxc);
+		__netif_rx_schedule(&napi->poll_dev);
+	} else {
+		vioc_rxc_interrupt_clear_pend(rxc);
+	}
+}

-- 
Misha Tomushev
misha@fabric7.com


