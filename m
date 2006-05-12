Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWELXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWELXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWELXoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:170 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932296AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 51 of 53] ipath - fix reporting of vendor ID and a few other
	trivial bits
X-Mercurial-Node: 5f665c503f0d2c2a9a0e3ab2f59ce4191f4245f3
Message-Id: <5f665c503f0d2c2a9a0e.1147477416@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:36 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r bd1de2e983db -r 5f665c503f0d drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Fri May 12 16:41:45 2006 -0700
@@ -339,18 +339,26 @@ u32 ipath_layer_get_nguid(struct ipath_d
 
 EXPORT_SYMBOL_GPL(ipath_layer_get_nguid);
 
-int ipath_layer_query_device(struct ipath_devdata *dd, u32 * vendor,
-			     u32 * boardrev, u32 * majrev, u32 * minrev)
-{
-	*vendor = dd->ipath_vendorid;
-	*boardrev = dd->ipath_boardrev;
-	*majrev = dd->ipath_majrev;
-	*minrev = dd->ipath_minrev;
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ipath_layer_query_device);
+u32 ipath_layer_get_majrev(struct ipath_devdata *dd)
+{
+	return dd->ipath_majrev;
+}
+
+EXPORT_SYMBOL_GPL(ipath_layer_get_majrev);
+
+u32 ipath_layer_get_minrev(struct ipath_devdata *dd)
+{
+	return dd->ipath_minrev;
+}
+
+EXPORT_SYMBOL_GPL(ipath_layer_get_minrev);
+
+u32 ipath_layer_get_pcirev(struct ipath_devdata *dd)
+{
+	return dd->ipath_pcirev;
+}
+
+EXPORT_SYMBOL_GPL(ipath_layer_get_pcirev);
 
 u32 ipath_layer_get_flags(struct ipath_devdata *dd)
 {
@@ -372,6 +380,13 @@ u16 ipath_layer_get_deviceid(struct ipat
 }
 
 EXPORT_SYMBOL_GPL(ipath_layer_get_deviceid);
+
+u32 ipath_layer_get_vendorid(struct ipath_devdata *dd)
+{
+	return dd->ipath_vendorid;
+}
+
+EXPORT_SYMBOL_GPL(ipath_layer_get_vendorid);
 
 u64 ipath_layer_get_lastibcstat(struct ipath_devdata *dd)
 {
diff -r bd1de2e983db -r 5f665c503f0d drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Fri May 12 16:41:45 2006 -0700
@@ -145,11 +145,13 @@ int ipath_layer_set_guid(struct ipath_de
 int ipath_layer_set_guid(struct ipath_devdata *, __be64 guid);
 __be64 ipath_layer_get_guid(struct ipath_devdata *);
 u32 ipath_layer_get_nguid(struct ipath_devdata *);
-int ipath_layer_query_device(struct ipath_devdata *, u32 * vendor,
-			     u32 * boardrev, u32 * majrev, u32 * minrev);
+u32 ipath_layer_get_majrev(struct ipath_devdata *);
+u32 ipath_layer_get_minrev(struct ipath_devdata *);
+u32 ipath_layer_get_pcirev(struct ipath_devdata *);
 u32 ipath_layer_get_flags(struct ipath_devdata *dd);
 struct device *ipath_layer_get_device(struct ipath_devdata *dd);
 u16 ipath_layer_get_deviceid(struct ipath_devdata *dd);
+u32 ipath_layer_get_vendorid(struct ipath_devdata *);
 u64 ipath_layer_get_lastibcstat(struct ipath_devdata *dd);
 u32 ipath_layer_get_ibmtu(struct ipath_devdata *dd);
 int ipath_layer_enable_timer(struct ipath_devdata *dd);
diff -r bd1de2e983db -r 5f665c503f0d drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Fri May 12 16:41:45 2006 -0700
@@ -84,7 +84,7 @@ static int recv_subn_get_nodeinfo(struct
 {
 	struct nodeinfo *nip = (struct nodeinfo *)&smp->data;
 	struct ipath_devdata *dd = to_idev(ibdev)->dd;
-	u32 vendor, boardid, majrev, minrev;
+	u32 vendor, majrev, minrev;
 
 	if (smp->attr_mod)
 		smp->status |= IB_SMP_INVALID_FIELD;
@@ -104,9 +104,11 @@ static int recv_subn_get_nodeinfo(struct
 	nip->port_guid = nip->sys_guid;
 	nip->partition_cap = cpu_to_be16(ipath_layer_get_npkeys(dd));
 	nip->device_id = cpu_to_be16(ipath_layer_get_deviceid(dd));
-	ipath_layer_query_device(dd, &vendor, &boardid, &majrev, &minrev);
+	majrev = ipath_layer_get_majrev(dd);
+	minrev = ipath_layer_get_minrev(dd);
 	nip->revision = cpu_to_be32((majrev << 16) | minrev);
 	nip->local_port_num = port;
+	vendor = ipath_layer_get_vendorid(dd);
 	nip->vendor_id[0] = 0;
 	nip->vendor_id[1] = vendor >> 8;
 	nip->vendor_id[2] = vendor;
diff -r bd1de2e983db -r 5f665c503f0d drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 16:41:45 2006 -0700
@@ -620,18 +620,15 @@ static int ipath_query_device(struct ib_
 			      struct ib_device_attr *props)
 {
 	struct ipath_ibdev *dev = to_idev(ibdev);
-	u32 vendor, boardrev, majrev, minrev;
 
 	memset(props, 0, sizeof(*props));
 
 	props->device_cap_flags = IB_DEVICE_BAD_PKEY_CNTR |
 		IB_DEVICE_BAD_QKEY_CNTR | IB_DEVICE_SHUTDOWN_PORT |
 		IB_DEVICE_SYS_IMAGE_GUID;
-	ipath_layer_query_device(dev->dd, &vendor, &boardrev,
-				 &majrev, &minrev);
-	props->vendor_id = vendor;
-	props->vendor_part_id = boardrev;
-	props->hw_ver = boardrev << 16 | majrev << 8 | minrev;
+	props->vendor_id = ipath_layer_get_vendorid(dev->dd);
+	props->vendor_part_id = ipath_layer_get_deviceid(dev->dd);
+	props->hw_ver = ipath_layer_get_pcirev(dev->dd);
 
 	props->sys_image_guid = dev->sys_image_guid;
 
@@ -1220,11 +1217,8 @@ static ssize_t show_rev(struct class_dev
 {
 	struct ipath_ibdev *dev =
 		container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
-	int vendor, boardrev, majrev, minrev;
-
-	ipath_layer_query_device(dev->dd, &vendor, &boardrev,
-				 &majrev, &minrev);
-	return sprintf(buf, "%d.%d\n", majrev, minrev);
+
+	return sprintf(buf, "%x\n", ipath_layer_get_pcirev(dev->dd));
 }
 
 static ssize_t show_hca(struct class_device *cdev, char *buf)
@@ -1253,7 +1247,7 @@ static ssize_t show_stats(struct class_d
 	len = sprintf(buf,
 		      "RC resends  %d\n"
 		      "RC no QACK  %d\n"
-		      "RC ACKs     %d\n"
+		      "RC ACKs	   %d\n"
 		      "RC SEQ NAKs %d\n"
 		      "RC RDMA seq %d\n"
 		      "RC RNR NAKs %d\n"
@@ -1263,7 +1257,7 @@ static ssize_t show_stats(struct class_d
 		      "piobuf wait %d\n"
 		      "no piobuf   %d\n"
 		      "PKT drops   %d\n"
-		      "WQE errs    %d\n",
+		      "WQE errs	   %d\n",
 		      dev->n_rc_resends, dev->n_rc_qacks, dev->n_rc_acks,
 		      dev->n_seq_naks, dev->n_rdma_seq, dev->n_rnr_naks,
 		      dev->n_other_naks, dev->n_timeouts,
