Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWA3VZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWA3VZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbWA3VZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:25:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:40844 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030180AbWA3VYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:24:54 -0500
Subject: [patch 1/8] mempool - Add page allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:23:37 -0800
Message-Id: <1138656217.20704.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-add_page_allocator.patch)
Add an allocator to the common mempool code: a simple page allocator

This will be used by the next patch in the series to replace duplicate
mempool-backed page allocators in 2 places in the kernel.  It is also
likely that there will be more users in the future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |   12 ++++++++++++
 mm/mempool.c            |   18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

Index: linux-2.6.16-rc1-mm4+mempool_work/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/mm/mempool.c
+++ linux-2.6.16-rc1-mm4+mempool_work/mm/mempool.c
@@ -289,3 +289,21 @@ void mempool_free_slab(void *element, vo
 	kmem_cache_free(mem, element);
 }
 EXPORT_SYMBOL(mempool_free_slab);
+
+/*
+ * A simple mempool-backed page allocator that allocates pages
+ * of the order specified by pool_data.
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data)
+{
+	int order = (int) pool_data;
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL(mempool_alloc_pages);
+
+void mempool_free_pages(void *element, void *pool_data)
+{
+	int order = (int) pool_data;
+	__free_pages(element, order);
+}
+EXPORT_SYMBOL(mempool_free_pages);
Index: linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
@@ -38,4 +38,16 @@ extern void mempool_free(void *element, 
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
 
+/*
+ * A mempool_alloc_t and mempool_free_t for a simple page allocator that
+ * allocates pages of the order specified by pool_data
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data);
+void mempool_free_pages(void *element, void *pool_data);
+static inline mempool_t *mempool_create_page_pool(int min_nr, int order)
+{
+	return mempool_create(min_nr, mempool_alloc_pages, mempool_free_pages,
+			      (void *) order);
+}
+
 #endif /* _LINUX_MEMPOOL_H */

--

