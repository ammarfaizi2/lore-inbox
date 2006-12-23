Return-Path: <linux-kernel-owner+w=401wt.eu-S1753596AbWLWQwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbWLWQwQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 11:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbWLWQwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 11:52:12 -0500
Received: from dea.vocord.ru ([217.67.177.50]:33164 "EHLO
	kano.factory.vocord.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753596AbWLWQwJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 11:52:09 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: [take29 5/8] kevent: Timer notifications.
In-Reply-To: <11668927012580@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Sat, 23 Dec 2006 19:51:41 +0300
Message-Id: <1166892701836@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Timer notifications.

Timer notifications can be used for fine grained per-process time 
management, since interval timers are very inconvenient to use, 
and they are limited.

This subsystem uses high-resolution timers.
id.raw[0] is used as number of seconds
id.raw[1] is used as number of nanoseconds

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/kernel/kevent/kevent_timer.c b/kernel/kevent/kevent_timer.c
new file mode 100644
index 0000000..c21a155
--- /dev/null
+++ b/kernel/kevent/kevent_timer.c
@@ -0,0 +1,114 @@
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
+#include <linux/hrtimer.h>
+#include <linux/jiffies.h>
+#include <linux/kevent.h>
+
+struct kevent_timer
+{
+	struct hrtimer		ktimer;
+	struct kevent_storage	ktimer_storage;
+	struct kevent		*ktimer_event;
+};
+
+static int kevent_timer_func(struct hrtimer *timer)
+{
+	struct kevent_timer *t = container_of(timer, struct kevent_timer, ktimer);
+	struct kevent *k = t->ktimer_event;
+
+	kevent_storage_ready(&t->ktimer_storage, NULL, KEVENT_MASK_ALL);
+	hrtimer_forward(timer, timer->base->softirq_time,
+			ktime_set(k->event.id.raw[0], k->event.id.raw[1]));
+	return HRTIMER_RESTART;
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
+	hrtimer_init(&t->ktimer, CLOCK_MONOTONIC, HRTIMER_REL);
+	t->ktimer.expires = ktime_set(k->event.id.raw[0], k->event.id.raw[1]);
+	t->ktimer.function = kevent_timer_func;
+	t->ktimer_event = k;
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
+	hrtimer_start(&t->ktimer, t->ktimer.expires, HRTIMER_REL);
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
+	hrtimer_cancel(&t->ktimer);
+	kevent_storage_dequeue(st, k);
+	kfree(t);
+
+	return 0;
+}
+
+static int kevent_timer_callback(struct kevent *k)
+{
+	k->event.ret_data[0] = jiffies_to_msecs(jiffies);
+	return 1;
+}
+
+static int __init kevent_init_timer(void)
+{
+	struct kevent_callbacks tc = {
+		.callback = &kevent_timer_callback,
+		.enqueue = &kevent_timer_enqueue,
+		.dequeue = &kevent_timer_dequeue,
+		.flags = 0,
+	};
+
+	return kevent_add_callbacks(&tc, KEVENT_TIMER);
+}
+module_init(kevent_init_timer);
+

