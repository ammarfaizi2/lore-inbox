Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVCHCnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVCHCnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVCGUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:41:55 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:12721 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261782AbVCGUMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:40 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [19/many] acrypto: crypto_user_ioctl.c
In-Reply-To: <11102278553597@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <1110227855445@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_user_ioctl.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_user_ioctl.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,281 @@
+/*
+ * 	crypto_user_ioctl.c
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
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+
+#include <asm/uaccess.h>
+
+#include "acrypto.h"
+#include "crypto_user.h"
+#include "crypto_user_ioctl.h"
+
+static int crypto_user_ioctl_ioctl(struct inode *inode, struct file *fp, unsigned int cmd, unsigned long arg);
+static int crypto_user_ioctl_open(struct inode *inode, struct file *fp);
+static int crypto_user_ioctl_release(struct inode *pinode, struct file *fp);
+int crypto_user_ioctl_init(void);
+void crypto_user_ioctl_fini(void);
+
+static int crypto_user_ioctl_major = 0;
+static char crypto_user_ioctl_name[] = "crypto_user_ioctl";
+
+static struct file_operations crypto_user_ioctl_ops = {
+	.open		crypto_user_ioctl_open,
+	.release	crypto_user_ioctl_release,
+	.ioctl		crypto_user_ioctl_ioctl,
+	.owner 		THIS_MODULE
+};
+
+static void dump_data(u8 *ptr)
+{
+	int i;
+
+	dprintk("USER DATA: ");
+	for (i=0; i<32; ++i)
+		dprintka("%02x ", ptr[i]);
+	dprintka("\n");
+}
+
+static int crypto_user_ioctl_open(struct inode *inode, struct file *fp)
+{
+	struct crypto_user_ioctl_kern *iok;
+
+	iok = kmalloc(sizeof(*iok), GFP_KERNEL);
+	if (!iok) {
+		dprintk("Failed to allocate new crypto_user_ioctl_kern structure.\n");
+		return -ENOMEM;
+	}
+	memset(iok, 0, sizeof(*iok));
+
+	fp->private_data = iok;
+
+	return 0;
+}
+
+static int crypto_user_ioctl_release(struct inode *pinode, struct file *fp)
+{
+	struct crypto_user_ioctl_kern *iok = fp->private_data;
+	int i;
+
+	for (i=0; i<4; ++i)
+		if (iok->ptr[i])
+			kfree(iok->ptr[i]);
+	kfree(iok);
+
+	return 0;
+}
+
+static void crypto_user_ioctl_callback(struct crypto_session_initializer *ci, struct crypto_data *data)
+{
+	struct crypto_user_ioctl_kern *iok = data->priv;
+	
+	dprintk("%s() for session %llu [%llu].\n",
+			__func__, iok->s->ci.id, iok->s->ci.dev_id);
+			
+	crypto_user_free_crypto_data(&iok->data);
+
+	iok->scompleted = 1;
+	wake_up_interruptible(&iok->wait);
+}
+
+static int crypto_user_ioctl_session_alloc(struct crypto_user_ioctl *io, struct crypto_user_ioctl_kern *iok)
+{
+	int err;
+	
+	err = crypto_user_alloc_crypto_data(&iok->data, io->src_size, io->dst_size, io->key_size, io->iv_size);
+	if (err)
+		return err;
+
+	iok->ci.operation 	= io->operation;
+	iok->ci.type 		= io->type;
+	iok->ci.mode 		= io->mode;
+	iok->ci.priority 	= io->priority;
+	iok->ci.callback 	= crypto_user_ioctl_callback;
+
+	iok->data.priv		= iok;
+	iok->data.priv_size	= 0;
+	
+	iok->scompleted 	= 0;
+
+	init_waitqueue_head(&iok->wait);
+	
+	iok->s = crypto_session_create(&iok->ci, &iok->data);
+	if (!iok->s) {
+		crypto_user_free_crypto_data(&iok->data);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int crypto_user_ioctl_session_add(struct crypto_user_ioctl_kern *iok)
+{
+	crypto_session_add(iok->s);
+
+	return 0;
+}
+
+static int crypto_user_ioctl_ioctl(struct inode *inode, struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct crypto_user_ioctl io;
+	struct crypto_user_data data;
+	unsigned long not_read;
+	int err;
+	struct crypto_user_ioctl_kern *iok;
+       
+	iok = fp->private_data;
+	
+	err = 0;
+	switch (cmd) {
+		case CRYPTO_SESSION_ALLOC:
+			not_read = copy_from_user(&io, (void __user *)arg, sizeof(io));
+			if (not_read) {
+				dprintk("Failed to read crypto_user_ioctl structure from userspace.\n");
+				err = -EINVAL;
+				break;
+			}
+
+			err = crypto_user_ioctl_session_alloc(&io, iok);
+			break;
+		case CRYPTO_FILL_DATA:
+			not_read = copy_from_user(&data, (void __user *)arg, sizeof(data));
+			if (not_read) {
+				dprintk("Failed to read crypto_user_ioctl_data structure from userspace.\n");
+				err = -EINVAL;
+				break;
+			}
+
+			if (data.data_size > MAX_DATA_SIZE * PAGE_SIZE) {
+				dprintk("Data size is too bit: size=%u, type=%x.\n",
+						data.data_size, data.data_type);
+				err = -EINVAL;
+				break;
+			}
+
+			if (!crypto_user_get_sg(&data, &iok->data)) {
+				dprintk("Invalid crypto_user_data structure [size=%u, type=%x].\n", 
+						data.data_size, data.data_type);
+				err = -EINVAL;
+				break;
+			}
+
+			if (iok->ptr[data.data_type])
+				kfree(iok->ptr[data.data_type]);
+
+			iok->ptr[data.data_type] = kmalloc(data.data_size, GFP_KERNEL);
+			if (!iok->ptr[data.data_type]) {
+				dprintk("Failed to allocate %d bytes for data type %d.\n",
+						data.data_size, data.data_type);
+				err = -ENOMEM;
+				break;
+			}
+
+			not_read = copy_from_user(iok->ptr[data.data_type], (void __user *)arg + sizeof(data), data.data_size);
+			if (not_read) {
+				dprintk("Failed to read %d bytes of crypto data [type=%d] from userspace.\n",
+						data.data_size, data.data_type);
+				kfree(iok->ptr[data.data_type]);
+				err = -EINVAL;
+				break;
+			}
+
+			memcpy(&iok->usr[data.data_type], &data, sizeof(struct crypto_user_data));
+			
+			err = crypto_user_fill_sg_data(&data, &iok->data, iok->ptr[data.data_type]);
+			if (err) {
+				kfree(iok->ptr[data.data_type]);
+				break;
+			}
+			break;
+		case CRYPTO_SESSION_ADD:
+			if (!iok->s) {
+				dprintk("CRYPTO_SESSION_ADD must be called after session initialisation.\n");
+				err = -EINVAL;
+				break;
+			}
+			
+			err = crypto_user_ioctl_session_add(iok);
+			if (err)
+				break;
+
+			wait_event_interruptible(iok->wait, iok->scompleted);
+
+			dump_data(iok->ptr[CRYPTO_USER_DATA_DST]);
+
+			not_read = copy_to_user((void __user *)arg, iok->ptr[CRYPTO_USER_DATA_DST], iok->usr[CRYPTO_USER_DATA_DST].data_size);
+			if (not_read) {
+				dprintk("Failed to copy to user %d bytes of result.\n", iok->usr[CRYPTO_USER_DATA_DST].data_size);
+				err = -EINVAL;
+				break;
+			}
+			break;
+
+		default:
+			dprintk("Invalid ioctl(0x%x).\n", cmd);
+			err = -ENODEV;
+			break;
+	}
+	
+	return err;
+}
+
+static ssize_t crypto_user_ioctl_dev_show(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%u:%u\n", crypto_user_ioctl_major, 0);
+}
+
+extern struct crypto_device main_crypto_device;
+static CLASS_DEVICE_ATTR(dev, 0644, crypto_user_ioctl_dev_show, NULL);
+
+int crypto_user_ioctl_init(void)
+{
+	struct crypto_device *dev = &main_crypto_device;
+	int err;
+
+	crypto_user_ioctl_major = register_chrdev(0, crypto_user_ioctl_name, &crypto_user_ioctl_ops);
+       	if (crypto_user_ioctl_major < 0) {
+		dprintk("Failed to register %s char device: err=%d.\n", crypto_user_ioctl_name, crypto_user_ioctl_major);
+		return -ENODEV;
+	};
+	
+	err = class_device_create_file(&dev->class_device, &class_device_attr_dev);
+	if (err)
+		dprintk("Failed to create \"dev\" attribute: err=%d.\n", err);
+
+	printk("Asynchronous crypto userspace helper(ioctl based) has been started, major=%d.\n", crypto_user_ioctl_major);
+
+	return 0;
+}
+
+void crypto_user_ioctl_fini(void)
+{
+	struct crypto_device *dev = &main_crypto_device;
+
+	class_device_remove_file(&dev->class_device, &class_device_attr_dev);
+	unregister_chrdev(crypto_user_ioctl_major, crypto_user_ioctl_name);
+}

