Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932925AbWF2VuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbWF2VuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWF2Vto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:49:44 -0400
Received: from mx.pathscale.com ([64.160.42.68]:37775 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932906AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 27 of 39] IB/ipath - fixes to performance get counters for IB
	compliance
X-Mercurial-Node: 7d22a8963bdaca778b13384cf839709a4d46a703
Message-Id: <7d22a8963bdaca778b13.1151617278@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:18 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some problems uncovered during IB compliance
testing to return the right values for error counters returned
by the Performance Get Counters packet.

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:26 2006 -0700
@@ -460,6 +460,8 @@ static int __devinit ipath_init_one(stru
 	 * by ipath_setup_htconfig.
 	 */
 	dd->ipath_flags = 0;
+	dd->ipath_lli_counter = 0;
+	dd->ipath_lli_errors = 0;
 
 	if (dd->ipath_f_bus(dd, pdev))
 		ipath_dev_err(dd, "Failed to setup config space; "
@@ -942,6 +944,18 @@ reloop:
 				   "tlen=%x opcode=%x egridx=%x: %s\n",
 				   eflags, l, etype, tlen, bthbytes[0],
 				   ips_get_index((__le32 *) rc), emsg);
+			/* Count local link integrity errors. */
+			if (eflags & (INFINIPATH_RHF_H_ICRCERR |
+				      INFINIPATH_RHF_H_VCRCERR)) {
+				u8 n = (dd->ipath_ibcctrl >>
+					INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
+					INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
+
+				if (++dd->ipath_lli_counter > n) {
+					dd->ipath_lli_counter = 0;
+					dd->ipath_lli_errors++;
+				}
+			}
 		} else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
 				int ret = __ipath_verbs_rcv(dd, rc + 1,
 							    ebuf, tlen);
@@ -949,6 +963,9 @@ reloop:
 					ipath_cdbg(VERBOSE,
 						   "received IB packet, "
 						   "not SMA (QP=%x)\n", qp);
+				if (dd->ipath_lli_counter)
+					dd->ipath_lli_counter--;
+
 		} else if (etype == RCVHQ_RCV_TYPE_EAGER) {
 			if (qp == IPATH_KD_QP &&
 			    bthbytes[0] == ipath_layer_rcv_opcode &&
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:26 2006 -0700
@@ -262,6 +262,7 @@ static void handle_e_ibstatuschanged(str
 				     | IPATH_LINKACTIVE |
 				     IPATH_LINKARMED);
 		*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
+		dd->ipath_lli_counter = 0;
 		if (!noprint) {
 			if (((dd->ipath_lastibcstat >>
 			      INFINIPATH_IBCS_LINKSTATE_SHIFT) &
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:26 2006 -0700
@@ -507,6 +507,11 @@ struct ipath_devdata {
 	u8 ipath_pci_cacheline;
 	/* LID mask control */
 	u8 ipath_lmc;
+
+	/* local link integrity counter */
+	u32 ipath_lli_counter;
+	/* local link integrity errors */
+	u32 ipath_lli_errors;
 };
 
 extern struct list_head ipath_dev_list;
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:26 2006 -0700
@@ -1032,19 +1032,22 @@ int ipath_layer_get_counters(struct ipat
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_ibsymbolerrcnt);
 	cntrs->link_error_recovery_counter =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_iblinkerrrecovcnt);
+	/*
+	 * The link downed counter counts when the other side downs the
+	 * connection.  We add in the number of times we downed the link
+	 * due to local link integrity errors to compensate.
+	 */
 	cntrs->link_downed_counter =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_iblinkdowncnt);
 	cntrs->port_rcv_errors =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rxdroppktcnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvovflcnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_portovflcnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errrcvflowctrlcnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_err_rlencnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_invalidrlencnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_erricrccnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errvcrccnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errlpcrccnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errlinkcnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_badformatcnt);
 	cntrs->port_rcv_remphys_errors =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvebpcnt);
@@ -1058,6 +1061,8 @@ int ipath_layer_get_counters(struct ipat
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
 	cntrs->port_rcv_packets =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
+	cntrs->local_link_integrity_errors = dd->ipath_lli_errors;
+	cntrs->excessive_buffer_overrun_errors = 0; /* XXX */
 
 	ret = 0;
 
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Thu Jun 29 14:33:26 2006 -0700
@@ -55,6 +55,8 @@ struct ipath_layer_counters {
 	u64 port_rcv_data;
 	u64 port_xmit_packets;
 	u64 port_rcv_packets;
+	u32 local_link_integrity_errors;
+	u32 excessive_buffer_overrun_errors;
 };
 
 /*
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:26 2006 -0700
@@ -613,6 +613,9 @@ struct ib_pma_portcounters {
 #define IB_PMA_SEL_PORT_RCV_ERRORS		__constant_htons(0x0008)
 #define IB_PMA_SEL_PORT_RCV_REMPHYS_ERRORS	__constant_htons(0x0010)
 #define IB_PMA_SEL_PORT_XMIT_DISCARDS		__constant_htons(0x0040)
+#define IB_PMA_SEL_LOCAL_LINK_INTEGRITY_ERRORS	__constant_htons(0x0200)
+#define IB_PMA_SEL_EXCESSIVE_BUFFER_OVERRUNS	__constant_htons(0x0400)
+#define IB_PMA_SEL_PORT_VL15_DROPPED		__constant_htons(0x0800)
 #define IB_PMA_SEL_PORT_XMIT_DATA		__constant_htons(0x1000)
 #define IB_PMA_SEL_PORT_RCV_DATA		__constant_htons(0x2000)
 #define IB_PMA_SEL_PORT_XMIT_PACKETS		__constant_htons(0x4000)
@@ -859,6 +862,10 @@ static int recv_pma_get_portcounters(str
 	cntrs.port_rcv_data -= dev->z_port_rcv_data;
 	cntrs.port_xmit_packets -= dev->z_port_xmit_packets;
 	cntrs.port_rcv_packets -= dev->z_port_rcv_packets;
+	cntrs.local_link_integrity_errors -=
+		dev->z_local_link_integrity_errors;
+	cntrs.excessive_buffer_overrun_errors -=
+		dev->z_excessive_buffer_overrun_errors;
 
 	memset(pmp->data, 0, sizeof(pmp->data));
 
@@ -896,6 +903,16 @@ static int recv_pma_get_portcounters(str
 	else
 		p->port_xmit_discards =
 			cpu_to_be16((u16)cntrs.port_xmit_discards);
+	if (cntrs.local_link_integrity_errors > 0xFUL)
+		cntrs.local_link_integrity_errors = 0xFUL;
+	if (cntrs.excessive_buffer_overrun_errors > 0xFUL)
+		cntrs.excessive_buffer_overrun_errors = 0xFUL;
+	p->lli_ebor_errors = (cntrs.local_link_integrity_errors << 4) |
+		cntrs.excessive_buffer_overrun_errors;
+	if (dev->n_vl15_dropped > 0xFFFFUL)
+		p->vl15_dropped = __constant_cpu_to_be16(0xFFFF);
+	else
+		p->vl15_dropped = cpu_to_be16((u16)dev->n_vl15_dropped);
 	if (cntrs.port_xmit_data > 0xFFFFFFFFUL)
 		p->port_xmit_data = __constant_cpu_to_be32(0xFFFFFFFF);
 	else
@@ -989,6 +1006,17 @@ static int recv_pma_set_portcounters(str
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DISCARDS)
 		dev->z_port_xmit_discards = cntrs.port_xmit_discards;
+
+	if (p->counter_select & IB_PMA_SEL_LOCAL_LINK_INTEGRITY_ERRORS)
+		dev->z_local_link_integrity_errors =
+			cntrs.local_link_integrity_errors;
+
+	if (p->counter_select & IB_PMA_SEL_EXCESSIVE_BUFFER_OVERRUNS)
+		dev->z_excessive_buffer_overrun_errors =
+			cntrs.excessive_buffer_overrun_errors;
+
+	if (p->counter_select & IB_PMA_SEL_PORT_VL15_DROPPED)
+		dev->n_vl15_dropped = 0;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DATA)
 		dev->z_port_xmit_data = cntrs.port_xmit_data;
@@ -1275,32 +1303,8 @@ int ipath_process_mad(struct ib_device *
 		      struct ib_wc *in_wc, struct ib_grh *in_grh,
 		      struct ib_mad *in_mad, struct ib_mad *out_mad)
 {
-	struct ipath_ibdev *dev = to_idev(ibdev);
 	int ret;
 
-	/*
-	 * Snapshot current HW counters to "clear" them.
-	 * This should be done when the driver is loaded except that for
-	 * some reason we get a zillion errors when brining up the link.
-	 */
-	if (dev->rcv_errors == 0) {
-		struct ipath_layer_counters cntrs;
-
-		ipath_layer_get_counters(to_idev(ibdev)->dd, &cntrs);
-		dev->rcv_errors++;
-		dev->z_symbol_error_counter = cntrs.symbol_error_counter;
-		dev->z_link_error_recovery_counter =
-			cntrs.link_error_recovery_counter;
-		dev->z_link_downed_counter = cntrs.link_downed_counter;
-		dev->z_port_rcv_errors = cntrs.port_rcv_errors + 1;
-		dev->z_port_rcv_remphys_errors =
-			cntrs.port_rcv_remphys_errors;
-		dev->z_port_xmit_discards = cntrs.port_xmit_discards;
-		dev->z_port_xmit_data = cntrs.port_xmit_data;
-		dev->z_port_rcv_data = cntrs.port_rcv_data;
-		dev->z_port_xmit_packets = cntrs.port_xmit_packets;
-		dev->z_port_rcv_packets = cntrs.port_rcv_packets;
-	}
 	switch (in_mad->mad_hdr.mgmt_class) {
 	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
 	case IB_MGMT_CLASS_SUBN_LID_ROUTED:
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:26 2006 -0700
@@ -560,7 +560,16 @@ void ipath_ud_rcv(struct ipath_ibdev *de
 	spin_lock_irqsave(&rq->lock, flags);
 	if (rq->tail == rq->head) {
 		spin_unlock_irqrestore(&rq->lock, flags);
-		dev->n_pkt_drops++;
+		/*
+		 * Count VL15 packets dropped due to no receive buffer.
+		 * Otherwise, count them as buffer overruns since usually,
+		 * the HW will be able to receive packets even if there are
+		 * no QPs with posted receive buffers.
+		 */
+		if (qp->ibqp.qp_num == 0)
+			dev->n_vl15_dropped++;
+		else
+			dev->rcv_errors++;
 		goto bail;
 	}
 	/* Silently drop packets which are too big. */
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -981,6 +981,7 @@ static int ipath_verbs_register_sysfs(st
  */
 static void *ipath_register_ib_device(int unit, struct ipath_devdata *dd)
 {
+	struct ipath_layer_counters cntrs;
 	struct ipath_ibdev *idev;
 	struct ib_device *dev;
 	int ret;
@@ -1030,6 +1031,25 @@ static void *ipath_register_ib_device(in
 	idev->pma_counter_select[3] = IB_PMA_PORT_RCV_PKTS;
 	idev->pma_counter_select[5] = IB_PMA_PORT_XMIT_WAIT;
 	idev->link_width_enabled = 3;	/* 1x or 4x */
+
+	/* Snapshot current HW counters to "clear" them. */
+	ipath_layer_get_counters(dd, &cntrs);
+	idev->z_symbol_error_counter = cntrs.symbol_error_counter;
+	idev->z_link_error_recovery_counter =
+		cntrs.link_error_recovery_counter;
+	idev->z_link_downed_counter = cntrs.link_downed_counter;
+	idev->z_port_rcv_errors = cntrs.port_rcv_errors;
+	idev->z_port_rcv_remphys_errors =
+		cntrs.port_rcv_remphys_errors;
+	idev->z_port_xmit_discards = cntrs.port_xmit_discards;
+	idev->z_port_xmit_data = cntrs.port_xmit_data;
+	idev->z_port_rcv_data = cntrs.port_rcv_data;
+	idev->z_port_xmit_packets = cntrs.port_xmit_packets;
+	idev->z_port_rcv_packets = cntrs.port_rcv_packets;
+	idev->z_local_link_integrity_errors =
+		cntrs.local_link_integrity_errors;
+	idev->z_excessive_buffer_overrun_errors =
+		cntrs.excessive_buffer_overrun_errors;
 
 	/*
 	 * The system image GUID is supposed to be the same for all
diff -r eef7f8021500 -r 7d22a8963bda drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:26 2006 -0700
@@ -460,6 +460,8 @@ struct ipath_ibdev {
 	u64 z_port_xmit_packets;		/* starting count for PMA */
 	u64 z_port_rcv_packets;			/* starting count for PMA */
 	u32 z_pkey_violations;			/* starting count for PMA */
+	u32 z_local_link_integrity_errors;	/* starting count for PMA */
+	u32 z_excessive_buffer_overrun_errors;	/* starting count for PMA */
 	u32 n_rc_resends;
 	u32 n_rc_acks;
 	u32 n_rc_qacks;
@@ -469,6 +471,7 @@ struct ipath_ibdev {
 	u32 n_other_naks;
 	u32 n_timeouts;
 	u32 n_pkt_drops;
+	u32 n_vl15_dropped;
 	u32 n_wqe_errs;
 	u32 n_rdma_dup_busy;
 	u32 n_piowait;
