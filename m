Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVKJScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVKJScj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKJScG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:06 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48904 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932132AbVKJScD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:03 -0500
Subject: [git patch review 2/7] [IB] umad: get rid of unused mr array
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-cd68db8e19d165ad@cisco.com>
In-Reply-To: <1131647515831-039f6ac6e65cc7ed@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:56.0920 (UTC) FILETIME=[07D05780:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ib_umad uses the new MAD sending interface, it no longer
needs its own L_Key.  So just delete the array of MRs that it keeps.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |   29 ++++-------------------------
 1 files changed, 4 insertions(+), 25 deletions(-)

applies-to: e7b9ffe6fca9246f29a0a3cdf6417770f5821cef
ec914c52d6208d8752dfd85b48a9aff304911434
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index f5ed36c..d61f544 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -116,7 +116,6 @@ struct ib_umad_file {
 	spinlock_t           recv_lock;
 	wait_queue_head_t    recv_wait;
 	struct ib_mad_agent *agent[IB_UMAD_MAX_AGENTS];
-	struct ib_mr        *mr[IB_UMAD_MAX_AGENTS];
 };
 
 struct ib_umad_packet {
@@ -505,29 +504,16 @@ found:
 		goto out;
 	}
 
-	file->mr[agent_id] = ib_get_dma_mr(agent->qp->pd, IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(file->mr[agent_id])) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
 	if (put_user(agent_id,
 		     (u32 __user *) (arg + offsetof(struct ib_user_mad_reg_req, id)))) {
 		ret = -EFAULT;
-		goto err_mr;
+		ib_unregister_mad_agent(agent);
+		goto out;
 	}
 
 	file->agent[agent_id] = agent;
 	ret = 0;
 
-	goto out;
-
-err_mr:
-	ib_dereg_mr(file->mr[agent_id]);
-
-err:
-	ib_unregister_mad_agent(agent);
-
 out:
 	up_write(&file->port->mutex);
 	return ret;
@@ -536,7 +522,6 @@ out:
 static int ib_umad_unreg_agent(struct ib_umad_file *file, unsigned long arg)
 {
 	struct ib_mad_agent *agent = NULL;
-	struct ib_mr *mr = NULL;
 	u32 id;
 	int ret = 0;
 
@@ -551,16 +536,13 @@ static int ib_umad_unreg_agent(struct ib
 	}
 
 	agent = file->agent[id];
-	mr    = file->mr[id];
 	file->agent[id] = NULL;
 
 out:
 	up_write(&file->port->mutex);
 
-	if (agent) {
+	if (agent)
 		ib_unregister_mad_agent(agent);
-		ib_dereg_mr(mr);
-	}
 
 	return ret;
 }
@@ -629,10 +611,8 @@ static int ib_umad_close(struct inode *i
 	int i;
 
 	for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
-		if (file->agent[i]) {
+		if (file->agent[i])
 			ib_unregister_mad_agent(file->agent[i]);
-			ib_dereg_mr(file->mr[i]);
-		}
 
 	list_for_each_entry_safe(packet, tmp, &file->recv_list, list)
 		kfree(packet);
@@ -872,7 +852,6 @@ static void ib_umad_kill_port(struct ib_
 		for (id = 0; id < IB_UMAD_MAX_AGENTS; ++id) {
 			if (!file->agent[id])
 				continue;
-			ib_dereg_mr(file->mr[id]);
 			ib_unregister_mad_agent(file->agent[id]);
 			file->agent[id] = NULL;
 		}
---
0.99.9e
