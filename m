Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965468AbWKGQws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965468AbWKGQws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWKGQve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:51:34 -0500
Received: from dea.vocord.ru ([217.67.177.50]:29351 "EHLO
	kano.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S965357AbWKGQv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:51:27 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: [take23 3/5] kevent: poll/select() notifications.
In-Reply-To: <11629182482529@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Tue, 7 Nov 2006 19:50:48 +0300
Message-Id: <11629182482792@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


poll/select() notifications.

This patch includes generic poll/select notifications.
kevent_poll works simialr to epoll and has the same issues (callback
is invoked not from internal state machine of the caller, but through
process awake, a lot of allocations and so on).

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mitp.ru>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5baf3a1..f81299f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -276,6 +276,7 @@ #include <linux/prio_tree.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/kevent.h>
 
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
@@ -586,6 +587,10 @@ #ifdef CONFIG_INOTIFY
 	struct mutex		inotify_mutex;	/* protects the watches list */
 #endif
 
+#ifdef CONFIG_KEVENT_SOCKET
+	struct kevent_storage	st;
+#endif
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
@@ -739,6 +744,9 @@ #ifdef CONFIG_EPOLL
 	struct list_head	f_ep_links;
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
+#ifdef CONFIG_KEVENT_POLL
+	struct kevent_storage	st;
+#endif
 	struct address_space	*f_mapping;
 };
 extern spinlock_t files_lock;
diff --git a/kernel/kevent/kevent_poll.c b/kernel/kevent/kevent_poll.c
new file mode 100644
index 0000000..94facbb
--- /dev/null
+++ b/kernel/kevent/kevent_poll.c
@@ -0,0 +1,222 @@
+/*
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
+	u32 revents;
+
+	revents = file->f_op->poll(file, NULL);
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
+		return -EBADF;
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
+
+	k->event.ret_data[0] = revents & k->event.event;
+
+	return (revents & k->event.event);
+}
+
+static int __init kevent_poll_sys_init(void)
+{
+	struct kevent_callbacks pc = {
+		.callback = &kevent_poll_callback,
+		.enqueue = &kevent_poll_enqueue,
+		.dequeue = &kevent_poll_dequeue};
+
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
+	kevent_add_callbacks(&pc, KEVENT_POLL);
+
+	printk(KERN_INFO "Kevent poll()/select() subsystem has been initialized.\n");
+	return 0;
+}
+
+static struct lock_class_key kevent_poll_key;
+
+void kevent_poll_reinit(struct file *file)
+{
+	lockdep_set_class(&file->st.lock, &kevent_poll_key);
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

