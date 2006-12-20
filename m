Return-Path: <linux-kernel-owner+w=401wt.eu-S1030312AbWLTTUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWLTTUJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWLTTUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:20:08 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:38372 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030306AbWLTTT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:19:58 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v5 04/13] iw_cxgb3 Connection Manager
Date: Wed, 20 Dec 2006 13:19:55 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org, jeff@garzik.org
Message-Id: <20061220191955.19316.52717.stgit@dell3.ogc.int>
In-Reply-To: <20061220191754.19316.4914.stgit@dell3.ogc.int>
References: <20061220191754.19316.4914.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This code implements the iWARP CM provider methods for the Chelsio driver.
The Chelsio ULLD is used to setup and teardown TCP connections, and the
T3 RDMA Core is used to move the connections in and out of RDMA mode.

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
---

 drivers/infiniband/hw/cxgb3/iwch_cm.c | 2077 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/cxgb3/iwch_cm.h |  223 ++++
 drivers/infiniband/hw/cxgb3/tcb.h     |  603 ++++++++++
 3 files changed, 2903 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c b/drivers/infiniband/hw/cxgb3/iwch_cm.c
new file mode 100644
index 0000000..69fcb59
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.c
@@ -0,0 +1,2077 @@
+/*
+ * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
+ * Copyright (c) 2006 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/skbuff.h>
+#include <linux/timer.h>
+#include <linux/notifier.h>
+
+#include <net/neighbour.h>
+#include <net/netevent.h>
+#include <net/route.h>
+
+#include "tcb.h"
+#include "cxgb3_offload.h"
+#include "iwch.h"
+#include "iwch_provider.h"
+#include "iwch_cm.h"
+
+char *states[] = {
+	"idle",
+	"listen",
+	"connecting",
+	"mpa_wait_req",
+	"mpa_req_sent",
+	"mpa_req_rcvd",
+	"mpa_rep_sent",
+	"fpdu_mode",
+	"aborting",
+	"closing",
+	"moribund",
+	"dead",
+	NULL,
+};
+
+static int ep_timeout_secs = 10;
+module_param(ep_timeout_secs, int, 0444);
+MODULE_PARM_DESC(ep_timeout_secs, "CM Endpoint operation timeout "
+				   "in seconds (default=10)");
+
+static int mpa_rev = 1;
+module_param(mpa_rev, int, 0444);
+MODULE_PARM_DESC(mpa_rev, "MPA Revision, 0 supports amso1100, "
+		 "1 is spec compliant. (default=1)");
+
+static int markers_enabled = 0;
+module_param(markers_enabled, int, 0444);
+MODULE_PARM_DESC(markers_enabled, "Enable MPA MARKERS (default(0)=disabled)");
+
+static int crc_enabled = 1;
+module_param(crc_enabled, int, 0444);
+MODULE_PARM_DESC(crc_enabled, "Enable MPA CRC (default(1)=enabled)");
+
+static int rcv_win = 512 * 1024;
+module_param(rcv_win, int, 0444);
+MODULE_PARM_DESC(rcv_win, "TCP receive window in bytes (default=512KB)");
+
+static int snd_win = 512 * 1024;
+module_param(snd_win, int, 0444);
+MODULE_PARM_DESC(snd_win, "TCP send window in bytes (default=512KB)");
+
+static unsigned int nocong = 1;
+module_param(nocong, uint, 0444);
+MODULE_PARM_DESC(nocong, "Turn off congestion control (default=1)");
+
+static void process_work(struct work_struct *work);
+static struct workqueue_struct *workq;
+DECLARE_WORK(skb_work, process_work);
+
+static struct sk_buff_head rxq;
+static cxgb3_cpl_handler_func work_handlers[NUM_CPL_CMDS];
+
+static struct sk_buff *get_skb(struct sk_buff *skb, int len, gfp_t gfp);
+static void ep_timeout(unsigned long arg);
+static void connect_reply_upcall(struct iwch_ep *ep, int status);
+
+static void start_ep_timer(struct iwch_ep *ep)
+{
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	if (timer_pending(&ep->timer)) {
+		PDBG("%s stopped / restarted timer ep %p\n", __FUNCTION__, ep);
+		del_timer_sync(&ep->timer);
+	} else
+		get_ep(&ep->com);
+	ep->timer.expires = jiffies + ep_timeout_secs * HZ;
+	ep->timer.data = (unsigned long)ep;
+	ep->timer.function = ep_timeout;
+	add_timer(&ep->timer);
+}
+
+static void stop_ep_timer(struct iwch_ep *ep)
+{
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	del_timer_sync(&ep->timer);
+	put_ep(&ep->com);
+}
+
+static void release_tid(struct t3cdev *tdev, u32 hwtid, struct sk_buff *skb)
+{
+	struct cpl_tid_release *req;
+
+	skb = get_skb(skb, sizeof *req, GFP_KERNEL);
+	if (!skb)
+		return;
+	req = (struct cpl_tid_release *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_TID_RELEASE, hwtid));
+	skb->priority = CPL_PRIORITY_SETUP;
+	tdev->send(tdev, skb);
+	return;
+}
+
+int iwch_quiesce_tid(struct iwch_ep *ep)
+{
+	struct cpl_set_tcb_field *req;
+	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+
+	if (!skb)
+		return -ENOMEM;
+	req = (struct cpl_set_tcb_field *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
+	req->reply = 0;
+	req->cpu_idx = 0;
+	req->word = htons(W_TCB_RX_QUIESCE);
+	req->mask = cpu_to_be64(1ULL << S_TCB_RX_QUIESCE);
+	req->val = cpu_to_be64(1 << S_TCB_RX_QUIESCE);
+
+	skb->priority = CPL_PRIORITY_DATA;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+int iwch_resume_tid(struct iwch_ep *ep)
+{
+	struct cpl_set_tcb_field *req;
+	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+
+	if (!skb)
+		return -ENOMEM;
+	req = (struct cpl_set_tcb_field *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
+	req->reply = 0;
+	req->cpu_idx = 0;
+	req->word = htons(W_TCB_RX_QUIESCE);
+	req->mask = cpu_to_be64(1ULL << S_TCB_RX_QUIESCE);
+	req->val = 0;
+
+	skb->priority = CPL_PRIORITY_DATA;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+static void set_emss(struct iwch_ep *ep, u16 opt)
+{
+	PDBG("%s ep %p opt %u\n", __FUNCTION__, ep, opt);
+	ep->emss = T3C_DATA(ep->com.tdev)->mtus[G_TCPOPT_MSS(opt)] - 40;
+	if (G_TCPOPT_TSTAMP(opt))
+		ep->emss -= 12;
+	if (ep->emss < 128)
+		ep->emss = 128;
+	PDBG("emss=%d\n", ep->emss);
+}
+
+static enum iwch_ep_state state_read(struct iwch_ep_common *epc)
+{
+	unsigned long flags;
+	enum iwch_ep_state state;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	state = epc->state;
+	spin_unlock_irqrestore(&epc->lock, flags);
+	return state;
+}
+
+static inline void __state_set(struct iwch_ep_common *epc,
+			       enum iwch_ep_state new)
+{
+	epc->state = new;
+}
+
+static void state_set(struct iwch_ep_common *epc, enum iwch_ep_state new)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	PDBG("%s - %s -> %s\n", __FUNCTION__, states[epc->state], states[new]);
+	__state_set(epc, new);
+	spin_unlock_irqrestore(&epc->lock, flags);
+	return;
+}
+
+static void *alloc_ep(int size, gfp_t gfp)
+{
+	struct iwch_ep_common *epc;
+
+	epc = kmalloc(size, gfp);
+	if (epc) {
+		memset(epc, 0, size);
+		kref_init(&epc->kref);
+		spin_lock_init(&epc->lock);
+		init_waitqueue_head(&epc->waitq);
+	}
+	PDBG("%s alloc ep %p\n", __FUNCTION__, epc);
+	return (void *) epc;
+}
+
+void __free_ep(struct kref *kref)
+{
+	struct iwch_ep_common *epc;
+	epc = container_of(kref, struct iwch_ep_common, kref);
+	PDBG("%s ep %p state %s\n", __FUNCTION__, epc, states[state_read(epc)]);
+	kfree(epc);
+}
+
+static void release_ep_resources(struct iwch_ep *ep)
+{
+	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, ep->hwtid);
+	cxgb3_remove_tid(ep->com.tdev, (void *)ep, ep->hwtid);
+	dst_release(ep->dst);
+	l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+	if (ep->com.tdev->type == T3B)
+		release_tid(ep->com.tdev, ep->hwtid, NULL);
+	put_ep(&ep->com);
+}
+
+static void process_work(struct work_struct *work)
+{
+	struct sk_buff *skb = NULL;
+	void *ep;
+	struct t3cdev *tdev;
+	int ret;
+
+	while ((skb = skb_dequeue(&rxq))) {
+		ep = *((void **) (skb->cb));
+		tdev = *((struct t3cdev **) (skb->cb + sizeof(void *)));
+		ret = work_handlers[G_OPCODE(ntohl((__force __be32)skb->csum))](tdev, skb, ep);
+		if (ret & CPL_RET_BUF_DONE)
+			kfree_skb(skb);
+
+		/*
+		 * ep was referenced in sched(), and is freed here.
+		 */
+		put_ep((struct iwch_ep_common *)ep);
+	}
+}
+
+static int status2errno(int status)
+{
+	switch (status) {
+	case CPL_ERR_NONE:
+		return 0;
+	case CPL_ERR_CONN_RESET:
+		return -ECONNRESET;
+	case CPL_ERR_ARP_MISS:
+		return -EHOSTUNREACH;
+	case CPL_ERR_CONN_TIMEDOUT:
+		return -ETIMEDOUT;
+	case CPL_ERR_TCAM_FULL:
+		return -ENOMEM;
+	case CPL_ERR_CONN_EXIST:
+		return -EADDRINUSE;
+	default:
+		return -EIO;
+	}
+}
+
+/*
+ * Try and reuse skbs already allocated...
+ */
+static struct sk_buff *get_skb(struct sk_buff *skb, int len, gfp_t gfp)
+{
+	if (skb) {
+		BUG_ON(skb_cloned(skb));
+		skb_trim(skb, 0);
+		skb_get(skb);
+	} else {
+		skb = alloc_skb(len, gfp);
+	}
+	return skb;
+}
+
+static struct rtable *find_route(struct t3cdev *dev, __be32 local_ip,
+				 __be32 peer_ip, __be16 local_port,
+				 __be16 peer_port, u8 tos)
+{
+	struct rtable *rt;
+	struct flowi fl = {
+		.oif = 0,
+		.nl_u = {
+			 .ip4_u = {
+				   .daddr = peer_ip,
+				   .saddr = local_ip,
+				   .tos = tos}
+			 },
+		.proto = IPPROTO_TCP,
+		.uli_u = {
+			  .ports = {
+				    .sport = local_port,
+				    .dport = peer_port}
+			  }
+	};
+
+	if (ip_route_output_flow(&rt, &fl, NULL, 0))
+		return NULL;
+	return rt;
+}
+
+static unsigned int find_best_mtu(const struct t3c_data *d, unsigned short mtu)
+{
+	int i = 0;
+
+	while (i < d->nmtus - 1 && d->mtus[i + 1] <= mtu)
+		++i;
+	return i;
+}
+
+static void arp_failure_discard(struct t3cdev *dev, struct sk_buff *skb)
+{
+	PDBG("%s t3cdev %p\n", __FUNCTION__, dev);
+	kfree_skb(skb);
+}
+
+/*
+ * Handle an ARP failure for an active open.
+ */
+static void act_open_req_arp_failure(struct t3cdev *dev, struct sk_buff *skb)
+{
+	printk(KERN_ERR MOD "ARP failure duing connect\n");
+	kfree_skb(skb);
+}
+
+/*
+ * Handle an ARP failure for a CPL_ABORT_REQ.  Change it into a no RST variant
+ * and send it along.
+ */
+static void abort_arp_failure(struct t3cdev *dev, struct sk_buff *skb)
+{
+	struct cpl_abort_req *req = cplhdr(skb);
+
+	PDBG("%s t3cdev %p\n", __FUNCTION__, dev);
+	req->cmd = CPL_ABORT_NO_RST;
+	cxgb3_ofld_send(dev, skb);
+}
+
+static int send_halfclose(struct iwch_ep *ep, gfp_t gfp)
+{
+	struct cpl_close_con_req *req;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(NULL, sizeof(*req), gfp);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb->priority = CPL_PRIORITY_DATA;
+	set_arp_failure_handler(skb, arp_failure_discard);
+	req = (struct cpl_close_con_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_CLOSE_CON));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_CON_REQ, ep->hwtid));
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int send_abort(struct iwch_ep *ep, struct sk_buff *skb, gfp_t gfp)
+{
+	struct cpl_abort_req *req;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(skb, sizeof(*req), gfp);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb.\n",
+		       __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb->priority = CPL_PRIORITY_DATA;
+	set_arp_failure_handler(skb, abort_arp_failure);
+	req = (struct cpl_abort_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_REQ));
+	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ABORT_REQ, ep->hwtid));
+	req->cmd = CPL_ABORT_SEND_RST;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int send_connect(struct iwch_ep *ep)
+{
+	struct cpl_act_open_req *req;
+	struct sk_buff *skb;
+	u32 opt0h, opt0l, opt2;
+	unsigned int mtu_idx;
+	int wscale;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb.\n",
+		       __FUNCTION__);
+		return -ENOMEM;
+	}
+	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
+	wscale = compute_wscale(rcv_win);
+	opt0h = V_NAGLE(0) |
+	    V_NO_CONG(nocong) |
+	    V_KEEP_ALIVE(1) |
+	    F_TCAM_BYPASS |
+	    V_WND_SCALE(wscale) |
+	    V_MSS_IDX(mtu_idx) |
+	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
+	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
+	opt2 = V_FLAVORS_VALID(0) | V_CONG_CONTROL_FLAVOR(0);
+	skb->priority = CPL_PRIORITY_SETUP;
+	set_arp_failure_handler(skb, act_open_req_arp_failure);
+
+	req = (struct cpl_act_open_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ, ep->atid));
+	req->local_port = ep->com.local_addr.sin_port;
+	req->peer_port = ep->com.remote_addr.sin_port;
+	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
+	req->peer_ip = ep->com.remote_addr.sin_addr.s_addr;
+	req->opt0h = htonl(opt0h);
+	req->opt0l = htonl(opt0l);
+	req->params = 0;
+	req->opt2 = htonl(opt2);
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static void send_mpa_req(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	int mpalen;
+	struct tx_data_wr *req;
+	struct mpa_message *mpa;
+	int len;
+
+	PDBG("%s ep %p pd_len %d\n", __FUNCTION__, ep, ep->plen);
+
+	BUG_ON(skb_cloned(skb));
+
+	mpalen = sizeof(*mpa) + ep->plen;
+	if (skb->data + mpalen + sizeof(*req) > skb->end) {
+		kfree_skb(skb);
+		skb=alloc_skb(mpalen + sizeof(*req), GFP_KERNEL);
+		if (!skb) {
+			connect_reply_upcall(ep, -ENOMEM);
+			return;
+		}
+	}
+	skb_trim(skb, 0);
+	skb_reserve(skb, sizeof(*req));
+	skb_put(skb, mpalen);
+	skb->priority = CPL_PRIORITY_DATA;
+	mpa = (struct mpa_message *) skb->data;
+	memset(mpa, 0, sizeof(*mpa));
+	memcpy(mpa->key, MPA_KEY_REQ, sizeof(mpa->key));
+	mpa->flags = (crc_enabled ? MPA_CRC : 0) |
+		     (markers_enabled ? MPA_MARKERS : 0);
+	mpa->private_data_size = htons(ep->plen);
+	mpa->revision = mpa_rev;
+
+	if (ep->plen)
+		memcpy(mpa->private_data, ep->mpa_pkt + sizeof(*mpa), ep->plen);
+
+	/*
+	 * Reference the mpa skb.  This ensures the data area
+	 * will remain in memory until the hw acks the tx.
+	 * Function tx_ack() will deref it.
+	 */
+	skb_get(skb);
+	set_arp_failure_handler(skb, arp_failure_discard);
+	skb->h.raw = skb->data;
+	len = skb->len;
+	req = (struct tx_data_wr *) skb_push(skb, sizeof(*req));
+	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA));
+	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
+	req->len = htonl(len);
+	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
+			   V_TX_SNDBUF(snd_win>>15));
+	req->flags = htonl(F_TX_IMM_ACK|F_TX_INIT);
+	req->sndseq = htonl(ep->snd_seq);
+	BUG_ON(ep->mpa_skb);
+	ep->mpa_skb = skb;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	start_ep_timer(ep);
+	state_set(&ep->com, MPA_REQ_SENT);
+	return;
+}
+
+static int send_mpa_reject(struct iwch_ep *ep, const void *pdata, u8 plen)
+{
+	int mpalen;
+	struct tx_data_wr *req;
+	struct mpa_message *mpa;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p plen %d\n", __FUNCTION__, ep, plen);
+
+	mpalen = sizeof(*mpa) + plen;
+
+	skb = get_skb(NULL, mpalen + sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - cannot alloc skb!\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb_reserve(skb, sizeof(*req));
+	mpa = (struct mpa_message *) skb_put(skb, mpalen);
+	memset(mpa, 0, sizeof(*mpa));
+	memcpy(mpa->key, MPA_KEY_REP, sizeof(mpa->key));
+	mpa->flags = MPA_REJECT;
+	mpa->revision = mpa_rev;
+	mpa->private_data_size = htons(plen);
+	if (plen)
+		memcpy(mpa->private_data, pdata, plen);
+
+	/*
+	 * Reference the mpa skb again.  This ensures the data area
+	 * will remain in memory until the hw acks the tx.
+	 * Function tx_ack() will deref it.
+	 */
+	skb_get(skb);
+	skb->priority = CPL_PRIORITY_DATA;
+	set_arp_failure_handler(skb, arp_failure_discard);
+	skb->h.raw = skb->data;
+	req = (struct tx_data_wr *) skb_push(skb, sizeof(*req));
+	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA));
+	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
+	req->len = htonl(mpalen);
+	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
+			   V_TX_SNDBUF(snd_win>>15));
+	req->flags = htonl(F_TX_IMM_ACK|F_TX_INIT);
+	req->sndseq = htonl(ep->snd_seq);
+	BUG_ON(ep->mpa_skb);
+	ep->mpa_skb = skb;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int send_mpa_reply(struct iwch_ep *ep, const void *pdata, u8 plen)
+{
+	int mpalen;
+	struct tx_data_wr *req;
+	struct mpa_message *mpa;
+	int len;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p plen %d\n", __FUNCTION__, ep, plen);
+
+	mpalen = sizeof(*mpa) + plen;
+
+	skb = get_skb(NULL, mpalen + sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - cannot alloc skb!\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	skb->priority = CPL_PRIORITY_DATA;
+	skb_reserve(skb, sizeof(*req));
+	mpa = (struct mpa_message *) skb_put(skb, mpalen);
+	memset(mpa, 0, sizeof(*mpa));
+	memcpy(mpa->key, MPA_KEY_REP, sizeof(mpa->key));
+	mpa->flags = (ep->mpa_attr.crc_enabled ? MPA_CRC : 0) |
+		     (markers_enabled ? MPA_MARKERS : 0);
+	mpa->revision = mpa_rev;
+	mpa->private_data_size = htons(plen);
+	if (plen)
+		memcpy(mpa->private_data, pdata, plen);
+
+	/*
+	 * Reference the mpa skb.  This ensures the data area
+	 * will remain in memory until the hw acks the tx.
+	 * Function tx_ack() will deref it.
+	 */
+	skb_get(skb);
+	set_arp_failure_handler(skb, arp_failure_discard);
+	skb->h.raw = skb->data;
+	len = skb->len;
+	req = (struct tx_data_wr *) skb_push(skb, sizeof(*req));
+	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA));
+	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
+	req->len = htonl(len);
+	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
+			   V_TX_SNDBUF(snd_win>>15));
+	req->flags = htonl(F_TX_MORE | F_TX_IMM_ACK | F_TX_INIT);
+	req->sndseq = htonl(ep->snd_seq);
+	ep->mpa_skb = skb;
+	state_set(&ep->com, MPA_REP_SENT);
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+	return 0;
+}
+
+static int act_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_act_establish *req = cplhdr(skb);
+	unsigned int tid = GET_TID(req);
+
+	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, tid);
+
+	dst_confirm(ep->dst);
+
+	/* setup the hwtid for this connection */
+	ep->hwtid = tid;
+	cxgb3_insert_tid(ep->com.tdev, &t3c_client, ep, tid);
+
+	ep->snd_seq = ntohl(req->snd_isn);
+
+	set_emss(ep, ntohs(req->tcp_opt));
+
+	/* dealloc the atid */
+	cxgb3_free_atid(ep->com.tdev, ep->atid);
+
+	/* start MPA negotiation */
+	send_mpa_req(ep, skb);
+
+	return 0;
+}
+
+static void abort_connection(struct iwch_ep *ep, struct sk_buff *skb, gfp_t gfp)
+{
+	PDBG("%s ep %p\n", __FILE__, ep);
+	state_set(&ep->com, ABORTING);
+	send_abort(ep, skb, gfp);
+}
+
+static void close_complete_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CLOSE;
+	if (ep->com.cm_id) {
+		PDBG("close complete delivered ep %p cm_id %p tid %d\n",
+		     ep, ep->com.cm_id, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+	}
+}
+
+static void peer_close_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_DISCONNECT;
+	if (ep->com.cm_id) {
+		PDBG("peer close delivered ep %p cm_id %p tid %d\n",
+		     ep, ep->com.cm_id, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+	}
+}
+
+static void peer_abort_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CLOSE;
+	event.status = -ECONNRESET;
+	if (ep->com.cm_id) {
+		PDBG("abort delivered ep %p cm_id %p tid %d\n", ep,
+		     ep->com.cm_id, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+	}
+}
+
+static void connect_reply_upcall(struct iwch_ep *ep, int status)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p status %d\n", __FUNCTION__, ep, status);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CONNECT_REPLY;
+	event.status = status;
+	event.local_addr = ep->com.local_addr;
+	event.remote_addr = ep->com.remote_addr;
+
+	if ((status == 0) || (status == -ECONNREFUSED)) {
+		event.private_data_len = ep->plen;
+		event.private_data = ep->mpa_pkt + sizeof(struct mpa_message);
+	}
+	if (ep->com.cm_id) {
+		PDBG("%s ep %p tid %d status %d\n", __FUNCTION__, ep,
+		     ep->hwtid, status);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+	}
+	if (status < 0) {
+		ep->com.cm_id->rem_ref(ep->com.cm_id);
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+	}
+}
+
+static void connect_request_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, ep->hwtid);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_CONNECT_REQUEST;
+	event.local_addr = ep->com.local_addr;
+	event.remote_addr = ep->com.remote_addr;
+	event.private_data_len = ep->plen;
+	event.private_data = ep->mpa_pkt + sizeof(struct mpa_message);
+	event.provider_data = ep;
+	if (state_read(&ep->parent_ep->com) != DEAD)
+		ep->parent_ep->com.cm_id->event_handler(
+						ep->parent_ep->com.cm_id,
+						&event);
+	put_ep(&ep->parent_ep->com);
+	ep->parent_ep = NULL;
+}
+
+static void established_upcall(struct iwch_ep *ep)
+{
+	struct iw_cm_event event;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	memset(&event, 0, sizeof(event));
+	event.event = IW_CM_EVENT_ESTABLISHED;
+	if (ep->com.cm_id) {
+		PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, ep->hwtid);
+		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
+	}
+}
+
+static int update_rx_credits(struct iwch_ep *ep, u32 credits)
+{
+	struct cpl_rx_data_ack *req;
+	struct sk_buff *skb;
+
+	PDBG("%s ep %p credits %u\n", __FUNCTION__, ep, credits);
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "update_rx_credits - cannot alloc skb!\n");
+		return 0;
+	}
+
+	req = (struct cpl_rx_data_ack *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_RX_DATA_ACK, ep->hwtid));
+	req->credit_dack = htonl(V_RX_CREDITS(credits) | V_RX_FORCE_ACK(1));
+	skb->priority = CPL_PRIORITY_ACK;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return credits;
+}
+
+static void process_mpa_reply(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	struct mpa_message *mpa;
+	u16 plen;
+	struct iwch_qp_attributes attrs;
+	enum iwch_qp_attr_mask mask;
+	int err;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	/*
+ 	 * Stop mpa timer.  If it expired, then the state has
+	 * changed and we bail since ep_timeout already aborted
+	 * the connection.
+	 */
+	stop_ep_timer(ep);
+	if (state_read(&ep->com) != MPA_REQ_SENT)
+		return;
+
+	/*
+	 * If we get more than the supported amount of private data
+	 * then we must fail this connection.
+	 */
+	if (ep->mpa_pkt_len + skb->len > sizeof(ep->mpa_pkt)) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * copy the new data into our accumulation buffer.
+	 */
+	memcpy(&(ep->mpa_pkt[ep->mpa_pkt_len]), skb->data, skb->len);
+	ep->mpa_pkt_len += skb->len;
+
+	/*
+	 * if we don't even have the mpa message, then bail.
+	 */
+	if (ep->mpa_pkt_len < sizeof(*mpa))
+		return;
+	mpa = (struct mpa_message *) ep->mpa_pkt;
+
+	/* Validate MPA header. */
+	if (mpa->revision != mpa_rev) {
+		err = -EPROTO;
+		goto err;
+	}
+	if (memcmp(mpa->key, MPA_KEY_REP, sizeof(mpa->key))) {
+		err = -EPROTO;
+		goto err;
+	}
+
+	plen = ntohs(mpa->private_data_size);
+
+	/*
+	 * Fail if there's too much private data.
+	 */
+	if (plen > MPA_MAX_PRIVATE_DATA) {
+		err = -EPROTO;
+		goto err;
+	}
+
+	/*
+	 * If plen does not account for pkt size
+	 */
+	if (ep->mpa_pkt_len > (sizeof(*mpa) + plen)) {
+		err = -EPROTO;
+		goto err;
+	}
+
+	ep->plen = (u8) plen;
+
+	/*
+	 * If we don't have all the pdata yet, then bail.
+	 * We'll continue process when more data arrives.
+	 */
+	if (ep->mpa_pkt_len < (sizeof(*mpa) + plen))
+		return;
+
+	if (mpa->flags & MPA_REJECT) {
+		err = -ECONNREFUSED;
+		goto err;
+	}
+
+	/*
+	 * If we get here we have accumulated the entire mpa
+	 * start reply message including private data. And
+	 * the MPA header is valid.
+	 */
+	state_set(&ep->com, FPDU_MODE);
+	ep->mpa_attr.crc_enabled = (mpa->flags & MPA_CRC) | crc_enabled ? 1 : 0;
+	ep->mpa_attr.recv_marker_enabled = markers_enabled;
+	ep->mpa_attr.xmit_marker_enabled = mpa->flags & MPA_MARKERS ? 1 : 0;
+	ep->mpa_attr.version = mpa_rev;
+	PDBG("%s - crc_enabled=%d, recv_marker_enabled=%d, "
+	     "xmit_marker_enabled=%d, version=%d\n", __FUNCTION__,
+	     ep->mpa_attr.crc_enabled, ep->mpa_attr.recv_marker_enabled,
+	     ep->mpa_attr.xmit_marker_enabled, ep->mpa_attr.version);
+
+	attrs.mpa_attr = ep->mpa_attr;
+	attrs.max_ird = ep->ird;
+	attrs.max_ord = ep->ord;
+	attrs.llp_stream_handle = ep;
+	attrs.next_state = IWCH_QP_STATE_RTS;
+
+	mask = IWCH_QP_ATTR_NEXT_STATE |
+	    IWCH_QP_ATTR_LLP_STREAM_HANDLE | IWCH_QP_ATTR_MPA_ATTR |
+	    IWCH_QP_ATTR_MAX_IRD | IWCH_QP_ATTR_MAX_ORD;
+
+	/* bind QP and TID with INIT_WR */
+	err = iwch_modify_qp(ep->com.qp->rhp,
+			     ep->com.qp, mask, &attrs, 1);
+	if (!err)
+		goto out;
+err:
+	abort_connection(ep, skb, GFP_KERNEL);
+out:
+	connect_reply_upcall(ep, err);
+	return;
+}
+
+static void process_mpa_request(struct iwch_ep *ep, struct sk_buff *skb)
+{
+	struct mpa_message *mpa;
+	u16 plen;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	/*
+ 	 * Stop mpa timer.  If it expired, then the state has
+	 * changed and we bail since ep_timeout already aborted
+	 * the connection.
+	 */
+	stop_ep_timer(ep);
+	if (state_read(&ep->com) != MPA_REQ_WAIT)
+		return;
+
+	/*
+	 * If we get more than the supported amount of private data
+	 * then we must fail this connection.
+	 */
+	if (ep->mpa_pkt_len + skb->len > sizeof(ep->mpa_pkt)) {
+		abort_connection(ep, skb, GFP_KERNEL);
+		return;
+	}
+
+	PDBG("%s enter (%s line %u)\n", __FUNCTION__, __FILE__, __LINE__);
+
+	/*
+	 * Copy the new data into our accumulation buffer.
+	 */
+	memcpy(&(ep->mpa_pkt[ep->mpa_pkt_len]), skb->data, skb->len);
+	ep->mpa_pkt_len += skb->len;
+
+	/*
+	 * If we don't even have the mpa message, then bail.
+	 * We'll continue process when more data arrives.
+	 */
+	if (ep->mpa_pkt_len < sizeof(*mpa))
+		return;
+	PDBG("%s enter (%s line %u)\n", __FUNCTION__, __FILE__, __LINE__);
+	mpa = (struct mpa_message *) ep->mpa_pkt;
+
+	/*
+	 * Validate MPA Header.
+	 */
+	if (mpa->revision != mpa_rev) {
+		abort_connection(ep, skb, GFP_KERNEL);
+		return;
+	}
+
+	if (memcmp(mpa->key, MPA_KEY_REQ, sizeof(mpa->key))) {
+		abort_connection(ep, skb, GFP_KERNEL);
+		return;
+	}
+
+	plen = ntohs(mpa->private_data_size);
+
+	/*
+	 * Fail if there's too much private data.
+	 */
+	if (plen > MPA_MAX_PRIVATE_DATA) {
+		abort_connection(ep, skb, GFP_KERNEL);
+		return;
+	}
+
+	/*
+	 * If plen does not account for pkt size
+	 */
+	if (ep->mpa_pkt_len > (sizeof(*mpa) + plen)) {
+		abort_connection(ep, skb, GFP_KERNEL);
+		return;
+	}
+	ep->plen = (u8) plen;
+
+	/*
+	 * If we don't have all the pdata yet, then bail.
+	 */
+	if (ep->mpa_pkt_len < (sizeof(*mpa) + plen))
+		return;
+
+	/*
+	 * If we get here we have accumulated the entire mpa
+	 * start reply message including private data.
+	 */
+	ep->mpa_attr.crc_enabled = (mpa->flags & MPA_CRC) | crc_enabled ? 1 : 0;
+	ep->mpa_attr.recv_marker_enabled = markers_enabled;
+	ep->mpa_attr.xmit_marker_enabled = mpa->flags & MPA_MARKERS ? 1 : 0;
+	ep->mpa_attr.version = mpa_rev;
+	PDBG("%s - crc_enabled=%d, recv_marker_enabled=%d, "
+	     "xmit_marker_enabled=%d, version=%d\n", __FUNCTION__,
+	     ep->mpa_attr.crc_enabled, ep->mpa_attr.recv_marker_enabled,
+	     ep->mpa_attr.xmit_marker_enabled, ep->mpa_attr.version);
+
+	state_set(&ep->com, MPA_REQ_RCVD);
+
+	/* drive upcall */
+	connect_request_upcall(ep);
+	return;
+}
+
+static int rx_data(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_rx_data *hdr = cplhdr(skb);
+	unsigned int dlen = ntohs(hdr->len);
+
+	PDBG("%s ep %p dlen %u\n", __FUNCTION__, ep, dlen);
+
+	skb_pull(skb, sizeof(*hdr));
+	skb_trim(skb, dlen);
+
+	switch (state_read(&ep->com)) {
+	case MPA_REQ_SENT:
+		process_mpa_reply(ep, skb);
+		break;
+	case MPA_REQ_WAIT:
+		process_mpa_request(ep, skb);
+		break;
+	case MPA_REP_SENT:
+		break;
+	default:
+		printk(KERN_ERR MOD "%s Unexpected streaming data."
+		       " ep %p state %d tid %d\n",
+		       __FUNCTION__, ep, state_read(&ep->com), ep->hwtid);
+
+		/*
+	 	 * The ep will timeout and inform the ULP of the failure.
+		 * See ep_timeout().
+	 	 */
+		break;
+	}
+
+	/* update RX credits */
+	update_rx_credits(ep, dlen);
+
+	return CPL_RET_BUF_DONE;
+}
+
+/*
+ * Upcall from the adapter indicating data has been transmitted.
+ * For us its just the single MPA request or reply.  We can now free
+ * the skb holding the mpa message.
+ */
+static int tx_ack(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_wr_ack *hdr = cplhdr(skb);
+	unsigned int credits = ntohs(hdr->credits);
+	enum iwch_qp_attr_mask  mask;
+
+	PDBG("%s ep %p credits %u\n", __FUNCTION__, ep, credits);
+
+	if (credits == 0)
+		return CPL_RET_BUF_DONE;
+	BUG_ON(credits != 1);
+	BUG_ON(ep->mpa_skb == NULL);
+	kfree_skb(ep->mpa_skb);
+	ep->mpa_skb = NULL;
+	dst_confirm(ep->dst);
+	if (state_read(&ep->com) == MPA_REP_SENT) {
+		struct iwch_qp_attributes attrs;
+
+		/* bind QP to EP and move to RTS */
+		attrs.mpa_attr = ep->mpa_attr;
+		attrs.max_ird = ep->ord;
+		attrs.max_ord = ep->ord;
+		attrs.llp_stream_handle = ep;
+		attrs.next_state = IWCH_QP_STATE_RTS;
+
+		/* bind QP and TID with INIT_WR */
+		mask = IWCH_QP_ATTR_NEXT_STATE |
+				     IWCH_QP_ATTR_LLP_STREAM_HANDLE |
+				     IWCH_QP_ATTR_MPA_ATTR |
+				     IWCH_QP_ATTR_MAX_IRD |
+				     IWCH_QP_ATTR_MAX_ORD;
+
+		ep->com.rpl_err = iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, mask, &attrs, 1);
+
+		if (!ep->com.rpl_err) {
+			state_set(&ep->com, FPDU_MODE);
+			established_upcall(ep);
+		}
+
+		ep->com.rpl_done = 1;
+		PDBG("waking up ep %p\n", ep);
+		wake_up(&ep->com.waitq);
+	}
+	return CPL_RET_BUF_DONE;
+}
+
+static int abort_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	close_complete_upcall(ep);
+	state_set(&ep->com, DEAD);
+	release_ep_resources(ep);
+	return CPL_RET_BUF_DONE;
+}
+
+static int act_open_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_act_open_rpl *rpl = cplhdr(skb);
+
+	PDBG("%s ep %p status %u errno %d\n", __FUNCTION__, ep, rpl->status,
+	     status2errno(rpl->status));
+	connect_reply_upcall(ep, status2errno(rpl->status));
+	state_set(&ep->com, DEAD);
+	if (ep->com.tdev->type == T3B)
+		release_tid(ep->com.tdev, GET_TID(rpl), NULL);
+	cxgb3_free_atid(ep->com.tdev, ep->atid);
+	dst_release(ep->dst);
+	l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+	put_ep(&ep->com);
+	return CPL_RET_BUF_DONE;
+}
+
+static int listen_start(struct iwch_listen_ep *ep)
+{
+	struct sk_buff *skb;
+	struct cpl_pass_open_req *req;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "t3c_listen_start failed to alloc skb!\n");
+		return -ENOMEM;
+	}
+
+	req = (struct cpl_pass_open_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_PASS_OPEN_REQ, ep->stid));
+	req->local_port = ep->com.local_addr.sin_port;
+	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
+	req->peer_port = 0;
+	req->peer_ip = 0;
+	req->peer_netmask = 0;
+	req->opt0h = htonl(F_DELACK | F_TCAM_BYPASS);
+	req->opt0l = htonl(V_RCV_BUFSIZ(rcv_win>>10));
+	req->opt1 = htonl(V_CONN_POLICY(CPL_CONN_POLICY_ASK));
+
+	skb->priority = 1;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+static int pass_open_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_listen_ep *ep = ctx;
+	struct cpl_pass_open_rpl *rpl = cplhdr(skb);
+
+	PDBG("%s ep %p status %d error %d\n", __FUNCTION__, ep,
+	     rpl->status, status2errno(rpl->status));
+	ep->com.rpl_err = status2errno(rpl->status);
+	ep->com.rpl_done = 1;
+	wake_up(&ep->com.waitq);
+
+	return CPL_RET_BUF_DONE;
+}
+
+static int listen_stop(struct iwch_listen_ep *ep)
+{
+	struct sk_buff *skb;
+	struct cpl_close_listserv_req *req;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
+	if (!skb) {
+		printk(KERN_ERR MOD "%s - failed to alloc skb\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	req = (struct cpl_close_listserv_req *) skb_put(skb, sizeof(*req));
+	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_LISTSRV_REQ, ep->stid));
+	skb->priority = 1;
+	ep->com.tdev->send(ep->com.tdev, skb);
+	return 0;
+}
+
+static int close_listsrv_rpl(struct t3cdev *tdev, struct sk_buff *skb,
+			     void *ctx)
+{
+	struct iwch_listen_ep *ep = ctx;
+	struct cpl_close_listserv_rpl *rpl = cplhdr(skb);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	ep->com.rpl_err = status2errno(rpl->status);
+	ep->com.rpl_done = 1;
+	wake_up(&ep->com.waitq);
+	return CPL_RET_BUF_DONE;
+}
+
+static void accept_cr(struct iwch_ep *ep, __be32 peer_ip, struct sk_buff *skb)
+{
+	struct cpl_pass_accept_rpl *rpl;
+	unsigned int mtu_idx;
+	u32 opt0h, opt0l, opt2;
+	int wscale;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	BUG_ON(skb_cloned(skb));
+	skb_trim(skb, sizeof(*rpl));
+	skb_get(skb);
+	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
+	wscale = compute_wscale(rcv_win);
+	opt0h = V_NAGLE(0) |
+	    V_NO_CONG(nocong) |
+	    V_KEEP_ALIVE(1) |
+	    F_TCAM_BYPASS |
+	    V_WND_SCALE(wscale) |
+	    V_MSS_IDX(mtu_idx) |
+	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
+	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
+	opt2 = V_FLAVORS_VALID(0) | V_CONG_CONTROL_FLAVOR(0);
+
+	rpl = cplhdr(skb);
+	rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+	OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL, ep->hwtid));
+	rpl->peer_ip = peer_ip;
+	rpl->opt0h = htonl(opt0h);
+	rpl->opt0l_status = htonl(opt0l | CPL_PASS_OPEN_ACCEPT);
+	rpl->opt2 = htonl(opt2);
+	rpl->rsvd = rpl->opt2;	/* workaround for HW bug */
+	skb->priority = CPL_PRIORITY_SETUP;
+	l2t_send(ep->com.tdev, skb, ep->l2t);
+
+	return;
+}
+
+static void reject_cr(struct t3cdev *tdev, u32 hwtid, __be32 peer_ip,
+		      struct sk_buff *skb)
+{
+	PDBG("%s t3cdev %p tid %u peer_ip %x\n", __FUNCTION__, tdev, hwtid,
+	     peer_ip);
+	BUG_ON(skb_cloned(skb));
+	skb_trim(skb, sizeof(struct cpl_tid_release));
+	skb_get(skb);
+
+	if (tdev->type == T3B)
+		release_tid(tdev, hwtid, skb);
+	else {
+		struct cpl_pass_accept_rpl *rpl;
+
+		rpl = cplhdr(skb);
+		skb->priority = CPL_PRIORITY_SETUP;
+		rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
+		OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL,
+						      hwtid));
+		rpl->peer_ip = peer_ip;
+		rpl->opt0h = htonl(F_TCAM_BYPASS);
+		rpl->opt0l_status = htonl(CPL_PASS_OPEN_REJECT);
+		rpl->opt2 = 0;
+		rpl->rsvd = rpl->opt2;
+		tdev->send(tdev, skb);
+	}
+}
+
+static int pass_accept_req(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *child_ep, *parent_ep = ctx;
+	struct cpl_pass_accept_req *req = cplhdr(skb);
+	unsigned int hwtid = GET_TID(req);
+	struct dst_entry *dst;
+	struct l2t_entry *l2t;
+	struct rtable *rt;
+	struct iff_mac tim;
+
+	PDBG("%s parent ep %p tid %u\n", __FUNCTION__, parent_ep, hwtid);
+
+	if (state_read(&parent_ep->com) != LISTEN) {
+		printk(KERN_ERR "%s - listening ep not in LISTEN\n",
+		       __FUNCTION__);
+		goto reject;
+	}
+
+	/*
+	 * Find the netdev for this connection request.
+	 */
+	tim.mac_addr = req->dst_mac;
+	tim.vlan_tag = ntohs(req->vlan_tag);
+	if (tdev->ctl(tdev, GET_IFF_FROM_MAC, &tim) < 0 || !tim.dev) {
+		printk(KERN_ERR
+			"%s bad dst mac %02x %02x %02x %02x %02x %02x\n",
+			__FUNCTION__,
+			req->dst_mac[0],
+			req->dst_mac[1],
+			req->dst_mac[2],
+			req->dst_mac[3],
+			req->dst_mac[4],
+			req->dst_mac[5]);
+		goto reject;
+	}
+
+	/* Find output route */
+	rt = find_route(tdev,
+			req->local_ip,
+			req->peer_ip,
+			req->local_port,
+			req->peer_port, G_PASS_OPEN_TOS(ntohl(req->tos_tid)));
+	if (!rt) {
+		printk(KERN_ERR MOD "%s - failed to find dst entry!\n",
+		       __FUNCTION__);
+		goto reject;
+	}
+	dst = &rt->u.dst;
+	l2t = t3_l2t_get(tdev, dst->neighbour, dst->neighbour->dev);
+	if (!l2t) {
+		printk(KERN_ERR MOD "%s - failed to allocate l2t entry!\n",
+		       __FUNCTION__);
+		dst_release(dst);
+		goto reject;
+	}
+	child_ep = alloc_ep(sizeof(*child_ep), GFP_KERNEL);
+	if (!child_ep) {
+		printk(KERN_ERR MOD "%s - failed to allocate ep entry!\n",
+		       __FUNCTION__);
+		l2t_release(L2DATA(tdev), l2t);
+		dst_release(dst);
+		goto reject;
+	}
+	state_set(&child_ep->com, CONNECTING);
+	child_ep->com.tdev = tdev;
+	child_ep->com.cm_id = NULL;
+	child_ep->com.local_addr.sin_family = PF_INET;
+	child_ep->com.local_addr.sin_port = req->local_port;
+	child_ep->com.local_addr.sin_addr.s_addr = req->local_ip;
+	child_ep->com.remote_addr.sin_family = PF_INET;
+	child_ep->com.remote_addr.sin_port = req->peer_port;
+	child_ep->com.remote_addr.sin_addr.s_addr = req->peer_ip;
+	get_ep(&parent_ep->com);
+	child_ep->parent_ep = parent_ep;
+	child_ep->tos = G_PASS_OPEN_TOS(ntohl(req->tos_tid));
+	child_ep->l2t = l2t;
+	child_ep->dst = dst;
+	child_ep->hwtid = hwtid;
+	init_timer(&child_ep->timer);
+	cxgb3_insert_tid(tdev, &t3c_client, child_ep, hwtid);
+	accept_cr(child_ep, req->peer_ip, skb);
+	goto out;
+reject:
+	reject_cr(tdev, hwtid, req->peer_ip, skb);
+out:
+	return CPL_RET_BUF_DONE;
+}
+
+static int pass_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct cpl_pass_establish *req = cplhdr(skb);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	ep->snd_seq = ntohl(req->snd_isn);
+
+	set_emss(ep, ntohs(req->tcp_opt));
+
+	dst_confirm(ep->dst);
+	state_set(&ep->com, MPA_REQ_WAIT);
+	start_ep_timer(ep);
+
+	return CPL_RET_BUF_DONE;
+}
+
+static int peer_close(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct iwch_qp_attributes attrs;
+	unsigned long flags;
+	int disconnect = 1;
+	int release = 0;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	dst_confirm(ep->dst);
+
+	spin_lock_irqsave(&ep->com.lock, flags);
+	switch (ep->com.state) {
+	case MPA_REQ_WAIT:
+		__state_set(&ep->com, CLOSING);
+		break;
+	case MPA_REQ_SENT:
+		__state_set(&ep->com, CLOSING);
+		connect_reply_upcall(ep, -ECONNRESET);
+		break;
+	case MPA_REQ_RCVD:
+
+		/*
+		 * We're gonna mark this puppy DEAD, but keep
+		 * the reference on it until the ULP accepts or
+		 * rejects the CR.
+		 */
+		__state_set(&ep->com, CLOSING);
+		get_ep(&ep->com);
+		break;
+	case MPA_REP_SENT:
+		__state_set(&ep->com, CLOSING);
+		ep->com.rpl_done = 1;
+		ep->com.rpl_err = -ECONNRESET;
+		PDBG("waking up ep %p\n", ep);
+		wake_up(&ep->com.waitq);
+		break;
+	case FPDU_MODE:
+		__state_set(&ep->com, CLOSING);
+		attrs.next_state = IWCH_QP_STATE_CLOSING;
+		iwch_modify_qp(ep->com.qp->rhp, ep->com.qp,
+			       IWCH_QP_ATTR_NEXT_STATE, &attrs, 1);
+		peer_close_upcall(ep);
+		break;
+	case ABORTING:
+		disconnect = 0;
+		break;
+	case CLOSING:
+		start_ep_timer(ep);
+		__state_set(&ep->com, MORIBUND);
+		disconnect = 0;
+		break;
+	case MORIBUND:
+		stop_ep_timer(ep);
+		if (ep->com.cm_id && ep->com.qp) {
+			attrs.next_state = IWCH_QP_STATE_IDLE;
+			iwch_modify_qp(ep->com.qp->rhp, ep->com.qp,
+				       IWCH_QP_ATTR_NEXT_STATE, &attrs, 1);
+		}
+		close_complete_upcall(ep);
+		__state_set(&ep->com, DEAD);
+		release = 1;
+		disconnect = 0;
+		break;
+	case DEAD:
+		disconnect = 0;
+		break;
+	default:
+		BUG_ON(1);
+	}
+	spin_unlock_irqrestore(&ep->com.lock, flags);
+	if (disconnect)
+		iwch_ep_disconnect(ep, 0, GFP_KERNEL);	
+	if (release)
+		release_ep_resources(ep);
+	return CPL_RET_BUF_DONE;
+}
+
+/*
+ * Returns whether an ABORT_REQ_RSS message is a negative advice.
+ */
+static inline int is_neg_adv_abort(unsigned int status)
+{
+        return status == CPL_ERR_RTX_NEG_ADVICE ||
+               status == CPL_ERR_PERSIST_NEG_ADVICE;
+}
+
+static int peer_abort(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct cpl_abort_req_rss *req = cplhdr(skb);
+	struct iwch_ep *ep = ctx;
+	struct cpl_abort_rpl *rpl;
+	struct sk_buff *rpl_skb;
+	struct iwch_qp_attributes attrs;
+	int ret;
+	int state;
+
+	if (is_neg_adv_abort(req->status)) {
+		PDBG("%s neg_adv_abort ep %p tid %d\n", __FUNCTION__, ep,
+		     ep->hwtid);
+		t3_l2t_send_event(ep->com.tdev, ep->l2t);
+		return CPL_RET_BUF_DONE;
+	}
+
+	state = state_read(&ep->com);
+	PDBG("%s ep %p state %u\n", __FUNCTION__, ep, state);
+	switch (state) {
+	case CONNECTING:
+		break;
+	case MPA_REQ_WAIT:
+		break;
+	case MPA_REQ_SENT:
+		connect_reply_upcall(ep, -ECONNRESET);
+		break;
+	case MPA_REP_SENT:
+		ep->com.rpl_done = 1;
+		ep->com.rpl_err = -ECONNRESET;
+		PDBG("waking up ep %p\n", ep);
+		wake_up(&ep->com.waitq);
+		break;
+	case MPA_REQ_RCVD:
+	
+		/*
+		 * We're gonna mark this puppy DEAD, but keep
+		 * the reference on it until the ULP accepts or
+		 * rejects the CR.
+		 */
+		get_ep(&ep->com);
+		break;
+	case MORIBUND:
+		stop_ep_timer(ep);
+	case FPDU_MODE:
+	case CLOSING:
+		if (ep->com.cm_id && ep->com.qp) {
+			attrs.next_state = IWCH_QP_STATE_ERROR;
+			ret = iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+				     &attrs, 1);
+			if (ret)
+				printk(KERN_ERR MOD
+				       "%s - qp <- error failed!\n",
+				       __FUNCTION__);
+		}
+		peer_abort_upcall(ep);
+		break;
+	case ABORTING:
+		break;
+	case DEAD:
+		PDBG("%s PEER_ABORT IN DEAD STATE!!!!\n", __FUNCTION__);
+		return CPL_RET_BUF_DONE;
+	default:
+		BUG_ON(1);
+		break;
+	}
+	dst_confirm(ep->dst);
+	
+	rpl_skb = get_skb(skb, sizeof(*rpl), GFP_KERNEL);
+	if (!rpl_skb) {
+		printk(KERN_ERR MOD "%s - cannot allocate skb!\n",
+		       __FUNCTION__);
+		dst_release(ep->dst);
+		l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+		put_ep(&ep->com);
+		return CPL_RET_BUF_DONE;
+	}
+	rpl_skb->priority = CPL_PRIORITY_DATA;
+	rpl = (struct cpl_abort_rpl *) skb_put(rpl_skb, sizeof(*rpl));
+	rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_RPL));
+	rpl->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
+	OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_ABORT_RPL, ep->hwtid));
+	rpl->cmd = CPL_ABORT_NO_RST;
+	ep->com.tdev->send(ep->com.tdev, rpl_skb);
+	if (state != ABORTING) {
+		state_set(&ep->com, DEAD);
+		release_ep_resources(ep);
+	}
+	return CPL_RET_BUF_DONE;
+}
+
+static int close_con_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+	struct iwch_qp_attributes attrs;
+	unsigned long flags;
+	int release = 0;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	BUG_ON(!ep);
+
+	/* The cm_id may be null if we failed to connect */
+	spin_lock_irqsave(&ep->com.lock, flags);
+	switch (ep->com.state) {
+	case CLOSING:
+		start_ep_timer(ep);
+		__state_set(&ep->com, MORIBUND);
+		break;
+	case MORIBUND:
+		stop_ep_timer(ep);
+		if ((ep->com.cm_id) && (ep->com.qp)) {
+			attrs.next_state = IWCH_QP_STATE_IDLE;
+			iwch_modify_qp(ep->com.qp->rhp,
+					     ep->com.qp,
+					     IWCH_QP_ATTR_NEXT_STATE,
+					     &attrs, 1);
+		}
+		close_complete_upcall(ep);
+		__state_set(&ep->com, DEAD);
+		release = 1;
+		break;
+	case DEAD:
+	default:
+		BUG_ON(1);
+		break;
+	}
+	spin_unlock_irqrestore(&ep->com.lock, flags);
+	if (release)
+		release_ep_resources(ep);
+	return CPL_RET_BUF_DONE;
+}
+
+/*
+ * T3A does 3 things when a TERM is received:
+ * 1) send up a CPL_RDMA_TERMINATE message with the TERM packet
+ * 2) generate an async event on the QP with the TERMINATE opcode
+ * 3) post a TERMINATE opcde cqe into the associated CQ.
+ *
+ * For (1), we save the message in the qp for later consumer consumption.
+ * For (2), we move the QP into TERMINATE, post a QP event and disconnect.
+ * For (3), we toss the CQE in cxio_poll_cq().
+ *
+ * terminate() handles case (1)...
+ */
+static int terminate(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep *ep = ctx;
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	skb_pull(skb, sizeof(struct cpl_rdma_terminate));
+	PDBG("%s saving %d bytes of term msg\n", __FUNCTION__, skb->len);
+	memcpy(ep->com.qp->attr.terminate_buffer, skb->data, skb->len);
+	ep->com.qp->attr.terminate_msg_len = skb->len;
+	ep->com.qp->attr.is_terminate_local = 0;
+	return CPL_RET_BUF_DONE;
+}
+
+static int ec_status(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct cpl_rdma_ec_status *rep = cplhdr(skb);
+	struct iwch_ep *ep = ctx;
+
+	PDBG("%s ep %p tid %u status %d\n", __FUNCTION__, ep, ep->hwtid,
+	     rep->status);
+	if (rep->status) {
+		struct iwch_qp_attributes attrs;
+
+		printk(KERN_ERR MOD "%s BAD CLOSE - Aborting tid %u\n",
+		       __FUNCTION__, ep->hwtid);
+		attrs.next_state = IWCH_QP_STATE_ERROR;
+		iwch_modify_qp(ep->com.qp->rhp,
+			       ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+			       &attrs, 1);
+		abort_connection(ep, NULL, GFP_KERNEL);
+	}
+	return CPL_RET_BUF_DONE;
+}
+
+static void ep_timeout(unsigned long arg)
+{
+	struct iwch_ep *ep = (struct iwch_ep *)arg;
+	struct iwch_qp_attributes attrs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ep->com.lock, flags);
+	PDBG("%s ep %p tid %u state %d\n", __FUNCTION__, ep, ep->hwtid,
+	     ep->com.state);
+	switch (ep->com.state) {
+	case MPA_REQ_SENT:
+		connect_reply_upcall(ep, -ETIMEDOUT);
+		break;
+	case MPA_REQ_WAIT:
+		break;
+	case MORIBUND:
+		if (ep->com.cm_id && ep->com.qp) {
+			attrs.next_state = IWCH_QP_STATE_ERROR;
+			iwch_modify_qp(ep->com.qp->rhp,
+				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
+				     &attrs, 1);
+		}
+		break;
+	default:
+		BUG();
+	}
+	__state_set(&ep->com, CLOSING);
+	spin_unlock_irqrestore(&ep->com.lock, flags);
+	abort_connection(ep, NULL, GFP_ATOMIC);
+	put_ep(&ep->com);
+}
+
+int iwch_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len)
+{
+	int err;
+	struct iwch_ep *ep = to_ep(cm_id);
+	PDBG("%s ep %p tid %u\n", __FUNCTION__, ep, ep->hwtid);
+
+	if (state_read(&ep->com) == DEAD) {
+		put_ep(&ep->com);
+		return -ECONNRESET;
+	}
+	BUG_ON(state_read(&ep->com) != MPA_REQ_RCVD);
+	state_set(&ep->com, CLOSING);
+	if (mpa_rev == 0)
+		abort_connection(ep, NULL, GFP_KERNEL);
+	else {
+		err = send_mpa_reject(ep, pdata, pdata_len);
+		err = send_halfclose(ep, GFP_KERNEL);
+	}
+	return 0;
+}
+
+int iwch_accept_cr(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
+{
+	int err;
+	struct iwch_qp_attributes attrs;
+	enum iwch_qp_attr_mask mask;
+	struct iwch_ep *ep = to_ep(cm_id);
+	struct iwch_dev *h = to_iwch_dev(cm_id->device);
+	struct iwch_qp *qp = get_qhp(h, conn_param->qpn);
+
+	PDBG("%s ep %p tid %u\n", __FUNCTION__, ep, ep->hwtid);
+	if (state_read(&ep->com) == DEAD) {
+		put_ep(&ep->com);
+		return -ECONNRESET;
+	}
+
+	BUG_ON(state_read(&ep->com) != MPA_REQ_RCVD);
+	BUG_ON(!qp);
+
+	if ((conn_param->ord > qp->rhp->attr.max_rdma_read_qp_depth) ||
+	    (conn_param->ird > qp->rhp->attr.max_rdma_reads_per_qp)) {
+		abort_connection(ep, NULL, GFP_KERNEL);
+		return -EINVAL;
+	}
+
+	cm_id->add_ref(cm_id);
+	ep->com.cm_id = cm_id;
+	ep->com.qp = qp;
+
+	ep->com.rpl_done = 0;
+	ep->com.rpl_err = 0;
+	ep->ird = conn_param->ird;
+	ep->ord = conn_param->ord;
+	PDBG("%s %d ird %d ord %d\n", __FUNCTION__, __LINE__, ep->ird, ep->ord);
+	get_ep(&ep->com);
+	err = send_mpa_reply(ep, conn_param->private_data,
+			     conn_param->private_data_len);
+	if (err) {
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+		cm_id->rem_ref(cm_id);
+		abort_connection(ep, NULL, GFP_KERNEL);
+		put_ep(&ep->com);
+		return err;
+	}
+	
+	/* bind QP to EP and move to RTS */
+	attrs.mpa_attr = ep->mpa_attr;
+	attrs.max_ird = ep->ord;
+	attrs.max_ord = ep->ord;
+	attrs.llp_stream_handle = ep;
+	attrs.next_state = IWCH_QP_STATE_RTS;
+
+	/* bind QP and TID with INIT_WR */
+	mask = IWCH_QP_ATTR_NEXT_STATE |
+			     IWCH_QP_ATTR_LLP_STREAM_HANDLE |
+			     IWCH_QP_ATTR_MPA_ATTR |
+			     IWCH_QP_ATTR_MAX_IRD |
+			     IWCH_QP_ATTR_MAX_ORD;
+
+	err = iwch_modify_qp(ep->com.qp->rhp,
+			     ep->com.qp, mask, &attrs, 1);
+
+	if (err) {
+		ep->com.cm_id = NULL;
+		ep->com.qp = NULL;
+		cm_id->rem_ref(cm_id);
+		abort_connection(ep, NULL, GFP_KERNEL);
+	} else {
+		state_set(&ep->com, FPDU_MODE);
+		established_upcall(ep);
+	}
+	put_ep(&ep->com);
+	return err;
+}
+
+int iwch_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
+{
+	int err = 0;
+	struct iwch_dev *h = to_iwch_dev(cm_id->device);
+	struct iwch_ep *ep;
+	struct rtable *rt;
+
+	ep = alloc_ep(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		printk(KERN_ERR MOD "%s - cannot alloc ep.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto out;
+	}
+	init_timer(&ep->timer);
+	ep->plen = conn_param->private_data_len;
+	if (ep->plen)
+		memcpy(ep->mpa_pkt + sizeof(struct mpa_message),
+		       conn_param->private_data, ep->plen);
+	ep->ird = conn_param->ird;
+	ep->ord = conn_param->ord;
+	ep->com.tdev = h->rdev.t3cdev_p;
+
+	cm_id->add_ref(cm_id);
+	ep->com.cm_id = cm_id;
+	ep->com.qp = get_qhp(h, conn_param->qpn);
+	BUG_ON(!ep->com.qp);
+	PDBG("%s qpn 0x%x qp %p cm_id %p\n", __FUNCTION__, conn_param->qpn,
+	     ep->com.qp, cm_id);
+
+	/*
+	 * Allocate an active TID to initiate a TCP connection.
+	 */
+	ep->atid = cxgb3_alloc_atid(h->rdev.t3cdev_p, &t3c_client, ep);
+	if (ep->atid == -1) {
+		printk(KERN_ERR MOD "%s - cannot alloc atid.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	/* find a route */
+	rt = find_route(h->rdev.t3cdev_p,
+			cm_id->local_addr.sin_addr.s_addr,
+			cm_id->remote_addr.sin_addr.s_addr,
+			cm_id->local_addr.sin_port,
+			cm_id->remote_addr.sin_port, IPTOS_LOWDELAY);
+	if (!rt) {
+		printk(KERN_ERR MOD "%s - cannot find route.\n", __FUNCTION__);
+		err = -EHOSTUNREACH;
+		goto fail3;
+	}
+	ep->dst = &rt->u.dst;
+
+	/* get a l2t entry */
+	ep->l2t = t3_l2t_get(ep->com.tdev, ep->dst->neighbour,
+			     ep->dst->neighbour->dev);
+	if (!ep->l2t) {
+		printk(KERN_ERR MOD "%s - cannot alloc l2e.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail4;
+	}
+
+	state_set(&ep->com, CONNECTING);
+	ep->tos = IPTOS_LOWDELAY;
+	ep->com.local_addr = cm_id->local_addr;
+	ep->com.remote_addr = cm_id->remote_addr;
+
+	/* send connect request to rnic */
+	err = send_connect(ep);
+	if (!err)
+		goto out;
+
+	l2t_release(L2DATA(h->rdev.t3cdev_p), ep->l2t);
+fail4:
+	dst_release(ep->dst);
+fail3:
+	cxgb3_free_atid(ep->com.tdev, ep->atid);
+fail2:
+	put_ep(&ep->com);
+out:
+	return err;
+}
+
+int iwch_create_listen(struct iw_cm_id *cm_id, int backlog)
+{
+	int err = 0;
+	struct iwch_dev *h = to_iwch_dev(cm_id->device);
+	struct iwch_listen_ep *ep;
+
+
+	might_sleep();
+
+	ep = alloc_ep(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		printk(KERN_ERR MOD "%s - cannot alloc ep.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail1;
+	}
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+	ep->com.tdev = h->rdev.t3cdev_p;
+	cm_id->add_ref(cm_id);
+	ep->com.cm_id = cm_id;
+	ep->backlog = backlog;
+	ep->com.local_addr = cm_id->local_addr;
+
+	/*
+	 * Allocate a server TID.
+	 */
+	ep->stid = cxgb3_alloc_stid(h->rdev.t3cdev_p, &t3c_client, ep);
+	if (ep->stid == -1) {
+		printk(KERN_ERR MOD "%s - cannot alloc atid.\n", __FUNCTION__);
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	state_set(&ep->com, LISTEN);
+	err = listen_start(ep);
+	if (err)
+		goto fail3;
+
+	/* wait for pass_open_rpl */
+	wait_event(ep->com.waitq, ep->com.rpl_done);
+	err = ep->com.rpl_err;
+	if (!err) {
+		cm_id->provider_data = ep;
+		goto out;
+	}
+fail3:
+	cxgb3_free_stid(ep->com.tdev, ep->stid);
+fail2:
+	put_ep(&ep->com);
+fail1:
+out:
+	return err;
+}
+
+int iwch_destroy_listen(struct iw_cm_id *cm_id)
+{
+	int err;
+	struct iwch_listen_ep *ep = to_listen_ep(cm_id);
+
+	PDBG("%s ep %p\n", __FUNCTION__, ep);
+
+	might_sleep();
+	state_set(&ep->com, DEAD);
+	ep->com.rpl_done = 0;
+	ep->com.rpl_err = 0;
+	err = listen_stop(ep);
+	wait_event(ep->com.waitq, ep->com.rpl_done);
+	cxgb3_free_stid(ep->com.tdev, ep->stid);
+	err = ep->com.rpl_err;
+	cm_id->rem_ref(cm_id);
+	put_ep(&ep->com);
+	return err;
+}
+
+int iwch_ep_disconnect(struct iwch_ep *ep, int abrupt, gfp_t gfp)
+{
+	int ret=0;
+	unsigned long flags;
+	int close = 0;
+	
+	spin_lock_irqsave(&ep->com.lock, flags);
+
+	PDBG("%s ep %p state %s, abrupt %d\n", __FUNCTION__, ep,
+	     states[ep->com.state], abrupt);
+
+	if (ep->com.state == DEAD) {
+		PDBG("%s already dead ep %p\n", __FUNCTION__, ep);
+		goto out;
+	}
+
+	if (abrupt) {
+		if (ep->com.state != ABORTING) {
+			ep->com.state = ABORTING;
+			close = 1;
+		}
+		goto out;
+	}
+	
+	switch (ep->com.state) {
+	case MPA_REQ_WAIT:
+	case MPA_REQ_SENT:
+	case MPA_REQ_RCVD:
+	case MPA_REP_SENT:
+	case FPDU_MODE:
+		ep->com.state = CLOSING;
+		close = 1;
+		break;
+	case CLOSING:
+		start_ep_timer(ep);
+		ep->com.state = MORIBUND;
+		close = 1;
+		break;
+	case MORIBUND:
+		break;
+	default:
+		BUG();
+		break;
+	}
+out:
+	spin_unlock_irqrestore(&ep->com.lock, flags);
+	if (close) {
+		if (abrupt)
+			ret = send_abort(ep, NULL, gfp);
+		else
+			ret = send_halfclose(ep, gfp);
+	}
+	return ret;
+}
+
+int iwch_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new,
+		     struct l2t_entry *l2t)
+{
+	struct iwch_ep *ep = ctx;
+	
+	if (ep->dst != old)
+		return 0;
+
+	PDBG("%s ep %p redirect to dst %p l2t %p\n", __FUNCTION__, ep, new,
+	     l2t);
+	dst_hold(new);
+	l2t_release(L2DATA(ep->com.tdev), ep->l2t);
+	ep->l2t = l2t;
+	dst_release(old);
+	ep->dst = new;
+	return 1;
+}
+
+/*
+ * All the CM events are handled on a work queue to have a safe context.
+ */
+static int sched(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
+{
+	struct iwch_ep_common *epc = ctx;
+
+	get_ep(epc);
+
+	/*
+	 * Save ctx and tdev in the skb->cb area.
+	 */
+	*((void **) skb->cb) = ctx;
+	*((struct t3cdev **) (skb->cb + sizeof(void *))) = tdev;
+
+	/*
+	 * Queue the skb and schedule the worker thread.
+	 */
+	skb_queue_tail(&rxq, skb);
+	queue_work(workq, &skb_work);
+	return 0;
+}
+
+int __init iwch_cm_init(void)
+{
+	skb_queue_head_init(&rxq);
+
+	workq = create_singlethread_workqueue("iw_cxgb3");
+	if (!workq)
+		return -ENOMEM;
+
+	/*
+	 * All upcalls from the T3 Core go to sched() to
+	 * schedule the processing on a work queue.
+	 */
+	t3c_handlers[CPL_ACT_ESTABLISH] = sched;
+	t3c_handlers[CPL_ACT_OPEN_RPL] = sched;
+	t3c_handlers[CPL_RX_DATA] = sched;
+	t3c_handlers[CPL_TX_DMA_ACK] = sched;
+	t3c_handlers[CPL_ABORT_RPL_RSS] = sched;
+	t3c_handlers[CPL_ABORT_RPL] = sched;
+	t3c_handlers[CPL_PASS_OPEN_RPL] = sched;
+	t3c_handlers[CPL_CLOSE_LISTSRV_RPL] = sched;
+	t3c_handlers[CPL_PASS_ACCEPT_REQ] = sched;
+	t3c_handlers[CPL_PASS_ESTABLISH] = sched;
+	t3c_handlers[CPL_PEER_CLOSE] = sched;
+	t3c_handlers[CPL_CLOSE_CON_RPL] = sched;
+	t3c_handlers[CPL_ABORT_REQ_RSS] = sched;
+	t3c_handlers[CPL_RDMA_TERMINATE] = sched;
+	t3c_handlers[CPL_RDMA_EC_STATUS] = sched;
+
+	/*
+	 * These are the real handlers that are called from a
+	 * work queue.
+	 */
+	work_handlers[CPL_ACT_ESTABLISH] = act_establish;
+	work_handlers[CPL_ACT_OPEN_RPL] = act_open_rpl;
+	work_handlers[CPL_RX_DATA] = rx_data;
+	work_handlers[CPL_TX_DMA_ACK] = tx_ack;
+	work_handlers[CPL_ABORT_RPL_RSS] = abort_rpl;
+	work_handlers[CPL_ABORT_RPL] = abort_rpl;
+	work_handlers[CPL_PASS_OPEN_RPL] = pass_open_rpl;
+	work_handlers[CPL_CLOSE_LISTSRV_RPL] = close_listsrv_rpl;
+	work_handlers[CPL_PASS_ACCEPT_REQ] = pass_accept_req;
+	work_handlers[CPL_PASS_ESTABLISH] = pass_establish;
+	work_handlers[CPL_PEER_CLOSE] = peer_close;
+	work_handlers[CPL_ABORT_REQ_RSS] = peer_abort;
+	work_handlers[CPL_CLOSE_CON_RPL] = close_con_rpl;
+	work_handlers[CPL_RDMA_TERMINATE] = terminate;
+	work_handlers[CPL_RDMA_EC_STATUS] = ec_status;
+	return 0;
+}
+
+void __exit iwch_cm_term(void)
+{
+	flush_workqueue(workq);
+	destroy_workqueue(workq);
+}
diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.h b/drivers/infiniband/hw/cxgb3/iwch_cm.h
new file mode 100644
index 0000000..893f9d0
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.h
@@ -0,0 +1,223 @@
+/*
+ * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
+ * Copyright (c) 2006 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#ifndef _IWCH_CM_H_
+#define _IWCH_CM_H_
+
+#include <linux/inet.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+
+#include <rdma/ib_verbs.h>
+#include <rdma/iw_cm.h>
+
+#include "cxgb3_offload.h"
+#include "iwch_provider.h"
+
+#define MPA_KEY_REQ "MPA ID Req Frame"
+#define MPA_KEY_REP "MPA ID Rep Frame"
+
+#define MPA_MAX_PRIVATE_DATA 	256
+#define MPA_REV 		0	/* XXX - amso1100 uses rev 0 ! */
+#define MPA_REJECT 		0x20
+#define MPA_CRC			0x40
+#define MPA_MARKERS		0x80
+#define MPA_FLAGS_MASK		0xE0
+
+#define put_ep(ep) { \
+	PDBG("put_ep (via %s:%u) ep %p refcnt %d\n", __FUNCTION__, __LINE__,  \
+	     ep, atomic_read(&((ep)->kref.refcount))); \
+	kref_put(&((ep)->kref), __free_ep); \
+}
+
+#define get_ep(ep) { \
+	PDBG("get_ep (via %s:%u) ep %p, refcnt %d\n", __FUNCTION__, __LINE__, \
+	     ep, atomic_read(&((ep)->kref.refcount))); \
+	kref_get(&((ep)->kref));  \
+}
+
+struct mpa_message {
+	u8 key[16];
+	u8 flags;
+	u8 revision;
+	__be16 private_data_size;
+	u8 private_data[0];
+};
+
+struct terminate_message {
+	u8 layer_etype;
+	u8 ecode;
+	__be16 hdrct_rsvd;
+	u8 len_hdrs[0];
+};
+
+#define TERM_MAX_LENGTH (sizeof(struct terminate_message) + 2 + 18 + 28)
+
+enum iwch_layers_types {
+	LAYER_RDMAP 		= 0x00,
+	LAYER_DDP		= 0x10,
+	LAYER_MPA		= 0x20,
+	RDMAP_LOCAL_CATA	= 0x00,
+	RDMAP_REMOTE_PROT	= 0x01,
+	RDMAP_REMOTE_OP		= 0x02,
+	DDP_LOCAL_CATA		= 0x00,
+	DDP_TAGGED_ERR		= 0x01,
+	DDP_UNTAGGED_ERR	= 0x02,
+	DDP_LLP			= 0x03
+};
+
+enum iwch_rdma_ecodes {
+	RDMAP_INV_STAG		= 0x00,
+	RDMAP_BASE_BOUNDS	= 0x01,
+	RDMAP_ACC_VIOL		= 0x02,
+	RDMAP_STAG_NOT_ASSOC	= 0x03,
+	RDMAP_TO_WRAP		= 0x04,
+	RDMAP_INV_VERS		= 0x05,
+	RDMAP_INV_OPCODE	= 0x06,
+	RDMAP_STREAM_CATA	= 0x07,
+	RDMAP_GLOBAL_CATA	= 0x08,
+	RDMAP_CANT_INV_STAG	= 0x09,
+	RDMAP_UNSPECIFIED	= 0xff	
+};
+
+enum iwch_ddp_ecodes {
+	DDPT_INV_STAG		= 0x00,
+	DDPT_BASE_BOUNDS	= 0x01,
+	DDPT_STAG_NOT_ASSOC	= 0x02,
+	DDPT_TO_WRAP		= 0x03,
+	DDPT_INV_VERS		= 0x04,
+	DDPU_INV_QN		= 0x01,
+	DDPU_INV_MSN_NOBUF	= 0x02,
+	DDPU_INV_MSN_RANGE	= 0x03,
+	DDPU_INV_MO		= 0x04,
+	DDPU_MSG_TOOBIG		= 0x05,
+	DDPU_INV_VERS		= 0x06
+};
+
+enum iwch_mpa_ecodes {
+	MPA_CRC_ERR		= 0x02,
+	MPA_MARKER_ERR		= 0x03
+};
+
+enum iwch_ep_state {
+	IDLE = 0,
+	LISTEN,	
+	CONNECTING,
+	MPA_REQ_WAIT,
+	MPA_REQ_SENT,
+	MPA_REQ_RCVD,
+	MPA_REP_SENT,
+	FPDU_MODE,
+	ABORTING,
+	CLOSING,
+	MORIBUND,
+	DEAD,
+};
+
+struct iwch_ep_common {
+	struct iw_cm_id *cm_id;
+	struct iwch_qp *qp;
+	struct t3cdev *tdev;
+	enum iwch_ep_state state;
+	struct kref kref;
+	spinlock_t lock;
+	struct sockaddr_in local_addr;
+	struct sockaddr_in remote_addr;
+	wait_queue_head_t waitq;
+	int rpl_done;
+	int rpl_err;
+};
+
+struct iwch_listen_ep {
+	struct iwch_ep_common com;
+	unsigned int stid;
+	int backlog;
+};
+
+struct iwch_ep {
+	struct iwch_ep_common com;
+	struct iwch_ep *parent_ep;
+	struct timer_list timer;
+	unsigned int atid;
+	u32 hwtid;
+	u32 snd_seq;
+	struct l2t_entry *l2t;
+	struct dst_entry *dst;
+	struct sk_buff *mpa_skb;
+	struct iwch_mpa_attributes mpa_attr;
+	unsigned int mpa_pkt_len;
+	u8 mpa_pkt[sizeof(struct mpa_message) + MPA_MAX_PRIVATE_DATA];
+	u8 tos;
+	u16 emss;
+	u16 plen;
+	u32 ird;
+	u32 ord;
+};
+
+static inline struct iwch_ep *to_ep(struct iw_cm_id *cm_id)
+{
+	return (struct iwch_ep *)cm_id->provider_data;
+}
+
+static inline struct iwch_listen_ep *to_listen_ep(struct iw_cm_id *cm_id)
+{
+	return (struct iwch_listen_ep *)cm_id->provider_data;
+}
+
+static inline int compute_wscale(int win)
+{
+	int wscale = 0;
+
+	while (wscale < 14 && (65535<<wscale) < win)
+		wscale++;
+	return wscale;
+}
+
+/* CM prototypes */
+
+int iwch_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
+int iwch_create_listen(struct iw_cm_id *cm_id, int backlog);
+int iwch_destroy_listen(struct iw_cm_id *cm_id);
+int iwch_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len);
+int iwch_accept_cr(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
+int iwch_ep_disconnect(struct iwch_ep *ep, int abrupt, gfp_t gfp);
+int iwch_quiesce_tid(struct iwch_ep *ep);
+int iwch_resume_tid(struct iwch_ep *ep);
+void __free_ep(struct kref *kref);
+void iwch_rearp(struct iwch_ep *ep);
+int iwch_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new, struct l2t_entry *l2t);
+
+int __init iwch_cm_init(void);
+void __exit iwch_cm_term(void);
+
+#endif				/* _IWCH_CM_H_ */
diff --git a/drivers/infiniband/hw/cxgb3/tcb.h b/drivers/infiniband/hw/cxgb3/tcb.h
new file mode 100644
index 0000000..f287a7c
--- /dev/null
+++ b/drivers/infiniband/hw/cxgb3/tcb.h
@@ -0,0 +1,603 @@
+/* This file is automatically generated --- do not edit */
+
+#ifndef _TCB_DEFS_H
+#define _TCB_DEFS_H
+
+#define W_TCB_T_STATE    0
+#define S_TCB_T_STATE    0
+#define M_TCB_T_STATE    0xfULL
+#define V_TCB_T_STATE(x) ((x) << S_TCB_T_STATE)
+
+#define W_TCB_TIMER    0
+#define S_TCB_TIMER    4
+#define M_TCB_TIMER    0x1ULL
+#define V_TCB_TIMER(x) ((x) << S_TCB_TIMER)
+
+#define W_TCB_DACK_TIMER    0
+#define S_TCB_DACK_TIMER    5
+#define M_TCB_DACK_TIMER    0x1ULL
+#define V_TCB_DACK_TIMER(x) ((x) << S_TCB_DACK_TIMER)
+
+#define W_TCB_DEL_FLAG    0
+#define S_TCB_DEL_FLAG    6
+#define M_TCB_DEL_FLAG    0x1ULL
+#define V_TCB_DEL_FLAG(x) ((x) << S_TCB_DEL_FLAG)
+
+#define W_TCB_L2T_IX    0
+#define S_TCB_L2T_IX    7
+#define M_TCB_L2T_IX    0x7ffULL
+#define V_TCB_L2T_IX(x) ((x) << S_TCB_L2T_IX)
+
+#define W_TCB_SMAC_SEL    0
+#define S_TCB_SMAC_SEL    18
+#define M_TCB_SMAC_SEL    0x3ULL
+#define V_TCB_SMAC_SEL(x) ((x) << S_TCB_SMAC_SEL)
+
+#define W_TCB_TOS    0
+#define S_TCB_TOS    20
+#define M_TCB_TOS    0x3fULL
+#define V_TCB_TOS(x) ((x) << S_TCB_TOS)
+
+#define W_TCB_MAX_RT    0
+#define S_TCB_MAX_RT    26
+#define M_TCB_MAX_RT    0xfULL
+#define V_TCB_MAX_RT(x) ((x) << S_TCB_MAX_RT)
+
+#define W_TCB_T_RXTSHIFT    0
+#define S_TCB_T_RXTSHIFT    30
+#define M_TCB_T_RXTSHIFT    0xfULL
+#define V_TCB_T_RXTSHIFT(x) ((x) << S_TCB_T_RXTSHIFT)
+
+#define W_TCB_T_DUPACKS    1
+#define S_TCB_T_DUPACKS    2
+#define M_TCB_T_DUPACKS    0xfULL
+#define V_TCB_T_DUPACKS(x) ((x) << S_TCB_T_DUPACKS)
+
+#define W_TCB_T_MAXSEG    1
+#define S_TCB_T_MAXSEG    6
+#define M_TCB_T_MAXSEG    0xfULL
+#define V_TCB_T_MAXSEG(x) ((x) << S_TCB_T_MAXSEG)
+
+#define W_TCB_T_FLAGS1    1
+#define S_TCB_T_FLAGS1    10
+#define M_TCB_T_FLAGS1    0xffffffffULL
+#define V_TCB_T_FLAGS1(x) ((x) << S_TCB_T_FLAGS1)
+
+#define W_TCB_T_MIGRATION    1
+#define S_TCB_T_MIGRATION    20
+#define M_TCB_T_MIGRATION    0x1ULL
+#define V_TCB_T_MIGRATION(x) ((x) << S_TCB_T_MIGRATION)
+
+#define W_TCB_T_FLAGS2    2
+#define S_TCB_T_FLAGS2    10
+#define M_TCB_T_FLAGS2    0x7fULL
+#define V_TCB_T_FLAGS2(x) ((x) << S_TCB_T_FLAGS2)
+
+#define W_TCB_SND_SCALE    2
+#define S_TCB_SND_SCALE    17
+#define M_TCB_SND_SCALE    0xfULL
+#define V_TCB_SND_SCALE(x) ((x) << S_TCB_SND_SCALE)
+
+#define W_TCB_RCV_SCALE    2
+#define S_TCB_RCV_SCALE    21
+#define M_TCB_RCV_SCALE    0xfULL
+#define V_TCB_RCV_SCALE(x) ((x) << S_TCB_RCV_SCALE)
+
+#define W_TCB_SND_UNA_RAW    2
+#define S_TCB_SND_UNA_RAW    25
+#define M_TCB_SND_UNA_RAW    0x7ffffffULL
+#define V_TCB_SND_UNA_RAW(x) ((x) << S_TCB_SND_UNA_RAW)
+
+#define W_TCB_SND_NXT_RAW    3
+#define S_TCB_SND_NXT_RAW    20
+#define M_TCB_SND_NXT_RAW    0x7ffffffULL
+#define V_TCB_SND_NXT_RAW(x) ((x) << S_TCB_SND_NXT_RAW)
+
+#define W_TCB_RCV_NXT    4
+#define S_TCB_RCV_NXT    15
+#define M_TCB_RCV_NXT    0xffffffffULL
+#define V_TCB_RCV_NXT(x) ((x) << S_TCB_RCV_NXT)
+
+#define W_TCB_RCV_ADV    5
+#define S_TCB_RCV_ADV    15
+#define M_TCB_RCV_ADV    0xffffULL
+#define V_TCB_RCV_ADV(x) ((x) << S_TCB_RCV_ADV)
+
+#define W_TCB_SND_MAX_RAW    5
+#define S_TCB_SND_MAX_RAW    31
+#define M_TCB_SND_MAX_RAW    0x7ffffffULL
+#define V_TCB_SND_MAX_RAW(x) ((x) << S_TCB_SND_MAX_RAW)
+
+#define W_TCB_SND_CWND    6
+#define S_TCB_SND_CWND    26
+#define M_TCB_SND_CWND    0x7ffffffULL
+#define V_TCB_SND_CWND(x) ((x) << S_TCB_SND_CWND)
+
+#define W_TCB_SND_SSTHRESH    7
+#define S_TCB_SND_SSTHRESH    21
+#define M_TCB_SND_SSTHRESH    0x7ffffffULL
+#define V_TCB_SND_SSTHRESH(x) ((x) << S_TCB_SND_SSTHRESH)
+
+#define W_TCB_T_RTT_TS_RECENT_AGE    8
+#define S_TCB_T_RTT_TS_RECENT_AGE    16
+#define M_TCB_T_RTT_TS_RECENT_AGE    0xffffffffULL
+#define V_TCB_T_RTT_TS_RECENT_AGE(x) ((x) << S_TCB_T_RTT_TS_RECENT_AGE)
+
+#define W_TCB_T_RTSEQ_RECENT    9
+#define S_TCB_T_RTSEQ_RECENT    16
+#define M_TCB_T_RTSEQ_RECENT    0xffffffffULL
+#define V_TCB_T_RTSEQ_RECENT(x) ((x) << S_TCB_T_RTSEQ_RECENT)
+
+#define W_TCB_T_SRTT    10
+#define S_TCB_T_SRTT    16
+#define M_TCB_T_SRTT    0xffffULL
+#define V_TCB_T_SRTT(x) ((x) << S_TCB_T_SRTT)
+
+#define W_TCB_T_RTTVAR    11
+#define S_TCB_T_RTTVAR    0
+#define M_TCB_T_RTTVAR    0xffffULL
+#define V_TCB_T_RTTVAR(x) ((x) << S_TCB_T_RTTVAR)
+
+#define W_TCB_TS_LAST_ACK_SENT_RAW    11
+#define S_TCB_TS_LAST_ACK_SENT_RAW    16
+#define M_TCB_TS_LAST_ACK_SENT_RAW    0x7ffffffULL
+#define V_TCB_TS_LAST_ACK_SENT_RAW(x) ((x) << S_TCB_TS_LAST_ACK_SENT_RAW)
+
+#define W_TCB_DIP    12
+#define S_TCB_DIP    11
+#define M_TCB_DIP    0xffffffffULL
+#define V_TCB_DIP(x) ((x) << S_TCB_DIP)
+
+#define W_TCB_SIP    13
+#define S_TCB_SIP    11
+#define M_TCB_SIP    0xffffffffULL
+#define V_TCB_SIP(x) ((x) << S_TCB_SIP)
+
+#define W_TCB_DP    14
+#define S_TCB_DP    11
+#define M_TCB_DP    0xffffULL
+#define V_TCB_DP(x) ((x) << S_TCB_DP)
+
+#define W_TCB_SP    14
+#define S_TCB_SP    27
+#define M_TCB_SP    0xffffULL
+#define V_TCB_SP(x) ((x) << S_TCB_SP)
+
+#define W_TCB_TIMESTAMP    15
+#define S_TCB_TIMESTAMP    11
+#define M_TCB_TIMESTAMP    0xffffffffULL
+#define V_TCB_TIMESTAMP(x) ((x) << S_TCB_TIMESTAMP)
+
+#define W_TCB_TIMESTAMP_OFFSET    16
+#define S_TCB_TIMESTAMP_OFFSET    11
+#define M_TCB_TIMESTAMP_OFFSET    0xfULL
+#define V_TCB_TIMESTAMP_OFFSET(x) ((x) << S_TCB_TIMESTAMP_OFFSET)
+
+#define W_TCB_TX_MAX    16
+#define S_TCB_TX_MAX    15
+#define M_TCB_TX_MAX    0xffffffffULL
+#define V_TCB_TX_MAX(x) ((x) << S_TCB_TX_MAX)
+
+#define W_TCB_TX_HDR_PTR_RAW    17
+#define S_TCB_TX_HDR_PTR_RAW    15
+#define M_TCB_TX_HDR_PTR_RAW    0x1ffffULL
+#define V_TCB_TX_HDR_PTR_RAW(x) ((x) << S_TCB_TX_HDR_PTR_RAW)
+
+#define W_TCB_TX_LAST_PTR_RAW    18
+#define S_TCB_TX_LAST_PTR_RAW    0
+#define M_TCB_TX_LAST_PTR_RAW    0x1ffffULL
+#define V_TCB_TX_LAST_PTR_RAW(x) ((x) << S_TCB_TX_LAST_PTR_RAW)
+
+#define W_TCB_TX_COMPACT    18
+#define S_TCB_TX_COMPACT    17
+#define M_TCB_TX_COMPACT    0x1ULL
+#define V_TCB_TX_COMPACT(x) ((x) << S_TCB_TX_COMPACT)
+
+#define W_TCB_RX_COMPACT    18
+#define S_TCB_RX_COMPACT    18
+#define M_TCB_RX_COMPACT    0x1ULL
+#define V_TCB_RX_COMPACT(x) ((x) << S_TCB_RX_COMPACT)
+
+#define W_TCB_RCV_WND    18
+#define S_TCB_RCV_WND    19
+#define M_TCB_RCV_WND    0x7ffffffULL
+#define V_TCB_RCV_WND(x) ((x) << S_TCB_RCV_WND)
+
+#define W_TCB_RX_HDR_OFFSET    19
+#define S_TCB_RX_HDR_OFFSET    14
+#define M_TCB_RX_HDR_OFFSET    0x7ffffffULL
+#define V_TCB_RX_HDR_OFFSET(x) ((x) << S_TCB_RX_HDR_OFFSET)
+
+#define W_TCB_RX_FRAG0_START_IDX_RAW    20
+#define S_TCB_RX_FRAG0_START_IDX_RAW    9
+#define M_TCB_RX_FRAG0_START_IDX_RAW    0x7ffffffULL
+#define V_TCB_RX_FRAG0_START_IDX_RAW(x) ((x) << S_TCB_RX_FRAG0_START_IDX_RAW)
+
+#define W_TCB_RX_FRAG1_START_IDX_OFFSET    21
+#define S_TCB_RX_FRAG1_START_IDX_OFFSET    4
+#define M_TCB_RX_FRAG1_START_IDX_OFFSET    0x7ffffffULL
+#define V_TCB_RX_FRAG1_START_IDX_OFFSET(x) ((x) << S_TCB_RX_FRAG1_START_IDX_OFFSET)
+
+#define W_TCB_RX_FRAG0_LEN    21
+#define S_TCB_RX_FRAG0_LEN    31
+#define M_TCB_RX_FRAG0_LEN    0x7ffffffULL
+#define V_TCB_RX_FRAG0_LEN(x) ((x) << S_TCB_RX_FRAG0_LEN)
+
+#define W_TCB_RX_FRAG1_LEN    22
+#define S_TCB_RX_FRAG1_LEN    26
+#define M_TCB_RX_FRAG1_LEN    0x7ffffffULL
+#define V_TCB_RX_FRAG1_LEN(x) ((x) << S_TCB_RX_FRAG1_LEN)
+
+#define W_TCB_NEWRENO_RECOVER    23
+#define S_TCB_NEWRENO_RECOVER    21
+#define M_TCB_NEWRENO_RECOVER    0x7ffffffULL
+#define V_TCB_NEWRENO_RECOVER(x) ((x) << S_TCB_NEWRENO_RECOVER)
+
+#define W_TCB_PDU_HAVE_LEN    24
+#define S_TCB_PDU_HAVE_LEN    16
+#define M_TCB_PDU_HAVE_LEN    0x1ULL
+#define V_TCB_PDU_HAVE_LEN(x) ((x) << S_TCB_PDU_HAVE_LEN)
+
+#define W_TCB_PDU_LEN    24
+#define S_TCB_PDU_LEN    17
+#define M_TCB_PDU_LEN    0xffffULL
+#define V_TCB_PDU_LEN(x) ((x) << S_TCB_PDU_LEN)
+
+#define W_TCB_RX_QUIESCE    25
+#define S_TCB_RX_QUIESCE    1
+#define M_TCB_RX_QUIESCE    0x1ULL
+#define V_TCB_RX_QUIESCE(x) ((x) << S_TCB_RX_QUIESCE)
+
+#define W_TCB_RX_PTR_RAW    25
+#define S_TCB_RX_PTR_RAW    2
+#define M_TCB_RX_PTR_RAW    0x1ffffULL
+#define V_TCB_RX_PTR_RAW(x) ((x) << S_TCB_RX_PTR_RAW)
+
+#define W_TCB_CPU_NO    25
+#define S_TCB_CPU_NO    19
+#define M_TCB_CPU_NO    0x7fULL
+#define V_TCB_CPU_NO(x) ((x) << S_TCB_CPU_NO)
+
+#define W_TCB_ULP_TYPE    25
+#define S_TCB_ULP_TYPE    26
+#define M_TCB_ULP_TYPE    0xfULL
+#define V_TCB_ULP_TYPE(x) ((x) << S_TCB_ULP_TYPE)
+
+#define W_TCB_RX_FRAG1_PTR_RAW    25
+#define S_TCB_RX_FRAG1_PTR_RAW    30
+#define M_TCB_RX_FRAG1_PTR_RAW    0x1ffffULL
+#define V_TCB_RX_FRAG1_PTR_RAW(x) ((x) << S_TCB_RX_FRAG1_PTR_RAW)
+
+#define W_TCB_RX_FRAG2_START_IDX_OFFSET_RAW    26
+#define S_TCB_RX_FRAG2_START_IDX_OFFSET_RAW    15
+#define M_TCB_RX_FRAG2_START_IDX_OFFSET_RAW    0x7ffffffULL
+#define V_TCB_RX_FRAG2_START_IDX_OFFSET_RAW(x) ((x) << S_TCB_RX_FRAG2_START_IDX_OFFSET_RAW)
+
+#define W_TCB_RX_FRAG2_PTR_RAW    27
+#define S_TCB_RX_FRAG2_PTR_RAW    10
+#define M_TCB_RX_FRAG2_PTR_RAW    0x1ffffULL
+#define V_TCB_RX_FRAG2_PTR_RAW(x) ((x) << S_TCB_RX_FRAG2_PTR_RAW)
+
+#define W_TCB_RX_FRAG2_LEN_RAW    27
+#define S_TCB_RX_FRAG2_LEN_RAW    27
+#define M_TCB_RX_FRAG2_LEN_RAW    0x7ffffffULL
+#define V_TCB_RX_FRAG2_LEN_RAW(x) ((x) << S_TCB_RX_FRAG2_LEN_RAW)
+
+#define W_TCB_RX_FRAG3_PTR_RAW    28
+#define S_TCB_RX_FRAG3_PTR_RAW    22
+#define M_TCB_RX_FRAG3_PTR_RAW    0x1ffffULL
+#define V_TCB_RX_FRAG3_PTR_RAW(x) ((x) << S_TCB_RX_FRAG3_PTR_RAW)
+
+#define W_TCB_RX_FRAG3_LEN_RAW    29
+#define S_TCB_RX_FRAG3_LEN_RAW    7
+#define M_TCB_RX_FRAG3_LEN_RAW    0x7ffffffULL
+#define V_TCB_RX_FRAG3_LEN_RAW(x) ((x) << S_TCB_RX_FRAG3_LEN_RAW)
+
+#define W_TCB_RX_FRAG3_START_IDX_OFFSET_RAW    30
+#define S_TCB_RX_FRAG3_START_IDX_OFFSET_RAW    2
+#define M_TCB_RX_FRAG3_START_IDX_OFFSET_RAW    0x7ffffffULL
+#define V_TCB_RX_FRAG3_START_IDX_OFFSET_RAW(x) ((x) << S_TCB_RX_FRAG3_START_IDX_OFFSET_RAW)
+
+#define W_TCB_PDU_HDR_LEN    30
+#define S_TCB_PDU_HDR_LEN    29
+#define M_TCB_PDU_HDR_LEN    0xffULL
+#define V_TCB_PDU_HDR_LEN(x) ((x) << S_TCB_PDU_HDR_LEN)
+
+#define W_TCB_SLUSH1    31
+#define S_TCB_SLUSH1    5
+#define M_TCB_SLUSH1    0x7ffffULL
+#define V_TCB_SLUSH1(x) ((x) << S_TCB_SLUSH1)
+
+#define W_TCB_ULP_RAW    31
+#define S_TCB_ULP_RAW    24
+#define M_TCB_ULP_RAW    0xffULL
+#define V_TCB_ULP_RAW(x) ((x) << S_TCB_ULP_RAW)
+
+#define W_TCB_DDP_RDMAP_VERSION    25
+#define S_TCB_DDP_RDMAP_VERSION    30
+#define M_TCB_DDP_RDMAP_VERSION    0x1ULL
+#define V_TCB_DDP_RDMAP_VERSION(x) ((x) << S_TCB_DDP_RDMAP_VERSION)
+
+#define W_TCB_MARKER_ENABLE_RX    25
+#define S_TCB_MARKER_ENABLE_RX    31
+#define M_TCB_MARKER_ENABLE_RX    0x1ULL
+#define V_TCB_MARKER_ENABLE_RX(x) ((x) << S_TCB_MARKER_ENABLE_RX)
+
+#define W_TCB_MARKER_ENABLE_TX    26
+#define S_TCB_MARKER_ENABLE_TX    0
+#define M_TCB_MARKER_ENABLE_TX    0x1ULL
+#define V_TCB_MARKER_ENABLE_TX(x) ((x) << S_TCB_MARKER_ENABLE_TX)
+
+#define W_TCB_CRC_ENABLE    26
+#define S_TCB_CRC_ENABLE    1
+#define M_TCB_CRC_ENABLE    0x1ULL
+#define V_TCB_CRC_ENABLE(x) ((x) << S_TCB_CRC_ENABLE)
+
+#define W_TCB_IRS_ULP    26
+#define S_TCB_IRS_ULP    2
+#define M_TCB_IRS_ULP    0x1ffULL
+#define V_TCB_IRS_ULP(x) ((x) << S_TCB_IRS_ULP)
+
+#define W_TCB_ISS_ULP    26
+#define S_TCB_ISS_ULP    11
+#define M_TCB_ISS_ULP    0x1ffULL
+#define V_TCB_ISS_ULP(x) ((x) << S_TCB_ISS_ULP)
+
+#define W_TCB_TX_PDU_LEN    26
+#define S_TCB_TX_PDU_LEN    20
+#define M_TCB_TX_PDU_LEN    0x3fffULL
+#define V_TCB_TX_PDU_LEN(x) ((x) << S_TCB_TX_PDU_LEN)
+
+#define W_TCB_TX_PDU_OUT    27
+#define S_TCB_TX_PDU_OUT    2
+#define M_TCB_TX_PDU_OUT    0x1ULL
+#define V_TCB_TX_PDU_OUT(x) ((x) << S_TCB_TX_PDU_OUT)
+
+#define W_TCB_CQ_IDX_SQ    27
+#define S_TCB_CQ_IDX_SQ    3
+#define M_TCB_CQ_IDX_SQ    0xffffULL
+#define V_TCB_CQ_IDX_SQ(x) ((x) << S_TCB_CQ_IDX_SQ)
+
+#define W_TCB_CQ_IDX_RQ    27
+#define S_TCB_CQ_IDX_RQ    19
+#define M_TCB_CQ_IDX_RQ    0xffffULL
+#define V_TCB_CQ_IDX_RQ(x) ((x) << S_TCB_CQ_IDX_RQ)
+
+#define W_TCB_QP_ID    28
+#define S_TCB_QP_ID    3
+#define M_TCB_QP_ID    0xffffULL
+#define V_TCB_QP_ID(x) ((x) << S_TCB_QP_ID)
+
+#define W_TCB_PD_ID    28
+#define S_TCB_PD_ID    19
+#define M_TCB_PD_ID    0xffffULL
+#define V_TCB_PD_ID(x) ((x) << S_TCB_PD_ID)
+
+#define W_TCB_STAG    29
+#define S_TCB_STAG    3
+#define M_TCB_STAG    0xffffffffULL
+#define V_TCB_STAG(x) ((x) << S_TCB_STAG)
+
+#define W_TCB_RQ_START    30
+#define S_TCB_RQ_START    3
+#define M_TCB_RQ_START    0x3ffffffULL
+#define V_TCB_RQ_START(x) ((x) << S_TCB_RQ_START)
+
+#define W_TCB_RQ_MSN    30
+#define S_TCB_RQ_MSN    29
+#define M_TCB_RQ_MSN    0x3ffULL
+#define V_TCB_RQ_MSN(x) ((x) << S_TCB_RQ_MSN)
+
+#define W_TCB_RQ_MAX_OFFSET    31
+#define S_TCB_RQ_MAX_OFFSET    7
+#define M_TCB_RQ_MAX_OFFSET    0xfULL
+#define V_TCB_RQ_MAX_OFFSET(x) ((x) << S_TCB_RQ_MAX_OFFSET)
+
+#define W_TCB_RQ_WRITE_PTR    31
+#define S_TCB_RQ_WRITE_PTR    11
+#define M_TCB_RQ_WRITE_PTR    0x3ffULL
+#define V_TCB_RQ_WRITE_PTR(x) ((x) << S_TCB_RQ_WRITE_PTR)
+
+#define W_TCB_INB_WRITE_PERM    31
+#define S_TCB_INB_WRITE_PERM    21
+#define M_TCB_INB_WRITE_PERM    0x1ULL
+#define V_TCB_INB_WRITE_PERM(x) ((x) << S_TCB_INB_WRITE_PERM)
+
+#define W_TCB_INB_READ_PERM    31
+#define S_TCB_INB_READ_PERM    22
+#define M_TCB_INB_READ_PERM    0x1ULL
+#define V_TCB_INB_READ_PERM(x) ((x) << S_TCB_INB_READ_PERM)
+
+#define W_TCB_ORD_L_BIT_VLD    31
+#define S_TCB_ORD_L_BIT_VLD    23
+#define M_TCB_ORD_L_BIT_VLD    0x1ULL
+#define V_TCB_ORD_L_BIT_VLD(x) ((x) << S_TCB_ORD_L_BIT_VLD)
+
+#define W_TCB_RDMAP_OPCODE    31
+#define S_TCB_RDMAP_OPCODE    24
+#define M_TCB_RDMAP_OPCODE    0xfULL
+#define V_TCB_RDMAP_OPCODE(x) ((x) << S_TCB_RDMAP_OPCODE)
+
+#define W_TCB_TX_FLUSH    31
+#define S_TCB_TX_FLUSH    28
+#define M_TCB_TX_FLUSH    0x1ULL
+#define V_TCB_TX_FLUSH(x) ((x) << S_TCB_TX_FLUSH)
+
+#define W_TCB_TX_OOS_RXMT    31
+#define S_TCB_TX_OOS_RXMT    29
+#define M_TCB_TX_OOS_RXMT    0x1ULL
+#define V_TCB_TX_OOS_RXMT(x) ((x) << S_TCB_TX_OOS_RXMT)
+
+#define W_TCB_TX_OOS_TXMT    31
+#define S_TCB_TX_OOS_TXMT    30
+#define M_TCB_TX_OOS_TXMT    0x1ULL
+#define V_TCB_TX_OOS_TXMT(x) ((x) << S_TCB_TX_OOS_TXMT)
+
+#define W_TCB_SLUSH_AUX2    31
+#define S_TCB_SLUSH_AUX2    31
+#define M_TCB_SLUSH_AUX2    0x1ULL
+#define V_TCB_SLUSH_AUX2(x) ((x) << S_TCB_SLUSH_AUX2)
+
+#define W_TCB_RX_FRAG1_PTR_RAW2    25
+#define S_TCB_RX_FRAG1_PTR_RAW2    30
+#define M_TCB_RX_FRAG1_PTR_RAW2    0x1ffffULL
+#define V_TCB_RX_FRAG1_PTR_RAW2(x) ((x) << S_TCB_RX_FRAG1_PTR_RAW2)
+
+#define W_TCB_RX_DDP_FLAGS    26
+#define S_TCB_RX_DDP_FLAGS    15
+#define M_TCB_RX_DDP_FLAGS    0x3ffULL
+#define V_TCB_RX_DDP_FLAGS(x) ((x) << S_TCB_RX_DDP_FLAGS)
+
+#define W_TCB_SLUSH_AUX3    26
+#define S_TCB_SLUSH_AUX3    31
+#define M_TCB_SLUSH_AUX3    0x1ffULL
+#define V_TCB_SLUSH_AUX3(x) ((x) << S_TCB_SLUSH_AUX3)
+
+#define W_TCB_RX_DDP_BUF0_OFFSET    27
+#define S_TCB_RX_DDP_BUF0_OFFSET    8
+#define M_TCB_RX_DDP_BUF0_OFFSET    0x3fffffULL
+#define V_TCB_RX_DDP_BUF0_OFFSET(x) ((x) << S_TCB_RX_DDP_BUF0_OFFSET)
+
+#define W_TCB_RX_DDP_BUF0_LEN    27
+#define S_TCB_RX_DDP_BUF0_LEN    30
+#define M_TCB_RX_DDP_BUF0_LEN    0x3fffffULL
+#define V_TCB_RX_DDP_BUF0_LEN(x) ((x) << S_TCB_RX_DDP_BUF0_LEN)
+
+#define W_TCB_RX_DDP_BUF1_OFFSET    28
+#define S_TCB_RX_DDP_BUF1_OFFSET    20
+#define M_TCB_RX_DDP_BUF1_OFFSET    0x3fffffULL
+#define V_TCB_RX_DDP_BUF1_OFFSET(x) ((x) << S_TCB_RX_DDP_BUF1_OFFSET)
+
+#define W_TCB_RX_DDP_BUF1_LEN    29
+#define S_TCB_RX_DDP_BUF1_LEN    10
+#define M_TCB_RX_DDP_BUF1_LEN    0x3fffffULL
+#define V_TCB_RX_DDP_BUF1_LEN(x) ((x) << S_TCB_RX_DDP_BUF1_LEN)
+
+#define W_TCB_RX_DDP_BUF0_TAG    30
+#define S_TCB_RX_DDP_BUF0_TAG    0
+#define M_TCB_RX_DDP_BUF0_TAG    0xffffffffULL
+#define V_TCB_RX_DDP_BUF0_TAG(x) ((x) << S_TCB_RX_DDP_BUF0_TAG)
+
+#define W_TCB_RX_DDP_BUF1_TAG    31
+#define S_TCB_RX_DDP_BUF1_TAG    0
+#define M_TCB_RX_DDP_BUF1_TAG    0xffffffffULL
+#define V_TCB_RX_DDP_BUF1_TAG(x) ((x) << S_TCB_RX_DDP_BUF1_TAG)
+
+#define S_TF_DACK    10
+#define V_TF_DACK(x) ((x) << S_TF_DACK)
+
+#define S_TF_NAGLE    11
+#define V_TF_NAGLE(x) ((x) << S_TF_NAGLE)
+
+#define S_TF_RECV_SCALE    12
+#define V_TF_RECV_SCALE(x) ((x) << S_TF_RECV_SCALE)
+
+#define S_TF_RECV_TSTMP    13
+#define V_TF_RECV_TSTMP(x) ((x) << S_TF_RECV_TSTMP)
+
+#define S_TF_RECV_SACK    14
+#define V_TF_RECV_SACK(x) ((x) << S_TF_RECV_SACK)
+
+#define S_TF_TURBO    15
+#define V_TF_TURBO(x) ((x) << S_TF_TURBO)
+
+#define S_TF_KEEPALIVE    16
+#define V_TF_KEEPALIVE(x) ((x) << S_TF_KEEPALIVE)
+
+#define S_TF_TCAM_BYPASS    17
+#define V_TF_TCAM_BYPASS(x) ((x) << S_TF_TCAM_BYPASS)
+
+#define S_TF_CORE_FIN    18
+#define V_TF_CORE_FIN(x) ((x) << S_TF_CORE_FIN)
+
+#define S_TF_CORE_MORE    19
+#define V_TF_CORE_MORE(x) ((x) << S_TF_CORE_MORE)
+
+#define S_TF_MIGRATING    20
+#define V_TF_MIGRATING(x) ((x) << S_TF_MIGRATING)
+
+#define S_TF_ACTIVE_OPEN    21
+#define V_TF_ACTIVE_OPEN(x) ((x) << S_TF_ACTIVE_OPEN)
+
+#define S_TF_ASK_MODE    22
+#define V_TF_ASK_MODE(x) ((x) << S_TF_ASK_MODE)
+
+#define S_TF_NON_OFFLOAD    23
+#define V_TF_NON_OFFLOAD(x) ((x) << S_TF_NON_OFFLOAD)
+
+#define S_TF_MOD_SCHD    24
+#define V_TF_MOD_SCHD(x) ((x) << S_TF_MOD_SCHD)
+
+#define S_TF_MOD_SCHD_REASON0    25
+#define V_TF_MOD_SCHD_REASON0(x) ((x) << S_TF_MOD_SCHD_REASON0)
+
+#define S_TF_MOD_SCHD_REASON1    26
+#define V_TF_MOD_SCHD_REASON1(x) ((x) << S_TF_MOD_SCHD_REASON1)
+
+#define S_TF_MOD_SCHD_RX    27
+#define V_TF_MOD_SCHD_RX(x) ((x) << S_TF_MOD_SCHD_RX)
+
+#define S_TF_CORE_PUSH    28
+#define V_TF_CORE_PUSH(x) ((x) << S_TF_CORE_PUSH)
+
+#define S_TF_RCV_COALESCE_ENABLE    29
+#define V_TF_RCV_COALESCE_ENABLE(x) ((x) << S_TF_RCV_COALESCE_ENABLE)
+
+#define S_TF_RCV_COALESCE_PUSH    30
+#define V_TF_RCV_COALESCE_PUSH(x) ((x) << S_TF_RCV_COALESCE_PUSH)
+
+#define S_TF_RCV_COALESCE_LAST_PSH    31
+#define V_TF_RCV_COALESCE_LAST_PSH(x) ((x) << S_TF_RCV_COALESCE_LAST_PSH)
+
+#define S_TF_RCV_COALESCE_HEARTBEAT    32
+#define V_TF_RCV_COALESCE_HEARTBEAT(x) ((x) << S_TF_RCV_COALESCE_HEARTBEAT)
+
+#define S_TF_HALF_CLOSE    33
+#define V_TF_HALF_CLOSE(x) ((x) << S_TF_HALF_CLOSE)
+
+#define S_TF_DACK_MSS    34
+#define V_TF_DACK_MSS(x) ((x) << S_TF_DACK_MSS)
+
+#define S_TF_CCTRL_SEL0    35
+#define V_TF_CCTRL_SEL0(x) ((x) << S_TF_CCTRL_SEL0)
+
+#define S_TF_CCTRL_SEL1    36
+#define V_TF_CCTRL_SEL1(x) ((x) << S_TF_CCTRL_SEL1)
+
+#define S_TF_TCP_NEWRENO_FAST_RECOVERY    37
+#define V_TF_TCP_NEWRENO_FAST_RECOVERY(x) ((x) << S_TF_TCP_NEWRENO_FAST_RECOVERY)
+
+#define S_TF_TX_PACE_AUTO    38
+#define V_TF_TX_PACE_AUTO(x) ((x) << S_TF_TX_PACE_AUTO)
+
+#define S_TF_PEER_FIN_HELD    39
+#define V_TF_PEER_FIN_HELD(x) ((x) << S_TF_PEER_FIN_HELD)
+
+#define S_TF_CORE_URG    40
+#define V_TF_CORE_URG(x) ((x) << S_TF_CORE_URG)
+
+#define S_TF_RDMA_ERROR    41
+#define V_TF_RDMA_ERROR(x) ((x) << S_TF_RDMA_ERROR)
+
+#define S_TF_SSWS_DISABLED    42
+#define V_TF_SSWS_DISABLED(x) ((x) << S_TF_SSWS_DISABLED)
+
+#define S_TF_DUPACK_COUNT_ODD    43
+#define V_TF_DUPACK_COUNT_ODD(x) ((x) << S_TF_DUPACK_COUNT_ODD)
+
+#define S_TF_TX_CHANNEL    44
+#define V_TF_TX_CHANNEL(x) ((x) << S_TF_TX_CHANNEL)
+
+#define S_TF_RX_CHANNEL    45
+#define V_TF_RX_CHANNEL(x) ((x) << S_TF_RX_CHANNEL)
+
+#define S_TF_TX_PACE_FIXED    46
+#define V_TF_TX_PACE_FIXED(x) ((x) << S_TF_TX_PACE_FIXED)
+
+#define S_TF_RDMA_FLM_ERROR    47
+#define V_TF_RDMA_FLM_ERROR(x) ((x) << S_TF_RDMA_FLM_ERROR)
+
+#define S_TF_RX_FLOW_CONTROL_DISABLE    48
+#define V_TF_RX_FLOW_CONTROL_DISABLE(x) ((x) << S_TF_RX_FLOW_CONTROL_DISABLE)
+
+#endif /* _TCB_DEFS_H */
