Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVKJScf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVKJScf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKJScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:12 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:45853 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751203AbVKJScE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:04 -0500
Subject: [git patch review 7/7] [IB] umad: further ib_unregister_mad_agent()
	deadlock fixes
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-6e04eecf9c835e20@cisco.com>
In-Reply-To: <1131647515831-7161f73f404fbe76@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:57.0936 (UTC) FILETIME=[086B5F00:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous umad deadlock fix left ib_umad_kill_port() still
vulnerable to deadlocking.  This patch fixes that by downgrading our
lock to a read lock when we might end up trying to reacquire the lock
for reading.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |   87 ++++++++++++++++++++++++++----------
 1 files changed, 63 insertions(+), 24 deletions(-)

applies-to: 17115437026be55dcd74641be21561fecf33dcdb
94382f3562e350ed7c8f7dcd6fc968bdece31328
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index d61f544..5ea741f 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -31,7 +31,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: user_mad.c 2814 2005-07-06 19:14:09Z halr $
+ * $Id: user_mad.c 4010 2005-11-09 23:11:56Z roland $
  */
 
 #include <linux/module.h>
@@ -110,12 +110,13 @@ struct ib_umad_device {
 };
 
 struct ib_umad_file {
-	struct ib_umad_port *port;
-	struct list_head     recv_list;
-	struct list_head     port_list;
-	spinlock_t           recv_lock;
-	wait_queue_head_t    recv_wait;
-	struct ib_mad_agent *agent[IB_UMAD_MAX_AGENTS];
+	struct ib_umad_port    *port;
+	struct list_head	recv_list;
+	struct list_head	port_list;
+	spinlock_t		recv_lock;
+	wait_queue_head_t	recv_wait;
+	struct ib_mad_agent    *agent[IB_UMAD_MAX_AGENTS];
+	int			agents_dead;
 };
 
 struct ib_umad_packet {
@@ -144,6 +145,12 @@ static void ib_umad_release_dev(struct k
 	kfree(dev);
 }
 
+/* caller must hold port->mutex at least for reading */
+static struct ib_mad_agent *__get_agent(struct ib_umad_file *file, int id)
+{
+	return file->agents_dead ? NULL : file->agent[id];
+}
+
 static int queue_packet(struct ib_umad_file *file,
 			struct ib_mad_agent *agent,
 			struct ib_umad_packet *packet)
@@ -151,10 +158,11 @@ static int queue_packet(struct ib_umad_f
 	int ret = 1;
 
 	down_read(&file->port->mutex);
+
 	for (packet->mad.hdr.id = 0;
 	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
 	     packet->mad.hdr.id++)
-		if (agent == file->agent[packet->mad.hdr.id]) {
+		if (agent == __get_agent(file, packet->mad.hdr.id)) {
 			spin_lock_irq(&file->recv_lock);
 			list_add_tail(&packet->list, &file->recv_list);
 			spin_unlock_irq(&file->recv_lock);
@@ -326,7 +334,7 @@ static ssize_t ib_umad_write(struct file
 
 	down_read(&file->port->mutex);
 
-	agent = file->agent[packet->mad.hdr.id];
+	agent = __get_agent(file, packet->mad.hdr.id);
 	if (!agent) {
 		ret = -EINVAL;
 		goto err_up;
@@ -480,7 +488,7 @@ static int ib_umad_reg_agent(struct ib_u
 	}
 
 	for (agent_id = 0; agent_id < IB_UMAD_MAX_AGENTS; ++agent_id)
-		if (!file->agent[agent_id])
+		if (!__get_agent(file, agent_id))
 			goto found;
 
 	ret = -ENOMEM;
@@ -530,7 +538,7 @@ static int ib_umad_unreg_agent(struct ib
 
 	down_write(&file->port->mutex);
 
-	if (id < 0 || id >= IB_UMAD_MAX_AGENTS || !file->agent[id]) {
+	if (id < 0 || id >= IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -608,21 +616,29 @@ static int ib_umad_close(struct inode *i
 	struct ib_umad_file *file = filp->private_data;
 	struct ib_umad_device *dev = file->port->umad_dev;
 	struct ib_umad_packet *packet, *tmp;
+	int already_dead;
 	int i;
 
-	for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
-		if (file->agent[i])
-			ib_unregister_mad_agent(file->agent[i]);
+	down_write(&file->port->mutex);
+
+	already_dead = file->agents_dead;
+	file->agents_dead = 1;
 
 	list_for_each_entry_safe(packet, tmp, &file->recv_list, list)
 		kfree(packet);
 
-	down_write(&file->port->mutex);
 	list_del(&file->port_list);
-	up_write(&file->port->mutex);
 
-	kfree(file);
+	downgrade_write(&file->port->mutex);
+
+	if (!already_dead)
+		for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
+			if (file->agent[i])
+				ib_unregister_mad_agent(file->agent[i]);
 
+	up_read(&file->port->mutex);
+
+	kfree(file);
 	kref_put(&dev->ref, ib_umad_release_dev);
 
 	return 0;
@@ -848,13 +864,36 @@ static void ib_umad_kill_port(struct ib_
 
 	port->ib_dev = NULL;
 
-	list_for_each_entry(file, &port->file_list, port_list)
-		for (id = 0; id < IB_UMAD_MAX_AGENTS; ++id) {
-			if (!file->agent[id])
-				continue;
-			ib_unregister_mad_agent(file->agent[id]);
-			file->agent[id] = NULL;
-		}
+	/*
+	 * Now go through the list of files attached to this port and
+	 * unregister all of their MAD agents.  We need to hold
+	 * port->mutex while doing this to avoid racing with
+	 * ib_umad_close(), but we can't hold the mutex for writing
+	 * while calling ib_unregister_mad_agent(), since that might
+	 * deadlock by calling back into queue_packet().  So we
+	 * downgrade our lock to a read lock, and then drop and
+	 * reacquire the write lock for the next iteration.
+	 *
+	 * We do list_del_init() on the file's list_head so that the
+	 * list_del in ib_umad_close() is still OK, even after the
+	 * file is removed from the list.
+	 */
+	while (!list_empty(&port->file_list)) {
+		file = list_entry(port->file_list.next, struct ib_umad_file,
+				  port_list);
+
+		file->agents_dead = 1;
+		list_del_init(&file->port_list);
+
+		downgrade_write(&port->mutex);
+
+		for (id = 0; id < IB_UMAD_MAX_AGENTS; ++id)
+			if (file->agent[id])
+				ib_unregister_mad_agent(file->agent[id]);
+
+		up_read(&port->mutex);
+		down_write(&port->mutex);
+	}
 
 	up_write(&port->mutex);
 
---
0.99.9e
