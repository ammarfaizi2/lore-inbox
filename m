Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWGLLJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWGLLJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWGLLJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:09:17 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:63458 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S1750929AbWGLLJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:09:16 -0400
Date: Wed, 12 Jul 2006 14:09:55 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Ingo Molnar <mingo@elte.hu>, Sean Hefty <sean.hefty@intel.com>
Cc: Roland Dreier <rdreier@cisco.com>, Zach Brown <zach.brown@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: ipoib lockdep warning
Message-ID: <20060712110955.GB18466@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060712093820.GA9218@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712093820.GA9218@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Jul 2006 11:14:31.0578 (UTC) FILETIME=[5929F7A0:01C6A5A4]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Ingo Molnar <mingo@elte.hu>:
> But i also think that you should avoid using GFP_ATOMIC for any sort of 
> reliable IO path and push as much work into process context as possible. 
> Is it acceptable for your infiniband IO model to fail with -ENOMEM if 
> GFP_ATOMIC happens to fail, and is the IO retried transparently?

Yes, this is true for users that pass GFP_ATOMIC to sa_query, at least.  But
might not be so for other users:  send_mad in sa_query actually gets gfp_flags
parameter, but for some reason it does not pass it to idr_pre_get, which means
even sa query done with GFP_KERNEL flag is likely to fail.

Sean, it seems we need something like the following - what do you think?

--

Avoid bogus out out memory errors: fix sa_query to actually pass gfp_mask
supplied by the user to idr_pre_get.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

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
