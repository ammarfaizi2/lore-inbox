Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWELXpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWELXpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWELXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:47 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58025 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932270AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 27 of 53] ipath - fix accounting of data packets with bad VLs
X-Mercurial-Node: 551966b88d7c74827a548a45b166f8a38f335217
Message-Id: <551966b88d7c74827a54.1147477392@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:12 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For better IB conformance.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 8e2d63833cf2 -r 551966b88d7c drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:28 2006 -0700
@@ -1019,13 +1019,11 @@ int ipath_layer_get_counters(struct ipat
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
diff -r 8e2d63833cf2 -r 551966b88d7c drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
@@ -1316,32 +1316,8 @@ int ipath_process_mad(struct ib_device *
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
-		dev->n_symbol_error_counter = cntrs.symbol_error_counter;
-		dev->n_link_error_recovery_counter =
-			cntrs.link_error_recovery_counter;
-		dev->n_link_downed_counter = cntrs.link_downed_counter;
-		dev->n_port_rcv_errors = cntrs.port_rcv_errors + 1;
-		dev->n_port_rcv_remphys_errors =
-			cntrs.port_rcv_remphys_errors;
-		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
-		dev->n_port_xmit_data = cntrs.port_xmit_data;
-		dev->n_port_rcv_data = cntrs.port_rcv_data;
-		dev->n_port_xmit_packets = cntrs.port_xmit_packets;
-		dev->n_port_rcv_packets = cntrs.port_rcv_packets;
-	}
 	switch (in_mad->mad_hdr.mgmt_class) {
 	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
 	case IB_MGMT_CLASS_SUBN_LID_ROUTED:
diff -r 8e2d63833cf2 -r 551966b88d7c drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -981,6 +981,7 @@ static int ipath_verbs_register_sysfs(st
  */
 static void *ipath_register_ib_device(int unit, struct ipath_devdata *dd)
 {
+	struct ipath_layer_counters cntrs;
 	struct ipath_ibdev *idev;
 	struct ib_device *dev;
 	int ret;
@@ -1030,6 +1031,21 @@ static void *ipath_register_ib_device(in
 	idev->pma_counter_select[3] = IB_PMA_PORT_RCV_PKTS;
 	idev->pma_counter_select[5] = IB_PMA_PORT_XMIT_WAIT;
 	idev->link_width_enabled = 3;	/* 1x or 4x */
+
+	/* Snapshot current HW counters to "clear" them. */
+	ipath_layer_get_counters(dd, &cntrs);
+	idev->n_symbol_error_counter = cntrs.symbol_error_counter;
+	idev->n_link_error_recovery_counter =
+		cntrs.link_error_recovery_counter;
+	idev->n_link_downed_counter = cntrs.link_downed_counter;
+	idev->n_port_rcv_errors = cntrs.port_rcv_errors;
+	idev->n_port_rcv_remphys_errors =
+		cntrs.port_rcv_remphys_errors;
+	idev->n_port_xmit_discards = cntrs.port_xmit_discards;
+	idev->n_port_xmit_data = cntrs.port_xmit_data;
+	idev->n_port_rcv_data = cntrs.port_rcv_data;
+	idev->n_port_xmit_packets = cntrs.port_xmit_packets;
+	idev->n_port_rcv_packets = cntrs.port_rcv_packets;
 
 	/*
 	 * The system image GUID is supposed to be the same for all
