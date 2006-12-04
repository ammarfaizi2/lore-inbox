Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936877AbWLDOHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936877AbWLDOHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936878AbWLDOHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:07:51 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:17106 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S936877AbWLDOHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:07:50 -0500
Date: Mon, 4 Dec 2006 14:07:47 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that may be migrated
Message-ID: <20061204140747.GA21662@skynet.ie>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org> <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061201110103.08d0cf3d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/12/06 11:01), Andrew Morton didst pronounce:
> On Fri, 1 Dec 2006 09:54:11 +0000 (GMT)
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
> > >> @@ -65,7 +65,7 @@ static inline void clear_user_highpage(s
> > >>  static inline struct page *
> > >>  alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
> > >>  {
> > >> -	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
> > >> +	struct page *page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, vaddr);
> > >>
> > >>  	if (page)
> > >>  		clear_user_highpage(page, vaddr);
> > >
> > > But this change is presumptuous.  alloc_zeroed_user_highpage() doesn't know
> > > that its caller is going to use the page for moveable purposes.  (Ditto lots
> > > of other places in this patch).
> > >
> > 
> > according to grep -r, alloc_zeroed_user_highpage() is only used in two 
> > places, do_wp_page() (when write faulting the zero page)[1] and 
> > do_anonymous_page() (when mapping the zero page for the first time and 
> > writing). In these cases, they are known to be movable. What am I missing?
> 
> We shouldn't implement a function which "knows" how its callers are using
> it in this manner.
> 

I see.

> You've gone and changed alloc_zeroed_user_highpage() into alloc_user_zeroed_highpage_which_you_must_use_in_an_application_where_it_is_movable().
> Now, if we want to put a big fat comment over these functions saying that the caller
> must honour the promise we've made on the caller's behalf then OK(ish).  But it'd
> be better (albeit perhaps bloaty) to require the caller to pass in the gfp-flags.

It is a bit more bloaty all right but it makes more sense so I've made
some changes to the patch and posted it below.  There are three important
differences from the first patch. 

o copy_strings() and variants are no longer setting the flag as the pages
  are not obviously movable when I took a much closer look.

o The arch function alloc_zeroed_user_highpage() is now called
  __alloc_zeroed_user_highpage and takes flags related to
  movability that will be applied.  alloc_zeroed_user_highpage()
  calls __alloc_zeroed_user_highpage() with no additional flags to
  preserve existing behavior of the API for out-of-tree users and
  alloc_zeroed_user_highpage_movable() sets the __GFP_MOVABLE flag.

o new_inode() documents that it uses GFP_HIGH_MOVABLE and callers are expected
  to call mapping_set_gfp_mask() if that is not suitable.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/fs/inode.c linux-2.6.19-rc6-mm2-mark_highmovable/fs/inode.c
--- linux-2.6.19-rc6-mm2-clean/fs/inode.c	2006-11-29 10:31:09.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/fs/inode.c	2006-12-04 11:44:24.000000000 +0000
@@ -146,7 +146,7 @@ static struct inode *alloc_inode(struct 
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
-		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
+		mapping_set_gfp_mask(mapping, GFP_HIGH_MOVABLE);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
 
@@ -527,7 +527,13 @@ repeat:
  *	new_inode 	- obtain an inode
  *	@sb: superblock
  *
- *	Allocates a new inode for given superblock.
+ *	Allocates a new inode for given superblock. The gfp_mask used for
+ *	allocations related to inode->i_mapping is GFP_HIGH_MOVABLE. If
+ *	HIGHMEM pages are unsuitable or it is known that pages allocated
+ *	for the page cache are not reclaimable on demand,
+ *	mapping_set_gfp_mask() must be called with suitable flags after
+ *	new_inode()
+ *
  */
 struct inode *new_inode(struct super_block *sb)
 {
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/fs/ramfs/inode.c linux-2.6.19-rc6-mm2-mark_highmovable/fs/ramfs/inode.c
--- linux-2.6.19-rc6-mm2-clean/fs/ramfs/inode.c	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/fs/ramfs/inode.c	2006-12-04 10:18:33.000000000 +0000
@@ -61,6 +61,7 @@ struct inode *ramfs_get_inode(struct sup
 		inode->i_blocks = 0;
 		inode->i_mapping->a_ops = &ramfs_aops;
 		inode->i_mapping->backing_dev_info = &ramfs_backing_dev_info;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		switch (mode & S_IFMT) {
 		default:
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-alpha/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-alpha/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-alpha/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-alpha/page.h	2006-12-04 11:15:23.000000000 +0000
@@ -17,7 +17,9 @@
 extern void clear_page(void *page);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vmaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vmaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 extern void copy_page(void * _to, void * _from);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-cris/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-cris/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-cris/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-cris/page.h	2006-12-04 11:16:59.000000000 +0000
@@ -20,7 +20,9 @@
 #define clear_user_page(page, vaddr, pg)    clear_page(page)
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-h8300/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-h8300/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-h8300/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-h8300/page.h	2006-12-04 11:17:29.000000000 +0000
@@ -22,7 +22,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-i386/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-i386/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-i386/page.h	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-i386/page.h	2006-12-04 11:15:31.000000000 +0000
@@ -35,7 +35,9 @@
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-ia64/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-ia64/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-ia64/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-ia64/page.h	2006-12-04 11:18:45.000000000 +0000
@@ -87,9 +87,11 @@ do {						\
 } while (0)
 
 
-#define alloc_zeroed_user_highpage(vma, vaddr) \
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) \
 ({						\
-	struct page *page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr); \
+	struct page *page = alloc_page_vma(	\
+		set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+		vma, vaddr);			\
 	if (page)				\
  		flush_dcache_page(page);	\
 	page;					\
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-m32r/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-m32r/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-m32r/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-m32r/page.h	2006-12-04 11:19:05.000000000 +0000
@@ -16,7 +16,9 @@ extern void copy_page(void *to, void *fr
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-s390/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-s390/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-s390/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-s390/page.h	2006-12-04 11:19:35.000000000 +0000
@@ -64,7 +64,9 @@ static inline void copy_page(void *to, v
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/asm-x86_64/page.h linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-x86_64/page.h
--- linux-2.6.19-rc6-mm2-clean/include/asm-x86_64/page.h	2006-11-16 04:03:40.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/asm-x86_64/page.h	2006-12-04 11:19:58.000000000 +0000
@@ -51,7 +51,9 @@ void copy_page(void *, void *);
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define alloc_zeroed_user_highpage(vma, vaddr) alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO, vma, vaddr)
+#define __alloc_zeroed_user_highpage(gfp_movableflags, vma, vaddr) alloc_page_vma(\
+	set_movable_flags(GFP_HIGHUSER | __GFP_ZERO, gfp_movableflags), \
+	vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 /*
  * These are used to make use of C type-checking..
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/linux/gfp.h linux-2.6.19-rc6-mm2-mark_highmovable/include/linux/gfp.h
--- linux-2.6.19-rc6-mm2-clean/include/linux/gfp.h	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/linux/gfp.h	2006-12-04 11:04:36.000000000 +0000
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
@@ -54,7 +58,17 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|\
+			__GFP_MOVABLE)
+
+/* Mask of GFP flags related to migration or reclaimation */
+#define GFP_MOVABLE_FLAGS (__GFP_MOVABLE)
+
+static inline gfp_t set_movable_flags(gfp_t gfp, gfp_t migrate_flags)
+{
+	return (gfp & ~(GFP_MOVABLE_FLAGS)) |
+		(migrate_flags & GFP_MOVABLE_FLAGS);
+}
 
 /* This equals 0, but use constants in case they ever change */
 #define GFP_NOWAIT	(GFP_ATOMIC & ~__GFP_HIGH)
@@ -66,6 +80,9 @@ struct vm_area_struct;
 #define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
 #define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
 			 __GFP_HIGHMEM)
+#define GFP_HIGH_MOVABLE	(__GFP_WAIT | __GFP_IO | __GFP_FS | \
+				 __GFP_HARDWALL | __GFP_HIGHMEM | \
+				 __GFP_MOVABLE)
 
 #ifdef CONFIG_NUMA
 #define GFP_THISNODE	(__GFP_THISNODE | __GFP_NOWARN | __GFP_NORETRY)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/include/linux/highmem.h linux-2.6.19-rc6-mm2-mark_highmovable/include/linux/highmem.h
--- linux-2.6.19-rc6-mm2-clean/include/linux/highmem.h	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/include/linux/highmem.h	2006-12-04 11:10:35.000000000 +0000
@@ -62,10 +62,28 @@ static inline void clear_user_highpage(s
 }
 
 #ifndef __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+/**
+ * __alloc_zeroed_user_highpage - Allocate a zeroed HIGHMEM page for a VMA with caller-specified movable GFP flags
+ * @gfp_movableflags: The GFP flags related to the pages future ability to move like __GFP_MOVABLE
+ * @vma: The VMA the page is to be allocated for
+ * @vaddr: The virtual address the page will be inserted into
+ *
+ * This function will allocate a page for a VMA but the caller is expected
+ * to specify via gfp_movableflags whether the page will be movable in the
+ * future or not
+ *
+ * An architecture may override this function by defining
+ * __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE and providing their own
+ * implementation.
+ */
 static inline struct page *
-alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
+__alloc_zeroed_user_highpage(gfp_t gfp_movableflags,
+			struct vm_area_struct *vma,
+			unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER, vma, vaddr);
+	struct page *page = alloc_page_vma(
+			set_movable_flags(GFP_HIGHUSER, gfp_movableflags),
+			vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
@@ -74,6 +92,36 @@ alloc_zeroed_user_highpage(struct vm_are
 }
 #endif
 
+/**
+ * alloc_zeroed_user_highpage - Allocate a zeroed HIGHMEM page for a VMA
+ * @vma: The VMA the page is to be allocated for
+ * @vaddr: The virtual address the page will be inserted into
+ *
+ * This function will allocate a page for a VMA that the caller knows will
+ * not be able to move in the future using move_pages() or reclaim. If it
+ * is known that the page can move, use alloc_zeroed_user_highpage_movable
+ */
+static inline struct page *
+alloc_zeroed_user_highpage(struct vm_area_struct *vma, unsigned long vaddr)
+{
+	return __alloc_zeroed_user_highpage(0, vma, vaddr);
+}
+
+/**
+ * alloc_zeroed_user_highpage_movable - Allocate a zeroed HIGHMEM page for a VMA that the caller knows can move
+ * @vma: The VMA the page is to be allocated for
+ * @vaddr: The virtual address the page will be inserted into
+ *
+ * This function will allocate a page for a VMA that the caller knows will
+ * be able to migrate in the future using move_pages() or reclaimed
+ */
+static inline struct page *
+alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
+					unsigned long vaddr)
+{
+	return __alloc_zeroed_user_highpage(__GFP_MOVABLE, vma, vaddr);
+}
+
 static inline void clear_highpage(struct page *page)
 {
 	void *kaddr = kmap_atomic(page, KM_USER0);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/mm/memory.c linux-2.6.19-rc6-mm2-mark_highmovable/mm/memory.c
--- linux-2.6.19-rc6-mm2-clean/mm/memory.c	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/mm/memory.c	2006-12-04 10:57:13.000000000 +0000
@@ -1560,11 +1560,11 @@ gotten:
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 	if (old_page == ZERO_PAGE(address)) {
-		new_page = alloc_zeroed_user_highpage(vma, address);
+		new_page = alloc_zeroed_user_highpage_movable(vma, address);
 		if (!new_page)
 			goto oom;
 	} else {
-		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		new_page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, address);
 		if (!new_page)
 			goto oom;
 		cow_user_page(new_page, old_page, address);
@@ -2085,7 +2085,7 @@ static int do_anonymous_page(struct mm_s
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto oom;
-		page = alloc_zeroed_user_highpage(vma, address);
+		page = alloc_zeroed_user_highpage_movable(vma, address);
 		if (!page)
 			goto oom;
 
@@ -2188,7 +2188,7 @@ retry:
 
 			if (unlikely(anon_vma_prepare(vma)))
 				goto oom;
-			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+			page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, address);
 			if (!page)
 				goto oom;
 			copy_user_highpage(page, new_page, address);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/mm/mempolicy.c linux-2.6.19-rc6-mm2-mark_highmovable/mm/mempolicy.c
--- linux-2.6.19-rc6-mm2-clean/mm/mempolicy.c	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/mm/mempolicy.c	2006-12-04 10:18:33.000000000 +0000
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
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/mm/migrate.c linux-2.6.19-rc6-mm2-mark_highmovable/mm/migrate.c
--- linux-2.6.19-rc6-mm2-clean/mm/migrate.c	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/mm/migrate.c	2006-12-04 10:18:33.000000000 +0000
@@ -748,7 +748,7 @@ static struct page *new_page_node(struct
 
 	*result = &pm->status;
 
-	return alloc_pages_node(pm->node, GFP_HIGHUSER | GFP_THISNODE, 0);
+	return alloc_pages_node(pm->node, GFP_HIGH_MOVABLE | GFP_THISNODE, 0);
 }
 
 /*
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/mm/shmem.c linux-2.6.19-rc6-mm2-mark_highmovable/mm/shmem.c
--- linux-2.6.19-rc6-mm2-clean/mm/shmem.c	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/mm/shmem.c	2006-12-04 10:18:33.000000000 +0000
@@ -93,8 +93,11 @@ static inline struct page *shmem_dir_all
 	 * The above definition of ENTRIES_PER_PAGE, and the use of
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
+	 *
+	 * __GFP_MOVABLE is masked out as swap vectors cannot move
 	 */
-	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+	return alloc_pages((gfp_mask & ~__GFP_MOVABLE) | __GFP_ZERO,
+				PAGE_CACHE_SHIFT-PAGE_SHIFT);
 }
 
 static inline void shmem_dir_free(struct page *page)
@@ -372,7 +375,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 		}
 
 		spin_unlock(&info->lock);
-		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO);
+		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
 		if (page)
 			set_page_private(page, 0);
 		spin_lock(&info->lock);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/mm/swap_prefetch.c linux-2.6.19-rc6-mm2-mark_highmovable/mm/swap_prefetch.c
--- linux-2.6.19-rc6-mm2-clean/mm/swap_prefetch.c	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/mm/swap_prefetch.c	2006-12-04 10:18:33.000000000 +0000
@@ -204,7 +204,7 @@ static enum trickle_return trickle_swap_
 	 * Get a new page to read from swap. We have already checked the
 	 * watermarks so __alloc_pages will not call on reclaim.
 	 */
-	page = alloc_pages_node(node, GFP_HIGHUSER & ~__GFP_WAIT, 0);
+	page = alloc_pages_node(node, GFP_HIGH_MOVABLE & ~__GFP_WAIT, 0);
 	if (unlikely(!page)) {
 		ret = TRICKLE_DELAY;
 		goto out;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm2-clean/mm/swap_state.c linux-2.6.19-rc6-mm2-mark_highmovable/mm/swap_state.c
--- linux-2.6.19-rc6-mm2-clean/mm/swap_state.c	2006-11-29 10:31:10.000000000 +0000
+++ linux-2.6.19-rc6-mm2-mark_highmovable/mm/swap_state.c	2006-12-04 10:18:33.000000000 +0000
@@ -343,7 +343,7 @@ struct page *read_swap_cache_async(swp_e
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			new_page = alloc_page_vma(GFP_HIGH_MOVABLE, vma, addr);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
