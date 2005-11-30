Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVK3A7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVK3A7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVK3A6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:58:04 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750745AbVK3A5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:35 -0500
Subject: [git patch review 6/8] IPoIB: fix error handling in ipoib_open
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245799-51b50fe9f024aec5@cisco.com>
In-Reply-To: <1133312245797-01403858bd5f112a@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0924 (UTC) FILETIME=[08D0B340:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ipoib_ib_dev_up() fails after ipoib_ib_dev_open() is called, then
ipoib_ib_dev_stop() needs to be called to clean up.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

applies-to: bb4b6f10197addff1af91368f916904eb4404edf
267ee88ed34c76dc527eeb3d95f9f9558ac99973
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 826d7a7..475d98f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -94,8 +94,10 @@ int ipoib_open(struct net_device *dev)
 	if (ipoib_ib_dev_open(dev))
 		return -EINVAL;
 
-	if (ipoib_ib_dev_up(dev))
+	if (ipoib_ib_dev_up(dev)) {
+		ipoib_ib_dev_stop(dev);
 		return -EINVAL;
+	}
 
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
 		struct ipoib_dev_priv *cpriv;
---
0.99.9k
