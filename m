Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWAJTb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWAJTb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWAJTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:30 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:27490 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932364AbWAJTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:28 -0500
Subject: [git patch review 4/7] IB/mthca: Factor common MAD initialization code
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483290-850b093ba9fe8fda@cisco.com>
In-Reply-To: <1136921483290-3d1a8ae2f0b61cbf@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:24.0932 (UTC) FILETIME=[71B68440:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out common code for initializing MAD packets, which is shared
by many query routines in mthca_provider.c, into init_query_mad().

add/remove: 1/0 grow/shrink: 0/4 up/down: 16/-44 (-28)
function                                     old     new   delta
init_query_mad                                 -      16     +16
mthca_query_port                             521     518      -3
mthca_query_pkey                             301     294      -7
mthca_query_device                           648     641      -7
mthca_query_gid                              453     426     -27

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   52 +++++++++++---------------
 1 files changed, 22 insertions(+), 30 deletions(-)

87635b71b544563f29050a9cecaa12b5d2a3e34a
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 0ae27fa..4887577 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -45,6 +45,14 @@
 #include "mthca_user.h"
 #include "mthca_memfree.h"
 
+static void init_query_mad(struct ib_smp *mad)
+{
+	mad->base_version  = 1;
+	mad->mgmt_class    = IB_MGMT_CLASS_SUBN_LID_ROUTED;
+	mad->class_version = 1;
+	mad->method    	   = IB_MGMT_METHOD_GET;
+}
+
 static int mthca_query_device(struct ib_device *ibdev,
 			      struct ib_device_attr *props)
 {
@@ -64,11 +72,8 @@ static int mthca_query_device(struct ib_
 
 	props->fw_ver              = mdev->fw_ver;
 
-	in_mad->base_version       = 1;
-	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	in_mad->class_version  	   = 1;
-	in_mad->method         	   = IB_MGMT_METHOD_GET;
-	in_mad->attr_id   	   = IB_SMP_ATTR_NODE_INFO;
+	init_query_mad(in_mad);
+	in_mad->attr_id = IB_SMP_ATTR_NODE_INFO;
 
 	err = mthca_MAD_IFC(mdev, 1, 1,
 			    1, NULL, NULL, in_mad, out_mad,
@@ -134,12 +139,9 @@ static int mthca_query_port(struct ib_de
 
 	memset(props, 0, sizeof *props);
 
-	in_mad->base_version       = 1;
-	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	in_mad->class_version  	   = 1;
-	in_mad->method         	   = IB_MGMT_METHOD_GET;
-	in_mad->attr_id   	   = IB_SMP_ATTR_PORT_INFO;
-	in_mad->attr_mod           = cpu_to_be32(port);
+	init_query_mad(in_mad);
+	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
+	in_mad->attr_mod = cpu_to_be32(port);
 
 	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
 			    port, NULL, NULL, in_mad, out_mad,
@@ -223,12 +225,9 @@ static int mthca_query_pkey(struct ib_de
 	if (!in_mad || !out_mad)
 		goto out;
 
-	in_mad->base_version       = 1;
-	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	in_mad->class_version  	   = 1;
-	in_mad->method         	   = IB_MGMT_METHOD_GET;
-	in_mad->attr_id   	   = IB_SMP_ATTR_PKEY_TABLE;
-	in_mad->attr_mod           = cpu_to_be32(index / 32);
+	init_query_mad(in_mad);
+	in_mad->attr_id  = IB_SMP_ATTR_PKEY_TABLE;
+	in_mad->attr_mod = cpu_to_be32(index / 32);
 
 	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
 			    port, NULL, NULL, in_mad, out_mad,
@@ -261,12 +260,9 @@ static int mthca_query_gid(struct ib_dev
 	if (!in_mad || !out_mad)
 		goto out;
 
-	in_mad->base_version       = 1;
-	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	in_mad->class_version  	   = 1;
-	in_mad->method         	   = IB_MGMT_METHOD_GET;
-	in_mad->attr_id   	   = IB_SMP_ATTR_PORT_INFO;
-	in_mad->attr_mod           = cpu_to_be32(port);
+	init_query_mad(in_mad);
+	in_mad->attr_id  = IB_SMP_ATTR_PORT_INFO;
+	in_mad->attr_mod = cpu_to_be32(port);
 
 	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
 			    port, NULL, NULL, in_mad, out_mad,
@@ -280,13 +276,9 @@ static int mthca_query_gid(struct ib_dev
 
 	memcpy(gid->raw, out_mad->data + 8, 8);
 
-	memset(in_mad, 0, sizeof *in_mad);
-	in_mad->base_version       = 1;
-	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
-	in_mad->class_version  	   = 1;
-	in_mad->method         	   = IB_MGMT_METHOD_GET;
-	in_mad->attr_id   	   = IB_SMP_ATTR_GUID_INFO;
-	in_mad->attr_mod           = cpu_to_be32(index / 8);
+	init_query_mad(in_mad);
+	in_mad->attr_id  = IB_SMP_ATTR_GUID_INFO;
+	in_mad->attr_mod = cpu_to_be32(index / 8);
 
 	err = mthca_MAD_IFC(to_mdev(ibdev), 1, 1,
 			    port, NULL, NULL, in_mad, out_mad,
-- 
1.0.7
