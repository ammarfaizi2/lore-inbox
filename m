Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVCGUis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVCGUis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVCGUe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:34:28 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:8881 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261780AbVCGUMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:35 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [15/many] acrypto: crypto_user.c
In-Reply-To: <1110227855676@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:35 +0300
Message-Id: <11102278551109@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/empty/crypto_user.c	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/crypto_user.c	2005-03-07 20:35:36.000000000 +0300
@@ -0,0 +1,196 @@
+/*
+ * 	crypto_user.c
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
+
+#include "acrypto.h"
+#include "crypto_user.h"
+
+static struct scatterlist *crypto_user_alloc_sg(int sg_num)
+{
+	struct scatterlist *sg;
+
+	sg = kmalloc(sg_num * sizeof(*sg), GFP_ATOMIC);
+	if (!sg) {
+		dprintk("Failed to allocate %d scatterlist structures.\n", sg_num);
+		return NULL;
+	}
+
+	memset(sg, 0, sizeof(*sg) * sg_num);
+
+	return sg;
+}
+
+static void crypto_user_free_sg(struct scatterlist *sg)
+{
+	kfree(sg);
+}
+
+int crypto_user_alloc_crypto_data(struct crypto_data *data, int src_size, int dst_size, int key_size, int iv_size)
+{
+	int sg_num;
+
+	if (	(src_size > MAX_DATA_SIZE * PAGE_SIZE) ||
+		(dst_size > MAX_DATA_SIZE * PAGE_SIZE) ||
+		(key_size > MAX_DATA_SIZE * PAGE_SIZE) ||
+		(iv_size  > MAX_DATA_SIZE * PAGE_SIZE)) {
+		dprintk("Sizes are too big: src=%u, dst=%u, key=%u, iv=%u, max=%u.\n",
+				src_size, dst_size, key_size, iv_size, MAX_DATA_SIZE);
+		return -EINVAL;
+	
+	}
+
+	sg_num = ALIGN_DATA_SIZE(src_size) / PAGE_SIZE;
+	data->sg_src = crypto_user_alloc_sg(sg_num);
+	if (!data->sg_src)
+		goto err_out_exit;
+	data->sg_src_num = sg_num;
+	
+	sg_num = ALIGN_DATA_SIZE(dst_size) / PAGE_SIZE;
+	data->sg_dst = crypto_user_alloc_sg(sg_num);
+	if (!data->sg_dst)
+		goto err_out_free_src;
+	data->sg_dst_num = sg_num;
+	
+	sg_num = ALIGN_DATA_SIZE(key_size) / PAGE_SIZE;
+	data->sg_key = crypto_user_alloc_sg(sg_num);
+	if (!data->sg_key)
+		goto err_out_free_dst;
+	data->sg_key_num = sg_num;
+	
+	sg_num = ALIGN_DATA_SIZE(iv_size) / PAGE_SIZE;
+	data->sg_iv = crypto_user_alloc_sg(sg_num);
+	if (!data->sg_iv)
+		goto err_out_free_key;
+	data->sg_iv_num = sg_num;
+
+	return 0;
+
+err_out_free_key:
+	crypto_user_free_sg(data->sg_key);
+err_out_free_dst:
+	crypto_user_free_sg(data->sg_dst);
+err_out_free_src:
+	crypto_user_free_sg(data->sg_src);
+err_out_exit:
+
+	return -ENOMEM;
+}
+
+void crypto_user_free_crypto_data(struct crypto_data *data)
+{
+	crypto_user_free_sg(data->sg_src);
+	crypto_user_free_sg(data->sg_dst);
+	crypto_user_free_sg(data->sg_key);
+	crypto_user_free_sg(data->sg_iv);
+}
+
+void crypto_user_fill_sg(void *ptr, u16 size, struct scatterlist *sg)
+{
+	int i, sg_num;
+
+	sg_num = ALIGN_DATA_SIZE(size) / PAGE_SIZE;
+
+	dprintk("Filling %d sgs, total size %u: ", sg_num, size);
+	
+	for (i=0; i<sg_num; ++i) {
+		sg[i].page = virt_to_page(ptr);
+		if (i == 0) {
+			sg[i].offset = offset_in_page(ptr);
+			sg[i].length = ALIGN_DATA_SIZE((unsigned long)ptr) - (unsigned long)ptr;
+			if (sg[i].length == 0)
+				sg[i].length = PAGE_SIZE;
+			if (sg[i].length > size) 
+				sg[i].length = size;
+		} else {
+			sg[i].offset = 0;
+			sg[i].length = (i != sg_num-1)?PAGE_SIZE:size;
+		}
+		dprintka("%x.%x.%p.%lx ", sg[i].offset, sg[i].length, ptr, ALIGN_DATA_SIZE((unsigned long)ptr));
+		
+		size 	-= sg[i].length;
+		ptr 	+= sg[i].length;
+	}
+	dprintka("\n");
+}
+
+struct scatterlist *crypto_user_get_sg(struct crypto_user_data *ud, struct crypto_data *data)
+{
+	struct scatterlist *sg = NULL;
+	int inval = 0;
+	
+	switch (ud->data_type) {
+		case CRYPTO_USER_DATA_SRC:
+			sg = data->sg_src;
+			inval = (data->sg_src_num * PAGE_SIZE < ud->data_size);
+			dprintk("Found SRC data type, inval=%d, size=%u.\n", inval, ud->data_size);
+			break;
+		case CRYPTO_USER_DATA_DST:
+			sg = data->sg_dst;
+			inval = (data->sg_dst_num * PAGE_SIZE < ud->data_size);
+			dprintk("Found DST data type, inval=%d, size=%u.\n", inval, ud->data_size);
+			break;
+		case CRYPTO_USER_DATA_KEY:
+			sg = data->sg_key;
+			inval = (data->sg_key_num * PAGE_SIZE < ud->data_size);
+			dprintk("Found KEY data type, inval=%d, size=%u.\n", inval, ud->data_size);
+			break;
+		case CRYPTO_USER_DATA_IV:
+			sg = data->sg_iv;
+			inval = (data->sg_iv_num * PAGE_SIZE < ud->data_size);
+			dprintk("Found  IV data type, inval=%d, size=%u.\n", inval, ud->data_size);
+			break;
+		default:
+			dprintk("Unknown data type 0x%x, size=%u.\n", ud->data_type, ud->data_size);
+			break;
+	}
+
+	return (inval)?NULL:sg;
+}
+
+int crypto_user_fill_sg_data(struct crypto_user_data *ud, struct crypto_data *data, void *ptr)
+{
+	struct scatterlist *sg;
+
+	sg = crypto_user_get_sg(ud, data);
+	if (!sg)
+		return -EINVAL;
+
+	crypto_user_fill_sg(ptr, ud->data_size, sg);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(crypto_user_alloc_crypto_data);
+EXPORT_SYMBOL_GPL(crypto_user_free_crypto_data);
+EXPORT_SYMBOL_GPL(crypto_user_fill_sg);
+EXPORT_SYMBOL_GPL(crypto_user_fill_sg_data);
+EXPORT_SYMBOL_GPL(crypto_user_get_sg);

