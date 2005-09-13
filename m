Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVIMQSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVIMQSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVIMQSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:18:15 -0400
Received: from serv01.siteground.net ([70.85.91.68]:58301 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964845AbVIMQSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:18:13 -0400
Date: Tue, 13 Sep 2005 09:18:06 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 10/11] mm: Reimplementation of dynamic per-cpu allocator -- allow_early_mapvmarea
Message-ID: <20050913161806.GL3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides for early calls to map_vm_area.  Currently, map_vm_area
cannot be called early during the boot process since map_vm_area depends on
kmalloc for the vm_struct objects.  This patch is a bad hack to let
map_vm_area work early, but just for a few calls so that the dynamic per-cpu
subsystem can allocate a block and satisfy some early requests.  This is
primarily to enable slab code use alloc_percpu for slab head arrays.  This
patch might not be elegant, but solves the chicken and egg problem in using
alloc_percpu for slab.

Signed-off-by: Ravikiran Thirumalai <kiran.th@gmail.com>

Index: alloc_percpu-2.6.13-rc6/include/linux/slab.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/slab.h	2005-08-14 21:47:56.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/include/linux/slab.h	2005-08-15 17:29:41.000000000 -0700
@@ -76,6 +76,8 @@
 extern struct cache_sizes malloc_sizes[];
 extern void *__kmalloc(size_t, unsigned int __nocast);
 
+#define SLAB_READY ({malloc_sizes[0].cs_cachep != NULL;})
+
 static inline void *kmalloc(size_t size, unsigned int __nocast flags)
 {
 	if (__builtin_constant_p(size)) {
Index: alloc_percpu-2.6.13-rc6/include/linux/vmalloc.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/vmalloc.h	2005-08-15 17:28:42.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/include/linux/vmalloc.h	2005-08-15 17:29:41.000000000 -0700
@@ -8,6 +8,7 @@
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
+#define VM_EARLY	0x00000008	/* indicates static vm_struct */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 struct vm_struct {
Index: alloc_percpu-2.6.13-rc6/mm/vmalloc.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/mm/vmalloc.c	2005-08-15 17:28:42.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/mm/vmalloc.c	2005-08-15 17:35:29.000000000 -0700
@@ -160,6 +160,15 @@
 
 #define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
 
+/* 
+ * Statically define a few vm_structs so that early per-cpu allocator code
+ * can get vm_areas even before slab is up. NR_EARLY_VMAREAS should remain
+ * in single digits
+ */
+#define NR_EARLY_VMAREAS (1)
+static struct vm_struct early_vmareas[NR_EARLY_VMAREAS];
+static int early_vmareas_idx = 0;
+
 struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 				unsigned long start, unsigned long end,
 				unsigned int gfp_flags)
@@ -168,6 +177,9 @@
 	unsigned long align = 1;
 	unsigned long addr;
 
+	if (unlikely(!size))
+		return NULL;
+
 	if (flags & VM_IOREMAP) {
 		int bit = fls(size);
 
@@ -184,10 +196,16 @@
 	area = kmalloc(sizeof(*area), gfp_flags);
 	if (unlikely(!area))
 		return NULL;
-
-	if (unlikely(!size)) {
-		kfree (area);
-		return NULL;
+ 	if (likely(SLAB_READY)) {
+ 		area = kmalloc(sizeof(*area), GFP_KERNEL);
+ 		if (unlikely(!area))
+ 			return NULL;
+ 	} else {
+ 		if (early_vmareas_idx < NR_EARLY_VMAREAS) {
+ 			area = &early_vmareas[early_vmareas_idx++];
+ 			flags |= VM_EARLY;
+ 		} else
+ 			return NULL;
 	}
 
 	/*
@@ -228,7 +246,8 @@
 
 out:
 	write_unlock(&vmlist_lock);
-	kfree(area);
+	if (likely(!(flags & VM_EARLY)))
+		kfree(area);
 	if (printk_ratelimit())
 		printk(KERN_WARNING "allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.\n");
 	return NULL;
@@ -326,7 +345,8 @@
 			kfree(area->pages);
 	}
 
-	kfree(area);
+	if (likely(!(area->flags & VM_EARLY)))
+		kfree(area);
 	return;
 }
 
@@ -415,7 +435,8 @@
 	area->pages = pages;
 	if (!area->pages) {
 		remove_vm_area(area->addr);
-		kfree(area);
+		if (likely(!(area->flags & VM_EARLY)))
+			kfree(area);
 		return NULL;
 	}
 	memset(area->pages, 0, array_size);
