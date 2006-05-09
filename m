Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWEIVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWEIVHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWEIVHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:07:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50595 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750954AbWEIVHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:07:08 -0400
Date: Tue, 9 May 2006 14:07:23 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Christoph Lameter <clameter@sgi.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] alloc_memory_early() routines
Message-ID: <20060509210722.GD3168@w-mikek2.ibm.com>
References: <20060509053512.GA20073@monkey.ibm.com> <20060508224952.0b43d0fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508224952.0b43d0fd.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add alloc_memory_early() routines so that code needing to allocate
space during boot need not be aware of which allocator is in use.
Includes first use of such routine by the SPARSEMEM code.

I did not include support for 'large' allocations as suggested by
Dave, or corresponding free_memory_early() routines.  The only
immediate need is for NUMA/node aware allocation.  Others can be
added as the needs arise.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17-rc3-mm1/include/linux/slab.h linux-2.6.17-rc3-mm1.work3/include/linux/slab.h
--- linux-2.6.17-rc3-mm1/include/linux/slab.h	2006-05-03 22:19:15.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work3/include/linux/slab.h	2006-05-09 21:09:37.000000000 +0000
@@ -150,10 +150,12 @@ static inline void *kcalloc(size_t n, si
 
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
+extern void *alloc_memory_early(size_t size, gfp_t flags);
 
 #ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
 extern void *kmalloc_node(size_t size, gfp_t flags, int node);
+extern void *alloc_memory_early_node(size_t size, gfp_t flags, int node);
 #else
 static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int node)
 {
@@ -163,6 +165,10 @@ static inline void *kmalloc_node(size_t 
 {
 	return kmalloc(size, flags);
 }
+static inline void *alloc_memory_early_node(size_t size, gfp_t flags, int node)
+{
+	return alloc_memory_early(size, flags);
+}
 #endif
 
 extern int FASTCALL(kmem_cache_reap(int));
diff -Naupr linux-2.6.17-rc3-mm1/mm/slab.c linux-2.6.17-rc3-mm1.work3/mm/slab.c
--- linux-2.6.17-rc3-mm1/mm/slab.c	2006-05-03 22:19:16.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work3/mm/slab.c	2006-05-09 21:38:23.000000000 +0000
@@ -108,6 +108,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/bootmem.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -3266,8 +3267,24 @@ void *kmalloc_node(size_t size, gfp_t fl
 	return kmem_cache_alloc_node(cachep, flags, node);
 }
 EXPORT_SYMBOL(kmalloc_node);
+
+void * __init alloc_memory_early_node(size_t size, gfp_t flags, int node)
+{
+	if (g_cpucache_up == FULL)
+		return kmalloc_node(size, flags, node);
+	else
+		return alloc_bootmem_node(NODE_DATA(node), size);
+}
 #endif
 
+void * __init alloc_memory_early(size_t size, gfp_t flags)
+{
+	if (g_cpucache_up == FULL)
+		return kmalloc(size, flags);
+	else
+		return alloc_bootmem(size);
+}
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff -Naupr linux-2.6.17-rc3-mm1/mm/sparse.c linux-2.6.17-rc3-mm1.work3/mm/sparse.c
--- linux-2.6.17-rc3-mm1/mm/sparse.c	2006-05-03 22:19:16.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work3/mm/sparse.c	2006-05-09 20:37:51.000000000 +0000
@@ -32,11 +32,7 @@ static struct mem_section *sparse_index_
 	unsigned long array_size = SECTIONS_PER_ROOT *
 				   sizeof(struct mem_section);
 
-	if (system_state == SYSTEM_RUNNING)
-		section = kmalloc_node(array_size, GFP_KERNEL, nid);
-	else
-		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
-
+	section = alloc_memory_early_node(array_size, GFP_KERNEL, nid);
 	if (section)
 		memset(section, 0, array_size);
 
