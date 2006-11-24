Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934561AbWKXKo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934561AbWKXKo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934563AbWKXKo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:44:28 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:43158 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S934561AbWKXKo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:44:26 -0500
Date: Fri, 24 Nov 2006 10:44:23 +0000
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
Message-ID: <20061124104422.GA23426@skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie> <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie> <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie> <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie> <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/06 09:11), Linus Torvalds didst pronounce:
> 
> 
> On Thu, 23 Nov 2006, Mel Gorman wrote:
> >
> > There are a suprising number of GFP_HIGHUSER users. I've included an
> > untested patch below to give an idea of what the reworked patch would
> > look like.
> 
> Thanks. Seeing the patch actually was useful, because I think this isa 
> good idea quite regardless of anything else: it adds a certain amount of 
> "inherent documentation" when you see a line like
> 
> 	page = alloc_page(GFP_HIGHUNMOVABLE);
> 
> because it makes it very obvious that something is going on.
> 
> At the same time, I do get the feelign that maybe we should simply go the 
> other way: talk about allocating MOVABLE pages instead of talking about 
> allocating pages that are NOT movable.
> 

I tend to agree. If GFP_HIGHUSER was the movable set of flags, a number
of out-of-tree drivers and new drivers would continue to use it instead of
GFP_HIGHUNMOVABLE. It would need to be periodically audited.

> Because usually it's really that way you think about it: when you allocate 
> a _movable_ page, you need to add support for moving it some way (ie you 
> need to put it on the proper page-cache lists etc), while a page that you 
> don't think about is generally _not_ movable.
> 

Good point.

> So: I think this is the right direction, but I would actually prefer to 
> see
> 
> 	page = alloc_page(GFP_[HIGH_]MOVABLE);
> 
> instead, and then just teach the routines that create movable pages 
> (whether they are movable because they are in the page cache, or for some 
> other reason) to use that flag instead of GFP_[HIGH]USER.
> 
> And the assumption would be that if it's MOVABLE, then it's obviously a 
> USER allocation (it it can fail much more eagerly - that's really what the 
> whole USER bit ends up meaning internally).
> 

This is what the (compile-tested-only on x86) patch looks like for
GFP_HIGH_MOVABLE. The remaining in-tree GFP_HIGHUSER users are infiniband,
kvm, ncpfs, nfs, pipes (possible the most frequent user), m68knommu, hugepages
and kexec.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/compat.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/fs/compat.c
--- linux-2.6.19-rc5-mm2-clean/fs/compat.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/fs/compat.c	2006-11-24 10:17:48.000000000 +0000
@@ -1419,7 +1419,7 @@ static int compat_copy_strings(int argc,
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGH_MOVABLE);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/exec.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/fs/exec.c
--- linux-2.6.19-rc5-mm2-clean/fs/exec.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/fs/exec.c	2006-11-24 10:17:48.000000000 +0000
@@ -239,7 +239,7 @@ static int copy_strings(int argc, char _
 			page = bprm->page[i];
 			new = 0;
 			if (!page) {
-				page = alloc_page(GFP_HIGHUSER);
+				page = alloc_page(GFP_HIGH_MOVABLE);
 				bprm->page[i] = page;
 				if (!page) {
 					ret = -ENOMEM;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/fs/inode.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/fs/inode.c
--- linux-2.6.19-rc5-mm2-clean/fs/inode.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/fs/inode.c	2006-11-24 10:17:48.000000000 +0000
@@ -146,7 +146,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_HIGH_MOVABLE);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-alpha/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-alpha/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-alpha/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-alpha/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -17,7 +17,7 @@
 extern void clear_page(void *page);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vmaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGH_MOVABLE | __GFP_ZERO, vma, vmaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 extern void copy_page(void * _to, void * _from);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-cris/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-cris/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-cris/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-cris/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -20,7 +20,7 @@
 #define clear_user_page(page, vaddr, pg)    clear_page(page)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGH_MOVABLE | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-h8300/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-h8300/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-h8300/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-h8300/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -22,7 +22,7 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGH_MOVABLE | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-i386/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-i386/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-i386/page.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-i386/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -35,7 +35,7 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr)	alloc_page_vma(GFP_HIGH_MOVABLE|__GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-ia64/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-ia64/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-ia64/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-ia64/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -89,7 +89,7 @@ do {						\
 
 #define alloc_zeroed_user_highpage(vma, vaddr) \
 ({						\
-	struct page *page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr); \
+	struct page *page = alloc_page_vma(GFP_HIGH_MOVABLE | __GFP_ZERO, vma, vaddr); 		\
 	if (page)				\
  		flush_dcache_page(page);	\
 	page;					\
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-m32r/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-m32r/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-m32r/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-m32r/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -16,7 +16,7 @@ extern void copy_page(void *to, void *fr
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGH_MOVABLE | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-s390/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-s390/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-s390/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-s390/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -64,7 +64,7 @@ static inline void copy_page(void *to, v
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGH_MOVABLE | __GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/asm-x86_64/page.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-x86_64/page.h
--- linux-2.6.19-rc5-mm2-clean/include/asm-x86_64/page.h	2006-11-08 02:24:20.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/asm-x86_64/page.h	2006-11-24 10:17:48.000000000 +0000
@@ -51,7 +51,7 @@ void copy_page(void *, void *);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGH_MOVABLE|__GFP_ZERO, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 /*
  * These are used to make use of C type-checking..
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/gfp.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/linux/gfp.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/gfp.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/linux/gfp.h	2006-11-24 10:32:26.000000000 +0000
@@ -30,6 +30,9 @@ struct vm_area_struct;
  * cannot handle allocation failures.
  *
  * __GFP_NORETRY: The VM implementation must not retry indefinitely.
+ *
+ * __GFP_MOVABLE: Flag that this page will be movable by the page migration
+ * mechanism
  */
 #define __GFP_WAIT	((__force gfp_t)0x10u)	/* Can wait and reschedule? */
 #define __GFP_HIGH	((__force gfp_t)0x20u)	/* Should access emergency pools? */
@@ -46,6 +49,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
+#define __GFP_MOVABLE	((__force gfp_t)0x80000u) /* Page is movable */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -54,7 +58,8 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
+			__GFP_MOVABLE)
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
@@ -66,6 +71,9 @@ struct vm_area_struct;
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
 			 __GFP_HIGHMEM)
+#define GFP_HIGH_MOVABLE	(__GFP_WAIT | __GFP_IO | __GFP_FS | \
+				 __GFP_HARDWALL | __GFP_HIGHMEM | \
+				 __GFP_MOVABLE)
 
 #ifdef CONFIG_NUMA
 #define GFP_THISNODE	(__GFP_THISNODE | __GFP_NOWARN | __GFP_NORETRY)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/include/linux/highmem.h linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/linux/highmem.h
--- linux-2.6.19-rc5-mm2-clean/include/linux/highmem.h	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/include/linux/highmem.h	2006-11-24 10:17:48.000000000 +0000
@@ -65,7 +65,7 @@ static inline void clear_user_highpage(s
 static inline struct page *
 alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/memory.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/memory.c
--- linux-2.6.19-rc5-mm2-clean/mm/memory.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/memory.c	2006-11-24 10:17:48.000000000 +0000
@@ -1564,7 +1564,7 @@ gotten:
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, address);
 		if (!new_page)
 			goto oom;
 		cow_user_page(new_page, old_page, address);
@@ -2188,7 +2188,7 @@ retry:
 
 			if (unlikely(anon_vma_prepare(vma)))
 				goto oom;
-			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, address);
 			if (!page)
 				goto oom;
 			copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/mempolicy.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/mempolicy.c
--- linux-2.6.19-rc5-mm2-clean/mm/mempolicy.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/mempolicy.c	2006-11-24 10:33:04.000000000 +0000
@@ -598,7 +598,7 @@ static void migrate_page_add(struct page
 
 static struct page *new_node_page(struct page *page, unsigned long node, int **x)
 {
-	return alloc_pages_node(node, GFP_HIGHUSER, 0);
+	return alloc_pages_node(node, GFP_HIGH_MOVABLE, 0);
 }
 
 /*
@@ -714,7 +714,7 @@ static struct page *new_vma_page(struct 
 {
 	struct vm_area_struct *vma = (struct vm_area_struct *)private;
 
-	return alloc_page_vma(GFP_HIGHUSER, vma, page_address_in_vma(page, vma));
+	return alloc_page_vma(GFP_HIGH_MOVABLE, vma, page_address_in_vma(page, vma));
 }
 #else
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/migrate.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/migrate.c
--- linux-2.6.19-rc5-mm2-clean/mm/migrate.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/migrate.c	2006-11-24 10:17:48.000000000 +0000
@@ -748,7 +748,7 @@ static struct page *new_page_node(struct
 
 	*result = &pm->status;
 
-	return alloc_pages_node(pm->node, GFP_HIGHUSER | GFP_THISNODE, 0);
+	return alloc_pages_node(pm->node, GFP_HIGH_MOVABLE | GFP_THISNODE, 0);
 }
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/swap_prefetch.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/swap_prefetch.c
--- linux-2.6.19-rc5-mm2-clean/mm/swap_prefetch.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/swap_prefetch.c	2006-11-24 10:17:48.000000000 +0000
@@ -204,7 +204,7 @@ static enum trickle_return trickle_swap_
 	 * Get a new page to read from swap. We have already checked the
 	 * watermarks so __alloc_pages will not call on reclaim.
 	 */
-	page = alloc_pages_node(node, GFP_HIGHUSER & ~__GFP_WAIT, 0);
+	page = alloc_pages_node(node, GFP_HIGH_MOVABLE & ~__GFP_WAIT, 0);
 	if (unlikely(!page)) {
 		ret = TRICKLE_DELAY;
 		goto out;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/swap_state.c linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/swap_state.c
--- linux-2.6.19-rc5-mm2-clean/mm/swap_state.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-mark_HIGH_MOVABLE/mm/swap_state.c	2006-11-24 10:17:48.000000000 +0000
@@ -343,7 +343,7 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
