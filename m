Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVEJGUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVEJGUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 02:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEJGUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 02:20:10 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:39087 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261551AbVEJGSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 02:18:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Date: Tue, 10 May 2005 01:18:46 -0500
User-Agent: KMail/1.8
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
In-Reply-To: <20050411125932.GA19538@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100118.48027.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 April 2005 07:59, Evgeniy Polyakov wrote:
> /*****************************************/
> Kernel Connector.
> /*****************************************/
> 
> Kernel connector - new netlink based userspace <-> kernel space easy to use communication module.
> 

Hi Evgeniy,

I have looked at the connector implementation one more time and I think
it can be improved in the following ways:

- drop unneeded refcounting;
- start only one workqueue entry instead of one for every callback type;
- drop cn_dev - there is only one connector;
- simplify cn_notify_request to carry only one range - it simplifies code
  quite a bit - nothing stops clientd from sending several notification
  requests;
- implement internal queuefor callbacks so we are not at mercy of scheduler;
- admit that SKBs are message medium and do not mess up with passing around
  destructor functions.
- In callback notifier switch to using GFP_KERNEL since it can sleep just
  fine;
- more... 

Because there were a lot of changes I decided against doing relative patch
but instead a replacement patch for affected files. I have cut out cbus and
documentation to keep it smaller so it will be easier to review. The patch
is compile-tested only.

BTW, I do not think that "All rights reserved" statement is applicable/
compatible with GPL this software is supposedly released under, I have
taken liberty of removing this statement.

> +/*
> + * 	connector.c
> + * 
> + * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> + * All rights reserved.
> + * 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Please look it over.

-- 
Dmitry

 drivers/Kconfig               |    2 
 drivers/Makefile              |    2 
 drivers/connector/Kconfig     |   12 +
 drivers/connector/Makefile    |    1 
 drivers/connector/connector.c |  481 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/connector.h     |  103 ++++++++
 6 files changed, 601 insertions(+)

Index: dtor/drivers/connector/connector.c
===================================================================
--- /dev/null
+++ dtor/drivers/connector/connector.c
@@ -0,0 +1,481 @@
+/*
+ *	connector.c
+ *
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 2005 Copyright (c) Dmitry Torokhov <dtor@mail.ru>
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
+module_param(unit, int, 0);
+MODULE_PARM_DESC(unit, "Netlink socket to use.");
+
+static u32 cn_idx = CN_IDX_CONNECTOR;
+module_param_named(idx, cn_idx, uint, 0);
+MODULE_PARM_DESC(idx, "Connector's main device idx.");
+
+static u32 cn_val = CN_VAL_CONNECTOR;
+module_param_named(val, cn_val, uint, 0);
+MODULE_PARM_DESC(val, "Connector's main device val.");
+
+static u32 cn_max_backlog = 100;
+module_param_named(max_backlog, cn_max_backlog, uint, 0);
+MODULE_PARM_DESC(max_backlog, "Connector's maximum request backlog.");
+
+static LIST_HEAD(notify_list);
+static DECLARE_MUTEX(notify_list_lock);
+
+static LIST_HEAD(callback_list);
+static DEFINE_SPINLOCK(callback_list_lock);
+
+static struct sock *cn_netlink_socket;
+static struct workqueue_struct *cn_workqueue;
+static struct cb_id cn_id;
+static int cn_initialized;
+
+#define DEBUG
+#define PFX	"connector: "
+
+#ifdef DEBUG
+#define dprintk(fmt, args...)	printk(KERN_DEBUG PFX "%s: " fmt, \
+					__FUNCTION__, ## args)
+#else
+#define dprintk(fmt, args...)
+#endif
+
+/*
+ * cn_cb_equal() - checks whether 2 callback IDs are equal.
+ */
+static inline int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
+{
+	dprintk("comparing %04x.%04x and %04x.%04x\n",
+		i1->idx, i1->val,
+		i2->idx, i2->val);
+
+	return i1->idx == i2->idx && i1->val == i2->val;
+}
+
+/*
+ * cn_find_callback() - locates registered callback structure
+ * by its id. Caller must hold callback_list_lock.
+ */
+static struct cn_callback *cn_find_callback(struct cb_id *id)
+{
+	struct cn_callback *cb;
+
+	list_for_each_entry(cb, &callback_list, node)
+		if (cn_cb_equal(&cb->id, id))
+			return cb;
+
+	return NULL;
+}
+
+/*
+ * msg->seq and msg->ack are used to determine message genealogy.
+ * When someone sends message it puts there locally unique sequence
+ * and random acknowledge numbers.
+ * Sequence number may also be copied into nlmsghdr->nlmsg_seq.
+ *
+ * Sequence number is incremented with each message to be sent.
+ *
+ * If we expect reply to our message,
+ * then sequence number in received message MUST be the same as in
+ * original message, and acknowledge number MUST be the same + 1.
+ *
+ * If we receive a message and it's sequence number is not equal to
+ * the one we are expecting, then it is new message.
+ * If we receive a message and it's sequence number is the same as
+ * the one we are expecting, but it's acknowledge is not equal to the
+ * acknowledge number in original message + 1, then it is ialso a new
+ * message.
+ */
+int cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask)
+{
+	struct cn_callback *cb;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	unsigned int size;
+	u32 groups = 0;
+
+	if (!cn_initialized)
+		return -EAGAIN;
+
+	if (!__groups) {
+		spin_lock_bh(&callback_list_lock);
+		cb = cn_find_callback(&msg->id);
+		if (cb)
+			groups = cb->group;
+		spin_unlock_bh(&callback_list_lock);
+
+		if (!cb) {
+			dprintk("Failed to find callback %#x.%#x, seq=%u\n",
+				msg->id.idx, msg->id.val, msg->seq);
+			return -ENODEV;
+		}
+	}
+	else
+		groups = __groups;
+
+	size = sizeof(struct cn_msg) + msg->len;
+
+	skb = alloc_skb(NLMSG_SPACE(size), gfp_mask);
+	if (!skb) {
+		printk(KERN_ERR PFX "Failed to allocate skb with size=%u\n",
+			NLMSG_SPACE(size));
+		return -ENOMEM;
+	}
+
+	dprintk("len=%u, seq=%u, ack=%u, group=%u.\n",
+		msg->len, msg->seq, msg->ack, groups);
+
+	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size);
+	memcpy(NLMSG_DATA(nlh), msg, sizeof(struct cn_msg) + msg->len);
+
+	NETLINK_CB(skb).dst_groups = groups;
+
+	netlink_broadcast(cn_netlink_socket, skb, 0, groups, gfp_mask);
+	return 0;
+
+ nlmsg_failure:
+	kfree_skb(skb);
+	return -ENOMEM;
+}
+
+/*
+ * cn_execute_callback() - executes callback and frees associated
+ * skb and work structures.
+ */
+static void cn_execute_callback(void *data)
+{
+	struct cn_callback_work *cb_work = data;
+
+	cb_work->cb->callback(cb_work->msg->data);
+
+	spin_lock_bh(&callback_list_lock);
+	cb_work->cb->requests--;
+	spin_unlock_bh(&callback_list_lock);
+
+	kfree_skb(cb_work->skb);
+	kfree(cb_work);
+}
+
+/*
+ * cn_schedule_callback() - allocates work structure and
+ * schedules callback for execution on cn_workqueue
+ */
+static int cn_schedule_callback(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh = (struct nlmsghdr *)skb->data;
+	struct cn_msg *msg = NLMSG_DATA(nlh);
+	struct cn_callback_work *cb_work;
+	struct cn_callback *cb;
+	int error;
+
+	cb_work = kcalloc(1, sizeof(struct cn_callback_work), GFP_KERNEL);
+	if (!cb_work)
+		return -ENOMEM;
+
+	spin_lock_bh(&callback_list_lock);
+	cb = cn_find_callback(&msg->id);
+	if (!cb)
+		error = -ENODEV;
+	else if (cb->requests >= cn_max_backlog)
+		error = -ENOSPC;
+	else {
+		cb_work->cb = cb;
+		cb_work->msg = msg;
+		cb_work->skb = skb_get(skb);
+		INIT_WORK(&cb_work->work, cn_execute_callback, cb_work);
+		queue_work(cn_workqueue, &cb_work->work);
+		cb->requests++;
+		error = 0;
+	}
+	spin_unlock_bh(&callback_list_lock);
+
+	if (error)
+		kfree(cb_work);
+
+	return error;
+}
+
+/*
+ * cn_validate_skb() - performs basic checks on skb to ensure
+ * that received message has correct structure.
+ */
+static int cn_validate_skb(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh;
+	struct cn_msg *msg;
+
+	dprintk("skb: len=%u, data_len=%u, truesize=%u, proto=%u, "
+		"cloned=%d, shared=%d\n",
+		skb->len, skb->data_len, skb->truesize, skb->protocol,
+		skb_cloned(skb), skb_shared(skb));
+
+	if (skb->len < NLMSG_SPACE(0)) {
+		printk(KERN_ERR PFX "empty skb received\n");
+		return -EINVAL;
+	}
+
+	nlh = (struct nlmsghdr *)skb->data;
+	if (skb->len < nlh->nlmsg_len) {
+		printk(KERN_ERR PFX
+			"skb is too short, skb_len=%u, nlmsg_len=%u\n",
+			skb->len, nlh->nlmsg_len);
+		return -EINVAL;
+	}
+
+	msg = (struct cn_msg *)NLMSG_DATA(nlh);
+	if (NLMSG_SPACE(msg->len + sizeof(*msg)) != nlh->nlmsg_len) {
+		printk(KERN_ERR PFX "invalid netlink message length, "
+			"msg->len=%u[%u], nlh->nlmsg_len=%u\n",
+			msg->len, NLMSG_SPACE(msg->len + sizeof(*msg)),
+			nlh->nlmsg_len);
+		return -EINVAL;
+	}
+
+	dprintk("pid=%u, uid=%u, seq=%u, group=%u\n",
+		NETLINK_CREDS(skb)->pid, NETLINK_CREDS(skb)->uid,
+		nlh->nlmsg_seq, NETLINK_CB((skb)).groups);
+
+	return 0;
+}
+
+/*
+ * cn_input() - netlink socket input handler. Dequeues skb and,
+ * after validating reveived data, schedules requested callback
+ * for subsequent execution.
+ */
+static void cn_input(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+		if (cn_validate_skb(skb))
+			cn_schedule_callback(skb);
+
+		kfree_skb(skb);
+	}
+}
+
+/*
+ * cn_notify() - notifies registered listeners about an event.
+ * Currently is used to notify userspace about add/remove callback
+ * requests being processed by connector.
+ */
+static void cn_notify(struct cb_id *id, u32 notify_event)
+{
+	struct cn_notify_entry *entry;
+	struct cn_notify_req *req;
+	struct cn_msg notify_msg;
+
+	down(&notify_list_lock);
+	list_for_each_entry(entry, &notify_list, node) {
+
+		req = &entry->req;
+
+		if (id->idx >= req->idx_first &&
+		    id->idx < req->idx_first + req->idx_range &&
+		    id->val >= req->val_first &&
+		    id->val < req->val_first + req->val_range) {
+
+			dprintk("Notifying group %x - %#x.%#x: event %u\n",
+				req->group, id->idx, id->val, notify_event);
+
+			memset(&notify_msg, 0, sizeof(notify_msg));
+			notify_msg.id = *id;
+			notify_msg.ack = notify_event;
+
+			cn_netlink_send(&notify_msg, req->group, GFP_KERNEL);
+		}
+	}
+	up(&notify_list_lock);
+}
+
+/*
+ * cn_add_callback() - installs callback with specified callback ID
+ */
+int cn_add_callback(struct cb_id *id, char *name, void (*callback)(void *))
+{
+	struct cn_callback *cb;
+	int retval = 0;
+
+	cb = kcalloc(1, sizeof(struct cn_callback), GFP_KERNEL);
+	if (!cb) {
+		printk(KERN_ERR PFX
+			"Failed to allocate new struct cn_callback\n");
+		return -ENOMEM;
+	}
+
+	cb->id = *id;
+	snprintf(cb->name, sizeof(cb->name), "%s", name);
+	cb->callback = callback;
+
+	spin_lock_bh(&callback_list_lock);
+	if (cn_find_callback(id)) {
+		kfree(cb);
+		retval = -EEXIST;
+	} else
+		list_add_tail(&cb->node, &callback_list);
+	spin_unlock_bh(&callback_list_lock);
+
+	if (retval == 0)
+		cn_notify(id, 0);
+
+	return retval;
+}
+
+/*
+ * cn_del_callback() - deletes callback with specified callback ID
+ * Will wait until all scheduled instances of the callback complete.
+ */
+void cn_del_callback(struct cb_id *id)
+{
+	struct cn_callback *cb;
+
+	spin_lock_bh(&callback_list_lock);
+	cb = cn_find_callback(id);
+	if (cb)
+		list_del(&cb->node);
+	spin_unlock_bh(&callback_list_lock);
+
+	if (cb) {
+		flush_workqueue(cn_workqueue);
+		kfree(cb);
+		cn_notify(id, 1);
+	} else
+		printk(KERN_WARNING PFX
+			"Attempting do delete non-existing callback %x/%x\n",
+			id->idx, id->val);
+}
+
+/*
+ * cn_notify_req_same() - compares two connector notify requestes
+ */
+static inline int cn_notify_req_same(struct cn_notify_req *r1,
+				     struct cn_notify_req *r2)
+{
+	return r1->group == r2->group &&
+	       r1->idx_first == r2->idx_first &&
+	       r1->idx_range == r2->idx_range &&
+	       r1->val_first == r2->val_first &&
+	       r1->val_range == r2->val_range;
+}
+
+/*
+ * cn_connector_callback() - callback installed and used by connector
+ * itself to manage connector notification requests.
+ */
+static void cn_connector_callback(void *data)
+{
+	struct cn_msg *msg = data;
+	struct cn_notify_req *req;
+	struct cn_notify_entry *entry;
+	int found = 0;
+
+	if (msg->len != sizeof(struct cn_notify_req)) {
+		printk(KERN_ERR PFX
+		       "Wrong notify request size (%u, must be %u)\n",
+			msg->len, sizeof(struct cn_notify_req));
+		return;
+	}
+
+	req = (struct cn_notify_req *)msg->data;
+
+	down(&notify_list_lock);
+
+	list_for_each_entry(entry, &notify_list, node) {
+		if (cn_notify_req_same(&entry->req, req)) {
+			list_del(&entry->node);
+			kfree(entry);
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			printk(KERN_ERR PFX
+				"Failed to allocate new notify entry\n");
+		else {
+			entry->req = *req;
+			list_add_tail(&entry->node, &notify_list);
+		}
+	}
+
+	up(&notify_list_lock);
+}
+
+static int cn_init(void)
+{
+	int error;
+
+	cn_workqueue = create_workqueue("cqueue");
+	if (!cn_workqueue) {
+		printk(KERN_ERR PFX "Failed to create workqueue\n");
+		return -ENOMEM;
+	}
+
+	cn_netlink_socket = netlink_kernel_create(unit, cn_input);
+	if (!cn_netlink_socket) {
+		printk(KERN_ERR PFX
+			"Failed to create new netlink socket(%u)\n", unit);
+		destroy_workqueue(cn_workqueue);
+		return -ENOMEM;
+	}
+
+	cn_id.idx = cn_idx;
+	cn_id.val = cn_val;
+	error = cn_add_callback(&cn_id, "connector", cn_connector_callback);
+	if (error) {
+		printk(KERN_ERR PFX "Failed to install 'connector' callback\n");
+		sock_release(cn_netlink_socket->sk_socket);
+		destroy_workqueue(cn_workqueue);
+		return error;
+	}
+
+	cn_initialized = 1;
+	return 0;
+}
+
+static void cn_exit(void)
+{
+	cn_del_callback(&cn_id);
+	sock_release(cn_netlink_socket->sk_socket);
+	destroy_workqueue(cn_workqueue);
+}
+
+module_init(cn_init);
+module_exit(cn_exit);
+
+EXPORT_SYMBOL_GPL(cn_add_callback);
+EXPORT_SYMBOL_GPL(cn_del_callback);
+EXPORT_SYMBOL_GPL(cn_netlink_send);
Index: dtor/drivers/connector/Makefile
===================================================================
--- /dev/null
+++ dtor/drivers/connector/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CONNECTOR)		+= connector.o
Index: dtor/drivers/connector/Kconfig
===================================================================
--- /dev/null
+++ dtor/drivers/connector/Kconfig
@@ -0,0 +1,12 @@
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
+endmenu
Index: dtor/include/linux/connector.h
===================================================================
--- /dev/null
+++ dtor/include/linux/connector.h
@@ -0,0 +1,103 @@
+/*
+ *	connector.h
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
+#define CN_IDX_CONNECTOR		0xffffffff
+#define CN_VAL_CONNECTOR		0xffffffff
+
+/*
+ * idx and val are unique identifiers which
+ * are used for message routing and
+ * must be registered in connector.h for in-kernel usage.
+ */
+
+struct cb_id
+{
+	__u32			idx;
+	__u32			val;
+};
+
+struct cn_msg
+{
+	struct cb_id	id;
+
+	__u32		seq;
+	__u32		ack;
+
+	__u32		len;		/* Length of the following data */
+	__u8		data[0];
+};
+
+/*
+ * Notify structure - requests notification about
+ * registering/unregistering idx/val in range [first, first+range).
+ */
+struct cn_notify_req
+{
+	__u32			group;
+	__u32			idx_first, idx_range;
+	__u32			val_first, val_range;
+};
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
+struct cn_callback
+{
+	struct cb_id		id;
+	unsigned char		name[CN_CBQ_NAMELEN];
+	int			group;
+	void			(*callback)(void *);
+	int			requests;
+	struct list_head	node;
+};
+
+struct cn_callback_work {
+	struct cn_callback	*cb;
+	struct cn_msg		*msg;
+	struct sk_buff		*skb;
+	struct work_struct	work;
+};
+
+struct cn_notify_entry
+{
+	struct list_head	node;
+	struct cn_notify_req	req;
+};
+
+int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
+void cn_del_callback(struct cb_id *);
+int cn_netlink_send(struct cn_msg *, u32, int);
+
+#endif /* __KERNEL__ */
+#endif /* __CONNECTOR_H */
Index: dtor/drivers/Makefile
===================================================================
--- dtor.orig/drivers/Makefile
+++ dtor/drivers/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_PNP)		+= pnp/
 # default.
 obj-y				+= char/
 
+obj-$(CONFIG_CONNECTOR)	+= connector/
+
 # i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           += video/i810/
 obj-$(CONFIG_FB_INTEL)          += video/intelfb/
Index: dtor/drivers/Kconfig
===================================================================
--- dtor.orig/drivers/Kconfig
+++ dtor/drivers/Kconfig
@@ -4,6 +4,8 @@ menu "Device Drivers"
 
 source "drivers/base/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "drivers/mtd/Kconfig"
 
 source "drivers/parport/Kconfig"
