Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJNMVC>; Mon, 14 Oct 2002 08:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbSJNMVC>; Mon, 14 Oct 2002 08:21:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37573 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261609AbSJNMUq>;
	Mon, 14 Oct 2002 08:20:46 -0400
Date: Mon, 14 Oct 2002 14:38:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: [patch, feature] nonlinear mappings, prefaulting support, 2.5.42-F8
Message-ID: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) implements two brand-new VM features:

 - a new syscall, remap_file_pages(), for arbitrary remapping of shared
   mappings, within the same vma.

 - explicit pagetable population (prefaulting) support for mmap().

   [ MAP_POPULATE is a nice side-effect of the more generic ->populate()
     handler approach suggested by Linus. Plus the patch implements
     MAP_NONBLOCK for IO-less prefaulting as well.]

the patch and a test-utility can also be found at:

	http://redhat.com/~mingo/remap-file-pages-patches/

first, a little bit of background about what this patch tries to achieve:

Linux mappings (vmas) have been 'linear' from day one on, which means that
files can only be mmap()-ed linearly - ie. the file's first page is mapped
to the first page in the mapping, the second page is mapped to the second
page, the third file-page is mapped to the third mapping page, etc. [plus
an optional constant offset on the file side.] This is a basic property of
mmap() on all unices.

The main goal of this patch is to provide support for 'nonlinear'
mappings, ie. vmas where there's an arbitrary relationship between the
file and the virtual memory range that is mapped - while still keeping the
same single vma.

nonlinearly mapped virtual memory ranges of the same file are already
possible by using multiple separate mappings (vmas) via mmap(), which
approach, while used widely, has lots of disadvantages:

- really complex remappings (used by databases or virtualizing
  applications) create a *huge* amount of vmas - and vma's are per-process
  which puts a really big load on kernel memory allocations, especially on
  32-bit systems. I've seen applications that had a mapping setup that
  generated 128 *thousand* vmas per process, causing lots of problems.

- setting up separate mappings is expensive, causes one pagefault per page
  and also causes TLB flushes.

- even on 64-bit systems, when mapping really large (terabyte size) and
  really sparse files, sparse mappings can be a disadvantage - in the
  worst-case there can be as much as 1 more pagetable page allocated for
  every file page that is mapped in.

So the more compact mappings enabled by the new remap_file_pages()  
syscall can be advantegous in a number of cases. The new syscall has the
following semantics:

 * sys_remap_file_pages - remap arbitrary pages of a shared backing store
 *                        file within an existing vma.
 * @start: start of the remapped virtual memory range
 * @size: size of the remapped virtual memory range
 * @prot: new protection bits of the range
 * @pgoff: to be mapped page of the backing store file
 * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.

the virtual memory range has to be mapped linearly before using it, and
all further remapping has to happen within a single vma. Since all the
mapping information of nonlinear vmas lives in the pagetables, they either
have to be MAP_LOCKED (for databases or virtualization software) or need a
special SIGBUS handler to reinstall mappings across swapping (for more
complex uses such as memory debuggers).

mmap(MAP_POPULATE) prefaulting support, is a 'side-effect' of the support
code needed for nonlinear vmas.

Today's relational databases, when supporting large amounts of RAM on
IA32, typically map a big /dev/shm/ shared memory file (eg. 16 GB large)  
into a smaller window (eg. 1GB large) and heavily remap that window. Here
is a list of advantages of nonlinear mappings, over of the current mmap()
based remapping method, in the case of such DB memory models:

- less vma tree lookup overhead: there's only one vma allocated for an eg.
  1 GB window. In fact this vma would be cached in the mm->mmap_cache most
  of the time.

- dramatically reduced vma lowmem overhead: i've seen DBs where about
  50%(!) of all lowmem allocations during a TPC run are due to the shmfs
  vmas. remap_file_pages() is in essence using the pagetables as the only
  mapping information - and it's thus the most memory-compact mapping
  method possible.

- the vma lowmem reduction has another advantage: the number of concurrent
  database processes can be increased significantly. With pagetables in
  highmem and mass-vmas avoided, the lowmem pressure is reduced
  significantly.

- less swapping overhead: a high number of vmas increases the swapping
  overhead.

- finegrained caching for the application - it no longer has a lowmem
  impact to map at 4K granularity.

- TLB flush avoidance: the MAP_FIXED overmapping of larger than 4K cache
  units causes a TLB flush, greatly increasing the overhead of 'basic'
  DB cache operations - both the direct overhead and the secondary costs
  of repopulating the TLB cache are signifiant - and will only increase
  with newer CPUs. remap_file_pages() uses the one-page invalidation
  instruction, which does not destroy the TLB.

- reduced cost of cache remapping: remapping a eg. 16K cache element
  causes a kernel entry, an unmapping, a TLB flush and a vma-install, plus
  4 subsequent pagefaults. With remap_file_pages() it's a single kernel
  entry per cache element - no followup pagefaults.

the patch has got an initial review from Linus, Andrew Morton and Hugh
Dickins, and most of their suggestions are part of the patch already.

Implementational details:

- pagetable population is a per-vma op currently, not a file op. The
  reason is that remapping itself is a per-vma concept, changing
  sys_remap_file_pages() to work across multiple vmas does not make much
  sense IMO.

- the fact that MAP_LOCKED has to be used is not an issue for things like
  databases, which size their caches to available RAM anyway, and want to
  have a separate chunk of memory that is never swapped out.

- i've added MAP_NONBLOCK as well, which enables applications to prefault 
  all pages that are in the pagecache already, but cause no further IO.  
  This can be useful for the dynamic linker, especially when prelinking is
  enabled.

- the lowlevel population handlers are currently simplified. They iterate
  over the virtual memory range and look up the file page for the given
  offset. It would be faster to iterate the pagecache mapping's radix tree
  and the pagetables at once, but it's also *much* more complex. I have
  tried to implement it and had to unroll the change - mixing radix tree
  walking and pagetable walking and getting all the VM details right is
  really complex - especially considering all the re-lookup race checks
  that have to occur upon IO. It might make sense to split out a fast
  function for MAP_NONBLOCK. (everyone is welcome to implement these
  things.)

- two backing store concepts have a ->populate function currently: shmfs
  and the generic pagecache.

- readahead: currently filemap_populate() does not initiate further
  readahead - this is mainly to recognize the mostly random nature of
  remap_file_pages() remappings. Or should we trust the readahead engine
  and use one filemap_getpage() function for filemap_nopage() and
  filemap_populate()? The readahead should not go beyond the window
  specified by the populate() function, which is distinct from the mostly
  guessing work filemap_nopage() has to do. This is the reason why i
  separated the two codepaths, although they did similar things.

i've also tested the patch by unconditionally enabling prefaulting in
mmap(), which produced a fully working system, so i'm confident that the
basic bits are right. The testcode on my webpage can be used to check the
nonlinear remapping functionality. I've tested x86 SMP and UP.

all in one, nonlinear mappings (not present in any other OS i'm aware of)
would IMO be a nice twist to the already excellent and incredibly flexible
Linux VM. Comments, suggestions are welcome!

	Ingo

--- linux/arch/i386/kernel/entry.S.orig	2002-09-20 17:20:21.000000000 +0200
+++ linux/arch/i386/kernel/entry.S	2002-10-14 10:09:38.000000000 +0200
@@ -736,6 +736,7 @@
 	.long sys_alloc_hugepages /* 250 */
 	.long sys_free_hugepages
 	.long sys_exit_group
+	.long sys_remap_file_pages
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/include/linux/mm.h.orig	2002-10-14 10:09:05.000000000 +0200
+++ linux/include/linux/mm.h	2002-10-14 13:02:10.000000000 +0200
@@ -130,6 +130,7 @@
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
+	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, unsigned long prot, unsigned long pgoff, int nonblock);
 };
 
 /* forward declaration; pte_chain is meant to be internal to rmap.c */
@@ -366,9 +367,12 @@
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
+extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, unsigned long prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
+extern int sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
+
 
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address, int write);
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
--- linux/include/asm-i386/mman.h.orig	2002-09-20 17:20:17.000000000 +0200
+++ linux/include/asm-i386/mman.h	2002-10-14 12:58:21.000000000 +0200
@@ -18,6 +18,8 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
--- linux/include/asm-i386/unistd.h.orig	2002-10-14 10:08:51.000000000 +0200
+++ linux/include/asm-i386/unistd.h	2002-10-14 10:09:38.000000000 +0200
@@ -257,6 +257,7 @@
 #define __NR_alloc_hugepages	250
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
+#define __NR_remap_file_pages	253
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- linux/mm/fremap.c.orig	2002-10-14 10:09:38.000000000 +0200
+++ linux/mm/fremap.c	2002-10-14 13:01:47.000000000 +0200
@@ -0,0 +1,138 @@
+/*
+ *   linux/mm/mpopulate.c
+ * 
+ * Explicit pagetable population and nonlinear (random) mappings support.
+ *
+ * started by Ingo Molnar, Copyright (C) 2002
+ */
+
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/mman.h>
+#include <linux/pagemap.h>
+#include <linux/swapops.h>
+#include <asm/mmu_context.h>
+
+static inline void zap_pte(struct mm_struct *mm, pte_t *ptep)
+{
+	pte_t pte = *ptep;
+
+	if (pte_none(pte))
+		return;
+	if (pte_present(pte)) {
+		unsigned long pfn = pte_pfn(pte);
+
+		pte = ptep_get_and_clear(ptep);
+		if (pfn_valid(pfn)) {
+			struct page *page = pfn_to_page(pfn);
+			if (!PageReserved(page)) {
+				if (pte_dirty(pte))
+					set_page_dirty(page);
+				page_remove_rmap(page, ptep);
+				page_cache_release(page);
+				mm->rss--;
+			}
+		}
+	} else {
+		free_swap_and_cache(pte_to_swp_entry(pte));
+		pte_clear(ptep);
+	}
+}
+
+/*
+ * Install a page to a given virtual memory address, release any
+ * previously existing mapping.
+ */
+int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long addr, struct page *page, unsigned long prot)
+{
+	int err = -ENOMEM;
+	pte_t *pte, entry;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	spin_lock(&mm->page_table_lock);
+
+	pmd = pmd_alloc(mm, pgd, addr);
+	if (!pmd)
+		goto err_unlock;
+
+	pte = pte_alloc_map(mm, pmd, addr);
+	if (!pte)
+		goto err_unlock;
+
+	zap_pte(mm, pte);
+
+	mm->rss++;
+	flush_page_to_ram(page);
+	flush_icache_page(vma, page);
+	entry = mk_pte(page, protection_map[prot]);
+	if (prot & PROT_WRITE)
+		entry = pte_mkwrite(pte_mkdirty(entry));
+	set_pte(pte, entry);
+	page_add_rmap(page, pte);
+	pte_unmap(pte);
+	flush_tlb_page(vma, addr);
+
+	spin_unlock(&mm->page_table_lock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&mm->page_table_lock);
+	return err;
+}
+
+/***
+ * sys_remap_file_pages - remap arbitrary pages of a shared backing store
+ *                        file within an existing vma.
+ * @start: start of the remapped virtual memory range
+ * @size: size of the remapped virtual memory range
+ * @prot: new protection bits of the range
+ * @pgoff: to be mapped page of the backing store file
+ * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.
+ *
+ * this syscall works purely via pagetables, so it's the most efficient
+ * way to map the same (large) file into a given virtual window. Unlike
+ * mremap()/mmap() it does not create any new vmas.
+ *
+ * The new mappings do not live across swapout, so either use MAP_LOCKED
+ * or use PROT_NONE in the original linear mapping and add a special
+ * SIGBUS pagefault handler to reinstall zapped mappings.
+ */
+int sys_remap_file_pages(unsigned long start, unsigned long size,
+	unsigned long prot, unsigned long pgoff, unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long end = start + size;
+	struct vm_area_struct *vma;
+	int err = -EINVAL;
+
+	/*
+	 * Sanitize the syscall parameters:
+	 */
+	start = PAGE_ALIGN(start);
+	size = PAGE_ALIGN(size);
+	prot &= 0xf;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_vma(mm, start);
+	/*
+	 * Make sure the vma is shared, that it supports prefaulting,
+	 * and that the remapped range is valid and fully within
+	 * the single existing vma:
+	 */
+	if (vma && (vma->vm_flags & VM_SHARED) &&
+		vma->vm_ops && vma->vm_ops->populate &&
+			end > start && start >= vma->vm_start &&
+				end <= vma->vm_end)
+		err = vma->vm_ops->populate(vma, start, size, prot,
+						pgoff, flags & MAP_NONBLOCK);
+
+	up_read(&mm->mmap_sem);
+
+	return err;
+}
+
--- linux/mm/Makefile.orig	2002-10-14 10:09:04.000000000 +0200
+++ linux/mm/Makefile	2002-10-14 10:09:38.000000000 +0200
@@ -4,7 +4,7 @@
 
 export-objs := shmem.o filemap.o mempool.o page_alloc.o page-writeback.o
 
-obj-y	 := memory.o mmap.o filemap.o mprotect.o mlock.o mremap.o \
+obj-y	 := memory.o mmap.o filemap.o fremap.o mprotect.o mlock.o mremap.o \
 	    vmalloc.o slab.o bootmem.o swap.o vmscan.o page_io.o \
 	    page_alloc.o swap_state.o swapfile.o oom_kill.o \
 	    shmem.o highmem.o mempool.o msync.o mincore.o readahead.o \
--- linux/mm/shmem.c.orig	2002-10-14 10:09:04.000000000 +0200
+++ linux/mm/shmem.c	2002-10-14 12:23:32.000000000 +0200
@@ -710,7 +710,10 @@
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
  */
-static int shmem_getpage(struct inode *inode, unsigned long idx, struct page **pagep)
+static int shmem_getpage(struct inode *inode,
+		unsigned long idx,
+		struct page **pagep,
+		int nonblock)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -735,11 +738,9 @@
 	spin_unlock(&info->lock);
 
 repeat:
-	page = find_lock_page(mapping, idx);
-	if (page) {
-		*pagep = page;
+	*pagep = page = find_lock_page(mapping, idx);
+	if (page || nonblock)
 		return 0;
-	}
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
@@ -879,7 +880,7 @@
 	}
 	spin_unlock(&info->lock);
 	if (swap.val) {
-		if (shmem_getpage(inode, idx, &page) == 0)
+		if (shmem_getpage(inode, idx, &page, 0) == 0)
 			unlock_page(page);
 	}
 	return page;
@@ -899,7 +900,7 @@
 	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= inode->i_size)
 		return NOPAGE_SIGBUS;
 
-	error = shmem_getpage(inode, idx, &page);
+	error = shmem_getpage(inode, idx, &page, 0);
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
@@ -908,6 +909,43 @@
 	return page;
 }
 
+static int shmem_populate(struct vm_area_struct *vma,
+		unsigned long addr,
+		unsigned long len,
+		unsigned long prot,
+		unsigned long pgoff,
+		int nonblock)
+{
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	int err;
+
+repeat:
+	if (((loff_t) pgoff << PAGE_CACHE_SHIFT) >= inode->i_size)
+		return -EFAULT;
+
+	err = shmem_getpage(inode, pgoff, &page, nonblock);
+	if (err)
+		return err;
+
+	if (page) {
+		unlock_page(page);
+
+		err = install_page(mm, vma, addr, page, prot);
+		if (err)
+			return err;
+	}
+
+	len -= PAGE_SIZE;
+	addr += PAGE_SIZE;
+	pgoff++;
+	if (len)
+		goto repeat;
+
+	return 0;
+}
+
 void shmem_lock(struct file *file, int lock)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -1111,7 +1149,7 @@
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		status = shmem_getpage(inode, index, &page);
+		status = shmem_getpage(inode, index, &page, 0);
 		if (status)
 			break;
 
@@ -1178,7 +1216,7 @@
 				break;
 		}
 
-		desc->error = shmem_getpage(inode, index, &page);
+		desc->error = shmem_getpage(inode, index, &page, 0);
 		if (desc->error) {
 			if (desc->error == -EFAULT)
 				desc->error = 0;
@@ -1429,7 +1467,7 @@
 			iput(inode);
 			return -ENOMEM;
 		}
-		error = shmem_getpage(inode, 0, &page);
+		error = shmem_getpage(inode, 0, &page, 0);
 		if (error) {
 			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
@@ -1466,7 +1504,7 @@
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
 	struct page *page;
-	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	int res = shmem_getpage(dentry->d_inode, 0, &page, 0);
 	if (res)
 		return res;
 	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
@@ -1479,7 +1517,7 @@
 static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page;
-	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	int res = shmem_getpage(dentry->d_inode, 0, &page, 0);
 	if (res)
 		return res;
 	res = vfs_follow_link(nd, kmap(page));
@@ -1746,6 +1784,7 @@
 
 static struct vm_operations_struct shmem_vm_ops = {
 	.nopage		= shmem_nopage,
+	.populate	= shmem_populate,
 };
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
--- linux/mm/mmap.c.orig	2002-10-14 10:08:55.000000000 +0200
+++ linux/mm/mmap.c	2002-10-14 12:58:57.000000000 +0200
@@ -601,6 +601,12 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	if (flags & MAP_POPULATE) {
+		up_write(&mm->mmap_sem);
+		sys_remap_file_pages(addr, len, prot,
+					pgoff, flags & MAP_NONBLOCK);
+		down_write(&mm->mmap_sem);
+	}
 	return addr;
 
 unmap_and_free_vma:
--- linux/mm/filemap.c.orig	2002-10-14 10:22:07.000000000 +0200
+++ linux/mm/filemap.c	2002-10-14 12:33:40.000000000 +0200
@@ -1154,8 +1154,155 @@
 	return NULL;
 }
 
+static struct page * filemap_getpage(struct file *file, unsigned long pgoff,
+					int nonblock)
+{
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct page *page;
+	int error;
+
+	/*
+	 * Do we have something in the page cache already?
+	 */
+retry_find:
+	page = find_get_page(mapping, pgoff);
+	if (!page) {
+		if (nonblock)
+			return NULL;
+		goto no_cached_page;
+	}
+
+	/*
+	 * Ok, found a page in the page cache, now we need to check
+	 * that it's up-to-date.
+	 */
+	if (!PageUptodate(page))
+		goto page_not_uptodate;
+
+success:
+	/*
+	 * Found the page and have a reference on it, need to check sharing
+	 * and possibly copy it over to another page..
+	 */
+	mark_page_accessed(page);
+	flush_page_to_ram(page);
+
+	return page;
+
+no_cached_page:
+	error = page_cache_read(file, pgoff);
+
+	/*
+	 * The page we want has now been added to the page cache.
+	 * In the unlikely event that someone removed it in the
+	 * meantime, we'll just come back here and read it again.
+	 */
+	if (error >= 0)
+		goto retry_find;
+
+	/*
+	 * An error return from page_cache_read can result if the
+	 * system is low on memory, or a problem occurs while trying
+	 * to schedule I/O.
+	 */
+	return NULL;
+
+page_not_uptodate:
+	lock_page(page);
+
+	/* Did it get unhashed while we waited for it? */
+	if (!page->mapping) {
+		unlock_page(page);
+		goto err;
+	}
+
+	/* Did somebody else get it up-to-date? */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		goto success;
+	}
+
+	if (!mapping->a_ops->readpage(file, page)) {
+		wait_on_page_locked(page);
+		if (PageUptodate(page))
+			goto success;
+	}
+
+	/*
+	 * Umm, take care of errors if the page isn't up-to-date.
+	 * Try to re-read it _once_. We do this synchronously,
+	 * because there really aren't any performance issues here
+	 * and we need to check for errors.
+	 */
+	lock_page(page);
+
+	/* Somebody truncated the page on us? */
+	if (!page->mapping) {
+		unlock_page(page);
+		goto err;
+	}
+	/* Somebody else successfully read it in? */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		goto success;
+	}
+
+	ClearPageError(page);
+	if (!mapping->a_ops->readpage(file, page)) {
+		wait_on_page_locked(page);
+		if (PageUptodate(page))
+			goto success;
+	}
+
+	/*
+	 * Things didn't work out. Return zero to tell the
+	 * mm layer so, possibly freeing the page cache page first.
+	 */
+err:
+	page_cache_release(page);
+
+	return NULL;
+}
+
+static int filemap_populate(struct vm_area_struct *vma,
+			unsigned long addr,
+			unsigned long len,
+			unsigned long prot,
+			unsigned long pgoff,
+			int nonblock)
+{
+	struct file *file = vma->vm_file;
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct inode *inode = mapping->host;
+	unsigned long size;
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	int err;
+
+repeat:
+	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (pgoff + (len >> PAGE_CACHE_SHIFT) > size)
+		return -EINVAL;
+
+	page = filemap_getpage(file, pgoff, nonblock);
+	if (!page)
+		return -ENOMEM;
+	err = install_page(mm, vma, addr, page, prot);
+	if (err)
+		return err;
+
+	len -= PAGE_SIZE;
+	addr += PAGE_SIZE;
+	pgoff++;
+	if (len)
+		goto repeat;
+
+	return 0;
+}
+
 static struct vm_operations_struct generic_file_vm_ops = {
 	.nopage		= filemap_nopage,
+	.populate	= filemap_populate,
 };
 
 /* This is used for a general mmap of a disk file */

