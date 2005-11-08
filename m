Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbVKHGbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbVKHGbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbVKHGbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:31:51 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:27941 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965273AbVKHGa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:30:29 -0500
Subject: [git patch review 4/6] [IB] umad: avoid potential deadlock when
	unregistering MAD agents
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 08 Nov 2005 06:30:19 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131431419060-bf0b43a20ac24b6a@cisco.com>
In-Reply-To: <1131431419060-dda308f068edb6f9@cisco.com>
X-OriginalArrivalTime: 08 Nov 2005 06:30:20.0128 (UTC) FILETIME=[E416AE00:01C5E42D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ib_unregister_mad_agent() completes all pending MAD sends and waits
for the agent's send_handler routine to return.  umad's send_handler()
calls queue_packet(), which does down_read() on the port mutex to look
up the agent ID.  This means that the port mutex cannot be held for
writing while calling ib_unregister_mad_agent(), or else it will
deadlock.  This patch fixes all the calls to ib_unregister_mad_agent()
in the umad module to avoid this deadlock.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

applies-to: 69df1437f2ab467ff8bdd28a9282a3af19daa119
85e28883ef956d40b4aac3fc81ff39ac19713541
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 6aefeed..f5ed36c 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -505,8 +505,6 @@ found:
 		goto out;
 	}
 
-	file->agent[agent_id] = agent;
-
 	file->mr[agent_id] = ib_get_dma_mr(agent->qp->pd, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(file->mr[agent_id])) {
 		ret = -ENOMEM;
@@ -519,14 +517,15 @@ found:
 		goto err_mr;
 	}
 
+	file->agent[agent_id] = agent;
 	ret = 0;
+
 	goto out;
 
 err_mr:
 	ib_dereg_mr(file->mr[agent_id]);
 
 err:
-	file->agent[agent_id] = NULL;
 	ib_unregister_mad_agent(agent);
 
 out:
@@ -536,27 +535,33 @@ out:
 
 static int ib_umad_unreg_agent(struct ib_umad_file *file, unsigned long arg)
 {
+	struct ib_mad_agent *agent = NULL;
+	struct ib_mr *mr = NULL;
 	u32 id;
 	int ret = 0;
 
-	down_write(&file->port->mutex);
+	if (get_user(id, (u32 __user *) arg))
+		return -EFAULT;
 
-	if (get_user(id, (u32 __user *) arg)) {
-		ret = -EFAULT;
-		goto out;
-	}
+	down_write(&file->port->mutex);
 
 	if (id < 0 || id >= IB_UMAD_MAX_AGENTS || !file->agent[id]) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ib_dereg_mr(file->mr[id]);
-	ib_unregister_mad_agent(file->agent[id]);
+	agent = file->agent[id];
+	mr    = file->mr[id];
 	file->agent[id] = NULL;
 
 out:
 	up_write(&file->port->mutex);
+
+	if (agent) {
+		ib_unregister_mad_agent(agent);
+		ib_dereg_mr(mr);
+	}
+
 	return ret;
 }
 
@@ -623,16 +628,16 @@ static int ib_umad_close(struct inode *i
 	struct ib_umad_packet *packet, *tmp;
 	int i;
 
-	down_write(&file->port->mutex);
 	for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
 		if (file->agent[i]) {
-			ib_dereg_mr(file->mr[i]);
 			ib_unregister_mad_agent(file->agent[i]);
+			ib_dereg_mr(file->mr[i]);
 		}
 
 	list_for_each_entry_safe(packet, tmp, &file->recv_list, list)
 		kfree(packet);
 
+	down_write(&file->port->mutex);
 	list_del(&file->port_list);
 	up_write(&file->port->mutex);
 
---
0.99.9e
