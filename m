Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVCGUd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCGUd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVCGUcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:32:16 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:6321 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261775AbVCGUMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:32 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [12/many] acrypto: crypto_route.h
In-Reply-To: <11102278541439@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:34 +0300
Message-Id: <11102278541968@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_route.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_route.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,242 @@
+/*
+ * 	crypto_route.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __CRYPTO_ROUTE_H
+#define __CRYPTO_ROUTE_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "acrypto.h"
+
+static inline struct crypto_route *crypto_route_alloc_direct(struct crypto_device *dev,
+							     struct crypto_session_initializer *ci)
+{
+	struct crypto_route *rt;
+
+	rt = kmalloc(sizeof(*rt), GFP_ATOMIC);
+	if (!rt) {
+		crypto_device_put(dev);
+		return NULL;
+	}
+
+	memset(rt, 0, sizeof(*rt));
+	memcpy(&rt->ci, ci, sizeof(*ci));
+
+	rt->dev = dev;
+
+	return rt;
+}
+
+static inline struct crypto_route *crypto_route_alloc(struct crypto_device *dev,
+							struct crypto_session_initializer *ci)
+{
+	struct crypto_route *rt;
+
+	if (!match_initializer(dev, ci))
+		return NULL;
+
+	rt = crypto_route_alloc_direct(dev, ci);
+
+	return rt;
+}
+
+static inline void crypto_route_free(struct crypto_route *rt)
+{
+	crypto_device_put(rt->dev);
+	rt->dev = NULL;
+	kfree(rt);
+}
+
+static inline void __crypto_route_del(struct crypto_route *rt, struct crypto_route_head *list)
+{
+	struct crypto_route *next, *prev;
+
+	list->qlen--;
+	next = rt->next;
+	prev = rt->prev;
+	rt->next = rt->prev = NULL;
+	rt->list = NULL;
+	next->prev = prev;
+	prev->next = next;
+}
+
+static inline void crypto_route_del(struct crypto_route *rt)
+{
+	struct crypto_route_head *list = rt->list;
+
+	if (list) {
+		spin_lock_irq(&list->lock);
+		if (list == rt->list)
+			__crypto_route_del(rt, rt->list);
+		spin_unlock_irq(&list->lock);
+
+		crypto_route_free(rt);
+	}
+}
+
+static inline struct crypto_route *__crypto_route_dequeue(struct crypto_route_head *list)
+{
+	struct crypto_route *next, *prev, *result;
+
+	prev = (struct crypto_route *)list;
+	next = prev->next;
+	result = NULL;
+	if (next != prev) {
+		result = next;
+		next = next->next;
+		list->qlen--;
+		next->prev = prev;
+		prev->next = next;
+		result->next = result->prev = NULL;
+		result->list = NULL;
+	}
+	return result;
+}
+
+static inline struct crypto_route *crypto_route_dequeue(struct crypto_session *s)
+{
+	struct crypto_route *rt;
+
+	spin_lock_irq(&s->route_list.lock);
+
+	rt = __crypto_route_dequeue(&s->route_list);
+
+	spin_unlock_irq(&s->route_list.lock);
+
+	return rt;
+}
+
+static inline void __crypto_route_queue(struct crypto_route *rt, struct crypto_route_head *list)
+{
+	struct crypto_route *prev, *next;
+
+	rt->list = list;
+	list->qlen++;
+	next = (struct crypto_route *)list;
+	prev = next->prev;
+	rt->next = next;
+	rt->prev = prev;
+	next->prev = prev->next = rt;
+}
+
+static inline void crypto_route_queue(struct crypto_route *rt, struct crypto_session *s)
+{
+
+	spin_lock_irq(&s->route_list.lock);
+
+	__crypto_route_queue(rt, &s->route_list);
+
+	spin_unlock_irq(&s->route_list.lock);
+}
+
+static inline int crypto_route_add(struct crypto_device *dev, struct crypto_session *s, 
+						struct crypto_session_initializer *ci)
+{
+	struct crypto_route *rt;
+
+	rt = crypto_route_alloc(dev, ci);
+	if (!rt)
+		return -ENOMEM;
+
+	crypto_route_queue(rt, s);
+
+	return 0;
+}
+
+static inline int crypto_route_add_direct(struct crypto_device *dev, struct crypto_session *s,
+						struct crypto_session_initializer *ci)
+{
+	struct crypto_route *rt;
+
+	rt = crypto_route_alloc_direct(dev, ci);
+	if (!rt)
+		return -ENOMEM;
+
+	crypto_route_queue(rt, s);
+
+	return 0;
+}
+
+static inline int crypto_route_queue_len(struct crypto_session *s)
+{
+	return s->route_list.qlen;
+}
+
+static inline void crypto_route_head_init(struct crypto_route_head *list)
+{
+	spin_lock_init(&list->lock);
+	list->prev = list->next = (struct crypto_route *)list;
+	list->qlen = 0;
+}
+
+static inline struct crypto_route *__crypto_route_current(struct crypto_route_head *list)
+{
+	struct crypto_route *next, *prev, *result;
+
+	prev = (struct crypto_route *)list;
+	next = prev->next;
+	result = NULL;
+	if (next != prev)
+		result = next;
+
+	return result;
+}
+
+static inline struct crypto_route *crypto_route_current(struct crypto_session *s)
+{
+	struct crypto_route_head *list;
+	struct crypto_route *rt = NULL;
+
+	list = &s->route_list;
+
+	if (list) {
+		spin_lock_irq(&list->lock);
+
+		rt = __crypto_route_current(list);
+
+		spin_unlock_irq(&list->lock);
+	}
+
+	return rt;
+}
+
+static inline struct crypto_device *crypto_route_get_current_device(struct crypto_session *s)
+{
+	struct crypto_route *rt = NULL;
+	struct crypto_device *dev = NULL;
+	struct crypto_route_head *list = &s->route_list;
+
+	spin_lock_irq(&list->lock);
+
+	rt = __crypto_route_current(list);
+	if (rt) {
+		dev = rt->dev;
+		crypto_device_get(dev);
+	}
+
+	spin_unlock_irq(&list->lock);
+
+	return dev;
+}
+
+#endif				/* __CRYPTO_ROUTE_H */

