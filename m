Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVLIVwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVLIVwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVLIVwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:52:01 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:30754 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964881AbVLIVwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:52:00 -0500
Subject: [git patch review 3/5] IB/cm: avoid reusing local ID
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 09 Dec 2005 21:51:50 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134165110300-7535693e84cc230f@cisco.com>
In-Reply-To: <1134165110300-7a2e27ea7ca96ec0@cisco.com>
X-OriginalArrivalTime: 09 Dec 2005 21:51:51.0300 (UTC) FILETIME=[C3003C40:01C5FD0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use an increasing local ID to avoid re-using identifiers while
messages may still be outstanding on the old ID.  Without this, a
quick connect-disconnect-connect sequence can fail by matching
messages for the new connection with the old connection.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/cm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

de1bb1a64c29bae4f5330c70bd1dc6a62954c9f4
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1fe2186..3a611fe 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -308,10 +308,11 @@ static int cm_alloc_id(struct cm_id_priv
 {
 	unsigned long flags;
 	int ret;
+	static int next_id;
 
 	do {
 		spin_lock_irqsave(&cm.lock, flags);
-		ret = idr_get_new_above(&cm.local_id_table, cm_id_priv, 1,
+		ret = idr_get_new_above(&cm.local_id_table, cm_id_priv, next_id++,
 					(__force int *) &cm_id_priv->id.local_id);
 		spin_unlock_irqrestore(&cm.lock, flags);
 	} while( (ret == -EAGAIN) && idr_pre_get(&cm.local_id_table, GFP_KERNEL) );
-- 
0.99.9l
