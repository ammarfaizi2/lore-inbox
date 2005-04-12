Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVDLPsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVDLPsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVDLKtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:49:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:61130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262289AbVDLKdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:50 -0400
Message-Id: <200504121033.j3CAXSb4005889@shell0.pdx.osdl.net>
Subject: [patch 182/198] IB/mthca: add mthca_table_find() function
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Add mthca_table_find() function, which returns the lowmem address of an entry
in a mem-free HCA's context tables.  This will be used by the FMR
implementation.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c |   34 ++++++++++++++++++++
 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.h |    1 
 2 files changed, 35 insertions(+)

diff -puN drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-add-mthca_table_find-function drivers/infiniband/hw/mthca/mthca_memfree.c
--- 25/drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-add-mthca_table_find-function	2005-04-12 03:21:46.703036960 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-12 03:21:46.707036352 -0700
@@ -192,6 +192,40 @@ void mthca_table_put(struct mthca_dev *d
 	up(&table->mutex);
 }
 
+void *mthca_table_find(struct mthca_icm_table *table, int obj)
+{
+	int idx, offset, i;
+	struct mthca_icm_chunk *chunk;
+	struct mthca_icm *icm;
+	struct page *page = NULL;
+
+	if (!table->lowmem)
+		return NULL;
+
+	down(&table->mutex);
+
+	idx = (obj & (table->num_obj - 1)) * table->obj_size;
+	icm = table->icm[idx / MTHCA_TABLE_CHUNK_SIZE];
+	offset = idx % MTHCA_TABLE_CHUNK_SIZE;
+
+	if (!icm)
+		goto out;
+
+	list_for_each_entry(chunk, &icm->chunk_list, list) {
+		for (i = 0; i < chunk->npages; ++i) {
+			if (chunk->mem[i].length >= offset) {
+				page = chunk->mem[i].page;
+				break;
+			}
+			offset -= chunk->mem[i].length;
+		}
+	}
+
+out:
+	up(&table->mutex);
+	return page ? lowmem_page_address(page) + offset : NULL;
+}
+
 int mthca_table_get_range(struct mthca_dev *dev, struct mthca_icm_table *table,
 			  int start, int end)
 {
diff -puN drivers/infiniband/hw/mthca/mthca_memfree.h~ib-mthca-add-mthca_table_find-function drivers/infiniband/hw/mthca/mthca_memfree.h
--- 25/drivers/infiniband/hw/mthca/mthca_memfree.h~ib-mthca-add-mthca_table_find-function	2005-04-12 03:21:46.704036808 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-12 03:21:46.708036200 -0700
@@ -85,6 +85,7 @@ struct mthca_icm_table *mthca_alloc_icm_
 void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table);
 int mthca_table_get(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
 void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
+void *mthca_table_find(struct mthca_icm_table *table, int obj);
 int mthca_table_get_range(struct mthca_dev *dev, struct mthca_icm_table *table,
 			  int start, int end);
 void mthca_table_put_range(struct mthca_dev *dev, struct mthca_icm_table *table,
_
