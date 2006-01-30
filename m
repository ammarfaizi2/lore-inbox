Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWA3VZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWA3VZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWA3VZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:25:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:42112 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030180AbWA3VZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:25:16 -0500
Subject: [patch 5/8] mempool - Add kzalloc allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:23:58 -0800
Message-Id: <1138656238.20704.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-add_kzalloc_allocator.patch)
Add another allocator to the common mempool code: a kzalloc/kfree allocator

This will be used by the next patch in the series to replace a mempool-backed
kzalloc allocator. It is also very likely that there will be more users in the
future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |   10 ++++++++--
 mm/mempool.c            |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
@@ -39,16 +39,22 @@ void *mempool_alloc_slab(gfp_t gfp_mask,
 void mempool_free_slab(void *element, void *pool_data);
 
 /*
- * A mempool_alloc_t and mempool_free_t to kmalloc the amount of memory
- * specified by pool_data
+ * 2 mempool_alloc_t's and a mempool_free_t to kmalloc/kzalloc and kfree
+ * the amount of memory specified by pool_data
  */
 void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data);
+void *mempool_kzalloc(gfp_t gfp_mask, void *pool_data);
 void mempool_kfree(void *element, void *pool_data);
 static inline mempool_t *mempool_create_kmalloc_pool(int min_nr, size_t size)
 {
 	return mempool_create(min_nr, mempool_kmalloc, mempool_kfree,
 			      (void *) size);
 }
+static inline mempool_t *mempool_create_kzalloc_pool(int min_nr, size_t size)
+{
+	return mempool_create(min_nr, mempool_kzalloc, mempool_kfree,
+			      (void *) size);
+}
 
 /*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator that
Index: linux-2.6.16-rc1-mm4+mempool_work/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/mm/mempool.c
+++ linux-2.6.16-rc1-mm4+mempool_work/mm/mempool.c
@@ -301,6 +301,13 @@ void *mempool_kmalloc(gfp_t gfp_mask, vo
 }
 EXPORT_SYMBOL(mempool_kmalloc);
 
+void *mempool_kzalloc(gfp_t gfp_mask, void *pool_data)
+{
+	size_t size = (size_t) pool_data;
+	return kzalloc(size, gfp_mask);
+}
+EXPORT_SYMBOL(mempool_kzalloc);
+
 void mempool_kfree(void *element, void *pool_data)
 {
 	kfree(element);

--

