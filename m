Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSKDNoB>; Mon, 4 Nov 2002 08:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbSKDNoB>; Mon, 4 Nov 2002 08:44:01 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:47524 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264677AbSKDNnw>; Mon, 4 Nov 2002 08:43:52 -0500
Date: Mon, 4 Nov 2002 14:49:37 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: get_user_pages rewrite (was: Huge TLB pages always physically continious?)
Message-ID: <20021104144937.H659@nightmaster.csn.tu-chemnitz.de>
References: <20021101235620.A5263@nightmaster.csn.tu-chemnitz.de> <3DC30CD6.D92D0F9F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DC30CD6.D92D0F9F@digeo.com>; from akpm@digeo.com on Fri, Nov 01, 2002 at 03:23:02PM -0800
X-Spam-Score: -14.0 (--------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *188hcR-0005lM-00*dfu4yOCs5/s*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Nov 01, 2002 at 03:23:02PM -0800, Andrew Morton wrote:
> I suggest that you restructure get_user_pages thusly:

Ok, first step follows.

> 
> 1: Write a simplified get_user_page().  Most callers of get_user_pages()
>    only want a single page anyway, and don't need to concoct all those
>    arguments.
> 
> 2: Split get_user_pages up into a pagetable walker and a callback function.
>    So it walks the pages, calling back to the caller's callback function
>    for each page with
> 
> 	(*callback)(struct page *page, <other stuff>, void *callerdata);
> 
>    You'll need to extend follow_hugetlb_page() to take the callback
>    info and to perform the callbacks for its pages as well.
> 
> 3: Reimplement the current get_user_pages() using the core engine from 2
>    (ie: write the callback for it)
 
CONFIG_HUGETLB_PAGES is currently broken by this patch, but will
be fixed NOW.

Patch implementing 1-3 of your 5 points is attached.

This also enables get_user_pages() callers to do more cleanup, if
things failed, which wasn't ensured before (namely pagecache
references where not always released on errors).

The OBSOLETE_PAGE_WALKER define is there to catch callers, which
use the vmas-pointer of get_user_pages.

There are 3 kinds of callers in the kernel:

   a) Caller needs a VMA and only ONE page of it
      -> will be converted to get_one_user_page() and must do
         find_extend_vma() itself. Since it needs a vma anyway,
         it can also look for it, right? ;-)

   b) Caller doesn't need VMA, but will take care of pages
      passed. 
      -> Will be converted to NEW variant get_user_pages(), which
         will not support the "vmas" parameter anymore.
         
         But since we pass the VMA anyway for unlocking the
         page_table_lock of the MM it belongs to, any user
         outside of the kernel can use it's own custom_page_walker_t
         and account them, too.

   c) Caller does need neither VMA nor pages
      -> is converted to use walk_user_pages()

         This caller was mm/memory.c:make_pages_present and is
         covered by the patch attached already.

My problems are now with the handling of follow_hugetlb_pages().

1) follow_hugetlb_pages() don't need the page_table_lock, but the
   custom_page_walker_t expects it to be locked and will unlock
   it on error. But since everything inside follow_hugetlb_pages()
   is happening quite fast (it cannot sleep), there should be not
   much contention.

2) It looks benefical to implement follow_one_hugetlb_page(),
   which doesn't need the page_table_lock and will only look up
   one small page. But it has to be implemented for every
   hugetlb_page implemtation.

   Is this acceptable, because it covers the common case?


Thanks for your input so far. It has been very helpful.

Patch compiles so far. Testing will be done, after I converted
all users and the generic design is ACKed ;-)

Regards

Ingo Oeser

diff -Naur --exclude=.err --exclude=.out --exclude=[.].* linux-2.5.44/include/linux/mm.h linux-2.5.44-ioe/include/linux/mm.h
--- linux-2.5.44/include/linux/mm.h	Sat Oct 19 06:01:08 2002
+++ linux-2.5.44-ioe/include/linux/mm.h	Mon Nov  4 13:53:35 2002
@@ -370,9 +370,47 @@
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 
+/*** Page walking API ***/
+
+/* &custom_page_walker - A custom page walk handler for walk_user_pages().
+ * vma:         The vma we walk pages of.
+ * page:        The page we found or an %ERR_PTR() value
+ * virt_addr:   The virtual address we are at while walking.
+ * customdata:  Anything you would like to pass additionally.
+ *
+ * Returns:
+ *      Negative values -> ERRNO values.
+ *      0               -> continue page walking.
+ *      1               -> abort page walking.
+ *
+ * If this functions gets a page, for which %IS_ERR(@page) is true, than it
+ * should do it's cleanup of customdata and return -PTR_ERR(@page).
+ *
+ * This function is called with @vma->vm_mm->page_table_lock held,
+ * if IS_ERR(@vma) is not true.
+ *
+ * But if IS_ERR(@vma) is true, IS_ERR(@page) is also true, since if we have no
+ * vma, then we also have no user space page.
+ *
+ * If it returns a negative value, then the page_table_lock must be dropped
+ * by this function, if it is held.
+ */
+typedef int (*custom_page_walker_t)(struct vm_area_struct *vma, 
+		struct page *page, unsigned long virt_addr, void *customdata);
+
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address, int write);
-int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
-		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+
+struct page *get_one_user_page(struct task_struct *tsk, 
+		struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long start, int write, int force);
+
+int walk_user_pages(struct task_struct *tsk, struct mm_struct *mm,
+		unsigned long start, int write, int force,
+		custom_page_walker_t walker, void *customdata);
+
+int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, 
+		unsigned long start, int len, int write, int force, 
+		struct page **pages, struct vm_area_struct **vmas);
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
diff -Naur --exclude=.err --exclude=.out --exclude=[.].* linux-2.5.44/mm/memory.c linux-2.5.44-ioe/mm/memory.c
--- linux-2.5.44/mm/memory.c	Sat Oct 19 06:01:52 2002
+++ linux-2.5.44-ioe/mm/memory.c	Mon Nov  4 14:32:39 2002
@@ -35,6 +35,10 @@
  * 16.07.99  -  Support of BIGMEM added by Gerhard Wichert, Siemens AG
  *		(Gerhard.Wichert@pdb.siemens.de)
  */
+/* 04.11.02  -  Page walker API added by Ingo Oeser 
+ * 		<ioe@informatik.tu-chemnitz.de>
+ * 		Thanks go to Andrew Morton for his intial idea and general help.
+ */
 
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
@@ -505,20 +509,203 @@
  * it?  This may become more complex in the future if we start dealing
  * with IO-aperture pages for direct-IO.
  */
-
 static inline struct page *get_page_map(struct page *page)
 {
 	if (!pfn_valid(page_to_pfn(page)))
-		return 0;
+		return ERR_PTR(EFAULT);
 	return page;
 }
 
+/* Simple page walk handler adding pages to a list of them */
+struct gup_add_pages {
+	unsigned int count;
+	unsigned int max_pages;
+	struct page **pages;
+};
 
-int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long start, int len, int write, int force,
-		struct page **pages, struct vm_area_struct **vmas)
+static inline void gup_pages_cleanup(struct gup_add_pages *gup)
+{
+	while (gup->count--) {
+		page_cache_release(gup->pages[gup->count]);
+	}
+}
+
+/* Follows custom_page_walker API description */
+static int gup_add_pages(struct vm_area_struct *vma, struct page *page,
+	      unsigned long virt_addr, void *customdata)
+{
+
+	struct gup_add_pages *gup = customdata;
+
+	BUG_ON(!customdata);
+
+	if (!IS_ERR(page)) {
+		gup->pages[gup->count++] = page;
+		if (!PageReserved(page))
+			page_cache_get(page);
+
+		/* Abort if we cannot hold more pages */
+		return (gup->count == gup->max_pages) ? 1 : 0;
+	}
+
+	if (!IS_ERR(vma))
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	gup_pages_cleanup(gup);
+	return -PTR_ERR(page);
+}
+
+#define OBSOLETE_PAGE_WALKER
+#ifdef OBSOLETE_PAGE_WALKER
+/* Obsolete page walk handler adding pages and vmas to a list of them */
+struct gup_add_pv {
+	unsigned int page_count;
+	unsigned int max_pages;
+	struct page **pages;
+	unsigned int vma_count;
+	unsigned int max_vmas;
+	struct vm_area_struct **vmas;
+};
+
+static inline void gup_pv_cleanup(struct gup_add_pv *gup)
+{
+	while (gup->page_count--) {
+		page_cache_release(gup->pages[gup->page_count]);
+	}
+}
+
+/* Follows custom_page_walker API description */
+static int gup_add_pv(struct vm_area_struct *vma, struct page *page,
+	   unsigned long virt_addr, void *customdata)
+{
+
+	struct gup_add_pv *gup = customdata;
+	int ret = 0;
+
+	BUG_ON(!customdata);
+
+	if (!IS_ERR(page)) {
+		if (gup->vmas) {
+			/* Add vma only, if its a new one. Since we walk them
+			 * uniquely, this simple check is enough. -ioe 
+			 */
+			if (!gup->vma_count
+			    || gup->vmas[gup->vma_count - 1] != vma) {
+				gup->vmas[gup->vma_count++] = vma;
+
+				/* Abort scanning, if we cannot hold more */
+				if (gup->vma_count == gup->max_vmas)
+					ret = 1;
+			}
+		}
+
+		if (gup->pages) {
+			gup->pages[gup->page_count++] = page;
+			if (!PageReserved(page))
+				page_cache_get(page);
+
+			/* Abort scanning, if we cannot hold more */
+			if (gup->page_count == gup->max_pages)
+				ret = 1;
+		}
+		return ret;
+	}
+
+	if (!IS_ERR(vma))
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	gup_pv_cleanup(gup);
+	return -PTR_ERR(page);
+}
+#endif				/* OBSOLETE_PAGE_WALKER */
+
+/* Try to fault in the page at START. Returns valid page or ERR_PTR().
+ *
+ * called with mm->page_table_lock held 
+ */
+static struct page *single_page_walk(struct task_struct *tsk,
+				     struct mm_struct *mm,
+				     struct vm_area_struct *vma,
+				     unsigned long start, int write)
+{
+	struct page *map;
+
+	while (!(map = follow_page(mm, start, write))) {
+		int fault;
+
+		spin_unlock(&mm->page_table_lock);
+		fault = handle_mm_fault(mm, vma, start, write);
+		spin_lock(&mm->page_table_lock);
+
+		switch (fault) {
+		case VM_FAULT_MINOR:
+			tsk->min_flt++;
+			break;
+		case VM_FAULT_MAJOR:
+			tsk->maj_flt++;
+			break;
+		case VM_FAULT_SIGBUS:
+			return ERR_PTR(EFAULT);
+		case VM_FAULT_OOM:
+			return ERR_PTR(ENOMEM);
+		default:
+			/* FIXME Is this unlock better or worse here? -ioe */
+			spin_unlock(&mm->page_table_lock);
+			BUG();
+		}
+	}
+	return get_page_map(map);
+}
+
+/* VMA contains already "start".
+ * (e.g. find_vma_extend(mm,start) has been called sucessfully already 
+ */
+struct page *get_one_user_page(struct task_struct *tsk,
+			   struct mm_struct *mm, struct vm_area_struct *vma,
+			   unsigned long start, int write, int force)
+{
+	unsigned int flags;
+	struct page *page;
+
+	/* 
+	 * Require read or write permissions.
+	 * If 'force' is set, we only require the "MAY" flags.
+	 */
+	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
+	flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
+
+	if (!vma || (vma->vm_flags & VM_IO) || !(flags & vma->vm_flags))
+		return ERR_PTR(EFAULT);
+
+	/* FIXME: These are not handled properly, yet. -ioe */
+	/*
+	   if (is_vm_hugetlb_page(vma)) {
+	   int len = 1;
+	   int i;
+	   i = follow_hugetlb_page(mm, vma, &page, NULL,
+	   &start, &len, 0);
+	   return (i == 1) ? page : ERR_PTR(EFAULT);
+	   }
+	 */
+
+	spin_lock(&mm->page_table_lock);
+	page = single_page_walk(tsk, mm, vma, start, write);
+
+	if (!(IS_ERR(page) || PageReserved(page)))
+		page_cache_get(page);
+
+	spin_unlock(&mm->page_table_lock);
+	return page;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+#error This code is not suitable for huge pages yet.
+#endif
+
+/* Returns 0 or negative errno value */
+int walk_user_pages(struct task_struct *tsk, struct mm_struct *mm,
+		unsigned long start, int write, int force,
+		custom_page_walker_t walker, void *customdata)
 {
-	int i;
+	int ret;
 	unsigned int flags;
 
 	/* 
@@ -527,65 +714,100 @@
 	 */
 	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
 	flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
-	i = 0;
 
 	do {
-		struct vm_area_struct *	vma;
+		struct vm_area_struct *vma;
 
 		vma = find_extend_vma(mm, start);
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
-				|| !(flags & vma->vm_flags))
-			return i ? : -EFAULT;
-
-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
+		if (!vma || (vma->vm_flags & VM_IO)
+		    || !(flags & vma->vm_flags))
+			return walker(ERR_PTR(EFAULT), ERR_PTR(EFAULT), start,
+				      customdata);
+
+		/* FIXME: These are not handled, yet. -ioe */
+		/*
+		   if (is_vm_hugetlb_page(vma)) {
+		   int i=0;
+		   i = follow_hugetlb_page(mm, vma, pages, vmas,
+		   &start, &len, i);
+		   continue;
+		   }
+		 */
 		spin_lock(&mm->page_table_lock);
 		do {
-			struct page *map;
-			while (!(map = follow_page(mm, start, write))) {
+			struct page *page;
+			page = single_page_walk(tsk, mm, vma, start, write);
+			ret = walker(vma, page, start, customdata);
+			switch (ret) {
+				/* Common case -> continue walking. */
+			case 0:
+				break;
+
+				/* We are satisfied with our walking. */
+			case 1:
+				ret = 0;
 				spin_unlock(&mm->page_table_lock);
-				switch (handle_mm_fault(mm,vma,start,write)) {
-				case VM_FAULT_MINOR:
-					tsk->min_flt++;
-					break;
-				case VM_FAULT_MAJOR:
-					tsk->maj_flt++;
-					break;
-				case VM_FAULT_SIGBUS:
-					return i ? i : -EFAULT;
-				case VM_FAULT_OOM:
-					return i ? i : -ENOMEM;
-				default:
-					BUG();
-				}
-				spin_lock(&mm->page_table_lock);
-			}
-			if (pages) {
-				pages[i] = get_page_map(map);
-				if (!pages[i]) {
-					spin_unlock(&mm->page_table_lock);
-					while (i--)
-						page_cache_release(pages[i]);
-					i = -EFAULT;
-					goto out;
-				}
-				if (!PageReserved(pages[i]))
-					page_cache_get(pages[i]);
+				/* Fall trough now */
+
+				/* Bail out because of error. */
+			default:
+				/* Error cases do unlock, 
+				 * if necessary. -ioe */
+				goto out;
 			}
-			if (vmas)
-				vmas[i] = vma;
-			i++;
 			start += PAGE_SIZE;
-			len--;
-		} while(len && start < vma->vm_end);
+		} while (start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
-	} while(len);
-out:
-	return i;
+	} while (1);
+      out:
+	return ret;
+}
+
+/* Ugly for now, but the defines and the union will go later. -ioe */
+int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
+	       unsigned long start, int len, int write, int force,
+	       struct page **pages, struct vm_area_struct **vmas)
+{
+	int ret;
+	custom_page_walker_t walker = gup_add_pages;
+	union {
+		struct gup_add_pages pg;
+#ifdef OBSOLETE_PAGE_WALKER
+		struct gup_add_pv pv;
+#endif
+	} gup_u;
+
+	memset(&gup_u, 0, sizeof (gup_u));
+
+#ifdef OBSOLETE_PAGE_WALKER
+	if (vmas) {
+		gup_u.pv.vmas = vmas;
+		gup_u.pv.max_vmas = len;
+		walker = gup_add_pv;
+		printk("Obsolete argument \"vmas\" used!"
+		       " Please send this report to linux-mm@vger.kernel.org"
+		       " or fix the caller. Stack trace follows...\n");
+		WARN_ON(vmas);
+	}
+#else
+	/* FIXME: Or should we simply ignore it? -ioe */
+	BUG_ON(vmas);
+#endif
+
+	/* Warn on non-sense calls, but process them. -ioe */
+	WARN_ON(!vmas && !pages);
+
+	if (pages) {
+		gup_u.pg.max_pages = len;
+		gup_u.pg.pages = pages;
+	}
+
+	ret = walk_user_pages(tsk, mm, start, write, force, walker, &gup_u);
+	if (ret == 0) {
+		ret = gup_u.pg.count;
+	}
+	return ret;
 }
 
 static inline void zeromap_pte_range(pte_t * pte, unsigned long address,
@@ -1294,10 +1516,30 @@
 	return pmd_offset(pgd, address);
 }
 
+
+/* A page walker, which just counts down how many pages it got */
+static int
+gup_mk_present(struct vm_area_struct *vma, struct page *page,
+	       unsigned long virt_addr, void *customdata)
+{
+
+	int *todo = customdata;
+
+	if (!IS_ERR(page)) {
+		(*todo)--;
+		/* Abort if have made all required pages present */
+		return (*todo) ? 0 : 1;
+	}
+
+	if (!IS_ERR(vma))
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	return -PTR_ERR(page);
+}
+
 int make_pages_present(unsigned long addr, unsigned long end)
 {
 	int ret, len, write;
-	struct vm_area_struct * vma;
+	struct vm_area_struct *vma;
 
 	vma = find_vma(current->mm, addr);
 	write = (vma->vm_flags & VM_WRITE) != 0;
@@ -1305,10 +1547,18 @@
 		BUG();
 	if (end > vma->vm_end)
 		BUG();
-	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
-	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
-	return ret == len ? 0 : -1;
+	len = (end + PAGE_SIZE - 1) / PAGE_SIZE - addr / PAGE_SIZE;
+
+	/* This is necessary for gup_mk_present to work and
+	 * also a slight optimization. -ioe 
+	 */
+	if (len == 0)
+		return 0;
+
+	ret = walk_user_pages(current, current->mm, addr,
+			      write, 0, gup_mk_present, &len);
+
+	return (ret == 0 && len == 0) ? 0 : -1;
 }
 
 /* 
