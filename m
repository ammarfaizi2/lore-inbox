Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVKCXLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVKCXLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbVKCXLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:34 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030524AbVKCXLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:22 -0500
Subject: [git patch review 6/7] [IB] umad: fix hot remove of IB devices
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459423-5367bfddb028b876@cisco.com>
In-Reply-To: <1131059459423-9ff5e95fb47caab0@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:01.0511 (UTC) FILETIME=[DB79E970:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix hotplug of devices for ib_umad module: when a device goes away,
kill off all MAD agents for open files associated with that device,
and make sure that the device is not touched again after ib_umad
returns from its remove_one function.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/user_mad.c |   80 +++++++++++++++++++++++++++++-------
 1 files changed, 64 insertions(+), 16 deletions(-)

applies-to: 2cbc1b1e7bb230afcf4903b6527e3238f689de89
0c99cb6d5fe77872c5a32cff837c05f70158ce15
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 97128e2..aed5ca2 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -94,6 +94,9 @@ struct ib_umad_port {
 	struct class_device   *sm_class_dev;
 	struct semaphore       sm_sem;
 
+	struct rw_semaphore    mutex;
+	struct list_head       file_list;
+
 	struct ib_device      *ib_dev;
 	struct ib_umad_device *umad_dev;
 	int                    dev_num;
@@ -108,10 +111,10 @@ struct ib_umad_device {
 
 struct ib_umad_file {
 	struct ib_umad_port *port;
-	spinlock_t           recv_lock;
 	struct list_head     recv_list;
+	struct list_head     port_list;
+	spinlock_t           recv_lock;
 	wait_queue_head_t    recv_wait;
-	struct rw_semaphore  agent_mutex;
 	struct ib_mad_agent *agent[IB_UMAD_MAX_AGENTS];
 	struct ib_mr        *mr[IB_UMAD_MAX_AGENTS];
 };
@@ -148,7 +151,7 @@ static int queue_packet(struct ib_umad_f
 {
 	int ret = 1;
 
-	down_read(&file->agent_mutex);
+	down_read(&file->port->mutex);
 	for (packet->mad.hdr.id = 0;
 	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
 	     packet->mad.hdr.id++)
@@ -161,7 +164,7 @@ static int queue_packet(struct ib_umad_f
 			break;
 		}
 
-	up_read(&file->agent_mutex);
+	up_read(&file->port->mutex);
 
 	return ret;
 }
@@ -322,7 +325,7 @@ static ssize_t ib_umad_write(struct file
 		goto err;
 	}
 
-	down_read(&file->agent_mutex);
+	down_read(&file->port->mutex);
 
 	agent = file->agent[packet->mad.hdr.id];
 	if (!agent) {
@@ -419,7 +422,7 @@ static ssize_t ib_umad_write(struct file
 	if (ret)
 		goto err_msg;
 
-	up_read(&file->agent_mutex);
+	up_read(&file->port->mutex);
 
 	return count;
 
@@ -430,7 +433,7 @@ err_ah:
 	ib_destroy_ah(ah);
 
 err_up:
-	up_read(&file->agent_mutex);
+	up_read(&file->port->mutex);
 
 err:
 	kfree(packet);
@@ -460,7 +463,12 @@ static int ib_umad_reg_agent(struct ib_u
 	int agent_id;
 	int ret;
 
-	down_write(&file->agent_mutex);
+	down_write(&file->port->mutex);
+
+	if (!file->port->ib_dev) {
+		ret = -EPIPE;
+		goto out;
+	}
 
 	if (copy_from_user(&ureq, (void __user *) arg, sizeof ureq)) {
 		ret = -EFAULT;
@@ -522,7 +530,7 @@ err:
 	ib_unregister_mad_agent(agent);
 
 out:
-	up_write(&file->agent_mutex);
+	up_write(&file->port->mutex);
 	return ret;
 }
 
@@ -531,7 +539,7 @@ static int ib_umad_unreg_agent(struct ib
 	u32 id;
 	int ret = 0;
 
-	down_write(&file->agent_mutex);
+	down_write(&file->port->mutex);
 
 	if (get_user(id, (u32 __user *) arg)) {
 		ret = -EFAULT;
@@ -548,7 +556,7 @@ static int ib_umad_unreg_agent(struct ib
 	file->agent[id] = NULL;
 
 out:
-	up_write(&file->agent_mutex);
+	up_write(&file->port->mutex);
 	return ret;
 }
 
@@ -569,6 +577,7 @@ static int ib_umad_open(struct inode *in
 {
 	struct ib_umad_port *port;
 	struct ib_umad_file *file;
+	int ret = 0;
 
 	spin_lock(&port_lock);
 	port = umad_port[iminor(inode) - IB_UMAD_MINOR_BASE];
@@ -579,21 +588,32 @@ static int ib_umad_open(struct inode *in
 	if (!port)
 		return -ENXIO;
 
+	down_write(&port->mutex);
+
+	if (!port->ib_dev) {
+		ret = -ENXIO;
+		goto out;
+	}
+
 	file = kzalloc(sizeof *file, GFP_KERNEL);
 	if (!file) {
 		kref_put(&port->umad_dev->ref, ib_umad_release_dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	spin_lock_init(&file->recv_lock);
-	init_rwsem(&file->agent_mutex);
 	INIT_LIST_HEAD(&file->recv_list);
 	init_waitqueue_head(&file->recv_wait);
 
 	file->port = port;
 	filp->private_data = file;
 
-	return 0;
+	list_add_tail(&file->port_list, &port->file_list);
+
+out:
+	up_write(&port->mutex);
+	return ret;
 }
 
 static int ib_umad_close(struct inode *inode, struct file *filp)
@@ -603,6 +623,7 @@ static int ib_umad_close(struct inode *i
 	struct ib_umad_packet *packet, *tmp;
 	int i;
 
+	down_write(&file->port->mutex);
 	for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
 		if (file->agent[i]) {
 			ib_dereg_mr(file->mr[i]);
@@ -612,6 +633,9 @@ static int ib_umad_close(struct inode *i
 	list_for_each_entry_safe(packet, tmp, &file->recv_list, list)
 		kfree(packet);
 
+	list_del(&file->port_list);
+	up_write(&file->port->mutex);
+
 	kfree(file);
 
 	kref_put(&dev->ref, ib_umad_release_dev);
@@ -680,9 +704,13 @@ static int ib_umad_sm_close(struct inode
 	struct ib_port_modify props = {
 		.clr_port_cap_mask = IB_PORT_SM
 	};
-	int ret;
+	int ret = 0;
+
+	down_write(&port->mutex);
+	if (port->ib_dev)
+		ret = ib_modify_port(port->ib_dev, port->port_num, 0, &props);
+	up_write(&port->mutex);
 
-	ret = ib_modify_port(port->ib_dev, port->port_num, 0, &props);
 	up(&port->sm_sem);
 
 	kref_put(&port->umad_dev->ref, ib_umad_release_dev);
@@ -745,6 +773,8 @@ static int ib_umad_init_port(struct ib_d
 	port->ib_dev   = device;
 	port->port_num = port_num;
 	init_MUTEX(&port->sm_sem);
+	init_rwsem(&port->mutex);
+	INIT_LIST_HEAD(&port->file_list);
 
 	port->dev = cdev_alloc();
 	if (!port->dev)
@@ -813,6 +843,9 @@ err_cdev:
 
 static void ib_umad_kill_port(struct ib_umad_port *port)
 {
+	struct ib_umad_file *file;
+	int id;
+
 	class_set_devdata(port->class_dev,    NULL);
 	class_set_devdata(port->sm_class_dev, NULL);
 
@@ -826,6 +859,21 @@ static void ib_umad_kill_port(struct ib_
 	umad_port[port->dev_num] = NULL;
 	spin_unlock(&port_lock);
 
+	down_write(&port->mutex);
+
+	port->ib_dev = NULL;
+
+	list_for_each_entry(file, &port->file_list, port_list)
+		for (id = 0; id < IB_UMAD_MAX_AGENTS; ++id) {
+			if (!file->agent[id])
+				continue;
+			ib_dereg_mr(file->mr[id]);
+			ib_unregister_mad_agent(file->agent[id]);
+			file->agent[id] = NULL;
+		}
+
+	up_write(&port->mutex);
+
 	clear_bit(port->dev_num, dev_map);
 }
 
---
0.99.9
