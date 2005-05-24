Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVEXWVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVEXWVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVEXWVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:21:15 -0400
Received: from webmail.topspin.com ([12.162.17.3]:21691 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261248AbVEXWU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:20:58 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 0/2] IB: allow NULL sa_query callbacks
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Tue, 24 May 2005 15:20:57 -0700
Message-Id: <20055241520.Hsf2RosQGYxIWuXH@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 May 2005 22:20:57.0979 (UTC) FILETIME=[DBE60CB0:01C560AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check if a client passes a NULL callback into an SA query, and if so,
never call back.  This fixes an oops if someone unloads ib_ipoib and
ib_sa in rapid succession.  ib_ipoib does an MCMember delete with a
NULL callback and 0 timeout on unload, which is usually fine since the
delete completes successfully.  However, if ib_sa is unloaded
immediately afterwards, the delete will be canceled and ib_sa will try
to call the (now already unloaded) ib_ipoib module back with the
cancel completion, which triggers the oops.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 drivers/infiniband/core/sa_query.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)



--- linux-git.orig/drivers/infiniband/core/sa_query.c	2005-05-24 15:17:29.409716468 -0700
+++ linux-git/drivers/infiniband/core/sa_query.c	2005-05-24 15:17:39.225578334 -0700
@@ -587,7 +587,7 @@
 
 	init_mad(query->sa_query.mad, agent);
 
-	query->sa_query.callback              = ib_sa_path_rec_callback;
+	query->sa_query.callback              = callback ? ib_sa_path_rec_callback : NULL;
 	query->sa_query.release               = ib_sa_path_rec_release;
 	query->sa_query.port                  = port;
 	query->sa_query.mad->mad_hdr.method   = IB_MGMT_METHOD_GET;
@@ -663,7 +663,7 @@
 
 	init_mad(query->sa_query.mad, agent);
 
-	query->sa_query.callback              = ib_sa_mcmember_rec_callback;
+	query->sa_query.callback              = callback ? ib_sa_mcmember_rec_callback : NULL;
 	query->sa_query.release               = ib_sa_mcmember_rec_release;
 	query->sa_query.port                  = port;
 	query->sa_query.mad->mad_hdr.method   = method;
@@ -698,20 +698,21 @@
 	if (!query)
 		return;
 
-	switch (mad_send_wc->status) {
-	case IB_WC_SUCCESS:
-		/* No callback -- already got recv */
-		break;
-	case IB_WC_RESP_TIMEOUT_ERR:
-		query->callback(query, -ETIMEDOUT, NULL);
-		break;
-	case IB_WC_WR_FLUSH_ERR:
-		query->callback(query, -EINTR, NULL);
-		break;
-	default:
-		query->callback(query, -EIO, NULL);
-		break;
-	}
+	if (query->callback)
+		switch (mad_send_wc->status) {
+		case IB_WC_SUCCESS:
+			/* No callback -- already got recv */
+			break;
+		case IB_WC_RESP_TIMEOUT_ERR:
+			query->callback(query, -ETIMEDOUT, NULL);
+			break;
+		case IB_WC_WR_FLUSH_ERR:
+			query->callback(query, -EINTR, NULL);
+			break;
+		default:
+			query->callback(query, -EIO, NULL);
+			break;
+		}
 
 	dma_unmap_single(agent->device->dma_device,
 			 pci_unmap_addr(query, mapping),
@@ -736,7 +737,7 @@
 	query = idr_find(&query_idr, mad_recv_wc->wc->wr_id);
 	spin_unlock_irqrestore(&idr_lock, flags);
 
-	if (query) {
+	if (query && query->callback) {
 		if (mad_recv_wc->wc->status == IB_WC_SUCCESS)
 			query->callback(query,
 					mad_recv_wc->recv_buf.mad->mad_hdr.status ?

