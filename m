Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVGKUgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVGKUgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVGKUeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:34:19 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:23501 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262651AbVGKUeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:34:11 -0400
Subject: [PATCH 16/29v2] Add ib_create_ah_from_wc to IB verbs
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110331.4389.5016.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:26:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added new call: ib_create_ah_from_wc. Call will allocate an 
address handle given work completion information, including any
received GRH.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 15/29.

--
 core/verbs.c       |   35 +++++++++++++++++++++++++++++++++++
 include/ib_mad.h   |    9 --
 include/ib_verbs.h |   24 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 9 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-15/drivers/infiniband/core/verbs.c linux-2.6.13-rc2-mm1-16/drivers/infiniband/core/verbs.c
-- linux-2.6.13-rc2-mm1-15/drivers/infiniband/core/verbs.c	2005-07-10 11:09:37.000000000 -0400
+++ linux-2.6.13-rc2-mm1-16/drivers/infiniband/core/verbs.c	2005-07-10 11:43:44.000000000 -0400
@@ -41,6 +41,7 @@
 #include <linux/err.h>
 
 #include <ib_verbs.h>
+#include <ib_cache.h>
 
 /* Protection domains */
 
@@ -88,6 +89,40 @@ struct ib_ah *ib_create_ah(struct ib_pd 
 }
 EXPORT_SYMBOL(ib_create_ah);
 
+struct ib_ah *ib_create_ah_from_wc(struct ib_pd *pd, struct ib_wc *wc,
+				   struct ib_grh *grh, u8 port_num)
+{
+	struct ib_ah_attr ah_attr;
+	u32 flow_class;
+	u16 gid_index;
+	int ret;
+
+	memset(&ah_attr, 0, sizeof ah_attr);
+	ah_attr.dlid = wc->slid;
+	ah_attr.sl = wc->sl;
+	ah_attr.src_path_bits = wc->dlid_path_bits;
+	ah_attr.port_num = port_num;
+	
+	if (wc->wc_flags & IB_WC_GRH) {
+		ah_attr.ah_flags = IB_AH_GRH;
+		ah_attr.grh.dgid = grh->dgid;
+
+		ret = ib_find_cached_gid(pd->device, &grh->sgid, &port_num,
+					 &gid_index);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ah_attr.grh.sgid_index = (u8) gid_index;
+		flow_class = be32_to_cpu(&grh->version_tclass_flow);
+		ah_attr.grh.flow_label = flow_class & 0xFFFFF;
+		ah_attr.grh.traffic_class = (flow_class >> 20) & 0xFF;
+		ah_attr.grh.hop_limit = grh->hop_limit;
+	}
+
+	return ib_create_ah(pd, &ah_attr);
+}
+EXPORT_SYMBOL(ib_create_ah_from_wc);
+
 int ib_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
 {
 	return ah->device->modify_ah ?
diff -uprN linux-2.6.13-rc2-mm1-15/drivers/infiniband/include/ib_mad.h linux-2.6.13-rc2-mm1-16/drivers/infiniband/include/ib_mad.h
-- linux-2.6.13-rc2-mm1-15/drivers/infiniband/include/ib_mad.h	2005-07-11 13:38:52.000000000 -0400
+++ linux-2.6.13-rc2-mm1-16/drivers/infiniband/include/ib_mad.h	2005-07-11 13:39:04.000000000 -0400
@@ -77,15 +77,6 @@
 #define IB_QP1_QKEY	0x80010000
 #define IB_QP_SET_QKEY	0x80000000
 
-struct ib_grh {
-	u32		version_tclass_flow;
-	u16		paylen;
-	u8		next_hdr;
-	u8		hop_limit;
-	union ib_gid	sgid;
-	union ib_gid	dgid;
-} __attribute__ ((packed));
-
 struct ib_mad_hdr {
 	u8	base_version;
 	u8	mgmt_class;
diff -uprN linux-2.6.13-rc2-mm1-15/drivers/infiniband/include/ib_verbs.h linux-2.6.13-rc2-mm1-16/drivers/infiniband/include/ib_verbs.h
-- linux-2.6.13-rc2-mm1-15/drivers/infiniband/include/ib_verbs.h	2005-07-10 10:55:59.000000000 -0400
+++ linux-2.6.13-rc2-mm1-16/drivers/infiniband/include/ib_verbs.h	2005-07-10 11:43:45.000000000 -0400
@@ -289,6 +289,15 @@ struct ib_global_route {
 	u8		traffic_class;
 };
 
+struct ib_grh {
+	u32		version_tclass_flow;
+	u16		paylen;
+	u8		next_hdr;
+	u8		hop_limit;
+	union ib_gid	sgid;
+	union ib_gid	dgid;
+};
+
 enum {
 	IB_MULTICAST_QPN = 0xffffff
 };
@@ -991,6 +1000,21 @@ int ib_dealloc_pd(struct ib_pd *pd);
 struct ib_ah *ib_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr);
 
 /**
+ * ib_create_ah_from_wc - Creates an address handle associated with the
+ *   sender of the specified work completion.
+ * @pd: The protection domain associated with the address handle.
+ * @wc: Work completion information associated with a received message.
+ * @grh: References the received global route header.  This parameter is
+ *   ignored unless the work completion indicates that the GRH is valid.
+ * @port_num: The outbound port number to associate with the address.
+ *
+ * The address handle is used to reference a local or global destination
+ * in all UD QP post sends.
+ */
+struct ib_ah *ib_create_ah_from_wc(struct ib_pd *pd, struct ib_wc *wc,
+				   struct ib_grh *grh, u8 port_num);
+
+/**
  * ib_modify_ah - Modifies the address vector associated with an address
  *   handle.
  * @ah: The address handle to modify.


