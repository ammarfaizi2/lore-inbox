Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVCGVVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVCGVVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVCGVUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:20:23 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:19122 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261824AbVCGUNp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:45 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [17/many] acrypto: crypto_user_direct.c
In-Reply-To: <11102278551459@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <111022785593@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_user_direct.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_user_direct.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,390 @@
+/*
+ * 	crypto_user_direct.c
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
+#include <linux/vmalloc.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/connector.h>
+
+#include "acrypto.h"
+#include "crypto_user.h"
+#include "crypto_user_direct.h"
+
+extern struct cb_id crypto_conn_id;
+
+static LIST_HEAD(crypto_user_direct_list);
+static spinlock_t crypto_user_direct_lock = SPIN_LOCK_UNLOCKED;
+static struct completion thread_exited;
+static int need_exit;
+static DECLARE_WAIT_QUEUE_HEAD(crypto_user_direct_wait_queue);
+
+static int crypto_user_direct_alloc_pages(struct crypto_user_direct_kern *k)
+{
+	k->sp = kmalloc(sizeof(struct page *) * k->snum, GFP_KERNEL);
+	if (!k->sp) {
+		dprintk("Failed to allocate %d source pages.\n", k->snum);
+		return -ENOMEM;
+	}
+	
+	k->dp = kmalloc(sizeof(struct page *) * k->dnum, GFP_KERNEL);
+	if (!k->dp) {
+		dprintk("Failed to allocate %d destination pages.\n", k->dnum);
+		kfree(k->sp);
+		return -ENOMEM;
+	}
+	
+	return 0;
+}
+
+static void crypto_user_direct_free_pages(struct crypto_user_direct_kern *k)
+{
+	kfree(k->sp);
+	kfree(k->dp);
+}
+
+static int crypto_user_direct_alloc_vmas(struct crypto_user_direct_kern *k)
+{
+	k->svma = kmalloc(sizeof(struct vm_area_struct *) * k->snum, GFP_KERNEL);
+	if (!k->svma) {
+		dprintk("Failed to allocate %d source vmas.\n", k->snum);
+		return -ENOMEM;
+	}
+	
+	k->dvma = kmalloc(sizeof(struct vm_area_struct *) * k->dnum, GFP_KERNEL);
+	if (!k->dvma) {
+		dprintk("Failed to allocate %d destination vmas.\n", k->dnum);
+		kfree(k->svma);
+		return -ENOMEM;
+	}
+	
+	return 0;
+}
+
+static void crypto_user_direct_free_vmas(struct crypto_user_direct_kern *k)
+{
+	kfree(k->svma);
+	kfree(k->dvma);
+}
+
+static int crypto_user_direct_alloc_mm(struct crypto_user_direct_kern *k)
+{
+	int err;
+
+	err = crypto_user_direct_alloc_pages(k);
+	if (err)
+		return err;
+	
+	err = crypto_user_direct_alloc_vmas(k);
+	if (err) {
+		crypto_user_direct_free_pages(k);
+		return err;
+	}
+
+	return 0;
+}
+
+static void crypto_user_direct_free_mm(struct crypto_user_direct_kern *k)
+{
+	crypto_user_direct_free_pages(k);
+	crypto_user_direct_free_vmas(k);
+}
+
+static void crypto_user_direct_free_data(struct crypto_user_direct_kern *k)
+{
+	int i;
+	
+	for (i=0; i<k->snum; ++i)
+		page_cache_release(k->sp[i]);
+	for (i=0; i<k->dnum; ++i) {
+		set_page_dirty_lock(k->dp[i]);
+		page_cache_release(k->dp[i]);
+	}
+	up_read(&k->mm->mmap_sem);
+	crypto_user_direct_free_mm(k);
+	mmput(k->mm);
+}
+
+static void crypto_user_direct_callback(struct crypto_session_initializer *ci, struct crypto_data *data)
+{
+	struct crypto_user_direct_kern *k = data->priv;
+	struct cn_msg m;
+
+	memset(&m, 0, sizeof(m));
+
+	memcpy(&m.id, &crypto_conn_id, sizeof(m.id));
+	m.seq = k->seq;
+	m.ack = k->ack+1;
+
+	cn_netlink_send(&m, 0);
+
+	crypto_user_direct_free_data(k);
+	crypto_user_free_crypto_data(data);
+}
+
+static void crypto_user_direct_fill_data(struct crypto_data *data, struct crypto_user_direct_kern *k)
+{
+	int i, size;
+
+	size = k->usr.src_size;
+	for (i=0; i<data->sg_src_num; ++i) {
+		data->sg_src[i].page = k->sp[i];
+
+		if (i == 0) {
+			data->sg_src[i].offset = offset_in_page(k->usr.src);
+			data->sg_src[i].length = ALIGN_DATA_SIZE(k->usr.src) - k->usr.src;
+		} else {
+			data->sg_src[i].offset = 0;
+			data->sg_src[i].length = (i != data->sg_src_num)?PAGE_SIZE:size;
+		}
+
+		size -= data->sg_src[i].length;
+	}
+	
+	size = k->usr.dst_size;
+	for (i=0; i<data->sg_dst_num; ++i) {
+		data->sg_dst[i].page = k->dp[i];
+
+		if (i == 0) {
+			data->sg_dst[i].offset = offset_in_page(k->usr.dst);
+			data->sg_dst[i].length = ALIGN_DATA_SIZE(k->usr.dst) - k->usr.dst;
+		} else {
+			data->sg_dst[i].offset = 0;
+			data->sg_dst[i].length = (i != data->sg_dst_num)?PAGE_SIZE:size;
+		}
+
+		size -= data->sg_dst[i].length;
+	}
+}
+
+static int crypto_user_direct_prepare_data(struct crypto_data *data, struct crypto_user_direct_kern *k)
+{
+	int err, i;
+	struct task_struct *tsk;
+
+	tsk = find_task_by_pid(k->usr.pid);
+	if (!tsk) {
+		dprintk(KERN_ERR "Task with pid=%d does not exist.\n", k->usr.pid);
+		return -ENODEV;
+	}
+
+	dprintk("Found task with pid=%d.\n", k->usr.pid);
+
+	k->mm = get_task_mm(tsk);
+	if (!k->mm)
+		return -EINVAL;
+
+	k->snum = data->sg_src_num;
+	k->dnum = data->sg_dst_num;
+
+	err = crypto_user_direct_alloc_mm(k);
+	if (err)
+		goto err_out_put_mm;
+
+	down_read(&k->mm->mmap_sem);
+		
+	err = get_user_pages(tsk, k->mm, k->usr.src, k->snum, 1, 1, k->sp, k->svma);
+	if (err < 0) {
+		dprintk("Failed to get %d src pages for pid=%d.\n",
+				k->snum, k->usr.pid);
+		goto err_out_up_sem;
+	}
+	
+	err = get_user_pages(tsk, k->mm, k->usr.dst, k->dnum, 1, 1, k->dp, k->dvma);
+	if (err < 0) {
+		dprintk("Failed to get %d dst pages for pid=%d.\n",
+				k->snum, k->usr.pid);
+		goto err_out_put_src;
+	}
+
+	crypto_user_direct_fill_data(data, k);
+
+	return 0;
+
+err_out_put_src:
+	for (i=0; i<k->snum; ++i)
+		page_cache_release(k->sp[i]);
+err_out_up_sem:
+	up_read(&k->mm->mmap_sem);
+	
+	crypto_user_direct_free_mm(k);
+err_out_put_mm:
+	mmput(k->mm);
+	return err;
+}
+
+static int crypto_user_direct_prepare(struct crypto_session_initializer *ci, struct crypto_data *data, struct crypto_user_direct_kern *k)
+{
+	int err;
+
+	ci->operation 		= k->usr.operation;
+	ci->type 		= k->usr.type;
+	ci->mode 		= k->usr.mode;
+	ci->priority 		= k->usr.priority;
+	ci->callback 		= crypto_user_direct_callback;
+
+	err = crypto_user_alloc_crypto_data(data, k->usr.src_size, k->usr.dst_size, k->usr.key_size, k->usr.iv_size);
+	if (err)
+		return err;
+
+	if (k->usr.key_size)
+		crypto_user_fill_sg(k->key, k->usr.key_size, data->sg_key);
+	
+	if (k->usr.iv_size)
+		crypto_user_fill_sg(k->iv, k->usr.iv_size, data->sg_iv);
+
+	data->priv		= k;
+	data->priv_size		= 0;
+
+	err = crypto_user_direct_prepare_data(data, k);
+	if (err) {
+		crypto_user_free_crypto_data(data);
+		return err;
+	}
+
+	return 0;
+}
+
+static int crypto_user_direct_process(struct crypto_user_direct_kern *k)
+{
+	struct crypto_session_initializer ci;
+	struct crypto_data data;
+	struct crypto_session *s;
+	int err;
+
+	memset(&ci, 0, sizeof(ci));
+	memset(&data, 0, sizeof(data));
+
+	err = crypto_user_direct_prepare(&ci, &data, k);
+	if (err)
+		return err;
+
+	s = crypto_session_alloc(&ci, &data);
+	if (!s) {
+		crypto_user_direct_free_data(k);
+		return -EINVAL;
+	}
+
+	return 0;
+}	
+
+static int crypto_user_direct_thread(void *data)
+{
+	struct crypto_user_direct_kern *k, *n;
+
+	daemonize("crypto_user_direct_thread");
+	allow_signal(SIGTERM);
+
+	while (!need_exit) {
+		interruptible_sleep_on_timeout(&crypto_user_direct_wait_queue, 1000);
+
+		spin_lock_bh(&crypto_user_direct_lock);
+		list_for_each_entry_safe(k, n, &crypto_user_direct_list, entry) {
+			list_del(&k->entry);
+
+			spin_unlock_bh(&crypto_user_direct_lock);
+			
+			crypto_user_direct_process(k);
+			
+			spin_lock_bh(&crypto_user_direct_lock);
+		}
+		spin_unlock_bh(&crypto_user_direct_lock);
+	}
+
+	complete_and_exit(&thread_exited, 0);
+}
+
+int crypto_user_direct_add_request(u32 seq, u32 ack, struct crypto_user_direct *usr)
+{
+	struct crypto_user_direct_kern *k;
+
+	k = kmalloc(sizeof(struct crypto_user_direct_kern) + usr->key_size + usr->iv_size, GFP_ATOMIC);
+	if (!k) {
+		dprintk("Failed to allocate new kernel crypto request.\n");
+		return -ENOMEM;
+	}
+
+	memset(k, 0, sizeof(*k));
+	
+	memcpy(&k->usr, usr, sizeof(k->usr));
+	
+	k->key = (u8 *)(k+1);
+	k->iv = (u8 *)(k->key + k->usr.key_size);
+
+	memcpy(k->key, usr->data, k->usr.key_size);
+	memcpy(k->iv, usr->data + k->usr.key_size, k->usr.iv_size);
+
+	k->seq = seq;
+	k->ack = ack;
+		
+	spin_lock_bh(&crypto_user_direct_lock);
+	list_add(&k->entry, &crypto_user_direct_list);
+	spin_unlock_bh(&crypto_user_direct_lock);
+
+	dprintk("msg [%08x.%08x]: op=[%04x.%04x.%04x.%04x], src=%llx [%d], dst=%llx [%d], key=%p [%d], iv=%p [%d].\n",
+			seq, ack, 
+			k->usr.operation, k->usr.mode, k->usr.type, k->usr.priority,
+			k->usr.src, k->usr.src_size,
+			k->usr.dst, k->usr.dst_size,
+			k->key, k->usr.key_size,
+			k->iv, k->usr.iv_size);
+
+	wake_up_interruptible(&crypto_user_direct_wait_queue);
+
+	return 0;
+}
+
+int crypto_user_direct_init(void)
+{
+	int pid, err;
+
+	err = 0;
+	init_completion(&thread_exited);
+	pid = kernel_thread(crypto_user_direct_thread, NULL, CLONE_FS | CLONE_FILES);
+	if (IS_ERR((void *)pid)) {
+		dprintk(KERN_ERR "Failed to create acrypto userspace processing thread.\n");
+		err = -EINVAL;
+		goto err_out_exit;
+	}
+
+	printk(KERN_INFO "Acrypto userspace processing thread has been started.\n");
+
+	return err;
+
+err_out_exit:
+
+	return err;
+}
+
+void crypto_user_direct_fini(void)
+{
+	need_exit = 1;
+	wait_for_completion(&thread_exited);
+	
+	printk(KERN_INFO "Acrypto userspace processing thread has been finished.\n");
+}

