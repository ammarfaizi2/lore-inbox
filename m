Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVCGU3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVCGU3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVCGU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:28:58 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:1201 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261771AbVCGUMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:30 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [3/many] acrypto: acrypto.h
In-Reply-To: <1110227853321@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <11102278533380@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/acrypto.h	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/acrypto.h	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,245 @@
+/*
+ * 	acrypto.h
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
+#ifndef __ACRYPTO_H
+#define __ACRYPTO_H
+
+#define SCACHE_NAMELEN		32
+
+struct crypto_session_initializer;
+struct crypto_data;
+typedef void (*crypto_callback_t) (struct crypto_session_initializer *,
+				   struct crypto_data *);
+
+struct crypto_device_stat 
+{
+	__u64 scompleted;
+	__u64 sfinished;
+	__u64 sstarted;
+	__u64 kmem_failed;
+	__u64 pool_failed;
+};
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/mempool.h>
+
+#include <asm/scatterlist.h>
+
+#define DEBUG
+#ifdef DEBUG
+#define dprintk(f, a...) printk(f, ##a)
+#define dprintka(f, a...) printk(f, ##a)
+#else
+#define dprintk(f, a...)
+#define dprintka(f, a...)
+#endif
+
+extern void crypto_wake_lb(void);
+
+#define SESSION_COMPLETED	(1<<15)
+#define SESSION_FINISHED	(1<<14)
+#define SESSION_STARTED		(1<<13)
+#define SESSION_PROCESSED	(1<<12)
+#define SESSION_BINDED		(1<<11)
+#define SESSION_BROKEN		(1<<10)
+#define SESSION_FROM_CACHE	(1<<9)
+
+#define session_completed(s)	(s->ci.flags & SESSION_COMPLETED)
+#define complete_session(s)	do {s->ci.flags |= SESSION_COMPLETED;} while(0)
+#define uncomplete_session(s)	do {s->ci.flags &= ~SESSION_COMPLETED;} while (0)
+
+#define session_finished(s)	(s->ci.flags & SESSION_FINISHED)
+#define finish_session(s)	do {s->ci.flags |= SESSION_FINISHED;} while(0)
+#define unfinish_session(s)	do {s->ci.flags &= ~SESSION_FINISHED;} while (0)
+
+#define session_started(s)	(s->ci.flags & SESSION_STARTED)
+#define start_session(s)	do {s->ci.flags |= SESSION_STARTED;} while(0)
+#define unstart_session(s)	do {s->ci.flags &= ~SESSION_STARTED;} while (0)
+
+#define session_is_processed(s)		(s->ci.flags & SESSION_PROCESSED)
+#define start_process_session(s)	do {s->ci.flags |= SESSION_PROCESSED; s->ci.ptime = jiffies;} while(0)
+#define stop_process_session(s)		do {s->ci.flags &= ~SESSION_PROCESSED; s->ci.ptime = jiffies - s->ci.ptime; crypto_wake_lb();} while (0)
+
+#define session_binded(s)	(s->ci.flags & SESSION_BINDED)
+#define bind_session(s)		do {s->ci.flags |= SESSION_BINDED;} while(0)
+#define unbind_session(s)	do {s->ci.flags &= ~SESSION_BINDED;} while (0)
+#define sci_binded(ci)		(ci->flags & SESSION_BINDED)
+
+#define session_broken(s)	(s->ci.flags & SESSION_BROKEN)
+#define broke_session(s)	do {s->ci.flags |= SESSION_BROKEN;} while(0)
+#define unbroke_session(s)	do {s->ci.flags &= ~SESSION_BROKEN;} while (0)
+
+#define session_from_cache(s)		(s->ci.flags & SESSION_FROM_CACHE)
+#define mark_session_from_cache(s)	do {s->ci.flags |= SESSION_FROM_CACHE;} while(0)
+
+#define CRYPTO_MAX_PRIV_SIZE	1024
+
+#define DEVICE_BROKEN		(1<<0)
+
+#define device_broken(dev)	(dev->flags & DEVICE_BROKEN)
+#define broke_device(dev)	do {dev->flags |= DEVICE_BROKEN;} while(0)
+#define repair_device(dev)	do {dev->flags &= ~DEVICE_BROKEN;} while(0)
+
+struct crypto_capability {
+	u16 			operation;
+	u16 			type;
+	u16 			mode;
+	u16 			qlen;
+	u64 			ptime;
+	u64 			scomp;
+};
+
+struct crypto_session_initializer {
+	u16 			operation;
+	u16 			type;
+	u16 			mode;
+	u16 			priority;
+
+	u64 			id;
+	u64 			dev_id;
+
+	u32 			flags;
+
+	u32 			bdev;
+
+	u64 			ptime;
+
+	crypto_callback_t 	callback;
+};
+
+struct crypto_data {
+	struct			scatterlist *sg_src;
+	int 			sg_src_num;
+	struct			scatterlist *sg_dst;
+	int 			sg_dst_num;
+	struct			scatterlist *sg_key;
+	int 			sg_key_num;
+	struct			scatterlist *sg_iv;
+	int 			sg_iv_num;
+
+	void 			*priv;
+	unsigned int 		priv_size;
+};
+
+struct crypto_device {
+	char 			name[SCACHE_NAMELEN];
+
+	spinlock_t 		session_lock;
+	struct list_head 	session_list;
+
+	u64 			sid;
+	spinlock_t 		lock;
+
+	atomic_t 		refcnt;
+
+	u32 			flags;
+
+	u32 			id;
+
+	struct list_head 	cdev_entry;
+
+	void 			(*data_ready)(struct crypto_device *);
+
+	struct device_driver 	*driver;
+	struct device 		device;
+	struct class_device 	class_device;
+	struct completion 	dev_released;
+
+	spinlock_t 		stat_lock;
+	struct crypto_device_stat stat;
+
+	struct crypto_capability *cap;
+	int 			cap_number;
+
+	void 			*priv;
+
+	mempool_t		*session_pool;
+	kmem_cache_t		*session_cache;
+};
+
+struct crypto_route_head {
+	struct crypto_route 	*next;
+	struct crypto_route 	*prev;
+
+	__u32 			qlen;
+	spinlock_t 		lock;
+};
+
+struct crypto_route {
+	struct crypto_route 	*next;
+	struct crypto_route 	*prev;
+
+	struct crypto_route_head *list;
+	struct crypto_device 	*dev;
+
+	struct crypto_session_initializer ci;
+};
+
+struct crypto_session {
+	struct list_head 	dev_queue_entry;
+	struct list_head	main_queue_entry;
+
+	struct crypto_session_initializer ci;
+
+	struct crypto_data 	data;
+
+	spinlock_t 		lock;
+
+	struct work_struct 	work;
+
+	struct crypto_route_head route_list;
+
+	struct crypto_device 	*pool_dev;
+};
+
+struct crypto_session *crypto_session_alloc(struct crypto_session_initializer *, struct crypto_data *);
+struct crypto_session *crypto_session_create(struct crypto_session_initializer *, struct crypto_data *);
+void crypto_session_destroy(struct crypto_session *);
+void crypto_session_add(struct crypto_session *);
+void crypto_session_dequeue_main(struct crypto_session *);
+void __crypto_session_dequeue_main(struct crypto_session *);
+void __crypto_session_dequeue_route(struct crypto_session *);
+void crypto_session_dequeue_route(struct crypto_session *);
+
+void crypto_device_get(struct crypto_device *);
+void crypto_device_put(struct crypto_device *);
+struct crypto_device *crypto_device_get_name(char *);
+
+int __crypto_device_add(struct crypto_device *);
+int crypto_device_add(struct crypto_device *);
+void __crypto_device_remove(struct crypto_device *);
+void crypto_device_remove(struct crypto_device *);
+int match_initializer(struct crypto_device *, struct crypto_session_initializer *);
+int __match_initializer(struct crypto_capability *, struct crypto_session_initializer *);
+
+void crypto_session_insert_main(struct crypto_device *dev, struct crypto_session *s);
+void crypto_session_insert(struct crypto_device *dev, struct crypto_session *s);
+void __crypto_session_insert(struct crypto_device *dev, struct crypto_session *s);
+
+#endif				/* __KERNEL__ */
+#endif				/* __ACRYPTO_H */

