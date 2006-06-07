Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWFGUIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWFGUIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFGUHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:07:50 -0400
Received: from rrcs-24-227-247-179.sw.biz.rr.com ([24.227.247.179]:28843 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S1751285AbWFGUG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:06:58 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH v2 5/7] AMSO1100 Message Queues.
Date: Wed, 07 Jun 2006 15:06:57 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060607200657.9259.48820.stgit@stevo-desktop>
In-Reply-To: <20060607200646.9259.24588.stgit@stevo-desktop>
References: <20060607200646.9259.24588.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Review Changes:

- remove useless asserts

- assert() -> BUG_ON()

- C2_DEBUG -> DEBUG
---

 drivers/infiniband/hw/amso1100/c2_mq.c |  175 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/amso1100/c2_mq.h |  103 +++++++++++++++++++
 2 files changed, 278 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/amso1100/c2_mq.c b/drivers/infiniband/hw/amso1100/c2_mq.c
new file mode 100644
index 0000000..0b0ab02
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_mq.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright (c) 2005 Ammasso, Inc. All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+#include "c2.h"
+#include "c2_mq.h"
+
+void *c2_mq_alloc(struct c2_mq *q)
+{
+	BUG_ON(q->magic != C2_MQ_MAGIC);
+	BUG_ON(q->type != C2_MQ_ADAPTER_TARGET);
+
+	if (c2_mq_full(q)) {
+		return NULL;
+	} else {
+#ifdef DEBUG
+		struct c2wr_hdr *m =
+		    (struct c2wr_hdr *) (q->msg_pool.host + q->priv * q->msg_size);
+#ifdef CCMSGMAGIC
+		BUG_ON(m->magic != be32_to_cpu(~CCWR_MAGIC));
+		m->magic = cpu_to_be32(CCWR_MAGIC);
+#endif
+		return m;
+#else
+		return q->msg_pool.host + q->priv * q->msg_size;
+#endif
+	}
+}
+
+void c2_mq_produce(struct c2_mq *q)
+{
+	BUG_ON(q->magic != C2_MQ_MAGIC);
+	BUG_ON(q->type != C2_MQ_ADAPTER_TARGET);
+
+	if (!c2_mq_full(q)) {
+		q->priv = (q->priv + 1) % q->q_size;
+		q->hint_count++;
+		/* Update peer's offset. */
+		__raw_writew(cpu_to_be16(q->priv), &q->peer->shared);
+	}
+}
+
+void *c2_mq_consume(struct c2_mq *q)
+{
+	BUG_ON(q->magic != C2_MQ_MAGIC);
+	BUG_ON(q->type != C2_MQ_HOST_TARGET);
+
+	if (c2_mq_empty(q)) {
+		return NULL;
+	} else {
+#ifdef DEBUG
+		struct c2wr_hdr *m = (struct c2wr_hdr *)
+		    (q->msg_pool.host + q->priv * q->msg_size);
+#ifdef CCMSGMAGIC
+		BUG_ON(m->magic != be32_to_cpu(CCWR_MAGIC));
+#endif
+		return m;
+#else
+		return q->msg_pool.host + q->priv * q->msg_size;
+#endif
+	}
+}
+
+void c2_mq_free(struct c2_mq *q)
+{
+	BUG_ON(q->magic != C2_MQ_MAGIC);
+	BUG_ON(q->type != C2_MQ_HOST_TARGET);
+
+	if (!c2_mq_empty(q)) {
+
+#ifdef CCMSGMAGIC
+		{
+			struct c2wr_hdr __iomem *m = (struct c2wr_hdr __iomem *)
+			    (q->msg_pool.adapter + q->priv * q->msg_size);
+			__raw_writel(cpu_to_be32(~CCWR_MAGIC), &m->magic);
+		}
+#endif
+		q->priv = (q->priv + 1) % q->q_size;
+		/* Update peer's offset. */
+		__raw_writew(cpu_to_be16(q->priv), &q->peer->shared);
+	}
+}
+
+
+void c2_mq_lconsume(struct c2_mq *q, u32 wqe_count)
+{
+	BUG_ON(q->magic != C2_MQ_MAGIC);
+	BUG_ON(q->type != C2_MQ_ADAPTER_TARGET);
+
+	while (wqe_count--) {
+		BUG_ON(c2_mq_empty(q));
+		*q->shared = cpu_to_be16((be16_to_cpu(*q->shared)+1) % q->q_size);
+	}
+}
+
+
+u32 c2_mq_count(struct c2_mq *q)
+{
+	s32 count;
+
+	if (q->type == C2_MQ_HOST_TARGET) {
+		count = be16_to_cpu(*q->shared) - q->priv;
+	} else {
+		count = q->priv - be16_to_cpu(*q->shared);
+	}
+
+	if (count < 0) {
+		count += q->q_size;
+	}
+
+	return (u32) count;
+}
+
+void c2_mq_req_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
+		    u8 __iomem *pool_start, u16 __iomem *peer, u32 type)
+{
+	BUG_ON(!q->shared);
+
+	/* This code assumes the byte swapping has already been done! */
+	q->index = index;
+	q->q_size = q_size;
+	q->msg_size = msg_size;
+	q->msg_pool.adapter = pool_start;
+	q->peer = (struct c2_mq_shared __iomem *) peer;
+	q->magic = C2_MQ_MAGIC;
+	q->type = type;
+	q->priv = 0;
+	q->hint_count = 0;
+	return;
+}
+void c2_mq_rep_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
+		    u8 *pool_start, u16 __iomem *peer, u32 type)
+{
+	BUG_ON(!q->shared);
+
+	/* This code assumes the byte swapping has already been done! */
+	q->index = index;
+	q->q_size = q_size;
+	q->msg_size = msg_size;
+	q->msg_pool.host = pool_start;
+	q->peer = (struct c2_mq_shared __iomem *) peer;
+	q->magic = C2_MQ_MAGIC;
+	q->type = type;
+	q->priv = 0;
+	q->hint_count = 0;
+	return;
+}
diff --git a/drivers/infiniband/hw/amso1100/c2_mq.h b/drivers/infiniband/hw/amso1100/c2_mq.h
new file mode 100644
index 0000000..de00184
--- /dev/null
+++ b/drivers/infiniband/hw/amso1100/c2_mq.h
@@ -0,0 +1,103 @@
+/*
+ * Copyright (c) 2005 Ammasso, Inc. All rights reserved.
+ * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef _C2_MQ_H_
+#define _C2_MQ_H_
+#include <linux/kernel.h>
+#include "c2_wr.h"
+
+enum c2_shared_regs {
+
+	C2_SHARED_ARMED = 0x10,
+	C2_SHARED_NOTIFY = 0x18,
+	C2_SHARED_SHARED = 0x40,
+};
+
+struct c2_mq_shared {
+	u16 unused1;
+	u8 armed;
+	u8 notification_type;
+	u32 unused2;
+	u16 shared;
+	/* Pad to 64 bytes. */
+	u8 pad[64 - sizeof(u16) - 2 * sizeof(u8) - sizeof(u32) - sizeof(u16)];
+};
+
+enum c2_mq_type {
+	C2_MQ_HOST_TARGET = 1,
+	C2_MQ_ADAPTER_TARGET = 2,
+};
+
+/*
+ * c2_mq_t is for kernel-mode MQs like the VQs Cand the AEQ.
+ * c2_user_mq_t (which is the same format) is for user-mode MQs...
+ */
+#define C2_MQ_MAGIC 0x4d512020	/* 'MQ  ' */
+struct c2_mq {
+	u32 magic; 
+	union {
+		u8 *host;
+		u8 __iomem *adapter;
+	} msg_pool;
+	u16 hint_count;
+	u16 priv;
+	struct c2_mq_shared __iomem *peer;
+	u16 *shared;
+	u32 q_size;
+	u32 msg_size;
+	u32 index;
+	enum c2_mq_type type;
+};
+
+static __inline__ int c2_mq_empty(struct c2_mq *q)
+{
+	return q->priv == be16_to_cpu(*q->shared);
+}
+
+static __inline__ int c2_mq_full(struct c2_mq *q)
+{
+	return q->priv == (be16_to_cpu(*q->shared) + q->q_size - 1) % q->q_size;
+}
+
+extern void c2_mq_lconsume(struct c2_mq *q, u32 wqe_count);
+extern void *c2_mq_alloc(struct c2_mq *q);
+extern void c2_mq_produce(struct c2_mq *q);
+extern void *c2_mq_consume(struct c2_mq *q);
+extern void c2_mq_free(struct c2_mq *q);
+extern u32 c2_mq_count(struct c2_mq *q);
+extern void c2_mq_req_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
+		       u8 __iomem *pool_start, u16 __iomem *peer, u32 type);
+extern void c2_mq_rep_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
+			   u8 *pool_start, u16 __iomem *peer, u32 type);
+
+#endif				/* _C2_MQ_H_ */
