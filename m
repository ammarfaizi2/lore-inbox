Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWHIIi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWHIIi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWHIIi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:38:29 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:61778 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030463AbWHIIiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:38:23 -0400
Message-ID: <44D99EFC.3000105@de.ibm.com>
Date: Wed, 09 Aug 2006 10:38:20 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 1/6] ehea: interface to network stack
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


  drivers/net/ehea/ehea_main.c | 2738 +++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 2738 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_main.c	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_main.c	2006-08-08 23:59:39.683357016 -0700
@@ -0,0 +1,2738 @@
+/*
+ *  linux/drivers/net/ehea/ehea_main.c
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Heiko-Joerg Schick <schickhj@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define DEB_PREFIX "main"
+
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/if.h>
+#include <linux/list.h>
+#include <net/ip.h>
+
+#include "ehea.h"
+#include "ehea_qmr.h"
+#include "ehea_phyp.h"
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
+MODULE_DESCRIPTION("IBM eServer HEA Driver");
+MODULE_VERSION(EHEA_DRIVER_VERSION);
+
+static int __devinit ehea_probe(struct ibmebus_dev *dev,
+				const struct of_device_id *id);
+static int __devexit ehea_remove(struct ibmebus_dev *dev);
+static int ehea_sense_port_attr(struct ehea_adapter *adapter, int portnum);
+
+
+int ehea_trace_level = 5;
+
+static struct net_device_stats *ehea_get_stats(struct net_device *dev)
+{
+	int i;
+	u64 hret = H_HARDWARE;
+	u64 rx_packets = 0;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct ehea_adapter *adapter = port->adapter;
+	struct hcp_query_ehea_port_cb_2 *cb2 = NULL;
+	struct net_device_stats *stats = &port->stats;
+
+	EDEB_EN(7, "net_device=%p", dev);
+
+	cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb2) {
+		EDEB_ERR(4, "No memory for cb2");
+		goto get_stat_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB2,
+				      H_PORT_CB2_ALL,
+				      cb2);
+
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_port failed for cb2");
+		goto get_stat_exit;
+	}
+
+	EDEB_DMP(7, (u8*)cb2,
+		 sizeof(struct hcp_query_ehea_port_cb_2), "After HCALL");
+
+	for (i = 0; i < port->num_def_qps; i++) {
+		rx_packets += port->port_res[i].rx_packets;
+	}
+
+	stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
+	stats->multicast = cb2->rxmcp;
+	stats->rx_errors = cb2->rxuerr;
+	stats->rx_bytes = cb2->rxo;
+	stats->tx_bytes = cb2->txo;
+	stats->rx_packets = rx_packets;
+
+get_stat_exit:
+	EDEB_EX(7, "");
+	return stats;
+}
+
+static inline u32 ehea_get_send_lkey(struct ehea_port_res *pr)
+{
+	return pr->send_mr.lkey;
+}
+
+static inline u32 ehea_get_recv_lkey(struct ehea_port_res *pr)
+{
+	return pr->recv_mr.lkey;
+}
+
+#define EHEA_OD_ADDR(address, segment) (((address) & (PAGE_SIZE - 1)) \
+					| ((segment) << 12));
+
+static inline u64 get_swqe_addr(u64 tmp_addr, int addr_seg)
+{
+	u64 addr;
+	addr = tmp_addr;
+	return addr;
+}
+
+static inline u64 get_rwqe_addr(u64 tmp_addr)
+{
+	return tmp_addr;
+}
+
+
+static inline int ehea_refill_rq1(struct ehea_port_res *port_res, int arr_index,
+				  int nr_of_wqes)
+{
+	int i;
+	int ret = 0;
+	struct ehea_qp *qp;
+	int skb_arr_rq1_len = port_res->skb_arr_rq1_len;
+	struct sk_buff **skb_arr_rq1 = port_res->skb_arr_rq1;
+	EDEB_EN(7, "port_res=%p, arr_index=%d, nr_of_wqes=%d, arr_rq1_len=%d",
+		port_res, arr_index, nr_of_wqes, skb_arr_rq1_len);
+
+	qp = port_res->qp;
+	if (unlikely(nr_of_wqes == 0))
+		return -EINVAL;
+	for (i = 0; i < nr_of_wqes; i++) {
+		int index = ((skb_arr_rq1_len + arr_index) - i)
+		    % skb_arr_rq1_len;
+		if (!skb_arr_rq1[index]) {
+			skb_arr_rq1[index] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
+
+			if (!skb_arr_rq1[index]) {
+				EDEB_ERR(4, "No mem for skb/%d wqes filled", i);
+				ret = -ENOMEM;
+				break;
+			}
+		}
+	}
+	/* Ring doorbell */
+	ehea_update_rq1a(qp, nr_of_wqes);
+	EDEB_EX(7, "");
+	return ret;
+}
+
+static int ehea_init_fill_rq1(struct ehea_port_res *port_res, int nr_rq1a)
+{
+	int i;
+	int ret = 0;
+	struct ehea_qp *qp;
+	EDEB_EN(7, "port_res=%p, nr_rq1a=%d", port_res, nr_rq1a);
+	qp = port_res->qp;
+
+	for (i = 0; i < port_res->skb_arr_rq1_len; i++) {
+		port_res->skb_arr_rq1[i] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
+		if (!port_res->skb_arr_rq1[i]) {
+			EDEB_ERR(4, "dev_alloc_skb failed. Only %d skb filled.",
+				 i);
+			ret = -ENOMEM;
+			break;
+		}
+	}
+	/* Ring doorbell */
+	ehea_update_rq1a(qp, nr_rq1a);
+	EDEB_EX(7, "");
+	return ret;
+}
+
+static inline int ehea_refill_rq2_def(struct ehea_port_res *pr, int nr_of_wqes)
+{
+	int i;
+	int ret = 0;
+	struct ehea_qp *qp;
+	struct ehea_rwqe *rwqe;
+	int skb_arr_rq2_len = pr->skb_arr_rq2_len;
+	struct sk_buff **skb_arr_rq2 = pr->skb_arr_rq2;
+
+	EDEB_EN(8, "pr=%p, nr_of_wqes=%d", pr, nr_of_wqes);
+	if (nr_of_wqes == 0)
+		return -EINVAL;
+	qp = pr->qp;
+	for (i = 0; i < nr_of_wqes; i++) {
+		int index = pr->skb_rq2_index++;
+		struct sk_buff *skb = dev_alloc_skb(EHEA_RQ2_PKT_SIZE
+						    + NET_IP_ALIGN);
+
+		if (!skb) {
+			EDEB_ERR(4, "dev_alloc_skb nr %d failed", i);
+			ret = -ENOMEM;
+			break;
+		}
+		skb_reserve(skb, NET_IP_ALIGN);
+		pr->skb_rq2_index %= skb_arr_rq2_len;
+		skb_arr_rq2[index] = skb;
+		rwqe = ehea_get_next_rwqe(qp, 2);
+		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE2_TYPE)
+		            | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
+		rwqe->sg_list[0].l_key = ehea_get_recv_lkey(pr);
+		rwqe->sg_list[0].vaddr = get_rwqe_addr((u64)skb->data);
+		rwqe->sg_list[0].len = EHEA_RQ2_PKT_SIZE;
+		rwqe->data_segments = 1;
+	}
+
+	/* Ring doorbell */
+	iosync();
+	ehea_update_rq2a(qp, i);
+	EDEB_EX(8, "");
+	return ret;
+}
+
+
+static inline int ehea_refill_rq2(struct ehea_port_res *pr, int nr_of_wqes)
+{
+	return ehea_refill_rq2_def(pr, nr_of_wqes);
+}
+
+static inline int ehea_refill_rq3_def(struct ehea_port_res *pr, int nr_of_wqes)
+{
+	int i;
+	int ret = 0;
+	struct ehea_qp *qp;
+	struct ehea_rwqe *rwqe;
+	int skb_arr_rq3_len = pr->skb_arr_rq3_len;
+	struct sk_buff **skb_arr_rq3 = pr->skb_arr_rq3;
+	EDEB_EN(8, "pr=%p, nr_of_wqes=%d", pr, nr_of_wqes);
+	if (nr_of_wqes == 0)
+		return -EINVAL;
+	qp = pr->qp;
+	for (i = 0; i < nr_of_wqes; i++) {
+		int index = pr->skb_rq3_index++;
+		struct sk_buff *skb = dev_alloc_skb(EHEA_MAX_PACKET_SIZE
+						    + NET_IP_ALIGN);
+
+		if (!skb) {
+			EDEB_ERR(4, "No memory for skb. Only %d rwqe filled.",
+				 i);
+			ret = -ENOMEM;
+			break;
+		}
+		skb_reserve(skb, NET_IP_ALIGN);
+
+		rwqe = ehea_get_next_rwqe(qp, 3);
+		pr->skb_rq3_index %= skb_arr_rq3_len;
+		skb_arr_rq3[index] = skb;
+		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE3_TYPE)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
+		rwqe->sg_list[0].l_key = ehea_get_recv_lkey(pr);
+		rwqe->sg_list[0].vaddr = get_rwqe_addr((u64)skb->data);
+		rwqe->sg_list[0].len = EHEA_MAX_PACKET_SIZE;
+		rwqe->data_segments = 1;
+	}
+
+	/* Ring doorbell */
+	iosync();
+	ehea_update_rq3a(qp, i);
+	EDEB_EX(8, "");
+	return ret;
+}
+
+
+static inline int ehea_refill_rq3(struct ehea_port_res *pr, int nr_of_wqes)
+{
+	return ehea_refill_rq3_def(pr, nr_of_wqes);
+}
+
+
+static inline int ehea_check_cqe(struct ehea_cqe *cqe, int *rq_num)
+{
+	*rq_num = (cqe->type & EHEA_CQE_TYPE_RQ) >> 5;
+	EDEB(7, "RQ used=%d, status=%X", *rq_num, cqe->status);
+	if ((cqe->status & EHEA_CQE_STAT_ERR_MASK) == 0)
+		return 0;
+	if (((cqe->status & EHEA_CQE_STAT_ERR_TCP) != 0)
+	    && (cqe->header_length == 0))
+		return 0;
+	else
+		printk("WARNING: Packet discarded. Wrong TCP/UDP chksum"
+		       "and header_length != 0. cqe->status=%X", cqe->status);
+
+	return -EINVAL;
+}
+
+static inline void ehea_fill_skb_ll(struct net_device *dev,
+				    struct sk_buff *skb, struct ehea_cqe *cqe)
+{
+	int length = cqe->num_bytes_transfered - 4;	/*remove CRC */
+	EDEB_EN(7, "dev=%p, skb=%p, cqe=%p", dev, skb, cqe);
+	memcpy(skb->data, ((char*)cqe) + 64, length);
+	skb_put(skb, length);
+	skb->dev = dev;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->protocol = eth_type_trans(skb, dev);
+	EDEB_EX(7, "");
+}
+
+static inline void ehea_fill_skb(struct net_device *dev,
+				 struct sk_buff *skb, struct ehea_cqe *cqe)
+{
+	int length = cqe->num_bytes_transfered - 4;	/*remove CRC */
+	EDEB_EN(7, "dev=%p, skb=%p, cqe=%p", dev, skb, cqe);
+	skb_put(skb, length);
+	skb->dev = dev;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->protocol = eth_type_trans(skb, dev);
+	EDEB_EX(7, "");
+}
+
+
+#define EHEA_MAX_RWQE 1000
+
+static int ehea_poll(struct net_device *dev, int *budget)
+{
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct ehea_port_res *port_res = &port->port_res[0];
+	struct ehea_cqe *cqe;
+	struct ehea_qp *qp = port_res->qp;
+	int wqe_index = 0;
+	int last_wqe_index = 0;
+	int x = 0;
+	int processed = 0;
+	int processed_RQ1 = 0;
+	int processed_RQ2 = 0;
+	int processed_RQ3 = 0;
+	int rq;
+	int intreq;
+	struct sk_buff **skb_arr_rq1 = port_res->skb_arr_rq1;
+	struct sk_buff **skb_arr_rq2 = port_res->skb_arr_rq2;
+	struct sk_buff **skb_arr_rq3 = port_res->skb_arr_rq3;
+	int skb_arr_rq1_len = port_res->skb_arr_rq1_len;
+	int my_quota = min(*budget, dev->quota);
+
+	EDEB_EN(7, "dev=%p, port_res=%p, budget=%d, quota=%d, qp_nr=%x",
+		dev, port_res, *budget, dev->quota,
+		port_res->qp->init_attr.qp_nr);
+	my_quota = min(my_quota, EHEA_MAX_RWQE);
+
+	/* rq0 is low latency RQ */
+	cqe = ehea_poll_rq1(qp, &wqe_index);
+	while ((my_quota > 0) && cqe) {
+		ehea_inc_rq1(qp);
+		processed_RQ1++;
+		processed++;
+		my_quota--;
+
+		EDEB_DMP(6, (u8*)cqe, 4 * 16, "CQE");
+		last_wqe_index = wqe_index;
+		rmb();
+		if (!ehea_check_cqe(cqe, &rq)) {
+			struct sk_buff *skb;
+			if (rq == 1) {	/* LL RQ1 */
+				void *pref;
+
+				x = (wqe_index + 1) % skb_arr_rq1_len;
+				pref = (void*)skb_arr_rq1[x];
+				prefetchw(pref);
+				prefetchw(pref + EHEA_CACHE_LINE);
+
+				x = (wqe_index + 1) % skb_arr_rq1_len;
+				pref = (void*)(skb_arr_rq1[x]->data);
+				prefetchw(pref);
+				prefetchw(pref + EHEA_CACHE_LINE);
+
+				skb = skb_arr_rq1[wqe_index];
+				if (unlikely(!skb)) {
+					EDEB_ERR(4, "LL SBK=NULL, wqe_index=%d",
+						 wqe_index);
+					skb = dev_alloc_skb(EHEA_LL_PKT_SIZE);
+					if (!skb)
+						panic("Alloc SKB failed");
+				}
+				skb_arr_rq1[wqe_index] = NULL;
+				ehea_fill_skb_ll(dev, skb, cqe);
+			} else if (rq == 2) {	/* RQ2 */
+				void *pref;
+				int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+							       cqe->wr_id);
+				x = (skb_index + 1) % port_res->skb_arr_rq2_len;
+				pref = (void*)skb_arr_rq2[x];
+				prefetchw(pref);
+				prefetchw(pref + EHEA_CACHE_LINE);
+
+				x = (skb_index + 1) % port_res->skb_arr_rq2_len;
+				pref = (void*)(skb_arr_rq2[x]->data);
+
+				prefetch(pref);
+				prefetch(pref + EHEA_CACHE_LINE);
+				prefetch(pref + EHEA_CACHE_LINE * 2);
+				prefetch(pref + EHEA_CACHE_LINE * 3);
+				skb = skb_arr_rq2[skb_index];
+
+				if (unlikely(!skb)) {
+					EDEB_ERR(4, "rq2: SKB=NULL, index=%d",
+						 skb_index);
+					break;
+				}
+				skb_arr_rq2[skb_index] = NULL;
+				ehea_fill_skb(dev, skb, cqe);
+				processed_RQ2++;
+			} else {
+				void *pref;
+				int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+							       cqe->wr_id);
+				x = (skb_index + 1) % port_res->skb_arr_rq3_len;
+				pref = (void*)skb_arr_rq3[x];
+				prefetchw(pref);
+				prefetchw(pref + EHEA_CACHE_LINE);
+
+				x = (skb_index + 1) % port_res->skb_arr_rq3_len;
+				pref = (void*)(skb_arr_rq3[x]->data);
+				prefetch(pref);
+				prefetch(pref + EHEA_CACHE_LINE);
+				prefetch(pref + EHEA_CACHE_LINE * 2);
+				prefetch(pref + EHEA_CACHE_LINE * 3);
+
+				skb = skb_arr_rq3[skb_index];
+				if (unlikely(!skb)) {
+					EDEB_ERR(4, "rq3: SKB=NULL, index=%d",
+						 skb_index);
+					break;
+				}
+				skb_arr_rq3[skb_index] = NULL;
+				ehea_fill_skb(dev, skb, cqe);
+				processed_RQ3++;
+			}
+
+			EDEB(6, "About to pass SKB: dev=%p\n"
+			     "skb=%p skb->data=%p skb->len=%d"
+			     " skb->data_len=0x%x nr_frags=%d",
+			     dev,
+			     skb,
+			     skb->data,
+			     skb->len,
+			     skb->data_len, skb_shinfo(skb)->nr_frags);
+			if (cqe->status & EHEA_CQE_VLAN_TAG_XTRACT) {
+				EDEB(7, "VLAN TAG extracted: %4x, vgrp=%p",
+				     cqe->vlan_tag, port->vgrp);
+				EDEB(7, "vlan_devices[vlan_tag]=%p",
+				     port->vgrp->vlan_devices[cqe->vlan_tag]);
+				vlan_hwaccel_receive_skb(skb, port->vgrp,
+							 cqe->vlan_tag);
+			} else {
+				EDEB(7, "netif_receive_skb");
+				netif_receive_skb(skb);
+			}
+			EDEB(7, "SKB passed (netif_receive(skb) called)");
+
+		} else {
+			struct sk_buff *skb;
+
+			EDEB_ERR(4, "cqe->status indicating error: CQE:");
+			EDEB_DMP(4, (u8*)cqe, 4 * 16, "");
+			if (rq == 2) {
+				processed_RQ2++;
+				skb = skb_arr_rq2[
+					EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+							  cqe->wr_id)];
+				skb_arr_rq2[EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+							  cqe->wr_id)] = NULL;
+				dev_kfree_skb(skb);
+			}
+			if (rq == 3) {
+				processed_RQ3++;
+				skb = skb_arr_rq3[
+					EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+								cqe->wr_id)];
+				skb_arr_rq3[EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+							  cqe->wr_id)] = NULL;
+				dev_kfree_skb(skb);
+			}
+		}
+		cqe = ehea_poll_rq1(qp, &wqe_index);
+	}
+
+	dev->quota -= processed;
+	*budget -= processed;
+
+	port_res->p_state.ehea_poll += 1;
+
+	port_res->rx_packets += processed;
+
+	ehea_refill_rq1(port_res, last_wqe_index, processed_RQ1);
+	ehea_refill_rq2(port_res, processed_RQ2);
+	ehea_refill_rq3(port_res, processed_RQ3);
+
+	intreq = ((port_res->p_state.ehea_poll & 0xF) == 0xF);
+
+	EDEB_EX(7, "processed=%d, *budget=%d, dev->quota=%d",
+		processed, *budget, dev->quota);
+
+	if (!cqe || intreq) {
+		netif_rx_complete(dev);
+		ehea_reset_cq_ep(port_res->recv_cq);
+		ehea_reset_cq_n1(port_res->recv_cq);
+		cqe = ipz_qeit_get_valid(&qp->ipz_rqueue1);
+		EDEB(7, "CQE=%p, break ehea_poll while loop", cqe);
+		if (!cqe || intreq)
+			return 0;
+		if (!netif_rx_reschedule(dev, my_quota))
+			return 0;
+	}
+	return 1;
+}
+
+#define MAX_SENDCOMP_QUOTA 400
+void ehea_send_irq_tasklet(unsigned long data)
+{
+	int quota = MAX_SENDCOMP_QUOTA;
+	int skb_index;
+	int cqe_counter = 0;
+	int swqe_av = 0;
+	unsigned long flags;
+	struct sk_buff *skb;
+	struct ehea_cqe *cqe;
+	struct ehea_port_res *port_res = (struct ehea_port_res*)data;
+	struct ehea_cq *send_cq = port_res->send_cq;
+	struct net_device *dev = port_res->port->netdev;
+
+	EDEB_EN(7, "port_res=%p", port_res);
+
+	do {
+		cqe = ehea_poll_cq(send_cq);
+		if (!cqe) {
+			EDEB(7, "No further cqe found");
+			ehea_reset_cq_ep(send_cq);
+			ehea_reset_cq_n1(send_cq);
+			cqe = ehea_poll_cq(send_cq);
+			if (!cqe) {
+				EDEB(7, "No cqe found after having"
+				     " reset N1/EP\n");
+				break;
+			}
+		}
+		cqe_counter++;
+		EDEB(7, "CQE found on Send-CQ:");
+		EDEB_DMP(7, (u8*)cqe, 4 * 16, "");
+		rmb();
+		if (likely(EHEA_BMASK_GET(EHEA_WR_ID_TYPE, cqe->wr_id)
+			   == EHEA_SWQE2_TYPE)) {	/* is swqe format 2 */
+			int i;
+			int index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
+						     cqe->wr_id);
+			for (i = 0; i < EHEA_BMASK_GET(EHEA_WR_ID_REFILL,
+						       cqe->wr_id); i++) {
+
+				skb_index = ((index - i
+					      + port_res->skb_arr_sq_len)
+					     % port_res->skb_arr_sq_len);
+				skb = port_res->skb_arr_sq[skb_index];
+				port_res->skb_arr_sq[skb_index] = NULL;
+
+				if (unlikely(!skb)) {
+					EDEB_ERR(4, "s_irq_tasklet: SKB=NULL "
+						 "WQ_ID=%lX, loop=%d, index=%d",
+						 cqe->wr_id, i, skb_index);
+					break;
+				}
+				dev_kfree_skb(skb);
+			}
+		}
+		swqe_av += EHEA_BMASK_GET(EHEA_WR_ID_REFILL, cqe->wr_id);
+		quota--;
+	} while (quota > 0);
+
+	ehea_update_feca(send_cq, cqe_counter);
+
+	atomic_add(swqe_av, &port_res->swqe_avail);
+	EDEB(7, "port_res->swqe_avail=%d",
+	     atomic_read(&port_res->swqe_avail));
+
+	if (unlikely(netif_queue_stopped(dev))) {
+		spin_lock_irqsave(&port_res->netif_queue, flags);
+		if (unlikely((atomic_read(&port_res->swqe_avail)
+			      >= EHEA_SWQE_REFILL_TH))) {
+			EDEB(7, "port %d swqes_avail >=10 (%d),"
+			     "netif_wake_queue called",
+			     port_res->port->logical_port_id,
+			     atomic_read(&port_res->swqe_avail));
+			netif_wake_queue(port_res->port->netdev);
+		}
+		spin_unlock_irqrestore(&port_res->netif_queue, flags);
+	}
+
+	if (unlikely(cqe))
+		tasklet_hi_schedule(&port_res->send_comp_task);
+
+	EDEB_EX(7, "");
+}
+
+irqreturn_t ehea_send_irq_handler(int irq, void *param, struct pt_regs *regs)
+{
+	struct ehea_port_res *pr = (struct ehea_port_res*)param;
+	EDEB_EN(7, "irq=%d, param=%p, pt_regs=%p", irq, param, regs);
+	tasklet_hi_schedule(&pr->send_comp_task);
+	EDEB_EX(7, "");
+	return IRQ_HANDLED;
+}
+
+irqreturn_t ehea_recv_irq_handler(int irq, void *param, struct pt_regs * regs)
+{
+	struct ehea_port_res *pr = (struct ehea_port_res*)param;
+	struct ehea_port *port = pr->port;
+	EDEB_EN(7, "irq=%d, param=%p, pt_regs=%p", irq, param, regs);
+	netif_rx_schedule(port->netdev);
+	EDEB_EX(7, "");
+	return IRQ_HANDLED;
+}
+
+irqreturn_t ehea_qp_aff_irq_handler(int irq, void *param, struct pt_regs * regs)
+{
+	struct ehea_port *port = (struct ehea_port*)param;
+	struct ehea_eqe *eqe;
+	u32 qp_token;
+
+	EDEB_EN(7, "irq=%d, param=%p, pt_regs=%p", irq, param, regs);
+	eqe = (struct ehea_eqe*)ehea_poll_eq(port->qp_eq);
+	EDEB(7, "eqe=%p", eqe);
+	while (eqe) {
+		EDEB(7, "*eqe=%lx", *(u64*)eqe);
+		eqe = (struct ehea_eqe*)ehea_poll_eq(port->qp_eq);
+		qp_token = EHEA_BMASK_GET(EHEA_EQE_QP_TOKEN, eqe->entry);
+		EDEB(7, "next eqe=%p", eqe);
+	}
+
+	EDEB_EX(7, "");
+	return IRQ_HANDLED;
+}
+
+static struct ehea_port *ehea_get_port(struct ehea_adapter *adapter,
+				       int logical_port)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_ports; i++)
+		if (adapter->port[i]->logical_port_id == logical_port)
+			return adapter->port[i];
+	return NULL;
+}
+
+static void ehea_parse_eqe(struct ehea_adapter *adapter, u64 eqe)
+{
+	int ret = -EINVAL;
+	u8 ec = 0;
+	u8 portnum = 0;
+	struct ehea_port *port = NULL;
+
+	EDEB_EN(7, "eqe=%lx", eqe);
+
+	ec = EHEA_BMASK_GET(NEQE_EVENT_CODE, eqe);
+
+	switch (ec) {
+	case EHEA_EC_PORTSTATE_CHG:	/* port state change */
+		EDEB(7, "Port state change");
+		portnum = EHEA_BMASK_GET(NEQE_PORTNUM, eqe);
+		port = ehea_get_port(adapter, portnum);
+
+		if (!port) {
+			EDEB_ERR(4, "Unknown portnum %x", portnum);
+			break;
+		}
+
+		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
+			if (!netif_carrier_ok(port->netdev)) {
+				ret = ehea_sense_port_attr(adapter, portnum);
+				if (ret) {
+					EDEB_ERR(4, "Failed resensing port");
+					break;
+				}
+
+				printk("%s: Logical port up: %dMbps %s Duplex",
+				       port->netdev->name,
+				       port->port_speed,
+				       port->full_duplex ==
+				       1 ? "Full" : "Half");
+
+				netif_carrier_on(port->netdev);
+				netif_wake_queue(port->netdev);
+			}
+		} else
+			if (netif_carrier_ok(port->netdev)) {
+				printk("%s: Logical port down",
+				       port->netdev->name);
+				netif_carrier_off(port->netdev);
+				netif_stop_queue(port->netdev);
+			}
+
+		if (EHEA_BMASK_GET(NEQE_EXTSWITCH_PORT_UP, eqe))
+			printk("%s: Physical port up", port->netdev->name);
+		else
+			printk("%s: Physical port down", port->netdev->name);
+
+		if (EHEA_BMASK_GET(NEQE_EXTSWITCH_PRIMARY, eqe))
+			printk("Externel switch port is primary port");
+		else
+			printk("Externel switch port is backup port");
+
+		break;
+	case EHEA_EC_ADAPTER_MALFUNC:	/* adapter malfunction */
+		EDEB_ERR(4, "Adapter malfunction");
+		break;
+	case EHEA_EC_PORT_MALFUNC:	/* port malfunction */
+		EDEB_ERR(4, "Port malfunction");
+		/* TODO Determine the port structure of the malfunctioning port
+		 * netif_carrier_off(port->netdev);
+		 * netif_stop_queue(port->netdev);
+		 */
+		break;
+	default:
+		EDEB_ERR(4, "Unknown event code %x", ec);
+		break;
+	}
+
+	EDEB_EX(7, "");
+}
+
+void ehea_neq_tasklet(unsigned long data)
+{
+	struct ehea_adapter *adapter = (struct ehea_adapter*)data;
+	struct ehea_eqe *eqe;
+	u64 event_mask;
+
+	EDEB_EN(7, "");
+	eqe = (struct ehea_eqe*)ehea_poll_eq(adapter->neq);
+	EDEB(7, "eqe=%p", eqe);
+
+	while (eqe) {
+		EDEB(7, "*eqe=%lx", eqe->entry);
+		ehea_parse_eqe(adapter, eqe->entry);
+		eqe = (struct ehea_eqe*)ehea_poll_eq(adapter->neq);
+		EDEB(7, "next eqe=%p", eqe);
+	}
+
+	event_mask = EHEA_BMASK_SET(NELR_PORTSTATE_CHG, 1)
+		   | EHEA_BMASK_SET(NELR_ADAPTER_MALFUNC, 1)
+		   | EHEA_BMASK_SET(NELR_PORT_MALFUNC, 1);
+
+	ehea_h_reset_events(adapter->handle,
+			    adapter->neq->ipz_eq_handle, event_mask);
+	EDEB_EX(7, "");
+}
+
+irqreturn_t ehea_interrupt_neq(int irq, void *param, struct pt_regs *regs)
+{
+	struct ehea_adapter *adapter = (struct ehea_adapter*)param;
+	EDEB_EN(7, "dev_id=%p", adapter);
+	tasklet_hi_schedule(&adapter->neq_tasklet);
+	EDEB_EX(7, "");
+	return IRQ_HANDLED;
+}
+
+
+
+static void ehea_fill_port_res(struct ehea_port_res *pr)
+{
+	struct ehea_qp_init_attr *init_attr = &pr->qp->init_attr;
+
+	/* RQ 1 */
+	ehea_init_fill_rq1(pr, init_attr->act_nr_rwqes_rq1
+			   - init_attr->act_nr_rwqes_rq2
+			   - init_attr->act_nr_rwqes_rq3 - 1);
+
+	/* RQ 2 */
+	ehea_refill_rq2(pr, init_attr->act_nr_rwqes_rq2);
+
+	/* RQ 3 */
+	ehea_refill_rq3(pr, init_attr->act_nr_rwqes_rq3);
+}
+
+static int ehea_reg_interrupts(struct net_device *dev)
+{
+	int ret = -EINVAL;
+	int i;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct ehea_port_res *pr = &port->port_res[0];
+
+	EDEB_EN(7, "");
+	for (i = 0; i < port->num_def_qps; i++) {
+		pr = &port->port_res[i];
+		snprintf(pr->int_recv_name, EHEA_IRQ_NAME_SIZE - 1
+			 , "%s-recv%d", dev->name, i);
+		ret = ibmebus_request_irq(NULL,
+					  pr->recv_eq->attr.ist1,
+					  ehea_recv_irq_handler,
+					  SA_INTERRUPT, pr->int_recv_name, pr);
+		if (ret) {
+			EDEB_ERR(4, "Failed registering irq for ehea_recv_int:"
+				 "port_res_nr:%d, ist=%X", i,
+				 pr->recv_eq->attr.ist1);
+			goto failure;
+		}
+		EDEB(7, "irq_handle 0x%X for function ehea_recv_int %d "
+		     " registered", pr->recv_eq->attr.ist1, i);
+	}
+
+	snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
+		 "%s-aff", dev->name);
+	ret = ibmebus_request_irq(NULL,
+				  port->qp_eq->attr.ist1,
+				  ehea_qp_aff_irq_handler,
+				  SA_INTERRUPT, port->int_aff_name, port);
+	if (ret) {
+		EDEB_ERR(4, "Failed registering irq for qp_aff_irq_handler:"
+			 " ist=%X", port->qp_eq->attr.ist1);
+		goto failure;
+	}
+	EDEB(7, "irq_handle 0x%X for function qp_aff_irq_handler registered",
+	     port->qp_eq->attr.ist1);
+
+	for (i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
+		pr = &port->port_res[i];
+		snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
+			 "%s-send%d", dev->name, i);
+		ret = ibmebus_request_irq(NULL,
+					  pr->send_eq->attr.ist1,
+					  ehea_send_irq_handler,
+					  SA_INTERRUPT, pr->int_send_name,
+					  pr);
+		if (ret) {
+			EDEB_ERR(4, "Registering irq for ehea_send failed"
+				 " port_res_nr:%d, ist=%X", i,
+				 pr->send_eq->attr.ist1);
+			goto failure;
+		}
+		EDEB(7, "irq_handle 0x%X for function ehea_send_int %d"
+		     " registered", pr->send_eq->attr.ist1, i);
+	}
+failure:
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static void ehea_free_interrupts(struct net_device *dev)
+{
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	int i;
+
+	EDEB_EN(7, "");
+	/* send */
+	for (i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
+		ibmebus_free_irq(NULL, port->port_res[i].send_eq->attr.ist1,
+				 &port->port_res[i]);
+		EDEB(7, "free send interrupt for res %d with handle 0x%X",
+		     i, port->port_res[i].send_eq->attr.ist1);
+	}
+
+	/* receive */
+	for (i = 0; i < port->num_def_qps; i++) {
+		ibmebus_free_irq(NULL, port->port_res[i].recv_eq->attr.ist1,
+				 &port->port_res[i]);
+		EDEB(7, "free recv intterupt for res %d with handle 0x%X",
+		     i, port->port_res[i].recv_eq->attr.ist1);
+	}
+	/* associated events */
+	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
+	EDEB(7, "associated event interrupt for handle 0x%X freed",
+	     port->qp_eq->attr.ist1);
+	EDEB_EX(7, "");
+}
+
+static int ehea_configure_port(struct ehea_port *port)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_0 *ehea_port_cb_0 = NULL;
+	u64 mask = 0;
+	int i;
+
+	EDEB_EN(7, "");
+
+	ehea_port_cb_0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+
+	if (!ehea_port_cb_0) {
+		EDEB_ERR(4, "No memory for ehea_port control block");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	ehea_port_cb_0->port_rc = EHEA_BMASK_SET(PXLY_RC_VALID, 1)
+				| EHEA_BMASK_SET(PXLY_RC_IP_CHKSUM, 1)
+				| EHEA_BMASK_SET(PXLY_RC_TCP_UDP_CHKSUM, 1)
+                		| EHEA_BMASK_SET(PXLY_RC_VLAN_XTRACT, 1)
+                		| EHEA_BMASK_SET(PXLY_RC_VLAN_TAG_FILTER,
+				                 PXLY_RC_VLAN_FILTER)
+				| EHEA_BMASK_SET(PXLY_RC_JUMBO_FRAME, 1);
+
+	for (i = 0; i < port->num_def_qps; i++) {
+		ehea_port_cb_0->default_qpn_array[i] =
+		    port->port_res[i].qp->init_attr.qp_nr;
+
+		EDEB(7, "default_qpn_array[%d]=%d",
+		     i, port->port_res[i].qp->init_attr.qp_nr);
+	}
+
+	EDEB(7, "ehea_port_cb_0");
+	EDEB_DMP(7, (u8*)ehea_port_cb_0, sizeof(*ehea_port_cb_0), "");
+
+	mask = EHEA_BMASK_SET(H_PORT_CB0_PRC, 1)
+	       | EHEA_BMASK_SET(H_PORT_CB0_DEFQPNARRAY, 1);
+
+	hret = ehea_h_modify_ehea_port(port->adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB0,
+				       mask,
+				       (void*)ehea_port_cb_0);
+
+	if (hret != H_SUCCESS) {
+		goto modify_ehea_port_failed;
+	}
+
+	ret = 0;
+
+modify_ehea_port_failed:
+	kfree(ehea_port_cb_0);
+
+kzalloc_failed:
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+
+static int ehea_gen_smrs(struct ehea_port_res *pr)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_adapter *adapter = pr->port->adapter;
+	EDEB_EN(7, "ehea_port_res=%p", pr);
+	hret = hipz_h_register_smr(adapter->handle,
+				   adapter->mr.handle,
+				   adapter->mr.vaddr,
+				   EHEA_MR_ACC_CTRL,
+				   adapter->pd,
+				   &pr->send_mr);
+	if (hret != H_SUCCESS)
+		goto ehea_gen_smrs_err1;
+
+	hret = hipz_h_register_smr(adapter->handle,
+				   adapter->mr.handle,
+				   adapter->mr.vaddr,
+				   EHEA_MR_ACC_CTRL,
+				   adapter->pd,
+				   &pr->recv_mr);
+	if (hret != H_SUCCESS)
+		goto ehea_gen_smrs_err2;
+	EDEB_EX(7, "");
+	return 0;
+
+ehea_gen_smrs_err2:
+	hret = ehea_h_free_resource_mr(adapter->handle, pr->send_mr.handle);
+	if (hret != H_SUCCESS)
+		EDEB_ERR(4, "Could not free SMR");
+ehea_gen_smrs_err1:
+	return -EINVAL;
+}
+
+static void ehea_rem_smrs(struct ehea_port_res *pr)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_adapter *adapter = pr->port->adapter;
+	EDEB_EN(7, "ehea_port_res=%p", pr);
+	hret = ehea_h_free_resource_mr(adapter->handle, pr->send_mr.handle);
+	if (hret != H_SUCCESS)
+		EDEB_ERR(4, "Could not free send SMR for pr=%p", pr);
+
+	hret = ehea_h_free_resource_mr(adapter->handle, pr->recv_mr.handle);
+	if (hret != H_SUCCESS)
+		EDEB_ERR(4, "Could not free receive SMR for pr=%p", pr);
+	EDEB_EX(7, "");
+}
+
+static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
+			      struct port_res_cfg *pr_cfg, int queue_token)
+{
+	int ret = -EINVAL;
+	int max_rq_entries = 0;
+	enum ehea_eq_type eq_type = EHEA_EQ;
+	struct ehea_qp_init_attr *init_attr;
+	struct ehea_adapter *adapter = port->adapter;
+
+	EDEB_EN(7, "port=%p, pr=%p", port, pr);
+
+	memset(pr, 0, sizeof(struct ehea_port_res));
+
+	pr->port = port;
+	spin_lock_init(&pr->send_lock);
+	spin_lock_init(&pr->recv_lock);
+	spin_lock_init(&pr->xmit_lock);
+	spin_lock_init(&pr->netif_queue);
+
+	pr->recv_eq = ehea_create_eq(adapter, eq_type,
+				     EHEA_MAX_ENTRIES_EQ, 0);
+	if (!pr->recv_eq) {
+		EDEB_ERR(4, "ehea_create_eq failed (recv_eq)");
+		goto ehea_init_port_res_err1;
+	}
+	pr->send_eq = ehea_create_eq(adapter, eq_type,
+				     EHEA_MAX_ENTRIES_EQ, 0);
+	if (!pr->send_eq) {
+		EDEB_ERR(4, "ehea_create_eq failed (send_eq)");
+		goto ehea_init_port_res_err2;
+	}
+
+	pr->recv_cq = ehea_create_cq(adapter, pr_cfg->max_entries_rcq,
+				     pr->recv_eq->ipz_eq_handle,
+				     port->logical_port_id);
+	if (!pr->recv_cq) {
+		EDEB_ERR(4, "ehea_create_cq failed (cq_recv)");
+		goto ehea_init_port_res_err3;
+	}
+
+	pr->send_cq = ehea_create_cq(adapter, pr_cfg->max_entries_scq,
+				     pr->send_eq->ipz_eq_handle,
+				     port->logical_port_id);
+	if (!pr->send_cq) {
+		EDEB_ERR(4, "ehea_create_cq failed (cq_send)");
+		goto ehea_init_port_res_err4;
+	}
+
+	init_attr = (struct ehea_qp_init_attr*)
+	    kzalloc(sizeof(struct ehea_qp_init_attr), GFP_KERNEL);
+
+	if (!init_attr) {
+		EDEB_ERR(4, "no mem for init_attr struct");
+		ret = -ENOMEM;
+		goto ehea_init_port_res_err5;
+	}
+
+	init_attr->low_lat_rq1 = 1;
+	init_attr->signalingtype = 1;	/* generate CQE if specified in WQE */
+	init_attr->rq_count = 3;
+	init_attr->qp_token = queue_token;
+
+	init_attr->max_nr_send_wqes = pr_cfg->max_entries_sq;
+	init_attr->max_nr_rwqes_rq1 = pr_cfg->max_entries_rq1;
+	init_attr->max_nr_rwqes_rq2 = pr_cfg->max_entries_rq2;
+	init_attr->max_nr_rwqes_rq3 = pr_cfg->max_entries_rq3;
+
+	init_attr->wqe_size_enc_sq = EHEA_SG_SQ;
+	init_attr->wqe_size_enc_rq1 = EHEA_SG_RQ1;
+	init_attr->wqe_size_enc_rq2 = EHEA_SG_RQ2;
+	init_attr->wqe_size_enc_rq3 = EHEA_SG_RQ3;
+
+	init_attr->rq2_threshold = EHEA_RQ2_THRESHOLD;
+	init_attr->rq3_threshold = EHEA_RQ3_THRESHOLD;
+	init_attr->port_nr = port->logical_port_id;
+	init_attr->send_cq_handle = pr->send_cq->ipz_cq_handle;
+	init_attr->recv_cq_handle = pr->recv_cq->ipz_cq_handle;
+	init_attr->aff_eq_handle = port->qp_eq->ipz_eq_handle;
+
+	pr->qp = ehea_create_qp(adapter, adapter->pd, init_attr);
+	if (!pr->qp) {
+		EDEB_ERR(4, "could not create queue pair");
+		goto ehea_init_port_res_err6;
+	}
+
+	/* SQ */
+	max_rq_entries = init_attr->act_nr_send_wqes;
+	pr->skb_arr_sq = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
+						    * (max_rq_entries + 1));
+	if (!pr->skb_arr_sq) {
+		EDEB_ERR(4, "vmalloc for skb_arr_sq failed");
+		goto ehea_init_port_res_err7;
+	}
+	memset(pr->skb_arr_sq, 0, sizeof(void*) * (max_rq_entries + 1));
+	pr->skb_sq_index = 0;
+	pr->skb_arr_sq_len = max_rq_entries + 1;
+
+	/* RQ 1 */
+	max_rq_entries = init_attr->act_nr_rwqes_rq1;
+	pr->skb_arr_rq1 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
+						     * (max_rq_entries + 1));
+	if (!pr->skb_arr_rq1) {
+		EDEB_ERR(4, "vmalloc for skb_arr_rq1 failed");
+		goto ehea_init_port_res_err8;
+	}
+	memset(pr->skb_arr_rq1, 0, sizeof(void*) * (max_rq_entries + 1));
+	pr->skb_arr_rq1_len = max_rq_entries + 1;
+
+	/* RQ 2 */
+	max_rq_entries = init_attr->act_nr_rwqes_rq2;
+	pr->skb_arr_rq2 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
+						     * (max_rq_entries + 1));
+	if (!pr->skb_arr_rq2) {
+		EDEB_ERR(4, "vmalloc for skb_arr_rq2 failed");
+		goto ehea_init_port_res_err9;
+	}
+	memset(pr->skb_arr_rq2, 0, sizeof(void*) * (max_rq_entries + 1));
+	pr->skb_arr_rq2_len = max_rq_entries;
+	pr->skb_rq2_index = 0;
+
+	/* RQ 3 */
+	max_rq_entries = init_attr->act_nr_rwqes_rq3;
+	pr->skb_arr_rq3 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
+						     * (max_rq_entries + 1));
+	if (!pr->skb_arr_rq3) {
+		EDEB_ERR(4, "vmalloc for skb_arr_rq3 failed");
+		goto ehea_init_port_res_err10;
+	}
+	memset(pr->skb_arr_rq3, 0, sizeof(void*) * (max_rq_entries + 1));
+	pr->skb_arr_rq3_len = max_rq_entries;
+	pr->skb_rq3_index = 0;
+
+	if (ehea_gen_smrs(pr) != 0)
+		goto ehea_init_port_res_err11;
+	tasklet_init(&pr->send_comp_task, ehea_send_irq_tasklet,
+		     (unsigned long)pr);
+	atomic_set(&pr->swqe_avail, EHEA_MAX_ENTRIES_SQ - 1);
+
+	kfree(init_attr);
+	ret = 0;
+	goto done;
+
+ehea_init_port_res_err11:
+	vfree(pr->skb_arr_rq3);
+ehea_init_port_res_err10:
+	vfree(pr->skb_arr_rq2);
+ehea_init_port_res_err9:
+	vfree(pr->skb_arr_rq1);
+ehea_init_port_res_err8:
+	vfree(pr->skb_arr_sq);
+ehea_init_port_res_err7:
+	ehea_destroy_qp(pr->qp);
+ehea_init_port_res_err6:
+	kfree(init_attr);
+ehea_init_port_res_err5:
+	ehea_destroy_cq(pr->send_cq);
+ehea_init_port_res_err4:
+	ehea_destroy_cq(pr->recv_cq);
+ehea_init_port_res_err3:
+	ehea_destroy_eq(pr->send_eq);
+ehea_init_port_res_err2:
+	ehea_destroy_eq(pr->recv_eq);
+ehea_init_port_res_err1:
+done:
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static int ehea_clean_port_res(struct ehea_port *port, struct ehea_port_res *pr)
+{
+	int i;
+	int ret = -EINVAL;
+
+	EDEB_EN(7, "Not completed yet...");
+
+	ret = ehea_destroy_qp(pr->qp);
+	if (ret)
+		EDEB_ERR(4, "could not destroy queue pair");
+
+	ret = ehea_destroy_cq(pr->send_cq);
+	if (ret)
+		EDEB_ERR(4, "could not destroy send_cq");
+
+	ret = ehea_destroy_cq(pr->recv_cq);
+	if (ret)
+		EDEB_ERR(4, "could not destroy recv_cq");
+
+	ret = ehea_destroy_eq(pr->send_eq);
+	if (ret)
+		EDEB_ERR(4, "could not destroy send_eq");
+
+	ret = ehea_destroy_eq(pr->recv_eq);
+	if (ret)
+		EDEB_ERR(4, "could not destroy recv_eq");
+
+	for (i = 0; i < pr->skb_arr_rq1_len; i++) {
+		if (pr->skb_arr_rq1[i])
+			dev_kfree_skb(pr->skb_arr_rq1[i]);
+	}
+
+	for (i = 0; i < pr->skb_arr_rq2_len; i++)
+		if (pr->skb_arr_rq2[i])
+			dev_kfree_skb(pr->skb_arr_rq2[i]);
+
+	for (i = 0; i < pr->skb_arr_rq3_len; i++)
+		if (pr->skb_arr_rq3[i])
+			dev_kfree_skb(pr->skb_arr_rq3[i]);
+
+	for (i = 0; i < pr->skb_arr_sq_len; i++)
+		if (pr->skb_arr_sq[i])
+			dev_kfree_skb(pr->skb_arr_sq[i]);
+
+	vfree(pr->skb_arr_sq);
+	vfree(pr->skb_arr_rq1);
+	vfree(pr->skb_arr_rq2);
+	vfree(pr->skb_arr_rq3);
+
+	ehea_rem_smrs(pr);
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static inline void write_ip_start_end(struct ehea_swqe *swqe,
+				      const struct sk_buff *skb)
+{
+
+	swqe->ip_start = (u8)(((u64)skb->nh.iph) - ((u64)skb->data));
+	swqe->ip_end = (u8)(swqe->ip_start + skb->nh.iph->ihl * 4 - 1);
+}
+
+static inline void write_tcp_offset_end(struct ehea_swqe *swqe,
+					const struct sk_buff *skb)
+{
+	swqe->tcp_offset = (u8)(swqe->ip_end + 1 + offsetof(struct tcphdr,
+							    check));
+	swqe->tcp_end = (u16)skb->len - 1;
+}
+
+static inline void write_udp_offset_end(struct ehea_swqe *swqe,
+					const struct sk_buff *skb)
+{
+	swqe->tcp_offset = (u8)(swqe->ip_end + 1 + offsetof(struct udphdr,
+							    check));
+	swqe->tcp_end = (u16)skb->len - 1;
+}
+
+static inline void write_swqe2_data(struct sk_buff *skb,
+				    struct net_device *dev,
+				    struct ehea_swqe *swqe,
+				    u32 lkey)
+{
+	int skb_data_size, nfrags, headersize, i, sg1entry_contains_frag_data;
+	struct ehea_vsgentry *sg_list;
+	struct ehea_vsgentry *sg1entry;
+	struct ehea_vsgentry *sgentry;
+	u8 *imm_data;
+	u64 tmp_addr;
+	skb_frag_t *frag;
+	EDEB_EN(7, "");
+
+	skb_data_size = skb->len - skb->data_len;
+	nfrags = skb_shinfo(skb)->nr_frags;
+	sg1entry = &swqe->u.immdata_desc.sg_entry;
+	sg_list = (struct ehea_vsgentry*)&swqe->u.immdata_desc.sg_list;
+	imm_data = &swqe->u.immdata_desc.immediate_data[0];
+	swqe->descriptors = 0;
+	sg1entry_contains_frag_data = 0;
+
+	if ((dev->features & NETIF_F_TSO) && skb_shinfo(skb)->gso_size) {
+		/* Packet is TCP with TSO enabled */
+		swqe->tx_control |= EHEA_SWQE_TSO;
+		swqe->mss = skb_shinfo(skb)->gso_size;
+		/* copy only eth/ip/tcp headers to immediate data and
+		 * the rest of skb->data to sg1entry
+		 */
+		headersize = ETH_HLEN + (skb->nh.iph->ihl * 4)
+		    + skb->h.th->doff * 4;
+		skb_data_size = skb->len - skb->data_len;
+
+		if (skb_data_size >= headersize) {
+			/* copy immediate data */
+			memcpy(imm_data, skb->data, headersize);
+			swqe->immediate_data_length = headersize;
+
+			if (skb_data_size > headersize) {
+				/* set sg1entry data */
+				sg1entry->l_key = lkey;
+				sg1entry->len = skb_data_size - headersize;
+
+				tmp_addr = (u64)(skb->data + headersize);
+				sg1entry->vaddr =
+					get_swqe_addr(tmp_addr, 0);
+
+				swqe->descriptors++;
+			}
+		} else
+			EDEB_ERR(4, "Cannot handle fragmented headers");
+	} else {
+		/* Packet is any nonTSO type
+		 *
+		 * Copy as much as possible skb->data to immediate data and
+		 * the rest to sg1entry
+		 */
+		if (skb_data_size >= SWQE2_MAX_IMM) {
+			/* copy immediate data */
+			memcpy(imm_data, skb->data, SWQE2_MAX_IMM);
+
+			swqe->immediate_data_length = SWQE2_MAX_IMM;
+
+			if (skb_data_size > SWQE2_MAX_IMM) {
+				/* copy sg1entry data */
+				sg1entry->l_key = lkey;
+				sg1entry->len = skb_data_size - SWQE2_MAX_IMM;
+				tmp_addr = (u64)(skb->data + SWQE2_MAX_IMM);
+				sg1entry->vaddr = get_swqe_addr(tmp_addr, 0);
+				swqe->descriptors++;
+			}
+		} else {
+			memcpy(imm_data, skb->data, skb_data_size);
+			swqe->immediate_data_length = skb_data_size;
+		}
+	}
+
+	/* write descriptors */
+	if (nfrags > 0) {
+		if (swqe->descriptors == 0) {
+			/* sg1entry not yet used */
+			frag = &skb_shinfo(skb)->frags[0];
+
+			/* copy sg1entry data */
+			sg1entry->l_key = lkey;
+			sg1entry->len = frag->size;
+			tmp_addr =  (u64)(page_address(frag->page) +
+					    frag->page_offset);
+			sg1entry->vaddr = get_swqe_addr(tmp_addr,
+							EHEA_MR_TX_DATA_PN);
+			swqe->descriptors++;
+			sg1entry_contains_frag_data = 1;
+		}
+
+		for (i = sg1entry_contains_frag_data; i < nfrags; i++) {
+
+			frag = &skb_shinfo(skb)->frags[i];
+			sgentry = &sg_list[i - sg1entry_contains_frag_data];
+
+			sgentry->l_key = lkey;
+			sgentry->len = frag->size;
+
+			tmp_addr = (u64)(page_address(frag->page)
+					 + frag->page_offset);
+			sgentry->vaddr = get_swqe_addr(tmp_addr,
+						       EHEA_MR_TX_DATA_PN + i);
+		}
+	}
+
+	EDEB_EX(7, "");
+}
+
+static int ehea_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	EDEB_ERR(4, "ioctl not supported: dev=%s cmd=%d", dev->name, cmd);
+	return -EOPNOTSUPP;
+}
+
+static u64 ehea_broadcast_reg_helper(struct ehea_port *port, u32 hcallid)
+{
+	u64 hret = H_HARDWARE;
+	u8 reg_type = 0;
+
+	if (hcallid == H_REG_BCMC) {
+		EDEB(7, "REGistering MAC for broadcast");
+	} else {
+		EDEB(7, "DEREGistering MAC for broadcast");
+	}
+
+	/* De/Register untagged packets */
+	reg_type = EHEA_BCMC_BROADCAST | EHEA_BCMC_UNTAGGED;
+	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
+				     port->logical_port_id,
+				     reg_type, port->mac_addr, 0, hcallid);
+	if (hret != H_SUCCESS)
+		goto hcall_failed;
+
+	/* De/Register VLAN packets */
+	reg_type = EHEA_BCMC_BROADCAST | EHEA_BCMC_VLANID_ALL;
+	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
+				     port->logical_port_id,
+				     reg_type, port->mac_addr, 0, hcallid);
+hcall_failed:
+	return hret;
+}
+
+static int ehea_set_mac_addr(struct net_device *dev, void *sa)
+{
+	int ret = -EOPNOTSUPP;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_0 *ehea_port_cb_0 = NULL;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct sockaddr *mac_addr = (struct sockaddr*)sa;
+
+	EDEB_EN(7, "devname=%s", dev->name);
+	EDEB_DMP(7, (u8*)&(mac_addr->sa_data[0]), 14, "");
+
+	if (!is_valid_ether_addr(mac_addr->sa_data)) {
+		ret = -EADDRNOTAVAIL;
+		goto invalid_mac;
+	}
+
+	ehea_port_cb_0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+
+	if (!ehea_port_cb_0) {
+		EDEB_ERR(4, "No memory for ehea_port control block");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	memcpy((u8*)(&(ehea_port_cb_0->port_mac_addr)),
+	       (u8*)&(mac_addr->sa_data[0]), 6);
+
+	ehea_port_cb_0->port_mac_addr = ehea_port_cb_0->port_mac_addr >> 16;
+
+	EDEB(7, "ehea_port_cb_0");
+	EDEB_DMP(7, (u8*)ehea_port_cb_0,
+		 sizeof(struct hcp_query_ehea_port_cb_0), "");
+
+	hret = ehea_h_modify_ehea_port(port->adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB0,
+				       EHEA_BMASK_SET(H_PORT_CB0_MAC, 1),
+				       (void*)ehea_port_cb_0);
+	if (hret != H_SUCCESS) {
+		ret = -EOPNOTSUPP;
+		goto hcall_failed;
+	}
+
+	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
+
+	/* Deregister old MAC in PHYP */
+	hret = ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+	if (hret) {
+		ret = -EOPNOTSUPP;
+		goto hcall_failed;
+	}
+
+	port->mac_addr = ehea_port_cb_0->port_mac_addr << 16;
+
+	/* Register new MAC in PHYP */
+	hret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
+	if (hret) {
+		ret = -EOPNOTSUPP;
+		goto hcall_failed;
+	}
+
+	ret = 0;
+
+hcall_failed:
+	kfree(ehea_port_cb_0);
+
+kzalloc_failed:
+invalid_mac:
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static void ehea_promiscuous(struct net_device *dev, int enable)
+{
+	struct ehea_port *port = dev->priv;
+
+	if (!port->promisc) {
+		if (enable) {
+			/* Enable promiscuous mode */
+			EDEB(7, "Enabling IFF_PROMISC");
+			EDEB_ERR(4, "Enable promiscuous mode: "
+				 "not yet implemented");
+			port->promisc = EHEA_ENABLE;
+		}
+	} else {
+		if (!enable) {
+			/* Disable promiscuous mode */
+			EDEB(7, "Disabling IFF_PROMISC");
+			EDEB_ERR(4, "Disable promiscuous mode: "
+				 "not yet implemented");
+			port->promisc = EHEA_DISABLE;
+		}
+	}
+}
+
+static u64 ehea_multicast_reg_helper(struct ehea_port *port,
+				     u64 mc_mac_addr,
+				     u32 hcallid)
+{
+	u64 hret = H_HARDWARE;
+	u8 reg_type = 0;
+
+	reg_type = EHEA_BCMC_SCOPE_ALL | EHEA_BCMC_MULTICAST
+		 | EHEA_BCMC_UNTAGGED;
+
+	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
+				     port->logical_port_id,
+				     reg_type, mc_mac_addr, 0, hcallid);
+	if (hret)
+		goto hcall_failed;
+
+	reg_type = EHEA_BCMC_SCOPE_ALL | EHEA_BCMC_MULTICAST
+		 | EHEA_BCMC_VLANID_ALL;
+
+	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
+				     port->logical_port_id,
+				     reg_type, mc_mac_addr, 0, hcallid);
+hcall_failed:
+	return hret;
+}
+
+static int ehea_drop_multicast_list(struct net_device *dev)
+{
+	int ret = 0;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = dev->priv;
+	struct ehea_mc_list *mc_entry = port->mc_list;
+	struct list_head *pos;
+	struct list_head *temp;
+
+	EDEB_EN(7, "devname=%s", dev->name);
+
+	if (!list_empty(&mc_entry->list)) {
+		list_for_each_safe(pos, temp, &(port->mc_list->list)) {
+			mc_entry = list_entry(pos, struct ehea_mc_list, list);
+
+			EDEB(7, "Deregistering MAC %lx", mc_entry->macaddr);
+
+			hret = ehea_multicast_reg_helper(port,
+							 mc_entry->macaddr,
+							 H_DEREG_BCMC);
+			if (hret) {
+				EDEB_ERR(4, "Failed deregistering mcast MAC");
+				ret = -EINVAL;
+			}
+
+			list_del(pos);
+			kfree(mc_entry);
+		}
+	}
+
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static void ehea_allmulti(struct net_device *dev, int enable)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = dev->priv;
+
+	if (!port->allmulti) {
+		if (enable) {
+			/* Enable ALLMULTI */
+			EDEB(7, "Enabling IFF_ALLMULTI");
+			ehea_drop_multicast_list(dev);
+			hret = ehea_multicast_reg_helper(port, 0, H_REG_BCMC);
+			if (!hret)
+				port->allmulti = EHEA_ENABLE;
+			else
+				EDEB_ERR(4, "Enabling IFF_ALLMULTI failed!");
+		}
+	} else
+		if (!enable) {
+			/* Disable ALLMULTI */
+			EDEB(7, "Disabling IFF_ALLMULTI");
+			hret = ehea_multicast_reg_helper(port, 0, H_DEREG_BCMC);
+			if (!hret)
+				port->allmulti = EHEA_DISABLE;
+			else
+				EDEB_ERR(4, "Disabling IFF_ALLMULTI failed!");
+		}
+}
+
+static void ehea_add_multicast_entry(struct ehea_port* port, u8* mc_mac_addr)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_mc_list *ehea_mcl_entry;
+
+	EDEB_EN(7, "port=%p", port);
+	EDEB_DMP(7, mc_mac_addr, MAX_ADDR_LEN, "dmi_addr");
+
+	ehea_mcl_entry =
+	    (struct ehea_mc_list*)kzalloc(sizeof(struct ehea_mc_list),
+					   GFP_KERNEL);
+	if (!ehea_mcl_entry) {
+		EDEB_ERR(4, "Out of memory");
+		return;
+	}
+
+	INIT_LIST_HEAD(&ehea_mcl_entry->list);
+
+	memcpy((u8*)&ehea_mcl_entry->macaddr, mc_mac_addr, ETH_ALEN);
+
+	hret = ehea_multicast_reg_helper(port, ehea_mcl_entry->macaddr,
+					 H_REG_BCMC);
+	if (!hret)
+		list_add(&ehea_mcl_entry->list, &port->mc_list->list);
+	else {
+		EDEB_ERR(4, "Failed registering mcast MAC");
+		kfree(ehea_mcl_entry);
+	}
+
+	EDEB_EX(7, "");
+}
+
+static void ehea_set_multicast_list(struct net_device *dev)
+{
+	int ret;
+	int i;
+	struct ehea_port *port = dev->priv;
+	struct dev_mc_list *k_mcl_entry;
+
+	EDEB_EN(7, "devname=%s, mc_count=%d", dev->name, dev->mc_count);
+
+	if (dev->flags & IFF_PROMISC) {
+		ehea_promiscuous(dev, EHEA_ENABLE);
+		return;
+	}
+	ehea_promiscuous(dev, EHEA_DISABLE);
+
+	if (dev->flags & IFF_ALLMULTI) {
+		ehea_allmulti(dev, EHEA_ENABLE);
+		return;
+	}
+	ehea_allmulti(dev, EHEA_DISABLE);
+
+	EDEB(7, "Set individual multicast list");
+	if (dev->mc_count) {
+		ret = ehea_drop_multicast_list(dev);
+		if (ret) {
+			/* Dropping the current multicast list failed.
+			 * Enabling ALL_MULTI is the best we can do.
+			 */
+			ehea_allmulti(dev, EHEA_ENABLE);
+		}
+
+		if (dev->mc_count > port->adapter->max_mc_mac) {
+			EDEB_ERR(4, "Mcast registration limit reached "
+				 "(0x%lx). Use ALLMULTI!",
+				 port->adapter->max_mc_mac);
+			goto escape;
+		}
+
+		for (i = 0, k_mcl_entry = dev->mc_list;
+		     i < dev->mc_count;
+		     i++, k_mcl_entry = k_mcl_entry->next) {
+			ehea_add_multicast_entry(port,
+						 k_mcl_entry->dmi_addr);
+		}
+	}
+
+escape:
+	EDEB_EX(7, "");
+	return;
+}
+
+static int ehea_change_mtu(struct net_device *dev, int new_mtu)
+{
+	if ((new_mtu < 68) || (new_mtu > EHEA_MAX_PACKET_SIZE))
+		return -EINVAL;
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static inline void ehea_xmit2(struct sk_buff *skb,
+			      struct net_device *dev, struct ehea_swqe *swqe,
+			      u32 lkey)
+{
+	int nfrags;
+	unsigned short skb_protocol = skb->protocol;
+	nfrags = skb_shinfo(skb)->nr_frags;
+	EDEB_EN(7, "skb->nfrags=%d (0x%X)", nfrags, nfrags);
+
+	if (skb_protocol == ETH_P_IP) {
+		/* IPv4 */
+		swqe->tx_control |= EHEA_SWQE_CRC
+				 | EHEA_SWQE_IP_CHECKSUM
+				 | EHEA_SWQE_TCP_CHECKSUM
+				 | EHEA_SWQE_IMM_DATA_PRESENT
+				 | EHEA_SWQE_DESCRIPTORS_PRESENT;
+
+		write_ip_start_end(swqe, skb);
+
+		if (skb->nh.iph->protocol == IPPROTO_UDP) {
+			if ((skb->nh.iph->frag_off & IP_MF)
+			    || (skb->nh.iph->frag_off & IP_OFFSET))
+				/* IP fragment, so don't change cs */
+				swqe->tx_control &= ~EHEA_SWQE_TCP_CHECKSUM;
+			else
+				write_udp_offset_end(swqe, skb);
+
+		} else if (skb->nh.iph->protocol == IPPROTO_TCP) {
+			write_tcp_offset_end(swqe, skb);
+		}
+
+		/* icmp (big data) and ip segmentation packets (all other ip
+		   packets) do not require any special handling */
+
+	} else {
+		/* Other Ethernet Protocol */
+		swqe->tx_control |= EHEA_SWQE_CRC
+				 | EHEA_SWQE_IMM_DATA_PRESENT
+				 | EHEA_SWQE_DESCRIPTORS_PRESENT;
+	}
+
+	write_swqe2_data(skb, dev, swqe, lkey);
+
+	EDEB_EX(7, "");
+}
+
+static inline void ehea_xmit3(struct sk_buff *skb,
+			      struct net_device *dev, struct ehea_swqe *swqe)
+{
+	int i;
+	skb_frag_t *frag;
+	int nfrags = skb_shinfo(skb)->nr_frags;
+	u8 *imm_data = &swqe->u.immdata_nodesc.immediate_data[0];
+	u64 skb_protocol = skb->protocol;
+
+	EDEB_EN(7, "");
+	if (likely(skb_protocol == ETH_P_IP)) {
+		/* IPv4 */
+		write_ip_start_end(swqe, skb);
+
+		if (skb->nh.iph->protocol == IPPROTO_TCP) {
+			swqe->tx_control |= EHEA_SWQE_CRC
+					 | EHEA_SWQE_IP_CHECKSUM
+					 | EHEA_SWQE_TCP_CHECKSUM
+					 | EHEA_SWQE_IMM_DATA_PRESENT;
+
+			write_tcp_offset_end(swqe, skb);
+
+		} else if (skb->nh.iph->protocol == IPPROTO_UDP) {
+			if ((skb->nh.iph->frag_off & IP_MF)
+			    || (skb->nh.iph->frag_off & IP_OFFSET))
+				/* IP fragment, so don't change cs */
+				swqe->tx_control |= EHEA_SWQE_CRC
+						 | EHEA_SWQE_IMM_DATA_PRESENT;
+			else {
+				swqe->tx_control |= EHEA_SWQE_CRC
+						 | EHEA_SWQE_IP_CHECKSUM
+						 | EHEA_SWQE_TCP_CHECKSUM
+						 | EHEA_SWQE_IMM_DATA_PRESENT;
+				write_udp_offset_end(swqe, skb);
+			}
+		} else {
+			/* icmp (big data) and
+			   ip segmentation packets (all other ip packets) */
+			swqe->tx_control |= EHEA_SWQE_CRC
+					 | EHEA_SWQE_IP_CHECKSUM
+					 | EHEA_SWQE_IMM_DATA_PRESENT;
+		}
+	} else {
+		/* Other Ethernet Protocol */
+		swqe->tx_control |= EHEA_SWQE_CRC | EHEA_SWQE_IMM_DATA_PRESENT;
+	}
+	/* copy (immediate) data */
+	if (nfrags == 0) {
+		/* data is in a single piece */
+		memcpy(imm_data, skb->data, skb->len);
+	} else {
+		/* first copy data from the skb->data buffer ... */
+		memcpy(imm_data, skb->data, skb->len - skb->data_len);
+		imm_data += skb->len - skb->data_len;
+
+		/* ... then copy data from the fragments */
+		for (i = 0; i < nfrags; i++) {
+			frag = &skb_shinfo(skb)->frags[i];
+			memcpy(imm_data,
+			       page_address(frag->page) + frag->page_offset,
+			       frag->size);
+			imm_data += frag->size;
+		}
+	}
+	swqe->immediate_data_length = skb->len;
+	dev_kfree_skb(skb);
+
+	EDEB_EX(7, "");
+}
+
+static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned long flags;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct ehea_port_res *pr;
+	struct ehea_swqe *swqe;
+	u32 lkey;
+	int swqe_index;
+	EDEB_EN(7, "");
+
+	pr = &port->port_res[0];
+
+	EDEB(6, "MACaddr=0x%X, dev=%p\n"
+	     "PAGE_SIZE=%d MAX_SKB_FRAGS=%d"
+	     "skb=%p skb->data=%p skb->len=%d skb->data_len=0x%x nr_frags=%d",
+	     *(u32*)port->netdev->dev_addr, dev,
+	     (int)PAGE_SIZE,
+	     (int)MAX_SKB_FRAGS,
+	     skb,
+	     skb->data, skb->len, skb->data_len, skb_shinfo(skb)->nr_frags);
+
+
+	if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
+		spin_lock_irqsave(&pr->netif_queue, flags);
+		if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
+			EDEB(7, "netif_stop_queue to be called");
+			netif_stop_queue(dev);
+			spin_unlock_irqrestore(&pr->netif_queue, flags);
+			return NETDEV_TX_BUSY;
+		}
+		spin_unlock_irqrestore(&pr->netif_queue, flags);
+	}
+	atomic_dec(&pr->swqe_avail);
+
+
+	EDEB_DMP(7, (u8*)skb->data, (skb->len - skb->data_len), "SKB_DATA");
+
+	spin_lock(&pr->xmit_lock);
+
+	swqe = ehea_get_swqe(pr->qp, &swqe_index);
+	EDEB(7, "Posting SWQE on QP wit qp_nr=%X\n",
+	     pr->qp->init_attr.qp_nr);
+
+	memset(swqe, 0, 32);
+
+	if (skb->len <= SWQE3_MAX_IMM) {
+		u32 swqe_num = pr->swqe_id_counter;
+		ehea_xmit3(skb, dev, swqe);
+		swqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_REFILL, EHEA_SIG_IV)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_SWQE3_TYPE)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_COUNT, swqe_num);
+		if (pr->swqe_ll_count >= (EHEA_SIG_IV - 1)) {
+			swqe->tx_control |= EHEA_SWQE_SIGNALLED_COMPLETION;
+			pr->swqe_ll_count = 0;
+		} else
+			pr->swqe_ll_count += 1;
+		/* only for debugging purpose */
+		EDEB_DMP(6, (u8*)swqe, 128, "swqe format 3");
+
+	} else {
+		swqe->wr_id =
+		    EHEA_BMASK_SET(EHEA_WR_ID_REFILL, EHEA_SIG_IV_LONG)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_SWQE2_TYPE)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_COUNT, pr->swqe_id_counter)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, pr->skb_sq_index);
+		pr->skb_arr_sq[pr->skb_sq_index] = skb;
+		pr->skb_sq_index = (pr->skb_sq_index + 1) % pr->skb_arr_sq_len;
+
+		lkey = ehea_get_send_lkey(pr);
+		ehea_xmit2(skb, dev, swqe, lkey);
+
+		if (pr->swqe_count >= (EHEA_SIG_IV_LONG - 1)) {
+			swqe->tx_control |= EHEA_SWQE_SIGNALLED_COMPLETION;
+			pr->swqe_count = 0;
+		} else
+			pr->swqe_count += 1;
+		/* only for debugging purpose */
+		EDEB_DMP(6, (u8*)swqe, 256, "swqe format 2");
+	}
+	pr->swqe_id_counter += 1;
+
+	if (port->vgrp && vlan_tx_tag_present(skb)) {
+		EDEB(7, "VLAN TAG included");
+		swqe->tx_control |= EHEA_SWQE_VLAN_INSERT;
+		swqe->vlan_tag = vlan_tx_tag_get(skb);
+	}
+	ehea_post_swqe(pr->qp, swqe);
+	pr->tx_packets++;
+
+	spin_unlock(&pr->xmit_lock);
+
+	EDEB_EX(7, "");
+	return NETDEV_TX_OK;
+}
+
+static void ehea_vlan_rx_register(struct net_device *dev,
+				  struct vlan_group *grp)
+{
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
+	struct ehea_port *port =  (struct ehea_port*)dev->priv;
+	struct ehea_adapter *adapter = port->adapter;
+
+	EDEB_EN(7, "net_device=%p port=%p adapter=%p", dev, port, adapter);
+
+	port->vgrp = grp;
+
+	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb1) {
+		EDEB_ERR(4, "No memory for cb1");
+		goto vlan_reg_exit;
+	}
+
+	if (grp)
+		memset(cb1->vlan_filter, 0, sizeof(cb1->vlan_filter));
+	else
+		memset(cb1->vlan_filter, 1, sizeof(cb1->vlan_filter));
+
+	hret = ehea_h_modify_ehea_port(adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB1,
+				       H_PORT_CB1_ALL,
+				       cb1);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_port failed for cb3");
+	}
+	kfree(cb1);
+
+vlan_reg_exit:
+	EDEB_EN(7, "dev=%p, vlan_group=%p", dev, grp);
+}
+
+static void ehea_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
+{
+	int index;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
+	struct ehea_adapter *adapter = port->adapter;
+	EDEB_EN(7, "dev=%p, vlan_id=%d", dev, vid);
+
+	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb1) {
+		EDEB_ERR(4, "No memory for cb1");
+		goto vlan_kill_exit;
+	}
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB1,
+				       H_PORT_CB1_ALL,
+				       cb1);
+
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_port failed for cb1");
+		goto vlan_kill_exit;
+	}
+
+	index = (vid / 64);
+	cb1->vlan_filter[index] |= ((u64)(1 << (vid & 0x3F)));
+
+	hret = ehea_h_modify_ehea_port(adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB1,
+				       H_PORT_CB1_ALL,
+				       cb1);
+	if (hret != H_SUCCESS)
+		EDEB_ERR(4, "modify_ehea_port failed for cb3");
+
+	kfree(cb1);
+
+vlan_kill_exit:
+	EDEB_EX(7, "");
+
+}
+
+static void ehea_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
+{
+	int index;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	struct ehea_adapter *adapter = port->adapter;
+	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
+	EDEB_EN(7, "dev=%p, vlan_id=%d", dev, vid);
+	if (port->vgrp)
+		port->vgrp->vlan_devices[vid] = NULL;
+
+	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb1) {
+		EDEB_ERR(4, "No memory for cb1");
+		goto vlan_kill_exit;
+	}
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB1,
+				       H_PORT_CB1_ALL,
+				       cb1);
+
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_port failed for cb1");
+		goto vlan_kill_exit;
+	}
+
+	index = (vid / 64);
+	cb1->vlan_filter[index] &= ~((u64)(1 << (vid & 0x3F)));
+
+	hret = ehea_h_modify_ehea_port(adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB1,
+				       H_PORT_CB1_ALL,
+				       cb1);
+	if (hret != H_SUCCESS)
+		EDEB_ERR(4, "modify_ehea_port failed for cb3");
+	kfree(cb1);
+
+vlan_kill_exit:
+	EDEB_EX(7, "");
+}
+
+int ehea_stop_qp(struct ehea_adapter *adapter, struct ehea_qp *qp)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	u16 dummy16;
+	u64 dummy64;
+	struct hcp_modify_qp_cb_0 *cb0 = NULL;
+
+	EDEB_EN(7, "qp=%p", qp);
+
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+
+	if (!cb0) {
+		EDEB_ERR(4, "No memory for modify_qp control block");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	/* Reset queue pair */
+	cb0->qp_ctl_reg = H_QP_CR_ENABLED | H_QP_CR_STATE_RESET;
+	hret = ehea_h_modify_ehea_qp(adapter->handle,
+				     0,
+				     qp->ipz_qp_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1),
+				     cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "Failed resetting the queue pair");
+		goto modify_qp_failed;
+	}
+
+	/* Disable queue pair */
+	cb0->qp_ctl_reg = H_QP_CR_STATE_RESET;
+	hret = ehea_h_modify_ehea_qp(adapter->handle,
+				     0,
+				     qp->ipz_qp_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1),
+				     cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "Failed disabling the queue pair");
+		goto modify_qp_failed;
+	}
+
+	ret = 0;
+
+modify_qp_failed:
+	kfree(cb0);
+
+kzalloc_failed:
+	return ret;
+}
+
+int ehea_activate_qp(struct ehea_adapter *adapter, struct ehea_qp *qp)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	u16 dummy16 = 0;
+	u64 dummy64 = 0;
+	struct hcp_modify_qp_cb_0* cb0 = NULL;
+
+	EDEB_EN(7, "qp=%p", qp);
+
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb0) {
+		EDEB_ERR(4, "No mem to allocate control block");
+		ret = -ENOMEM;
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle,
+				    0, qp->ipz_qp_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_qp failed (1)\n");
+		goto failure;
+	}
+
+	cb0->qp_ctl_reg = H_QP_CR_STATE_INITIALIZED;
+	hret = ehea_h_modify_ehea_qp(adapter->handle,
+				     0, qp->ipz_qp_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "modify_ehea_qp failed (1)\n");
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle,
+				    0, qp->ipz_qp_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_qp failed (2)\n");
+		goto failure;
+	}
+
+	cb0->qp_ctl_reg = H_QP_CR_ENABLED | H_QP_CR_STATE_INITIALIZED;
+	hret = ehea_h_modify_ehea_qp(adapter->handle,
+				     0, qp->ipz_qp_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "modify_ehea_qp failed (2)\n");
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle,
+				    0, qp->ipz_qp_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_qp failed (3)\n");
+		goto failure;
+	}
+
+	cb0->qp_ctl_reg = H_QP_CR_ENABLED | H_QP_CR_STATE_RDY2SND;
+	hret = ehea_h_modify_ehea_qp(adapter->handle,
+				     0, qp->ipz_qp_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "modify_ehea_qp failed (3)\n");
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle,
+				    0, qp->ipz_qp_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		EDEB_ERR(4, "query_ehea_qp failed (4)\n");
+		goto failure;
+	}
+
+	ret = 0;
+
+failure:
+	kfree(cb0);
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static int ehea_port_res_setup(struct ehea_port *port, int def_qps,
+			       int add_tx_qps)
+{
+	int i, k;
+	int ret;
+	struct port_res_cfg pr_cfg, pr_cfg_small_rx;
+	enum ehea_eq_type eq_type = EHEA_EQ;
+
+	EDEB_EN(7, "");
+
+	port->qp_eq = ehea_create_eq(port->adapter, eq_type,
+				   EHEA_MAX_ENTRIES_EQ, 1);
+	if (!port->qp_eq) {
+		EDEB_ERR(4, "ehea_create_eq failed (qp_eq)");
+		goto port_res_setup_failed2;
+	}
+
+	pr_cfg.max_entries_rcq = EHEA_MAX_CQE_COUNT;
+	pr_cfg.max_entries_scq = EHEA_MAX_CQE_COUNT;
+	pr_cfg.max_entries_sq = EHEA_MAX_ENTRIES_SQ;
+	pr_cfg.max_entries_rq1 = EHEA_MAX_ENTRIES_RQ1;
+	pr_cfg.max_entries_rq2 = EHEA_MAX_ENTRIES_RQ2;
+	pr_cfg.max_entries_rq3 = EHEA_MAX_ENTRIES_RQ3;
+
+	pr_cfg_small_rx.max_entries_rcq = 1;
+	pr_cfg_small_rx.max_entries_scq = EHEA_MAX_CQE_COUNT;
+	pr_cfg_small_rx.max_entries_sq = EHEA_MAX_ENTRIES_SQ;
+	pr_cfg_small_rx.max_entries_rq1 = 1;
+	pr_cfg_small_rx.max_entries_rq2 = 1;
+	pr_cfg_small_rx.max_entries_rq3 = 1;
+
+
+	for (i = 0; i < def_qps; i++) {
+		ret = ehea_init_port_res(port, &port->port_res[i],
+					 &pr_cfg, i);
+		if (ret)
+			goto port_res_setup_failed;
+	}
+	for (i = def_qps; i < def_qps + add_tx_qps; i++) {
+		ret = ehea_init_port_res(port, &port->port_res[i],
+					 &pr_cfg_small_rx, i);
+		if (ret)
+			goto port_res_setup_failed;
+	}
+	EDEB_EX(7, "");
+	return 0;
+
+port_res_setup_failed:
+	for(k = 0; k < i; k++) {
+		ehea_clean_port_res(port, &port->port_res[k]);
+	}
+port_res_setup_failed2:
+	ret = ehea_destroy_eq(port->qp_eq);
+	if (ret)
+		EDEB_ERR(4, "could not destroy qp_eq");
+
+	EDEB_EX(7, "");
+	return -EINVAL;
+}
+
+void ehea_clean_all_port_res(struct ehea_port *port)
+{
+	int ret;
+	int i;
+	for(i = 0; i < port->num_def_qps + port->num_tx_qps; i++)
+		ehea_clean_port_res(port, &port->port_res[i]);
+
+	ret = ehea_destroy_eq(port->qp_eq);
+	if (ret)
+		EDEB_ERR(4, "could not destroy qp_eq");
+}
+
+int ehea_open(struct net_device *dev)
+{
+	u64 hret = H_HARDWARE;
+	int i;
+	int ret = -EIO;
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+	u64 mac_addr = 0;
+
+	EDEB_EN(7, "logical_port_id=%d", port->logical_port_id);
+
+	ret = ehea_port_res_setup(port, port->num_def_qps, port->num_tx_qps);
+
+	if (ret)
+		goto port_res_setup_failed;
+
+	/* Set default QP for this port */
+	ret = ehea_configure_port(port);
+	if (ret) {
+		EDEB_ERR(4, "ehea_configure_port failed");
+		goto reg_failed;
+	}
+
+	hret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
+	if (hret) {
+		ret = -EIO;
+		goto reg_failed;
+	}
+	mac_addr = (*(u64*)dev->dev_addr) >> 16;
+
+	ret = ehea_reg_interrupts(dev);
+	if (ret)
+		goto irq_reg_failed;
+
+	for(i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
+		ret = ehea_activate_qp(port->adapter, port->port_res[i].qp);
+		if (ret)
+			goto activate_qp_failed;
+	}
+
+	for(i = 0; i < port->num_def_qps + port->num_tx_qps; i++)
+		ehea_fill_port_res(&port->port_res[i]);
+
+	netif_start_queue(dev);
+	ret = 0;
+	goto done;
+
+activate_qp_failed:
+	ehea_free_interrupts(dev);
+
+irq_reg_failed:
+	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+
+reg_failed:
+	ehea_clean_all_port_res(port);
+
+port_res_setup_failed:
+done:
+	EDEB_EX(7, "ret=%d", ret);
+	return ret;
+}
+
+static int ehea_stop(struct net_device *dev)
+{
+	struct ehea_port *port = (struct ehea_port*)dev->priv;
+
+	EDEB_EN(7, "");
+	netif_stop_queue(dev);
+	ehea_drop_multicast_list(dev);
+	ehea_stop_qp(port->adapter, port->port_res[0].qp);
+	ehea_free_interrupts(dev);
+
+	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+	ehea_clean_all_port_res(port);
+
+	EDEB_EX(7, "");
+	return 0;
+}
+
+static struct of_device_id ehea_device_table[] = {
+	{
+	 .name = "lhea",
+	 .compatible = "IBM,lhea",
+	 },
+	{},
+};
+
+static struct ibmebus_driver ehea_driver = {
+	.name = "ehea",
+	.id_table = ehea_device_table,
+	.probe = ehea_probe,
+	.remove = ehea_remove,
+};
+
+int ehea_sense_adapter_attr(struct ehea_adapter *adapter)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea *query_ehea_cb = NULL;
+
+	EDEB_EN(7, "");
+
+	query_ehea_cb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+
+	if (!query_ehea_cb) {
+		EDEB_ERR(4, "No memory for query_ehea control block");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	hret = ehea_h_query_ehea(adapter->handle, query_ehea_cb);
+	if (hret != H_SUCCESS) {
+		goto query_ehea_failed;
+	}
+
+	adapter->num_ports = query_ehea_cb->num_ports;
+	adapter->max_mc_mac = query_ehea_cb->max_mc_mac - 1;
+
+	ret = 0;
+
+query_ehea_failed:
+	kfree(query_ehea_cb);
+
+kzalloc_failed:
+	EDEB_EX(7, "ret=%d, num_ports=%d, max_mc_mac=0x%lx",
+		ret, adapter->num_ports, adapter->max_mc_mac);
+	return ret;
+}
+
+static int ehea_sense_port_attr(struct ehea_adapter *adapter, int portnum)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = adapter->port[portnum];
+	struct hcp_query_ehea_port_cb_0 *query_ehea_port_cb_0 = NULL;
+
+	EDEB_EN(7, "adapter=%p, portnum=%d", adapter, portnum);
+
+	/* allocate memory for control block */
+	query_ehea_port_cb_0 =
+	    kzalloc(sizeof(*query_ehea_port_cb_0), GFP_KERNEL);
+
+	if (!query_ehea_port_cb_0) {
+		EDEB_ERR(4, "No memory for query_ehea_port control block");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				      adapter->port[portnum]->logical_port_id,
+				      H_PORT_CB0,
+				      EHEA_BMASK_SET(H_PORT_CB0_ALL, 0xFFFF),
+				      query_ehea_port_cb_0);
+
+	if (hret != H_SUCCESS) {
+		ret = -EPERM;
+		goto query_ehea_port_failed;
+	}
+
+	EDEB_DMP(7, (u8 *) query_ehea_port_cb_0,
+		 sizeof(struct hcp_query_ehea_port_cb_0), "After HCALL");
+
+
+	/* MAC address */
+	port->mac_addr = query_ehea_port_cb_0->port_mac_addr << 16;
+
+	/* Port speed */
+	switch (query_ehea_port_cb_0->port_speed) {
+	case H_PORT_SPEED_10M_H:
+		port->port_speed = EHEA_SPEED_10M;
+		port->full_duplex = 0;
+		break;
+	case H_PORT_SPEED_10M_F:
+		port->port_speed = EHEA_SPEED_10M;
+		port->full_duplex = 1;
+		break;
+	case H_PORT_SPEED_100M_H:
+		port->port_speed = EHEA_SPEED_100M;
+		port->full_duplex = 0;
+		break;
+	case H_PORT_SPEED_100M_F:
+		port->port_speed = EHEA_SPEED_100M;
+		port->full_duplex = 1;
+		break;
+	case H_PORT_SPEED_1G_F:
+		port->port_speed = EHEA_SPEED_1G;
+		port->full_duplex = 1;
+		break;
+	case H_PORT_SPEED_10G_F:
+		port->port_speed = EHEA_SPEED_10G;
+		port->full_duplex = 1;
+		break;
+	default:
+		port->port_speed = 0;
+		port->full_duplex = 0;
+		break;
+	}
+
+	/* Number of default QPs */
+	port->num_def_qps = query_ehea_port_cb_0->num_default_qps;
+	if (port->num_def_qps >= EHEA_NUM_TX_QP)
+		port->num_tx_qps = 0;
+	else
+		port->num_tx_qps = EHEA_NUM_TX_QP - port->num_def_qps;
+
+	EDEB(7, "MAC address=0x%lX", adapter->port[portnum]->mac_addr >> 16);
+
+	ret = 0;
+
+query_ehea_port_failed:
+	kfree(query_ehea_port_cb_0);
+
+kzalloc_failed:
+	EDEB_EX(7,"MACaddr=0x%lX, portspeed=%dMbps, fullduplex=%d, "
+		  "num_def_qps=%d",
+		port->mac_addr >> 16,
+		port->port_speed, port->full_duplex, port->num_def_qps);
+	return ret;
+}
+
+static int ehea_setup_single_port(struct ehea_adapter *adapter,
+				  int portnum, struct device_node *dn)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = NULL;
+	struct net_device *dev = NULL;
+	struct hcp_query_ehea_port_cb_4 *cb4;
+	u32 *dn_log_port_id = NULL;
+
+	EDEB_EN(7, "Initializing port #%d. adapter=%p", portnum, adapter);
+
+	port = adapter->port[portnum];
+
+	if (!dn) {
+		EDEB_ERR(4, "Bad device node: dn=%p", dn);
+		goto done;
+	}
+
+	port->of_dev_node = dn;
+
+	/* Determine logical port id */
+	dn_log_port_id = (u32*)get_property(dn, "ibm,hea-port-no", NULL);
+
+	if (!dn_log_port_id) {
+		EDEB_ERR(4, "Bad device node: dn_log_port_id=%p",
+			 dn_log_port_id);
+		goto done;
+	}
+	port->logical_port_id = *dn_log_port_id;
+	port->adapter = adapter;
+	port->mc_list =
+	    (struct ehea_mc_list*)kzalloc(sizeof(struct ehea_mc_list),
+					   GFP_KERNEL);
+	if (!port->mc_list) {
+		EDEB_ERR(4, "No memory for multicast list");
+		goto done;
+	}
+
+	INIT_LIST_HEAD(&port->mc_list->list);
+
+	ret = ehea_sense_port_attr(adapter, portnum);
+	if (ret)
+		goto done;
+
+	/* initialize net_device structure */
+	dev = alloc_etherdev(sizeof(struct ehea_port));
+
+	if (!dev) {
+		EDEB_ERR(4, "No memory for net_device");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb4) {
+		EDEB_ERR(4, "No memory for cb4");
+	} else {
+		cb4->jumbo_frame = 1;
+		hret = ehea_h_modify_ehea_port(adapter->handle,
+					       port->logical_port_id,
+					       H_PORT_CB4,
+					       H_PORT_CB4_JUMBO,
+					       (void*)cb4);
+		if (hret != H_SUCCESS)
+			EDEB_ERR(4, "Jumbo frames not activated");
+	}
+
+	SET_MODULE_OWNER(dev);
+
+	memcpy(dev->dev_addr, &port->mac_addr, ETH_ALEN);
+
+	dev->open = ehea_open;
+	dev->poll = ehea_poll;
+	dev->weight = 64;
+	dev->stop = ehea_stop;
+	dev->hard_start_xmit = ehea_start_xmit;
+	dev->get_stats = ehea_get_stats;
+	dev->set_multicast_list = ehea_set_multicast_list;
+	dev->do_ioctl = ehea_ioctl;
+	dev->set_mac_address = ehea_set_mac_addr;
+	dev->change_mtu = ehea_change_mtu;
+	dev->priv = port;
+
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO
+		      | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_TX
+		      | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
+		      | NETIF_F_LLTX;
+
+	dev->vlan_rx_register = ehea_vlan_rx_register;
+	dev->vlan_rx_add_vid = ehea_vlan_rx_add_vid;
+	dev->vlan_rx_kill_vid = ehea_vlan_rx_kill_vid;
+
+	ehea_set_ethtool_ops(dev);
+
+	ret = register_netdev(dev);
+	if (ret) {
+		EDEB_ERR(4, "register_netdev failed. ret=%d", ret);
+		goto reg_netdev_failed;
+	}
+
+	port->netdev = dev;
+
+	ret = 0;
+
+	goto done;
+
+reg_netdev_failed:
+	free_netdev(port->netdev);
+	kfree(port->mc_list);
+
+done:
+	EDEB_EX(7, "logical port id=0x%x", port->logical_port_id);
+	return ret;
+}
+
+static int ehea_setup_ports(struct ehea_adapter *adapter)
+{
+	int ret = -EINVAL;
+	int i;
+	int port_setup_ok = 0;
+	struct ehea_port *port = NULL;
+	struct device_node *dn = NULL;
+
+	EDEB_EX(7, "");
+
+	/* get port properties for all ports */
+	for (i = 0; i < adapter->num_ports; i++) {
+
+		if (adapter->port[i])
+			continue;	/* port already up and running */
+
+		/* allocate memory for the port structures */
+		port = kzalloc(sizeof(struct ehea_port), GFP_KERNEL);
+
+		if (!port) {
+			EDEB_ERR(4, "No memory for ehea_port");
+			break;	/* continuing not reasonable */
+		}
+
+		adapter->port[i] = port;
+		dn = of_find_node_by_name(dn, "ethernet");
+		ret = ehea_setup_single_port(adapter, i, dn);
+
+		if (ret) {
+			/* Free mem for this port struct. the others will be
+			   processed on rollback */
+			kfree(port);
+			adapter->port[i] = NULL;
+		}
+	}
+
+	of_node_put(dn);
+
+	/* Check for succesfully set up ports */
+	for (i = 0; i < adapter->num_ports; i++)
+		if (adapter->port[i])
+			port_setup_ok++;
+
+	if (port_setup_ok > 0)
+		ret = 0;	/* At least some ports are setup correctly */
+
+	EDEB_EX(7, "");
+	return ret;
+}
+
+static int __devinit ehea_probe(struct ibmebus_dev *dev,
+				const struct of_device_id *id)
+{
+	int ret = -EINVAL;
+	struct ehea_adapter *adapter = NULL;
+	u64 *adapter_handle = NULL;
+
+	EDEB_EN(7, "ibmebus_dev=%p, of_device_id=%p", dev, id);
+
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+
+	if (!adapter) {
+		EDEB_ERR(4, "No memory for ehea_adapter");
+		ret = -ENOMEM;
+		goto kzalloc_adapter_failed;
+	}
+
+
+	adapter_handle = (u64*)get_property(dev->ofdev.node, "ibm,hea-handle",
+					    NULL);
+
+	if (!adapter_handle) {
+		EDEB_ERR(4, "Failed getting handle for adapter '%s'",
+			 dev->ofdev.node->full_name);
+		ret = -ENODEV;
+		goto get_property_failed;
+	}
+
+	adapter->handle = *adapter_handle;
+	adapter->pd = EHEA_PD_ID;
+
+	dev->ofdev.dev.driver_data = adapter;
+
+	ret = ehea_reg_mr_adapter(adapter);
+	if (ret)
+		goto register_mr_failed;
+
+	/* initialize adapter and ports */
+	/* get adapter properties */
+	ret = ehea_sense_adapter_attr(adapter);
+	if (ret)
+		goto sense_adapter_failed;
+
+	adapter->neq = ehea_create_eq(adapter,
+				      EHEA_NEQ, EHEA_MAX_ENTRIES_EQ, 1);
+	if (!adapter->neq)
+		goto create_neq_failed;
+
+	tasklet_init(&adapter->neq_tasklet, ehea_neq_tasklet,
+		     (unsigned long)adapter);
+
+	ret = ibmebus_request_irq(NULL, adapter->neq->attr.ist1,
+				ehea_interrupt_neq, SA_INTERRUPT, "ehea_neq",
+				(void*)adapter);
+	if (ret)
+		goto request_irq_failed;
+
+	ret = ehea_setup_ports(adapter);
+	if (ret)
+		goto setup_ports_failed;
+
+	ret = 0;
+	goto done;
+
+setup_ports_failed:
+request_irq_failed:
+	ehea_destroy_eq(adapter->neq);
+create_neq_failed:
+sense_adapter_failed:
+	ehea_dereg_mr_adapter(adapter);
+register_mr_failed:
+get_property_failed:
+	kfree(adapter);
+kzalloc_adapter_failed:
+done:
+	EDEB_EX(7, "");
+	return ret;
+}
+
+int __init ehea_module_init(void)
+{
+	int ret = -EINVAL;
+
+	EDEB_EN(7, "");
+
+	printk(KERN_INFO "%s Ethernet Device Driver (Release %s)\n",
+	       EHEA_DRIVER_NAME,
+	       EHEA_DRIVER_VERSION);
+
+
+	ret = ibmebus_register_driver(&ehea_driver);
+	if (ret) {
+		EDEB_ERR(4, "Failed registering eHEA device driver on ebus");
+		return -EINVAL;
+	}
+
+	EDEB_EX(7, "");
+	return 0;
+}
+
+static void ehea_shutdown_single_port(struct ehea_adapter *adapter, int portnum)
+{
+	struct ehea_port *port = adapter->port[portnum];
+
+	EDEB_EN(7, "");
+
+	if (port) {
+		EDEB(7, "Shutting down port #%d.", portnum);
+		unregister_netdev(port->netdev);
+		free_netdev(port->netdev);
+		kfree(port->mc_list);
+		kfree(port);
+		adapter->port[portnum] = NULL;
+	} else
+		EDEB(7, "Port #%d not setup. Doing nothing.", portnum);
+
+	EDEB_EX(7, "");
+}
+
+static int __devexit ehea_remove(struct ibmebus_dev *dev)
+{
+	int ret = -EINVAL;
+	struct ehea_adapter *adapter = dev->ofdev.dev.driver_data;
+	int i;
+
+	EDEB_EN(7, "ibmebus_dev=%p", dev);
+
+	for (i = 0; i < adapter->num_ports; i++)
+		ehea_shutdown_single_port(adapter, i);
+
+	ibmebus_free_irq(NULL, adapter->neq->attr.ist1, adapter);
+
+	ehea_destroy_eq(adapter->neq);
+
+	ret = ehea_dereg_mr_adapter(adapter);
+	if (ret)
+		goto deregister_mr_failed;
+	kfree(adapter);
+	ret = 0;
+
+deregister_mr_failed:
+	EDEB_EX(7, "");
+	return ret;
+}
+
+static void __exit ehea_module_exit(void)
+{
+	EDEB_EN(7, "");
+
+	ibmebus_unregister_driver(&ehea_driver);
+	EDEB_EX(7, "");
+}
+
+module_init(ehea_module_init);
+module_exit(ehea_module_exit);


