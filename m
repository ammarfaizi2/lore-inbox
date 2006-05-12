Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWELX6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWELX6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWELX5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:33 -0400
Received: from mx.pathscale.com ([64.160.42.68]:57257 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932215AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 24 of 53] ipath - count dropped VL15 packets
X-Mercurial-Node: e468ad0bd83e87fd2533f9f30f0d8033ae49e1d0
Message-Id: <e468ad0bd83e87fd2533.1147477389@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:09 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to count these for IB conformance.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 8b882bb46a32 -r e468ad0bd83e drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
@@ -646,6 +646,7 @@ struct ib_pma_portcounters {
 #define IB_PMA_SEL_PORT_RCV_ERRORS		__constant_htons(0x0008)
 #define IB_PMA_SEL_PORT_RCV_REMPHYS_ERRORS	__constant_htons(0x0010)
 #define IB_PMA_SEL_PORT_XMIT_DISCARDS		__constant_htons(0x0040)
+#define IB_PMA_SEL_PORT_VL15_DROPPED		__constant_htons(0x0800)
 #define IB_PMA_SEL_PORT_XMIT_DATA		__constant_htons(0x1000)
 #define IB_PMA_SEL_PORT_RCV_DATA		__constant_htons(0x2000)
 #define IB_PMA_SEL_PORT_XMIT_PACKETS		__constant_htons(0x4000)
@@ -929,6 +930,10 @@ static int recv_pma_get_portcounters(str
 	else
 		p->port_xmit_discards =
 			cpu_to_be16((u16)cntrs.port_xmit_discards);
+	if (dev->n_vl15_dropped > 0xFFFFUL)
+		p->vl15_dropped = __constant_cpu_to_be16(0xFFFF);
+	else
+		p->vl15_dropped = cpu_to_be16((u16)dev->n_vl15_dropped);
 	if (cntrs.port_xmit_data > 0xFFFFFFFFUL)
 		p->port_xmit_data = __constant_cpu_to_be32(0xFFFFFFFF);
 	else
@@ -1022,6 +1027,9 @@ static int recv_pma_set_portcounters(str
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DISCARDS)
 		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_VL15_DROPPED)
+		dev->n_vl15_dropped = 0;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DATA)
 		dev->n_port_xmit_data = cntrs.port_xmit_data;
diff -r 8b882bb46a32 -r e468ad0bd83e drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Fri May 12 15:55:28 2006 -0700
@@ -554,7 +554,11 @@ void ipath_ud_rcv(struct ipath_ibdev *de
 	spin_lock_irqsave(&rq->lock, flags);
 	if (rq->tail == rq->head) {
 		spin_unlock_irqrestore(&rq->lock, flags);
-		dev->n_pkt_drops++;
+		/* Count VL15 packets dropped due to no receive buffer */
+		if (qp->ibqp.qp_num == 0)
+			dev->n_vl15_dropped++;
+		else
+			dev->n_pkt_drops++;
 		goto bail;
 	}
 	/* Silently drop packets which are too big. */
diff -r 8b882bb46a32 -r e468ad0bd83e drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
@@ -468,6 +468,7 @@ struct ipath_ibdev {
 	u32 n_other_naks;
 	u32 n_timeouts;
 	u32 n_pkt_drops;
+	u32 n_vl15_dropped;
 	u32 n_wqe_errs;
 	u32 n_rdma_dup_busy;
 	u32 n_piowait;
