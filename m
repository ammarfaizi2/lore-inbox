Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSKGKEt>; Thu, 7 Nov 2002 05:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSKGKEt>; Thu, 7 Nov 2002 05:04:49 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:10646 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S266433AbSKGKEe>; Thu, 7 Nov 2002 05:04:34 -0500
Date: Thu, 7 Nov 2002 11:08:40 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: get_user_pages rewrite (completed, updated for 2.4.46)
Message-ID: <20021107110840.P659@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *189jcr-0003Fc-00*zOFhTrc1ybc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

now I have implemented the big get_user_pages rewrite. All the
patches apply to 2.4.46 so far.

Description of each patch (all called page_walk_api-2.5.46-XX):

01 - Implements the page walk api, staying as compatible, as
     possible to the user users. Introduces get_one_user_page()
     for the purpose, that the name suggests. 
     
     The page iterator is called walk_user_pages().
     get_one_user_page() expects find_extend_vma() to be called first.
     This is necessary or at least a nice optimization anyway in
     all its callers. 

     Doesn't work with CONFIG_HUGETLB_PAGE and warns about that.
     (02 removes that).

     Introduces OBSOLETE_PAGE_WALKER and some mess to catch
     callers of get_user_pages, which need to collect vmas.
     (05 removes that).

     Also demonstrate its benefits in make_pages_present().

02 - Implements a new follow_hugetlb_page() for i386,ia64,sparc64.
     Caveat: spin_lock(&mm->page_table_lock) is taken in this
        function, which wasn't needed before. 
        Some contention analysis is welcome!

03 - Use the new function from 02 and support huge tlb pages now, too.

04 - Sprinkle the get_one_user_page() where only one page is needed.

05 - This patch requires the aio fix, which I sent out earlier
     today[1]. fs/aio.c called get_user_pages() with a wrong argument,
     causing buffer overflow and scribble on kernel memory.
     
     Here get_user_pages() is reduced by the last argument ("vmas"),
     because no remaining callers used it.
     
     I also sprinkled comments about optimizing with the new 
     page walker API, where apropriate.


All in all, I still need to implement the reason for all this:

   A scatterlist page walker.
   
This will be done, if this stuff is accepted, because it
makes no sense without it.

The attached patchset supersedes the one I sent as page_walk_api[2].

Comments are very welcome.

Regards

Ingo Oeser

[1] Ben might post it together with his next AIO update, so
   linux-kernel please stay tuned. On linux-mm it has been
   posted.

[2] <20021104144937.H659@nightmaster.csn.tu-chemnitz.de>
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_walk_api-2.5.46-01.patch"

diff -Naur linux-2.5.46/kernel/ksyms.c linux-2.5.46-ioe/kernel/ksyms.c
--- linux-2.5.46/kernel/ksyms.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/kernel/ksyms.c	Thu Nov  7 09:30:15 2002
@@ -134,6 +134,8 @@
 EXPORT_SYMBOL(page_address);
 #endif
 EXPORT_SYMBOL(get_user_pages);
+EXPORT_SYMBOL(get_one_user_page);
+EXPORT_SYMBOL_GPL(walk_user_pages);
 
 /* filesystem internal functions */
 EXPORT_SYMBOL(def_blk_fops);
diff -Naur linux-2.5.46/include/linux/mm.h linux-2.5.46-ioe/include/linux/mm.h
--- linux-2.5.46/include/linux/mm.h	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/include/linux/mm.h	Tue Nov  5 21:43:26 2002
@@ -373,9 +373,47 @@
 extern int sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
 
 
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
diff -Naur linux-2.5.46/mm/memory.c linux-2.5.46-ioe/mm/memory.c
--- linux-2.5.46/mm/memory.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/mm/memory.c	Tue Nov  5 22:43:38 2002
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
@@ -516,20 +520,205 @@
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
 
 
-int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long start, int len, int write, int force,
-		struct page **pages, struct vm_area_struct **vmas)
+/* Simple page walk handler adding pages to a list of them */
+struct gup_add_pages {
+	unsigned int count;
+	unsigned int max_pages;
+	struct page **pages;
+};
+
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
+		flush_dcache_page(page);
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
+			flush_dcache_page(page);
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
 	unsigned int flags;
 
 	/* 
@@ -538,66 +727,103 @@
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
-		spin_lock(&mm->page_table_lock);
-		do {
-			struct page *map;
-			while (!(map = follow_page(mm, start, write))) {
-				spin_unlock(&mm->page_table_lock);
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
-				flush_dcache_page(pages[i]);
-				if (!PageReserved(pages[i]))
-					page_cache_get(pages[i]);
-			}
-			if (vmas)
-				vmas[i] = vma;
-			i++;
-			start += PAGE_SIZE;
-			len--;
-		} while(len && start < vma->vm_end);
+ 		if (!vma || (vma->vm_flags & VM_IO)
+ 		    || !(flags & vma->vm_flags))
+ 			return walker(ERR_PTR(EFAULT), ERR_PTR(EFAULT), start,
+ 				      customdata);
+ 
+ 		/* FIXME: These are not handled, yet. -ioe */
+ 		/*
+ 		   if (is_vm_hugetlb_page(vma)) {
+ 		   int i=0;
+ 		   i = follow_hugetlb_page(mm, vma, pages, vmas,
+ 		   &start, &len, i);
+ 		   continue;
+ 		   }
+ 		 */
+  		spin_lock(&mm->page_table_lock);
+  		do {
+			int ret;
+ 			struct page *page;
+ 			page = single_page_walk(tsk, mm, vma, start, write);
+ 			ret = walker(vma, page, start, customdata);
+ 			switch (ret) {
+ 				/* Common case -> continue walking. */
+ 			case 0:
+ 				break;
+ 
+ 				/* We are satisfied with our walking. */
+ 			case 1:
+ 				ret = 0;
+  				spin_unlock(&mm->page_table_lock);
+ 				/* Fall trough now */
+ 
+ 				/* Bail out because of error. */
+ 			default:
+ 				/* Error cases do unlock, 
+ 				 * if necessary. -ioe */
+ 				return ret;
+  			}
+  			start += PAGE_SIZE;
+ 		} while (start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
-	} while(len);
-out:
-	return i;
+	} while(1);
+
+	/* We will never reach this code, but this makes GCC happy */
+	return 0;
+}
+
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
 
 static void zeromap_pte_range(pte_t * pte, unsigned long address,
@@ -1309,10 +1535,29 @@
 	return pmd_offset(pgd, address);
 }
 
+
+/* A page walker, which just counts down how many pages it got */
+static int gup_mk_present(struct vm_area_struct *vma, struct page *page,
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
@@ -1320,10 +1565,18 @@
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

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_walk_api-2.5.46-02.patch"

diff -Naur linux-2.5.46/arch/i386/mm/hugetlbpage.c linux-2.5.46-ioe/arch/i386/mm/hugetlbpage.c
--- linux-2.5.46/arch/i386/mm/hugetlbpage.c	Tue Nov  5 21:32:52 2002
+++ linux-2.5.46-ioe/arch/i386/mm/hugetlbpage.c	Tue Nov  5 23:54:29 2002
@@ -180,15 +180,16 @@
 
 int
 follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
+		unsigned long *st,
+		custom_page_walker_t walker, void *customdata)
 {
 	pte_t *ptep, pte;
 	unsigned long start = *st;
 	unsigned long pstart;
-	int len = *length;
+	int ret = 0;
 	struct page *page;
 
+	spin_lock(&mm->page_table_lock);
 	do {
 		pstart = start;
 		ptep = huge_pte_offset(mm, start);
@@ -196,22 +197,31 @@
 
 back1:
 		page = pte_page(pte);
-		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
-			pages[i] = page;
+		page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
+		ret = walker(vma, page, start, customdata);
+		switch (ret) {
+			/* Common case -> continue walking. */
+		case 0:
+			break;
+			/* We are satisfied with our walking. */
+		case 1:
+			ret = 0;
+			goto out_unlock;
+		default:
+			/* Error cases do unlock, 
+			 * if necessary. -ioe */
+			goto out;
 		}
-		if (vmas)
-			vmas[i] = vma;
-		i++;
-		len--;
 		start += PAGE_SIZE;
-		if (((start & HPAGE_MASK) == pstart) && len &&
+		if (((start & HPAGE_MASK) == pstart) &&
 				(start < vma->vm_end))
 			goto back1;
-	} while (len && start < vma->vm_end);
-	*length = len;
+	} while (start < vma->vm_end);
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
+out:
 	*st = start;
-	return i;
+	return ret;
 }
 
 void free_huge_page(struct page *page)
diff -Naur linux-2.5.46/arch/ia64/mm/hugetlbpage.c linux-2.5.46-ioe/arch/ia64/mm/hugetlbpage.c
--- linux-2.5.46/arch/ia64/mm/hugetlbpage.c	Tue Nov  5 21:32:52 2002
+++ linux-2.5.46-ioe/arch/ia64/mm/hugetlbpage.c	Tue Nov  5 23:54:29 2002
@@ -226,16 +226,17 @@
 }
 
 int
-follow_hugetlb_page (struct mm_struct *mm, struct vm_area_struct *vma,
-		     struct page **pages, struct vm_area_struct **vmas,
-		     unsigned long *st, int *length, int i)
+follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *st,
+		custom_page_walker_t walker, void *customdata)
 {
 	pte_t *ptep, pte;
 	unsigned long start = *st;
 	unsigned long pstart;
-	int len = *length;
+	int ret = 0;
 	struct page *page;
 
+	spin_lock(&mm->page_table_lock);
 	do {
 		pstart = start & HPAGE_MASK;
 		ptep = huge_pte_offset(mm, start);
@@ -243,22 +244,30 @@
 
 back1:
 		page = pte_page(pte);
-		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
-			pages[i] = page;
+		page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
+		ret = walker(vma, page, start, customdata);
+		switch (ret) {
+			/* Common case -> continue walking. */
+		case 0:
+			break;
+			/* We are satisfied with our walking. */
+		case 1:
+			ret = 0;
+			goto out_unlock;
+		default:
+			/* Error cases do unlock, 
+			 * if necessary. -ioe */
+			goto out;
 		}
-		if (vmas)
-			vmas[i] = vma;
-		i++;
-		len--;
 		start += PAGE_SIZE;
-		if (((start & HPAGE_MASK) == pstart) && len
-		    && (start < vma->vm_end))
+		if (((start & HPAGE_MASK) == pstart) && (start < vma->vm_end))
 			goto back1;
-	} while (len && start < vma->vm_end);
-	*length = len;
+	} while (start < vma->vm_end);
+out_unlock:
+	spin_unlock(&mm->page_table_lock);
+out:
 	*st = start;
-	return i;
+	return ret;
 }
 
 static void
diff -Naur linux-2.5.46/arch/sparc64/mm/hugetlbpage.c linux-2.5.46-ioe/arch/sparc64/mm/hugetlbpage.c
--- linux-2.5.46/arch/sparc64/mm/hugetlbpage.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/arch/sparc64/mm/hugetlbpage.c	Tue Nov  5 23:59:12 2002
@@ -269,16 +269,18 @@
 	return -ENOMEM;
 }
 
+
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *st, int *length, int i)
+		unsigned long *st,
+		custom_page_walker_t walker, void *customdata)
 {
 	pte_t *ptep, pte;
 	unsigned long start = *st;
 	unsigned long pstart;
-	int len = *length;
+	int ret = 0;
 	struct page *page;
 
+	spin_lock(&mm->page_table_lock);
 	do {
 		pstart = start;
 		ptep = huge_pte_offset_map(mm, start);
@@ -286,14 +288,22 @@
 
 back1:
 		page = pte_page(pte);
-		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
-			pages[i] = page;
+		page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
+		ret = walker(vma, page, start, customdata);
+		switch (ret) {
+			/* Common case -> continue walking. */
+		case 0:
+			break;
+			/* We are satisfied with our walking. */
+		case 1:
+			ret = 0;
+			spin_unlock(&mm->page_table_lock);
+		default:
+			/* Error cases do unlock, 
+			 * if necessary. -ioe */
+			pte_unmap(ptep);
+			goto out;
 		}
-		if (vmas)
-			vmas[i] = vma;
-		i++;
-		len--;
 		start += PAGE_SIZE;
 		if (((start & HPAGE_MASK) == pstart) && len &&
 				(start < vma->vm_end))
@@ -301,10 +311,10 @@
 
 		pte_unmap(ptep);
 	} while (len && start < vma->vm_end);
-
-	*length = len;
+	spin_unlock(&mm->page_table_lock);
+out:
 	*st = start;
-	return i;
+	return ret;
 }
 
 static void zap_hugetlb_resources(struct vm_area_struct *mpnt)
diff -Naur linux-2.5.46/include/linux/hugetlb.h linux-2.5.46-ioe/include/linux/hugetlb.h
--- linux-2.5.46/include/linux/hugetlb.h	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/include/linux/hugetlb.h	Tue Nov  5 23:44:46 2002
@@ -8,7 +8,16 @@
 }
 
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
-int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+//int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+/* Sorry for the ugliness, but the other option was to always 
+ * include linux/mm.h -ioe
+ */
+int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, 
+		unsigned long *,
+		int (*)(struct vm_area_struct *, 
+		struct page *, unsigned long, void *), 
+		void *);
+
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
@@ -19,7 +28,7 @@
 	return 0;
 }
 
-#define follow_hugetlb_page(m,v,p,vs,a,b,i)		({ BUG(); 0; })
+#define follow_hugetlb_page(m,v,a,w,c)		({ BUG(); 0; })
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
 #define zap_hugepage_range(vma, start, len)	BUG()

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_walk_api-2.5.46-03.patch"

diff -u linux-2.5.46-ioe/mm/memory.c linux-2.5.46-ioe/mm/memory.c
--- linux-2.5.46-ioe/mm/memory.c	Tue Nov  5 22:43:38 2002
+++ linux-2.5.46-ioe/mm/memory.c	Wed Nov  6 00:24:05 2002
@@ -689,16 +689,16 @@
 	if (!vma || (vma->vm_flags & VM_IO) || !(flags & vma->vm_flags))
 		return ERR_PTR(EFAULT);
 
-	/* FIXME: These are not handled properly, yet. -ioe */
-	/*
-	   if (is_vm_hugetlb_page(vma)) {
-	   int len = 1;
-	   int i;
-	   i = follow_hugetlb_page(mm, vma, &page, NULL,
-	   &start, &len, 0);
-	   return (i == 1) ? page : ERR_PTR(EFAULT);
-	   }
-	 */
+	if (is_vm_hugetlb_page(vma)) {
+		struct gup_add_pages gup = { 
+			.count = 0,
+			.max_pages = 1, 
+			.pages = &page,
+		};
+		int ret;
+		ret = follow_hugetlb_page(mm, vma, &start, gup_add_pages, &gup);
+		return (ret == 0) ? page : ERR_PTR(ret);
+	}
 
 	spin_lock(&mm->page_table_lock);
 	page = single_page_walk(tsk, mm, vma, start, write);
@@ -710,15 +710,12 @@
 	return page;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-#error This code is not suitable for huge pages yet.
-#endif
-
 /* Returns 0 or negative errno value */
 int walk_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int write, int force,
 		custom_page_walker_t walker, void *customdata)
 {
+	int ret = 0;
 	unsigned int flags;
 
 	/* 
@@ -738,18 +735,18 @@
  			return walker(ERR_PTR(EFAULT), ERR_PTR(EFAULT), start,
  				      customdata);
  
- 		/* FIXME: These are not handled, yet. -ioe */
- 		/*
- 		   if (is_vm_hugetlb_page(vma)) {
- 		   int i=0;
- 		   i = follow_hugetlb_page(mm, vma, pages, vmas,
- 		   &start, &len, i);
- 		   continue;
- 		   }
- 		 */
+		if (is_vm_hugetlb_page(vma)) {
+			ret = follow_hugetlb_page(mm, vma, &start, 
+					walker, customdata);
+
+			if (ret == 0) 
+				continue;
+			else 
+				break;
+		}
+
   		spin_lock(&mm->page_table_lock);
   		do {
-			int ret;
  			struct page *page;
  			page = single_page_walk(tsk, mm, vma, start, write);
  			ret = walker(vma, page, start, customdata);
@@ -774,9 +771,7 @@
  		} while (start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
 	} while(1);
-
-	/* We will never reach this code, but this makes GCC happy */
-	return 0;
+	return ret;
 }
 
  

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_walk_api-2.5.46-04.patch"

diff -Naur linux-2.5.46/fs/binfmt_elf.c linux-2.5.46-ioe/fs/binfmt_elf.c
--- linux-2.5.46/fs/binfmt_elf.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/fs/binfmt_elf.c	Wed Nov  6 20:47:16 2002
@@ -1245,10 +1245,11 @@
 		     addr < vma->vm_end;
 		     addr += PAGE_SIZE) {
 			struct page* page;
-			struct vm_area_struct *vma;
+			
+			page = get_one_user_page(current, 
+					current->mm, vma, addr, 1, 0);
 
-			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
-						&page, &vma) <= 0) {
+			if (IS_ERR(page)) {
 				DUMP_SEEK (file->f_pos + PAGE_SIZE);
 			} else {
 				if (page == ZERO_PAGE(addr)) {
diff -Naur linux-2.5.46/kernel/futex.c linux-2.5.46-ioe/kernel/futex.c
--- linux-2.5.46/kernel/futex.c	Sat Oct 19 06:01:18 2002
+++ linux-2.5.46-ioe/kernel/futex.c	Wed Nov  6 14:57:45 2002
@@ -108,8 +108,8 @@
 static struct page *__pin_page(unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
 	struct page *page, *tmp;
-	int err;
 
 	/*
 	 * Do a quick atomic lookup first - this is the fastpath.
@@ -129,12 +129,13 @@
 	unlock_futex_mm();
 
 	down_read(&mm->mmap_sem);
-	err = get_user_pages(current, mm, addr, 1, 0, 0, &page, NULL);
+	vma = find_extend_vma(mm, addr);
+	page = get_one_user_page(current, mm, vma, addr, 1, 0);
 	up_read(&mm->mmap_sem);
 
 	lock_futex_mm();
 
-	if (err < 0)
+	if (IS_ERR(page))
 		return NULL;
 	/*
 	 * Since the faulting happened with locks released, we have to
diff -Naur linux-2.5.46/kernel/ptrace.c linux-2.5.46-ioe/kernel/ptrace.c
--- linux-2.5.46/kernel/ptrace.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/kernel/ptrace.c	Wed Nov  6 15:41:12 2002
@@ -163,12 +163,16 @@
 	down_read(&mm->mmap_sem);
 	/* ignore errors, just check how much was sucessfully transfered */
 	while (len) {
-		int bytes, ret, offset;
+		int bytes, offset;
 		void *maddr;
 
-		ret = get_user_pages(current, mm, addr, 1,
-				write, 1, &page, &vma);
-		if (ret <= 0)
+		/* TODO: This whole function could be optimized, 
+		 * 	 by doing the whole stuff of this loop 
+		 * 	 in a custom page walker using walk_user_pages(). -ioe 
+		 */
+		vma = find_extend_vma(mm, addr);
+		page = get_one_user_page(current, mm, vma, addr, write, 1);
+		if (IS_ERR(page))
 			break;
 
 		bytes = len;

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="page_walk_api-2.5.46-05.patch"

diff -u linux-2.5.46-ioe/fs/aio.c linux-2.5.46-ioe/fs/aio.c
--- linux-2.5.46-ioe/fs/aio.c	Thu Nov  7 09:40:17 2002
+++ linux-2.5.46-ioe/fs/aio.c	Thu Nov  7 09:30:49 2002
@@ -149,7 +149,7 @@
 	dprintk("mmap address: 0x%08lx\n", info->mmap_base);
 	info->nr_pages = get_user_pages(current, ctx->mm,
 					info->mmap_base, nr_pages, 
-					1, 0, info->ring_pages, NULL);
+					1, 0, info->ring_pages);
 	up_write(&ctx->mm->mmap_sem);
 
 	if (unlikely(info->nr_pages != nr_pages)) {
diff -u linux-2.5.46-ioe/include/linux/mm.h linux-2.5.46-ioe/include/linux/mm.h
--- linux-2.5.46-ioe/include/linux/mm.h	Thu Nov  7 09:40:17 2002
+++ linux-2.5.46-ioe/include/linux/mm.h	Thu Nov  7 09:25:28 2002
@@ -413,7 +413,7 @@
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, 
 		unsigned long start, int len, int write, int force, 
-		struct page **pages, struct vm_area_struct **vmas);
+		struct page **pages);
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
diff -u linux-2.5.46-ioe/kernel/ptrace.c linux-2.5.46-ioe/kernel/ptrace.c
--- linux-2.5.46-ioe/kernel/ptrace.c	Thu Nov  7 09:40:17 2002
+++ linux-2.5.46-ioe/kernel/ptrace.c	Thu Nov  7 09:29:07 2002
@@ -146,7 +146,7 @@
 /*
  * Access another process' address space.
  * Source/target buffer must be kernel space, 
- * Do not walk the page table directly, use get_user_pages
+ * Do not walk the page table directly, use get_one_user_page.
  */
 
 int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
diff -u linux-2.5.46-ioe/mm/memory.c linux-2.5.46-ioe/mm/memory.c
--- linux-2.5.46-ioe/mm/memory.c	Thu Nov  7 09:40:17 2002
+++ linux-2.5.46-ioe/mm/memory.c	Thu Nov  7 09:28:02 2002
@@ -567,70 +567,6 @@
 	return -PTR_ERR(page);
 }
 
-#define OBSOLETE_PAGE_WALKER
-#ifdef OBSOLETE_PAGE_WALKER
-/* Obsolete page walk handler adding pages and vmas to a list of them */
-struct gup_add_pv {
-	unsigned int page_count;
-	unsigned int max_pages;
-	struct page **pages;
-	unsigned int vma_count;
-	unsigned int max_vmas;
-	struct vm_area_struct **vmas;
-};
-
-static inline void gup_pv_cleanup(struct gup_add_pv *gup)
-{
-	while (gup->page_count--) {
-		page_cache_release(gup->pages[gup->page_count]);
-	}
-}
-
-/* Follows custom_page_walker API description */
-static int gup_add_pv(struct vm_area_struct *vma, struct page *page,
-	   unsigned long virt_addr, void *customdata)
-{
-
-	struct gup_add_pv *gup = customdata;
-	int ret = 0;
-
-	BUG_ON(!customdata);
-
-	if (!IS_ERR(page)) {
-		if (gup->vmas) {
-			/* Add vma only, if its a new one. Since we walk them
-			 * uniquely, this simple check is enough. -ioe 
-			 */
-			if (!gup->vma_count
-			    || gup->vmas[gup->vma_count - 1] != vma) {
-				gup->vmas[gup->vma_count++] = vma;
-
-				/* Abort scanning, if we cannot hold more */
-				if (gup->vma_count == gup->max_vmas)
-					ret = 1;
-			}
-		}
-
-		if (gup->pages) {
-			gup->pages[gup->page_count++] = page;
-			flush_dcache_page(page);
-			if (!PageReserved(page))
-				page_cache_get(page);
-
-			/* Abort scanning, if we cannot hold more */
-			if (gup->page_count == gup->max_pages)
-				ret = 1;
-		}
-		return ret;
-	}
-
-	if (!IS_ERR(vma))
-		spin_unlock(&vma->vm_mm->page_table_lock);
-	gup_pv_cleanup(gup);
-	return -PTR_ERR(page);
-}
-#endif				/* OBSOLETE_PAGE_WALKER */
-
 /* Try to fault in the page at START. Returns valid page or ERR_PTR().
  *
  * called with mm->page_table_lock held 
@@ -775,50 +711,33 @@
 }
 
  
-/* Ugly for now, but the defines and the union will go later. -ioe */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	       unsigned long start, int len, int write, int force,
-	       struct page **pages, struct vm_area_struct **vmas)
+	       struct page **pages)
 {
 	int ret;
 	custom_page_walker_t walker = gup_add_pages;
-	union {
-		struct gup_add_pages pg;
-#ifdef OBSOLETE_PAGE_WALKER
-		struct gup_add_pv pv;
-#endif
-	} gup_u;
+	struct gup_add_pages gup;
 
-	memset(&gup_u, 0, sizeof (gup_u));
+	memset(&gup, 0, sizeof (gup));
 
-#ifdef OBSOLETE_PAGE_WALKER
-	if (vmas) {
-		gup_u.pv.vmas = vmas;
-		gup_u.pv.max_vmas = len;
-		walker = gup_add_pv;
-		printk("Obsolete argument \"vmas\" used!"
-		       " Please send this report to linux-mm@vger.kernel.org"
-		       " or fix the caller. Stack trace follows...\n");
-		WARN_ON(vmas);
-	}
-#else
-	/* FIXME: Or should we simply ignore it? -ioe */
-	BUG_ON(vmas);
-#endif
-
-	/* Warn on non-sense calls, but process them. -ioe */
-	WARN_ON(!vmas && !pages);
 
 	if (pages) {
-		gup_u.pg.max_pages = len;
-		gup_u.pg.pages = pages;
+		gup.max_pages = len;
+		gup.pages = pages;
+	} else {
+		/* Warn on non-sense calls, but process them. 
+		 * The user should use a custom page walker for this.
+		 * Look at gup_mk_present() for an example.   -ioe 
+		 */
+		WARN_ON(!pages);
 	}
 
-	ret = walk_user_pages(tsk, mm, start, write, force, walker, &gup_u);
+	ret = walk_user_pages(tsk, mm, start, write, force, walker, &gup);
 	if (ret == 0) {
-		ret = gup_u.pg.count;
+		ret = gup.count;
 	}
 	return ret;
 }


diff -u linux-2.5.46-ioe/fs/nfs/direct.c linux-2.5.46-ioe/fs/nfs/direct.c
--- linux-2.5.46/fs/nfs/direct.c	Sat Oct 19 06:02:29 2002
+++ linux-2.5.46-ioe/fs/nfs/direct.c	Thu Nov  7 09:31:31 2002
@@ -69,8 +69,7 @@
 	if (*pages) {
 		down_read(&current->mm->mmap_sem);
 		result = get_user_pages(current, current->mm, addr,
-					page_count, (rw == WRITE), 0,
-					*pages, NULL);
+					page_count, (rw == WRITE), 0, *pages);
 		up_read(&current->mm->mmap_sem);
 		if (result < 0)
 			printk(KERN_ERR "%s: get_user_pages result %d\n",
diff -u linux-2.5.46-ioe/fs/direct-io.c linux-2.5.46-ioe/fs/direct-io.c
--- linux-2.5.46/fs/direct-io.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/fs/direct-io.c	Thu Nov  7 09:32:57 2002
@@ -127,8 +127,7 @@
 		nr_pages,			/* How many pages? */
 		dio->rw == READ,		/* Write to memory? */
 		0,				/* force (?) */
-		&dio->pages[0],
-		NULL);				/* vmas */
+		&dio->pages[0]);
 	up_read(&current->mm->mmap_sem);
 
 	if (ret < 0 && dio->blocks_available && (dio->rw == WRITE)) {
diff -u linux-2.5.46-ioe/fs/bio.c linux-2.5.46-ioe/fs/bio.c
--- linux-2.5.46/fs/bio.c	Tue Nov  5 21:32:45 2002
+++ linux-2.5.46-ioe/fs/bio.c	Thu Nov  7 09:32:23 2002
@@ -485,7 +485,7 @@
 
 	down_read(&current->mm->mmap_sem);
 	ret = get_user_pages(current, current->mm, uaddr, nr_pages,
-						write_to_vm, 0, pages, NULL);
+						write_to_vm, 0, pages);
 	up_read(&current->mm->mmap_sem);
 
 	if (ret < nr_pages)
diff -u linux-2.5.46-ioe/drivers/scsi/st.c linux-2.5.46-ioe/drivers/scsi/st.c
--- linux-2.5.46/drivers/scsi/st.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/drivers/scsi/st.c	Thu Nov  7 09:35:03 2002
@@ -4030,6 +4030,7 @@
 		return -ENOMEM;
 
         /* Try to fault in all of the necessary pages */
+	/* TODO: Use custom page walker for these later. -ioe */
 	down_read(&current->mm->mmap_sem);
         /* rw==READ means read from drive, write into memory area */
 	res = get_user_pages(
@@ -4039,8 +4040,7 @@
 		nr_pages,
 		rw == READ,
 		0, /* don't force */
-		pages,
-		NULL);
+		pages);
 	up_read(&current->mm->mmap_sem);
 
 	/* Errors and no page mapped should return here */
diff -u linux-2.5.46-ioe/drivers/scsi/sg.c linux-2.5.46-ioe/drivers/scsi/sg.c
--- linux-2.5.46/drivers/scsi/sg.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/drivers/scsi/sg.c	Thu Nov  7 09:35:25 2002
@@ -1767,6 +1767,7 @@
 		return -ENOMEM;
 
         /* Try to fault in all of the necessary pages */
+	/* TODO: Use custom page walker for these later. -ioe */
 	down_read(&current->mm->mmap_sem);
         /* rw==READ means read from drive, write into memory area */
 	res = get_user_pages(
@@ -1776,8 +1777,7 @@
 		nr_pages,
 		rw == READ,
 		0, /* don't force */
-		pages,
-		NULL);
+		pages);
 	up_read(&current->mm->mmap_sem);
 
 	/* Errors and no page mapped should return here */
diff -u linux-2.5.46-ioe/drivers/media/video-buf.c linux-2.5.46-ioe/drivers/media/video-buf.c
--- linux-2.5.46/drivers/media/video/video-buf.c	Tue Nov  5 21:32:53 2002
+++ linux-2.5.46-ioe/drivers/media/video/video-buf.c	Thu Nov  7 09:33:37 2002
@@ -170,7 +170,7 @@
         err = get_user_pages(current,current->mm,
 			     data & PAGE_MASK, dma->nr_pages,
 			     rw == READ, 1, /* force */
-			     dma->pages, NULL);
+			     dma->pages);
 	up_read(&current->mm->mmap_sem);
 	if (err != dma->nr_pages) {
 		dma->nr_pages = (err >= 0) ? err : 0;

--OBd5C1Lgu00Gd/Tn--
