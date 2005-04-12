Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVDLOQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVDLOQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVDLLIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:08:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:27594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262253AbVDLKdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:14 -0400
Message-Id: <200504121033.j3CAX5cJ005773@shell0.pdx.osdl.net>
Subject: [patch 154/198] IPoIB: fix static rate calculation
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Correct and simplify calculation of static rate.  We need to round up the
quotient of (local_rate - path_rate) / path_rate.  To round up we add
(path_rate - 1) to the numerator, so the quotient simplifies to (local_rate -
1) / path_rate.

No idea how I came up with the old formula.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_main.c      |    7 +++----
 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff -puN drivers/infiniband/ulp/ipoib/ipoib_main.c~ipoib-fix-static-rate-calculation drivers/infiniband/ulp/ipoib/ipoib_main.c
--- 25/drivers/infiniband/ulp/ipoib/ipoib_main.c~ipoib-fix-static-rate-calculation	2005-04-12 03:21:40.451987264 -0700
+++ 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-04-12 03:21:40.456986504 -0700
@@ -302,11 +302,10 @@ static void path_rec_completion(int stat
 			.sl 	       = pathrec->sl,
 			.port_num      = priv->port
 		};
+		int path_rate = ib_sa_rate_enum_to_int(pathrec->rate);
 
-		if (ib_sa_rate_enum_to_int(pathrec->rate) > 0)
-			av.static_rate = (2 * priv->local_rate -
-					  ib_sa_rate_enum_to_int(pathrec->rate) - 1) /
-				(priv->local_rate ? priv->local_rate : 1);
+		if (path_rate > 0 && priv->local_rate > path_rate)
+			av.static_rate = (priv->local_rate - 1) / path_rate;
 
 		ipoib_dbg(priv, "static_rate %d for local port %dX, path %dX\n",
 			  av.static_rate, priv->local_rate,
diff -puN drivers/infiniband/ulp/ipoib/ipoib_multicast.c~ipoib-fix-static-rate-calculation drivers/infiniband/ulp/ipoib/ipoib_multicast.c
--- 25/drivers/infiniband/ulp/ipoib/ipoib_multicast.c~ipoib-fix-static-rate-calculation	2005-04-12 03:21:40.453986960 -0700
+++ 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-04-12 03:21:40.457986352 -0700
@@ -258,13 +258,12 @@ static int ipoib_mcast_join_finish(struc
 				.traffic_class = mcast->mcmember.traffic_class
 			}
 		};
+		int path_rate = ib_sa_rate_enum_to_int(mcast->mcmember.rate);
 
 		av.grh.dgid = mcast->mcmember.mgid;
 
-		if (ib_sa_rate_enum_to_int(mcast->mcmember.rate) > 0)
-			av.static_rate = (2 * priv->local_rate -
-					  ib_sa_rate_enum_to_int(mcast->mcmember.rate) - 1) /
-				(priv->local_rate ? priv->local_rate : 1);
+		if (path_rate > 0 && priv->local_rate > path_rate)
+			av.static_rate = (priv->local_rate - 1) / path_rate;
 
 		ipoib_dbg_mcast(priv, "static_rate %d for local port %dX, mcmember %dX\n",
 				av.static_rate, priv->local_rate,
_
