Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWELXqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWELXqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWELXp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:59 -0400
Received: from mx.pathscale.com ([64.160.42.68]:61353 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932183AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 36 of 53] ipath - count local link integrity errors
X-Mercurial-Node: ec1934faf5d11e165c9c528df2a4afa51bfdf660
Message-Id: <ec1934faf5d11e165c9c.1147477401@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:21 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
@@ -446,6 +446,8 @@ static int __devinit ipath_init_one(stru
 	 * by ipath_setup_htconfig.
 	 */
 	dd->ipath_flags = 0;
+	dd->ipath_lli_counter = 0;
+	dd->ipath_lli_errors = 0;
 
 	if (dd->ipath_f_bus(dd, pdev))
 		ipath_dev_err(dd, "Failed to setup config space; "
@@ -927,6 +929,18 @@ void ipath_kreceive(struct ipath_devdata
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
@@ -934,6 +948,8 @@ void ipath_kreceive(struct ipath_devdata
 					ipath_cdbg(VERBOSE,
 						   "received IB packet, "
 						   "not SMA (QP=%x)\n", qp);
+				if (dd->ipath_lli_counter)
+					dd->ipath_lli_counter--;
 		} else if (etype == RCVHQ_RCV_TYPE_EAGER) {
 			if (qp == IPATH_KD_QP &&
 			    bthbytes[0] == ipath_layer_rcv_opcode &&
@@ -1864,19 +1880,19 @@ static void __exit infinipath_cleanup(vo
 			} else
 				ipath_dbg("irq is 0, not doing free_irq "
 					  "for unit %u\n", dd->ipath_unit);
+
+			/*
+			 * we check for NULL here, because it's outside
+			 * the kregbase check, and we need to call it
+			 * after the free_irq.  Thus it's possible that
+			 * the function pointers were never initialized.
+			 */
+			if (dd->ipath_f_cleanup)
+				/* clean up chip-specific stuff */
+				dd->ipath_f_cleanup(dd);
+
 			dd->pcidev = NULL;
 		}
-
-		/*
-		 * we check for NULL here, because it's outside the kregbase
-		 * check, and we need to call it after the free_irq.  Thus
-		 * it's possible that the function pointers were never
-		 * initialized.
-		 */
-		if (dd->ipath_f_cleanup)
-			/* clean up chip-specific stuff */
-			dd->ipath_f_cleanup(dd);
-
 		spin_lock_irqsave(&ipath_devs_lock, flags);
 	}
 
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
@@ -261,6 +261,7 @@ static void handle_e_ibstatuschanged(str
 				     | IPATH_LINKACTIVE |
 				     IPATH_LINKARMED);
 		*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
+		dd->ipath_lli_counter = 0;
 		if (!noprint) {
 			if (((dd->ipath_lastibcstat >>
 			      INFINIPATH_IBCS_LINKSTATE_SHIFT) &
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:28 2006 -0700
@@ -509,6 +509,11 @@ struct ipath_devdata {
 	u8 ipath_pci_cacheline;
 	/* LID mask control */
 	u8 ipath_lmc;
+
+	/* local link integrity counter */
+	u32 ipath_lli_counter;
+	/* local link integrity errors */
+	u32 ipath_lli_errors;
 };
 
 
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:28 2006 -0700
@@ -1013,6 +1013,11 @@ int ipath_layer_get_counters(struct ipat
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
@@ -1037,6 +1042,8 @@ int ipath_layer_get_counters(struct ipat
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
 	cntrs->port_rcv_packets =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
+	cntrs->local_link_integrity_errors = dd->ipath_lli_errors;
+	cntrs->excessive_buffer_overrun_errors = 0; /* XXX */
 
 	ret = 0;
 
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Fri May 12 15:55:28 2006 -0700
@@ -54,6 +54,8 @@ struct ipath_layer_counters {
 	u64 port_rcv_data;
 	u64 port_xmit_packets;
 	u64 port_rcv_packets;
+	u32 local_link_integrity_errors;
+	u32 excessive_buffer_overrun_errors;
 };
 
 /*
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:28 2006 -0700
@@ -646,6 +646,8 @@ struct ib_pma_portcounters {
 #define IB_PMA_SEL_PORT_RCV_ERRORS		__constant_htons(0x0008)
 #define IB_PMA_SEL_PORT_RCV_REMPHYS_ERRORS	__constant_htons(0x0010)
 #define IB_PMA_SEL_PORT_XMIT_DISCARDS		__constant_htons(0x0040)
+#define IB_PMA_SEL_LOCAL_LINK_INTEGRITY_ERRORS	__constant_htons(0x0200)
+#define IB_PMA_SEL_EXCESSIVE_BUFFER_OVERRUNS	__constant_htons(0x0400)
 #define IB_PMA_SEL_PORT_VL15_DROPPED		__constant_htons(0x0800)
 #define IB_PMA_SEL_PORT_XMIT_DATA		__constant_htons(0x1000)
 #define IB_PMA_SEL_PORT_RCV_DATA		__constant_htons(0x2000)
@@ -893,6 +895,10 @@ static int recv_pma_get_portcounters(str
 	cntrs.port_rcv_data -= dev->n_port_rcv_data;
 	cntrs.port_xmit_packets -= dev->n_port_xmit_packets;
 	cntrs.port_rcv_packets -= dev->n_port_rcv_packets;
+	cntrs.local_link_integrity_errors -=
+		dev->z_local_link_integrity_errors;
+	cntrs.excessive_buffer_overrun_errors -=
+		dev->z_excessive_buffer_overrun_errors;
 
 	memset(pmp->data, 0, sizeof(pmp->data));
 
@@ -930,6 +936,12 @@ static int recv_pma_get_portcounters(str
 	else
 		p->port_xmit_discards =
 			cpu_to_be16((u16)cntrs.port_xmit_discards);
+	if (cntrs.local_link_integrity_errors > 0xFUL)
+		cntrs.local_link_integrity_errors = 0xFUL;
+	if (cntrs.excessive_buffer_overrun_errors > 0xFUL)
+		cntrs.excessive_buffer_overrun_errors = 0xFUL;
+	p->lli_ebor_errors = (cntrs.local_link_integrity_errors << 4) |
+		cntrs.excessive_buffer_overrun_errors;
 	if (dev->n_vl15_dropped > 0xFFFFUL)
 		p->vl15_dropped = __constant_cpu_to_be16(0xFFFF);
 	else
@@ -1028,6 +1040,14 @@ static int recv_pma_set_portcounters(str
 	if (p->counter_select & IB_PMA_SEL_PORT_XMIT_DISCARDS)
 		dev->n_port_xmit_discards = cntrs.port_xmit_discards;
 
+	if (p->counter_select & IB_PMA_SEL_LOCAL_LINK_INTEGRITY_ERRORS)
+		dev->z_local_link_integrity_errors =
+			cntrs.local_link_integrity_errors;
+
+	if (p->counter_select & IB_PMA_SEL_EXCESSIVE_BUFFER_OVERRUNS)
+		dev->z_excessive_buffer_overrun_errors =
+			cntrs.excessive_buffer_overrun_errors;
+
 	if (p->counter_select & IB_PMA_SEL_PORT_VL15_DROPPED)
 		dev->n_vl15_dropped = 0;
 
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -1046,6 +1046,10 @@ static void *ipath_register_ib_device(in
 	idev->n_port_rcv_data = cntrs.port_rcv_data;
 	idev->n_port_xmit_packets = cntrs.port_xmit_packets;
 	idev->n_port_rcv_packets = cntrs.port_rcv_packets;
+	idev->z_local_link_integrity_errors =
+		cntrs.local_link_integrity_errors;
+	idev->z_excessive_buffer_overrun_errors =
+		cntrs.excessive_buffer_overrun_errors;
 
 	/*
 	 * The system image GUID is supposed to be the same for all
diff -r e29625bd9050 -r ec1934faf5d1 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
@@ -459,6 +459,8 @@ struct ipath_ibdev {
 	u64 n_port_xmit_packets;	/* starting count for PMA */
 	u64 n_port_rcv_packets;	/* starting count for PMA */
 	u32 n_pkey_violations;	/* starting count for PMA */
+	u32 z_local_link_integrity_errors;	/* starting count for PMA */
+	u32 z_excessive_buffer_overrun_errors;	/* starting count for PMA */
 	u32 n_rc_resends;
 	u32 n_rc_acks;
 	u32 n_rc_qacks;
