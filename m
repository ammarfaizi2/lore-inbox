Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422724AbWA1ATk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWA1ATk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWA1ATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:19:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:19898 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422724AbWA1ATj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:19:39 -0500
Subject: [patch 1/6] Create and Use common mempool allocators
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060128001539.030809000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 27 Jan 2006 16:19:35 -0800
Message-Id: <1138407575.26088.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-add_page_allocator.patch)
From: Matthew Dobson <colpatch@us.ibm.com>
Subject: [patch 1/6] mempool - Add page allocator

Add an allocator to the common mempool code: a simple page allocator

This will be used by the next patch in the series to replace duplicate
mempool-backed page allocators in 2 places in the kernel.  It is also
likely that there will be more users in the future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |    7 +++++++
 mm/mempool.c            |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

Index: linux-2.6.16-rc1-mm3+mempool_work/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/mm/mempool.c
+++ linux-2.6.16-rc1-mm3+mempool_work/mm/mempool.c
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
Index: linux-2.6.16-rc1-mm3+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm3+mempool_work/include/linux/mempool.h
@@ -38,4 +38,11 @@ extern void mempool_free(void *element, 
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
 
+/*
+ * A mempool_alloc_t and mempool_free_t for a simple page allocator that
+ * allocates pages of the order specified by pool_data
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data);
+void mempool_free_pages(void *element, void *pool_data);
+
 #endif /* _LINUX_MEMPOOL_H */

--

