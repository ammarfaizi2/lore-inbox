Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVGLAOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVGLAOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVGLAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:14:34 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:26316 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262547AbVGKT5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:57:55 -0400
Subject: [PATCH 6/29v2] Change ib_mad_send_wr_private struct
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110277.4389.4996.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 15:50:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have ib_mad_send_wr_private reference the private agent structure 
directly, rather than the exposed agent definition.  Remove unneeded
parameters to functions and simplify code were possible from this
change.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 5/29.

--
 mad.c      |   22 ++++++++++--
 mad_priv.h |    4 ++--
 2 files changed, 12 insertions(+), 14 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-5/drivers/infiniband/core/mad.c linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad.c
-- linux-2.6.13-rc2-mm1-5/drivers/infiniband/core/mad.c	2005-07-11 13:35:56.000000000 -0400
+++ linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad.c	2005-07-11 13:36:16.000000000 -0400
@@ -839,8 +839,7 @@ void ib_free_send_mad(struct ib_mad_send
 }
 EXPORT_SYMBOL(ib_free_send_mad);
 
-static int ib_send_mad(struct ib_mad_agent_private *mad_agent_priv,
-		       struct ib_mad_send_wr_private *mad_send_wr)
+static int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	struct ib_mad_qp_info *qp_info;
 	struct ib_send_wr *bad_send_wr;
@@ -848,7 +847,7 @@ static int ib_send_mad(struct ib_mad_age
 	int ret;
 
 	/* Set WR ID to find mad_send_wr upon completion */
-	qp_info = mad_agent_priv->qp_info;
+	qp_info = mad_send_wr->mad_agent_priv->qp_info;
 	mad_send_wr->send_wr.wr_id = (unsigned long)&mad_send_wr->mad_list;
 	mad_send_wr->mad_list.mad_queue = &qp_info->send_queue;
 
@@ -857,7 +856,7 @@ static int ib_send_mad(struct ib_mad_age
 		list_add_tail(&mad_send_wr->mad_list.list,
 			      &qp_info->send_queue.list);
 		spin_unlock_irqrestore(&qp_info->send_queue.lock, flags);
-		ret = ib_post_send(mad_agent_priv->agent.qp,
+		ret = ib_post_send(mad_send_wr->mad_agent_priv->agent.qp,
 				   &mad_send_wr->send_wr, &bad_send_wr);
 		if (ret) {
 			printk(KERN_ERR PFX "ib_post_send failed: %d\n", ret);
@@ -950,7 +949,7 @@ int ib_post_send_mad(struct ib_mad_agent
 		mad_send_wr->wr_id = mad_send_wr->send_wr.wr_id;
 		mad_send_wr->send_wr.next = NULL;
 		mad_send_wr->tid = send_wr->wr.ud.mad_hdr->tid;
-		mad_send_wr->agent = mad_agent;
+		mad_send_wr->mad_agent_priv = mad_agent_priv;
 		/* Timeout will be updated after send completes */
 		mad_send_wr->timeout = msecs_to_jiffies(send_wr->wr.
 							ud.timeout_ms);
@@ -966,7 +965,7 @@ int ib_post_send_mad(struct ib_mad_agent
 			      &mad_agent_priv->send_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-		ret = ib_send_mad(mad_agent_priv, mad_send_wr);
+		ret = ib_send_mad(mad_send_wr);
 		if (ret) {
 			/* Fail send request */
 			spin_lock_irqsave(&mad_agent_priv->lock, flags);
@@ -1742,13 +1741,14 @@ static void adjust_timeout(struct ib_mad
 	}
 }
 
-static void wait_for_response(struct ib_mad_agent_private *mad_agent_priv,
-			      struct ib_mad_send_wr_private *mad_send_wr )
+static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 {
+	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *temp_mad_send_wr;
 	struct list_head *list_item;
 	unsigned long delay;
 
+	mad_agent_priv = mad_send_wr->mad_agent_priv;
 	list_del(&mad_send_wr->agent_list);
 
 	delay = mad_send_wr->timeout;
@@ -1781,9 +1781,7 @@ static void ib_mad_complete_send_wr(stru
 	struct ib_mad_agent_private	*mad_agent_priv;
 	unsigned long			flags;
 
-	mad_agent_priv = container_of(mad_send_wr->agent,
-				      struct ib_mad_agent_private, agent);
-
+	mad_agent_priv = mad_send_wr->mad_agent_priv;
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	if (mad_send_wc->status != IB_WC_SUCCESS &&
 	    mad_send_wr->status == IB_WC_SUCCESS) {
@@ -1794,7 +1792,7 @@ static void ib_mad_complete_send_wr(stru
 	if (--mad_send_wr->refcount > 0) {
 		if (mad_send_wr->refcount == 1 && mad_send_wr->timeout &&
 		    mad_send_wr->status == IB_WC_SUCCESS) {
-			wait_for_response(mad_agent_priv, mad_send_wr);
+			wait_for_response(mad_send_wr);
 		}
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 		return;
diff -uprN linux-2.6.13-rc2-mm1-5/drivers/infiniband/core/mad_priv.h linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad_priv.h
-- linux-2.6.13-rc2-mm1-5/drivers/infiniband/core/mad_priv.h	2005-06-29 19:00:53.000000000 -0400
+++ linux-2.6.13-rc2-mm1-6/drivers/infiniband/core/mad_priv.h	2005-07-09 15:09:53.000000000 -0400
@@ -29,7 +29,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: mad_priv.h 1389 2004-12-27 22:56:47Z roland $
+ * $Id: mad_priv.h 1980 2005-03-11 22:33:53Z sean.hefty $
  */
 
 #ifndef __IB_MAD_PRIV_H__
@@ -116,7 +116,7 @@ struct ib_mad_snoop_private {
 struct ib_mad_send_wr_private {
 	struct ib_mad_list_head mad_list;
 	struct list_head agent_list;
-	struct ib_mad_agent *agent;
+	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_send_wr send_wr;
 	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
 	u64 wr_id;			/* client WR ID */


