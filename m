Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWAYXvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWAYXvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWAYXvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:51:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:42164 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751236AbWAYXvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:51:19 -0500
Subject: [patch 1/9] mempool - Add page allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 15:51:13 -0800
Message-Id: <1138233074.27293.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Add another allocator to the common mempool code: a simple page allocator

This will be used by the next patch in the series to replace duplicate
mempool-backed page allocators in 2 places in the kernel.  It is also very
likely that there will be more users in the future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |    6 ++++++
 mm/mempool.c            |   17 +++++++++++++++++
 2 files changed, 23 insertions(+)

Index: linux-2.6.16-rc1+critical_mempools/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/mm/mempool.c
+++ linux-2.6.16-rc1+critical_mempools/mm/mempool.c
@@ -289,3 +289,20 @@ void mempool_free_slab(void *element, vo
 	kmem_cache_free(mem, element);
 }
 EXPORT_SYMBOL(mempool_free_slab);
+
+/*
+ * A simple mempool-backed page allocator
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data)
+{
+	int order = (int)pool_data;
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL(mempool_alloc_pages);
+
+void mempool_free_pages(void *element, void *pool_data)
+{
+	int order = (int)pool_data;
+	__free_pages(element, order);
+}
+EXPORT_SYMBOL(mempool_free_pages);
Index: linux-2.6.16-rc1+critical_mempools/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1+critical_mempools/include/linux/mempool.h
@@ -38,4 +38,10 @@ extern void mempool_free(void *element, 
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
 
+/*
+ * A mempool_alloc_t and mempool_free_t for a simple page allocator
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data);
+void mempool_free_pages(void *element, void *pool_data);
+
 #endif /* _LINUX_MEMPOOL_H */

--

