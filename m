Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVDAVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVDAVBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVDAVBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:01:08 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262910AbVDAUvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:20 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][20/27] IB/mthca: add mthca_table_find() function
In-Reply-To: <2005411249.t0DdCtarOabubO3D@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.Tkvt1lzz8zEHUMmz@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0716 (UTC) FILETIME=[5B0CEF40:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Add mthca_table_find() function, which returns the lowmem address of
an entry in a mem-free HCA's context tables.  This will be used by the
FMR implementation.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:23.500859288 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:28.285820606 -0800
@@ -192,6 +192,40 @@
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
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-01 12:38:19.895641881 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.h	2005-04-01 12:38:28.280821691 -0800
@@ -85,6 +85,7 @@
 void mthca_free_icm_table(struct mthca_dev *dev, struct mthca_icm_table *table);
 int mthca_table_get(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
 void mthca_table_put(struct mthca_dev *dev, struct mthca_icm_table *table, int obj);
+void *mthca_table_find(struct mthca_icm_table *table, int obj);
 int mthca_table_get_range(struct mthca_dev *dev, struct mthca_icm_table *table,
 			  int start, int end);
 void mthca_table_put_range(struct mthca_dev *dev, struct mthca_icm_table *table,

