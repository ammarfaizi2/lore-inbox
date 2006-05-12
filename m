Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWELWID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWELWID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWELWIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:08:01 -0400
Received: from test-iport-2.cisco.com ([171.71.176.105]:35394 "EHLO
	test-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932264AbWELWIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:08:00 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] Please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 12 May 2006 15:07:54 -0700
Message-ID: <adamzdmx5fp.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 May 2006 22:07:55.0856 (UTC) FILETIME=[85894D00:01C67610]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The changes and patch are:

Roland Dreier:
      IB/ipath: Properly terminate PCI ID table

Sean Hefty:
      IB: refcount race fixes

 drivers/infiniband/core/cm.c               |   12 ++++---
 drivers/infiniband/core/mad.c              |   47 +++++++++++++++-------------
 drivers/infiniband/core/mad_priv.h         |    5 ++-
 drivers/infiniband/core/mad_rmpp.c         |   20 ++++++------
 drivers/infiniband/core/ucm.c              |   12 ++++---
 drivers/infiniband/hw/ipath/ipath_driver.c |    7 ++--
 6 files changed, 55 insertions(+), 48 deletions(-)


diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 7cfedb8..86fee43 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -34,6 +34,8 @@
  *
  * $Id: cm.c 2821 2005-07-08 17:07:28Z sean.hefty $
  */
+
+#include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/idr.h>
@@ -122,7 +124,7 @@ struct cm_id_private {
 	struct rb_node service_node;
 	struct rb_node sidr_id_node;
 	spinlock_t lock;	/* Do not acquire inside cm.lock */
-	wait_queue_head_t wait;
+	struct completion comp;
 	atomic_t refcount;
 
 	struct ib_mad_send_buf *msg;
@@ -159,7 +161,7 @@ static void cm_work_handler(void *data);
 static inline void cm_deref_id(struct cm_id_private *cm_id_priv)
 {
 	if (atomic_dec_and_test(&cm_id_priv->refcount))
-		wake_up(&cm_id_priv->wait);
+		complete(&cm_id_priv->comp);
 }
 
 static int cm_alloc_msg(struct cm_id_private *cm_id_priv,
@@ -559,7 +561,7 @@ struct ib_cm_id *ib_create_cm_id(struct 
 		goto error;
 
 	spin_lock_init(&cm_id_priv->lock);
-	init_waitqueue_head(&cm_id_priv->wait);
+	init_completion(&cm_id_priv->comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
 	atomic_set(&cm_id_priv->work_count, -1);
 	atomic_set(&cm_id_priv->refcount, 1);
@@ -724,8 +726,8 @@ retest:
 	}
 
 	cm_free_id(cm_id->local_id);
-	atomic_dec(&cm_id_priv->refcount);
-	wait_event(cm_id_priv->wait, !atomic_read(&cm_id_priv->refcount));
+	cm_deref_id(cm_id_priv);
+	wait_for_completion(&cm_id_priv->comp);
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
 		cm_free_work(work);
 	if (cm_id_priv->private_data && cm_id_priv->private_data_len)
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 469b692..5ad41a6 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -352,7 +352,7 @@ struct ib_mad_agent *ib_register_mad_age
 	INIT_WORK(&mad_agent_priv->local_work, local_completions,
 		   mad_agent_priv);
 	atomic_set(&mad_agent_priv->refcount, 1);
-	init_waitqueue_head(&mad_agent_priv->wait);
+	init_completion(&mad_agent_priv->comp);
 
 	return &mad_agent_priv->agent;
 
@@ -467,7 +467,7 @@ struct ib_mad_agent *ib_register_mad_sno
 	mad_snoop_priv->agent.qp = port_priv->qp_info[qpn].qp;
 	mad_snoop_priv->agent.port_num = port_num;
 	mad_snoop_priv->mad_snoop_flags = mad_snoop_flags;
-	init_waitqueue_head(&mad_snoop_priv->wait);
+	init_completion(&mad_snoop_priv->comp);
 	mad_snoop_priv->snoop_index = register_snoop_agent(
 						&port_priv->qp_info[qpn],
 						mad_snoop_priv);
@@ -486,6 +486,18 @@ error1:
 }
 EXPORT_SYMBOL(ib_register_mad_snoop);
 
+static inline void deref_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
+{
+	if (atomic_dec_and_test(&mad_agent_priv->refcount))
+		complete(&mad_agent_priv->comp);
+}
+
+static inline void deref_snoop_agent(struct ib_mad_snoop_private *mad_snoop_priv)
+{
+	if (atomic_dec_and_test(&mad_snoop_priv->refcount))
+		complete(&mad_snoop_priv->comp);
+}
+
 static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 {
 	struct ib_mad_port_private *port_priv;
@@ -509,9 +521,8 @@ static void unregister_mad_agent(struct 
 	flush_workqueue(port_priv->wq);
 	ib_cancel_rmpp_recvs(mad_agent_priv);
 
-	atomic_dec(&mad_agent_priv->refcount);
-	wait_event(mad_agent_priv->wait,
-		   !atomic_read(&mad_agent_priv->refcount));
+	deref_mad_agent(mad_agent_priv);
+	wait_for_completion(&mad_agent_priv->comp);
 
 	kfree(mad_agent_priv->reg_req);
 	ib_dereg_mr(mad_agent_priv->agent.mr);
@@ -529,9 +540,8 @@ static void unregister_mad_snoop(struct 
 	atomic_dec(&qp_info->snoop_count);
 	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
 
-	atomic_dec(&mad_snoop_priv->refcount);
-	wait_event(mad_snoop_priv->wait,
-		   !atomic_read(&mad_snoop_priv->refcount));
+	deref_snoop_agent(mad_snoop_priv);
+	wait_for_completion(&mad_snoop_priv->comp);
 
 	kfree(mad_snoop_priv);
 }
@@ -600,8 +610,7 @@ static void snoop_send(struct ib_mad_qp_
 		spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
 		mad_snoop_priv->agent.snoop_handler(&mad_snoop_priv->agent,
 						    send_buf, mad_send_wc);
-		if (atomic_dec_and_test(&mad_snoop_priv->refcount))
-			wake_up(&mad_snoop_priv->wait);
+		deref_snoop_agent(mad_snoop_priv);
 		spin_lock_irqsave(&qp_info->snoop_lock, flags);
 	}
 	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
@@ -626,8 +635,7 @@ static void snoop_recv(struct ib_mad_qp_
 		spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
 		mad_snoop_priv->agent.recv_handler(&mad_snoop_priv->agent,
 						   mad_recv_wc);
-		if (atomic_dec_and_test(&mad_snoop_priv->refcount))
-			wake_up(&mad_snoop_priv->wait);
+		deref_snoop_agent(mad_snoop_priv);
 		spin_lock_irqsave(&qp_info->snoop_lock, flags);
 	}
 	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
@@ -968,8 +976,7 @@ void ib_free_send_mad(struct ib_mad_send
 
 	free_send_rmpp_list(mad_send_wr);
 	kfree(send_buf->mad);
-	if (atomic_dec_and_test(&mad_agent_priv->refcount))
-		wake_up(&mad_agent_priv->wait);
+	deref_mad_agent(mad_agent_priv);
 }
 EXPORT_SYMBOL(ib_free_send_mad);
 
@@ -1757,8 +1764,7 @@ static void ib_mad_complete_recv(struct 
 		mad_recv_wc = ib_process_rmpp_recv_wc(mad_agent_priv,
 						      mad_recv_wc);
 		if (!mad_recv_wc) {
-			if (atomic_dec_and_test(&mad_agent_priv->refcount))
-				wake_up(&mad_agent_priv->wait);
+			deref_mad_agent(mad_agent_priv);
 			return;
 		}
 	}
@@ -1770,8 +1776,7 @@ static void ib_mad_complete_recv(struct 
 		if (!mad_send_wr) {
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 			ib_free_recv_mad(mad_recv_wc);
-			if (atomic_dec_and_test(&mad_agent_priv->refcount))
-				wake_up(&mad_agent_priv->wait);
+			deref_mad_agent(mad_agent_priv);
 			return;
 		}
 		ib_mark_mad_done(mad_send_wr);
@@ -1790,8 +1795,7 @@ static void ib_mad_complete_recv(struct 
 	} else {
 		mad_agent_priv->agent.recv_handler(&mad_agent_priv->agent,
 						   mad_recv_wc);
-		if (atomic_dec_and_test(&mad_agent_priv->refcount))
-			wake_up(&mad_agent_priv->wait);
+		deref_mad_agent(mad_agent_priv);
 	}
 }
 
@@ -2021,8 +2025,7 @@ void ib_mad_complete_send_wr(struct ib_m
 						   mad_send_wc);
 
 	/* Release reference on agent taken when sending */
-	if (atomic_dec_and_test(&mad_agent_priv->refcount))
-		wake_up(&mad_agent_priv->wait);
+	deref_mad_agent(mad_agent_priv);
 	return;
 done:
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 6c9c133..b4fa28d 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -37,6 +37,7 @@
 #ifndef __IB_MAD_PRIV_H__
 #define __IB_MAD_PRIV_H__
 
+#include <linux/completion.h>
 #include <linux/pci.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
@@ -108,7 +109,7 @@ struct ib_mad_agent_private {
 	struct list_head rmpp_list;
 
 	atomic_t refcount;
-	wait_queue_head_t wait;
+	struct completion comp;
 };
 
 struct ib_mad_snoop_private {
@@ -117,7 +118,7 @@ struct ib_mad_snoop_private {
 	int snoop_index;
 	int mad_snoop_flags;
 	atomic_t refcount;
-	wait_queue_head_t wait;
+	struct completion comp;
 };
 
 struct ib_mad_send_wr_private {
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index dfd4e58..d4704e0 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -49,7 +49,7 @@ struct mad_rmpp_recv {
 	struct list_head list;
 	struct work_struct timeout_work;
 	struct work_struct cleanup_work;
-	wait_queue_head_t wait;
+	struct completion comp;
 	enum rmpp_state state;
 	spinlock_t lock;
 	atomic_t refcount;
@@ -69,10 +69,16 @@ struct mad_rmpp_recv {
 	u8 method;
 };
 
+static inline void deref_rmpp_recv(struct mad_rmpp_recv *rmpp_recv)
+{
+	if (atomic_dec_and_test(&rmpp_recv->refcount))
+		complete(&rmpp_recv->comp);
+}
+
 static void destroy_rmpp_recv(struct mad_rmpp_recv *rmpp_recv)
 {
-	atomic_dec(&rmpp_recv->refcount);
-	wait_event(rmpp_recv->wait, !atomic_read(&rmpp_recv->refcount));
+	deref_rmpp_recv(rmpp_recv);
+	wait_for_completion(&rmpp_recv->comp);
 	ib_destroy_ah(rmpp_recv->ah);
 	kfree(rmpp_recv);
 }
@@ -253,7 +259,7 @@ create_rmpp_recv(struct ib_mad_agent_pri
 		goto error;
 
 	rmpp_recv->agent = agent;
-	init_waitqueue_head(&rmpp_recv->wait);
+	init_completion(&rmpp_recv->comp);
 	INIT_WORK(&rmpp_recv->timeout_work, recv_timeout_handler, rmpp_recv);
 	INIT_WORK(&rmpp_recv->cleanup_work, recv_cleanup_handler, rmpp_recv);
 	spin_lock_init(&rmpp_recv->lock);
@@ -279,12 +285,6 @@ error:	kfree(rmpp_recv);
 	return NULL;
 }
 
-static inline void deref_rmpp_recv(struct mad_rmpp_recv *rmpp_recv)
-{
-	if (atomic_dec_and_test(&rmpp_recv->refcount))
-		wake_up(&rmpp_recv->wait);
-}
-
 static struct mad_rmpp_recv *
 find_rmpp_recv(struct ib_mad_agent_private *agent,
 	       struct ib_mad_recv_wc *mad_recv_wc)
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index f6a0596..9164a09 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -32,6 +32,8 @@
  *
  * $Id: ucm.c 2594 2005-06-13 19:46:02Z libor $
  */
+
+#include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -72,7 +74,7 @@ struct ib_ucm_file {
 
 struct ib_ucm_context {
 	int                 id;
-	wait_queue_head_t   wait;
+	struct completion   comp;
 	atomic_t            ref;
 	int		    events_reported;
 
@@ -138,7 +140,7 @@ static struct ib_ucm_context *ib_ucm_ctx
 static void ib_ucm_ctx_put(struct ib_ucm_context *ctx)
 {
 	if (atomic_dec_and_test(&ctx->ref))
-		wake_up(&ctx->wait);
+		complete(&ctx->comp);
 }
 
 static inline int ib_ucm_new_cm_id(int event)
@@ -178,7 +180,7 @@ static struct ib_ucm_context *ib_ucm_ctx
 		return NULL;
 
 	atomic_set(&ctx->ref, 1);
-	init_waitqueue_head(&ctx->wait);
+	init_completion(&ctx->comp);
 	ctx->file = file;
 	INIT_LIST_HEAD(&ctx->events);
 
@@ -586,8 +588,8 @@ static ssize_t ib_ucm_destroy_id(struct 
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	atomic_dec(&ctx->ref);
-	wait_event(ctx->wait, !atomic_read(&ctx->ref));
+	ib_ucm_ctx_put(ctx);
+	wait_for_completion(&ctx->comp);
 
 	/* No new events will be generated after destroying the cm_id. */
 	ib_destroy_cm_id(ctx->cm_id);
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index 398add4..3697eda 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -116,10 +116,9 @@ #define PCI_DEVICE_ID_INFINIPATH_HT 0xd
 #define PCI_DEVICE_ID_INFINIPATH_PE800 0x10
 
 static const struct pci_device_id ipath_pci_tbl[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE,
-		    PCI_DEVICE_ID_INFINIPATH_HT)},
-	{PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE,
-		    PCI_DEVICE_ID_INFINIPATH_PE800)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_INFINIPATH_HT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_INFINIPATH_PE800) },
+	{ 0, }
 };
 
 MODULE_DEVICE_TABLE(pci, ipath_pci_tbl);
