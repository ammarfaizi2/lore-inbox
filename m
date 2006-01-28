Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWA1AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWA1AVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWA1AUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:20:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:14011 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422728AbWA1AUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:20:02 -0500
Subject: [patch 5/6] Create and Use common mempool allocators
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060128001539.030809000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 27 Jan 2006 16:19:58 -0800
Message-Id: <1138407599.26088.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-add_kzalloc_allocator.patch)
From: Matthew Dobson <colpatch@us.ibm.com>
Subject: [patch 5/6] mempool - Add kzalloc allocator

Add another allocator to the common mempool code: a kzalloc/kfree allocator

This will be used by the next patch in the series to replace a mempool-backed
kzalloc allocator. It is also very likely that there will be more users in the
future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |    5 +++--
 mm/mempool.c            |    7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc1-mm3+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm3+mempool_work/include/linux/mempool.h
@@ -39,10 +39,11 @@ void *mempool_alloc_slab(gfp_t gfp_mask,
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
 
 /*
Index: linux-2.6.16-rc1-mm3+mempool_work/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1-mm3+mempool_work.orig/mm/mempool.c
+++ linux-2.6.16-rc1-mm3+mempool_work/mm/mempool.c
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

