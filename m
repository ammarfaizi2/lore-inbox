Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVCGUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVCGUwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVCGUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:50:50 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:49329 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261798AbVCGUNN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:13 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [4/many] acrypto: async_provider.c
In-Reply-To: <11102278533380@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <11102278533364@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/async_provider.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/async_provider.c	2005-03-07 21:19:10.000000000 +0300
@@ -0,0 +1,322 @@
+/*
+ * 	async_provider.c
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
+#include <linux/crypto.h>
+#include <linux/mm.h>
+#include <linux/blkdev.h>
+
+#include "acrypto.h"
+#include "crypto_stat.h"
+#include "crypto_def.h"
+#include "crypto_route.h"
+#include "crypto_user.h"
+
+static unsigned int trnum = 1;
+module_param(trnum, uint, 0);
+
+static void prov_data_ready(struct crypto_device *);
+
+static struct crypto_capability prov_caps[] = {
+		{CRYPTO_OP_ENCRYPT, CRYPTO_TYPE_AES_128, CRYPTO_MODE_ECB, 100},
+		{CRYPTO_OP_DECRYPT, CRYPTO_TYPE_AES_128, CRYPTO_MODE_ECB, 100},
+		
+		{CRYPTO_OP_ENCRYPT, CRYPTO_TYPE_AES_128, CRYPTO_MODE_CBC, 100},
+		{CRYPTO_OP_DECRYPT, CRYPTO_TYPE_AES_128, CRYPTO_MODE_CBC, 100},
+};
+static int prov_cap_number = sizeof(prov_caps)/sizeof(prov_caps[0]);
+
+static int need_exit;
+static char async_algo[] = "aes";
+static char async_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+
+static struct crypto_device pdev = {
+	.name			= "async_provider",
+	.data_ready		= prov_data_ready,
+	.cap			= &prov_caps[0],
+};
+
+static struct async_provider
+{
+	int 			num;
+	struct crypto_tfm 	*tfm;
+	wait_queue_head_t	async_wait_queue;
+	struct completion 	thread_exited;
+	struct crypto_device	pdev;
+} *aprov;
+
+static void prov_data_ready(struct crypto_device *dev)
+{
+	struct async_provider *p;
+
+	p = (struct async_provider *)dev->priv;
+
+	if (p)
+		wake_up_interruptible(&p->async_wait_queue);
+}
+
+static int async_thread(void *data)
+{
+	struct async_provider *p = (struct async_provider *)data;
+	struct crypto_device *dev = &p->pdev;
+	struct crypto_session *s, *n;
+	int i, err, keylen, ivlen;
+	u8 *key, *iv;
+	int zero_pnum_cnt = 0;
+
+	daemonize("%s", dev->name);
+	allow_signal(SIGTERM);
+
+	while (!need_exit) {
+		int num, pnum;
+		
+		if (need_exit)
+			break;
+
+		num = pnum = 0;
+		list_for_each_entry_safe(s, n, &dev->session_list, dev_queue_entry) {
+			num++;
+			
+			if (session_completed(s))
+				continue;
+
+			pnum++;
+
+			start_process_session(s);
+			
+			if (s->data.sg_src_num != s->data.sg_dst_num) {
+				dprintk("Broken session: sg_src_num [%d] != sg_dst_num [%d].\n",
+						s->data.sg_src_num, s->data.sg_dst_num);
+				broke_session(s);
+				goto out;
+			}
+			
+			/*
+			 * Simple case - key is small(it's size is less than PAGE_SIZE).
+			 * Assymetric crypto will require proper key sg handling.
+			 */
+			key = kmap(s->data.sg_key[0].page) + s->data.sg_key[0].offset;
+			keylen = s->data.sg_key[0].length;
+
+			err = crypto_cipher_setkey(p->tfm, key, keylen);
+			if (err) {
+				dprintk(KERN_ERR "Failed to set key [keylen=%d]: err=%d.\n", keylen, err);
+				broke_session(s);
+				goto out;
+			}
+
+			if (s->ci.mode != CRYPTO_MODE_ECB) {
+				if (!s->data.sg_iv || !s->data.sg_iv_num) {
+					dprintk("Crypto mode %d requires IV.\n", s->ci.mode);
+					broke_session(s);
+					goto out;
+				}
+				
+				iv = kmap(s->data.sg_iv[0].page) + s->data.sg_iv[0].offset;
+				ivlen = s->data.sg_iv[0].length;
+
+				if (!iv || !ivlen) {
+					dprintk("Crypto mode %d requires IV, whic is broken: iv=%p, ivlen=%d.\n", 
+							s->ci.mode, iv, ivlen);
+					broke_session(s);
+					goto out;
+				}
+
+				crypto_cipher_set_iv(p->tfm, iv, ivlen);
+			} else {
+				iv = NULL;
+				ivlen = 0;
+			}
+			
+			for (i=0; i<s->data.sg_src_num; ++i) {
+				u8 *dst, *src;
+				int len;
+				
+				dst = kmap_atomic(s->data.sg_dst[i].page, KM_USER0) + s->data.sg_dst[i].offset;
+				src = kmap_atomic(s->data.sg_src[i].page, KM_USER1) + s->data.sg_src[i].offset;
+				len = s->data.sg_src[i].length;
+
+				if (s->ci.operation == CRYPTO_OP_ENCRYPT)
+					err = crypto_cipher_encrypt(p->tfm, &s->data.sg_dst[i], &s->data.sg_src[i], s->data.sg_src[i].length);
+				else
+					err = crypto_cipher_decrypt(p->tfm, &s->data.sg_dst[i], &s->data.sg_src[i], s->data.sg_src[i].length);
+
+				kunmap_atomic(src, KM_USER1);
+				kunmap_atomic(dst, KM_USER0);
+			
+				s->data.sg_dst[i].length = s->data.sg_src[i].length;
+				s->data.sg_dst[i].offset = s->data.sg_src[i].offset;
+
+				if (err < 0) {
+					broke_session(s);
+					printk("operation=%02x, size=%u, err=%d.\n", s->ci.operation, s->data.sg_src[i].length, err);
+				}
+			}
+
+			kunmap(s->data.sg_key[0].page);
+
+			if (iv)
+				kunmap(s->data.sg_iv[0].page);
+			
+			dprintk("%lu: Completing session %llu [%llu] in %s.\n", 
+					jiffies, s->ci.id, s->ci.dev_id, pdev.name);
+out:
+			crypto_stat_complete_inc(s);
+			crypto_session_dequeue_route(s);
+			complete_session(s);
+			stop_process_session(s);
+		}
+
+		if (!pnum)
+			zero_pnum_cnt++;
+		else
+			zero_pnum_cnt = 0;
+
+		if (unlikely(zero_pnum_cnt == 1000)) {
+			zero_pnum_cnt = 0;
+			interruptible_sleep_on_timeout(&p->async_wait_queue, 10);
+		}
+	}
+	
+	complete_and_exit(&p->thread_exited, 0);
+}
+
+static int prov_init_one(struct async_provider *p)
+{
+	int pid, err;
+
+	init_waitqueue_head(&p->async_wait_queue);
+	
+	p->tfm = crypto_alloc_tfm(async_algo, CRYPTO_TFM_MODE_CBC);
+	if (!p->tfm) {
+		dprintk(KERN_ERR "Failed to allocate %d's %s tfm.\n", p->num, async_algo);
+		return -EINVAL;
+	}
+	
+	err = crypto_cipher_setkey(p->tfm, async_key, sizeof(async_key));
+	if (err) {
+		dprintk("Failed to set key [keylen=%d]: err=%d.\n",
+				sizeof(async_key), err);
+		goto err_out_free_tfm;
+	}
+	
+	init_completion(&p->thread_exited);
+	pid = kernel_thread(async_thread, p, CLONE_FS | CLONE_FILES);
+	if (IS_ERR((void *)pid)) {
+		err = -EINVAL;
+		dprintk(KERN_ERR "Failed to create kernel load balancing thread.\n");
+		goto err_out_free_tfm;
+	}
+	
+	memcpy(&p->pdev, &pdev, sizeof(pdev));
+	snprintf(p->pdev.name, sizeof(p->pdev.name), "async_provider%d", p->num);
+
+	p->pdev.cap_number 	= prov_cap_number;
+	p->pdev.priv 		= p;
+
+	err = crypto_device_add(&p->pdev);
+	if (err)
+		goto err_out_remove_thread;
+
+	return 0;
+
+err_out_remove_thread:
+	need_exit = 1;
+	wake_up(&p->async_wait_queue);
+	wait_for_completion(&p->thread_exited);
+err_out_free_tfm:
+	crypto_free_tfm(p->tfm);
+
+	return err;
+}
+
+static void prov_fini_one(struct async_provider *p)
+{
+	crypto_device_remove(&p->pdev);
+	need_exit = 1;
+	wake_up(&p->async_wait_queue);
+	wait_for_completion(&p->thread_exited);
+
+	crypto_free_tfm(p->tfm);
+}
+
+int prov_init(void)
+{
+	int err, i;
+
+	aprov = kmalloc(trnum * sizeof(struct async_provider), GFP_KERNEL);
+	if (!aprov) {
+		dprintk(KERN_ERR "Failed to allocate %d async_provider pointers.\n", trnum);
+		return -ENOMEM;
+	}
+
+	memset(aprov, 0, trnum * sizeof(struct async_provider));
+
+	for (i=0; i<trnum; ++i) {
+		aprov[i].num = i;
+		
+		err = prov_init_one(&aprov[i]);
+		if (err)
+			goto err_out_fini_one;
+	}
+	
+	dprintk(KERN_INFO "Test crypto provider module %s is loaded for %d processors.\n", 
+			pdev.name, trnum);
+
+	return 0;
+
+err_out_fini_one:
+	i--;
+	while (i >= 0)
+		prov_fini_one(&aprov[i]);
+
+	kfree(aprov);
+
+	return err;
+}
+
+void prov_fini(void)
+{
+	int i;
+	
+	for (i=0; i<trnum; ++i)
+		prov_fini_one(&aprov[i]);
+	
+	kfree(aprov);
+
+	dprintk(KERN_INFO "Test crypto provider module %s is unloaded.\n", pdev.name);
+}
+
+module_init(prov_init);
+module_exit(prov_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Test crypto module provider.");

