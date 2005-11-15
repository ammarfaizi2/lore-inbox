Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVKOIik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVKOIik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVKOIik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:38:40 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:53425 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751381AbVKOIij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:38:39 -0500
Subject: [git patch review 2/3] [IB] srp: don't post receive if no send buf
	available
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 15 Nov 2005 08:38:30 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1132043910918-5d38e36f350b7b00@cisco.com>
In-Reply-To: <1132043910918-ccc552298b599865@cisco.com>
X-OriginalArrivalTime: 15 Nov 2005 08:38:31.0952 (UTC) FILETIME=[F5AA2100:01C5E9BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have __srp_get_tx_iu() fail if the target port's request limit will
not allow the initiator to post a send.  This avoids continuing on and
posting a receive, and then failing to post a corresponding send.  If
that happens, then the initiator will end up with an extra receive
posted, and if this happens to much, the receive queue will overflow.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/srp/ib_srp.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

applies-to: a5f8266c59f39f0a1f3dc3d71a00da7276ac1a80
47f2bce9021b4974ed33b072ebb8348c8145c946
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index a364530..ee9fe22 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -802,13 +802,21 @@ static int srp_post_recv(struct srp_targ
 
 /*
  * Must be called with target->scsi_host->host_lock held to protect
- * req_lim and tx_head.
+ * req_lim and tx_head.  Lock cannot be dropped between call here and
+ * call to __srp_post_send().
  */
 static struct srp_iu *__srp_get_tx_iu(struct srp_target_port *target)
 {
 	if (target->tx_head - target->tx_tail >= SRP_SQ_SIZE)
 		return NULL;
 
+	if (unlikely(target->req_lim < 1)) {
+		if (printk_ratelimit())
+			printk(KERN_DEBUG PFX "Target has req_lim %d\n",
+			       target->req_lim);
+		return NULL;
+	}
+
 	return target->tx_ring[target->tx_head & SRP_SQ_SIZE];
 }
 
@@ -823,11 +831,6 @@ static int __srp_post_send(struct srp_ta
 	struct ib_send_wr wr, *bad_wr;
 	int ret = 0;
 
-	if (target->req_lim < 1) {
-		printk(KERN_ERR PFX "Target has req_lim %d\n", target->req_lim);
-		return -EAGAIN;
-	}
-
 	list.addr   = iu->dma;
 	list.length = len;
 	list.lkey   = target->srp_host->mr->lkey;
---
0.99.9g
