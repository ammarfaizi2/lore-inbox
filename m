Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVALVT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVALVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVALVCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:02:12 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:32191 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261391AbVALUyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:54:20 -0500
Date: Thu, 13 Jan 2005 00:16:11 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: johnpol@2ka.mipt.ru
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel conector. Reincarnation #1.
Message-ID: <20050113001611.0a5d8bf8@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050112233345.6de409d0@zanzibar.2ka.mipt.ru>
References: <1101286481.18807.66.camel@uganda>
	<1101287606.18807.75.camel@uganda>
	<20041124222857.GG3584@kroah.com>
	<1102504677.3363.55.camel@uganda>
	<20041221204101.GA9831@kroah.com>
	<1103707272.3432.6.camel@uganda>
	<20050112190319.GA10885@kroah.com>
	<20050112233345.6de409d0@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forget about nasty typo.
Current one is right.

diff -Nru /tmp/empty/Kconfig linux-2.6.9/drivers/connector/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.9/drivers/connector/Kconfig	2005-01-12 23:28:25.000000000 +0300
@@ -0,0 +1,13 @@
+menu "Connector - unified userspace <-> kernelspace linker"
+
+config CONNECTOR
+	tristate "Connector - unified userspace <-> kernelspace linker"
+	depends on NET
+	---help---
+	  This is unified userspace <-> kernelspace connector working on top
+	  of the netlink socket protocol.
+
+	  Connector support can also be built as a module.  If so, the module
+	  will be called cn.ko.
+
+endmenu
diff -Nru /tmp/empty/Makefile linux-2.6.9/drivers/connector/Makefile
--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.9/drivers/connector/Makefile	2005-01-12 23:26:36.000000000 +0300
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CONNECTOR)		+= cn.o
+cn-objs		:= cn_queue.o connector.o
diff -Nru /tmp/empty/cn_queue.c linux-2.6.9/drivers/connector/cn_queue.c
--- /tmp/empty/cn_queue.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.9/drivers/connector/cn_queue.c	2005-01-12 23:23:45.000000000 +0300
@@ -0,0 +1,224 @@
+/*
+ * 	cn_queue.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/suspend.h>
+#include <linux/connector.h>
+
+static void cn_queue_wrapper(void *data)
+{
+	struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
+
+	atomic_inc(&cbq->cb->refcnt);
+	cbq->cb->callback(cbq->cb->priv);
+	atomic_dec(&cbq->cb->refcnt);
+
+	cbq->destruct_data(cbq->ddata);
+}
+
+static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct
+							       cn_callback *cb)
+{
+	struct cn_callback_entry *cbq;
+
+	cbq = kmalloc(sizeof(*cbq), GFP_KERNEL);
+	if (!cbq) {
+		printk(KERN_ERR "Failed to create new callback queue.\n");
+		return NULL;
+	}
+
+	memset(cbq, 0, sizeof(*cbq));
+
+	cbq->cb = cb;
+
+	INIT_WORK(&cbq->work, &cn_queue_wrapper, cbq);
+
+	return cbq;
+}
+
+static void cn_queue_free_callback(struct cn_callback_entry *cbq)
+{
+	cancel_delayed_work(&cbq->work);
+
+	while (atomic_read(&cbq->cb->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+	kfree(cbq);
+}
+
+int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
+{
+#if 0
+	printk(KERN_INFO "%s: comparing %04x.%04x and %04x.%04x\n",
+			__func__,
+			i1->idx, i1->val,
+			i2->idx, i2->val);
+#endif
+	return ((i1->idx == i2->idx) && (i1->val == i2->val));
+}
+
+int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
+{
+	struct cn_callback_entry *cbq, *n, *__cbq;
+	int found = 0;
+
+	cbq = cn_queue_alloc_callback_entry(cb);
+	if (!cbq)
+		return -ENOMEM;
+
+	atomic_inc(&dev->refcnt);
+	cbq->pdev = dev;
+
+	spin_lock_bh(&dev->queue_lock);
+	list_for_each_entry_safe(__cbq, n, &dev->queue_list, callback_entry) {
+		if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		atomic_set(&cbq->cb->refcnt, 1);
+		list_add_tail(&cbq->callback_entry, &dev->queue_list);
+	}
+	spin_unlock_bh(&dev->queue_lock);
+
+	if (found) {
+		atomic_dec(&dev->refcnt);
+		atomic_set(&cbq->cb->refcnt, 0);
+		cn_queue_free_callback(cbq);
+		return -EINVAL;
+	}
+
+	cbq->nls = dev->nls;
+	cbq->seq = 0;
+	//cbq->group = ++dev->netlink_groups;
+	cbq->group = cbq->cb->id.idx;
+
+	return 0;
+}
+
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
+{
+	struct cn_callback_entry *cbq = NULL, *n;
+	int found = 0;
+
+	spin_lock_bh(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		if (cn_cb_equal(&cbq->cb->id, &cb->id)) {
+			list_del(&cbq->callback_entry);
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock_bh(&dev->queue_lock);
+
+	if (found) {
+		atomic_dec(&cbq->cb->refcnt);
+		cn_queue_free_callback(cbq);
+		atomic_dec(&dev->refcnt);
+	}
+}
+
+struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *nls)
+{
+	struct cn_queue_dev *dev;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR "%s: Failed to allocte new struct cn_queue_dev.\n",
+		       name);
+		return NULL;
+	}
+
+	memset(dev, 0, sizeof(*dev));
+
+	snprintf(dev->name, sizeof(dev->name), "%s", name);
+
+	atomic_set(&dev->refcnt, 0);
+	INIT_LIST_HEAD(&dev->queue_list);
+	spin_lock_init(&dev->queue_lock);
+
+	dev->nls = nls;
+	dev->netlink_groups = 0;
+
+	dev->cn_queue = create_workqueue(dev->name);
+	if (!dev->cn_queue) {
+		printk(KERN_ERR "Failed to create %s queue.\n", dev->name);
+		kfree(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+void cn_queue_free_dev(struct cn_queue_dev *dev)
+{
+	struct cn_callback_entry *cbq, *n;
+
+	flush_workqueue(dev->cn_queue);
+	destroy_workqueue(dev->cn_queue);
+
+	spin_lock_bh(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		list_del(&cbq->callback_entry);
+		atomic_dec(&cbq->cb->refcnt);
+	}
+	spin_unlock_bh(&dev->queue_lock);
+
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+		       dev->name, atomic_read(&dev->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+	memset(dev, 0, sizeof(*dev));
+	kfree(dev);
+	dev = NULL;
+}
+
+EXPORT_SYMBOL(cn_queue_add_callback);
+EXPORT_SYMBOL(cn_queue_del_callback);
+EXPORT_SYMBOL(cn_queue_alloc_dev);
+EXPORT_SYMBOL(cn_queue_free_dev);
diff -Nru /tmp/empty/connector.c linux-2.6.9/drivers/connector/connector.c
--- /tmp/empty/connector.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6.9/drivers/connector/connector.c	2005-01-12 23:23:45.000000000 +0300
@@ -0,0 +1,496 @@
+/*
+ * 	connector.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/moduleparam.h>
+#include <linux/connector.h>
+
+#include <net/sock.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Generic userspace <-> kernelspace connector.");
+
+static int unit = NETLINK_NFLOG;
+static u32 cn_idx = -1;
+static u32 cn_val = -1;
+
+module_param(unit, int, 0);
+module_param(cn_idx, uint, 0);
+module_param(cn_val, uint, 0);
+
+spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(notify_list);
+
+static struct cn_dev cdev;
+
+/*
+ * msg->seq and msg->ack are used to determine message genealogy.
+ * When someone sends message it puts there locally unique sequence 
+ * and random acknowledge numbers.
+ * Sequence number may be copied into nlmsghdr->nlmsg_seq too.
+ *
+ * Sequence number is incremented with each message to be sent.
+ *
+ * If we expect reply to our message, 
+ * then sequence number in received message MUST be the same as in original message,
+ * and acknowledge number MUST be the same + 1.
+ *
+ * If we receive message and it's sequence number is not equal to one we are expecting, 
+ * then it is new message.
+ * If we receive message and it's sequence number is the same as one we are expecting,
+ * but it's acknowledge is not equal acknowledge number in original message + 1,
+ * then it is new message.
+ *
+ */
+void cn_netlink_send(struct cn_msg *msg, u32 __groups)
+{
+	struct cn_callback_entry *n, *__cbq;
+	unsigned int size;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	struct cn_msg *data;
+	struct cn_dev *dev = &cdev;
+	u32 groups = 0;
+	int found = 0;
+
+	if (!__groups)
+	{
+		spin_lock_bh(&dev->cbdev->queue_lock);
+		list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+			if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
+				found = 1;
+				groups = __cbq->group;
+			}
+		}
+		spin_unlock_bh(&dev->cbdev->queue_lock);
+
+		if (!found) {
+			printk(KERN_ERR "Failed to find multicast netlink group for callback[0x%x.0x%x]. seq=%u\n",
+			       msg->id.idx, msg->id.val, msg->seq);
+			return;
+		}
+	}
+	else
+		groups = __groups;
+
+	size = NLMSG_SPACE(sizeof(*msg) + msg->len);
+
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb) {
+		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
+		return;
+	}
+
+	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
+
+	data = (struct cn_msg *)NLMSG_DATA(nlh);
+
+	memcpy(data, msg, sizeof(*data) + msg->len);
+#if 0
+	printk("%s: len=%u, seq=%u, ack=%u, group=%u.\n",
+	       __func__, msg->len, msg->seq, msg->ack, groups);
+#endif
+	NETLINK_CB(skb).dst_groups = groups;
+	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
+
+	return;
+
+      nlmsg_failure:
+	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
+	kfree_skb(skb);
+	return;
+}
+
+static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)
+{
+	struct cn_callback_entry *n, *__cbq;
+	struct cn_dev *dev = &cdev;
+	int found = 0;
+
+	spin_lock_bh(&dev->cbdev->queue_lock);
+	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+		if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
+			__cbq->cb->priv = msg;
+
+			__cbq->ddata = data;
+			__cbq->destruct_data = destruct_data;
+
+			queue_work(dev->cbdev->cn_queue, &__cbq->work);
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock_bh(&dev->cbdev->queue_lock);
+
+	return found;
+}
+
+static int __cn_rx_skb(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	u32 pid, uid, seq, group;
+	struct cn_msg *msg;
+
+	pid = NETLINK_CREDS(skb)->pid;
+	uid = NETLINK_CREDS(skb)->uid;
+	seq = nlh->nlmsg_seq;
+	group = NETLINK_CB((skb)).groups;
+	msg = (struct cn_msg *)NLMSG_DATA(nlh);
+
+	if (msg->len != nlh->nlmsg_len - sizeof(*msg) - sizeof(*nlh)) {
+		printk(KERN_ERR "skb does not have enough length: "
+				"requested msg->len=%u[%u], nlh->nlmsg_len=%u[%u], skb->len=%u[must be %u].\n", 
+				msg->len, NLMSG_SPACE(msg->len), 
+				nlh->nlmsg_len, nlh->nlmsg_len - sizeof(*nlh),
+				skb->len, msg->len + sizeof(*msg));
+		return -EINVAL;
+	}
+#if 0
+	printk(KERN_INFO "pid=%u, uid=%u, seq=%u, group=%u.\n",
+	       pid, uid, seq, group);
+#endif
+	return cn_call_callback(msg, (void (*)(void *))kfree_skb, skb);
+}
+
+static void cn_rx_skb(struct sk_buff *__skb)
+{
+	struct nlmsghdr *nlh;
+	u32 len;
+	int err;
+	struct sk_buff *skb;
+
+	skb = skb_get(__skb);
+	if (!skb) {
+		printk(KERN_ERR "Failed to reference an skb.\n");
+		return;
+	}
+#if 0
+	printk(KERN_INFO
+	       "skb: len=%u, data_len=%u, truesize=%u, proto=%u, cloned=%d, shared=%d.\n",
+	       skb->len, skb->data_len, skb->truesize, skb->protocol,
+	       skb_cloned(skb), skb_shared(skb));
+#endif
+	while (skb->len >= NLMSG_SPACE(0)) {
+		nlh = (struct nlmsghdr *)skb->data;
+		if (nlh->nlmsg_len < sizeof(struct cn_msg) ||
+		    skb->len < nlh->nlmsg_len ||
+		    nlh->nlmsg_len > CONNECTOR_MAX_MSG_SIZE) {
+			printk(KERN_INFO "nlmsg_len=%u, sizeof(*nlh)=%u\n",
+			       nlh->nlmsg_len, sizeof(*nlh));
+			break;
+		}
+
+		len = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (len > skb->len)
+			len = skb->len;
+
+		err = __cn_rx_skb(skb, nlh);
+		if (err) {
+#if 0
+			if (err < 0 && (nlh->nlmsg_flags & NLM_F_ACK))
+				netlink_ack(skb, nlh, -err);
+#endif
+			kfree_skb(skb);
+			break;
+		} else {
+#if 0
+			if (nlh->nlmsg_flags & NLM_F_ACK)
+				netlink_ack(skb, nlh, 0);
+#endif
+			kfree_skb(skb);
+			break;
+		}
+		skb_pull(skb, len);
+	}
+}
+
+static void cn_input(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL)
+		cn_rx_skb(skb);
+}
+
+static void cn_notify(struct cb_id *id, u32 notify_event)
+{
+	struct cn_ctl_entry *ent;
+
+	spin_lock_bh(&notify_lock);
+	list_for_each_entry(ent, &notify_list, notify_entry) {
+		int i;
+		struct cn_notify_req *req;
+		struct cn_ctl_msg *ctl = ent->msg;
+		int a, b;
+
+		a = b = 0;
+		
+		req = (struct cn_notify_req *)ctl->data;
+		for (i=0; i<ctl->idx_notify_num; ++i, ++req) {
+			if (id->idx >= req->first && id->idx < req->first + req->range) {
+				a = 1;
+				break;
+			}
+		}
+		
+		for (i=0; i<ctl->val_notify_num; ++i, ++req) {
+			if (id->val >= req->first && id->val < req->first + req->range) {
+				b = 1;
+				break;
+			}
+		}
+
+		if (a && b) {
+			struct cn_msg m;
+			
+			printk(KERN_INFO "Notifying group %x with event %u about %x.%x.\n", 
+					ctl->group, notify_event, 
+					id->idx, id->val);
+
+			memset(&m, 0, sizeof(m));
+			m.ack = notify_event;
+
+			memcpy(&m.id, id, sizeof(m.id));
+			cn_netlink_send(&m, ctl->group);
+		}
+	}
+	spin_unlock_bh(&notify_lock);
+}
+
+int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *))
+{
+	int err;
+	struct cn_dev *dev = &cdev;
+	struct cn_callback *cb;
+
+	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb) {
+		printk(KERN_INFO "%s: Failed to allocate new struct cn_callback.\n",
+		       dev->cbdev->name);
+		return -ENOMEM;
+	}
+
+	memset(cb, 0, sizeof(*cb));
+
+	snprintf(cb->name, sizeof(cb->name), "%s", name);
+
+	memcpy(&cb->id, id, sizeof(cb->id));
+	cb->callback = callback;
+
+	atomic_set(&cb->refcnt, 0);
+
+	err = cn_queue_add_callback(dev->cbdev, cb);
+	if (err) {
+		kfree(cb);
+		return err;
+	}
+			
+	cn_notify(id, 0);
+
+	return 0;
+}
+
+void cn_del_callback(struct cb_id *id)
+{
+	struct cn_dev *dev = &cdev;
+	struct cn_callback_entry *n, *__cbq;
+
+	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+		if (cn_cb_equal(&__cbq->cb->id, id)) {
+			cn_queue_del_callback(dev->cbdev, __cbq->cb);
+			cn_notify(id, 1);
+			break;
+		}
+	}
+}
+
+static int cn_ctl_msg_equals(struct cn_ctl_msg *m1, struct cn_ctl_msg *m2)
+{
+	int i;
+	struct cn_notify_req *req1, *req2;
+
+	if (m1->idx_notify_num != m2->idx_notify_num)
+		return 0;
+	
+	if (m1->val_notify_num != m2->val_notify_num)
+		return 0;
+	
+	if (m1->len != m2->len)
+		return 0;
+
+	if ((m1->idx_notify_num + m1->val_notify_num)*sizeof(*req1) != m1->len) {
+		printk(KERN_ERR "Notify entry[idx_num=%x, val_num=%x, len=%u] contains garbage. Removing.\n", 
+				m1->idx_notify_num, m1->val_notify_num, m1->len);
+		return 1;
+	}
+
+	req1 = (struct cn_notify_req *)m1->data;
+	req2 = (struct cn_notify_req *)m2->data;
+	
+	for (i=0; i<m1->idx_notify_num; ++i) {
+		if (memcmp(req1, req2, sizeof(*req1)))
+			return 0;
+
+		req1++;
+		req2++;
+	}
+
+	for (i=0; i<m1->val_notify_num; ++i) {
+		if (memcmp(req1, req2, sizeof(*req1)))
+			return 0;
+
+		req1++;
+		req2++;
+	}
+
+	return 1;
+}
+
+static void cn_callback(void * data)
+{
+	struct cn_msg *msg = (struct cn_msg *)data;
+	struct cn_ctl_msg *ctl;
+	struct cn_ctl_entry *ent;
+	u32 size;
+ 
+	if (msg->len < sizeof(*ctl)) {
+		printk(KERN_ERR "Wrong connector request size %u, must be >= %u.\n", 
+				msg->len, sizeof(*ctl));
+		return;
+	}
+	
+	ctl = (struct cn_ctl_msg *)msg->data;
+
+	size = sizeof(*ctl) + (ctl->idx_notify_num + ctl->val_notify_num)*sizeof(struct cn_notify_req);
+
+	if (msg->len != size) {
+		printk(KERN_ERR "Wrong connector request size %u, must be == %u.\n", 
+				msg->len, size);
+		return;
+	}
+
+	if (ctl->len + sizeof(*ctl) != msg->len) {
+		printk(KERN_ERR "Wrong message: msg->len=%u must be equal to inner_len=%u [+%u].\n", 
+				msg->len, ctl->len, sizeof(*ctl));
+		return;
+	}
+
+	/*
+	 * Remove notification.
+	 */
+	if (ctl->group == 0) {
+		struct cn_ctl_entry *n;
+		
+		spin_lock_bh(&notify_lock);
+		list_for_each_entry_safe(ent, n, &notify_list, notify_entry) {
+			if (cn_ctl_msg_equals(ent->msg, ctl)) {
+				list_del(&ent->notify_entry);
+				kfree(ent);
+			}
+		}
+		spin_unlock_bh(&notify_lock);
+
+		return;
+	}
+
+	size += sizeof(*ent);
+
+	ent = kmalloc(size, GFP_ATOMIC);
+	if (!ent) {
+		printk(KERN_ERR "Failed to allocate %d bytes for new notify entry.\n", size);
+		return;
+	}
+
+	memset(ent, 0, size);
+
+	ent->msg = (struct cn_ctl_msg *)(ent + 1);
+
+	memcpy(ent->msg, ctl, size - sizeof(*ent));
+
+	spin_lock_bh(&notify_lock);
+	list_add(&ent->notify_entry, &notify_list);
+	spin_unlock_bh(&notify_lock);
+
+	{
+		int i;
+		struct cn_notify_req *req;
+	
+		printk("Notify group %x for idx: ", ctl->group);
+
+		req = (struct cn_notify_req *)ctl->data;
+		for (i=0; i<ctl->idx_notify_num; ++i, ++req) {
+			printk("%u-%u ", req->first, req->first+req->range-1);
+		}
+		
+		printk("\nNotify group %x for val: ", ctl->group);
+
+		for (i=0; i<ctl->val_notify_num; ++i, ++req) {
+			printk("%u-%u ", req->first, req->first+req->range-1);
+		}
+		printk("\n");
+	}
+}
+
+static int cn_init(void)
+{
+	struct cn_dev *dev = &cdev;
+
+	dev->input = cn_input;
+	dev->id.idx = cn_idx;
+	dev->id.val = cn_val;
+
+	dev->nls = netlink_kernel_create(unit, dev->input);
+	if (!dev->nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u).\n",
+		       unit);
+		return -EIO;
+	}
+
+	dev->cbdev = cn_queue_alloc_dev("cqueue", dev->nls);
+	if (!dev->cbdev) {
+		if (dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return -EINVAL;
+	}
+
+	return cn_add_callback(&dev->id, "connector", &cn_callback);
+}
+
+static void cn_fini(void)
+{
+	struct cn_dev *dev = &cdev;
+
+	cn_del_callback(&dev->id);
+	cn_queue_free_dev(dev->cbdev);
+	if (dev->nls->sk_socket)
+		sock_release(dev->nls->sk_socket);
+}
+
+module_init(cn_init);
+module_exit(cn_fini);
+
+EXPORT_SYMBOL(cn_add_callback);
+EXPORT_SYMBOL(cn_del_callback);
+EXPORT_SYMBOL(cn_netlink_send);
--- /dev/null	2004-09-17 14:58:06.000000000 +0400
+++ linux-2.6.9/include/linux/connector.h	2005-01-12 23:23:55.000000000 +0300
@@ -0,0 +1,142 @@
+/*
+ * 	connector.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __CONNECTOR_H
+#define __CONNECTOR_H
+
+#include <asm/types.h>
+
+#define CONNECTOR_MAX_MSG_SIZE 	1024
+
+struct cb_id
+{
+	__u32			idx;
+	__u32			val;
+};
+
+struct cn_msg
+{
+	struct cb_id 		id;
+
+	__u32			seq;
+	__u32			ack;
+
+	__u32			len;		/* Length of the following data */
+	__u8			data[0];
+};
+
+struct cn_notify_req
+{
+	__u32			first;
+	__u32			range;
+};
+
+struct cn_ctl_msg
+{
+	__u32			idx_notify_num;
+	__u32			val_notify_num;
+	__u32			group;
+	__u32			len;
+	__u8			data[0];
+};
+
+
+#ifdef __KERNEL__
+
+#include <asm/atomic.h>
+
+#include <linux/list.h>
+#include <linux/workqueue.h>
+
+#include <net/sock.h>
+
+#define CN_CBQ_NAMELEN		32
+
+struct cn_queue_dev
+{
+	atomic_t		refcnt;
+	unsigned char		name[CN_CBQ_NAMELEN];
+
+	struct workqueue_struct	*cn_queue;
+	
+	struct list_head 	queue_list;
+	spinlock_t 		queue_lock;
+
+	int			netlink_groups;
+	struct sock		*nls;
+};
+
+struct cn_callback
+{
+	unsigned char		name[CN_CBQ_NAMELEN];
+	
+	struct cb_id		id;
+	void			(* callback)(void *);
+	void			*priv;
+	
+	atomic_t		refcnt;
+};
+
+struct cn_callback_entry
+{
+	struct list_head	callback_entry;
+	struct cn_callback	*cb;
+	struct work_struct	work;
+	struct cn_queue_dev	*pdev;
+	
+	void			(* destruct_data)(void *);
+	void			*ddata;
+
+	int			seq, group;
+	struct sock		*nls;
+};
+
+struct cn_ctl_entry
+{
+	struct list_head	notify_entry;
+	struct cn_ctl_msg	*msg;
+};
+
+struct cn_dev
+{
+	struct cb_id 		id;
+
+	u32			seq, groups;
+	struct sock 		*nls;
+	void 			(*input)(struct sock *sk, int len);
+
+	struct cn_queue_dev	*cbdev;
+};
+
+int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
+void cn_del_callback(struct cb_id *);
+void cn_netlink_send(struct cn_msg *, u32);
+
+int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+
+struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *);
+void cn_queue_free_dev(struct cn_queue_dev *dev);
+
+int cn_cb_equal(struct cb_id *, struct cb_id *);
+
+#endif /* __KERNEL__ */
+#endif /* __CONNECTOR_H */
--- linux-2.6.9/drivers/Kconfig.orig	2005-01-08 17:22:53.000000000 +0300
+++ linux-2.6.9/drivers/Kconfig	2005-01-12 23:25:49.000000000 +0300
@@ -4,6 +4,8 @@
 
 source "drivers/base/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "drivers/mtd/Kconfig"
 
 source "drivers/parport/Kconfig"
--- linux-2.6.9/drivers/Makefile.orig	2005-01-08 17:22:44.000000000 +0300
+++ linux-2.6.9/drivers/Makefile	2005-01-12 23:25:28.000000000 +0300
@@ -17,6 +17,8 @@
 # default.
 obj-y				+= char/
 
+obj-$(CONFIG_CONNECTOR)	+= connector/
+
 # i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           += video/i810/
 obj-$(CONFIG_FB_INTEL)          += video/intelfb/


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
