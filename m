Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264894AbSJORgD>; Tue, 15 Oct 2002 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264895AbSJORgD>; Tue, 15 Oct 2002 13:36:03 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:59406 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264894AbSJORgA>; Tue, 15 Oct 2002 13:36:00 -0400
Date: Tue, 15 Oct 2002 18:41:57 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: [PATCH] Device-mapper submission 1/7
Message-ID: <20021015174156.GA27753@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hereby submitting the device-mapper patches for inclusion in 2.5.
All of the patches can be pulled using bitkeeper from:

   bk://device-mapper@device-mapper.bkbits.net/dm-submission

[mempool]
Most people use mempools in conjuction with slabs, this defines
an allocator and free function to simplify this.

--- a/include/linux/mempool.h	Tue Oct 15 18:24:31 2002
+++ b/include/linux/mempool.h	Tue Oct 15 18:24:31 2002
@@ -27,4 +27,11 @@
 extern void * mempool_alloc(mempool_t *pool, int gfp_mask);
 extern void mempool_free(void *element, mempool_t *pool);
 
+/*
+ * A mempool_alloc_t and mempool_free_t that get the memory from
+ * a slab that is passed in through pool_data.
+ */
+void *mempool_alloc_slab(int gfp_mask, void *pool_data);
+void mempool_free_slab(void *element, void *pool_data);
+
 #endif /* _LINUX_MEMPOOL_H */
--- a/mm/mempool.c	Tue Oct 15 18:24:31 2002
+++ b/mm/mempool.c	Tue Oct 15 18:24:31 2002
@@ -259,8 +259,25 @@
 	pool->free(element, pool->pool_data);
 }
 
+/*
+ * A commonly used alloc and free fn.
+ */
+void *mempool_alloc_slab(int gfp_mask, void *pool_data)
+{
+	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
+	return kmem_cache_alloc(mem, gfp_mask);
+}
+
+void mempool_free_slab(void *element, void *pool_data)
+{
+	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
+	kmem_cache_free(mem, element);
+}
+
 EXPORT_SYMBOL(mempool_create);
 EXPORT_SYMBOL(mempool_resize);
 EXPORT_SYMBOL(mempool_destroy);
 EXPORT_SYMBOL(mempool_alloc);
 EXPORT_SYMBOL(mempool_free);
+EXPORT_SYMBOL(mempool_alloc_slab);
+EXPORT_SYMBOL(mempool_free_slab);
