Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263247AbVFXVzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbVFXVzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbVFXVzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:55:14 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:58654 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S263247AbVFXVyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:54:46 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 1/3] IB: Fix race in sa_query
X-Mailer: Roland's Patchbomber
Date: Fri, 24 Jun 2005 14:54:42 -0700
Message-Id: <20056241454.JSnV6qzt9RST2IRw@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a copy of the id we'll return to the consumer so that we don't
dereference query->sa_query after calling send_mad().  A completion
may occur very quickly and end up freeing the query before we get to
do anything after send_mad().

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/sa_query.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)



--- linux-export2.orig/drivers/infiniband/core/sa_query.c	2005-06-23 13:16:25.000000000 -0700
+++ linux-export2/drivers/infiniband/core/sa_query.c	2005-06-24 14:49:43.592455970 -0700
@@ -507,7 +507,13 @@
 		spin_unlock_irqrestore(&idr_lock, flags);
 	}
 
-	return ret;
+	/*
+	 * It's not safe to dereference query any more, because the
+	 * send may already have completed and freed the query in
+	 * another context.  So use wr.wr_id, which has a copy of the
+	 * query's id.
+	 */
+	return ret ? ret : wr.wr_id;
 }
 
 static void ib_sa_path_rec_callback(struct ib_sa_query *sa_query,
@@ -598,14 +604,15 @@
 		rec, query->sa_query.mad->data);
 
 	*sa_query = &query->sa_query;
+
 	ret = send_mad(&query->sa_query, timeout_ms);
-	if (ret) {
+	if (ret < 0) {
 		*sa_query = NULL;
 		kfree(query->sa_query.mad);
 		kfree(query);
 	}
 
-	return ret ? ret : query->sa_query.id;
+	return ret;
 }
 EXPORT_SYMBOL(ib_sa_path_rec_get);
 
@@ -674,14 +681,15 @@
 		rec, query->sa_query.mad->data);
 
 	*sa_query = &query->sa_query;
+
 	ret = send_mad(&query->sa_query, timeout_ms);
-	if (ret) {
+	if (ret < 0) {
 		*sa_query = NULL;
 		kfree(query->sa_query.mad);
 		kfree(query);
 	}
 
-	return ret ? ret : query->sa_query.id;
+	return ret;
 }
 EXPORT_SYMBOL(ib_sa_mcmember_rec_query);
 
