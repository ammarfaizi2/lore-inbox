Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVAMAe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVAMAe1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVALV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:56:41 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261497AbVALVse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:34 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121348.Xc0vsayRkBF6BIqu@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:08 -0800
Message-Id: <20051121348.cZjtF8ckKVdplJpJ@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][13/18] InfiniBand/core: add more parameters to process_mad
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:13.0907 (UTC) FILETIME=[6AB17230:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add parameters to process_mad device method to support full Mellanox
firmware capabilities (pass sufficient information for baseboard
management trap generation, etc).

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/include/ib_verbs.h	(revision 1502)
+++ linux/drivers/infiniband/include/ib_verbs.h	(revision 1504)
@@ -684,9 +684,12 @@
 };
 
 struct ib_mad;
+struct ib_grh;
 
 enum ib_process_mad_flags {
-	IB_MAD_IGNORE_MKEY	= 1
+	IB_MAD_IGNORE_MKEY	= 1,
+	IB_MAD_IGNORE_BKEY	= 2,
+	IB_MAD_IGNORE_ALL	= IB_MAD_IGNORE_MKEY | IB_MAD_IGNORE_BKEY
 };
 
 enum ib_mad_result {
@@ -812,7 +815,8 @@
 	int                        (*process_mad)(struct ib_device *device,
 						  int process_mad_flags,
 						  u8 port_num,
-						  u16 source_lid,
+						  struct ib_wc *in_wc,
+						  struct ib_grh *in_grh,
 						  struct ib_mad *in_mad,
 						  struct ib_mad *out_mad);
 
--- linux/drivers/infiniband/core/mad.c	(revision 1502)
+++ linux/drivers/infiniband/core/mad.c	(revision 1504)
@@ -617,6 +617,23 @@
 	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
 }
 
+static void build_smp_wc(u64 wr_id, u16 slid, u16 pkey_index, u8 port_num,
+			 struct ib_wc *wc)
+{
+	memset(wc, 0, sizeof *wc);
+	wc->wr_id = wr_id;
+	wc->status = IB_WC_SUCCESS;
+	wc->opcode = IB_WC_RECV;
+	wc->pkey_index = pkey_index;
+	wc->byte_len = sizeof(struct ib_mad) + sizeof(struct ib_grh);
+	wc->src_qp = IB_QP0;
+	wc->qp_num = IB_QP0;
+	wc->slid = slid;
+	wc->sl = 0;
+	wc->dlid_path_bits = 0;
+	wc->port_num = port_num;
+}
+
 /*
  * Return 0 if SMP is to be sent
  * Return 1 if SMP was consumed locally (whether or not solicited)
@@ -634,6 +651,7 @@
 	struct ib_mad_agent_private *recv_mad_agent;
 	struct ib_device *device = mad_agent_priv->agent.device;
 	u8 port_num = mad_agent_priv->agent.port_num;
+	struct ib_wc mad_wc;
 
 	if (!smi_handle_dr_smp_send(smp, device->node_type, port_num)) {
 		ret = -EINVAL;
@@ -664,7 +682,12 @@
 		kfree(local);
 		goto out;
 	}
-	ret = device->process_mad(device, 0, port_num, smp->dr_slid,
+	
+	build_smp_wc(send_wr->wr_id, smp->dr_slid, send_wr->wr.ud.pkey_index,
+		     send_wr->wr.ud.port_num, &mad_wc);
+
+	/* No GRH for DR SMP */
+	ret = device->process_mad(device, 0, port_num, &mad_wc, NULL,
 				  (struct ib_mad *)smp,
 				  (struct ib_mad *)&mad_priv->mad);
 	switch (ret)
@@ -1622,7 +1645,7 @@
 
 		ret = port_priv->device->process_mad(port_priv->device, 0,
 						     port_priv->port_num,
-						     wc->slid,
+						     wc, &recv->grh,
 						     &recv->mad.mad,
 						     &response->mad.mad);
 		if (ret & IB_MAD_RESULT_SUCCESS) {
@@ -2050,19 +2073,10 @@
 			 * Defined behavior is to complete response
 			 * before request
 			 */
-			wc.wr_id = local->wr_id;
-			wc.status = IB_WC_SUCCESS;
-			wc.opcode = IB_WC_RECV;
-			wc.vendor_err = 0;
-			wc.byte_len = sizeof(struct ib_mad) +
-				      sizeof(struct ib_grh);
-			wc.src_qp = IB_QP0;
-			wc.wc_flags = 0;	/* No GRH */
-			wc.pkey_index = 0;
-			wc.slid = IB_LID_PERMISSIVE;
-			wc.sl = 0;
-			wc.dlid_path_bits = 0;
-			wc.qp_num = IB_QP0;
+			build_smp_wc(local->wr_id, IB_LID_PERMISSIVE,
+				     0 /* pkey index */,
+				     recv_mad_agent->agent.port_num, &wc);
+
 			local->mad_priv->header.recv_wc.wc = &wc;
 			local->mad_priv->header.recv_wc.mad_len =
 						sizeof(struct ib_mad);
--- linux/drivers/infiniband/core/sysfs.c	(revision 1502)
+++ linux/drivers/infiniband/core/sysfs.c	(revision 1504)
@@ -315,8 +315,8 @@
 
 	in_mad->data[41] = p->port_num;	/* PortSelect field */
 
-	if ((p->ibdev->process_mad(p->ibdev, IB_MAD_IGNORE_MKEY, p->port_num, 0xffff,
-				   in_mad, out_mad) &
+	if ((p->ibdev->process_mad(p->ibdev, IB_MAD_IGNORE_MKEY,
+		 p->port_num, NULL, NULL, in_mad, out_mad) &
 	     (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) !=
 	    (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) {
 		ret = -EINVAL;
--- linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1502)
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	(revision 1504)
@@ -381,7 +381,8 @@
 int mthca_process_mad(struct ib_device *ibdev,
 		      int mad_flags,
 		      u8 port_num,
-		      u16 slid,
+		      struct ib_wc *in_wc,
+		      struct ib_grh *in_grh,
 		      struct ib_mad *in_mad,
 		      struct ib_mad *out_mad);
 int mthca_create_agents(struct mthca_dev *dev);
--- linux/drivers/infiniband/hw/mthca/mthca_mad.c	(revision 1502)
+++ linux/drivers/infiniband/hw/mthca/mthca_mad.c	(revision 1504)
@@ -185,12 +185,14 @@
 int mthca_process_mad(struct ib_device *ibdev,
 		      int mad_flags,
 		      u8 port_num,
-		      u16 slid,
+		      struct ib_wc *in_wc,
+		      struct ib_grh *in_grh,
 		      struct ib_mad *in_mad,
 		      struct ib_mad *out_mad)
 {
 	int err;
 	u8 status;
+	u16 slid = in_wc ? in_wc->slid : IB_LID_PERMISSIVE;
 
 	/* Forward locally generated traps to the SM */
 	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP &&

