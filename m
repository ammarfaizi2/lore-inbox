Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbVDAVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVDAVFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVDAVBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:01:49 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262912AbVDAUvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:22 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][21/27] IB/mthca: split MR key munging routines
In-Reply-To: <2005411249.Tkvt1lzz8zEHUMmz@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.VplL6XJIvCp9HHyP@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0981 (UTC) FILETIME=[5B355ED0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Split Tavor and Arbel/mem-free index<->hw key munging routines, so that FMR implementation 
can call correct implementation without testing HCA type (which it already knows).

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:27.075083423 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:28.676735749 -0800
@@ -198,20 +198,40 @@
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

