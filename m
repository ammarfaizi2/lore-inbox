Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWAUWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWAUWDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWAUWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:03:14 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:32526 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932399AbWAUWDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:03:14 -0500
Subject: [git patch review 1/5] IPoIB: Make sure path is fully initialized
	before using it
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 21 Jan 2006 22:03:10 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137880990999-28a2de7670074e8b@cisco.com>
X-OriginalArrivalTime: 21 Jan 2006 22:03:12.0980 (UTC) FILETIME=[79139940:01C61ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SA path record query completion can initialize path->pathrec.dlid
before IPoIB's callback runs and initializes path->ah, so we must test
ah rather than dlid.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

47f7a0714b67b904a3a36e2f2d85904e8064219b
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index fd3f5c8..c3b5f79 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -505,7 +505,7 @@ static void neigh_add_path(struct sk_buf
 
 	list_add_tail(&neigh->list, &path->neigh_list);
 
-	if (path->pathrec.dlid) {
+	if (path->ah) {
 		kref_get(&path->ah->ref);
 		neigh->ah = path->ah;
 
@@ -591,7 +591,7 @@ static void unicast_arp_send(struct sk_b
 		return;
 	}
 
-	if (path->pathrec.dlid) {
+	if (path->ah) {
 		ipoib_dbg(priv, "Send unicast ARP to %04x\n",
 			  be16_to_cpu(path->pathrec.dlid));
 
-- 
1.1.3
