Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUKWRdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUKWRdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKWRdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:33:39 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:896 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261332AbUKWQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:17:36 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123816.7BdwvFRYhI45pb9i@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:16:09 -0800
Message-Id: <20041123816.bPLXoHbNS6amekEO@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][18/21] Add InfiniBand userspace MAD support
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:16:15.0459 (UTC) FILETIME=[C1B7FB30:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver that provides a character special device for each
InfiniBand port.  This device allows userspace to send and receive
MADs via write() and read() (with some control operations implemented
as ioctls).

All operations are 32/64 clean and have been tested with 32-bit
userspace running on a ppc64 kernel.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/infiniband/core/Makefile	2004-11-23 08:10:18.652812015 -0800
+++ linux-bk/drivers/infiniband/core/Makefile	2004-11-23 08:10:23.631077978 -0800
@@ -1,22 +1,12 @@
 EXTRA_CFLAGS += -Idrivers/infiniband/include
 
-obj-$(CONFIG_INFINIBAND) += \
-    ib_core.o \
-    ib_mad.o \
-    ib_sa.o
+obj-$(CONFIG_INFINIBAND) +=	ib_core.o ib_mad.o ib_sa.o ib_umad.o
 
-ib_core-objs := \
-    packer.o \
-    ud_header.o \
-    verbs.o \
-    sysfs.o \
-    device.o \
-    fmr_pool.o \
-    cache.o
+ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
+				device.o fmr_pool.o cache.o
 
-ib_mad-objs := \
-    mad.o \
-    smi.o \
-    agent.o
+ib_mad-y :=			mad.o smi.o agent.o
 
-ib_sa-objs := sa_query.o
+ib_sa-y :=			sa_query.o
+
+ib_umad-y :=			user_mad.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/user_mad.c	2004-11-23 08:10:23.697068248 -0800
@@ -0,0 +1,649 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id$
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/rwsem.h>
+
+#include <asm/uaccess.h>
+
+#include <ib_mad.h>
+#include <ib_user_mad.h>
+
+MODULE_AUTHOR("Roland Dreier");
+MODULE_DESCRIPTION("InfiniBand userspace MAD packet access");
+MODULE_LICENSE("Dual BSD/GPL");
+
+enum {
+	IB_UMAD_MAX_PORTS  = 256,
+	IB_UMAD_MAX_AGENTS = 32
+};
+
+struct ib_umad_port {
+	int                  devnum;
+	struct cdev          dev;
+	struct class_device *class_dev;
+	struct ib_device    *ib_dev;
+	u8                   port_num;
+};
+
+struct ib_umad_device {
+	int                  start_port, end_port;
+	struct ib_umad_port  port[0];
+};
+
+struct ib_umad_file {
+	struct ib_umad_port *port;
+	spinlock_t           recv_lock;
+	struct list_head     recv_list;
+	wait_queue_head_t    recv_wait;
+	struct rw_semaphore  agent_mutex;
+	struct ib_mad_agent *agent[IB_UMAD_MAX_AGENTS];
+	struct ib_mr        *mr[IB_UMAD_MAX_AGENTS];
+};
+
+struct ib_umad_packet {
+	struct ib_user_mad mad;
+	struct ib_ah      *ah;
+	struct list_head   list;
+	DECLARE_PCI_UNMAP_ADDR(mapping)
+};
+
+static dev_t base_dev;
+static spinlock_t map_lock;
+static DECLARE_BITMAP(dev_map, IB_UMAD_MAX_PORTS);
+
+static struct class_simple *umad_class;
+
+static void ib_umad_add_one(struct ib_device *device);
+static void ib_umad_remove_one(struct ib_device *device);
+
+static int queue_packet(struct ib_umad_file *file,
+			struct ib_mad_agent *agent,
+			struct ib_umad_packet *packet)
+{
+	int ret = 1;
+
+	down_read(&file->agent_mutex);
+	for (packet->mad.id = 0;
+	     packet->mad.id < IB_UMAD_MAX_AGENTS;
+	     packet->mad.id++)
+		if (agent == file->agent[packet->mad.id]) {
+			spin_lock_irq(&file->recv_lock);
+			list_add_tail(&packet->list, &file->recv_list);
+			spin_unlock_irq(&file->recv_lock);
+			wake_up_interruptible(&file->recv_wait);
+			ret = 0;
+			break;
+		}
+
+	up_read(&file->agent_mutex);
+
+	return ret;
+}
+
+static void send_handler(struct ib_mad_agent *agent,
+			 struct ib_mad_send_wc *send_wc)
+{
+	struct ib_umad_file *file = agent->context;
+	struct ib_umad_packet *packet =
+		(void *) (unsigned long) send_wc->wr_id;
+
+	dma_unmap_single(agent->device->dma_device,
+			 pci_unmap_addr(packet, mapping),
+			 sizeof packet->mad.data,
+			 DMA_TO_DEVICE);
+	ib_destroy_ah(packet->ah);
+
+	if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
+		packet->mad.status = ETIMEDOUT;
+
+		if (!queue_packet(file, agent, packet))
+			return;
+	}
+		
+	kfree(packet);
+}
+
+static void recv_handler(struct ib_mad_agent *agent,
+			 struct ib_mad_recv_wc *mad_recv_wc)
+{
+	struct ib_umad_file *file = agent->context;
+	struct ib_umad_packet *packet;
+
+	if (mad_recv_wc->wc->status != IB_WC_SUCCESS)
+		goto out;
+
+	packet = kmalloc(sizeof *packet, GFP_KERNEL);
+	if (!packet)
+		goto out;
+
+	memset(packet, 0, sizeof *packet);
+
+	memcpy(packet->mad.data, mad_recv_wc->recv_buf->mad, sizeof packet->mad.data);
+	packet->mad.status        = 0;
+	packet->mad.qpn 	  = cpu_to_be32(mad_recv_wc->wc->src_qp);
+	packet->mad.lid 	  = cpu_to_be16(mad_recv_wc->wc->slid);
+	packet->mad.sl  	  = mad_recv_wc->wc->sl;
+	packet->mad.path_bits 	  = mad_recv_wc->wc->dlid_path_bits;
+	packet->mad.grh_present   = !!(mad_recv_wc->wc->wc_flags & IB_WC_GRH);
+	if (packet->mad.grh_present) {
+		/* XXX parse GRH */
+		packet->mad.gid_index 	  = 0;
+		packet->mad.hop_limit 	  = 0;
+		packet->mad.traffic_class = 0;
+		memset(packet->mad.gid, 0, 16);
+		packet->mad.flow_label 	  = 0;
+	}
+
+	if (queue_packet(file, agent, packet))
+		kfree(packet);
+
+out:
+	ib_free_recv_mad(mad_recv_wc);
+}
+
+static ssize_t ib_umad_read(struct file *filp, char __user *buf,
+			    size_t count, loff_t *pos)
+{
+	struct ib_umad_file *file = filp->private_data;
+	struct ib_umad_packet *packet;
+	ssize_t ret;
+
+	if (count < sizeof (struct ib_user_mad))
+		return -EINVAL;
+
+	spin_lock_irq(&file->recv_lock);
+
+	while (list_empty(&file->recv_list)) {
+		spin_unlock_irq(&file->recv_lock);
+
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		if (wait_event_interruptible(file->recv_wait,
+					     !list_empty(&file->recv_list)))
+			return -ERESTARTSYS;
+
+		spin_lock_irq(&file->recv_lock);
+	}
+
+	packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
+	list_del(&packet->list);
+
+	spin_unlock_irq(&file->recv_lock);
+
+	if (copy_to_user(buf, &packet->mad, sizeof packet->mad))
+		ret = -EFAULT;
+	else
+		ret = sizeof packet->mad;
+
+	kfree(packet);
+	return ret;
+}
+
+static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
+			     size_t count, loff_t *pos)
+{
+	struct ib_umad_file *file = filp->private_data;
+	struct ib_umad_packet *packet;
+	struct ib_mad_agent *agent;
+	struct ib_ah_attr ah_attr;
+	struct ib_sge      gather_list;
+	struct ib_send_wr *bad_wr, wr = {
+		.opcode      = IB_WR_SEND,
+		.sg_list     = &gather_list,
+		.num_sge     = 1,
+		.send_flags  = IB_SEND_SIGNALED,
+	};
+	int ret;
+
+	if (count < sizeof (struct ib_user_mad))
+		return -EINVAL;
+
+	packet = kmalloc(sizeof *packet, GFP_KERNEL);
+	if (!packet)
+		return -ENOMEM;
+
+	if (copy_from_user(&packet->mad, buf, sizeof packet->mad)) {
+		kfree(packet);
+		return -EFAULT;
+	}
+
+	if (packet->mad.id < 0 || packet->mad.id >= IB_UMAD_MAX_AGENTS) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	down_read(&file->agent_mutex);
+
+	agent = file->agent[packet->mad.id];
+	if (!agent) {
+		ret = -EINVAL;
+		goto err_up;
+	}
+
+	((struct ib_mad_hdr *) packet->mad.data)->tid =
+		cpu_to_be64(((u64) agent->hi_tid) << 32 |
+			    (be64_to_cpu(((struct ib_mad_hdr *) packet->mad.data)->tid) &
+			     0xffffffff));
+
+	memset(&ah_attr, 0, sizeof ah_attr);
+	ah_attr.dlid          = be16_to_cpu(packet->mad.lid);
+	ah_attr.sl            = packet->mad.sl;
+	ah_attr.src_path_bits = packet->mad.path_bits;
+	ah_attr.port_num      = file->port->port_num;
+	/* XXX handle GRH */
+
+	packet->ah = ib_create_ah(agent->qp->pd, &ah_attr);
+	if (IS_ERR(packet->ah)) {
+		ret = PTR_ERR(packet->ah);
+		goto err_up;
+	}
+
+	gather_list.addr = dma_map_single(agent->device->dma_device,
+					  packet->mad.data,
+					  sizeof packet->mad.data,
+					  DMA_TO_DEVICE);
+	gather_list.length = sizeof packet->mad.data;
+	gather_list.lkey   = file->mr[packet->mad.id]->lkey;
+	pci_unmap_addr_set(packet, mapping, gather_list.addr);
+
+	wr.wr.ud.mad_hdr     = (struct ib_mad_hdr *) packet->mad.data;
+	wr.wr.ud.ah          = packet->ah;
+	wr.wr.ud.remote_qpn  = be32_to_cpu(packet->mad.qpn);
+	wr.wr.ud.remote_qkey = be32_to_cpu(packet->mad.qkey);
+	wr.wr.ud.timeout_ms  = packet->mad.timeout_ms;
+
+	wr.wr_id            = (unsigned long) packet;
+
+	ret = ib_post_send_mad(agent, &wr, &bad_wr);
+	if (ret) {
+		dma_unmap_single(agent->device->dma_device,
+				 pci_unmap_addr(packet, mapping),
+				 sizeof packet->mad.data,
+				 DMA_TO_DEVICE);
+		goto err_up;
+	}
+
+	up_read(&file->agent_mutex);
+
+	return sizeof packet->mad;
+
+err_up:
+	up_read(&file->agent_mutex);
+
+err:
+	kfree(packet);
+	return ret;
+}
+
+static unsigned int ib_umad_poll(struct file *filp, struct poll_table_struct *wait)
+{
+	struct ib_umad_file *file = filp->private_data;
+
+	/* we will always be able to post a MAD send */
+	unsigned int mask = POLLOUT | POLLWRNORM;
+
+	poll_wait(filp, &file->recv_wait, wait);
+
+	if (!list_empty(&file->recv_list))
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static int ib_umad_reg_agent(struct ib_umad_file *file, unsigned long arg)
+{
+	struct ib_user_mad_reg_req ureq;
+	struct ib_mad_reg_req req;
+	struct ib_mad_agent *agent;
+	int agent_id;
+	int ret;
+
+	down_write(&file->agent_mutex);
+
+	if (copy_from_user(&ureq, (void __user *) arg, sizeof ureq)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (ureq.qpn != 0 && ureq.qpn != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (agent_id = 0; agent_id < IB_UMAD_MAX_AGENTS; ++agent_id)
+		if (!file->agent[agent_id])
+			goto found;
+
+	ret = -ENOMEM;
+	goto out;
+
+found:
+	req.mgmt_class         = ureq.mgmt_class;
+	req.mgmt_class_version = ureq.mgmt_class_version;
+	memcpy(req.method_mask, ureq.method_mask, sizeof req.method_mask);
+
+	agent = ib_register_mad_agent(file->port->ib_dev, file->port->port_num,
+				      ureq.qpn ? IB_QPT_GSI : IB_QPT_SMI,
+				      &req, 0, send_handler, recv_handler,
+				      file);
+	if (IS_ERR(agent)) {
+		ret = PTR_ERR(agent);
+		goto out;
+	}
+
+	file->agent[agent_id] = agent;
+
+	file->mr[agent_id] = ib_get_dma_mr(agent->qp->pd, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(file->mr[agent_id])) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if (put_user(agent_id,
+		     (u32 __user *) (arg + offsetof(struct ib_user_mad_reg_req, id)))) {
+		ret = -EFAULT;
+		goto err_mr;
+	}
+
+	ret = 0;
+	goto out;
+
+err_mr:
+	ib_dereg_mr(file->mr[agent_id]);
+
+err:
+	file->agent[agent_id] = NULL;
+	ib_unregister_mad_agent(agent);
+
+out:
+	up_write(&file->agent_mutex);
+	return ret;
+}
+
+static int ib_umad_unreg_agent(struct ib_umad_file *file, unsigned long arg)
+{
+	u32 id;
+	int ret = 0;
+
+	down_write(&file->agent_mutex);
+
+	if (get_user(id, (u32 __user *) arg)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (id < 0 || id >= IB_UMAD_MAX_AGENTS || !file->agent[id]) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ib_dereg_mr(file->mr[id]);
+	ib_unregister_mad_agent(file->agent[id]);
+	file->agent[id] = NULL;
+
+out:
+	up_write(&file->agent_mutex);
+	return ret;
+}
+
+static int ib_umad_ioctl(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case IB_USER_MAD_GET_ABI_VERSION:
+		return put_user(IB_USER_MAD_ABI_VERSION,
+				(u32 __user *) arg) ? -EFAULT : 0;
+	case IB_USER_MAD_REGISTER_AGENT:
+		return ib_umad_reg_agent(filp->private_data, arg);
+	case IB_USER_MAD_UNREGISTER_AGENT:
+		return ib_umad_unreg_agent(filp->private_data, arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static int ib_umad_open(struct inode *inode, struct file *filp)
+{
+	struct ib_umad_port *port =
+		container_of(inode->i_cdev, struct ib_umad_port, dev);
+	struct ib_umad_file *file;
+
+	file = kmalloc(sizeof *file, GFP_KERNEL);
+	if (!file)
+		return -ENOMEM;
+
+	memset(file, 0, sizeof *file);
+
+	spin_lock_init(&file->recv_lock);
+	init_rwsem(&file->agent_mutex);
+	INIT_LIST_HEAD(&file->recv_list);
+	init_waitqueue_head(&file->recv_wait);
+
+	file->port = port;
+	filp->private_data = file;
+
+	return 0;
+}
+
+static int ib_umad_close(struct inode *inode, struct file *filp)
+{
+	struct ib_umad_file *file = filp->private_data;
+	int i;
+
+	for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
+		if (file->agent[i]) {
+			ib_dereg_mr(file->mr[i]);
+			ib_unregister_mad_agent(file->agent[i]);
+		}
+
+	kfree(file);
+
+	return 0;
+}
+
+static struct file_operations umad_fops = {
+	.owner 	 = THIS_MODULE,
+	.read 	 = ib_umad_read,
+	.write 	 = ib_umad_write,
+	.poll 	 = ib_umad_poll,
+	.ioctl 	 = ib_umad_ioctl,
+	.open 	 = ib_umad_open,
+	.release = ib_umad_close
+};
+
+static struct ib_client umad_client = {
+	.name   = "umad",
+	.add    = ib_umad_add_one,
+	.remove = ib_umad_remove_one
+};
+
+static ssize_t show_ibdev(struct class_device *class_dev, char *buf)
+{
+	struct ib_umad_port *port = class_get_devdata(class_dev);
+
+	return sprintf(buf, "%s\n", port->ib_dev->name);
+}
+static CLASS_DEVICE_ATTR(ibdev, S_IRUGO, show_ibdev, NULL);
+
+static ssize_t show_port(struct class_device *class_dev, char *buf)
+{
+	struct ib_umad_port *port = class_get_devdata(class_dev);
+
+	return sprintf(buf, "%d\n", port->port_num);
+}
+static CLASS_DEVICE_ATTR(port, S_IRUGO, show_port, NULL);
+
+static void ib_umad_add_one(struct ib_device *device)
+{
+	struct ib_umad_device *umad_dev;
+	int s, e, i;
+
+	if (device->node_type == IB_NODE_SWITCH)
+		s = e = 0;
+	else {
+		s = 1;
+		e = device->phys_port_cnt;
+	}
+
+	umad_dev = kmalloc(sizeof *umad_dev +
+			   (e - s + 1) * sizeof (struct ib_umad_port),
+			   GFP_KERNEL);
+	if (!umad_dev)
+		return;
+
+	umad_dev->start_port = s;
+	umad_dev->end_port   = e;
+
+	for (i = s; i <= e; ++i) {
+		spin_lock(&map_lock);
+		umad_dev->port[i - s].devnum =
+			find_first_zero_bit(dev_map, IB_UMAD_MAX_PORTS);
+		if (umad_dev->port[i - s].devnum >= IB_UMAD_MAX_PORTS) {
+			spin_unlock(&map_lock);
+			goto err;
+		}
+		set_bit(umad_dev->port[i - s].devnum, dev_map);
+		spin_unlock(&map_lock);
+
+		umad_dev->port[i - s].ib_dev   = device;
+		umad_dev->port[i - s].port_num = i;
+
+		memset(&umad_dev->port[i - s].dev, 0, sizeof (struct cdev));
+		cdev_init(&umad_dev->port[i - s].dev, &umad_fops);
+		umad_dev->port[i - s].dev.owner = THIS_MODULE;
+		kobject_set_name(&umad_dev->port[i - s].dev.kobj,
+				 "umad%d", umad_dev->port[i - s].devnum);
+		if (cdev_add(&umad_dev->port[i - s].dev, base_dev +
+			     umad_dev->port[i - s].devnum, 1))
+			goto err;
+
+		umad_dev->port[i - s].class_dev =
+			class_simple_device_add(umad_class,
+						umad_dev->port[i - s].dev.dev,
+						device->dma_device,
+						"umad%d", umad_dev->port[i - s].devnum);
+		if (IS_ERR(umad_dev->port[i - s].class_dev))
+			goto err_class;
+
+		class_set_devdata(umad_dev->port[i - s].class_dev,
+				  &umad_dev->port[i - s]);
+
+		if (class_device_create_file(umad_dev->port[i - s].class_dev,
+					     &class_device_attr_ibdev))
+			goto err_class;
+		if (class_device_create_file(umad_dev->port[i - s].class_dev,
+					     &class_device_attr_port))
+			goto err_class;
+	}
+
+	ib_set_client_data(device, &umad_client, umad_dev);
+
+	return;
+
+err_class:
+	cdev_del(&umad_dev->port[i - s].dev);
+	clear_bit(umad_dev->port[i - s].devnum, dev_map);
+
+err:
+	while (--i >= s) {
+		class_simple_device_remove(umad_dev->port[i - s].dev.dev);
+		cdev_del(&umad_dev->port[i - s].dev);
+		clear_bit(umad_dev->port[i - s].devnum, dev_map);
+	}
+
+	kfree(umad_dev);
+}
+
+static void ib_umad_remove_one(struct ib_device *device)
+{
+	struct ib_umad_device *umad_dev = ib_get_client_data(device, &umad_client);
+	int i;
+
+	if (!umad_dev)
+		return;
+
+	for (i = 0; i <= umad_dev->end_port - umad_dev->start_port; ++i) {
+		class_simple_device_remove(umad_dev->port[i].dev.dev);
+		cdev_del(&umad_dev->port[i].dev);
+		clear_bit(umad_dev->port[i].devnum, dev_map);
+	}
+
+	kfree(umad_dev);
+}
+
+static int __init ib_umad_init(void)
+{
+	int ret;
+
+	spin_lock_init(&map_lock);
+
+	ret = alloc_chrdev_region(&base_dev, 0, IB_UMAD_MAX_PORTS,
+				  "infiniband_mad");
+	if (ret) {
+		printk(KERN_ERR "user_mad: couldn't get device number\n");
+		goto out;
+	}
+
+	umad_class = class_simple_create(THIS_MODULE, "infiniband_mad");
+	if (IS_ERR(umad_class)) {
+		printk(KERN_ERR "user_mad: couldn't create class_simple\n");
+		ret = PTR_ERR(umad_class);
+		goto out_chrdev;
+	}
+
+	ret = ib_register_client(&umad_client);
+	if (ret) {
+		printk(KERN_ERR "user_mad: couldn't register ib_umad client\n");
+		goto out_class;
+	}
+		
+	return 0;
+
+out_class:
+	class_simple_destroy(umad_class);
+
+out_chrdev:
+	unregister_chrdev_region(base_dev, IB_UMAD_MAX_PORTS);
+
+out:
+	return ret;
+}
+
+static void __exit ib_umad_cleanup(void)
+{
+	ib_unregister_client(&umad_client);
+	class_simple_destroy(umad_class);
+	unregister_chrdev_region(base_dev, IB_UMAD_MAX_PORTS);
+}
+
+module_init(ib_umad_init);
+module_exit(ib_umad_cleanup);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/include/ib_user_mad.h	2004-11-23 08:10:23.724064267 -0800
@@ -0,0 +1,111 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id$
+ */
+
+#ifndef IB_USER_MAD_H
+#define IB_USER_MAD_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * Increment this value if any changes that break userspace ABI
+ * compatibility are made.
+ */
+#define IB_USER_MAD_ABI_VERSION	1
+
+/*
+ * Make sure that all structs defined in this file remain laid out so
+ * that they pack the same way on 32-bit and 64-bit architectures (to
+ * avoid incompatibility between 32-bit userspace and 64-bit kernels).
+ */
+
+/**
+ * ib_user_mad - MAD packet
+ * @data - Contents of MAD
+ * @id - ID of agent MAD received with/to be sent with
+ * @status - 0 on successful receive, ETIMEDOUT if no response
+ *   received (transaction ID in data[] will be set to TID of original
+ *   request) (ignored on send)
+ * @timeout_ms - Milliseconds to wait for response (unset on receive)
+ * @qpn - Remote QP number received from/to be sent to
+ * @qkey - Remote Q_Key to be sent with (unset on receive)
+ * @lid - Remote lid received from/to be sent to
+ * @sl - Service level received with/to be sent with
+ * @path_bits - Local path bits received with/to be sent with
+ * @grh_present - If set, GRH was received/should be sent
+ * @gid_index - Local GID index to send with (unset on receive)
+ * @hop_limit - Hop limit in GRH
+ * @traffic_class - Traffic class in GRH
+ * @gid - Remote GID in GRH
+ * @flow_label - Flow label in GRH
+ *
+ * All multi-byte quantities are stored in network (big endian) byte order.
+ */
+struct ib_user_mad {
+	__u8	data[256];
+	__u32	id;
+	__u32	status;
+	__u32	timeout_ms;
+	__u32	qpn;
+	__u32   qkey;
+	__u16	lid;
+	__u8	sl;
+	__u8	path_bits;
+	__u8	grh_present;
+	__u8	gid_index;
+	__u8	hop_limit;
+	__u8	traffic_class;
+	__u8	gid[16];
+	__u32	flow_label;
+};
+
+/**
+ * ib_user_mad_reg_req - MAD registration request
+ * @id - Set by the kernel; used to identify agent in future requests.
+ * @qpn - Queue pair number; must be 0 or 1.
+ * @method_mask - The caller will receive unsolicited MADs for any method
+ *   where @method_mask = 1.
+ * @mgmt_class - Indicates which management class of MADs should be receive
+ *   by the caller.  This field is only required if the user wishes to
+ *   receive unsolicited MADs, otherwise it should be 0.
+ * @mgmt_class_version - Indicates which version of MADs for the given
+ *   management class to receive.
+ */
+struct ib_user_mad_reg_req {
+	__u32	id;
+	__u32	method_mask[4];
+	__u8	qpn;
+	__u8	mgmt_class;
+	__u8	mgmt_class_version;
+};
+
+#define IB_IOCTL_MAGIC		0x1b
+
+#define IB_USER_MAD_GET_ABI_VERSION	_IOR(IB_IOCTL_MAGIC, 0, __u32)
+
+#define IB_USER_MAD_REGISTER_AGENT	_IOWR(IB_IOCTL_MAGIC, 1, \
+					      struct ib_user_mad_reg_req)
+
+#define IB_USER_MAD_UNREGISTER_AGENT	_IOW(IB_IOCTL_MAGIC, 2, __u32)
+
+#endif /* IB_USER_MAD_H */

