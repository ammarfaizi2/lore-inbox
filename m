Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbSLDMFe>; Wed, 4 Dec 2002 07:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLDMFe>; Wed, 4 Dec 2002 07:05:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8187 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266434AbSLDMFd>;
	Wed, 4 Dec 2002 07:05:33 -0500
Date: Wed, 4 Dec 2002 17:42:10 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Rusty Russell <rusty@rustcorp.com.au>,
       dipankar@in.ibm.com
Subject: [patch] kmalloc_percpu  -- 1 of 2
Message-ID: <20021204174209.A17375@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a 2.5.50 version of kmalloc_percpu originally submitted by Dipankar.  
This one incorporates Rusty's suggestions to rearrange code and sync 
up with its static counterpart. This version needs exposure of malloc_sizes 
in order to move the interfaces to percpu.c from slab.c (kmalloc_percpu and
kfree_percpu donot have anything to do with the slab allocator itself).
First of the two patches is to expose the malloc_sizes and the second
one is the actual allocator.  I'll follow this up with patchsets to enable 
networking mibs use kmalloc_percpu. We'll have to use kmalloc_percpu
for mibs since DEFINE_PER_CPU won't work with modules (and ipv6 stuff
can be compiled in as modules)

Following is the 1 of 2 patches.

D: Name: slabchange-2.5.50-1.patch
D: Description: Exposes malloc_sizes for kmalloc_percpu
D: Author: Ravikiran Thirumalai


 include/linux/slab.h |   13 +++++++++++++
 mm/slab.c            |    9 +--------
 2 files changed, 14 insertions(+), 8 deletions(-)


diff -ruN linux-2.5.50/include/linux/slab.h kmalloc_percpu-2.5.50/include/linux/slab.h
--- linux-2.5.50/include/linux/slab.h	Thu Nov 28 04:06:23 2002
+++ kmalloc_percpu-2.5.50/include/linux/slab.h	Sun Dec  1 11:13:49 2002
@@ -75,6 +75,19 @@
 extern kmem_cache_t	*sigact_cachep;
 extern kmem_cache_t	*bio_cachep;
 
+/* 
+ * Size description struct for general caches. 
+ * This had to be exposed for kmalloc_percpu.
+ */
+
+struct cache_sizes {
+	size_t           cs_size;
+	kmem_cache_t    *cs_cachep;
+	kmem_cache_t    *cs_dmacachep;
+};
+
+extern struct cache_sizes malloc_sizes[];
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
diff -ruN linux-2.5.50/mm/slab.c kmalloc_percpu-2.5.50/mm/slab.c
--- linux-2.5.50/mm/slab.c	Thu Nov 28 04:06:17 2002
+++ kmalloc_percpu-2.5.50/mm/slab.c	Sun Dec  1 11:13:49 2002
@@ -369,15 +369,8 @@
 #define	SET_PAGE_SLAB(pg,x)   ((pg)->list.prev = (struct list_head *)(x))
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->list.prev)
 
-/* Size description struct for general caches. */
-struct cache_sizes {
-	size_t		 cs_size;
-	kmem_cache_t	*cs_cachep;
-	kmem_cache_t	*cs_dmacachep;
-};
-
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
-static struct cache_sizes malloc_sizes[] = {
+struct cache_sizes malloc_sizes[] = {
 #if PAGE_SIZE == 4096
 	{    32,	NULL, NULL},
 #endif
