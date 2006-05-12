Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWELXy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWELXy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWELXpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:06 -0400
Received: from mx.pathscale.com ([64.160.42.68]:61609 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932278AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 37 of 53] ipath - name zero counter offsets consistently
X-Mercurial-Node: f8debae94d44f543ff99cb89b6146e948dccb76f
Message-Id: <f8debae94d44f543ff99.1147477402@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:22 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name zero counter offsets consistently so it's clear they aren't counters.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ec1934faf5d1 -r f8debae94d44 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
@@ -251,7 +251,7 @@ static int recv_subn_get_portinfo(struct
 	/* P_KeyViolations are counted by hardware. */
 	pip->pkey_violations =
 		cpu_to_be16((ipath_layer_get_cr_errpkey(dev->dd) -
-			     dev->n_pkey_violations) & 0xFFFF);
+			     dev->z_pkey_violations) & 0xFFFF);
 	pip->qkey_violations = cpu_to_be16(dev->qkey_violations);
 	/* Only the hardware GUID is supported for now */
 	pip->guid_cap = 1;
@@ -425,7 +425,7 @@ static int recv_subn_set_portinfo(struct
 	 * later.
 	 */
 	if (pip->pkey_violations == 0)
-		dev->n_pkey_violations =
+		dev->z_pkey_violations =
 			ipath_layer_get_cr_errpkey(dev->dd);
 
 	if (pip->qkey_violations == 0)
@@ -883,18 +883,18 @@ static int recv_pma_get_portcounters(str
 	ipath_layer_get_counters(dev->dd, &cntrs);
 
 	/* Adjust counters for any resets done. */
-	cntrs.symbol_error_counter -= dev->n_symbol_error_counter;
+	cntrs.symbol_error_counter -= dev->z_symbol_error_counter;
 	cntrs.link_error_recovery_counter -=
-		dev->n_link_error_recovery_counter;
-	cntrs.link_downed_counter -= dev->n_link_downed_counter;
+		dev->z_link_error_recovery_counter;
+	cntrs.link_downed_counter -= dev->z_link_downed_counter;
 	cntrs.port_rcv_errors += dev->rcv_errors;
-	cntrs.port_rcv_errors -= dev->n_port_rcv_errors;
-	cntrs.port_rcv_remphys_errors -= dev->n_port_rcv_remphys_errors;
-	cntrs.port_xmit_discards -= dev->n_port_xmit_discards;
-	cntrs.port_xmit_data -= dev->n_port_xmit_data;
-	cntrs.port_rcv_data -= dev->n_port_rcv_data;
-	cntrs.port_xmit_packets -= dev->n_port_xmit_packets;
-	cntrs.port_rcv_packets -= dev->n_port_rcv_packets;
+	cntrs.port_rcv_errors -= dev->z_port_rcv_errors;
+	cntrs.port_rcv_remphys_errors -= dev->z_port_rcv_remphys_errors;
+	cntrs.port_xmit_discards -= dev->z_port_xmit_discards;
+	cntrs.port_xmit_data -= dev->z_port_xmit_data;
+	cntrs.port_rcv_data -= dev->z_port_rcv_data;
+	cntrs.port_xmit_packets -= dev->z_port_xmit_packets;
+	cntrs.port_rcv_packets -= dev->z_port_rcv_packets;
 	cntrs.local_link_integrity_errors -=
 		dev->z_local_link_integrity_errors;
 	cntrs.excessive_buffer_overrun_errors -=
@@ -981,10 +981,10 @@ static int recv_pma_get_portcounters_ext
 				      &rpkts, &xwait);
 
 	/* Adjust counters for any resets done. */
-	swords -= dev->n_port_xmit_data;
-	rwords -= dev->n_port_rcv_data;
-	spkts -= dev->n_port_xmit_packets;
-	rpkts -= dev->n_port_rcv_packets;
+	swords -= dev->z_port_xmit_data;
+	rwords -= dev->z_port_rcv_data;
+	spkts -= dev->z_port_xmit_packets;
+	rpkts -= dev->z_port_rcv_packets;
 
 	memset(pmp->data, 0, sizeof(pmp->data));
 
@@ -1020,25 +1020,25 @@ static int recv_pma_set_portcounters(str
 	ipath_layer_get_counters(dev->dd, &cntrs);
 
 	if (p->counter_select & IB_PMA_SEL_SYMBOL_ERROR)
-		dev->n_symbol_error_counter = cntrs.symbol_error_counter;
+		dev->z_symbol_error_counter = cntrs.symbol_error_counter;
 
 	if (p->counter_select & IB_PMA_SEL_LINK_ERROR_RECOVERY)
-		dev->n_link_error_recovery_counter =
+		dev->z_link_error_recovery_counter =
 			cntrs.link_error_recovery_counter;
 
 	if (p->counter_select & IB_PMA_SEL_LINK_DOWNED)
-		dev->n_link_downed_counter = cntrs.link_downed_counter;
+		dev->z_link_downed_counter = cntrs.link_downed_counter;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_RCV_ERRORS)
-		dev->n_port_rcv_errors =
+		dev->z_port_rcv_errors =
 			cntrs.port_rcv_errors + dev->rcv_errors;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_RCV_REMPHYS_ERRORS)
-		dev->n_port_rcv_remphys_errors =
+		dev->z_port_rcv_remphys_errors =
 			cntrs.port_rcv_remphys_errors;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DISCARDS)
-		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
+		dev->z_port_xmit_discards = cntrs.port_xmit_discards;
 
 	if (p->counter_select & IB_PMA_SEL_LOCAL_LINK_INTEGRITY_ERRORS)
 		dev->z_local_link_integrity_errors =
@@ -1052,16 +1052,16 @@ static int recv_pma_set_portcounters(str
 		dev->n_vl15_dropped = 0;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DATA)
-		dev->n_port_xmit_data = cntrs.port_xmit_data;
+		dev->z_port_xmit_data = cntrs.port_xmit_data;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_RCV_DATA)
-		dev->n_port_rcv_data = cntrs.port_rcv_data;
+		dev->z_port_rcv_data = cntrs.port_rcv_data;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_PACKETS)
-		dev->n_port_xmit_packets = cntrs.port_xmit_packets;
+		dev->z_port_xmit_packets = cntrs.port_xmit_packets;
 
 	if (p->counter_select & IB_PMA_SEL_PORT_RCV_PACKETS)
-		dev->n_port_rcv_packets = cntrs.port_rcv_packets;
+		dev->z_port_rcv_packets = cntrs.port_rcv_packets;
 
 	return recv_pma_get_portcounters(pmp, ibdev, port);
 }
@@ -1078,16 +1078,16 @@ static int recv_pma_set_portcounters_ext
 				      &rpkts, &xwait);
 
 	if (p->counter_select & IB_PMA_SELX_PORT_XMIT_DATA)
-		dev->n_port_xmit_data = swords;
+		dev->z_port_xmit_data = swords;
 
 	if (p->counter_select & IB_PMA_SELX_PORT_RCV_DATA)
-		dev->n_port_rcv_data = rwords;
+		dev->z_port_rcv_data = rwords;
 
 	if (p->counter_select & IB_PMA_SELX_PORT_XMIT_PACKETS)
-		dev->n_port_xmit_packets = spkts;
+		dev->z_port_xmit_packets = spkts;
 
 	if (p->counter_select & IB_PMA_SELX_PORT_RCV_PACKETS)
-		dev->n_port_rcv_packets = rpkts;
+		dev->z_port_rcv_packets = rpkts;
 
 	if (p->counter_select & IB_PMA_SELX_PORT_UNI_XMIT_PACKETS)
 		dev->n_unicast_xmit = 0;
diff -r ec1934faf5d1 -r f8debae94d44 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -700,7 +700,7 @@ static int ipath_query_port(struct ib_de
 	props->max_msg_sz = 4096;
 	props->pkey_tbl_len = ipath_layer_get_npkeys(dev->dd);
 	props->bad_pkey_cntr = ipath_layer_get_cr_errpkey(dev->dd) -
-		dev->n_pkey_violations;
+		dev->z_pkey_violations;
 	props->qkey_viol_cntr = dev->qkey_violations;
 	props->active_width = IB_WIDTH_4X;
 	/* See rate_show() */
@@ -1034,18 +1034,18 @@ static void *ipath_register_ib_device(in
 
 	/* Snapshot current HW counters to "clear" them. */
 	ipath_layer_get_counters(dd, &cntrs);
-	idev->n_symbol_error_counter = cntrs.symbol_error_counter;
-	idev->n_link_error_recovery_counter =
+	idev->z_symbol_error_counter = cntrs.symbol_error_counter;
+	idev->z_link_error_recovery_counter =
 		cntrs.link_error_recovery_counter;
-	idev->n_link_downed_counter = cntrs.link_downed_counter;
-	idev->n_port_rcv_errors = cntrs.port_rcv_errors;
-	idev->n_port_rcv_remphys_errors =
+	idev->z_link_downed_counter = cntrs.link_downed_counter;
+	idev->z_port_rcv_errors = cntrs.port_rcv_errors;
+	idev->z_port_rcv_remphys_errors =
 		cntrs.port_rcv_remphys_errors;
-	idev->n_port_xmit_discards = cntrs.port_xmit_discards;
-	idev->n_port_xmit_data = cntrs.port_xmit_data;
-	idev->n_port_rcv_data = cntrs.port_rcv_data;
-	idev->n_port_xmit_packets = cntrs.port_xmit_packets;
-	idev->n_port_rcv_packets = cntrs.port_rcv_packets;
+	idev->z_port_xmit_discards = cntrs.port_xmit_discards;
+	idev->z_port_xmit_data = cntrs.port_xmit_data;
+	idev->z_port_rcv_data = cntrs.port_rcv_data;
+	idev->z_port_xmit_packets = cntrs.port_xmit_packets;
+	idev->z_port_rcv_packets = cntrs.port_rcv_packets;
 	idev->z_local_link_integrity_errors =
 		cntrs.local_link_integrity_errors;
 	idev->z_excessive_buffer_overrun_errors =
diff -r ec1934faf5d1 -r f8debae94d44 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
@@ -448,17 +448,17 @@ struct ipath_ibdev {
 	u64 n_unicast_rcv;	/* total unicast packets received */
 	u64 n_multicast_xmit;	/* total multicast packets sent */
 	u64 n_multicast_rcv;	/* total multicast packets received */
-	u64 n_symbol_error_counter;	/* starting count for PMA */
-	u64 n_link_error_recovery_counter;	/* starting count for PMA */
-	u64 n_link_downed_counter;	/* starting count for PMA */
-	u64 n_port_rcv_errors;	/* starting count for PMA */
-	u64 n_port_rcv_remphys_errors;	/* starting count for PMA */
-	u64 n_port_xmit_discards;	/* starting count for PMA */
-	u64 n_port_xmit_data;	/* starting count for PMA */
-	u64 n_port_rcv_data;	/* starting count for PMA */
-	u64 n_port_xmit_packets;	/* starting count for PMA */
-	u64 n_port_rcv_packets;	/* starting count for PMA */
-	u32 n_pkey_violations;	/* starting count for PMA */
+	u64 z_symbol_error_counter;		/* starting count for PMA */
+	u64 z_link_error_recovery_counter;	/* starting count for PMA */
+	u64 z_link_downed_counter;		/* starting count for PMA */
+	u64 z_port_rcv_errors;			/* starting count for PMA */
+	u64 z_port_rcv_remphys_errors;		/* starting count for PMA */
+	u64 z_port_xmit_discards;		/* starting count for PMA */
+	u64 z_port_xmit_data;			/* starting count for PMA */
+	u64 z_port_rcv_data;			/* starting count for PMA */
+	u64 z_port_xmit_packets;		/* starting count for PMA */
+	u64 z_port_rcv_packets;			/* starting count for PMA */
+	u32 z_pkey_violations;			/* starting count for PMA */
 	u32 z_local_link_integrity_errors;	/* starting count for PMA */
 	u32 z_excessive_buffer_overrun_errors;	/* starting count for PMA */
 	u32 n_rc_resends;
