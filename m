Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWHQHVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWHQHVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWHQHVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:21:41 -0400
Received: from dea.vocord.ru ([217.67.177.50]:21978 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S932137AbWHQHVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:21:37 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [take11 3/3] kevent: Timer notifications.
In-Reply-To: <11558006133752@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Thu, 17 Aug 2006 11:43:33 +0400
Message-Id: <1155800613375@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timer notifications.

Timer notifications can be used for fine grained per-process time 
management, since interval timers are very inconvenient to use, 
and they are limited.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mitp.ru>

diff --git a/kernel/kevent/kevent_timer.c b/kernel/kevent/kevent_timer.c
new file mode 100644
index 0000000..5217cd1
--- /dev/null
+++ b/kernel/kevent/kevent_timer.c
@@ -0,0 +1,107 @@
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
+struct kevent_timer
+{
+	struct timer_list	ktimer;
+	struct kevent_storage	ktimer_storage;
+};
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
+static struct lock_class_key kevent_timer_key;
+
+static int kevent_timer_enqueue(struct kevent *k)
+{
+	int err;
+	struct kevent_timer *t;
+
+	t = kmalloc(sizeof(struct kevent_timer), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	setup_timer(&t->ktimer, &kevent_timer_func, (unsigned long)k);
+
+	err = kevent_storage_init(&t->ktimer, &t->ktimer_storage);
+	if (err)
+		goto err_out_free;
+	lockdep_set_class(&t->ktimer_storage.lock, &kevent_timer_key);
+
+	err = kevent_storage_enqueue(&t->ktimer_storage, k);
+	if (err)
+		goto err_out_st_fini;
+	
+	mod_timer(&t->ktimer, jiffies + msecs_to_jiffies(k->event.id.raw[0]));
+
+	return 0;
+
+err_out_st_fini:	
+	kevent_storage_fini(&t->ktimer_storage);
+err_out_free:
+	kfree(t);
+
+	return err;
+}
+
+static int kevent_timer_dequeue(struct kevent *k)
+{
+	struct kevent_storage *st = k->st;
+	struct kevent_timer *t = container_of(st, struct kevent_timer, ktimer_storage);
+
+	del_timer_sync(&t->ktimer);
+	kevent_storage_dequeue(st, k);
+	kfree(t);
+
+	return 0;
+}
+
+static int kevent_timer_callback(struct kevent *k)
+{
+	k->event.ret_data[0] = (__u32)jiffies;
+	return 1;
+}
+
+static int __init kevent_init_timer(void)
+{
+	struct kevent_callbacks tc = {
+		.callback = &kevent_timer_callback, 
+		.enqueue = &kevent_timer_enqueue, 
+		.dequeue = &kevent_timer_dequeue};
+
+	return kevent_add_callbacks(&tc, KEVENT_TIMER);
+}
+module_init(kevent_init_timer);

