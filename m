Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVCGWVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVCGWVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCGVYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:24:02 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:21426 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261825AbVCGUNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:48 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [8/many] acrypto: crypto_dev.c
In-Reply-To: <11102278542733@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:34 +0300
Message-Id: <1110227854480@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_dev.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_dev.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,421 @@
+/*
+ * 	crypto_dev.c
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
+#include <linux/device.h>
+
+#include "acrypto.h"
+
+static LIST_HEAD(cdev_list);
+static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;
+static u32 cdev_ids;
+
+struct list_head *crypto_device_list = &cdev_list;
+spinlock_t *crypto_device_lock = &cdev_lock;
+
+static int crypto_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int crypto_probe(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static int crypto_remove(struct device *dev)
+{
+	return 0;
+}
+
+static void crypto_release(struct device *dev)
+{
+	struct crypto_device *d = container_of(dev, struct crypto_device, device);
+
+	complete(&d->dev_released);
+}
+
+static void crypto_class_release(struct class *class)
+{
+}
+
+static void crypto_class_release_device(struct class_device *class_dev)
+{
+}
+
+struct class crypto_class = {
+	.name 		= "acrypto",
+	.class_release 	= crypto_class_release,
+	.release 	= crypto_class_release_device
+};
+
+struct bus_type crypto_bus_type = {
+	.name 		= "acrypto",
+	.match 		= crypto_match
+};
+
+struct device_driver crypto_driver = {
+	.name 		= "crypto_driver",
+	.bus 		= &crypto_bus_type,
+	.probe 		= crypto_probe,
+	.remove 	= crypto_remove,
+};
+
+struct device crypto_dev = {
+	.parent 	= NULL,
+	.bus 		= &crypto_bus_type,
+	.bus_id		= "Asynchronous crypto",
+	.driver 	= &crypto_driver,
+	.release 	= &crypto_release
+};
+
+static ssize_t sessions_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d = container_of(dev, struct crypto_device, class_device);
+
+	return sprintf(buf, "%d\n", atomic_read(&d->refcnt));
+}
+static ssize_t name_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d = container_of(dev, struct crypto_device, class_device);
+
+	return sprintf(buf, "%s\n", d->name);
+}
+static ssize_t devices_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d;
+	int off = 0;
+
+	spin_lock_irq(&cdev_lock);
+	list_for_each_entry(d, &cdev_list, cdev_entry) {
+		off += sprintf(buf + off, "%s ", d->name);
+	}
+	spin_unlock_irq(&cdev_lock);
+
+	if (!off)
+		off = sprintf(buf, "No devices registered yet.");
+
+	off += sprintf(buf + off, "\n");
+
+	return off;
+}
+
+static ssize_t kmem_failed_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d =  container_of(dev, struct crypto_device, class_device);
+
+	return sprintf(buf, "%llu\n", d->stat.kmem_failed);
+}
+static ssize_t sstarted_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d = container_of(dev, struct crypto_device, class_device);
+
+	return sprintf(buf, "%llu\n", d->stat.sstarted);
+}
+static ssize_t sfinished_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d = container_of(dev, struct crypto_device, class_device);
+
+	return sprintf(buf, "%llu\n", d->stat.sfinished);
+}
+static ssize_t scompleted_show(struct class_device *dev, char *buf)
+{
+	struct crypto_device *d = container_of(dev, struct crypto_device, class_device);
+
+	return sprintf(buf, "%llu\n", d->stat.scompleted);
+}
+
+static CLASS_DEVICE_ATTR(sessions, 0444, sessions_show, NULL);
+static CLASS_DEVICE_ATTR(name, 0444, name_show, NULL);
+CLASS_DEVICE_ATTR(devices, 0444, devices_show, NULL);
+static CLASS_DEVICE_ATTR(scompleted, 0444, scompleted_show, NULL);
+static CLASS_DEVICE_ATTR(sstarted, 0444, sstarted_show, NULL);
+static CLASS_DEVICE_ATTR(sfinished, 0444, sfinished_show, NULL);
+static CLASS_DEVICE_ATTR(kmem_failed, 0444, kmem_failed_show, NULL);
+
+static int compare_device(struct crypto_device *d1, struct crypto_device *d2)
+{
+	if (!strncmp(d1->name, d2->name, sizeof(d1->name)))
+		return 1;
+
+	return 0;
+}
+
+static void create_device_attributes(struct crypto_device *dev)
+{
+	class_device_create_file(&dev->class_device, &class_device_attr_sessions);
+	class_device_create_file(&dev->class_device, &class_device_attr_name);
+	class_device_create_file(&dev->class_device, &class_device_attr_scompleted);
+	class_device_create_file(&dev->class_device, &class_device_attr_sstarted);
+	class_device_create_file(&dev->class_device, &class_device_attr_sfinished);
+	class_device_create_file(&dev->class_device, &class_device_attr_kmem_failed);
+}
+
+static void remove_device_attributes(struct crypto_device *dev)
+{
+	class_device_remove_file(&dev->class_device, &class_device_attr_sessions);
+	class_device_remove_file(&dev->class_device, &class_device_attr_name);
+	class_device_remove_file(&dev->class_device, &class_device_attr_scompleted);
+	class_device_remove_file(&dev->class_device, &class_device_attr_sstarted);
+	class_device_remove_file(&dev->class_device, &class_device_attr_sfinished);
+	class_device_remove_file(&dev->class_device, &class_device_attr_kmem_failed);
+}
+
+int __match_initializer(struct crypto_capability *cap, struct crypto_session_initializer *ci)
+{
+	dprintk("Match: %04x.%04x.%04x vs. %04x.%04x.%04x.\n",
+			cap->operation, cap->type, cap->mode,
+			ci->operation, ci->type, ci->mode);
+	if (cap->operation == ci->operation && cap->type == ci->type && 
+			cap->mode == (ci->mode & 0x1fff))
+		return 1;
+
+	return 0;
+}
+
+int match_initializer(struct crypto_device *dev, struct crypto_session_initializer *ci)
+{
+	int i;
+
+	for (i = 0; i < dev->cap_number; ++i) {
+		struct crypto_capability *cap = &dev->cap[i];
+
+		if (__match_initializer(cap, ci)) {
+			if (cap->qlen >= atomic_read(&dev->refcnt) + 1) {
+				dprintk("cap->len=%u, req=%u.\n",
+					cap->qlen, atomic_read(&dev->refcnt) + 1);
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+void crypto_device_get(struct crypto_device *dev)
+{
+	atomic_inc(&dev->refcnt);
+}
+
+struct crypto_device *crypto_device_get_name(char *name)
+{
+	struct crypto_device *dev;
+	int found = 0;
+
+	spin_lock_irq(&cdev_lock);
+	list_for_each_entry(dev, &cdev_list, cdev_entry) {
+		if (!strcmp(dev->name, name)) {
+			found = 1;
+			crypto_device_get(dev);
+			break;
+		}
+	}
+	spin_unlock_irq(&cdev_lock);
+
+	if (!found)
+		return NULL;
+
+	return dev;
+}
+
+void crypto_device_put(struct crypto_device *dev)
+{
+	atomic_dec(&dev->refcnt);
+}
+
+static int avg_cap_qlen(struct crypto_device *dev)
+{
+	int i, max = 0;
+
+	if (!dev->cap_number)
+		return 0;
+
+	for (i=0; i<dev->cap_number; ++i) {
+		max += dev->cap[i].qlen;
+	}
+
+	return (max / dev->cap_number);
+}
+
+int __crypto_device_add(struct crypto_device *dev)
+{
+	int err, avg;
+
+	memset(&dev->stat, 0, sizeof(dev->stat));
+	spin_lock_init(&dev->stat_lock);
+	spin_lock_init(&dev->lock);
+	spin_lock_init(&dev->session_lock);
+	INIT_LIST_HEAD(&dev->session_list);
+	atomic_set(&dev->refcnt, 0);
+	dev->sid = 0;
+	dev->flags = 0;
+	init_completion(&dev->dev_released);
+	memcpy(&dev->device, &crypto_dev, sizeof(struct device));
+	dev->driver = &crypto_driver;
+
+	dev->session_cache = kmem_cache_create(dev->name, sizeof(struct crypto_session), 
+			0, 0, NULL, NULL);
+	if (!dev->session_cache) {
+		dprintk(KERN_ERR "Failed to create session cache for device %s.\n", dev->name);
+		return -ENOMEM;
+	}
+	
+	avg = avg_cap_qlen(dev);
+
+	if (avg) {
+		dev->session_pool = mempool_create(avg, mempool_alloc_slab, mempool_free_slab, dev->session_cache);
+		if (!dev->session_pool) {
+			dprintk(KERN_ERR "Failed to create memory pool with %d objects for device %s.\n",
+					avg, dev->name);
+			err = -ENOMEM;
+			goto err_out_cache_destroy;
+		}
+	} else
+		dev->session_pool = NULL;
+
+	snprintf(dev->device.bus_id, sizeof(dev->device.bus_id), "%s", dev->name);
+	err = device_register(&dev->device);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto device %s: err=%d.\n",
+			dev->name, err);
+		goto err_out_mempool_destroy;
+	}
+
+	snprintf(dev->class_device.class_id, sizeof(dev->class_device.class_id), "%s", dev->name);
+	dev->class_device.dev = &dev->device;
+	dev->class_device.class = &crypto_class;
+
+	err = class_device_register(&dev->class_device);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto class device %s: err=%d.\n",
+			dev->name, err);
+		goto err_out_device_unregister;
+	}
+
+	create_device_attributes(dev);
+
+	return 0;
+
+err_out_device_unregister:
+	device_unregister(&dev->device);
+err_out_mempool_destroy:
+	if (dev->session_pool)
+		mempool_destroy(dev->session_pool);
+err_out_cache_destroy:
+	kmem_cache_destroy(dev->session_cache);
+
+	return err;
+}
+
+void __crypto_device_remove(struct crypto_device *dev)
+{
+	remove_device_attributes(dev);
+	class_device_unregister(&dev->class_device);
+	device_unregister(&dev->device);
+	if (dev->session_pool)
+		mempool_destroy(dev->session_pool);
+	kmem_cache_destroy(dev->session_cache);
+}
+
+int crypto_device_add(struct crypto_device *dev)
+{
+	int err;
+
+	err = __crypto_device_add(dev);
+	if (err)
+		return err;
+
+	spin_lock_irq(&cdev_lock);
+	list_add(&dev->cdev_entry, &cdev_list);
+	dev->id = ++cdev_ids;
+	spin_unlock_irq(&cdev_lock);
+
+	printk(KERN_INFO "Crypto device %s was registered with ID=%x.\n",
+		dev->name, dev->id);
+
+	return 0;
+}
+
+void crypto_device_remove(struct crypto_device *dev)
+{
+	struct crypto_device *__dev, *n;
+
+	__crypto_device_remove(dev);
+
+	spin_lock_irq(&cdev_lock);
+	list_for_each_entry_safe(__dev, n, &cdev_list, cdev_entry) {
+		if (compare_device(__dev, dev)) {
+			list_del_init(&__dev->cdev_entry);
+			spin_unlock_irq(&cdev_lock);
+
+			/*
+			 * In test cases or when crypto device driver is not written correctly,
+			 * it's ->data_ready() method will not be callen anymore
+			 * after device is removed from crypto device list.
+			 *
+			 * For such cases we either should provide ->flush() call
+			 * or properly write ->data_ready() method.
+			 */
+
+			while (atomic_read(&__dev->refcnt)) {
+
+				dprintk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
+					__dev->name, atomic_read(&dev->refcnt));
+
+				/*
+				 * Hack zone: you need to write good ->data_ready()
+				 * and crypto device driver itself.
+				 *
+				 * Driver shoud not buzz if it has pending sessions
+				 * in it's queue and it was removed from global device list.
+				 *
+				 * Although I can workaround it here, for example by
+				 * flushing the whole queue and drop all pending sessions.
+				 */
+
+				__dev->data_ready(__dev);
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(HZ);
+			}
+
+			dprintk(KERN_ERR "Crypto device %s was unregistered.\n",
+				dev->name);
+			return;
+		}
+	}
+	spin_unlock_irq(&cdev_lock);
+
+	dprintk(KERN_ERR "Crypto device %s was not registered.\n", dev->name);
+}
+
+EXPORT_SYMBOL_GPL(crypto_device_add);
+EXPORT_SYMBOL_GPL(crypto_device_remove);
+EXPORT_SYMBOL_GPL(crypto_device_get);
+EXPORT_SYMBOL_GPL(crypto_device_get_name);
+EXPORT_SYMBOL_GPL(crypto_device_put);
+EXPORT_SYMBOL_GPL(match_initializer);

