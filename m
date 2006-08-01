Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWHAJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWHAJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWHAJKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:10:24 -0400
Received: from dea.vocord.ru ([217.67.177.50]:28331 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1751538AbWHAJKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:10:21 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: [take2 4/4] kevent: poll/select() notifications. Timer notifications.
In-Reply-To: <11544248453229@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Tue, 1 Aug 2006 13:34:05 +0400
Message-Id: <11544248451905@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes generic poll/select and timer notifications.

kevent_poll works simialr to epoll and has the same issues (callback
is invoked not from internal state machine of the caller, but through
process awake).

Timer notifications can be used for fine grained per-process time 
management, since iteractive timers are very inconveniently to use, 
and they are limited.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mitp.ru>

diff --git a/kernel/kevent/kevent_poll.c b/kernel/kevent/kevent_poll.c
new file mode 100644
index 0000000..4950e7c
--- /dev/null
+++ b/kernel/kevent/kevent_poll.c
@@ -0,0 +1,223 @@
+/*
+ * 	kevent_poll.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/file.h>
+#include <linux/kevent.h>
+#include <linux/poll.h>
+#include <linux/fs.h>
+
+static kmem_cache_t *kevent_poll_container_cache;
+static kmem_cache_t *kevent_poll_priv_cache;
+
+struct kevent_poll_ctl
+{
+	struct poll_table_struct 	pt;
+	struct kevent			*k;
+};
+
+struct kevent_poll_wait_container
+{
+	struct list_head		container_entry;
+	wait_queue_head_t		*whead;
+	wait_queue_t			wait;
+	struct kevent			*k;
+};
+
+struct kevent_poll_private
+{
+	struct list_head		container_list;
+	spinlock_t			container_lock;
+};
+
+static int kevent_poll_enqueue(struct kevent *k);
+static int kevent_poll_dequeue(struct kevent *k);
+static int kevent_poll_callback(struct kevent *k);
+
+static int kevent_poll_wait_callback(wait_queue_t *wait, 
+		unsigned mode, int sync, void *key)
+{
+	struct kevent_poll_wait_container *cont = 
+		container_of(wait, struct kevent_poll_wait_container, wait);
+	struct kevent *k = cont->k;
+	struct file *file = k->st->origin;
+	unsigned long flags;
+	u32 revents, event;
+
+	revents = file->f_op->poll(file, NULL);
+	spin_lock_irqsave(&k->lock, flags);
+	event = k->event.event;
+	spin_unlock_irqrestore(&k->lock, flags);
+
+	kevent_storage_ready(k->st, NULL, revents);
+
+	return 0;
+}
+
+static void kevent_poll_qproc(struct file *file, wait_queue_head_t *whead, 
+		struct poll_table_struct *poll_table)
+{
+	struct kevent *k = 
+		container_of(poll_table, struct kevent_poll_ctl, pt)->k;
+	struct kevent_poll_private *priv = k->priv;
+	struct kevent_poll_wait_container *cont;
+	unsigned long flags;
+
+	cont = kmem_cache_alloc(kevent_poll_container_cache, SLAB_KERNEL);
+	if (!cont) {
+		kevent_break(k);
+		return;
+	}
+		
+	cont->k = k;
+	init_waitqueue_func_entry(&cont->wait, kevent_poll_wait_callback);
+	cont->whead = whead;
+
+	spin_lock_irqsave(&priv->container_lock, flags);
+	list_add_tail(&cont->container_entry, &priv->container_list);
+	spin_unlock_irqrestore(&priv->container_lock, flags);
+
+	add_wait_queue(whead, &cont->wait);
+}
+
+static int kevent_poll_enqueue(struct kevent *k)
+{
+	struct file *file;
+	int err, ready = 0;
+	unsigned int revents;
+	struct kevent_poll_ctl ctl;
+	struct kevent_poll_private *priv;
+
+	file = fget(k->event.id.raw[0]);
+	if (!file)
+		return -ENODEV;
+
+	err = -EINVAL;
+	if (!file->f_op || !file->f_op->poll)
+		goto err_out_fput;
+
+	err = -ENOMEM;
+	priv = kmem_cache_alloc(kevent_poll_priv_cache, SLAB_KERNEL);
+	if (!priv)
+		goto err_out_fput;
+
+	spin_lock_init(&priv->container_lock);
+	INIT_LIST_HEAD(&priv->container_list);
+
+	k->priv = priv;
+
+	ctl.k = k;
+	init_poll_funcptr(&ctl.pt, &kevent_poll_qproc);
+
+	err = kevent_storage_enqueue(&file->st, k);
+	if (err)
+		goto err_out_free;
+
+	revents = file->f_op->poll(file, &ctl.pt);
+	if (revents & k->event.event) {
+		ready = 1;
+		kevent_poll_dequeue(k);
+	}
+	
+	return ready;
+
+err_out_free:
+	kmem_cache_free(kevent_poll_priv_cache, priv);
+err_out_fput:
+	fput(file);
+	return err;
+}
+
+static int kevent_poll_dequeue(struct kevent *k)
+{
+	struct file *file = k->st->origin;
+	struct kevent_poll_private *priv = k->priv;
+	struct kevent_poll_wait_container *w, *n;
+	unsigned long flags;
+
+	kevent_storage_dequeue(k->st, k);
+
+	spin_lock_irqsave(&priv->container_lock, flags);
+	list_for_each_entry_safe(w, n, &priv->container_list, container_entry) {
+		list_del(&w->container_entry);
+		remove_wait_queue(w->whead, &w->wait);
+		kmem_cache_free(kevent_poll_container_cache, w);
+	}
+	spin_unlock_irqrestore(&priv->container_lock, flags);
+	
+	kmem_cache_free(kevent_poll_priv_cache, priv);
+	k->priv = NULL;
+	
+	fput(file);
+
+	return 0;
+}
+
+static int kevent_poll_callback(struct kevent *k)
+{
+	struct file *file = k->st->origin;
+	unsigned int revents = file->f_op->poll(file, NULL);
+	return (revents & k->event.event);
+}
+
+int kevent_init_poll(struct kevent *k)
+{
+	if (!kevent_poll_container_cache || !kevent_poll_priv_cache)
+		return -ENOMEM;
+
+	k->enqueue = &kevent_poll_enqueue;
+	k->dequeue = &kevent_poll_dequeue;
+	k->callback = &kevent_poll_callback;
+	return 0;
+}
+
+
+static int __init kevent_poll_sys_init(void)
+{
+	kevent_poll_container_cache = kmem_cache_create("kevent_poll_container_cache", 
+			sizeof(struct kevent_poll_wait_container), 0, 0, NULL, NULL);
+	if (!kevent_poll_container_cache) {
+		printk(KERN_ERR "Failed to create kevent poll container cache.\n");
+		return -ENOMEM;
+	}
+	
+	kevent_poll_priv_cache = kmem_cache_create("kevent_poll_priv_cache", 
+			sizeof(struct kevent_poll_private), 0, 0, NULL, NULL);
+	if (!kevent_poll_priv_cache) {
+		printk(KERN_ERR "Failed to create kevent poll private data cache.\n");
+		kmem_cache_destroy(kevent_poll_container_cache);
+		kevent_poll_container_cache = NULL;
+		return -ENOMEM;
+	}
+
+	printk(KERN_INFO "Kevent poll()/select() subsystem has been initialized.\n");
+	return 0;
+}
+
+static void __exit kevent_poll_sys_fini(void)
+{
+	kmem_cache_destroy(kevent_poll_priv_cache);
+	kmem_cache_destroy(kevent_poll_container_cache);
+}
+
+module_init(kevent_poll_sys_init);
+module_exit(kevent_poll_sys_fini);
diff --git a/kernel/kevent/kevent_timer.c b/kernel/kevent/kevent_timer.c
new file mode 100644
index 0000000..53d3bdf
--- /dev/null
+++ b/kernel/kevent/kevent_timer.c
@@ -0,0 +1,112 @@
+/*
+ * 	kevent_timer.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
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
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/kevent.h>
+
+static void kevent_timer_func(unsigned long data)
+{
+	struct kevent *k = (struct kevent *)data;
+	struct timer_list *t = k->st->origin;
+
+	kevent_storage_ready(k->st, NULL, KEVENT_MASK_ALL);
+	mod_timer(t, jiffies + msecs_to_jiffies(k->event.id.raw[0]));
+}
+
+static int kevent_timer_enqueue(struct kevent *k)
+{
+	struct timer_list *t;
+	struct kevent_storage *st;
+	int err;
+
+	t = kmalloc(sizeof(struct timer_list) + sizeof(struct kevent_storage), 
+			GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	init_timer(t);
+	t->function = kevent_timer_func;
+	t->expires = jiffies + msecs_to_jiffies(k->event.id.raw[0]);
+	t->data = (unsigned long)k;
+
+	st = (struct kevent_storage *)(t+1);
+	err = kevent_storage_init(t, st);
+	if (err)
+		goto err_out_free;
+
+	err = kevent_storage_enqueue(st, k);
+	if (err)
+		goto err_out_st_fini;
+	
+	add_timer(t);
+
+	return 0;
+
+err_out_st_fini:	
+	kevent_storage_fini(st);
+err_out_free:
+	kfree(t);
+
+	return err;
+}
+
+static int kevent_timer_dequeue(struct kevent *k)
+{
+	struct kevent_storage *st = k->st;
+	struct timer_list *t = st->origin;
+
+	if (!t)
+		return -ENODEV;
+
+	del_timer_sync(t);
+	
+	kevent_storage_dequeue(st, k);
+	
+	kfree(t);
+
+	return 0;
+}
+
+static int kevent_timer_callback(struct kevent *k)
+{
+	struct kevent_storage *st = k->st;
+	struct timer_list *t = st->origin;
+
+	if (!t)
+		return -ENODEV;
+	
+	k->event.ret_data[0] = (__u32)jiffies;
+	return 1;
+}
+
+int kevent_init_timer(struct kevent *k)
+{
+	k->enqueue = &kevent_timer_enqueue;
+	k->dequeue = &kevent_timer_dequeue;
+	k->callback = &kevent_timer_callback;
+	return 0;
+}


