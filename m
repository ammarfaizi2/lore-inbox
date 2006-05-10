Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWEJUzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWEJUzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWEJUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:55:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31915 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964895AbWEJUzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:55:36 -0400
Date: Wed, 10 May 2006 13:55:43 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Christoph Lameter <clameter@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] add slab_is_available() routine for boot code
Message-ID: <20060510205543.GI3198@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slab_is_available() indicates slab based allocators are available
for use.  SPARSEMEM code needs to know this as it can be called
at various times during the boot process.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17-rc3-mm1/include/linux/slab.h linux-2.6.17-rc3-mm1.work3/include/linux/slab.h
--- linux-2.6.17-rc3-mm1/include/linux/slab.h	2006-05-03 22:19:15.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work3/include/linux/slab.h	2006-05-10 19:15:20.000000000 +0000
@@ -150,6 +150,7 @@ static inline void *kcalloc(size_t n, si
 
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
+extern int slab_is_available(void);
 
 #ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
diff -Naupr linux-2.6.17-rc3-mm1/mm/slab.c linux-2.6.17-rc3-mm1.work3/mm/slab.c
--- linux-2.6.17-rc3-mm1/mm/slab.c	2006-05-03 22:19:16.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work3/mm/slab.c	2006-05-10 21:43:08.000000000 +0000
@@ -694,6 +694,14 @@ static enum {
 	FULL
 } g_cpucache_up;
 
+/*
+ * used by boot code to determine if it can use slab based allocator
+ */
+int slab_is_available(void)
+{
+	return g_cpucache_up == FULL;
+}
+
 static DEFINE_PER_CPU(struct work_struct, reap_work);
 
 static void free_block(struct kmem_cache *cachep, void **objpp, int len,
diff -Naupr linux-2.6.17-rc3-mm1/mm/sparse.c linux-2.6.17-rc3-mm1.work3/mm/sparse.c
--- linux-2.6.17-rc3-mm1/mm/sparse.c	2006-05-03 22:19:16.000000000 +0000
+++ linux-2.6.17-rc3-mm1.work3/mm/sparse.c	2006-05-10 19:15:56.000000000 +0000
@@ -32,7 +32,7 @@ static struct mem_section *sparse_index_
 	unsigned long array_size = SECTIONS_PER_ROOT *
 				   sizeof(struct mem_section);
 
-	if (system_state == SYSTEM_RUNNING)
+	if (slab_is_available())
 		section = kmalloc_node(array_size, GFP_KERNEL, nid);
 	else
 		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
