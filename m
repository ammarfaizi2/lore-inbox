Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVCGUsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVCGUsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVCGUrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:47:40 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:36273 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261796AbVCGUND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:03 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [11/many] acrypto: crypto_main.c
In-Reply-To: <11102278543541@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:34 +0300
Message-Id: <11102278541439@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_main.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_main.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,374 @@
+/*
+ * 	crypto_main.c
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
+
+#include "acrypto.h"
+#include "crypto_lb.h"
+#include "crypto_conn.h"
+#include "crypto_route.h"
+#include "crypto_user_ioctl.h"
+
+int force_lb_remove;
+module_param(force_lb_remove, int, 0);
+
+struct crypto_device main_crypto_device;
+
+extern struct bus_type crypto_bus_type;
+extern struct device_driver crypto_driver;
+extern struct class crypto_class;
+extern struct device crypto_dev;
+
+extern struct class_device_attribute class_device_attr_devices;
+extern struct class_device_attribute class_device_attr_lbs;
+
+static void dump_ci(struct crypto_session_initializer *ci)
+{
+	dprintk("%llu [%llu] op=%04u, type=%04x, mode=%04x, priority=%04x",
+		ci->id, ci->dev_id,
+		ci->operation, ci->type, ci->mode, ci->priority);
+}
+
+void __crypto_session_insert(struct crypto_device *dev, struct crypto_session *s)
+{
+	struct crypto_session *__s;
+
+	if (unlikely(list_empty(&dev->session_list))) {
+		list_add(&s->dev_queue_entry, &dev->session_list);
+	} else {
+		int inserted = 0;
+
+		list_for_each_entry(__s, &dev->session_list, dev_queue_entry) {
+			if (__s->ci.priority < s->ci.priority) {
+				list_add_tail(&s->dev_queue_entry, &__s->dev_queue_entry);
+				inserted = 1;
+				break;
+			}
+		}
+
+		if (!inserted)
+			list_add_tail(&s->dev_queue_entry, &dev->session_list);
+	}
+
+	dump_ci(&s->ci);
+	dprintk(" added to crypto device %s [%d].\n", dev->name, atomic_read(&dev->refcnt));
+}
+
+void crypto_session_insert_main(struct crypto_device *dev, struct crypto_session *s)
+{
+	struct crypto_session *__s;
+
+	spin_lock_irq(&dev->session_lock);
+
+	crypto_device_get(dev);
+	if (unlikely(list_empty(&dev->session_list))) {
+		list_add(&s->main_queue_entry, &dev->session_list);
+	} else {
+		int inserted = 0;
+
+		list_for_each_entry(__s, &dev->session_list, main_queue_entry) {
+			if (__s->ci.priority < s->ci.priority) {
+				list_add_tail(&s->main_queue_entry,
+					      &__s->main_queue_entry);
+				inserted = 1;
+				break;
+			}
+		}
+
+		if (!inserted)
+			list_add_tail(&s->main_queue_entry, &dev->session_list);
+	}
+
+	spin_unlock_irq(&dev->session_lock);
+}
+
+void crypto_session_insert(struct crypto_device *dev, struct crypto_session *s)
+{
+	spin_lock_irq(&dev->session_lock);
+	__crypto_session_insert(dev, s);
+	spin_unlock_irq(&dev->session_lock);
+}
+
+void crypto_session_destroy(struct crypto_session *s)
+{
+	if (s->data.priv_size && s->data.priv)
+		kfree(s->data.priv);
+
+	if (session_from_cache(s))
+		kmem_cache_free(s->pool_dev->session_cache, s);
+	else
+		mempool_free(s, s->pool_dev->session_pool);
+}
+
+struct crypto_session *crypto_session_create(struct crypto_session_initializer *ci, struct crypto_data *d)
+{
+	struct crypto_device *dev = &main_crypto_device;
+	struct crypto_device *ldev;
+	struct crypto_session *s;
+	int err;
+
+	if (d->priv_size > CRYPTO_MAX_PRIV_SIZE) {
+		dprintk("priv_size %u is too big, maximum allowed %u.\n",
+			d->priv_size, CRYPTO_MAX_PRIV_SIZE);
+		return NULL;
+	}
+	
+	ldev = crypto_lb_find_device(ci, d);
+	if (!ldev) {
+		dprintk("Cannot find suitable device for [%02x.%02x.%02x.%02x].\n",
+				ci->operation, ci->mode, ci->type, ci->priority);
+		return NULL;
+	}
+	
+	s = mempool_alloc(ldev->session_pool, GFP_ATOMIC);
+	if (!s) {
+		ldev->stat.pool_failed++;
+
+		s = kmem_cache_alloc(ldev->session_cache, GFP_ATOMIC);
+		if (!s) {
+			ldev->stat.kmem_failed++;
+			goto err_out_device_put;
+		}
+
+		mark_session_from_cache(s);
+	}
+	
+	s->pool_dev = ldev;
+
+	crypto_route_head_init(&s->route_list);
+	INIT_LIST_HEAD(&s->dev_queue_entry);
+	INIT_LIST_HEAD(&s->main_queue_entry);
+
+	spin_lock_init(&s->lock);
+
+	memcpy(&s->ci, ci, sizeof(s->ci));
+	memcpy(&s->data, d, sizeof(s->data));
+
+	s->data.priv = NULL;
+	if (d->priv_size) {
+		s->data.priv = kmalloc(d->priv_size, GFP_ATOMIC);
+		if (!s->data.priv)
+			goto err_out_session_free;
+
+		if (d->priv)
+			memcpy(s->data.priv, d->priv, d->priv_size);
+	}
+	else
+		s->data.priv = d->priv;
+
+	s->ci.id = dev->sid++;
+	s->ci.dev_id = ldev->sid++;
+	s->ci.flags = 0;
+
+	err = crypto_route_add_direct(ldev, s, ci);
+	if (err) {
+		dprintk("Can not add route to device %s.\n", ldev->name);
+		goto err_out_session_free;
+	}
+
+	return s;
+
+err_out_session_free:
+	crypto_session_destroy(s);
+err_out_device_put:
+	crypto_device_put(ldev);
+
+	return NULL;
+}
+
+void crypto_session_add(struct crypto_session *s)
+{
+	struct crypto_device *ldev;
+	struct crypto_device *dev = &main_crypto_device;
+
+	ldev = crypto_route_get_current_device(s);
+	BUG_ON(!ldev);		/* This can not happen. */
+
+	spin_lock_irq(&s->lock);
+	crypto_session_insert(ldev, s);
+	crypto_device_put(ldev);
+	crypto_session_insert_main(dev, s);
+	spin_unlock_irq(&s->lock);
+
+	if (ldev->data_ready)
+		ldev->data_ready(ldev);
+}
+
+struct crypto_session *crypto_session_alloc(struct crypto_session_initializer *ci, struct crypto_data *d)
+{
+	struct crypto_session *s;
+
+	s = crypto_session_create(ci, d);
+	if (!s)
+		return NULL;
+
+	crypto_session_add(s);
+
+	return s;
+}
+
+void crypto_session_dequeue_route(struct crypto_session *s)
+{
+	struct crypto_route *rt;
+	struct crypto_device *dev;
+
+	BUG_ON(crypto_route_queue_len(s) > 1);
+
+	while ((rt = crypto_route_dequeue(s))) {
+		dev = rt->dev;
+
+		dprintk(KERN_INFO "Removing route entry for device %s.\n", dev->name);
+
+		spin_lock_irq(&dev->session_lock);
+		list_del_init(&s->dev_queue_entry);
+		spin_unlock_irq(&dev->session_lock);
+
+		crypto_route_free(rt);
+	}
+}
+
+void __crypto_session_dequeue_main(struct crypto_session *s)
+{
+	struct crypto_device *dev = &main_crypto_device;
+
+	list_del(&s->main_queue_entry);
+	crypto_device_put(dev);
+}
+
+void crypto_session_dequeue_main(struct crypto_session *s)
+{
+	struct crypto_device *dev = &main_crypto_device;
+
+	spin_lock_irq(&dev->session_lock);
+
+	__crypto_session_dequeue_main(s);
+
+	spin_unlock_irq(&dev->session_lock);
+}
+
+int __devinit cmain_init(void)
+{
+	struct crypto_device *dev = &main_crypto_device;
+	int err;
+
+	snprintf(dev->name, sizeof(dev->name), "crypto_sessions");
+
+	err = bus_register(&crypto_bus_type);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto bus: err=%d.\n",
+			err);
+		return err;
+	}
+
+	err = driver_register(&crypto_driver);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto driver: err=%d.\n",
+			err);
+		goto err_out_bus_unregister;
+	}
+
+	err = class_register(&crypto_class);
+	if (err) {
+		dprintk(KERN_ERR "Failed to register crypto class: err=%d.\n",
+			err);
+		goto err_out_driver_unregister;
+	}
+
+	err = crypto_lb_init();
+	if (err)
+		goto err_out_class_unregister;
+
+	err = crypto_conn_init();
+	if (err)
+		goto err_out_crypto_lb_fini;
+
+	err = __crypto_device_add(dev);
+	if (err)
+		goto err_out_crypto_conn_fini;
+
+	err = class_device_create_file(&dev->class_device, &class_device_attr_devices);
+	if (err)
+		dprintk("Failed to create \"devices\" attribute: err=%d.\n", err);
+
+	err = class_device_create_file(&dev->class_device, &class_device_attr_lbs);
+	if (err)
+		dprintk("Failed to create \"lbs\" attribute: err=%d.\n", err);
+
+	err = crypto_user_ioctl_init();
+	if (err)
+		goto err_out_remove_files;
+
+	return 0;
+
+err_out_remove_files:
+	class_device_remove_file(&dev->class_device, &class_device_attr_devices);
+	class_device_remove_file(&dev->class_device, &class_device_attr_lbs);
+	__crypto_device_remove(dev);
+err_out_crypto_conn_fini:
+	crypto_conn_fini();
+err_out_crypto_lb_fini:
+	crypto_lb_fini();
+err_out_class_unregister:
+	class_unregister(&crypto_class);
+err_out_driver_unregister:
+	driver_unregister(&crypto_driver);
+err_out_bus_unregister:
+	bus_unregister(&crypto_bus_type);
+
+	return err;
+}
+
+void __devexit cmain_fini(void)
+{
+	struct crypto_device *dev = &main_crypto_device;
+
+	crypto_user_ioctl_fini();
+	
+	class_device_remove_file(&dev->class_device, &class_device_attr_devices);
+	class_device_remove_file(&dev->class_device, &class_device_attr_lbs);
+	__crypto_device_remove(dev);
+
+	crypto_conn_fini();
+	crypto_lb_fini();
+
+	class_unregister(&crypto_class);
+	driver_unregister(&crypto_driver);
+	bus_unregister(&crypto_bus_type);
+}
+
+module_init(cmain_init);
+module_exit(cmain_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Asynchronous crypto layer.");
+
+EXPORT_SYMBOL(crypto_session_alloc);
+EXPORT_SYMBOL_GPL(crypto_session_create);
+EXPORT_SYMBOL_GPL(crypto_session_add);
+EXPORT_SYMBOL_GPL(crypto_session_dequeue_route);

