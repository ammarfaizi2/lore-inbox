Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWA3VZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWA3VZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWA3VZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:25:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:37584 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030182AbWA3VZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:25:06 -0500
Subject: [patch 3/8] mempool - Add kmalloc allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:23:48 -0800
Message-Id: <1138656229.20704.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-add_kmalloc_allocator.patch)
Add another allocator to the common mempool code: a kmalloc/kfree allocator

This will be used by the next patch in the series to replace duplicate
mempool-backed kmalloc allocators in several places in the kernel.
It is also very likely that there will be more users in the future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |   12 ++++++++++++
 mm/mempool.c            |   17 +++++++++++++++++
 2 files changed, 29 insertions(+)

Index: linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
@@ -39,6 +39,18 @@ void *mempool_alloc_slab(gfp_t gfp_mask,
 void mempool_free_slab(void *element, void *pool_data);
 
 /*
+ * A mempool_alloc_t and mempool_free_t to kmalloc the amount of memory
+ * specified by pool_data
+ */
+void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data);
+void mempool_kfree(void *element, void *pool_data);
+static inline mempool_t *mempool_create_kmalloc_pool(int min_nr, size_t size)
+{
+	return mempool_create(min_nr, mempool_kmalloc, mempool_kfree,
+			      (void *) size);
+}
+
+/*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator that
  * allocates pages of the order specified by pool_data
  */
Index: linux-2.6.16-rc1-mm4+mempool_work/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/mm/mempool.c
+++ linux-2.6.16-rc1-mm4+mempool_work/mm/mempool.c
@@ -291,6 +291,23 @@ void mempool_free_slab(void *element, vo
 EXPORT_SYMBOL(mempool_free_slab);
 
 /*
+ * A commonly used alloc and free fn that kmalloc/kfrees the amount of memory
+ * specfied by pool_data
+ */
+void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data)
+{
+	size_t size = (size_t) pool_data;
+	return kmalloc(size, gfp_mask);
+}
+EXPORT_SYMBOL(mempool_kmalloc);
+
+void mempool_kfree(void *element, void *pool_data)
+{
+	kfree(element);
+}
+EXPORT_SYMBOL(mempool_kfree);
+
+/*
  * A simple mempool-backed page allocator that allocates pages
  * of the order specified by pool_data.
  */

--

