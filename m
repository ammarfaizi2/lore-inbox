Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWI1QLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWI1QLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWI1QLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:11:15 -0400
Received: from mx.pathscale.com ([64.160.42.68]:60341 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751635AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 28] IB/ipath - clean up handling of GUID 0
X-Mercurial-Node: 0fe847c544586f6f74d07b082dc798fcd0264afd
Message-Id: <0fe847c544586f6f74d0.1159459202@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:02 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Respond with an error to the SM if our GUID is 0, and don't allow the
user to set our GUID to 0.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r e2916bbf09ed -r 0fe847c54458 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Sep 28 08:57:12 2006 -0700
@@ -87,7 +87,8 @@ static int recv_subn_get_nodeinfo(struct
 	struct ipath_devdata *dd = to_idev(ibdev)->dd;
 	u32 vendor, majrev, minrev;
 
-	if (smp->attr_mod)
+	/* GUID 0 is illegal */
+	if (smp->attr_mod || (dd->ipath_guid == 0))
 		smp->status |= IB_SMP_INVALID_FIELD;
 
 	nip->base_version = 1;
@@ -131,10 +132,15 @@ static int recv_subn_get_guidinfo(struct
 	 * We only support one GUID for now.  If this changes, the
 	 * portinfo.guid_cap field needs to be updated too.
 	 */
-	if (startgx == 0)
-		/* The first is a copy of the read-only HW GUID. */
-		*p = to_idev(ibdev)->dd->ipath_guid;
-	else
+	if (startgx == 0) {
+		__be64 g = to_idev(ibdev)->dd->ipath_guid;
+		if (g == 0)
+			/* GUID 0 is illegal */
+			smp->status |= IB_SMP_INVALID_FIELD;
+		else
+			/* The first is a copy of the read-only HW GUID. */
+			*p = g;
+	} else
 		smp->status |= IB_SMP_INVALID_FIELD;
 
 	return reply(smp);
diff -r e2916bbf09ed -r 0fe847c54458 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Sep 28 08:57:12 2006 -0700
@@ -257,7 +257,7 @@ static ssize_t store_guid(struct device 
 	struct ipath_devdata *dd = dev_get_drvdata(dev);
 	ssize_t ret;
 	unsigned short guid[8];
-	__be64 nguid;
+	__be64 new_guid;
 	u8 *ng;
 	int i;
 
@@ -266,7 +266,7 @@ static ssize_t store_guid(struct device 
 		   &guid[4], &guid[5], &guid[6], &guid[7]) != 8)
 		goto invalid;
 
-	ng = (u8 *) &nguid;
+	ng = (u8 *) &new_guid;
 
 	for (i = 0; i < 8; i++) {
 		if (guid[i] > 0xff)
@@ -274,7 +274,10 @@ static ssize_t store_guid(struct device 
 		ng[i] = guid[i];
 	}
 
-	dd->ipath_guid = nguid;
+	if (new_guid == 0)
+		goto invalid;
+
+	dd->ipath_guid = new_guid;
 	dd->ipath_nguid = 1;
 
 	ret = strlen(buf);
