Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTJMX4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTJMX4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:56:47 -0400
Received: from holomorphy.com ([66.224.33.161]:36488 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262105AbTJMX40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:56:26 -0400
Date: Mon, 13 Oct 2003 16:59:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] State of ru_majflt
Message-ID: <20031013235935.GF765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031013165104.GA14720@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013165104.GA14720@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 06:51:04PM +0200, Roger Luethi wrote:
> The ru_majflt field of struct rusage doesn't return major page faults --
> pages retrieved from cache are counted as well. POSIX and Linux man pages
> don't seem to cover that particular field, but the values returned are
> neither what BSD (where Linux got its copy of the struct from) does nor
> what the field name suggests.
> A proper solution would probably have filemap_nopage tell its caller the
> correct return code. Is this considered a bug or is it a documentation
> issue? How much do we care?

Not sure. It does say "FIXME". A quick grep for "nopage" turns up
something like this, which hijacks the currently-unused arguemnt.
Untested (not even compiletested). vs. 2.6.0-test7-bkrecent

I tried to straighten out the do_page_cache_readahead() vs. pgmajfault
business in mm/filemap.c too. I have to wonder if hoisting the increment
to do_no_page() would be in order. do_file_page() probably needs a
similar treatment. filemap_nopage. If anyone calls ->nopage() explicitly
in non-fault c it'll increment pgmajfault when it shouldn't; that would
be automatically resolved by hoisting it into do_no_page().


-- wli


===== Documentation/filesystems/Locking 1.45 vs edited =====
--- 1.45/Documentation/filesystems/Locking	Wed Aug 20 22:31:59 2003
+++ edited/Documentation/filesystems/Locking	Mon Oct 13 15:13:40 2003
@@ -420,7 +420,7 @@
 prototypes:
 	void (*open)(struct vm_area_struct*);
 	void (*close)(struct vm_area_struct*);
-	struct page *(*nopage)(struct vm_area_struct*, unsigned long, int);
+	struct page *(*nopage)(struct vm_area_struct*, unsigned long, int *);
 
 locking rules:
 		BKL	mmap_sem
===== arch/i386/mm/hugetlbpage.c 1.38 vs edited =====
--- 1.38/arch/i386/mm/hugetlbpage.c	Tue Sep 23 23:15:29 2003
+++ edited/arch/i386/mm/hugetlbpage.c	Mon Oct 13 15:14:10 2003
@@ -529,7 +529,7 @@
  * this far.
  */
 static struct page *hugetlb_nopage(struct vm_area_struct *vma,
-				unsigned long address, int unused)
+				unsigned long address, int *unused)
 {
 	BUG();
 	return NULL;
===== arch/ia64/ia32/binfmt_elf32.c 1.15 vs edited =====
--- 1.15/arch/ia64/ia32/binfmt_elf32.c	Mon Jul 21 07:39:59 2003
+++ edited/arch/ia64/ia32/binfmt_elf32.c	Mon Oct 13 15:15:42 2003
@@ -60,11 +60,13 @@
 extern unsigned long *ia32_gdt;
 
 struct page *
-ia32_install_shared_page (struct vm_area_struct *vma, unsigned long address, int no_share)
+ia32_install_shared_page (struct vm_area_struct *vma, unsigned long address, int *type)
 {
 	struct page *pg = ia32_shared_page[(address - vma->vm_start)/PAGE_SIZE];
 
 	get_page(pg);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return pg;
 }
 
===== arch/ia64/mm/hugetlbpage.c 1.15 vs edited =====
--- 1.15/arch/ia64/mm/hugetlbpage.c	Thu Oct  9 16:09:37 2003
+++ edited/arch/ia64/mm/hugetlbpage.c	Mon Oct 13 15:15:53 2003
@@ -518,7 +518,7 @@
 	return 1;
 }
 
-static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
+static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int *unused)
 {
 	BUG();
 	return NULL;
===== arch/ppc64/mm/hugetlbpage.c 1.2 vs edited =====
--- 1.2/arch/ppc64/mm/hugetlbpage.c	Sat Sep  6 18:40:37 2003
+++ edited/arch/ppc64/mm/hugetlbpage.c	Mon Oct 13 16:16:04 2003
@@ -914,7 +914,7 @@
  * this far.
  */
 static struct page *hugetlb_nopage(struct vm_area_struct *vma,
-				unsigned long address, int unused)
+				unsigned long address, int *unused)
 {
 	BUG();
 	return NULL;
===== arch/sparc64/mm/hugetlbpage.c 1.8 vs edited =====
--- 1.8/arch/sparc64/mm/hugetlbpage.c	Tue Aug 26 09:41:27 2003
+++ edited/arch/sparc64/mm/hugetlbpage.c	Mon Oct 13 15:16:38 2003
@@ -433,7 +433,7 @@
 }
 
 static struct page *
-hugetlb_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
+hugetlb_nopage(struct vm_area_struct *vma, unsigned long address, int *unused)
 {
 	BUG();
 	return NULL;
===== drivers/char/agp/alpha-agp.c 1.9 vs edited =====
--- 1.9/drivers/char/agp/alpha-agp.c	Mon Sep 15 17:03:51 2003
+++ edited/drivers/char/agp/alpha-agp.c	Mon Oct 13 15:17:14 2003
@@ -13,7 +13,7 @@
 
 static struct page *alpha_core_agp_vm_nopage(struct vm_area_struct *vma,
 					     unsigned long address,
-					     int write_access)
+					     int *type)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
 	dma_addr_t dma_addr;
@@ -30,6 +30,8 @@
 	 */
 	page = virt_to_page(__va(pa));
 	get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return page;
 }
 
===== drivers/char/drm/drmP.h 1.29 vs edited =====
--- 1.29/drivers/char/drm/drmP.h	Thu Sep 25 08:56:58 2003
+++ edited/drivers/char/drm/drmP.h	Mon Oct 13 15:17:38 2003
@@ -760,16 +760,16 @@
 				/* Mapping support (drm_vm.h) */
 extern struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
 				   unsigned long address,
-				   int write_access);
+				   int *type);
 extern struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
 				       unsigned long address,
-				       int write_access);
+				       int *type);
 extern struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
 				       unsigned long address,
-				       int write_access);
+				       int *type);
 extern struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
 				      unsigned long address,
-				      int write_access);
+				      int *type);
 extern void	     DRM(vm_open)(struct vm_area_struct *vma);
 extern void	     DRM(vm_close)(struct vm_area_struct *vma);
 extern void	     DRM(vm_shm_close)(struct vm_area_struct *vma);
===== drivers/char/drm/drm_vm.h 1.25 vs edited =====
--- 1.25/drivers/char/drm/drm_vm.h	Thu Jul 10 23:18:01 2003
+++ edited/drivers/char/drm/drm_vm.h	Mon Oct 13 16:48:08 2003
@@ -76,7 +76,7 @@
  */
 struct page *DRM(vm_nopage)(struct vm_area_struct *vma,
 			    unsigned long address,
-			    int write_access)
+			    int *type)
 {
 #if __REALLY_HAVE_AGP
 	drm_file_t *priv  = vma->vm_file->private_data;
@@ -133,6 +133,8 @@
 			  baddr, __va(agpmem->memory->memory[offset]), offset,
 			  atomic_read(&page->count));
 
+		if (type)
+			*type = VM_FAULT_MINOR;
 		return page;
         }
 vm_nopage_error:
@@ -154,7 +156,7 @@
  */
 struct page *DRM(vm_shm_nopage)(struct vm_area_struct *vma,
 				unsigned long address,
-				int write_access)
+				int *type)
 {
 	drm_map_t	 *map	 = (drm_map_t *)vma->vm_private_data;
 	unsigned long	 offset;
@@ -170,6 +172,8 @@
 	if (!page)
 		return NOPAGE_OOM;
 	get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 
 	DRM_DEBUG("shm_nopage 0x%lx\n", address);
 	return page;
@@ -268,7 +272,7 @@
  */
 struct page *DRM(vm_dma_nopage)(struct vm_area_struct *vma,
 				unsigned long address,
-				int write_access)
+				int *type)
 {
 	drm_file_t	 *priv	 = vma->vm_file->private_data;
 	drm_device_t	 *dev	 = priv->dev;
@@ -287,6 +291,8 @@
 			     (offset & (~PAGE_MASK))));
 
 	get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 
 	DRM_DEBUG("dma_nopage 0x%lx (page %lu)\n", address, page_nr);
 	return page;
@@ -304,7 +310,7 @@
  */
 struct page *DRM(vm_sg_nopage)(struct vm_area_struct *vma,
 			       unsigned long address,
-			       int write_access)
+			       int *type)
 {
 	drm_map_t        *map    = (drm_map_t *)vma->vm_private_data;
 	drm_file_t *priv = vma->vm_file->private_data;
@@ -325,6 +331,8 @@
 	page_offset = (offset >> PAGE_SHIFT) + (map_offset >> PAGE_SHIFT);
 	page = entry->pagelist[page_offset];
 	get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 
 	return page;
 }
===== drivers/ieee1394/dma.c 1.5 vs edited =====
--- 1.5/drivers/ieee1394/dma.c	Thu Jul 24 17:00:00 2003
+++ edited/drivers/ieee1394/dma.c	Mon Oct 13 15:19:12 2003
@@ -187,7 +187,7 @@
 /* nopage() handler for mmap access */
 
 static struct page*
-dma_region_pagefault(struct vm_area_struct *area, unsigned long address, int write_access)
+dma_region_pagefault(struct vm_area_struct *area, unsigned long address, int *type)
 {
 	unsigned long offset;
 	unsigned long kernel_virt_addr;
@@ -202,6 +202,8 @@
 	    (address > (unsigned long) area->vm_start + (PAGE_SIZE * dma->n_pages)) )
 		goto out;
 
+	if (type)
+		*type = VM_FAULT_MINOR;
 	offset = address - area->vm_start;
 	kernel_virt_addr = (unsigned long) dma->kvirt + offset;
 	ret = vmalloc_to_page((void*) kernel_virt_addr);
===== drivers/media/video/video-buf.c 1.11 vs edited =====
--- 1.11/drivers/media/video/video-buf.c	Mon Oct  6 08:48:02 2003
+++ edited/drivers/media/video/video-buf.c	Mon Oct 13 15:19:52 2003
@@ -1076,7 +1076,7 @@
  */
 static struct page*
 videobuf_vm_nopage(struct vm_area_struct *vma, unsigned long vaddr,
-		  int write_access)
+		  int *type)
 {
 	struct page *page;
 
@@ -1088,6 +1088,8 @@
 	if (!page)
 		return NOPAGE_OOM;
 	clear_user_page(page_address(page), vaddr, page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return page;
 }
 
===== drivers/scsi/sg.c 1.69 vs edited =====
--- 1.69/drivers/scsi/sg.c	Sat Sep 20 02:35:07 2003
+++ edited/drivers/scsi/sg.c	Mon Oct 13 15:21:16 2003
@@ -1115,7 +1115,7 @@
 }
 
 static struct page *
-sg_vma_nopage(struct vm_area_struct *vma, unsigned long addr, int unused)
+sg_vma_nopage(struct vm_area_struct *vma, unsigned long addr, int *type)
 {
 	Sg_fd *sfp;
 	struct page *page = NOPAGE_SIGBUS;
@@ -1155,6 +1155,8 @@
 		page = virt_to_page(page_ptr);
 		get_page(page);	/* increment page count */
 	}
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return page;
 }
 
===== fs/ncpfs/mmap.c 1.7 vs edited =====
--- 1.7/fs/ncpfs/mmap.c	Sat Aug 10 20:07:55 2002
+++ edited/fs/ncpfs/mmap.c	Mon Oct 13 16:23:56 2003
@@ -26,7 +26,7 @@
  * Fill in the supplied page for mmap
  */
 static struct page* ncp_file_mmap_nopage(struct vm_area_struct *area,
-				     unsigned long address, int write_access)
+				     unsigned long address, int *type)
 {
 	struct file *file = area->vm_file;
 	struct dentry *dentry = file->f_dentry;
@@ -85,6 +85,15 @@
 		memset(pg_addr + already_read, 0, PAGE_SIZE - already_read);
 	flush_dcache_page(page);
 	kunmap(page);
+
+	/*
+	 * If I understand ncp_read_kernel() properly, the above always
+	 * fetches from the network, here the analogue of disk.
+	 * -- wli
+	 */
+	if (type)
+		*type = VM_FAULT_MAJOR;
+	inc_page_state(pgmajfault);
 	return page;
 }
 
===== include/linux/mm.h 1.133 vs edited =====
--- 1.133/include/linux/mm.h	Sun Oct  5 01:07:49 2003
+++ edited/include/linux/mm.h	Mon Oct 13 16:31:00 2003
@@ -143,7 +143,7 @@
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
-	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
+	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
@@ -405,7 +405,7 @@
 extern void show_free_areas(void);
 
 struct page *shmem_nopage(struct vm_area_struct * vma,
-			unsigned long address, int unused);
+			unsigned long address, int *type);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
@@ -563,7 +563,7 @@
 extern void truncate_inode_pages(struct address_space *, loff_t);
 
 /* generic vm_area_ops exported for stackable file systems */
-extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int);
+struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int *);
 
 /* mm/page-writeback.c */
 int write_one_page(struct page *page, int wait);
===== kernel/sys.c 1.66 vs edited =====
--- 1.66/kernel/sys.c	Thu Oct  9 15:13:54 2003
+++ edited/kernel/sys.c	Mon Oct 13 16:02:41 2003
@@ -1325,8 +1325,6 @@
  * either stopped or zombied.  In the zombied case the task won't get
  * reaped till shortly after the call to getrusage(), in both cases the
  * task being examined is in a frozen state so the counters won't change.
- *
- * FIXME! Get the fault counts properly!
  */
 int getrusage(struct task_struct *p, int who, struct rusage __user *ru)
 {
===== mm/filemap.c 1.210 vs edited =====
--- 1.210/mm/filemap.c	Tue Oct  7 19:53:43 2003
+++ edited/mm/filemap.c	Mon Oct 13 16:25:46 2003
@@ -984,7 +984,7 @@
  * it in the page cache, and handles the special cases reasonably without
  * having a lot of duplicated code.
  */
-struct page * filemap_nopage(struct vm_area_struct * area, unsigned long address, int unused)
+struct page * filemap_nopage(struct vm_area_struct * area, unsigned long address, int *type)
 {
 	int error;
 	struct file *file = area->vm_file;
@@ -993,7 +993,7 @@
 	struct inode *inode = mapping->host;
 	struct page *page;
 	unsigned long size, pgoff, endoff;
-	int did_readaround = 0;
+	int did_readaround = 0, majmin = VM_FAULT_MINOR;
 
 	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
 	endoff = ((area->vm_end - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
@@ -1042,6 +1042,14 @@
 		if (ra->mmap_miss > ra->mmap_hit + MMAP_LOTSAMISS)
 			goto no_cached_page;
 
+		/*
+		 * To keep the pgmajfault counter straight, we need to
+		 * check did_readaround, as this is an inner loop.
+		 */
+		if (!did_readaround) {
+			majmin = VM_FAULT_MAJOR;
+			inc_page_state(pgmajfault);
+		}
 		did_readaround = 1;
 		do_page_cache_readahead(mapping, file,
 				pgoff & ~(MMAP_READAROUND-1), MMAP_READAROUND);
@@ -1063,6 +1071,8 @@
 	 * Found the page and have a reference on it.
 	 */
 	mark_page_accessed(page);
+	if (type)
+		*type = majmin;
 	return page;
 
 outside_data_content:
@@ -1098,7 +1108,10 @@
 	return NULL;
 
 page_not_uptodate:
-	inc_page_state(pgmajfault);
+	if (!did_readaround) {
+		majmin = VM_FAULT_MAJOR;
+		inc_page_state(pgmajfault);
+	}
 	lock_page(page);
 
 	/* Did it get unhashed while we waited for it? */
===== mm/memory.c 1.139 vs edited =====
--- 1.139/mm/memory.c	Wed Oct  8 08:59:27 2003
+++ edited/mm/memory.c	Mon Oct 13 15:44:10 2003
@@ -1416,7 +1416,7 @@
 	}
 	smp_rmb();  /* Prevent CPU from reordering lock-free ->nopage() */
 retry:
-	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
+	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
 
 	/* no page was available -- either SIGBUS or OOM */
 	if (new_page == NOPAGE_SIGBUS)
@@ -1485,14 +1485,12 @@
 		pte_unmap(page_table);
 		page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
-		ret = VM_FAULT_MINOR;
 		goto out;
 	}
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	spin_unlock(&mm->page_table_lock);
-	ret = VM_FAULT_MAJOR;
 	goto out;
 oom:
 	ret = VM_FAULT_OOM;
===== mm/shmem.c 1.135 vs edited =====
--- 1.135/mm/shmem.c	Tue Sep  9 23:41:41 2003
+++ edited/mm/shmem.c	Mon Oct 13 16:30:00 2003
@@ -67,7 +67,7 @@
 };
 
 static int shmem_getpage(struct inode *inode, unsigned long idx,
-			 struct page **pagep, enum sgp_type sgp);
+			 struct page **pagep, enum sgp_type sgp, int *type);
 
 static inline struct page *shmem_dir_alloc(unsigned int gfp_mask)
 {
@@ -522,7 +522,7 @@
 			if (attr->ia_size & (PAGE_CACHE_SIZE-1)) {
 				(void) shmem_getpage(inode,
 					attr->ia_size>>PAGE_CACHE_SHIFT,
-						&page, SGP_READ);
+						&page, SGP_READ, NULL);
 			}
 		}
 	}
@@ -734,7 +734,7 @@
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
  */
-static int shmem_getpage(struct inode *inode, unsigned long idx, struct page **pagep, enum sgp_type sgp)
+static int shmem_getpage(struct inode *inode, unsigned long idx, struct page **pagep, enum sgp_type sgp, int *type)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -743,7 +743,7 @@
 	struct page *swappage;
 	swp_entry_t *entry;
 	swp_entry_t swap;
-	int error;
+	int error, majmin = VM_FAULT_MINOR;
 
 	if (idx >= SHMEM_MAX_INDEX)
 		return -EFBIG;
@@ -780,6 +780,10 @@
 		if (!swappage) {
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
+			/* here we actually do the io */
+			if (majmin == VM_FAULT_MINOR && type)
+				inc_page_state(pgmajfault);
+			majmin = VM_FAULT_MAJOR;
 			swapin_readahead(swap);
 			swappage = read_swap_cache_async(swap);
 			if (!swappage) {
@@ -926,6 +930,8 @@
 		} else
 			*pagep = ZERO_PAGE(0);
 	}
+	if (type)
+		*type = majmin;
 	return 0;
 
 failed:
@@ -936,7 +942,7 @@
 	return error;
 }
 
-struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
+struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int *type)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page = NULL;
@@ -947,7 +953,7 @@
 	idx += vma->vm_pgoff;
 	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
-	error = shmem_getpage(inode, idx, &page, SGP_CACHE);
+	error = shmem_getpage(inode, idx, &page, SGP_CACHE, type);
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
@@ -974,7 +980,7 @@
 		/*
 		 * Will need changing if PAGE_CACHE_SIZE != PAGE_SIZE
 		 */
-		err = shmem_getpage(inode, pgoff, &page, sgp);
+		err = shmem_getpage(inode, pgoff, &page, sgp, NULL);
 		if (err)
 			return err;
 		if (page) {
@@ -1124,7 +1130,7 @@
 shmem_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	struct inode *inode = page->mapping->host;
-	return shmem_getpage(inode, page->index, &page, SGP_WRITE);
+	return shmem_getpage(inode, page->index, &page, SGP_WRITE, NULL);
 }
 
 static ssize_t
@@ -1181,7 +1187,7 @@
 		 * But it still may be a good idea to prefault below.
 		 */
 
-		err = shmem_getpage(inode, index, &page, SGP_WRITE);
+		err = shmem_getpage(inode, index, &page, SGP_WRITE, NULL);
 		if (err)
 			break;
 
@@ -1264,7 +1270,7 @@
 				break;
 		}
 
-		desc->error = shmem_getpage(inode, index, &page, SGP_READ);
+		desc->error = shmem_getpage(inode, index, &page, SGP_READ, NULL);
 		if (desc->error) {
 			if (desc->error == -EINVAL)
 				desc->error = 0;
@@ -1515,7 +1521,7 @@
 			iput(inode);
 			return -ENOMEM;
 		}
-		error = shmem_getpage(inode, 0, &page, SGP_WRITE);
+		error = shmem_getpage(inode, 0, &page, SGP_WRITE, NULL);
 		if (error) {
 			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
@@ -1551,7 +1557,7 @@
 static int shmem_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct page *page = NULL;
-	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ);
+	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ, NULL);
 	if (res)
 		return res;
 	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
@@ -1564,7 +1570,7 @@
 static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page = NULL;
-	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ);
+	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ, NULL);
 	if (res)
 		return res;
 	res = vfs_follow_link(nd, kmap(page));
===== sound/core/pcm_native.c 1.41 vs edited =====
--- 1.41/sound/core/pcm_native.c	Mon Sep 29 19:28:26 2003
+++ edited/sound/core/pcm_native.c	Mon Oct 13 15:44:41 2003
@@ -2779,7 +2779,7 @@
 	return mask;
 }
 
-static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int no_share)
+static struct page * snd_pcm_mmap_status_nopage(struct vm_area_struct *area, unsigned long address, int *type)
 {
 	snd_pcm_substream_t *substream = (snd_pcm_substream_t *)area->vm_private_data;
 	snd_pcm_runtime_t *runtime;
@@ -2791,6 +2791,8 @@
 	page = virt_to_page(runtime->status);
 	if (!PageReserved(page))
 		get_page(page);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return page;
 }
 
===== sound/oss/via82cxxx_audio.c 1.34 vs edited =====
--- 1.34/sound/oss/via82cxxx_audio.c	Sun Oct  5 01:07:55 2003
+++ edited/sound/oss/via82cxxx_audio.c	Mon Oct 13 15:53:34 2003
@@ -2116,7 +2116,7 @@
 
 
 static struct page * via_mm_nopage (struct vm_area_struct * vma,
-				    unsigned long address, int write_access)
+				    unsigned long address, int *type)
 {
 	struct via_info *card = vma->vm_private_data;
 	struct via_channel *chan = &card->ch_out;
@@ -2124,12 +2124,11 @@
 	unsigned long pgoff;
 	int rd, wr;
 
-	DPRINTK ("ENTER, start %lXh, ofs %lXh, pgoff %ld, addr %lXh, wr %d\n",
+	DPRINTK ("ENTER, start %lXh, ofs %lXh, pgoff %ld, addr %lXh\n",
 		 vma->vm_start,
 		 address - vma->vm_start,
 		 (address - vma->vm_start) >> PAGE_SHIFT,
-		 address,
-		 write_access);
+		 address);
 
         if (address > vma->vm_end) {
 		DPRINTK ("EXIT, returning NOPAGE_SIGBUS\n");
@@ -2167,6 +2166,8 @@
 	DPRINTK ("EXIT, returning page %p for cpuaddr %lXh\n",
 		 dmapage, (unsigned long) chan->pgtbl[pgoff].cpuaddr);
 	get_page (dmapage);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return dmapage;
 }
 
===== sound/oss/emu10k1/audio.c 1.19 vs edited =====
--- 1.19/sound/oss/emu10k1/audio.c	Tue Aug 26 09:25:41 2003
+++ edited/sound/oss/emu10k1/audio.c	Mon Oct 13 15:52:23 2003
@@ -989,7 +989,7 @@
 	return 0;
 }
 
-static struct page *emu10k1_mm_nopage (struct vm_area_struct * vma, unsigned long address, int write_access)
+static struct page *emu10k1_mm_nopage (struct vm_area_struct * vma, unsigned long address, int *type)
 {
 	struct emu10k1_wavedevice *wave_dev = vma->vm_private_data;
 	struct woinst *woinst = wave_dev->woinst;
@@ -1032,6 +1032,8 @@
 	get_page (dmapage);
 
 	DPD(3, "page: %#lx\n", (unsigned long) dmapage);
+	if (type)
+		*type = VM_FAULT_MINOR;
 	return dmapage;
 }
 
