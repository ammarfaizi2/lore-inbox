Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVCCXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVCCXzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVCCXxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:53:24 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262734AbVCCXWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:16 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][11/26] IB/mthca: mem-free EQ initialization
In-Reply-To: <2005331520.6xlwh79w94Kl0EpH@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.nW52EhJhFo4sAhLI@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0660 (UTC) FILETIME=[95B8A4C0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to initialize EQ context properly in both Tavor and mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:56.154732247 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_eq.c	2005-03-03 14:12:57.462448386 -0800
@@ -54,10 +54,10 @@
 	u32 flags;
 	u64 start;
 	u32 logsize_usrpage;
-	u32 pd;
+	u32 tavor_pd;		/* reserved for Arbel */
 	u8  reserved1[3];
 	u8  intr;
-	u32 lost_count;
+	u32 arbel_pd;		/* lost_count for Tavor */
 	u32 lkey;
 	u32 reserved2[2];
 	u32 consumer_index;
@@ -75,6 +75,7 @@
 #define MTHCA_EQ_STATE_ARMED        ( 1 <<  8)
 #define MTHCA_EQ_STATE_FIRED        ( 2 <<  8)
 #define MTHCA_EQ_STATE_ALWAYS_ARMED ( 3 <<  8)
+#define MTHCA_EQ_STATE_ARBEL        ( 8 <<  8)
 
 enum {
 	MTHCA_EVENT_TYPE_COMP       	    = 0x00,
@@ -467,10 +468,16 @@
 						  MTHCA_EQ_OWNER_HW    |
 						  MTHCA_EQ_STATE_ARMED |
 						  MTHCA_EQ_FLAG_TR);
-	eq_context->start           = cpu_to_be64(0);
-	eq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24 |
-						  dev->driver_uar.index);
-	eq_context->pd              = cpu_to_be32(dev->driver_pd.pd_num);
+	if (dev->hca_type == ARBEL_NATIVE)
+		eq_context->flags  |= cpu_to_be32(MTHCA_EQ_STATE_ARBEL);
+
+	eq_context->logsize_usrpage = cpu_to_be32((ffs(nent) - 1) << 24);
+	if (dev->hca_type == ARBEL_NATIVE) {
+		eq_context->arbel_pd = cpu_to_be32(dev->driver_pd.pd_num);
+	} else {
+		eq_context->logsize_usrpage |= cpu_to_be32(dev->driver_uar.index);
+		eq_context->tavor_pd         = cpu_to_be32(dev->driver_pd.pd_num);
+	}
 	eq_context->intr            = intr;
 	eq_context->lkey            = cpu_to_be32(eq->mr.ibmr.lkey);
 

