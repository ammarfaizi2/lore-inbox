Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWHRMIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHRMIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWHRMIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:08:37 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:53656 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932134AbWHRMId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:08:33 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Fri, 18 Aug 2006 13:29:01 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608181329.02042.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/ehea/ehea_main.c | 2480 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2480 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_main.c	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_main.c	2006-08-18 00:01:02.147117523 -0700
@@ -0,0 +1,2480 @@
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
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/if.h>
+#include <linux/list.h>
+#include <linux/if_ether.h>
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
+MODULE_VERSION(DRV_VERSION);
+
+
+static int msg_level = -1;
+module_param(msg_level, int, 0);
+MODULE_PARM_DESC(msg_level, "msg_level");
+
+
+static struct net_device_stats *ehea_get_stats(struct net_device *dev)
+{
+	int i;
+	u64 hret = H_HARDWARE;
+	u64 rx_packets = 0;
+	struct ehea_port *port = netdev_priv(dev);
+	struct hcp_query_ehea_port_cb_2 *cb2 = NULL;
+	struct net_device_stats *stats = &port->stats;
+
+	cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb2) {
+		ehea_error("no mem for cb2");
+		goto get_stat_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(port->adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB2,
+				      H_PORT_CB2_ALL,
+				      cb2);
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_port failed");
+		goto get_stat_exit2;
+	}
+
+	if (netif_msg_hw(port))
+		ehea_dump(cb2, sizeof(*cb2), "net_device_stats");
+
+	for (i = 0; i < port->num_def_qps; i++)
+		rx_packets += port->port_res[i].rx_packets;
+
+	stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
+	stats->multicast = cb2->rxmcp;
+	stats->rx_errors = cb2->rxuerr;
+	stats->rx_bytes = cb2->rxo;
+	stats->tx_bytes = cb2->txo;
+	stats->rx_packets = rx_packets;
+get_stat_exit2:
+        kfree(cb2);
+get_stat_exit:
+	return stats;
+}
+
+
+static inline int ehea_refill_rq1(struct ehea_port_res *pr, int index,
+				  int nr_of_wqes)
+{
+	int i;
+	int ret = 0;
+	struct sk_buff **skb_arr_rq1 = pr->skb_arr_rq1;
+	int max_index_mask = pr->skb_arr_rq1_len - 1;
+
+	if (!nr_of_wqes)
+		return 0;
+
+	for (i = 0; i < nr_of_wqes; i++) {
+		if (!skb_arr_rq1[index]) {
+			skb_arr_rq1[index] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
+
+			if (!skb_arr_rq1[index]) {
+				ehea_error("no mem for skb/%d wqes filled", i);
+				ret = -ENOMEM;
+				break;
+			}
+		}
+		index--;
+		index &= max_index_mask;
+	}
+	/* Ring doorbell */
+	ehea_update_rq1a(pr->qp, i);
+
+	return ret;
+}
+
+static int ehea_init_fill_rq1(struct ehea_port_res *pr, int nr_rq1a)
+{
+	int i;
+	int ret = 0;
+	struct sk_buff **skb_arr_rq1 = pr->skb_arr_rq1;
+
+	for (i = 0; i < pr->skb_arr_rq1_len; i++) {
+		skb_arr_rq1[i] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
+		if (!skb_arr_rq1[i]) {
+			ehea_error("no mem for skb/%d skbs filled.", i);
+			ret = -ENOMEM;
+			goto nomem;
+		}
+	}
+	/* Ring doorbell */
+	ehea_update_rq1a(pr->qp, nr_rq1a);
+nomem:
+	return ret;
+}
+
+static inline int ehea_refill_rq2_def(struct ehea_port_res *pr, int nr_of_wqes)
+{
+	int i;
+	int ret = 0;
+	struct ehea_qp *qp;
+	struct ehea_rwqe *rwqe;
+	struct sk_buff **skb_arr_rq2 = pr->skb_arr_rq2;
+	int index, max_index_mask;
+
+	if (!nr_of_wqes)
+		return 0;
+
+	qp = pr->qp;
+
+	index = pr->skb_rq2_index;
+	max_index_mask = pr->skb_arr_rq2_len - 1;
+	for (i = 0; i < nr_of_wqes; i++) {
+		struct sk_buff *skb = dev_alloc_skb(EHEA_RQ2_PKT_SIZE
+						    + NET_IP_ALIGN);
+		if (!skb) {
+			ehea_error("no mem for skb/%d wqes filled", i);
+			ret = -ENOMEM;
+			break;
+		}
+		skb_reserve(skb, NET_IP_ALIGN);
+
+		skb_arr_rq2[index] = skb;
+
+		rwqe = ehea_get_next_rwqe(qp, 2);
+		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE2_TYPE)
+		            | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
+		rwqe->sg_list[0].l_key = pr->recv_mr.lkey;
+		rwqe->sg_list[0].vaddr = (u64)skb->data;
+		rwqe->sg_list[0].len = EHEA_RQ2_PKT_SIZE;
+		rwqe->data_segments = 1;
+
+		index++;
+		index &= max_index_mask;
+	}
+	pr->skb_rq2_index = index;
+
+	/* Ring doorbell */
+	iosync();
+	ehea_update_rq2a(qp, i);
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
+	struct ehea_qp *qp = pr->qp;
+	struct ehea_rwqe *rwqe;
+	int skb_arr_rq3_len = pr->skb_arr_rq3_len;
+	struct sk_buff **skb_arr_rq3 = pr->skb_arr_rq3;
+	int index, max_index_mask;
+
+	if (nr_of_wqes == 0)
+		return -EINVAL;
+        
+	index = pr->skb_rq3_index;
+	max_index_mask = skb_arr_rq3_len - 1;
+	for (i = 0; i < nr_of_wqes; i++) {
+		struct sk_buff *skb = dev_alloc_skb(EHEA_MAX_PACKET_SIZE
+						    + NET_IP_ALIGN);
+		if (!skb) {
+			ehea_error("no mem for skb/%d wqes filled", i);
+			ret = -ENOMEM;
+			break;
+		}
+		skb_reserve(skb, NET_IP_ALIGN);
+
+		rwqe = ehea_get_next_rwqe(qp, 3);
+
+		skb_arr_rq3[index] = skb;
+
+		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE3_TYPE)
+			    | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
+		rwqe->sg_list[0].l_key = pr->recv_mr.lkey;
+		rwqe->sg_list[0].vaddr = (u64)skb->data;
+		rwqe->sg_list[0].len = EHEA_MAX_PACKET_SIZE;
+		rwqe->data_segments = 1;
+
+		index++;
+		index &= max_index_mask;
+	}
+	pr->skb_rq3_index = index;
+
+	/* Ring doorbell */
+	iosync();
+	ehea_update_rq3a(qp, i);
+	return ret;
+}
+
+
+static inline int ehea_refill_rq3(struct ehea_port_res *pr, int nr_of_wqes)
+{
+	return ehea_refill_rq3_def(pr, nr_of_wqes);
+}
+
+static inline int ehea_check_cqe(struct ehea_cqe *cqe, int *rq_num)
+{
+	*rq_num = (cqe->type & EHEA_CQE_TYPE_RQ) >> 5;
+	if ((cqe->status & EHEA_CQE_STAT_ERR_MASK) == 0)
+		return 0;
+	if (((cqe->status & EHEA_CQE_STAT_ERR_TCP) != 0)
+	    && (cqe->header_length == 0))
+		return 0;
+	return -EINVAL;
+}
+
+static inline void ehea_fill_skb(struct net_device *dev,
+				 struct sk_buff *skb, struct ehea_cqe *cqe)
+{
+	int length = cqe->num_bytes_transfered - 4;	/*remove CRC */
+	skb_put(skb, length);
+	skb->dev = dev;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->protocol = eth_type_trans(skb, dev);
+}
+
+
+
+static inline struct sk_buff *get_skb_by_index(struct sk_buff **skb_array,
+					       int arr_len,
+					       struct ehea_cqe *cqe)
+{
+	struct sk_buff *skb;
+	void *pref;
+	int x;
+	int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX, cqe->wr_id);
+
+	x = skb_index + 1;
+	x &= (arr_len - 1);
+
+	pref = (void*)skb_array[x];
+	prefetchw(pref);
+	prefetchw(pref + EHEA_CACHE_LINE);
+
+	pref = (void*)(skb_array[x]->data);
+	prefetch(pref);
+	prefetch(pref + EHEA_CACHE_LINE);
+	prefetch(pref + EHEA_CACHE_LINE * 2);
+	prefetch(pref + EHEA_CACHE_LINE * 3);
+	skb = skb_array[skb_index];
+	skb_array[skb_index] = NULL;
+	return skb;
+}
+
+static inline struct sk_buff *get_skb_by_index_ll(struct sk_buff **skb_array,
+						  int arr_len, int wqe_index)
+{
+	struct sk_buff *skb;
+	void *pref;
+	int x;
+
+	x = wqe_index + 1;
+	x &= (arr_len - 1);
+
+	pref = (void*)skb_array[x];
+	prefetchw(pref);
+	prefetchw(pref + EHEA_CACHE_LINE);
+
+	pref = (void*)(skb_array[x]->data);
+	prefetchw(pref);
+	prefetchw(pref + EHEA_CACHE_LINE);
+
+	skb = skb_array[wqe_index];
+	skb_array[wqe_index] = NULL;
+	return skb;
+}
+
+static int ehea_poll(struct net_device *dev, int *budget)
+{
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_port_res *pr = &port->port_res[0];
+	struct ehea_cqe *cqe;
+	struct ehea_qp *qp = pr->qp;
+	int wqe_index, last_wqe_index = 0;
+	int processed = 0;
+	int processed_RQ1 = 0;
+	int processed_RQ2 = 0;
+	int processed_RQ3 = 0;
+	int rq, intreq;
+	struct sk_buff **skb_arr_rq1 = pr->skb_arr_rq1;
+	struct sk_buff **skb_arr_rq2 = pr->skb_arr_rq2;
+	struct sk_buff **skb_arr_rq3 = pr->skb_arr_rq3;
+	int skb_arr_rq1_len = pr->skb_arr_rq1_len;
+	int my_quota = min(*budget, dev->quota);
+	struct sk_buff *skb;
+	my_quota = min(my_quota, EHEA_MAX_RWQE);
+
+	/* rq0 is low latency RQ */
+	cqe = ehea_poll_rq1(qp, &wqe_index);
+	while ((my_quota > 0) && cqe) {
+		ehea_inc_rq1(qp);
+		processed_RQ1++;
+		processed++;
+		my_quota--;
+		if (netif_msg_rx_status(port))
+			ehea_dump(cqe, sizeof(*cqe), "CQE");
+
+		last_wqe_index = wqe_index;
+		rmb();
+		if (!ehea_check_cqe(cqe, &rq)) {
+			if (rq == 1) {	/* LL RQ1 */
+				skb = get_skb_by_index_ll(skb_arr_rq1,
+							  skb_arr_rq1_len,
+							  wqe_index);
+				if (unlikely(!skb)) {
+					if (netif_msg_rx_err(port))
+						ehea_error("LL rq1: skb=NULL");
+					break;
+				}
+				memcpy(skb->data, ((char*)cqe) + 64,
+				       cqe->num_bytes_transfered - 4);
+				ehea_fill_skb(dev, skb, cqe);
+			} else if (rq == 2) {  /* RQ2 */
+				skb = get_skb_by_index(skb_arr_rq2,
+						     pr->skb_arr_rq2_len, cqe);
+				if (unlikely(!skb)) {
+					if (netif_msg_rx_err(port))
+						ehea_error("rq2: skb=NULL");
+					break;
+				}
+				ehea_fill_skb(dev, skb, cqe);
+				processed_RQ2++;
+			} else {  /* RQ3 */
+				skb = get_skb_by_index(skb_arr_rq3,
+						     pr->skb_arr_rq3_len, cqe);
+				if (unlikely(!skb)) {
+					if (netif_msg_rx_err(port))
+						ehea_error("rq3: skb=NULL");
+					break;
+				}
+				ehea_fill_skb(dev, skb, cqe);
+				processed_RQ3++;
+			}
+
+			if (cqe->status & EHEA_CQE_VLAN_TAG_XTRACT)
+				vlan_hwaccel_receive_skb(skb, port->vgrp,
+							 cqe->vlan_tag);
+			else
+				netif_receive_skb(skb);
+
+		} else { /* Error occured */
+			if (netif_msg_rx_err(port))
+				ehea_dump(cqe, sizeof(*cqe), "CQE");
+			if (rq == 2) {
+				processed_RQ2++;
+				skb = get_skb_by_index(skb_arr_rq2,
+						       pr->skb_arr_rq2_len,
+						       cqe);
+				dev_kfree_skb(skb);
+			}
+			if (rq == 3) {
+				processed_RQ3++;
+				skb = get_skb_by_index(skb_arr_rq3,
+						       pr->skb_arr_rq3_len,
+						       cqe);
+				dev_kfree_skb(skb);
+			}
+		}
+		cqe = ehea_poll_rq1(qp, &wqe_index);
+	}
+
+	dev->quota -= processed;
+	*budget -= processed;
+
+	pr->p_state.ehea_poll += 1;
+	pr->rx_packets += processed;
+
+	ehea_refill_rq1(pr, last_wqe_index, processed_RQ1);
+	ehea_refill_rq2(pr, processed_RQ2);
+	ehea_refill_rq3(pr, processed_RQ3);
+	intreq = ((pr->p_state.ehea_poll & 0xF) == 0xF);
+
+	if (!cqe || intreq) {
+		netif_rx_complete(dev);
+		ehea_reset_cq_ep(pr->recv_cq);
+		ehea_reset_cq_n1(pr->recv_cq);
+		cqe = hw_qeit_get_valid(&qp->hw_rqueue1);
+		if (!cqe || intreq)
+			return 0;
+		if (!netif_rx_reschedule(dev, my_quota))
+			return 0;
+	}
+	return 1;
+}
+
+void free_sent_skbs(struct ehea_cqe *cqe, struct ehea_port_res *pr)
+{
+	struct sk_buff *skb;
+	int index, max_index_mask;
+	int i;
+
+	index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX, cqe->wr_id);
+	max_index_mask = pr->skb_arr_sq_len - 1;
+	for (i = 0; i < EHEA_BMASK_GET(EHEA_WR_ID_REFILL, cqe->wr_id); i++) {
+		skb = pr->skb_arr_sq[index];
+		if (likely(skb)) {
+			dev_kfree_skb(skb);
+			pr->skb_arr_sq[index] = NULL;
+		} else {
+			ehea_error("skb=NULL, wr_id=%lX, loop=%d, index=%d\n",
+				   cqe->wr_id, i, index);
+		}
+
+		index--;
+		index &= max_index_mask;
+	}
+}
+
+#define MAX_SENDCOMP_QUOTA 400
+void ehea_send_irq_tasklet(unsigned long data)
+{
+	int quota = MAX_SENDCOMP_QUOTA;
+	int cqe_counter = 0;
+	int swqe_av = 0;
+	unsigned long flags;
+	struct ehea_cqe *cqe;
+	struct ehea_port_res *pr = (struct ehea_port_res*)data;
+	struct ehea_cq *send_cq = pr->send_cq;
+	struct net_device *dev = pr->port->netdev;
+
+	do {
+		cqe = ehea_poll_cq(send_cq);
+		if (!cqe) {
+			ehea_reset_cq_ep(send_cq);
+			ehea_reset_cq_n1(send_cq);
+			cqe = ehea_poll_cq(send_cq);
+			if (!cqe)
+				break;
+		}
+		cqe_counter++;
+		rmb();
+
+		if (netif_msg_tx_done(pr->port))
+			ehea_dump(cqe, sizeof(*cqe), "CQE");
+
+		if (likely(EHEA_BMASK_GET(EHEA_WR_ID_TYPE, cqe->wr_id)
+			   == EHEA_SWQE2_TYPE))
+			free_sent_skbs(cqe, pr);
+
+		swqe_av += EHEA_BMASK_GET(EHEA_WR_ID_REFILL, cqe->wr_id);
+		quota--;
+	} while (quota > 0);
+
+	ehea_update_feca(send_cq, cqe_counter);
+	atomic_add(swqe_av, &pr->swqe_avail);
+
+	if (unlikely(netif_queue_stopped(dev))) {
+		spin_lock_irqsave(&pr->netif_queue, flags);
+		if (unlikely((atomic_read(&pr->swqe_avail)
+			      >= EHEA_SWQE_REFILL_TH))) {
+			netif_wake_queue(pr->port->netdev);
+		}
+		spin_unlock_irqrestore(&pr->netif_queue, flags);
+	}
+
+	if (unlikely(cqe))
+		tasklet_hi_schedule(&pr->send_comp_task);
+}
+
+irqreturn_t ehea_send_irq_handler(int irq, void *param, struct pt_regs *regs)
+{
+	struct ehea_port_res *pr = (struct ehea_port_res*)param;
+	tasklet_hi_schedule(&pr->send_comp_task);
+	return IRQ_HANDLED;
+}
+
+irqreturn_t ehea_recv_irq_handler(int irq, void *param, struct pt_regs * regs)
+{
+	struct ehea_port_res *pr = (struct ehea_port_res*)param;
+	struct ehea_port *port = pr->port;
+	netif_rx_schedule(port->netdev);
+	return IRQ_HANDLED;
+}
+
+irqreturn_t ehea_qp_aff_irq_handler(int irq, void *param, struct pt_regs * regs)
+{
+	struct ehea_port *port = (struct ehea_port*)param;
+	struct ehea_eqe *eqe;
+	u32 qp_token;
+
+	eqe = ehea_poll_eq(port->qp_eq);
+	ehea_debug("eqe=%p", eqe);
+	while (eqe) {
+		ehea_debug("*eqe=%lx", *(u64*)eqe);
+		eqe = ehea_poll_eq(port->qp_eq);
+		qp_token = EHEA_BMASK_GET(EHEA_EQE_QP_TOKEN, eqe->entry);
+		ehea_debug("next eqe=%p", eqe);
+	}
+
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
+static int ehea_sense_port_attr(struct ehea_port *port)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_0 *cb0 = NULL;
+
+	cb0 = kzalloc(sizeof(*cb0), GFP_KERNEL);
+	if (!cb0) {
+		ehea_error("no mem for cb0");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	hret = ehea_h_query_ehea_port(port->adapter->handle,
+				      port->logical_port_id,
+				      H_PORT_CB0,
+				      EHEA_BMASK_SET(H_PORT_CB0_ALL, 0xFFFF),
+				      cb0);
+	if (hret != H_SUCCESS) {
+		ret = -EPERM;
+		goto query_ehea_port_failed;
+	}
+
+	if (netif_msg_probe(port))
+		ehea_dump(cb0, sizeof(*cb0), "ehea_sense_port_attr");
+
+	/* MAC address */
+	port->mac_addr = cb0->port_mac_addr << 16;
+
+	/* Port speed */
+	switch (cb0->port_speed) {
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
+	port->num_def_qps = cb0->num_default_qps;
+	if (port->num_def_qps >= EHEA_NUM_TX_QP)
+		port->num_tx_qps = 0;
+	else
+		port->num_tx_qps = EHEA_NUM_TX_QP - port->num_def_qps;
+
+	ret = 0;
+
+query_ehea_port_failed:
+	kfree(cb0);
+
+kzalloc_failed:
+	return ret;
+}
+
+
+static void ehea_parse_eqe(struct ehea_adapter *adapter, u64 eqe)
+{
+	int ret = -EINVAL;
+	u8 ec;
+	u8 portnum;
+	struct ehea_port *port;
+
+	ec = EHEA_BMASK_GET(NEQE_EVENT_CODE, eqe);
+
+	switch (ec) {
+	case EHEA_EC_PORTSTATE_CHG:	/* port state change */
+		portnum = EHEA_BMASK_GET(NEQE_PORTNUM, eqe);
+		port = ehea_get_port(adapter, portnum);
+
+		if (!port) {
+			ehea_error("unknown portnum %x", portnum);
+			break;
+		}
+
+		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
+			if (!netif_carrier_ok(port->netdev)) {
+				ret = ehea_sense_port_attr(
+					adapter->port[portnum]);
+				if (ret) {
+					ehea_error("failed resensing port");
+					break;
+				}
+
+				if (netif_msg_link(port))
+					ehea_info("%s: Logical port up: %dMbps "
+						  "%s Duplex",
+						  port->netdev->name,
+						  port->port_speed,
+						  port->full_duplex ==
+						  1 ? "Full" : "Half");
+
+				netif_carrier_on(port->netdev);
+				netif_wake_queue(port->netdev);
+			}
+		} else
+			if (netif_carrier_ok(port->netdev)) {
+				if (netif_msg_link(port))
+					ehea_info("%s: Logical port down",
+						  port->netdev->name);
+				netif_carrier_off(port->netdev);
+				netif_stop_queue(port->netdev);
+			}
+
+		if (EHEA_BMASK_GET(NEQE_EXTSWITCH_PORT_UP, eqe)) {
+			if (netif_msg_link(port))
+				ehea_info("%s: Physical port up",
+					  port->netdev->name);
+		} else {
+			if (netif_msg_link(port))
+				ehea_info("%s: Physical port down",
+					  port->netdev->name);
+		}
+
+		if (EHEA_BMASK_GET(NEQE_EXTSWITCH_PRIMARY, eqe))
+			ehea_info("Externel switch port is primary port");
+		else
+			ehea_info("Externel switch port is backup port");
+
+		break;
+	case EHEA_EC_ADAPTER_MALFUNC:	/* adapter malfunction */
+		ehea_error("adapter malfunction");
+		break;
+	case EHEA_EC_PORT_MALFUNC:	/* port malfunction */
+		ehea_info("Port malfunction");
+		/* TODO Determine the port structure of the malfunctioning port
+		 * netif_carrier_off(port->netdev);
+		 * netif_stop_queue(port->netdev);
+		 */
+		break;
+	default:
+		ehea_error("unknown event code %x", ec);
+		break;
+	}
+}
+
+void ehea_neq_tasklet(unsigned long data)
+{
+	struct ehea_adapter *adapter = (struct ehea_adapter*)data;
+	struct ehea_eqe *eqe;
+	u64 event_mask;
+
+	eqe = ehea_poll_eq(adapter->neq);
+	ehea_debug("eqe=%p", eqe);
+
+	while (eqe) {
+		ehea_debug("*eqe=%lx", eqe->entry);
+		ehea_parse_eqe(adapter, eqe->entry);
+		eqe = ehea_poll_eq(adapter->neq);
+		ehea_debug("next eqe=%p", eqe);
+	}
+
+	event_mask = EHEA_BMASK_SET(NELR_PORTSTATE_CHG, 1)
+		   | EHEA_BMASK_SET(NELR_ADAPTER_MALFUNC, 1)
+		   | EHEA_BMASK_SET(NELR_PORT_MALFUNC, 1);
+
+	ehea_h_reset_events(adapter->handle,
+			    adapter->neq->fw_handle, event_mask);
+}
+
+irqreturn_t ehea_interrupt_neq(int irq, void *param, struct pt_regs *regs)
+{
+	struct ehea_adapter *adapter = (struct ehea_adapter*)param;
+	tasklet_hi_schedule(&adapter->neq_tasklet);
+	return IRQ_HANDLED;
+}
+
+
+static int ehea_fill_port_res(struct ehea_port_res *pr)
+{
+	int ret = 0;
+	struct ehea_qp_init_attr *init_attr = &pr->qp->init_attr;
+
+	/* RQ 1 */
+	ret = ehea_init_fill_rq1(pr, init_attr->act_nr_rwqes_rq1
+				 - init_attr->act_nr_rwqes_rq2
+				 - init_attr->act_nr_rwqes_rq3 - 1);
+	/* RQ 2 */
+	ret |= ehea_refill_rq2(pr, init_attr->act_nr_rwqes_rq2);
+
+	/* RQ 3 */
+	ret |= ehea_refill_rq3(pr, init_attr->act_nr_rwqes_rq3);
+
+	return ret;
+}
+
+static int ehea_reg_interrupts(struct net_device *dev)
+{
+	int ret = -EINVAL;
+	int i, k;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_port_res *pr;
+
+	for (i = 0; i < port->num_def_qps; i++) {
+		pr = &port->port_res[i];
+		snprintf(pr->int_recv_name, EHEA_IRQ_NAME_SIZE - 1
+			 , "%s-recv%d", dev->name, i);
+		ret = ibmebus_request_irq(NULL, pr->recv_eq->attr.ist1,
+					  ehea_recv_irq_handler,
+					  SA_INTERRUPT, pr->int_recv_name, pr);
+		if (ret) {
+			ehea_error("failed registering irq for ehea_recv_int:"
+				   "port_res_nr:%d, ist=%X", i,
+				   pr->recv_eq->attr.ist1);
+			for (k = 0; k < i; k++) {
+				u32 ist = port->port_res[k].recv_eq->attr.ist1;
+				ibmebus_free_irq(NULL, ist, &port->port_res[k]);
+			}
+			goto failure;
+		}
+		if (netif_msg_ifup(port))
+			ehea_info("irq_handle 0x%X for funct ehea_recv_int %d "
+				  "registered\n", pr->recv_eq->attr.ist1, i);
+	}
+
+	snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
+		 "%s-aff", dev->name);
+	ret = ibmebus_request_irq(NULL, port->qp_eq->attr.ist1,
+				  ehea_qp_aff_irq_handler,
+				  SA_INTERRUPT, port->int_aff_name, port);
+	if (ret) {
+		ehea_error("failed registering irq for qp_aff_irq_handler:"
+			   " ist=%X", port->qp_eq->attr.ist1);
+		goto failure2;
+	}
+	if (netif_msg_ifup(port))
+		ehea_info("irq_handle 0x%X for function qp_aff_irq_handler "
+			  "registered\n", port->qp_eq->attr.ist1);
+
+	for (i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
+		pr = &port->port_res[i];
+		snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
+			 "%s-send%d", dev->name, i);
+		ret = ibmebus_request_irq(NULL, pr->send_eq->attr.ist1,
+					  ehea_send_irq_handler,
+					  SA_INTERRUPT, pr->int_send_name,
+					  pr);
+		if (ret) {
+			ehea_error("failed registering irq for ehea_send"
+				   " port_res_nr:%d, ist=%X\n", i,
+				   pr->send_eq->attr.ist1);
+			for (k = 0; k < i; k++) {
+				u32 ist = port->port_res[k].send_eq->attr.ist1;
+				ibmebus_free_irq(NULL, ist, &port->port_res[i]);
+			}
+			goto failure3;
+		}
+		if (netif_msg_ifup(port))
+			ehea_info("irq_handle 0x%X for function ehea_send_int "
+				  "%d registered\n", pr->send_eq->attr.ist1, i);
+	}
+	return ret;
+failure3:
+	for (i = 0; i < port->num_def_qps; i++)
+		ibmebus_free_irq(NULL, port->port_res[i].recv_eq->attr.ist1,
+				 &port->port_res[i]);
+failure2:
+	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
+failure:
+	return ret;
+}
+
+static void ehea_free_interrupts(struct net_device *dev)
+{
+	struct ehea_port *port = netdev_priv(dev);
+	int i;
+
+	/* send */
+	for (i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
+		ibmebus_free_irq(NULL, port->port_res[i].send_eq->attr.ist1,
+				 &port->port_res[i]);
+		if (netif_msg_intr(port))
+			ehea_info("free send irq for res %d with handle 0x%X",
+				  i, port->port_res[i].send_eq->attr.ist1);
+	}
+
+	/* receive */
+	for (i = 0; i < port->num_def_qps; i++) {
+		ibmebus_free_irq(NULL, port->port_res[i].recv_eq->attr.ist1,
+				 &port->port_res[i]);
+		if (netif_msg_intr(port))
+			ehea_info("free recv irq for res %d with handle 0x%X",
+				  i, port->port_res[i].recv_eq->attr.ist1);
+	}
+
+	/* associated events */
+	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
+	if (netif_msg_intr(port))
+		ehea_info("associated event interrupt for handle 0x%X freed",
+			  port->qp_eq->attr.ist1);
+}
+
+static int ehea_configure_port(struct ehea_port *port)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_0 *cb0 = NULL;
+	u64 mask = 0;
+	int i;
+
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb0) {
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	cb0->port_rc = EHEA_BMASK_SET(PXLY_RC_VALID, 1)
+		     | EHEA_BMASK_SET(PXLY_RC_IP_CHKSUM, 1)
+		     | EHEA_BMASK_SET(PXLY_RC_TCP_UDP_CHKSUM, 1)
+                     | EHEA_BMASK_SET(PXLY_RC_VLAN_XTRACT, 1)
+                     | EHEA_BMASK_SET(PXLY_RC_VLAN_TAG_FILTER,
+		                      PXLY_RC_VLAN_FILTER)
+		     | EHEA_BMASK_SET(PXLY_RC_JUMBO_FRAME, 1);
+
+	for (i = 0; i < port->num_def_qps; i++) {
+		cb0->default_qpn_array[i] =
+		    port->port_res[i].qp->init_attr.qp_nr;
+	}
+
+	if (netif_msg_ifup(port))
+		ehea_dump(cb0, sizeof(*cb0), "ehea_configure_port");
+
+	mask = EHEA_BMASK_SET(H_PORT_CB0_PRC, 1)
+	       | EHEA_BMASK_SET(H_PORT_CB0_DEFQPNARRAY, 1);
+
+	hret = ehea_h_modify_ehea_port(port->adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB0,
+				       mask,
+				       cb0);
+
+	if (hret != H_SUCCESS)
+		goto modify_ehea_port_failed;
+
+	ret = 0;
+
+modify_ehea_port_failed:
+	kfree(cb0);
+
+kzalloc_failed:
+	return ret;
+}
+
+
+static int ehea_gen_smrs(struct ehea_port_res *pr)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_adapter *adapter = pr->port->adapter;
+
+	hret = ehea_h_register_smr(adapter->handle,
+				   adapter->mr.handle,
+				   adapter->mr.vaddr,
+				   EHEA_MR_ACC_CTRL,
+				   adapter->pd,
+				   &pr->send_mr);
+	if (hret != H_SUCCESS)
+		goto ehea_gen_smrs_err1;
+
+	hret = ehea_h_register_smr(adapter->handle,
+				   adapter->mr.handle,
+				   adapter->mr.vaddr,
+				   EHEA_MR_ACC_CTRL,
+				   adapter->pd,
+				   &pr->recv_mr);
+	if (hret != H_SUCCESS)
+		goto ehea_gen_smrs_err2;
+	return 0;
+
+ehea_gen_smrs_err2:
+	hret = ehea_h_free_resource_mr(adapter->handle, pr->send_mr.handle);
+	if (hret != H_SUCCESS)
+		ehea_error("failed freeing SMR. hret:%lX\n", hret);
+ehea_gen_smrs_err1:
+	return -EINVAL;
+}
+
+static void ehea_rem_smrs(struct ehea_port_res *pr)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_adapter *adapter = pr->port->adapter;
+
+	hret = ehea_h_free_resource_mr(adapter->handle, pr->send_mr.handle);
+	if (hret != H_SUCCESS)
+		ehea_error("failed freeing send SMR for pr=%p", pr);
+
+	hret = ehea_h_free_resource_mr(adapter->handle, pr->recv_mr.handle);
+	if (hret != H_SUCCESS)
+		ehea_error("failed freeing recv SMR for pr=%p", pr);
+}
+
+static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
+			      struct port_res_cfg *pr_cfg, int queue_token)
+{
+	int ret = -EINVAL;
+	int max_rq_entries = 0;
+	enum ehea_eq_type eq_type = EHEA_EQ;
+	struct ehea_qp_init_attr *init_attr = NULL;
+	struct ehea_adapter *adapter = port->adapter;
+
+	memset(pr, 0, sizeof(struct ehea_port_res));
+
+	pr->skb_arr_rq3 = NULL;
+	pr->skb_arr_rq2 = NULL;
+	pr->skb_arr_rq1 = NULL;
+	pr->skb_arr_sq = NULL;
+	pr->qp = NULL;
+	pr->send_cq = NULL;
+	pr->recv_cq = NULL;
+	pr->send_eq = NULL;
+	pr->recv_eq = NULL;
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
+		ehea_error("create_eq failed (recv_eq)");
+		goto ehea_init_port_res_err;
+	}
+	pr->send_eq = ehea_create_eq(adapter, eq_type,
+				     EHEA_MAX_ENTRIES_EQ, 0);
+	if (!pr->send_eq) {
+		ehea_error("create_eq failed (send_eq)");
+		goto ehea_init_port_res_err;
+	}
+
+	pr->recv_cq = ehea_create_cq(adapter, pr_cfg->max_entries_rcq,
+				     pr->recv_eq->fw_handle,
+				     port->logical_port_id);
+	if (!pr->recv_cq) {
+		ehea_error("create_cq failed (cq_recv)");
+		goto ehea_init_port_res_err;
+	}
+
+	pr->send_cq = ehea_create_cq(adapter, pr_cfg->max_entries_scq,
+				     pr->send_eq->fw_handle,
+				     port->logical_port_id);
+	if (!pr->send_cq) {
+		ehea_error("create_cq failed (cq_send)");
+		goto ehea_init_port_res_err;
+	}
+
+	init_attr = kzalloc(sizeof(*init_attr), GFP_KERNEL);
+
+	if (!init_attr) {
+		ret = -ENOMEM;
+		ehea_error("no mem");
+		goto ehea_init_port_res_err;
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
+	init_attr->send_cq_handle = pr->send_cq->fw_handle;
+	init_attr->recv_cq_handle = pr->recv_cq->fw_handle;
+	init_attr->aff_eq_handle = port->qp_eq->fw_handle;
+
+	pr->qp = ehea_create_qp(adapter, adapter->pd, init_attr);
+	if (!pr->qp) {
+		ehea_error("create_qp failed");
+		goto ehea_init_port_res_err;
+	}
+
+	if (netif_msg_ifup(port))
+		ehea_info("QP: qp_nr=%d\n act_nr_snd_wqe=%d\n nr_rwqe_rq1=%d\n "
+			  "nr_rwqe_rq2=%d\n nr_rwqe_rq3=%d\n", init_attr->qp_nr,
+			  init_attr->act_nr_send_wqes,
+			  init_attr->act_nr_rwqes_rq1,
+			  init_attr->act_nr_rwqes_rq2,
+			  init_attr->act_nr_rwqes_rq3);
+
+	/* SQ */
+	max_rq_entries = init_attr->act_nr_send_wqes + 1;
+	pr->skb_arr_sq = vmalloc(sizeof(struct sk_buff*)
+				 * max_rq_entries);
+	if (!pr->skb_arr_sq) {
+		ret = -ENOMEM;
+		goto ehea_init_port_res_err;
+	}
+	memset(pr->skb_arr_sq, 0, sizeof(void*) * max_rq_entries);
+	pr->skb_sq_index = 0;
+	pr->skb_arr_sq_len = max_rq_entries;
+
+	/* RQ 1 */
+	max_rq_entries = init_attr->act_nr_rwqes_rq1 + 1;
+	pr->skb_arr_rq1 = vmalloc(sizeof(struct sk_buff*)
+				  * max_rq_entries);
+	if (!pr->skb_arr_rq1) {
+		ret = -ENOMEM;
+		goto ehea_init_port_res_err;
+	}
+	memset(pr->skb_arr_rq1, 0, sizeof(void*) * max_rq_entries);
+	pr->skb_arr_rq1_len = max_rq_entries;
+
+	/* RQ 2 */
+	max_rq_entries = init_attr->act_nr_rwqes_rq2 + 1;
+	pr->skb_arr_rq2 = vmalloc(sizeof(struct sk_buff*)*max_rq_entries);
+	if (!pr->skb_arr_rq2) {
+		ret = -ENOMEM;
+		goto ehea_init_port_res_err;
+	}
+	memset(pr->skb_arr_rq2, 0, sizeof(void*) * max_rq_entries);
+	pr->skb_arr_rq2_len = max_rq_entries;
+	pr->skb_rq2_index = 0;
+
+	/* RQ 3 */
+	max_rq_entries = init_attr->act_nr_rwqes_rq3 + 1;
+	pr->skb_arr_rq3 = vmalloc(sizeof(struct sk_buff*)
+				  * max_rq_entries);
+	if (!pr->skb_arr_rq3) {
+		ret = -ENOMEM;
+		goto ehea_init_port_res_err;
+	}
+	memset(pr->skb_arr_rq3, 0, sizeof(void*) * max_rq_entries);
+	pr->skb_arr_rq3_len = max_rq_entries;
+	pr->skb_rq3_index = 0;
+
+	if (ehea_gen_smrs(pr) != 0)
+		goto ehea_init_port_res_err;
+	tasklet_init(&pr->send_comp_task, ehea_send_irq_tasklet,
+		     (unsigned long)pr);
+	atomic_set(&pr->swqe_avail, EHEA_MAX_ENTRIES_SQ - 1);
+
+	kfree(init_attr);
+	ret = 0;
+	goto done;
+
+ehea_init_port_res_err:
+	vfree(pr->skb_arr_rq3);
+	vfree(pr->skb_arr_rq2);
+	vfree(pr->skb_arr_rq1);
+	vfree(pr->skb_arr_sq);
+	ehea_destroy_qp(pr->qp);
+	kfree(init_attr);
+	ehea_destroy_cq(pr->send_cq);
+	ehea_destroy_cq(pr->recv_cq);
+	ehea_destroy_eq(pr->send_eq);
+	ehea_destroy_eq(pr->recv_eq);
+done:
+	return ret;
+}
+
+static int ehea_clean_port_res(struct ehea_port *port, struct ehea_port_res *pr)
+{
+	int i;
+	int ret = -EINVAL;
+
+	ehea_destroy_qp(pr->qp);
+	ehea_destroy_cq(pr->send_cq);
+	ehea_destroy_cq(pr->recv_cq);
+	ehea_destroy_eq(pr->send_eq);
+	ehea_destroy_eq(pr->recv_eq);
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
+	return ret;
+}
+
+/*
+ * The write_* functions store information in swqe which is used by
+ * the hardware to calculate the ip/tcp/udp checksum
+ */
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
+				      + (skb->h.th->doff * 4);
+
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
+				sg1entry->vaddr = tmp_addr;
+				swqe->descriptors++;
+			}
+		} else
+			ehea_error("cannot handle fragmented headers");
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
+				sg1entry->vaddr = tmp_addr;
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
+			tmp_addr =  (u64)(page_address(frag->page)
+					  + frag->page_offset);
+			sg1entry->vaddr = tmp_addr;
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
+			sgentry->vaddr = tmp_addr;
+		}
+	}
+}
+
+static int ehea_broadcast_reg_helper(struct ehea_port *port, u32 hcallid)
+{
+	u64 hret = H_HARDWARE;
+	u8 reg_type = 0;
+	int ret = 0;
+
+	/* De/Register untagged packets */
+	reg_type = EHEA_BCMC_BROADCAST | EHEA_BCMC_UNTAGGED;
+	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
+				     port->logical_port_id,
+				     reg_type, port->mac_addr, 0, hcallid);
+	if (hret != H_SUCCESS) {
+		ehea_error("reg_dereg_bcmc failed (tagged)");
+		ret = -EOPNOTSUPP;
+		goto hcall_failed;
+	}
+
+	/* De/Register VLAN packets */
+	reg_type = EHEA_BCMC_BROADCAST | EHEA_BCMC_VLANID_ALL;
+	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
+				     port->logical_port_id,
+				     reg_type, port->mac_addr, 0, hcallid);
+	if (hret != H_SUCCESS) {
+		ehea_error("reg_dereg_bcmc failed (vlan)");
+		ret = -EOPNOTSUPP;
+	}
+hcall_failed:
+	return ret;
+}
+
+static int ehea_set_mac_addr(struct net_device *dev, void *sa)
+{
+	int ret = -EOPNOTSUPP;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_0 *cb0 = NULL;
+	struct ehea_port *port = netdev_priv(dev);
+	struct sockaddr *mac_addr = (struct sockaddr*)sa;
+
+	if (!is_valid_ether_addr(mac_addr->sa_data)) {
+		ret = -EADDRNOTAVAIL;
+		goto invalid_mac;
+	}
+
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb0) {
+		ehea_error("no mem for cb0");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	memcpy(&(cb0->port_mac_addr), &(mac_addr->sa_data[0]), ETH_ALEN);
+
+	cb0->port_mac_addr = cb0->port_mac_addr >> 16;
+
+	hret = ehea_h_modify_ehea_port(port->adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB0,
+				       EHEA_BMASK_SET(H_PORT_CB0_MAC, 1),
+				       cb0);
+	if (hret != H_SUCCESS) {
+		ret = -EOPNOTSUPP;
+		goto hcall_failed;
+	}
+
+	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
+
+	/* Deregister old MAC in pHYP */
+	ret = ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+	if (ret)
+		goto hcall_failed;
+
+	port->mac_addr = cb0->port_mac_addr << 16;
+
+	/* Register new MAC in pHYP */
+	ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
+	if (ret)
+		goto hcall_failed;
+
+	ret = 0;
+
+hcall_failed:
+	kfree(cb0);
+
+kzalloc_failed:
+invalid_mac:
+	return ret;
+}
+
+static void ehea_promiscuous(struct net_device *dev, int enable)
+{
+	struct ehea_port *port = netdev_priv(dev);
+
+	if (!port->promisc) {
+		if (enable) {
+			/* Enable promiscuous mode */
+			ehea_error("Enable promiscuous mode: "
+				   "not yet implemented");
+			port->promisc = 1;
+		}
+	} else {
+		if (!enable) {
+			/* Disable promiscuous mode */
+			ehea_error("Disable promiscuous mode: "
+				   "not yet implemented");
+			port->promisc = 0;
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
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_mc_list *mc_entry = port->mc_list;
+	struct list_head *pos;
+	struct list_head *temp;
+
+	list_for_each_safe(pos, temp, &(port->mc_list->list)) {
+		mc_entry = list_entry(pos, struct ehea_mc_list, list);
+
+		hret = ehea_multicast_reg_helper(port,
+						 mc_entry->macaddr,
+						 H_DEREG_BCMC);
+		if (hret) {
+			ehea_error("failed deregistering mcast MAC");
+			ret = -EINVAL;
+		}
+
+		list_del(pos);
+		kfree(mc_entry);
+	}
+	return ret;
+}
+
+static void ehea_allmulti(struct net_device *dev, int enable)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+
+	if (!port->allmulti) {
+		if (enable) {
+			/* Enable ALLMULTI */
+			ehea_drop_multicast_list(dev);
+			hret = ehea_multicast_reg_helper(port, 0, H_REG_BCMC);
+			if (!hret)
+				port->allmulti = 1;
+			else
+				ehea_error("failed enabling IFF_ALLMULTI");
+		}
+	} else
+		if (!enable) {
+			/* Disable ALLMULTI */
+			hret = ehea_multicast_reg_helper(port, 0, H_DEREG_BCMC);
+			if (!hret)
+				port->allmulti = 0;
+			else
+				ehea_error("failed disabling IFF_ALLMULTI");
+		}
+}
+
+static void ehea_add_multicast_entry(struct ehea_port* port, u8* mc_mac_addr)
+{
+	u64 hret = H_HARDWARE;
+	struct ehea_mc_list *ehea_mcl_entry;
+
+	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_KERNEL);
+	if (!ehea_mcl_entry) {
+		ehea_error("no mem for mcl_entry");
+		return;
+	}
+
+	INIT_LIST_HEAD(&ehea_mcl_entry->list);
+
+	memcpy(&ehea_mcl_entry->macaddr, mc_mac_addr, ETH_ALEN);
+
+	hret = ehea_multicast_reg_helper(port, ehea_mcl_entry->macaddr,
+					 H_REG_BCMC);
+	if (!hret)
+		list_add(&ehea_mcl_entry->list, &port->mc_list->list);
+	else {
+		ehea_error("failed registering mcast MAC");
+		kfree(ehea_mcl_entry);
+	}
+}
+
+static void ehea_set_multicast_list(struct net_device *dev)
+{
+	int ret;
+	int i;
+	struct ehea_port *port = netdev_priv(dev);
+	struct dev_mc_list *k_mcl_entry;
+
+	if (dev->flags & IFF_PROMISC) {
+		ehea_promiscuous(dev, 1);
+		return;
+	}
+	ehea_promiscuous(dev, 0);
+
+	if (dev->flags & IFF_ALLMULTI) {
+		ehea_allmulti(dev, 1);
+		return;
+	}
+	ehea_allmulti(dev, 0);
+
+	if (dev->mc_count) {
+		ret = ehea_drop_multicast_list(dev);
+		if (ret) {
+			/* Dropping the current multicast list failed.
+			 * Enabling ALL_MULTI is the best we can do.
+			 */
+			ehea_allmulti(dev, 1);
+		}
+
+		if (dev->mc_count > port->adapter->max_mc_mac) {
+			ehea_info("Mcast registration limit reached (0x%lx). "
+				  "Use ALLMULTI!",
+				  port->adapter->max_mc_mac);
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
+escape:
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
+	nfrags = skb_shinfo(skb)->nr_frags;
+
+	if (skb->protocol == htons(ETH_P_IP)) {
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
+}
+
+static inline void ehea_xmit3(struct sk_buff *skb,
+			      struct net_device *dev, struct ehea_swqe *swqe)
+{
+	int i;
+	skb_frag_t *frag;
+	int nfrags = skb_shinfo(skb)->nr_frags;
+	u8 *imm_data = &swqe->u.immdata_nodesc.immediate_data[0];
+
+	if (likely(skb->protocol == htons(ETH_P_IP))) {
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
+
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
+}
+
+static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned long flags;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_port_res *pr;
+	struct ehea_swqe *swqe;
+	u32 lkey;
+	int swqe_index;
+
+	pr = &port->port_res[0];
+
+	if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
+		spin_lock_irqsave(&pr->netif_queue, flags);
+		if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
+			netif_stop_queue(dev);
+			spin_unlock_irqrestore(&pr->netif_queue, flags);
+			return NETDEV_TX_BUSY;
+		}
+		spin_unlock_irqrestore(&pr->netif_queue, flags);
+	}
+	atomic_dec(&pr->swqe_avail);
+
+	spin_lock(&pr->xmit_lock);
+
+	swqe = ehea_get_swqe(pr->qp, &swqe_index);
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
+	} else {
+		swqe->wr_id =
+		    EHEA_BMASK_SET(EHEA_WR_ID_REFILL, EHEA_SIG_IV_LONG)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_SWQE2_TYPE)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_COUNT, pr->swqe_id_counter)
+		    | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, pr->skb_sq_index);
+		pr->skb_arr_sq[pr->skb_sq_index] = skb;
+
+		pr->skb_sq_index++;
+		pr->skb_sq_index &= (pr->skb_arr_sq_len - 1);
+
+		lkey = pr->send_mr.lkey;
+		ehea_xmit2(skb, dev, swqe, lkey);
+
+		if (pr->swqe_count >= (EHEA_SIG_IV_LONG - 1)) {
+			swqe->tx_control |= EHEA_SWQE_SIGNALLED_COMPLETION;
+			pr->swqe_count = 0;
+		} else
+			pr->swqe_count += 1;
+	}
+	pr->swqe_id_counter += 1;
+
+	if (port->vgrp && vlan_tx_tag_present(skb)) {
+		swqe->tx_control |= EHEA_SWQE_VLAN_INSERT;
+		swqe->vlan_tag = vlan_tx_tag_get(skb);
+	}
+
+	if (netif_msg_tx_queued(port)) {
+		ehea_info("post swqe on QP %d", pr->qp->init_attr.qp_nr);
+		ehea_dump(swqe, sizeof(*swqe), "swqe");
+	}
+
+	ehea_post_swqe(pr->qp, swqe);
+	pr->tx_packets++;
+	spin_unlock(&pr->xmit_lock);
+
+	return NETDEV_TX_OK;
+}
+
+static void ehea_vlan_rx_register(struct net_device *dev,
+				  struct vlan_group *grp)
+{
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_adapter *adapter = port->adapter;
+
+	port->vgrp = grp;
+
+	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb1) {
+		ehea_error("no mem for cb1");
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
+	if (hret != H_SUCCESS)
+		ehea_error("modify_ehea_port failed");
+
+	kfree(cb1);
+
+vlan_reg_exit:
+	return;
+}
+
+static void ehea_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
+{
+	int index;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
+	struct ehea_adapter *adapter = port->adapter;
+
+	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb1) {
+		ehea_error("no mem for cb1");
+		goto vlan_kill_exit;
+	}
+
+	hret = ehea_h_query_ehea_port(adapter->handle, port->logical_port_id,
+				      H_PORT_CB1, H_PORT_CB1_ALL, cb1);
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_port failed");
+		goto vlan_kill_exit;
+	}
+
+	index = (vid / 64);
+	cb1->vlan_filter[index] |= ((u64)(1 << (vid & 0x3F)));
+
+	hret = ehea_h_modify_ehea_port(adapter->handle, port->logical_port_id,
+				       H_PORT_CB1, H_PORT_CB1_ALL, cb1);
+	if (hret != H_SUCCESS)
+		ehea_error("modify_ehea_port failed");
+
+	kfree(cb1);
+
+vlan_kill_exit:
+	return;
+
+}
+
+static void ehea_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
+{
+	int index;
+	u64 hret = H_HARDWARE;
+	struct ehea_port *port = netdev_priv(dev);
+	struct ehea_adapter *adapter = port->adapter;
+	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
+
+	if (port->vgrp)
+		port->vgrp->vlan_devices[vid] = NULL;
+
+	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb1) {
+		ehea_error("no mem for cb1");
+		goto vlan_kill_exit;
+	}
+	hret = ehea_h_query_ehea_port(adapter->handle,
+				       port->logical_port_id,
+				       H_PORT_CB1,
+				       H_PORT_CB1_ALL,
+				       cb1);
+
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_port failed");
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
+		ehea_error("modify_ehea_port failed");
+
+	kfree(cb1);
+
+vlan_kill_exit:
+	return;
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
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+
+	if (!cb0) {
+		ehea_error("no mem for cb0");
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	/* Reset queue pair */
+	cb0->qp_ctl_reg = H_QP_CR_ENABLED | H_QP_CR_STATE_RESET;
+	hret = ehea_h_modify_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		ehea_error("gailed resetting the queue pair");
+		goto modify_qp_failed;
+	}
+
+	/* Disable queue pair */
+	cb0->qp_ctl_reg = H_QP_CR_STATE_RESET;
+	hret = ehea_h_modify_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		ehea_error("failed disabling the queue pair");
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
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb0) {
+		ret = -ENOMEM;
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_qp failed (1)");
+		goto failure;
+	}
+
+	cb0->qp_ctl_reg = H_QP_CR_STATE_INITIALIZED;
+	hret = ehea_h_modify_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		ehea_error("modify_ehea_qp failed (1)");
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_qp failed (2)");
+		goto failure;
+	}
+
+	cb0->qp_ctl_reg = H_QP_CR_ENABLED | H_QP_CR_STATE_INITIALIZED;
+	hret = ehea_h_modify_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		ehea_error("modify_ehea_qp failed (2)");
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_qp failed (3)");
+		goto failure;
+	}
+
+	cb0->qp_ctl_reg = H_QP_CR_ENABLED | H_QP_CR_STATE_RDY2SND;
+	hret = ehea_h_modify_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				     EHEA_BMASK_SET(H_QPCB0_QP_CTL_REG, 1), cb0,
+				     &dummy64, &dummy64, &dummy16, &dummy16);
+	if (hret != H_SUCCESS) {
+		ehea_error("modify_ehea_qp failed (3)");
+		goto failure;
+	}
+
+	hret = ehea_h_query_ehea_qp(adapter->handle, 0, qp->fw_handle,
+				    EHEA_BMASK_SET(H_QPCB0_ALL, 0xFFFF), cb0);
+	if (hret != H_SUCCESS) {
+		ehea_error("query_ehea_qp failed (4)");
+		goto failure;
+	}
+
+	ret = 0;
+
+failure:
+	kfree(cb0);
+	return ret;
+}
+
+static int ehea_port_res_setup(struct ehea_port *port, int def_qps,
+			       int add_tx_qps)
+{
+	int i, k;
+	int ret = 0;
+	struct port_res_cfg pr_cfg, pr_cfg_small_rx;
+	enum ehea_eq_type eq_type = EHEA_EQ;
+
+	port->qp_eq = ehea_create_eq(port->adapter, eq_type,
+				   EHEA_MAX_ENTRIES_EQ, 1);
+	if (!port->qp_eq) {
+		ehea_error("ehea_create_eq failed (qp_eq)");
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
+		ret = ehea_init_port_res(port, &port->port_res[i], &pr_cfg, i);
+		if (ret)
+			goto port_res_setup_failed;
+	}
+	for (i = def_qps; i < def_qps + add_tx_qps; i++) {
+		ret = ehea_init_port_res(port, &port->port_res[i],
+					 &pr_cfg_small_rx, i);
+		if (ret)
+			goto port_res_setup_failed;
+	}
+	return 0;
+
+port_res_setup_failed:
+	for(k = 0; k < i; k++) {
+		ehea_clean_port_res(port, &port->port_res[k]);
+	}
+port_res_setup_failed2:
+	ehea_destroy_eq(port->qp_eq);
+	return ret;
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
+}
+
+int ehea_open(struct net_device *dev)
+{
+	int i;
+	int ret = -EIO;
+	struct ehea_port *port = netdev_priv(dev);
+	u64 mac_addr = 0;
+
+	ret = ehea_port_res_setup(port, port->num_def_qps, port->num_tx_qps);
+	if (ret)
+		goto port_res_setup_failed;
+
+	/* Set default QP for this port */
+	ret = ehea_configure_port(port);
+	if (ret) {
+		ehea_error("ehea_configure_port failed. ret:%d", ret);
+		goto reg_failed;
+	}
+
+	ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
+	if (ret) {
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
+	for(i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
+		ret = ehea_fill_port_res(&port->port_res[i]);
+		if (ret)
+			goto fill_port_res_failed;
+	}
+
+	netif_start_queue(dev);
+	ret = 0;
+	goto done;
+
+fill_port_res_failed:
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
+	return ret;
+}
+
+static int ehea_stop(struct net_device *dev)
+{
+	int ret;
+	struct ehea_port *port = netdev_priv(dev);
+
+	netif_stop_queue(dev);
+	ehea_drop_multicast_list(dev);
+	ret = ehea_stop_qp(port->adapter, port->port_res[0].qp);
+	ehea_free_interrupts(dev);
+	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
+	if (!ret)
+		ehea_clean_all_port_res(port);
+	return ret;
+}
+
+int ehea_sense_adapter_attr(struct ehea_adapter *adapter)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct hcp_query_ehea *cb = NULL;
+
+	cb = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb) {
+		ret = -ENOMEM;
+		goto kzalloc_failed;
+	}
+
+	hret = ehea_h_query_ehea(adapter->handle, cb);
+
+	if (hret != H_SUCCESS)
+		goto query_ehea_failed;
+
+	adapter->num_ports = cb->num_ports;
+	adapter->max_mc_mac = cb->max_mc_mac - 1;
+	ret = 0;
+
+query_ehea_failed:
+	kfree(cb);
+
+kzalloc_failed:
+	return ret;
+}
+
+static int ehea_setup_single_port(struct ehea_port *port,
+				  struct device_node *dn)
+{
+	int ret = -EINVAL;
+	u64 hret = H_HARDWARE;
+	struct net_device *dev = port->netdev;
+	struct ehea_adapter *adapter = port->adapter;
+	struct hcp_query_ehea_port_cb_4 *cb4;
+	u32 *dn_log_port_id = NULL;
+
+	if (!dn) {
+		ehea_error("bad device node: dn=%p", dn);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	port->of_dev_node = dn;
+
+	/* Determine logical port id */
+	dn_log_port_id = (u32*)get_property(dn, "ibm,hea-port-no", NULL);
+
+	if (!dn_log_port_id) {
+		ehea_error("bad device node: dn_log_port_id=%p",
+		       dn_log_port_id);
+		ret = -EINVAL;
+		goto done;
+	}
+	port->logical_port_id = *dn_log_port_id;
+
+	port->mc_list = kzalloc(sizeof(struct ehea_mc_list), GFP_KERNEL);
+	if (!port->mc_list) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	INIT_LIST_HEAD(&port->mc_list->list);
+
+	ret = ehea_sense_port_attr(port);
+	if (ret)
+		goto done;
+
+	/* Enable Jumbo frames */
+	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	if (!cb4) {
+		ehea_error("no mem for cb4");
+	} else {
+		cb4->jumbo_frame = 1;
+		hret = ehea_h_modify_ehea_port(adapter->handle,
+					       port->logical_port_id,
+					       H_PORT_CB4,
+					       H_PORT_CB4_JUMBO,
+					       cb4);
+		if (hret != H_SUCCESS) {
+			ehea_error("modify_ehea_port failed");
+			ehea_info("Jumbo frames not activated");
+		}
+		kfree(cb4);
+	}
+
+	/* initialize net_device structure */
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
+	dev->set_mac_address = ehea_set_mac_addr;
+	dev->change_mtu = ehea_change_mtu;
+	dev->vlan_rx_register = ehea_vlan_rx_register;
+	dev->vlan_rx_add_vid = ehea_vlan_rx_add_vid;
+	dev->vlan_rx_kill_vid = ehea_vlan_rx_kill_vid;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO
+		      | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_TX
+		      | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
+		      | NETIF_F_LLTX;
+
+	ehea_set_ethtool_ops(dev);
+
+	ret = register_netdev(dev);
+	if (ret) {
+		ehea_error("register_netdev failed. ret=%d", ret);
+		goto reg_netdev_failed;
+	}
+
+	port->netdev = dev;
+	ret = 0;
+	goto done;
+
+reg_netdev_failed:
+	kfree(port->mc_list);
+done:
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
+	struct net_device *dev;
+
+	/* get port properties for all ports */
+	for (i = 0; i < adapter->num_ports; i++) {
+
+		if (adapter->port[i])
+			continue;	/* port already up and running */
+
+		/* allocate memory for the port structures */
+		dev = alloc_etherdev(sizeof(struct ehea_port));
+
+		if (!dev) {
+			ehea_error("no mem for net_device");
+			break;
+		}
+
+		port = netdev_priv(dev);
+		port->adapter = adapter;
+		port->netdev = dev;
+		adapter->port[i] = port;
+		port->msg_enable = netif_msg_init(msg_level, EHEA_MSG_DEFAULT);
+
+		dn = of_find_node_by_name(dn, "ethernet");
+		ret = ehea_setup_single_port(port, dn);
+		if (ret) {
+			/* Free mem for this port struct. the others will be
+			   processed on rollback */
+			free_netdev(dev);
+			adapter->port[i] = NULL;
+			ehea_error("eHEA port %d setup failed, ret=%d", i, ret);
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
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+
+	if (!adapter) {
+		dev_err(&dev->ofdev.dev, "No mem for ehea_adapter\n");
+		ret = -ENOMEM;
+		goto kzalloc_adapter_failed;
+	}
+
+
+	adapter_handle = (u64*)get_property(dev->ofdev.node, "ibm,hea-handle",
+					    NULL);
+
+	if (!adapter_handle) {
+		dev_err(&dev->ofdev.dev, "Failed getting handle for adapter"
+			" '%s'\n", dev->ofdev.node->full_name);
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
+	if (ret) {
+		dev_err(&dev->ofdev.dev, "register Memory Region failed\n");
+		goto register_mr_failed;
+	}
+
+	/* initialize adapter and ports */
+	/* get adapter properties */
+	ret = ehea_sense_adapter_attr(adapter);
+	if (ret) {
+		dev_err(&dev->ofdev.dev, "sense_adapter_attr failed: %d", ret);
+		goto sense_adapter_failed;
+	}
+	dev_info(&dev->ofdev.dev, "%d eHEA ports found\n", adapter->num_ports);
+
+	adapter->neq = ehea_create_eq(adapter,
+				      EHEA_NEQ, EHEA_MAX_ENTRIES_EQ, 1);
+	if (!adapter->neq) {
+		dev_err(&dev->ofdev.dev, "NEQ creation failed");
+		goto create_neq_failed;
+	}
+
+	tasklet_init(&adapter->neq_tasklet, ehea_neq_tasklet,
+		     (unsigned long)adapter);
+
+	ret = ibmebus_request_irq(NULL, adapter->neq->attr.ist1,
+				ehea_interrupt_neq, SA_INTERRUPT, "ehea_neq",
+				(void*)adapter);
+	if (ret) {
+		dev_err(&dev->ofdev.dev, "requesting NEQ IRQ failed");
+		goto request_irq_failed;
+	}
+
+	ret = ehea_setup_ports(adapter);
+	if (ret) {
+		dev_err(&dev->ofdev.dev, "setup_ports failed");
+		goto setup_ports_failed;
+	}
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
+	return ret;
+}
+
+static void ehea_shutdown_single_port(struct ehea_port *port)
+{
+	unregister_netdev(port->netdev);
+	kfree(port->mc_list);
+	free_netdev(port->netdev);
+}
+
+static int __devexit ehea_remove(struct ibmebus_dev *dev)
+{
+	int ret = -EINVAL;
+	struct ehea_adapter *adapter = dev->ofdev.dev.driver_data;
+	int i;
+
+	for (i = 0; i < adapter->num_ports; i++)
+		if(adapter->port[i]) {
+			ehea_shutdown_single_port(adapter->port[i]);
+			adapter->port[i] = NULL;
+		}
+
+	ibmebus_free_irq(NULL, adapter->neq->attr.ist1, adapter);
+
+	ehea_destroy_eq(adapter->neq);
+
+	ret = ehea_dereg_mr_adapter(adapter);
+	if (ret) {
+		dev_err(&dev->ofdev.dev, "dereg_mr_adapter failed");
+		goto deregister_mr_failed;
+	}
+	kfree(adapter);
+	ret = 0;
+
+deregister_mr_failed:
+	return ret;
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
+int __init ehea_module_init(void)
+{
+	int ret = -EINVAL;
+
+	printk("IBM eHEA Ethernet Device Driver (Release %s)\n", DRV_VERSION);
+
+	ret = ibmebus_register_driver(&ehea_driver);
+	if (ret) {
+		ehea_error("failed registering eHEA device driver on ebus");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __exit ehea_module_exit(void)
+{
+	ibmebus_unregister_driver(&ehea_driver);
+}
+
+module_init(ehea_module_init);
+module_exit(ehea_module_exit);
