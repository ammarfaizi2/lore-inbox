Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVDAD7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVDAD7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVDAD7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:59:01 -0500
Received: from webmail.topspin.com ([12.162.17.3]:202 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262597AbVDAD6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:58:54 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][2/3] IPoIB: fix static rate calculation
In-Reply-To: <20053311936.983q6QLaPvAkIcQj@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 31 Mar 2005 19:36:12 -0800
Message-Id: <20053311936.qOWRURSZd0itPjAn@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 03:36:12.0264 (UTC) FILETIME=[F3626680:01C5366B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct and simplify calculation of static rate.  We need to round up
the quotient of (local_rate - path_rate) / path_rate.  To round up we
add (path_rate - 1) to the numerator, so the quotient simplifies to
(local_rate - 1) / path_rate.

No idea how I came up with the old formula.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-31 19:06:47.984714505 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-31 19:26:39.094134171 -0800
@@ -302,11 +302,10 @@
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
--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-03-31 19:07:01.877698296 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-03-31 19:26:03.861782487 -0800
@@ -258,13 +258,12 @@
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

