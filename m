Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVDKM6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVDKM6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDKM6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:58:09 -0400
Received: from dea.vocord.ru ([217.67.177.50]:62902 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261567AbVDKMzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:55:15 -0400
Date: Mon, 11 Apr 2005 16:59:32 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: netdev@oss.sgi.com
Cc: Greg KH <greg@kroah.com>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
Subject: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Message-ID: <20050411125932.GA19538@uganda.factory.vocord.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*****************************************/
Kernel Connector.
/*****************************************/

Kernel connector - new netlink based userspace <-> kernel space easy to use communication module.

Connector driver adds possibility to connect various agents using
netlink based network.
One must register callback and identifier. When driver receives
special netlink message with appropriate identifier, appropriate
callback will be called.

>From the userspace point of view it's quite straightforward:
socket();
bind();
send();
recv();

But if kernelspace want to use full power of such connections, driver
writer must create special sockets, must know about struct sk_buff
handling...
Connector allows any kernelspace agents to use netlink based
networking for inter-process communication in a significantly easier
way:

int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *));
void cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask);

struct cb_id
{
	__u32			idx;
	__u32			val;
};

idx and val are unique identifiers which must be registered in connector.h
for in-kernel usage.
void (*callback) (void *) - is a callback function which will be called
when message with above idx.val will be received by connector core.
Argument for that function must be dereferenced to struct cn_msg *.

struct cn_msg
{
	struct cb_id 		id;

	__u32			seq;
	__u32			ack;

	__u32			len;		/* Length of the following data */
	__u8			data[0];
};

/*****************************************/
Connector interfaces.
/*****************************************/

int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *));
Registers new callback with connector core.

struct cb_id *id 		- unique connector's user identifier.
			  	  It must be registered in connector.h for legal in-kernel users.
char *name 			- connector's callback symbolic name.
void (*callback) (void *)	- connector's callback.
				  Argument must be dereferenced to struct cn_msg *.

void cn_del_callback(struct cb_id *id);
Unregisters new callback with connector core.

struct cb_id *id 		- unique connector's user identifier.

void cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask);
Sends message to the specified groups.
It can be safely called from any context, but may silently
fail under strong memory pressure.

struct cn_msg *			- message header(with attached data).
u32 __groups			- destination groups.
				  If __groups is zero, then appropriate group will
				  be searched through all registered connector users,
				  and message will be delivered to the group which was
				  created for user with the same ID as in msg.
				  If __groups is not zero, then message will be delivered
				  to the specified group.
int gfp_mask			- GFP mask.

Note: When registering new callback user, connector core assigns netlink group
to the user which is equal to it's id.idx.

/*****************************************/
Protocol description.
/*****************************************/

Current offers transport layer with fixed header.
Recommended protocol which uses such header is following:

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

connector allows event notification in the following form:
kernel driver or userspace process can ask connector to notify it
when selected id's will be turned on or off(registered or unregistered
it's callback). It is done by sending special command to connector
driver(it also registers itself with id={-1, -1}).

As example of usage Documentation/connector now contains cn_test.c - 
testing module which uses connector to request notification
and to send messages.


/*****************************************/
CBUS.
/*****************************************/

This message bus allows message passing between different agents
using connector's infrastructure.
It is extremely fast for insert operations so it can be used in performance
critical paths in any context instead of direct connector's methods calls.

CBUS uses per CPU variables and thus allows message reordering,
caller must be prepared (and use CPU id in it's messages).

Usage is very simple - just call cbus_insert(struct cn_msg *msg, int gfp_mask);
It can fail, so caller must check return value - zero on success
and negative error code otherwise.

Benchmark with modified fork connector and fork bomb on 2-way system
did not show any differences between vanilla 2.6.11 and CBUS.



/*****************************************/
Reliability.
/*****************************************/
Netlink itself is not reliable protocol, 
that means that messages can be lost
due to memory pressure or process' receiving
queue overflowed, so caller is warned 
must be prepared. That is why struct cn_msg
[main connector's message header] contains 
u32 seq and u32 ack fields.

P.S. As far as I can see, all previous comments are successfully resolved.
Thank you.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff -Nru /tmp/empty/cbus.c ./drivers/connector/cbus.c
--- /tmp/empty/cbus.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/cbus.c	2005-04-11 16:15:29.535285712 +0400
@@ -0,0 +1,272 @@
+/*
+ * 	cbus.c
+ * 
+ * 2005 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
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
+#include <linux/connector.h>
+#include <linux/list.h>
+#include <linux/moduleparam.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Ultrafast message bus based on kernel connector.");
+
+static DEFINE_PER_CPU(struct cbus_event_container, cbus_event_list);
+static int cbus_pid, cbus_need_exit;
+static struct completion cbus_thread_exited;
+static DECLARE_WAIT_QUEUE_HEAD(cbus_wait_queue);
+static int cbus_max_queue_len = 1024;
+module_param(cbus_max_queue_len, int, 0);
+MODULE_PARM_DESC(cbus_max_queue_len, "Maximum CBUS queue length, "
+		"if it is overflowed events will be delivered using direct connector's methods.");
+
+static char cbus_name[] = "cbus";
+
+struct cbus_event_container
+{
+	struct list_head	event_list;
+	spinlock_t		event_lock;
+	int 			qlen;
+};
+
+struct cbus_event
+{
+	struct list_head	event_entry;
+	u32			cpu;
+	struct cn_msg		msg;
+};
+
+static inline struct cbus_event *__cbus_dequeue(struct cbus_event_container *c)
+{
+	struct list_head *next = c->event_list.next;
+
+	list_del(next);
+	c->qlen--;
+
+	if (c->qlen < 0) {
+		printk(KERN_ERR "%s: qlen=%d after dequeue on CPU%u.\n",
+				cbus_name, c->qlen, smp_processor_id());
+		c->qlen = 0;
+	}
+	
+	return list_entry(next, struct cbus_event, event_entry);
+}
+
+static inline struct cbus_event *cbus_dequeue(struct cbus_event_container *c)
+{
+	struct cbus_event *event;
+	unsigned long flags;
+	
+	if (list_empty(&c->event_list))
+		return NULL;
+	
+	spin_lock_irqsave(&c->event_lock, flags);
+	event = __cbus_dequeue(c);
+	spin_unlock_irqrestore(&c->event_lock, flags);
+
+	return event;
+}
+
+static inline void __cbus_enqueue(struct cbus_event_container *c, struct cbus_event *event)
+{
+	list_add_tail(&event->event_entry, &c->event_list);
+	c->qlen++;
+}
+
+static int cbus_enqueue(struct cbus_event_container *c, struct cn_msg *msg, int gfp_mask)
+{
+	int err, enq = 0;
+	struct cbus_event *event;
+	unsigned long flags;
+
+	event = kmalloc(sizeof(*event) + msg->len, gfp_mask);
+	if (!event) {
+		err = -ENOMEM;
+		goto err_out_exit;
+	}
+
+	memcpy(&event->msg, msg, sizeof(event->msg));
+
+	if (msg->len)
+		memcpy(event+1, msg->data, msg->len);
+	
+	spin_lock_irqsave(&c->event_lock, flags);
+	if (c->qlen <= cbus_max_queue_len) {
+		__cbus_enqueue(c, event);
+		enq = 1;
+	}
+	spin_unlock_irqrestore(&c->event_lock, flags);
+
+	if (!enq) {
+		kfree(event);
+		cn_netlink_send(msg, 0, gfp_mask);
+	}
+
+	//wake_up_interruptible(&cbus_wait_queue);
+
+	return 0;
+
+err_out_exit:
+	return err;
+}
+
+int cbus_insert(struct cn_msg *msg, int gfp_flags)
+{
+	struct cbus_event_container *c;
+	int err;
+
+	/*
+	 * If CBUS is being removed,
+	 * do not allow to add new events,
+	 * it still has a race, when
+	 * event may be added after
+	 * all queues are processed,
+	 * but we do not care if one
+	 * message in each queue will not
+	 * be delivered and CBUS is removed.
+	 */
+	if (cbus_need_exit)
+		return -ENODEV;
+
+	preempt_disable();
+	c = &__get_cpu_var(cbus_event_list);
+	
+	err = cbus_enqueue(c, msg, gfp_flags);
+	
+	preempt_enable();
+
+	return err;
+}
+
+static int cbus_process(struct cbus_event_container *c, int all)
+{
+	struct cbus_event *event;
+	int len, i, num;
+	
+	if (list_empty(&c->event_list))
+		return 0;
+
+	if (all)
+		len = c->qlen;
+	else
+		len = 1;
+
+	num = 0;
+	for (i=0; i<len; ++i) {
+		event = cbus_dequeue(c);
+		if (!event)
+			continue;
+
+		cn_netlink_send(&event->msg, 0, GFP_KERNEL);
+		num++;
+
+		kfree(event);
+	}
+	
+	return num;
+}
+
+static int cbus_event_thread(void *data)
+{
+	int i, non_empty = 0, empty = 0;
+	struct cbus_event_container *c;
+
+	daemonize(cbus_name);
+	allow_signal(SIGTERM);
+	set_user_nice(current, 19);
+
+	while (!cbus_need_exit) {
+		if (empty || non_empty == 0 || non_empty > 10) {
+			wait_event_interruptible_timeout(cbus_wait_queue, 0, HZ/100);
+			non_empty = 0;
+			empty = 0;
+		}
+
+		for_each_cpu(i) {
+			c = &per_cpu(cbus_event_list, i);
+
+			if (cbus_process(c, 0))
+				non_empty++;
+			else
+				empty = 1;
+		}
+	}
+
+	complete_and_exit(&cbus_thread_exited, 0);
+}
+
+static int cbus_init_event_container(struct cbus_event_container *c)
+{
+	INIT_LIST_HEAD(&c->event_list);
+	spin_lock_init(&c->event_lock);
+	c->qlen = 0;
+
+	return 0;
+}
+
+static void cbus_fini_event_container(struct cbus_event_container *c)
+{
+	cbus_process(c, 1);
+}
+
+int __devinit cbus_init(void)
+{
+	int i, err = 0;
+	struct cbus_event_container *c;
+	
+	for_each_cpu(i) {
+		c = &per_cpu(cbus_event_list, i);
+		cbus_init_event_container(c);
+	}
+
+	init_completion(&cbus_thread_exited);
+
+	cbus_pid = kernel_thread(cbus_event_thread, NULL, CLONE_FS | CLONE_FILES);
+	if (cbus_pid < 0) {
+		printk(KERN_ERR "%s: Failed to create cbus event thread: err=%d.\n", 
+				cbus_name, cbus_pid);
+		err = cbus_pid;
+		goto err_out_exit;
+	}
+
+err_out_exit:
+	return err;
+}
+
+void __devexit cbus_fini(void)
+{
+	int i;
+	struct cbus_event_container *c;
+
+	cbus_need_exit = 1;
+	kill_proc(cbus_pid, SIGTERM, 0);
+	wait_for_completion(&cbus_thread_exited);
+	
+	for_each_cpu(i) {
+		c = &per_cpu(cbus_event_list, i);
+		cbus_fini_event_container(c);
+	}
+}
+
+module_init(cbus_init);
+module_exit(cbus_fini);
+
+EXPORT_SYMBOL_GPL(cbus_insert);
diff -Nru /tmp/empty/cn_queue.c ./drivers/connector/cn_queue.c
--- /tmp/empty/cn_queue.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/cn_queue.c	2005-04-11 16:12:22.511717616 +0400
@@ -0,0 +1,207 @@
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
+#include <linux/delay.h>
+
+static void cn_queue_wrapper(void *data)
+{
+	struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
+
+	atomic_inc_and_test(&cbq->cb->refcnt);
+	cbq->cb->callback(cbq->cb->priv);
+	atomic_dec_and_test(&cbq->cb->refcnt);
+
+	cbq->destruct_data(cbq->ddata);
+}
+
+static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct cn_callback *cb)
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
+	flush_workqueue(cbq->pdev->cn_queue);
+
+	while (atomic_read(&cbq->cb->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
+
+		msleep(1000);
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
+	struct cn_callback_entry *cbq, *__cbq;
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
+	list_for_each_entry(__cbq, &dev->queue_list, callback_entry) {
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
+	cbq->group = cbq->cb->id.idx;
+
+	return 0;
+}
+
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id)
+{
+	struct cn_callback_entry *cbq = NULL, *n;
+	int found = 0;
+
+	spin_lock_bh(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		if (cn_cb_equal(&cbq->cb->id, id)) {
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
+		atomic_dec_and_test(&dev->refcnt);
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
+		atomic_dec_and_test(&cbq->cb->refcnt);
+	}
+	spin_unlock_bh(&dev->queue_lock);
+
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+		       dev->name, atomic_read(&dev->refcnt));
+
+		msleep(1000);
+	}
+
+	memset(dev, 0, sizeof(*dev));
+	kfree(dev);
+	dev = NULL;
+}
diff -Nru /tmp/empty/connector.c ./drivers/connector/connector.c
--- /tmp/empty/connector.c	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/connector.c	2005-04-11 16:10:03.327876776 +0400
@@ -0,0 +1,529 @@
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
+static u32 cn_idx = CN_IDX_CONNECTOR;
+static u32 cn_val = CN_VAL_CONNECTOR;
+
+module_param(unit, int, 0);
+MODULE_PARM_DESC(unit, "Netlink socket to use.");
+module_param(cn_idx, uint, 0);
+module_param(cn_val, uint, 0);
+MODULE_PARM_DESC(cn_idx, "Connector's main device idx.");
+MODULE_PARM_DESC(cn_val, "Connector's main device val.");
+
+static DEFINE_SPINLOCK(notify_lock);
+static LIST_HEAD(notify_list);
+
+static struct cn_dev cdev;
+
+int cn_already_initialized = 0;
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
+int cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask)
+{
+	struct cn_callback_entry *__cbq;
+	unsigned int size;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	struct cn_msg *data;
+	struct cn_dev *dev = &cdev;
+	u32 groups = 0;
+	int found = 0;
+
+	if (!__groups) {
+		spin_lock_bh(&dev->cbdev->queue_lock);
+		list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
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
+			return -ENODEV;
+		}
+	}
+	else
+		groups = __groups;
+
+	size = NLMSG_SPACE(sizeof(*msg) + msg->len);
+
+	skb = alloc_skb(size, gfp_mask);
+	if (!skb) {
+		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
+		return -ENOMEM;
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
+	
+	NETLINK_CB(skb).dst_groups = groups;
+	
+	netlink_broadcast(dev->nls, skb, 0, groups, gfp_mask);
+
+	return 0;
+
+nlmsg_failure:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+/*
+ * Callback helper - queues work and setup destructor for given data.
+ */
+static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)
+{
+	struct cn_callback_entry *__cbq;
+	struct cn_dev *dev = &cdev;
+	int found = 0;
+
+	spin_lock_bh(&dev->cbdev->queue_lock);
+	list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
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
+	return (found)?0:-ENODEV;
+}
+
+/*
+ * Skb receive helper - checks skb and msg size
+ * and calls callback helper.
+ */
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
+	if (NLMSG_SPACE(msg->len + sizeof(*msg)) != nlh->nlmsg_len) {
+		printk(KERN_ERR "skb does not have enough length: "
+				"requested msg->len=%u[%u], nlh->nlmsg_len=%u, skb->len=%u.\n",
+				msg->len, NLMSG_SPACE(msg->len + sizeof(*msg)),
+				nlh->nlmsg_len, skb->len);
+		return -EINVAL;
+	}
+#if 0
+	printk(KERN_INFO "pid=%u, uid=%u, seq=%u, group=%u.\n",
+	       pid, uid, seq, group);
+#endif
+	return cn_call_callback(msg, (void (*)(void *))kfree_skb, skb);
+}
+
+/*
+ * Main netlink receiving function - 
+ * it checks skb and netlink header sizes 
+ * and calls skb receive helper with shared skb.
+ */
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
+		kfree_skb(__skb);
+		return;
+	}
+#if 0
+	printk(KERN_INFO
+	       "skb: len=%u, data_len=%u, truesize=%u, proto=%u, cloned=%d, shared=%d.\n",
+	       skb->len, skb->data_len, skb->truesize, skb->protocol,
+	       skb_cloned(skb), skb_shared(skb));
+#endif
+	if (skb->len >= NLMSG_SPACE(0)) {
+		nlh = (struct nlmsghdr *)skb->data;
+
+		if (nlh->nlmsg_len < sizeof(struct cn_msg) ||
+		    skb->len < nlh->nlmsg_len ||
+		    nlh->nlmsg_len > CONNECTOR_MAX_MSG_SIZE) {
+#if 1
+			printk(KERN_INFO "nlmsg_len=%u, sizeof(*nlh)=%u\n",
+			       nlh->nlmsg_len, sizeof(*nlh));
+#endif
+			kfree_skb(skb);
+			goto out;
+		}
+
+		len = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (len > skb->len)
+			len = skb->len;
+
+		err = __cn_rx_skb(skb, nlh);
+		if (err < 0)
+			kfree_skb(skb);
+	}
+
+out:
+	kfree_skb(__skb);
+}
+
+/*
+ * Netlink socket input callback - dequeues skb and 
+ * calls main netlink receiving function.
+ */
+static void cn_input(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL)
+		cn_rx_skb(skb);
+}
+
+/*
+ * Notification routing.
+ * Gets id and checks if
+ * there are notification request for it's idx and val.
+ * If there are such requests notify it's listeners 
+ * with given notify event.
+ */
+static void cn_notify(struct cb_id *id, u32 notify_event)
+{
+	struct cn_ctl_entry *ent;
+
+	spin_lock_bh(&notify_lock);
+	list_for_each_entry(ent, &notify_list, notify_entry) {
+		int i;
+		struct cn_notify_req *req;
+		struct cn_ctl_msg *ctl = ent->msg;
+		int idx_found, val_found;
+
+		idx_found = val_found = 0;
+		
+		req = (struct cn_notify_req *)ctl->data;
+		for (i=0; i<ctl->idx_notify_num; ++i, ++req) {
+			if (id->idx >= req->first && id->idx < req->first + req->range) {
+				idx_found = 1;
+				break;
+			}
+		}
+		
+		for (i=0; i<ctl->val_notify_num; ++i, ++req) {
+			if (id->val >= req->first && id->val < req->first + req->range) {
+				val_found = 1;
+				break;
+			}
+		}
+
+		if (idx_found && val_found) {
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
+			cn_netlink_send(&m, ctl->group, GFP_ATOMIC);
+		}
+	}
+	spin_unlock_bh(&notify_lock);
+}
+
+/*
+ * Callback add routing - adds callback
+ * with given ID and name.
+ * If there is registered callback with the same
+ * ID it will not be added.
+ *
+ * May sleep.
+ */
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
+	scnprintf(cb->name, sizeof(cb->name), "%s", name);
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
+/*
+ * Callback remove routing - removes callback
+ * with given ID.
+ * If there is no registered callback with given
+ * ID nothing happens.
+ *
+ * May sleep while waiting for reference counter to become zero.
+ */
+void cn_del_callback(struct cb_id *id)
+{
+	struct cn_dev *dev = &cdev;
+
+	cn_queue_del_callback(dev->cbdev, id);
+	cn_notify(id, 1);
+}
+
+/*
+ * Checks two connector's control messages to be the same.
+ * Returns 1 if they are the same or firts one is broken.
+ */
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
+/*
+ * Main connector device's callback.
+ * Is used for notification requests processing.
+ */
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
+}
+
+static int cn_init(void)
+{
+	struct cn_dev *dev = &cdev;
+	int err;
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
+	err = cn_add_callback(&dev->id, "connector", &cn_callback);
+	if (err) {
+		cn_queue_free_dev(dev->cbdev);
+		if (dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return -EINVAL;
+	}
+
+	cn_already_initialized = 1;
+
+	return 0;
+}
+
+static void cn_fini(void)
+{
+	struct cn_dev *dev = &cdev;
+
+	cn_already_initialized = 0;
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
+EXPORT_SYMBOL_GPL(cn_add_callback);
+EXPORT_SYMBOL_GPL(cn_del_callback);
+EXPORT_SYMBOL_GPL(cn_netlink_send);
diff -Nru /tmp/empty/Kconfig ./drivers/connector/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/Kconfig	2005-04-11 16:16:27.176522912 +0400
@@ -0,0 +1,27 @@
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
+config CBUS
+       tristate "CBUS - ultra fast (for insert operations) message bus based on connector"
+       depends on CONNECTOR
+       ---help---
+         This message bus allows message passing between different agents
+         using connector's infrastructure.
+         It is extremly fast for insert operations so it can be used in performance
+         critical pathes instead of direct connector's methods calls.
+
+         CBUS uses per CPU variables and thus allows message reordering,
+         caller must be prepared (and use CPU id in it's messages).
+         
+         CBUS support can also be built as a module.  If so, the module
+         will be called cbus.
+
+endmenu
diff -Nru /tmp/empty/Makefile ./drivers/connector/Makefile
--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/Makefile	2005-04-11 16:17:04.440857872 +0400
@@ -0,0 +1,3 @@
+obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_CBUS)		+= cbus.o
+cn-objs		:= cn_queue.o connector.o
Binary files /tmp/empty/.tmp_cbus.o and ./drivers/connector/.tmp_cbus.o differ
diff -Nru /tmp/empty/.tmp_cbus.ver ./drivers/connector/.tmp_cbus.ver
--- /tmp/empty/.tmp_cbus.ver	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/.tmp_cbus.ver	2005-04-11 16:17:06.579532744 +0400
@@ -0,0 +1 @@
+__crc_cbus_insert = 0x2fcab901 ;
Binary files /tmp/empty/.tmp_connector.o and ./drivers/connector/.tmp_connector.o differ
diff -Nru /tmp/empty/.tmp_connector.ver ./drivers/connector/.tmp_connector.ver
--- /tmp/empty/.tmp_connector.ver	1970-01-01 03:00:00.000000000 +0300
+++ ./drivers/connector/.tmp_connector.ver	2005-04-11 16:16:39.753610904 +0400
@@ -0,0 +1,3 @@
+__crc_cn_add_callback = 0xdf3c19ec ;
+__crc_cn_del_callback = 0xff5a8cfe ;
+__crc_cn_netlink_send = 0xa53caf8b ;
--- /dev/null	2005-03-30 21:16:41.358774272 +0400
+++ ./include/linux/connector.h	2005-04-11 16:10:39.698347624 +0400
@@ -0,0 +1,166 @@
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
+#define CN_IDX_CONNECTOR		0xffffffff
+#define CN_VAL_CONNECTOR		0xffffffff
+
+
+/*
+ * Maximum connector's message size.
+ */
+#define CONNECTOR_MAX_MSG_SIZE 	1024
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
+	struct cb_id 		id;
+
+	__u32			seq;
+	__u32			ack;
+
+	__u32			len;		/* Length of the following data */
+	__u8			data[0];
+};
+
+/*
+ * Notify structure - requests notification about
+ * registering/unregistering idx/val in range [first, first+range].
+ */
+struct cn_notify_req
+{
+	__u32			first;
+	__u32			range;
+};
+
+/*
+ * Main notification control message
+ * *_notify_num 	- number of appropriate cn_notify_req structures after 
+ *				this struct.
+ * group 		- notification receiver's idx.
+ * len 			- total length of the attached data.
+ */
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
+int cn_netlink_send(struct cn_msg *, u32, int);
+
+int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id);
+
+struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *);
+void cn_queue_free_dev(struct cn_queue_dev *dev);
+
+int cn_cb_equal(struct cb_id *, struct cb_id *);
+
+#endif /* __KERNEL__ */
+#endif /* __CONNECTOR_H */
--- ./drivers/Kconfig.orig	2005-04-11 16:31:04.202194744 +0400
+++ ./drivers/Kconfig	2005-02-28 12:58:35.000000000 +0300
@@ -4,6 +4,8 @@
 
 source "drivers/base/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "drivers/mtd/Kconfig"
 
 source "drivers/parport/Kconfig"
--- ./drivers/Makefile.orig	2005-04-11 16:30:48.521578560 +0400
+++ ./drivers/Makefile	2005-02-28 12:58:35.000000000 +0300
@@ -17,6 +17,8 @@
 # default.
 obj-y				+= char/
 
+obj-$(CONFIG_CONNECTOR)	+= connector/
+
 # i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           += video/i810/
 obj-$(CONFIG_FB_INTEL)          += video/intelfb/
diff -Nru /tmp/empty/cn_test.c ./Documentation/connector/cn_test.c
--- /tmp/empty/cn_test.c	1970-01-01 03:00:00.000000000 +0300
+++ ./Documentation/connector/cn_test.c	2005-04-11 16:11:11.967441976 +0400
@@ -0,0 +1,203 @@
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
+#include <linux/timer.h>
+
+#include "connector.h"
+
+static struct cb_id cn_test_id = { 0x123, 0x456 };
+static char cn_test_name[] = "cn_test";
+static struct sock *nls;
+static struct timer_list cn_test_timer;
+
+void cn_test_callback(void *data)
+{
+	struct cn_msg *msg = (struct cn_msg *)data;
+
+	printk("%s: %lu: idx=%x, val=%x, seq=%u, ack=%u, len=%d: %s.\n",
+	       __func__, jiffies, msg->id.idx, msg->id.val, 
+	       msg->seq, msg->ack, msg->len, (char *)msg->data);
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
+	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - NLMSG_ALIGN(sizeof(*nlh)));
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
+	printk(KERN_INFO "Request was sent. Group=0x%x.\n", ctl->group);
+		
+	return 0;
+
+nlmsg_failure:
+	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static u32 cn_test_timer_counter;
+static void cn_test_timer_func(unsigned long __data)
+{
+	struct cn_msg *m;
+	char data[32];
+
+	m = kmalloc(sizeof(*m) + sizeof(data), GFP_ATOMIC);
+	if (m)
+	{
+		memset(m, 0, sizeof(*m) + sizeof(data));
+
+		memcpy(&m->id, &cn_test_id, sizeof(m->id));
+		m->seq = cn_test_timer_counter;
+		m->len = sizeof(data);
+
+		m->len = scnprintf(data, sizeof(data), "counter = %u", cn_test_timer_counter) + 1;
+
+		memcpy(m+1, data, m->len);
+		
+		cbus_insert(m, gfp_any());
+		//cn_netlink_send(m, gfp_any());
+		kfree(m);
+	}
+
+	cn_test_timer_counter++;
+
+	mod_timer(&cn_test_timer, jiffies + HZ);
+}
+
+static int cn_test_init(void)
+{
+	int err;
+#if 0
+	nls = netlink_kernel_create(NETLINK_TAPBASE + 1, NULL);
+	if (!nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u).\n", NETLINK_NFLOG);
+		return -EIO;
+	}
+
+	err = cn_test_want_notify();
+	if (err)
+		goto err_out;
+#endif
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
+	init_timer(&cn_test_timer);
+	cn_test_timer.function = cn_test_timer_func;
+	cn_test_timer.expires = jiffies + HZ;
+	cn_test_timer.data = 0;
+	add_timer(&cn_test_timer);
+
+	return 0;
+
+err_out:
+	if (nls && nls->sk_socket)
+		sock_release(nls->sk_socket);
+
+	return err;
+}
+
+static void cn_test_fini(void)
+{
+	del_timer_sync(&cn_test_timer);
+	cn_del_callback(&cn_test_id);
+	cn_test_id.val--;
+	cn_del_callback(&cn_test_id);
+	if (nls && nls->sk_socket)
+		sock_release(nls->sk_socket);
+}
+
+module_init(cn_test_init);
+module_exit(cn_test_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Connector's test module");
diff -Nru /tmp/empty/connector.txt ./Documentation/connector/connector.txt
--- /tmp/empty/connector.txt	1970-01-01 03:00:00.000000000 +0300
+++ ./Documentation/connector/connector.txt	2005-04-11 16:12:01.804865536 +0400
@@ -0,0 +1,155 @@
+/*****************************************/
+Kernel Connector.
+/*****************************************/
+
+Kernel connector - new netlink based userspace <-> kernel space easy to use communication module.
+
+Connector driver adds possibility to connect various agents using
+netlink based network.
+One must register callback and identifier. When driver receives
+special netlink message with appropriate identifier, appropriate
+callback will be called.
+
+From the userspace point of view it's quite straightforward:
+socket();
+bind();
+send();
+recv();
+
+But if kernelspace want to use full power of such connections, driver
+writer must create special sockets, must know about struct sk_buff
+handling...
+Connector allows any kernelspace agents to use netlink based
+networking for inter-process communication in a significantly easier
+way:
+
+int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *));
+void cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask);
+
+struct cb_id
+{
+	__u32			idx;
+	__u32			val;
+};
+
+idx and val are unique identifiers which must be registered in connector.h
+for in-kernel usage.
+void (*callback) (void *) - is a callback function which will be called
+when message with above idx.val will be received by connector core.
+Argument for that function must be dereferenced to struct cn_msg *.
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
+/*****************************************/
+Connector interfaces.
+/*****************************************/
+
+int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *));
+Registers new callback with connector core.
+
+struct cb_id *id 		- unique connector's user identifier.
+			  	  It must be registered in connector.h for legal in-kernel users.
+char *name 			- connector's callback symbolic name.
+void (*callback) (void *)	- connector's callback.
+				  Argument must be dereferenced to struct cn_msg *.
+
+void cn_del_callback(struct cb_id *id);
+Unregisters new callback with connector core.
+
+struct cb_id *id 		- unique connector's user identifier.
+
+void cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask);
+Sends message to the specified groups.
+It can be safely called from any context, but may silently
+fail under strong memory pressure.
+
+struct cn_msg *			- message header(with attached data).
+u32 __groups			- destination groups.
+				  If __groups is zero, then appropriate group will
+				  be searched through all registered connector users,
+				  and message will be delivered to the group which was
+				  created for user with the same ID as in msg.
+				  If __groups is not zero, then message will be delivered
+				  to the specified group.
+int gfp_mask			- GFP mask.
+
+Note: When registering new callback user, connector core assigns netlink group
+to the user which is equal to it's id.idx.
+
+/*****************************************/
+Protocol description.
+/*****************************************/
+
+Current offers transport layer with fixed header.
+Recommended protocol which uses such header is following:
+
+msg->seq and msg->ack are used to determine message genealogy.
+When someone sends message it puts there locally unique sequence
+and random acknowledge numbers.
+Sequence number may be copied into nlmsghdr->nlmsg_seq too.
+
+Sequence number is incremented with each message to be sent.
+
+If we expect reply to our message, then sequence number in received
+message MUST be the same as in original message, and acknowledge
+number MUST be the same + 1.
+
+If we receive message and it's sequence number is not equal to one
+we are expecting, then it is new message.
+If we receive message and it's sequence number is the same as one we
+are expecting, but it's acknowledge is not equal acknowledge number
+in original message + 1, then it is new message.
+
+Obviously, protocol header contains above id.
+
+connector allows event notification in the following form:
+kernel driver or userspace process can ask connector to notify it
+when selected id's will be turned on or off(registered or unregistered
+it's callback). It is done by sending special command to connector
+driver(it also registers itself with id={-1, -1}).
+
+As example of usage Documentation/connector now contains cn_test.c - 
+testing module which uses connector to request notification
+and to send messages.
+
+
+/*****************************************/
+CBUS.
+/*****************************************/
+
+This message bus allows message passing between different agents
+using connector's infrastructure.
+It is extremely fast for insert operations so it can be used in performance
+critical paths in any context instead of direct connector's methods calls.
+
+CBUS uses per CPU variables and thus allows message reordering,
+caller must be prepared (and use CPU id in it's messages).
+
+Usage is very simple - just call cbus_insert(struct cn_msg *msg, int gfp_mask);
+It can fail, so caller must check return value - zero on success
+and negative error code otherwise.
+
+Benchmark with modified fork connector and fork bomb on 2-way system
+did not show any differences between vanilla 2.6.11 and CBUS.
+
+
+
+/*****************************************/
+Reliability.
+/*****************************************/
+Netlink itself is not reliable protocol, 
+that means that messages can be lost
+due to memory pressure or process' receiving
+queue overflowed, so caller is warned 
+must be prepared. That is why struct cn_msg
+[main connector's message header] contains 
+u32 seq and u32 ack fields.

--
	Evgeniy Polyakov

Crash is better than data corruption. -- Artur Grabowski
