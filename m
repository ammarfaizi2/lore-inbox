Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVK1X4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVK1X4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVK1X4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:56:48 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:61875 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932289AbVK1X4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:56:47 -0500
Subject: [git patch review 2/2] IB/umad: fix RMPP handling
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 28 Nov 2005 23:56:40 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133222200079-c74b250d96363b53@cisco.com>
In-Reply-To: <1133222200079-44d9989c7d031b8b@cisco.com>
X-OriginalArrivalTime: 28 Nov 2005 23:56:40.0533 (UTC) FILETIME=[60634050:01C5F477]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ib_umad_write in user_mad.c is looking at rmpp_hdr field in MAD before
checking that the MAD actually has the RMPP header.  So for a MAD
without RMPP header it looks like we are actually checking a bit
inside M_Key, or something.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |   41 +++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 19 deletions(-)

applies-to: 918111360e352d128126bb338227ec4fb6e8afbc
bf6d9e23a36c8a01bf6fbb945387d8ca3870ff71
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index e73f81c..eb7f525 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -310,7 +310,7 @@ static ssize_t ib_umad_write(struct file
 	u8 method;
 	__be64 *tid;
 	int ret, length, hdr_len, copy_offset;
-	int rmpp_active = 0;
+	int rmpp_active, has_rmpp_header;
 
 	if (count < sizeof (struct ib_user_mad) + IB_MGMT_RMPP_HDR)
 		return -EINVAL;
@@ -360,28 +360,31 @@ static ssize_t ib_umad_write(struct file
 	}
 
 	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
-	if (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE) {
-		/* RMPP active */
-		if (!agent->rmpp_version) {
-			ret = -EINVAL;
-			goto err_ah;
-		}
-
-		/* Validate that the management class can support RMPP */
-		if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
-			hdr_len = IB_MGMT_SA_HDR;
-		} else if ((rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
-			    (rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END)) {
-				hdr_len = IB_MGMT_VENDOR_HDR;
-		} else {
-			ret = -EINVAL;
-			goto err_ah;
-		}
-		rmpp_active = 1;
+	if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
+		hdr_len = IB_MGMT_SA_HDR;
 		copy_offset = IB_MGMT_RMPP_HDR;
+		has_rmpp_header = 1;
+	} else if (rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START &&
+		   rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END) {
+			hdr_len = IB_MGMT_VENDOR_HDR;
+			copy_offset = IB_MGMT_RMPP_HDR;
+			has_rmpp_header = 1;
 	} else {
 		hdr_len = IB_MGMT_MAD_HDR;
 		copy_offset = IB_MGMT_MAD_HDR;
+		has_rmpp_header = 0;
+	}
+
+	if (has_rmpp_header)
+		rmpp_active = ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+			      IB_MGMT_RMPP_FLAG_ACTIVE;
+	else
+		rmpp_active = 0;
+
+	/* Validate that the management class can support RMPP */
+	if (rmpp_active && !agent->rmpp_version) {
+		ret = -EINVAL;
+		goto err_ah;
 	}
 
 	packet->msg = ib_create_send_mad(agent,
---
0.99.9k
