Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWA1AUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWA1AUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWA1AUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:20:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:54760 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422726AbWA1ATw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:19:52 -0500
Subject: [patch 3/6] Create and Use common mempool allocators
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060128001539.030809000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 27 Jan 2006 16:19:49 -0800
Message-Id: <1138407589.26088.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-add_kmalloc_allocator.patch)
From: Matthew Dobson <colpatch@us.ibm.com>
Subject: [patch 3/6] mempool - Add kmalloc allocator

Add another allocator to the common mempool code: a kmalloc/kfree allocator

This will be used by the next patch in the series to replace duplicate
mempool-backed kmalloc allocators in several places in the kernel.
It is also very likely that there will be more users in the future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |    7 +++++++
 mm/mempool.c            |   17 +++++++++++++++++
 2 files changed, 24 insertions(+)

Index: linux-2.6.16-rc1-mm3+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm3+mempool_work/include/linux/mempool.h
@@ -39,6 +39,13 @@ void *mempool_alloc_slab(gfp_t gfp_mask,
 void mempool_free_slab(void *element, void *pool_data);
 
 /*
+ * A mempool_alloc_t and mempool_free_t to kmalloc the amount of memory
+ * specified by pool_data
+ */
+void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data);
+void mempool_kfree(void *element, void *pool_data);
+
+/*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator that
  * allocates pages of the order specified by pool_data
  */
Index: linux-2.6.16-rc1-mm3+mempool_work/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/mm/mempool.c
+++ linux-2.6.16-rc1-mm3+mempool_work/mm/mempool.c
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

