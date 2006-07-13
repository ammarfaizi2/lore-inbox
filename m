Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWGMPyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWGMPyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGMPyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:54:49 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:12241 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S932168AbWGMPys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:54:48 -0400
Date: Thu, 13 Jul 2006 18:55:30 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Sean Hefty <sean.hefty@intel.com>
Cc: Roland Dreier <rdreier@cisco.com>, Zach Brown <zach.brown@oracle.com>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] IB/core: use correct gfp_mask in sa_query
Message-ID: <20060713155530.GC22648@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060712093820.GA9218@elte.hu> <20060712110955.GB18466@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712110955.GB18466@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Jul 2006 16:00:05.0328 (UTC) FILETIME=[68167D00:01C6A695]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you please drop the following in -mm and on to Linus?

--

Avoid bogus out of memory errors: fix sa_query to actually pass gfp_mask
supplied by the user to idr_pre_get.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Acked-by: "Sean Hefty" <mshefty@ichips.intel.com>
Acked-by: "Roland Dreier" <rdreier@cisco.com>

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index e911c99..aeda484 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -488,13 +488,13 @@ static void init_mad(struct ib_sa_mad *m
 	spin_unlock_irqrestore(&tid_lock, flags);
 }
 
-static int send_mad(struct ib_sa_query *query, int timeout_ms)
+static int send_mad(struct ib_sa_query *query, int timeout_ms, gfp_t gfp_mask)
 {
 	unsigned long flags;
 	int ret, id;
 
 retry:
-	if (!idr_pre_get(&query_idr, GFP_ATOMIC))
+	if (!idr_pre_get(&query_idr, gfp_mask))
 		return -ENOMEM;
 	spin_lock_irqsave(&idr_lock, flags);
 	ret = idr_get_new(&query_idr, query, &id);
@@ -630,7 +630,7 @@ int ib_sa_path_rec_get(struct ib_device 
 
 	*sa_query = &query->sa_query;
 
-	ret = send_mad(&query->sa_query, timeout_ms);
+	ret = send_mad(&query->sa_query, timeout_ms, gfp_mask);
 	if (ret < 0)
 		goto err2;
 
@@ -752,7 +752,7 @@ int ib_sa_service_rec_query(struct ib_de
 
 	*sa_query = &query->sa_query;
 
-	ret = send_mad(&query->sa_query, timeout_ms);
+	ret = send_mad(&query->sa_query, timeout_ms, gfp_mask);
 	if (ret < 0)
 		goto err2;
 
@@ -844,7 +844,7 @@ int ib_sa_mcmember_rec_query(struct ib_d
 
 	*sa_query = &query->sa_query;
 
-	ret = send_mad(&query->sa_query, timeout_ms);
+	ret = send_mad(&query->sa_query, timeout_ms, gfp_mask);
 	if (ret < 0)
 		goto err2;
 
-- 
MST
