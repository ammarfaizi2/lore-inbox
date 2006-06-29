Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933030AbWF2WGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbWF2WGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbWF2WEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:04:04 -0400
Received: from mx.pathscale.com ([64.160.42.68]:28303 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932829AbWF2VoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:08 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 39] IB/ipath - Name zero counter offsets so it's clear
	they aren't counters
X-Mercurial-Node: addf90abc7248e961bdbfdef256be84ed6bc80c5
Message-Id: <addf90abc7248e961bdb.1151617252@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:52 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 28e3d8204fdb -r addf90abc724 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri Jun 23 22:47:27 2006 +0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:25 2006 -0700
@@ -215,7 +215,7 @@ static int recv_subn_get_portinfo(struct
 	/* P_KeyViolations are counted by hardware. */
 	pip->pkey_violations =
 		cpu_to_be16((ipath_layer_get_cr_errpkey(dev->dd) -
-			     dev->n_pkey_violations) & 0xFFFF);
+			     dev->z_pkey_violations) & 0xFFFF);
 	pip->qkey_violations = cpu_to_be16(dev->qkey_violations);
 	/* Only the hardware GUID is supported for now */
 	pip->guid_cap = 1;
@@ -389,7 +389,7 @@ static int recv_subn_set_portinfo(struct
 	 * later.
 	 */
 	if (pip->pkey_violations == 0)
-		dev->n_pkey_violations =
+		dev->z_pkey_violations =
 			ipath_layer_get_cr_errpkey(dev->dd);
 
 	if (pip->qkey_violations == 0)
@@ -844,18 +844,18 @@ static int recv_pma_get_portcounters(str
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
 
 	memset(pmp->data, 0, sizeof(pmp->data));
 
@@ -928,10 +928,10 @@ static int recv_pma_get_portcounters_ext
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
 
@@ -967,37 +967,37 @@ static int recv_pma_set_portcounters(str
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
@@ -1014,16 +1014,16 @@ static int recv_pma_set_portcounters_ext
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
@@ -1285,18 +1285,18 @@ int ipath_process_mad(struct ib_device *
 
 		ipath_layer_get_counters(to_idev(ibdev)->dd, &cntrs);
 		dev->rcv_errors++;
-		dev->n_symbol_error_counter = cntrs.symbol_error_counter;
-		dev->n_link_error_recovery_counter =
+		dev->z_symbol_error_counter = cntrs.symbol_error_counter;
+		dev->z_link_error_recovery_counter =
 			cntrs.link_error_recovery_counter;
-		dev->n_link_downed_counter = cntrs.link_downed_counter;
-		dev->n_port_rcv_errors = cntrs.port_rcv_errors + 1;
-		dev->n_port_rcv_remphys_errors =
+		dev->z_link_downed_counter = cntrs.link_downed_counter;
+		dev->z_port_rcv_errors = cntrs.port_rcv_errors + 1;
+		dev->z_port_rcv_remphys_errors =
 			cntrs.port_rcv_remphys_errors;
-		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
-		dev->n_port_xmit_data = cntrs.port_xmit_data;
-		dev->n_port_rcv_data = cntrs.port_rcv_data;
-		dev->n_port_xmit_packets = cntrs.port_xmit_packets;
-		dev->n_port_rcv_packets = cntrs.port_rcv_packets;
+		dev->z_port_xmit_discards = cntrs.port_xmit_discards;
+		dev->z_port_xmit_data = cntrs.port_xmit_data;
+		dev->z_port_rcv_data = cntrs.port_rcv_data;
+		dev->z_port_xmit_packets = cntrs.port_xmit_packets;
+		dev->z_port_rcv_packets = cntrs.port_rcv_packets;
 	}
 	switch (in_mad->mad_hdr.mgmt_class) {
 	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
diff -r 28e3d8204fdb -r addf90abc724 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri Jun 23 22:47:27 2006 +0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
@@ -646,7 +646,7 @@ static int ipath_query_port(struct ib_de
 	props->max_msg_sz = 4096;
 	props->pkey_tbl_len = ipath_layer_get_npkeys(dev->dd);
 	props->bad_pkey_cntr = ipath_layer_get_cr_errpkey(dev->dd) -
-		dev->n_pkey_violations;
+		dev->z_pkey_violations;
 	props->qkey_viol_cntr = dev->qkey_violations;
 	props->active_width = IB_WIDTH_4X;
 	/* See rate_show() */
diff -r 28e3d8204fdb -r addf90abc724 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Jun 23 22:47:27 2006 +0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
@@ -442,17 +442,17 @@ struct ipath_ibdev {
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
 	u32 n_rc_resends;
 	u32 n_rc_acks;
 	u32 n_rc_qacks;
