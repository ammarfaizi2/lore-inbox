Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVGKVFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVGKVFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVGKVDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:03:35 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:60109 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262550AbVGKVAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:00:55 -0400
Subject: [PATCH 24/29v2] Implementation for RMPP support in user MAD
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110412.4389.5032.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 16:53:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation for RMPP support in user MAD

Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 23/29.

--
 user_mad.c |  300 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 194 insertions(+), 106 deletions(-)
diff -uprN linux-2.6.13-rc2-mm1-23/drivers/infiniband/core/user_mad.c linux-2.6.13-rc2-mm1-24/drivers/infiniband/core/user_mad.c
-- linux-2.6.13-rc2-mm1-23/drivers/infiniband/core/user_mad.c	2005-07-09 17:14:46.000000000 -0400
+++ linux-2.6.13-rc2-mm1-24/drivers/infiniband/core/user_mad.c	2005-07-10 16:56:39.000000000 -0400
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Voltaire, Inc. All rights reserved. 
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -29,7 +31,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
- * $Id: user_mad.c 1389 2004-12-27 22:56:47Z roland $
+ * $Id: user_mad.c 2814 2005-07-06 19:14:09Z halr $
  */
 
 #include <linux/module.h>
@@ -94,10 +96,12 @@ struct ib_umad_file {
 };
 
 struct ib_umad_packet {
-	struct ib_user_mad mad;
 	struct ib_ah      *ah;
+	struct ib_mad_send_buf *msg;
 	struct list_head   list;
+	int		   length;
 	DECLARE_PCI_UNMAP_ADDR(mapping)
+	struct ib_user_mad mad;
 };
 
 static const dev_t base_dev = MKDEV(IB_UMAD_MAJOR, IB_UMAD_MINOR_BASE);
@@ -114,10 +118,10 @@ static int queue_packet(struct ib_umad_f
 	int ret = 1;
 
 	down_read(&file->agent_mutex);
-	for (packet->mad.id = 0;
-	     packet->mad.id < IB_UMAD_MAX_AGENTS;
-	     packet->mad.id++)
-		if (agent == file->agent[packet->mad.id]) {
+	for (packet->mad.hdr.id = 0;
+	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
+	     packet->mad.hdr.id++)
+		if (agent == file->agent[packet->mad.hdr.id]) {
 			spin_lock_irq(&file->recv_lock);
 			list_add_tail(&packet->list, &file->recv_list);
 			spin_unlock_irq(&file->recv_lock);
@@ -135,22 +139,30 @@ static void send_handler(struct ib_mad_a
 			 struct ib_mad_send_wc *send_wc)
 {
 	struct ib_umad_file *file = agent->context;
-	struct ib_umad_packet *packet =
+	struct ib_umad_packet *timeout, *packet =
 		(void *) (unsigned long) send_wc->wr_id;
 
-	dma_unmap_single(agent->device->dma_device,
-			 pci_unmap_addr(packet, mapping),
-			 sizeof packet->mad.data,
-			 DMA_TO_DEVICE);
-	ib_destroy_ah(packet->ah);
+	ib_destroy_ah(packet->msg->send_wr.wr.ud.ah);
+	ib_free_send_mad(packet->msg);
 
 	if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
-		packet->mad.status = ETIMEDOUT;
+		timeout = kmalloc(sizeof *timeout + sizeof (struct ib_mad_hdr),
+				  GFP_KERNEL);
+		if (!timeout)
+			goto out;
+
+		memset(timeout, 0, sizeof *timeout + sizeof (struct ib_mad_hdr));
+
+		timeout->length = sizeof (struct ib_mad_hdr);
+		timeout->mad.hdr.id = packet->mad.hdr.id;
+		timeout->mad.hdr.status = ETIMEDOUT;
+		memcpy(timeout->mad.data, packet->mad.data,
+		       sizeof (struct ib_mad_hdr));
 
-		if (!queue_packet(file, agent, packet))
-			return;
+		if (!queue_packet(file, agent, timeout))
+				return;
 	}
-
+out:
 	kfree(packet);
 }
 
@@ -159,30 +171,35 @@ static void recv_handler(struct ib_mad_a
 {
 	struct ib_umad_file *file = agent->context;
 	struct ib_umad_packet *packet;
+	int length;
 
 	if (mad_recv_wc->wc->status != IB_WC_SUCCESS)
 		goto out;
 
-	packet = kmalloc(sizeof *packet, GFP_KERNEL);
+	length = mad_recv_wc->mad_len; 
+	packet = kmalloc(sizeof *packet + length, GFP_KERNEL);
 	if (!packet)
 		goto out;
 
-	memset(packet, 0, sizeof *packet);
+	memset(packet, 0, sizeof *packet + length);
+	packet->length = length;
+
+	ib_coalesce_recv_mad(mad_recv_wc, packet->mad.data);
 
-	memcpy(packet->mad.data, mad_recv_wc->recv_buf.mad, sizeof packet->mad.data);
-	packet->mad.status        = 0;
-	packet->mad.qpn 	  = cpu_to_be32(mad_recv_wc->wc->src_qp);
-	packet->mad.lid 	  = cpu_to_be16(mad_recv_wc->wc->slid);
-	packet->mad.sl  	  = mad_recv_wc->wc->sl;
-	packet->mad.path_bits 	  = mad_recv_wc->wc->dlid_path_bits;
-	packet->mad.grh_present   = !!(mad_recv_wc->wc->wc_flags & IB_WC_GRH);
-	if (packet->mad.grh_present) {
+	packet->mad.hdr.status    = 0;
+	packet->mad.hdr.length    = length + sizeof (struct ib_user_mad);
+	packet->mad.hdr.qpn 	  = cpu_to_be32(mad_recv_wc->wc->src_qp);
+	packet->mad.hdr.lid 	  = cpu_to_be16(mad_recv_wc->wc->slid);
+	packet->mad.hdr.sl  	  = mad_recv_wc->wc->sl;
+	packet->mad.hdr.path_bits = mad_recv_wc->wc->dlid_path_bits;
+	packet->mad.hdr.grh_present = !!(mad_recv_wc->wc->wc_flags & IB_WC_GRH);
+	if (packet->mad.hdr.grh_present) {
 		/* XXX parse GRH */
-		packet->mad.gid_index 	  = 0;
-		packet->mad.hop_limit 	  = 0;
-		packet->mad.traffic_class = 0;
-		memset(packet->mad.gid, 0, 16);
-		packet->mad.flow_label 	  = 0;
+		packet->mad.hdr.gid_index 	= 0;
+		packet->mad.hdr.hop_limit 	= 0;
+		packet->mad.hdr.traffic_class	= 0;
+		memset(packet->mad.hdr.gid, 0, 16);
+		packet->mad.hdr.flow_label	= 0;
 	}
 
 	if (queue_packet(file, agent, packet))
@@ -199,7 +216,7 @@ static ssize_t ib_umad_read(struct file 
 	struct ib_umad_packet *packet;
 	ssize_t ret;
 
-	if (count < sizeof (struct ib_user_mad))
+	if (count < sizeof (struct ib_user_mad) + sizeof (struct ib_mad))
 		return -EINVAL;
 
 	spin_lock_irq(&file->recv_lock);
@@ -222,12 +239,25 @@ static ssize_t ib_umad_read(struct file 
 
 	spin_unlock_irq(&file->recv_lock);
 
-	if (copy_to_user(buf, &packet->mad, sizeof packet->mad))
+	if (count < packet->length + sizeof (struct ib_user_mad)) {
+		/* Return length needed (and first RMPP segment) if too small */
+		if (copy_to_user(buf, &packet->mad,
+				 sizeof (struct ib_user_mad) + sizeof (struct ib_mad)))
+			ret = -EFAULT;
+		else
+			ret = -ENOSPC;
+	} else if (copy_to_user(buf, &packet->mad,
+			      packet->length + sizeof (struct ib_user_mad)))
 		ret = -EFAULT;
 	else
-		ret = sizeof packet->mad;
-
-	kfree(packet);
+		ret = packet->length + sizeof (struct ib_user_mad);
+	if (ret < 0) {
+		/* Requeue packet */
+		spin_lock_irq(&file->recv_lock);
+		list_add(&packet->list, &file->recv_list);
+		spin_unlock_irq(&file->recv_lock);
+	} else
+		kfree(packet);
 	return ret;
 }
 
@@ -238,106 +268,163 @@ static ssize_t ib_umad_write(struct file
 	struct ib_umad_packet *packet;
 	struct ib_mad_agent *agent;
 	struct ib_ah_attr ah_attr;
-	struct ib_sge      gather_list;
-	struct ib_send_wr *bad_wr, wr = {
-		.opcode      = IB_WR_SEND,
-		.sg_list     = &gather_list,
-		.num_sge     = 1,
-		.send_flags  = IB_SEND_SIGNALED,
-	};
+	struct ib_send_wr *bad_wr;
+	struct ib_rmpp_mad *rmpp_mad;
 	u8 method;
 	u64 *tid;
-	int ret;
+	int ret, length, hdr_len, data_len, rmpp_hdr_size;
+	int rmpp_active = 0;
 
 	if (count < sizeof (struct ib_user_mad))
 		return -EINVAL;
 
-	packet = kmalloc(sizeof *packet, GFP_KERNEL);
+	length = count - sizeof (struct ib_user_mad);
+	packet = kmalloc(sizeof *packet + sizeof(struct ib_mad_hdr) +
+			 sizeof(struct ib_rmpp_hdr), GFP_KERNEL);
 	if (!packet)
 		return -ENOMEM;
 
-	if (copy_from_user(&packet->mad, buf, sizeof packet->mad)) {
-		kfree(packet);
-		return -EFAULT;
+	if (copy_from_user(&packet->mad, buf,
+			    sizeof (struct ib_user_mad) +
+			    sizeof(struct ib_mad_hdr) +
+			    sizeof(struct ib_rmpp_hdr))) {
+		ret = -EFAULT;
+		goto err;
 	}
 
-	if (packet->mad.id < 0 || packet->mad.id >= IB_UMAD_MAX_AGENTS) {
+	if (packet->mad.hdr.id < 0 ||
+	    packet->mad.hdr.id >= IB_UMAD_MAX_AGENTS) {
 		ret = -EINVAL;
 		goto err;
 	}
 
+	packet->length = length;
+
 	down_read(&file->agent_mutex);
 
-	agent = file->agent[packet->mad.id];
+	agent = file->agent[packet->mad.hdr.id];
 	if (!agent) {
 		ret = -EINVAL;
 		goto err_up;
 	}
 
+	memset(&ah_attr, 0, sizeof ah_attr);
+	ah_attr.dlid          = be16_to_cpu(packet->mad.hdr.lid);
+	ah_attr.sl            = packet->mad.hdr.sl;
+	ah_attr.src_path_bits = packet->mad.hdr.path_bits;
+	ah_attr.port_num      = file->port->port_num;
+	if (packet->mad.hdr.grh_present) {
+		ah_attr.ah_flags = IB_AH_GRH;
+		memcpy(ah_attr.grh.dgid.raw, packet->mad.hdr.gid, 16);
+		ah_attr.grh.flow_label 	   = packet->mad.hdr.flow_label;
+		ah_attr.grh.hop_limit  	   = packet->mad.hdr.hop_limit;
+		ah_attr.grh.traffic_class  = packet->mad.hdr.traffic_class;
+	}
+
+	packet->ah = ib_create_ah(agent->qp->pd, &ah_attr);
+	if (IS_ERR(packet->ah)) {
+		ret = PTR_ERR(packet->ah);
+		goto err_up;
+	}
+
+	rmpp_mad = (struct ib_rmpp_mad *) packet->mad.data;
+	if (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE) {
+		/* RMPP active */
+		if (!agent->rmpp_version) {
+			ret = -EINVAL;
+			goto err_ah;
+		}
+		/* Validate that management class can support RMPP */
+		if (rmpp_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_SUBN_ADM) {
+			hdr_len = offsetof(struct ib_sa_mad, data);
+			data_len = length;
+		} else if ((rmpp_mad->mad_hdr.mgmt_class >= IB_MGMT_CLASS_VENDOR_RANGE2_START) &&
+			    (rmpp_mad->mad_hdr.mgmt_class <= IB_MGMT_CLASS_VENDOR_RANGE2_END)) {
+				hdr_len = offsetof(struct ib_vendor_mad, data);
+				data_len = length - hdr_len;
+		} else {
+			ret = -EINVAL;
+			goto err_ah;
+		}
+		rmpp_active = 1;
+	} else {
+		if (length > sizeof(struct ib_mad)) {
+			ret = -EINVAL;
+			goto err_ah;
+		}
+		hdr_len = offsetof(struct ib_mad, data);
+		data_len = length - hdr_len;
+	}
+	
+	packet->msg = ib_create_send_mad(agent,
+					 be32_to_cpu(packet->mad.hdr.qpn),
+					 0, packet->ah, rmpp_active,
+					 hdr_len, data_len,
+					 GFP_KERNEL);
+	if (IS_ERR(packet->msg)) {
+		ret = PTR_ERR(packet->msg);
+		goto err_ah;
+	}
+
+	packet->msg->send_wr.wr.ud.timeout_ms  = packet->mad.hdr.timeout_ms;
+	packet->msg->send_wr.wr.ud.retries = packet->mad.hdr.retries;
+
+	/* Override send WR WRID initialized in ib_create_send_mad */
+	packet->msg->send_wr.wr_id = (unsigned long) packet;
+
+	if (!rmpp_active) {
+		/* Copy message from user into send buffer */
+		if (copy_from_user(packet->msg->mad,
+				   buf + sizeof(struct ib_user_mad), length)) {
+			ret = -EFAULT;
+			goto err_msg;
+		}
+	} else {
+		rmpp_hdr_size = sizeof(struct ib_mad_hdr) +
+				sizeof(struct ib_rmpp_hdr);
+
+		/* Only copy MAD headers (RMPP header in place) */
+		memcpy(packet->msg->mad, packet->mad.data,
+		       sizeof(struct ib_mad_hdr));
+
+		/* Now, copy rest of message from user into send buffer */
+		if (copy_from_user(((struct ib_rmpp_mad *) packet->msg->mad)->data,
+				   buf + sizeof (struct ib_user_mad) + rmpp_hdr_size,
+				   length - rmpp_hdr_size)) {
+			ret = -EFAULT;
+			goto err_msg;
+		}
+	}
+
 	/*
 	 * If userspace is generating a request that will generate a
 	 * response, we need to make sure the high-order part of the
 	 * transaction ID matches the agent being used to send the
 	 * MAD.
 	 */
-	method = ((struct ib_mad_hdr *) packet->mad.data)->method;
+	method = packet->msg->mad->mad_hdr.method;
 
 	if (!(method & IB_MGMT_METHOD_RESP)       &&
 	    method != IB_MGMT_METHOD_TRAP_REPRESS &&
 	    method != IB_MGMT_METHOD_SEND) {
-		tid = &((struct ib_mad_hdr *) packet->mad.data)->tid;
+		tid = &packet->msg->mad->mad_hdr.tid;
 		*tid = cpu_to_be64(((u64) agent->hi_tid) << 32 |
 				   (be64_to_cpup(tid) & 0xffffffff));
 	}
 
-	memset(&ah_attr, 0, sizeof ah_attr);
-	ah_attr.dlid          = be16_to_cpu(packet->mad.lid);
-	ah_attr.sl            = packet->mad.sl;
-	ah_attr.src_path_bits = packet->mad.path_bits;
-	ah_attr.port_num      = file->port->port_num;
-	if (packet->mad.grh_present) {
-		ah_attr.ah_flags = IB_AH_GRH;
-		memcpy(ah_attr.grh.dgid.raw, packet->mad.gid, 16);
-		ah_attr.grh.flow_label 	   = packet->mad.flow_label;
-		ah_attr.grh.hop_limit  	   = packet->mad.hop_limit;
-		ah_attr.grh.traffic_class  = packet->mad.traffic_class;
-	}
-
-	packet->ah = ib_create_ah(agent->qp->pd, &ah_attr);
-	if (IS_ERR(packet->ah)) {
-		ret = PTR_ERR(packet->ah);
-		goto err_up;
-	}
-
-	gather_list.addr = dma_map_single(agent->device->dma_device,
-					  packet->mad.data,
-					  sizeof packet->mad.data,
-					  DMA_TO_DEVICE);
-	gather_list.length = sizeof packet->mad.data;
-	gather_list.lkey   = file->mr[packet->mad.id]->lkey;
-	pci_unmap_addr_set(packet, mapping, gather_list.addr);
-
-	wr.wr.ud.mad_hdr     = (struct ib_mad_hdr *) packet->mad.data;
-	wr.wr.ud.ah          = packet->ah;
-	wr.wr.ud.remote_qpn  = be32_to_cpu(packet->mad.qpn);
-	wr.wr.ud.remote_qkey = be32_to_cpu(packet->mad.qkey);
-	wr.wr.ud.timeout_ms  = packet->mad.timeout_ms;
-	wr.wr.ud.retries     = 0;
+	ret = ib_post_send_mad(agent, &packet->msg->send_wr, &bad_wr);
+	if (ret)
+		goto err_msg;
 
-	wr.wr_id            = (unsigned long) packet;
+	up_read(&file->agent_mutex);
 
-	ret = ib_post_send_mad(agent, &wr, &bad_wr);
-	if (ret) {
-		dma_unmap_single(agent->device->dma_device,
-				 pci_unmap_addr(packet, mapping),
-				 sizeof packet->mad.data,
-				 DMA_TO_DEVICE);
-		goto err_up;
-	}
+	return sizeof (struct ib_user_mad_hdr) + packet->length;
 
-	up_read(&file->agent_mutex);
+err_msg:
+	ib_free_send_mad(packet->msg);
 
-	return sizeof packet->mad;
+err_ah:
+	ib_destroy_ah(packet->ah);
 
 err_up:
 	up_read(&file->agent_mutex);
@@ -400,7 +487,8 @@ found:
 	agent = ib_register_mad_agent(file->port->ib_dev, file->port->port_num,
 				      ureq.qpn ? IB_QPT_GSI : IB_QPT_SMI,
 				      ureq.mgmt_class ? &req : NULL,
-				      0, send_handler, recv_handler, file);
+				      ureq.rmpp_version,
+				      send_handler, recv_handler, file);
 	if (IS_ERR(agent)) {
 		ret = PTR_ERR(agent);
 		goto out;
@@ -461,8 +549,8 @@ out:
 	return ret;
 }
 
-static long ib_umad_ioctl(struct file *filp,
-			 unsigned int cmd, unsigned long arg)
+static long ib_umad_ioctl(struct file *filp, unsigned int cmd,
+			  unsigned long arg)
 {
 	switch (cmd) {
 	case IB_USER_MAD_REGISTER_AGENT:
@@ -518,14 +606,14 @@ static int ib_umad_close(struct inode *i
 }
 
 static struct file_operations umad_fops = {
-	.owner 	        = THIS_MODULE,
-	.read 	        = ib_umad_read,
-	.write 	        = ib_umad_write,
-	.poll 	        = ib_umad_poll,
+	.owner 	 	= THIS_MODULE,
+	.read 	 	= ib_umad_read,
+	.write 	 	= ib_umad_write,
+	.poll 	 	= ib_umad_poll,
 	.unlocked_ioctl = ib_umad_ioctl,
-	.compat_ioctl   = ib_umad_ioctl,
-	.open 	        = ib_umad_open,
-	.release        = ib_umad_close
+	.compat_ioctl 	= ib_umad_ioctl,
+	.open 	 	= ib_umad_open,
+	.release 	= ib_umad_close
 };
 
 static int ib_umad_sm_open(struct inode *inode, struct file *filp)


