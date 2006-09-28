Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWI1QG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWI1QG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWI1QC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:29 -0400
Received: from mx.pathscale.com ([64.160.42.68]:5814 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751932AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 28 of 28] IB/ipath - fix lockdep error upon "ifconfig ibN down"
X-Mercurial-Node: c61b17b5602f2690dc3afecfdc0a17331c8a72ea
Message-Id: <c61b17b5602f2690dc3a.1159459224@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:24 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 944d7e53a049 -r c61b17b5602f drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Sep 28 08:57:13 2006 -0700
@@ -1202,6 +1202,7 @@ static struct ib_ah *ipath_create_ah(str
 	struct ipath_ah *ah;
 	struct ib_ah *ret;
 	struct ipath_ibdev *dev = to_idev(pd->device);
+	unsigned long flags;
 
 	/* A multicast address requires a GRH (see ch. 8.4.1). */
 	if (ah_attr->dlid >= IPATH_MULTICAST_LID_BASE &&
@@ -1228,16 +1229,16 @@ static struct ib_ah *ipath_create_ah(str
 		goto bail;
 	}
 
-	spin_lock(&dev->n_ahs_lock);
+	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	if (dev->n_ahs_allocated == ib_ipath_max_ahs) {
-		spin_unlock(&dev->n_ahs_lock);
+		spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 		kfree(ah);
 		ret = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
 
 	dev->n_ahs_allocated++;
-	spin_unlock(&dev->n_ahs_lock);
+	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 
 	/* ib_create_ah() will initialize ah->ibah. */
 	ah->attr = *ah_attr;
@@ -1258,10 +1259,11 @@ static int ipath_destroy_ah(struct ib_ah
 {
 	struct ipath_ibdev *dev = to_idev(ibah->device);
 	struct ipath_ah *ah = to_iah(ibah);
-
-	spin_lock(&dev->n_ahs_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	dev->n_ahs_allocated--;
-	spin_unlock(&dev->n_ahs_lock);
+	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 
 	kfree(ah);
 
