Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUIUMnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUIUMnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUIUMnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:43:22 -0400
Received: from dea.vocord.ru ([217.67.177.50]:44199 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S267633AbUIUMl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:41:29 -0400
Date: Tue, 21 Sep 2004 16:46:23 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Kernel connector - userspace <-> kernelspace "linker".
Message-ID: <20040921124623.GA6942@uganda.factory.vocord.ru>
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <1095331899.18219.58.camel@uganda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1095331899.18219.58.camel@uganda>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Connector driver adds possibility to connect various agents using
netlink based network.
One must register callback and identificator. When driver receives
special netlink message with appropriate identificator, appropriate
callback will be called.

>From the userspace point of view it's quite straightforward:
socket();
bind();
send();
recv();

But if kernespace want to use full power of such connections, driver 
writer must create special sockets, must know about struct skbuff 
handling...
Following driver allows any kernelspace agents to use netlink based 
networking for inter-process communication in a significantly easier 
way:

register_callback(id, callback_function);
nc_connector_send();

where id is currently to 32bit values which can be considered as
name + id.

Current driver offers just transport layer but with fixed header.
Recommended protocol using such header is following:

msg->seq and msg->ack are used to determine message genealogy.
When someone sends message it puts there locally unique sequence 
and random acknowledge numbers.
Sequence number may be copied into nlmsghdr->nlmsg_seq too.

Sequence number is incremented with each message to be sent.

If we expect reply to our message, then sequence number in received 
message MUST be the same as in original message, and acknowledge 
number MUST be the same + 1.

If we receive message and it's sequence number is not equal to one 
we are expecting, then it is new message.
If we receive message and it's sequence number is the same as one we 
are expecting, but it's acknowledge is not equal acknowledge number 
in original message + 1, then it is new message.

Obviously, protocol header contains above id.

As a bonus, suggested by Jamal Hadi Salim in netdev@ maillist, 
connector driver allows event notification in the following form:
kernel driver or userspace process can ask connector to notify it 
when selected id's will be turned on or off(registered or unregistered 
it's callback). It is done by sending special command to connector 
driver(it also registers itself with id={-1, -1}).

Created schema contains large reserve for different future extensions.

Attached cn_test.c - it is a module that registers itself with connector 
cruft. It's sending function is quite ugly, but it was created only for 
testing. Real users do not need to use netlink sockets directly, but with 
help of cn_connector_send(). Please see connector.c itself
and it's cn_notify() call.
ucon.c - simple userspace utility that uses netlink sockets to read/write 
GPIO pin values from SuperIO subsystem in general and PC8746x chip/GPIO 
logical device in particular. SuperIO driver depends on connector and 
implements it's own protocol over connector's one. It will not be sent 
into linux-kernel@, but into LM Sensors <sensors@Stimpy.netroedge.com> 
mail list (actually it was sent several times during development cycle).

Please review, comment and apply to -mm for testing.

P.S. I'm not subscribed to linux-kernel@ mail list, so please CC: me in
your answers.

P.P.S. I believe this patch definitely can easily pass through anyone's coding 
style yuck-o-meter at one dash, even through Greg KH.

-- 
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- linux-2.6/drivers/Makefile.orig	2004-09-12 01:14:07.000000000 +0400
+++ linux-2.6/drivers/Makefile	2004-09-11 22:49:32.000000000 +0400
@@ -43,6 +43,7 @@
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_CONNECTOR)		+= connector/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/

--- linux-2.6/drivers/Kconfig	2004-09-21 13:56:46.000000000 +0400
+++ linux-2.6/drivers/Kconfig.orig	2004-09-21 13:55:18.000000000 +0400
@@ -44,6 +44,8 @@
 
 source "drivers/w1/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"

diff -Nru /tmp/empty/Kconfig linux-2.6/drivers/connector/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/Kconfig	2004-09-09 08:43:37.000000000 +0400
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
+	  will be called connector.ko.
+
+endmenu
diff -Nru /tmp/empty/Makefile linux-2.6/drivers/connector/Makefile
--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/Makefile	2004-09-10 08:59:26.000000000 +0400
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CONNECTOR)		+= cn.o
+cn-objs		:= cn_queue.o connector.o
diff -Nru /tmp/empty/cn_queue.c linux-2.6/drivers/connector/cn_queue.c
--- /tmp/empty/cn_queue.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/cn_queue.c	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,218 @@
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
+
+#include "cn_queue.h"
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
+		printk(KERN_INFO "Waiting %s to became free: refcnt=%d.\n",
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
+	spin_lock(&dev->queue_lock);
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
+	spin_unlock(&dev->queue_lock);
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
+	cbq->group = ++dev->netlink_groups;
+
+	return 0;
+}
+
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
+{
+	struct cn_callback_entry *cbq = NULL, *n;
+	int found = 0;
+
+	spin_lock(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		if (cn_cb_equal(&cbq->cb->id, &cb->id)) {
+			list_del(&cbq->callback_entry);
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock(&dev->queue_lock);
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
+	spin_lock(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		list_del(&cbq->callback_entry);
+		atomic_dec(&cbq->cb->refcnt);
+	}
+	spin_unlock(&dev->queue_lock);
+
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting %s to became free: refcnt=%d.\n",
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
diff -Nru /tmp/empty/cn_queue.h linux-2.6/drivers/connector/cn_queue.h
--- /tmp/empty/cn_queue.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/cn_queue.h	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,90 @@
+/*
+ * 	cn_queue.h
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
+#ifndef __CN_QUEUE_H
+#define __CN_QUEUE_H
+
+#include <asm/types.h>
+
+struct cb_id
+{
+	__u32			idx;
+	__u32			val;
+};
+
+#ifdef __KERNEL__
+
+#include <asm/atomic.h>
+
+#include <linux/list.h>
+#include <linux/workqueue.h>
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
+int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+
+struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *);
+void cn_queue_free_dev(struct cn_queue_dev *dev);
+
+int cn_cb_equal(struct cb_id *, struct cb_id *);
+
+#endif /* __KERNEL__ */
+#endif /* __CN_QUEUE_H */
diff -Nru /tmp/empty/cn_test.c linux-2.6/drivers/connector/cn_test.c
--- /tmp/empty/cn_test.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/cn_test.c	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,160 @@
+/*
+ * 	cn_test.c
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
+#include <linux/moduleparam.h>
+#include <linux/skbuff.h>
+
+#include "connector.h"
+
+static struct cb_id cn_test_id = { 0x123, 0x456 };
+static char cn_test_name[] = "cn_test";
+static struct sock *nls;
+
+void cn_test_callback(void *data)
+{
+	struct cn_msg *msg = (struct cn_msg *)data;
+
+	printk("%s: idx=%x, val=%x, len=%d.\n",
+	       __func__, msg->id.idx, msg->id.val, msg->len);
+}
+
+static int cn_test_want_notify(void)
+{
+	struct cn_ctl_msg *ctl;
+	struct cn_notify_req *req;
+	struct cn_msg *msg = NULL;
+	int size, size0;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	u32 group = 1;
+
+	size0 = sizeof(*msg) + sizeof(*ctl) + 3*sizeof(*req);
+	
+	size = NLMSG_SPACE(size0);
+
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb) {
+		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
+
+		return -ENOMEM;
+	}
+
+	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - sizeof(*nlh));
+
+	msg = (struct cn_msg *)NLMSG_DATA(nlh);
+
+	memset(msg, 0, size0);
+
+	msg->id.idx 	= -1;
+	msg->id.val 	= -1;
+	msg->seq 	= 0x123;
+	msg->ack 	= 0x345;
+	msg->len 	= size0 - sizeof(*msg);
+
+	ctl = (struct cn_ctl_msg *)(msg + 1);
+
+	ctl->idx_notify_num 	= 1;
+	ctl->val_notify_num 	= 2;
+	ctl->group		= group;
+	ctl->len		= msg->len - sizeof(*ctl);
+
+	req = (struct cn_notify_req *)(ctl + 1);
+
+	/*
+	 * Idx.
+	 */
+	req->first = cn_test_id.idx;
+	req->range = 10;
+
+	/*
+	 * Val 0.
+	 */
+	req++;
+	req->first = cn_test_id.val;
+	req->range = 10;
+	
+	/*
+	 * Val 1.
+	 */
+	req++;
+	req->first = cn_test_id.val + 20;
+	req->range = 10;
+	
+	NETLINK_CB(skb).dst_groups = ctl->group;
+	//netlink_broadcast(nls, skb, 0, ctl->group, GFP_ATOMIC);
+	netlink_unicast(nls, skb, 0, 0);
+
+	printk(KERN_INFO "Request was sent. Group=0x%x.\n", group);
+		
+	return 0;
+
+nlmsg_failure:
+	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static int cn_test_init(void)
+{
+	int err;
+	
+	nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
+	if (!nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u).\n", NETLINK_NFLOG);
+		return -EIO;
+	}
+
+	err = cn_test_want_notify();
+	if (err)
+		goto err_out;
+
+	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
+	if (err)
+		goto err_out;
+	cn_test_id.val++;
+	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
+	if (err) {
+		cn_del_callback(&cn_test_id);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	if (nls->sk_socket)
+		sock_release(nls->sk_socket);
+
+	return err;
+}
+
+static void cn_test_fini(void)
+{
+	cn_del_callback(&cn_test_id);
+	cn_test_id.val--;
+	cn_del_callback(&cn_test_id);
+	if (nls->sk_socket)
+		sock_release(nls->sk_socket);
+}
+
+module_init(cn_test_init);
+module_exit(cn_test_fini);
diff -Nru /tmp/empty/connector.c linux-2.6/drivers/connector/connector.c
--- /tmp/empty/connector.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/connector.c	2004-09-21 13:38:57.000000000 +0400
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
+
+#include <net/sock.h>
+
+#include "../connector/connector.h"
+#include "../connector/cn_queue.h"
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
+		spin_lock(&dev->cbdev->queue_lock);
+		list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+			if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
+				found = 1;
+				groups = __cbq->group;
+			}
+		}
+		spin_unlock(&dev->cbdev->queue_lock);
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
+	spin_lock(&dev->cbdev->queue_lock);
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
+	spin_unlock(&dev->cbdev->queue_lock);
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
+			if (err < 0 && (nlh->nlmsg_flags & NLM_F_ACK))
+				netlink_ack(skb, nlh, -err);
+			kfree_skb(skb);
+			break;
+		} else {
+			if (nlh->nlmsg_flags & NLM_F_ACK)
+				netlink_ack(skb, nlh, 0);
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
+	spin_lock(&notify_lock);
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
+	spin_unlock(&notify_lock);
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
+		spin_lock(&notify_lock);
+		list_for_each_entry_safe(ent, n, &notify_list, notify_entry) {
+			if (cn_ctl_msg_equals(ent->msg, ctl)) {
+				list_del(&ent->notify_entry);
+				kfree(ent);
+			}
+		}
+		spin_unlock(&notify_lock);
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
+	spin_lock(&notify_lock);
+	list_add(&ent->notify_entry, &notify_list);
+	spin_unlock(&notify_lock);
+
+	{
+		int i;
+		struct cn_notify_req *req;
+	
+		printk("Notify group %x for idx: ", ctl->group);
+
+		req = (struct cn_notify_req *)ctl->data;
+		for (i=0; i<ctl->idx_notify_num; ++i, ++req)
+		{
+			printk("%u-%u ", req->first, req->first+req->range-1);
+		}
+		
+		printk("\nNotify group %x for val: ", ctl->group);
+
+		for (i=0; i<ctl->val_notify_num; ++i, ++req)
+		{
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
diff -Nru /tmp/empty/connector.h linux-2.6/drivers/connector/connector.h
--- /tmp/empty/connector.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/connector.h	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,81 @@
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
+#include "../connector/cn_queue.h"
+
+#define CONNECTOR_MAX_MSG_SIZE 	1024
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
+#ifdef __KERNEL__
+
+#include <net/sock.h>
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
+#endif /* __KERNEL__ */
+#endif /* __CONNECTOR_H */


--
	Evgeniy Polyakov

Crash is better than data corruption. -- Artur Grabowski

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="cn_test.c"

/*
 * 	cn_test.c
 * 
 * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 * All rights reserved.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/skbuff.h>

#include "connector.h"

static struct cb_id cn_test_id = { 0x123, 0x456 };
static char cn_test_name[] = "cn_test";
static struct sock *nls;

void cn_test_callback(void *data)
{
	struct cn_msg *msg = (struct cn_msg *)data;

	printk("%s: idx=%x, val=%x, len=%d.\n",
	       __func__, msg->id.idx, msg->id.val, msg->len);
}

static int cn_test_want_notify(void)
{
	struct cn_ctl_msg *ctl;
	struct cn_notify_req *req;
	struct cn_msg *msg = NULL;
	int size, size0;
	struct sk_buff *skb;
	struct nlmsghdr *nlh;
	u32 group = 1;

	size0 = sizeof(*msg) + sizeof(*ctl) + 3*sizeof(*req);
	
	size = NLMSG_SPACE(size0);

	skb = alloc_skb(size, GFP_ATOMIC);
	if (!skb) {
		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);

		return -ENOMEM;
	}

	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - sizeof(*nlh));

	msg = (struct cn_msg *)NLMSG_DATA(nlh);

	memset(msg, 0, size0);

	msg->id.idx 	= -1;
	msg->id.val 	= -1;
	msg->seq 	= 0x123;
	msg->ack 	= 0x345;
	msg->len 	= size0 - sizeof(*msg);

	ctl = (struct cn_ctl_msg *)(msg + 1);

	ctl->idx_notify_num 	= 1;
	ctl->val_notify_num 	= 2;
	ctl->group		= group;
	ctl->len		= msg->len - sizeof(*ctl);

	req = (struct cn_notify_req *)(ctl + 1);

	/*
	 * Idx.
	 */
	req->first = cn_test_id.idx;
	req->range = 10;

	/*
	 * Val 0.
	 */
	req++;
	req->first = cn_test_id.val;
	req->range = 10;
	
	/*
	 * Val 1.
	 */
	req++;
	req->first = cn_test_id.val + 20;
	req->range = 10;
	
	NETLINK_CB(skb).dst_groups = ctl->group;
	//netlink_broadcast(nls, skb, 0, ctl->group, GFP_ATOMIC);
	netlink_unicast(nls, skb, 0, 0);

	printk(KERN_INFO "Request was sent. Group=0x%x.\n", group);
		
	return 0;

nlmsg_failure:
	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
	kfree_skb(skb);
	return -EINVAL;
}

static int cn_test_init(void)
{
	int err;
	
	nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
	if (!nls) {
		printk(KERN_ERR "Failed to create new netlink socket(%u).\n", NETLINK_NFLOG);
		return -EIO;
	}

	err = cn_test_want_notify();
	if (err)
		goto err_out;

	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
	if (err)
		goto err_out;
	cn_test_id.val++;
	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
	if (err) {
		cn_del_callback(&cn_test_id);
		goto err_out;
	}

	return 0;

err_out:
	if (nls->sk_socket)
		sock_release(nls->sk_socket);

	return err;
}

static void cn_test_fini(void)
{
	cn_del_callback(&cn_test_id);
	cn_test_id.val--;
	cn_del_callback(&cn_test_id);
	if (nls->sk_socket)
		sock_release(nls->sk_socket);
}

module_init(cn_test_init);
module_exit(cn_test_fini);

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="ucon.c"

/*
 * 	ucon.c
 *
 * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 * 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include <asm/types.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>

#include <linux/netlink.h>
#include <linux/rtnetlink.h>

#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#include "connector.h"
#include "../soekris/sc_conn.h"

static int need_exit;
__u32 seq;

static int netlink_send(int s, char *data)
{
	struct nlmsghdr *nlh;
	unsigned int size;
	int err;
	char buf[128];
	struct cn_msg *m, *msg;
	struct sc_conn_data *cmd;

	size = NLMSG_SPACE(sizeof(struct cn_msg) + sizeof(struct sc_conn_data));

	nlh = (struct nlmsghdr *)buf;
	nlh->nlmsg_seq = seq++;
	nlh->nlmsg_pid = getpid();
	nlh->nlmsg_type = NLMSG_DONE;
	nlh->nlmsg_len = NLMSG_LENGTH(size - sizeof(*nlh));
	nlh->nlmsg_flags = 0;

	m = NLMSG_DATA(nlh);
	msg = (struct cn_msg *)data;
	cmd = (struct sc_conn_data *)(msg + 1);

	printf("%s: len=%u, seq=%u, ack=%u, "
	       "sname=%s, lname=%s, idx=0x%x, cmd=%02x [%02x.%02x.%02x].\n",
	       __func__,
	       msg->len, msg->seq, msg->ack,
	       cmd->sname,
	       cmd->lname, cmd->idx, cmd->cmd, cmd->p0, cmd->p1, cmd->p2);

	memcpy(m, data, sizeof(*m) + msg->len);

	err = send(s, nlh, size, 0);
	if (err == -1)
		fprintf(stderr, "Failed to send: %s [%d].\n",
			strerror(errno), errno);

	return err;
}

int main(int argc, char *argv[])
{
	int s;
	char buf[1024];
	int len;
	struct nlmsghdr *reply;
	struct sockaddr_nl l_local;
	struct cn_msg *data;
	struct sc_conn_data *m;
	FILE *out;
	time_t tm;
	struct pollfd pfd;

	if (argc < 2)
		out = stdout;
	else {
		out = fopen(argv[1], "a+");
		if (!out) {
			fprintf(stderr, "Unable to open %s for writing: %s\n",
				argv[1], strerror(errno));
			out = stdout;
		}
	}

	memset(buf, 0, sizeof(buf));

	s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
	if (s == -1) {
		perror("socket");
		return -1;
	}

	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = 1;
	l_local.nl_pid = getpid();

	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
		perror("bind");
		close(s);
		return -1;
	}

	pfd.fd = s;

	while (!need_exit) {
		pfd.events = POLLIN;
		pfd.revents = 0;
		/*switch (poll(&pfd, 1, -1)) 
		   {
		   case 0:
		   need_exit = 1;
		   break;
		   case -1:
		   if (errno != EINTR) 
		   {
		   need_exit = 1;
		   break;
		   }
		   continue;
		   } */
		if (need_exit)
			break;

		data = (struct cn_msg *)buf;

		data->id.idx = 0xaabb;
		data->id.val = 0xccdd;
		data->seq = seq++;
		data->ack = (seq ^ 0x1234);
		data->len = sizeof(*m);

		m = (struct sc_conn_data *)(data + 1);
		memset(m, 0, sizeof(*m));

		m->cmd = SC_CMD_LDEV_READ;
		m->idx = 0xff;
		sprintf(m->sname, "PC8736X");
		sprintf(m->lname, "GPIO");

		m->p0 = 21;

		len = netlink_send(s, buf);

		len = recv(s, buf, sizeof(buf), 0);
		if (len == -1) {
			perror("recv buf");
			close(s);
			return -1;
		}
		reply = (struct nlmsghdr *)buf;

		switch (reply->nlmsg_type) {
		case NLMSG_ERROR:
			fprintf(out, "Error message received.\n");
			fflush(out);
			break;
		case NLMSG_DONE:
			data = (struct cn_msg *)NLMSG_DATA(reply);
			m = (struct sc_conn_data *)(data + 1);

			time(&tm);
			fprintf(out,
				"%.24s : [%x.%x] [seq=%u, ack=%u], sname=%s, lname=%s, idx=%u, cmd=%#02x [%#02x.%#02x.%#02x]\n",
				ctime(&tm), data->id.idx, data->id.val,
				data->seq, data->ack, m->sname, m->lname,
				m->idx, m->cmd, m->p0, m->p1, m->p2);
			fflush(out);
			break;
		default:
			break;
		}

		sleep(1);
	}

	close(s);
	return 0;
}

--82I3+IH0IqGh5yIs--
