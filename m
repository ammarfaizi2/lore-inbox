Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVCTH6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVCTH6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 02:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVCTH6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 02:58:45 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:8383 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262043AbVCTH6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 02:58:16 -0500
Date: Sun, 20 Mar 2005 11:23:36 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
Subject: [1/1] CBUS: new very fast (for insert operations) message bus based
 on kenel connector.
Message-ID: <20050320112336.2b082e27@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sun, 20 Mar 2005 10:56:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, developers.

I'm pleased to annouce CBUS - ultra fast (for insert operations)
message bus.

This message bus allows message passing between different agents
using connector's infrastructure.
It is extremly fast for insert operations so it can be used in performance
critical pathes instead of direct connector's methods calls.

CBUS uses per CPU variables and thus allows message reordering,
caller must be prepared (and use CPU id in it's messages).

Usage is very simple - just call cbus_insert(struct cn_msg *msg);

Benchmark with modified fork connector and fork bomb on 2-way system
did not show any differencies between vanilla 2.6.11 and CBUS.

--- ./drivers/connector/Kconfig.orig	2005-03-20 11:11:27.000000000 +0300
+++ ./drivers/connector/Kconfig	2005-03-20 11:15:16.000000000 +0300
@@ -10,4 +10,18 @@
 	  Connector support can also be built as a module.  If so, the module
 	  will be called cn.ko.
 
+config CBUS
+	tristate "CBUS - ultra fast (for insert operations) message bus based on connector"
+	depends on CONNECTOR
+	---help---
+	  This message bus allows message passing between different agents
+	  using connector's infrastructure.
+	  It is extremly fast for insert operations so it can be used in performance
+	  critical pathes instead of direct connector's methods calls.
+
+	  CBUS uses per CPU variables and thus allows message reordering,
+	  caller must be prepared (and use CPU id in it's messages).
+	  
+	  CBUS support can also be built as a module.  If so, the module
+	  will be called cbus.
 endmenu
--- ./drivers/connector/Makefile.orig	2005-03-20 11:10:59.000000000 +0300
+++ ./drivers/connector/Makefile	2005-03-20 11:11:17.000000000 +0300
@@ -1,2 +1,3 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
+obj-$(CONFIG_CBUS)		+= cbus.o
 cn-objs		:= cn_queue.o connector.o
--- /dev/null	2004-09-17 14:58:06.000000000 +0400
+++ ./drivers/connector/cbus.c	2005-03-20 11:09:25.000000000 +0300
@@ -0,0 +1,247 @@
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
+static int cbus_enqueue(struct cbus_event_container *c, struct cn_msg *msg)
+{
+	int err;
+	struct cbus_event *event;
+	unsigned long flags;
+
+	event = kmalloc(sizeof(*event) + msg->len, GFP_ATOMIC);
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
+	__cbus_enqueue(c, event);
+	spin_unlock_irqrestore(&c->event_lock, flags);
+
+	//wake_up_interruptible(&cbus_wait_queue);
+
+	return 0;
+
+err_out_exit:
+	return err;
+}
+
+int cbus_insert(struct cn_msg *msg)
+{
+	struct cbus_event_container *c;
+	int err;
+
+	preempt_disable();
+	c = &__get_cpu_var(cbus_event_list);
+	
+	err = cbus_enqueue(c, msg);
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
+		cn_netlink_send(&event->msg, 0);
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
+			interruptible_sleep_on_timeout(&cbus_wait_queue, 10);
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
+	if (IS_ERR((void *)cbus_pid)) {
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



	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
