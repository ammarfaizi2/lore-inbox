Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVDLKry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVDLKry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVDLKol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:44:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:57290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVDLKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:47 -0400
Message-Id: <200504121033.j3CAXTvp005895@shell0.pdx.osdl.net>
Subject: [patch 183/198] IB/mthca: split MR key munging routines
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Split Tavor and Arbel/mem-free index<->hw key munging routines, so that FMR
implementation can call correct implementation without testing HCA type (which
it already knows).

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c |   28 +++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-split-mr-key-munging-routines drivers/infiniband/hw/mthca/mthca_mr.c
--- 25/drivers/infiniband/hw/mthca/mthca_mr.c~ib-mthca-split-mr-key-munging-routines	2005-04-12 03:21:46.923003520 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-12 03:21:46.927002912 -0700
@@ -198,20 +198,40 @@ static void mthca_free_mtt(struct mthca_
 				      seg + (1 << order) - 1);
 }
 
+static inline u32 tavor_hw_index_to_key(u32 ind)
+{
+	return ind;
+}
+
+static inline u32 tavor_key_to_hw_index(u32 key)
+{
+	return key;
+}
+
+static inline u32 arbel_hw_index_to_key(u32 ind)
+{
+	return (ind >> 24) | (ind << 8);
+}
+
+static inline u32 arbel_key_to_hw_index(u32 key)
+{
+	return (key << 24) | (key >> 8);
+}
+
 static inline u32 hw_index_to_key(struct mthca_dev *dev, u32 ind)
 {
 	if (dev->hca_type == ARBEL_NATIVE)
-		return (ind >> 24) | (ind << 8);
+		return arbel_hw_index_to_key(ind);
 	else
-		return ind;
+		return tavor_hw_index_to_key(ind);
 }
 
 static inline u32 key_to_hw_index(struct mthca_dev *dev, u32 key)
 {
 	if (dev->hca_type == ARBEL_NATIVE)
-		return (key << 24) | (key >> 8);
+		return arbel_key_to_hw_index(key);
 	else
-		return key;
+		return tavor_key_to_hw_index(key);
 }
 
 int mthca_mr_alloc_notrans(struct mthca_dev *dev, u32 pd,
_
