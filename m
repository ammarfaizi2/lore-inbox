Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVCHCnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVCHCnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVCGUmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:42:24 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:15281 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261783AbVCGUMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:44 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [21/many] acrypto: simple_lb.c
In-Reply-To: <11102278551170@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <11102278551512@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/simple_lb.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/simple_lb.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,88 @@
+/*
+ * 	simple_lb.c
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
+
+#include "crypto_lb.h"
+
+static void simple_lb_rehash(struct crypto_lb *);
+static struct crypto_device *simple_lb_find_device(struct crypto_lb *,
+						   struct crypto_session_initializer *,
+						   struct crypto_data *);
+
+struct crypto_lb simple_lb = {
+	.name = "simple_lb",
+	.rehash = simple_lb_rehash,
+	.find_device = simple_lb_find_device
+};
+
+static void simple_lb_rehash(struct crypto_lb *lb)
+{
+}
+
+static struct crypto_device *simple_lb_find_device(struct crypto_lb *lb,
+						   struct crypto_session_initializer *ci,
+						   struct crypto_data *data)
+{
+	struct crypto_device *dev, *__dev;
+	int min = 0x7ffffff;
+
+	__dev = NULL;
+	list_for_each_entry(dev, lb->crypto_device_list, cdev_entry) {
+		if (device_broken(dev))
+			continue;
+		if (!match_initializer(dev, ci))
+			continue;
+
+		if (atomic_read(&dev->refcnt) < min) {
+			min = atomic_read(&dev->refcnt);
+			__dev = dev;
+		}
+	}
+
+	return __dev;
+}
+
+int __devinit simple_lb_init(void)
+{
+	dprintk(KERN_INFO "Registering simple crypto load balancer.\n");
+
+	return crypto_lb_register(&simple_lb, 1, 1);
+}
+
+void __devexit simple_lb_fini(void)
+{
+	dprintk(KERN_INFO "Unregistering simple crypto load balancer.\n");
+
+	crypto_lb_unregister(&simple_lb);
+}
+
+module_init(simple_lb_init);
+module_exit(simple_lb_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Simple crypto load balancer.");

