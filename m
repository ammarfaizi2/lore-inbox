Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCHCnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCHCnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVCGUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:39:18 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:9393 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261781AbVCGUMh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:37 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [9/many] acrypto: crypto_lb.c
In-Reply-To: <1110227854480@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:34 +0300
Message-Id: <1110227854957@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_lb.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_lb.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,634 @@
+/*
+ * 	crypto_lb.c
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/err.h>
+
+#include "acrypto.h"
+#include "crypto_lb.h"
+#include "crypto_stat.h"
+#include "crypto_route.h"
+
+static LIST_HEAD(crypto_lb_list);
+static spinlock_t crypto_lb_lock = SPIN_LOCK_UNLOCKED;
+static int lb_num = 0;
+static struct crypto_lb *current_lb, *default_lb;
+static struct completion thread_exited;
+static int need_exit;
+static struct workqueue_struct *crypto_lb_queue;
+static DECLARE_WAIT_QUEUE_HEAD(crypto_lb_wait_queue);
+
+extern struct list_head *crypto_device_list;
+extern spinlock_t *crypto_device_lock;
+
+extern int force_lb_remove;
+extern struct crypto_device main_crypto_device;
+
+static int lb_is_current(struct crypto_lb *l)
+{
+	return (l->crypto_device_list != NULL && l->crypto_device_lock != NULL);
+}
+
+static int lb_is_default(struct crypto_lb *l)
+{
+	return (l == default_lb);
+}
+
+static void __lb_set_current(struct crypto_lb *l)
+{
+	struct crypto_lb *c = current_lb;
+
+	if (c) {
+		l->crypto_device_list = crypto_device_list;
+		l->crypto_device_lock = crypto_device_lock;
+		current_lb = l;
+		c->crypto_device_list = NULL;
+		c->crypto_device_lock = NULL;
+	} else {
+		l->crypto_device_list = crypto_device_list;
+		l->crypto_device_lock = crypto_device_lock;
+		current_lb = l;
+	}
+}
+
+static void lb_set_current(struct crypto_lb *l)
+{
+	struct crypto_lb *c = current_lb;
+
+	if (c) {
+		spin_lock_irq(&c->lock);
+		__lb_set_current(l);
+		spin_unlock_irq(&c->lock);
+	} else
+		__lb_set_current(l);
+}
+
+static void __lb_set_default(struct crypto_lb *l)
+{
+	default_lb = l;
+}
+
+static void lb_set_default(struct crypto_lb *l)
+{
+	struct crypto_lb *c = default_lb;
+
+	if (c) {
+		spin_lock_irq(&c->lock);
+		__lb_set_default(l);
+		spin_unlock_irq(&c->lock);
+	} else
+		__lb_set_default(l);
+}
+
+static int crypto_lb_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int crypto_lb_probe(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static int crypto_lb_remove(struct device *dev)
+{
+	return 0;
+}
+
+static void crypto_lb_release(struct device *dev)
+{
+	struct crypto_lb *d = container_of(dev, struct crypto_lb, device);
+
+	complete(&d->dev_released);
+}
+
+static void crypto_lb_class_release(struct class *class)
+{
+}
+
+static void crypto_lb_class_release_device(struct class_device *class_dev)
+{
+}
+
+struct class crypto_lb_class = {
+	.name 		= "crypto_lb",
+	.class_release 	= crypto_lb_class_release,
+	.release 	= crypto_lb_class_release_device
+};
+
+struct bus_type crypto_lb_bus_type = {
+	.name 		= "crypto_lb",
+	.match 		= crypto_lb_match
+};
+
+struct device_driver crypto_lb_driver = {
+	.name 		= "crypto_lb_driver",
+	.bus 		= &crypto_lb_bus_type,
+	.probe 		= crypto_lb_probe,
+	.remove 	= crypto_lb_remove,
+};
+
+struct device crypto_lb_dev = {
+	.parent 	= NULL,
+	.bus 		= &crypto_lb_bus_type,
+	.bus_id 	= "crypto load balancer",
+	.driver 	= &crypto_lb_driver,
+	.release 	= &crypto_lb_release
+};
+
+static ssize_t name_show(struct class_device *dev, char *buf)
+{
+	struct crypto_lb *lb = container_of(dev, struct crypto_lb, class_device);
+
+	return sprintf(buf, "%s\n", lb->name);
+}
+
+static ssize_t current_show(struct class_device *dev, char *buf)
+{
+	struct crypto_lb *lb;
+	int off = 0;
+
+	spin_lock_irq(&crypto_lb_lock);
+
+	list_for_each_entry(lb, &crypto_lb_list, lb_entry) {
+		if (lb_is_current(lb))
+			off += sprintf(buf + off, "[");
+		if (lb_is_default(lb))
+			off += sprintf(buf + off, "(");
+		off += sprintf(buf + off, "%s", lb->name);
+		if (lb_is_default(lb))
+			off += sprintf(buf + off, ")");
+		if (lb_is_current(lb))
+			off += sprintf(buf + off, "]");
+	}
+
+	spin_unlock_irq(&crypto_lb_lock);
+
+	if (!off)
+		off = sprintf(buf, "No load balancers regitered yet.");
+
+	off += sprintf(buf + off, "\n");
+
+	return off;
+}
+static ssize_t current_store(struct class_device *dev, const char *buf, size_t count)
+{
+	struct crypto_lb *lb;
+
+	spin_lock_irq(&crypto_lb_lock);
+
+	list_for_each_entry(lb, &crypto_lb_list, lb_entry) {
+		if (count == strlen(lb->name) && !strcmp(buf, lb->name)) {
+			lb_set_current(lb);
+			lb_set_default(lb);
+
+			dprintk(KERN_INFO "Load balancer %s is set as current and default.\n",
+				lb->name);
+
+			break;
+		}
+	}
+	spin_unlock_irq(&crypto_lb_lock);
+
+	return count;
+}
+
+static CLASS_DEVICE_ATTR(name, 0444, name_show, NULL);
+CLASS_DEVICE_ATTR(lbs, 0644, current_show, current_store);
+
+static void create_device_attributes(struct crypto_lb *lb)
+{
+	class_device_create_file(&lb->class_device, &class_device_attr_name);
+}
+
+static void remove_device_attributes(struct crypto_lb *lb)
+{
+	class_device_remove_file(&lb->class_device, &class_device_attr_name);
+}
+
+static int compare_lb(struct crypto_lb *l1, struct crypto_lb *l2)
+{
+	if (!strncmp(l1->name, l2->name, sizeof(l1->name)))
+		return 1;
+
+	return 0;
+}
+
+void crypto_lb_rehash(void)
+{
+	if (!current_lb)
+		return;
+
+	spin_lock_irq(&current_lb->lock);
+
+	current_lb->rehash(current_lb);
+
+	spin_unlock_irq(&current_lb->lock);
+
+	wake_up_interruptible(&crypto_lb_wait_queue);
+}
+
+struct crypto_device *crypto_lb_find_device(struct crypto_session_initializer *ci, struct crypto_data *data)
+{
+	struct crypto_device *dev;
+
+	if (!current_lb)
+		return NULL;
+
+	if (sci_binded(ci)) {
+		int found = 0;
+
+		spin_lock_irq(crypto_device_lock);
+
+		list_for_each_entry(dev, crypto_device_list, cdev_entry) {
+			if (dev->id == ci->bdev) {
+				found = 1;
+				break;
+			}
+		}
+
+		spin_unlock_irq(crypto_device_lock);
+
+		return (found) ? dev : NULL;
+	}
+
+	spin_lock_irq(&current_lb->lock);
+
+	current_lb->rehash(current_lb);
+
+	spin_lock(crypto_device_lock);
+
+	dev = current_lb->find_device(current_lb, ci, data);
+	if (dev)
+		crypto_device_get(dev);
+
+	spin_unlock(crypto_device_lock);
+
+	spin_unlock_irq(&current_lb->lock);
+
+	wake_up_interruptible(&crypto_lb_wait_queue);
+
+	return dev;
+}
+
+static int __crypto_lb_register(struct crypto_lb *lb)
+{
+	int err;
+
+	spin_lock_init(&lb->lock);
+
+	init_completion(&lb->dev_released);
+	memcpy(&lb->device, &crypto_lb_dev, sizeof(struct device));
+	lb->driver = &crypto_lb_driver;
+
+	snprintf(lb->device.bus_id, sizeof(lb->device.bus_id), "%s", lb->name);
+	err = device_register(&lb->device);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto load balancer device %s: err=%d.\n",
+			lb->name, err);
+		return err;
+	}
+
+	snprintf(lb->class_device.class_id, sizeof(lb->class_device.class_id), "%s", lb->name);
+	lb->class_device.dev = &lb->device;
+	lb->class_device.class = &crypto_lb_class;
+
+	err = class_device_register(&lb->class_device);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto load balancer class device %s: err=%d.\n",
+			lb->name, err);
+		device_unregister(&lb->device);
+		return err;
+	}
+
+	create_device_attributes(lb);
+	wake_up_interruptible(&crypto_lb_wait_queue);
+
+	return 0;
+
+}
+
+static void __crypto_lb_unregister(struct crypto_lb *lb)
+{
+	wake_up_interruptible(&crypto_lb_wait_queue);
+	remove_device_attributes(lb);
+	class_device_unregister(&lb->class_device);
+	device_unregister(&lb->device);
+}
+
+int crypto_lb_register(struct crypto_lb *lb, int set_current, int set_default)
+{
+	struct crypto_lb *__lb;
+	int err;
+
+	spin_lock_irq(&crypto_lb_lock);
+
+	list_for_each_entry(__lb, &crypto_lb_list, lb_entry) {
+		if (unlikely(compare_lb(__lb, lb))) {
+			spin_unlock_irq(&crypto_lb_lock);
+
+			dprintk(KERN_ERR "Crypto load balancer %s is already registered.\n",
+				lb->name);
+			return -EINVAL;
+		}
+	}
+
+	list_add(&lb->lb_entry, &crypto_lb_list);
+
+	spin_unlock_irq(&crypto_lb_lock);
+
+	err = __crypto_lb_register(lb);
+	if (err) {
+		spin_lock_irq(&crypto_lb_lock);
+		list_del_init(&lb->lb_entry);
+		spin_unlock_irq(&crypto_lb_lock);
+
+		return err;
+	}
+
+	if (!default_lb || set_default)
+		lb_set_default(lb);
+
+	if (!current_lb || set_current)
+		lb_set_current(lb);
+
+	dprintk(KERN_INFO "Crypto load balancer %s was registered and set to be [%s.%s].\n",
+		lb->name, (lb_is_current(lb)) ? "current" : "not current",
+		(lb_is_default(lb)) ? "default" : "not default");
+
+	lb_num++;
+
+	return 0;
+}
+
+void crypto_lb_unregister(struct crypto_lb *lb)
+{
+	struct crypto_lb *__lb, *n;
+
+	if (lb_num == 1) {
+		dprintk(KERN_INFO "You are removing crypto load balancer %s which is current and default.\n"
+			"There is no other crypto load balancers. "
+			"Removing %s delayed untill new load balancer is registered.\n",
+			lb->name, (force_lb_remove) ? "is not" : "is");
+		while (lb_num == 1 && !force_lb_remove) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ);
+
+			if (signal_pending(current))
+				flush_signals(current);
+		}
+	}
+
+	__crypto_lb_unregister(lb);
+
+	spin_lock_irq(&crypto_lb_lock);
+
+	list_for_each_entry_safe(__lb, n, &crypto_lb_list, lb_entry) {
+		if (compare_lb(__lb, lb)) {
+			lb_num--;
+			list_del_init(&__lb->lb_entry);
+
+			dprintk(KERN_ERR "Crypto load balancer %s was unregistered.\n",
+				lb->name);
+		} else if (lb_num) {
+			if (lb_is_default(lb))
+				lb_set_default(__lb);
+			if (lb_is_current(lb))
+				lb_set_current(default_lb);
+		}
+	}
+
+	spin_unlock_irq(&crypto_lb_lock);
+}
+
+static void crypto_lb_queue_wrapper(void *data)
+{
+	struct crypto_device *dev = &main_crypto_device;
+	struct crypto_session *s = (struct crypto_session *)data;
+
+	dprintk(KERN_INFO "%s: Calling callback for session %llu [%llu] flags=%x, "
+		"op=%04u, type=%04x, mode=%04x, priority=%04x\n", __func__,
+		s->ci.id, s->ci.dev_id, s->ci.flags, s->ci.operation,
+		s->ci.type, s->ci.mode, s->ci.priority);
+
+	spin_lock_irq(&s->lock);
+	crypto_stat_finish_inc(s);
+
+	finish_session(s);
+	unstart_session(s);
+	spin_unlock_irq(&s->lock);
+
+	s->ci.callback(&s->ci, &s->data);
+
+	if (session_finished(s)) {
+		crypto_session_destroy(s);
+		return;
+	} else {
+		/*
+		 * Special case: crypto consumer marks session as "not finished"
+		 * in it's callback - it means that crypto consumer wants 
+		 * this session to be processed further, 
+		 * for example crypto consumer can add new route and then
+		 * mark session as "not finished".
+		 */
+
+		uncomplete_session(s);
+		unstart_session(s);
+		crypto_session_insert_main(dev, s);
+	}
+	spin_unlock_irq(&s->lock);
+}
+
+static void crypto_lb_process_next_route(struct crypto_session *s)
+{
+	struct crypto_route *rt;
+	struct crypto_device *dev, *orig;
+
+	rt = crypto_route_dequeue(s);
+	if (rt) {
+		orig = rt->dev;
+
+		list_del_init(&s->dev_queue_entry);
+
+		crypto_route_free(rt);
+
+		dev = crypto_route_get_current_device(s);
+		if (dev) {
+			dprintk(KERN_INFO "%s: processing new route to %s.\n",
+				__func__, dev->name);
+
+			memcpy(&s->ci, &rt->ci, sizeof(s->ci));
+
+			if (!strncmp(orig->name, dev->name, sizeof(dev->name)))
+				__crypto_session_insert(dev, s);
+			else
+				crypto_session_insert(dev, s);
+
+			/*
+			 * Reference to this device was already hold when
+			 * new routing was added.
+			 */
+			crypto_device_put(dev);
+		}
+	}
+}
+
+void crypto_wake_lb(void)
+{
+	wake_up_interruptible(&crypto_lb_wait_queue);
+}
+
+int crypto_lb_thread(void *data)
+{
+	struct crypto_session *s, *n;
+	struct crypto_device *dev = (struct crypto_device *)data;
+	unsigned long flags;
+
+	daemonize("%s", dev->name);
+	allow_signal(SIGTERM);
+
+	while (!need_exit) {
+		spin_lock_irqsave(&dev->session_lock, flags);
+		list_for_each_entry_safe(s, n, &dev->session_list, main_queue_entry) {
+			dprintk("session %llu [%llu]: flags=%x, route_num=%d, %s,%s,%s,%s.\n",
+			     s->ci.id, s->ci.dev_id, s->ci.flags,
+			     crypto_route_queue_len(s),
+			     (session_completed(s)) ? "completed" : "not completed",
+			     (session_finished(s)) ? "finished" : "not finished",
+			     (session_started(s)) ? "started" : "not started",
+			     (session_is_processed(s)) ? "is being processed" : "is not being processed");
+
+			if (!spin_trylock(&s->lock))
+				continue;
+
+			if (session_is_processed(s))
+				goto unlock;
+			if (session_started(s))
+				goto unlock;
+
+			if (session_completed(s)) {
+				crypto_stat_ptime_inc(s);
+
+				if (crypto_route_queue_len(s) > 1) {
+					crypto_lb_process_next_route(s);
+				} else {
+					start_session(s);
+					crypto_stat_start_inc(s);
+
+					dprintk("%s: going to remove session %llu [%llu].\n",
+					     __func__, s->ci.id, s->ci.dev_id);
+
+					__crypto_session_dequeue_main(s);
+					spin_unlock(&s->lock);
+
+					INIT_WORK(&s->work, &crypto_lb_queue_wrapper, s);
+					queue_work(crypto_lb_queue, &s->work);
+					continue;
+				}
+			}
+unlock:
+			spin_unlock(&s->lock);
+		}
+		spin_unlock_irqrestore(&dev->session_lock, flags);
+
+		interruptible_sleep_on_timeout(&crypto_lb_wait_queue, 100);
+	}
+
+	flush_workqueue(crypto_lb_queue);
+	complete_and_exit(&thread_exited, 0);
+}
+
+int crypto_lb_init(void)
+{
+	int err;
+	long pid;
+
+	err = bus_register(&crypto_lb_bus_type);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto load balancer bus: err=%d.\n", err);
+		goto err_out_exit;
+	}
+
+	err = driver_register(&crypto_lb_driver);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto load balancer driver: err=%d.\n", err);
+		goto err_out_bus_unregister;
+	}
+
+	crypto_lb_class.class_dev_attrs = &class_device_attr_lbs;
+
+	err = class_register(&crypto_lb_class);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto load balancer class: err=%d.\n", err);
+		goto err_out_driver_unregister;
+	}
+
+	crypto_lb_queue = create_workqueue("clbq");
+	if (!crypto_lb_queue) {
+		dprintk(KERN_ERR "Failed to create crypto load balaner work queue.\n");
+		goto err_out_class_unregister;
+	}
+
+	init_completion(&thread_exited);
+	pid = kernel_thread(crypto_lb_thread, &main_crypto_device, CLONE_FS | CLONE_FILES);
+	if (IS_ERR((void *)pid)) {
+		dprintk(KERN_ERR "Failed to create kernel load balancing thread.\n");
+		goto err_out_destroy_workqueue;
+	}
+
+	return 0;
+
+err_out_destroy_workqueue:
+	destroy_workqueue(crypto_lb_queue);
+err_out_class_unregister:
+	class_unregister(&crypto_lb_class);
+err_out_driver_unregister:
+	driver_unregister(&crypto_lb_driver);
+err_out_bus_unregister:
+	bus_unregister(&crypto_lb_bus_type);
+err_out_exit:
+	return err;
+}
+
+void crypto_lb_fini(void)
+{
+	need_exit = 1;
+	wait_for_completion(&thread_exited);
+	flush_workqueue(crypto_lb_queue);
+	destroy_workqueue(crypto_lb_queue);
+	class_unregister(&crypto_lb_class);
+	driver_unregister(&crypto_lb_driver);
+	bus_unregister(&crypto_lb_bus_type);
+}
+
+EXPORT_SYMBOL_GPL(crypto_lb_register);
+EXPORT_SYMBOL_GPL(crypto_lb_unregister);
+EXPORT_SYMBOL_GPL(crypto_lb_rehash);
+EXPORT_SYMBOL_GPL(crypto_lb_find_device);
+EXPORT_SYMBOL_GPL(crypto_wake_lb);

