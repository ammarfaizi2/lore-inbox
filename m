Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSHFTbH>; Tue, 6 Aug 2002 15:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSHFTbE>; Tue, 6 Aug 2002 15:31:04 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:20492 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S315414AbSHFT3r>;
	Tue, 6 Aug 2002 15:29:47 -0400
Date: Tue, 6 Aug 2002 20:33:20 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/5] vmalloc commentry
Message-ID: <Pine.LNX.4.44.0208062018360.14917-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a commentry patch documenting more how vmalloc works.No code is
changed. Please apply

Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel


--- linux-2.4.19/mm/vmalloc.c	Mon Feb 25 19:38:14 2002
+++ linux-2.4.19-mel/mm/vmalloc.c	Tue Aug  6 16:20:50 2002
@@ -4,6 +4,19 @@
  *  Copyright (C) 1993  Linus Torvalds
  *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
  *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian <tigran@veritas.com>, May 2000
+ *
+ *
+ * Allocation/Freeing of non-contiguous memory
+ *
+ * These are the functions for assigning a block of linear addresses for pages.
+ * To give a safety margin, the linear address starts at VMALLOC_START.
+ * This is at PAGE_OFFSET + VMALLOC_OFFSET which are all arch dependent
+ * values
+ *
+ * Each area allocated is tracked by a struct vm_struct. There is a
+ * PAGE_SIZE'd gap between each area, also to try and prevent accidental memory
+ * overruns
+ *
  */

 #include <linux/config.h>
@@ -19,97 +32,208 @@
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
 struct vm_struct * vmlist;

+/**
+ *
+ * free_area_pte - Free pages and pte's from a PMD within a given address range
+ * @pmd: The PMD to free all pte's in
+ * @address: The starting address to free from
+ * @size: The range of entries to free
+ *
+ * This function is responsible for freeing all the page frames and their PTE's
+ * within a given address range in a PMD.
+ *
+ */
 static inline void free_area_pte(pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	pte_t * pte;
 	unsigned long end;

+	/* Will be none, if a vmalloc earlier failed */
 	if (pmd_none(*pmd))
 		return;
+
+	/*
+	 * A PMD can be bad if it's either read only or the accessed or dirty
+	 * bits are not cleared
+	 */
 	if (pmd_bad(*pmd)) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
 	}
+
 	pte = pte_offset(pmd, address);
+
+	/* Treat the address as an offset relative to the PMD */
 	address &= ~PMD_MASK;
 	end = address + size;
+
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
 		pte_t page;
+
+		/* Clear the PTE from the page tables and keep it here */
 		page = ptep_get_and_clear(pte);
+
+		/* Move onto the next PTE */
 		address += PAGE_SIZE;
 		pte++;
+
 		if (pte_none(page))
 			continue;
+
 		if (pte_present(page)) {
 			struct page *ptpage = pte_page(page);
+
+			/*
+			 * QUERY: Is ignoring the PageReserved not a bug?
+			 *        Here, we just skip over the page and move
+			 *        along. The vm_struct will be later freed
+			 *        and the page will be effectively forgotten
+			 *        about. What will free it?
+			 *
+			 *        Should it not be
+			 *
+			 *        if (PageReserved(ptpage)) BUG();
+			 *
+			 *        ?
+			 */
 			if (VALID_PAGE(ptpage) && (!PageReserved(ptpage)))
 				__free_page(ptpage);
 			continue;
 		}
+
+		/* Page got swapped out when it accidently got put on a LRU */
 		printk(KERN_CRIT "Whee.. Swapped out page in kernel page table\n");
 	} while (address < end);
 }

+/**
+ *
+ * free_area_pmd - Free PMD's from a PGD within a given address range
+ * @dir: The PGD to free from
+ * @address: The starting address
+ * @size: The range of entries to free
+ *
+ * For each entry in this PMD, try and free up the PTE's associated with it
+ */
 static inline void free_area_pmd(pgd_t * dir, unsigned long address, unsigned long size)
 {
 	pmd_t * pmd;
 	unsigned long end;

+	/* Will be none, if a vmalloc earlier failed */
 	if (pgd_none(*dir))
 		return;
+
+	/*
+	 * pgd_bad is a null-op for most architectures. In others (e.g. alpha),
+	 * it will make sure the PGD is not marked as a valid, dirty or
+	 * accessed page
+	 */
 	if (pgd_bad(*dir)) {
 		pgd_ERROR(*dir);
 		pgd_clear(dir);
 		return;
 	}
+
+	/* Get the first PMD */
 	pmd = pmd_offset(dir, address);
+
+	/* Treat address as an offset within this PMD */
 	address &= ~PGDIR_MASK;
 	end = address + size;
+
+        /* Don't overflow on this PGD */
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
 		free_area_pte(pmd, address, end - address);
+
+		/* Move to the next PMD making sure we are PMD aligned */
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 }

+/**
+ *
+ * vmfree_area_pages - Free all pages and ptes within an address range
+ * @address: The starting address
+ * @size: The range of pages to free
+ *
+ * This begins the steps through the page tables to free up all the page frames
+ * of the allocation. The caches are full so that the CPU doesn't accidently
+ * use the cache for a page that has been removed. The TLB is flushed as the
+ * page tables will be changed.
+ */
 void vmfree_area_pages(unsigned long address, unsigned long size)
 {
 	pgd_t * dir;
 	unsigned long end = address + size;

+	/* Get the first PGD */
 	dir = pgd_offset_k(address);
+
 	flush_cache_all();
 	do {
+		/*
+		 * Step into the PMD and begin trying to free the PTE's it
+		 * refers to
+		 */
 		free_area_pmd(dir, address, end - address);
+
+		/* Move to the next PGD making sure address is PGD aligned */
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
+
 	flush_tlb_all();
 }

+/**
+ *
+ * alloc_area_pte - Allocate all the page frames necessary for the allocation
+ * @pte: the PTE we are currently at
+ * @address: Starts as the base address of the PTE
+ * @size: The total size of the allocation
+ *
+ */
 static inline int alloc_area_pte (pte_t * pte, unsigned long address,
 			unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	unsigned long end;

+	/* Similar to alloc_area_pmd, see below */
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
+
 	do {
 		struct page * page;
+
+		/* Release lock as sleeping with a spinlock is a bug */
 		spin_unlock(&init_mm.page_table_lock);
 		page = alloc_page(gfp_mask);
 		spin_lock(&init_mm.page_table_lock);
+
+		/*
+		 * QUERY: If this is true, it means someone took this
+		 *        PTE in the middle of our address space when the lock
+		 *        was released. How could this happen and if it did, is
+		 *        it not a serious bug? As in, wouldn't a second
+		 *        process have to be trying to allocate a vm_struct
+		 *        that overlaps the one we are working on?
+		 */
 		if (!pte_none(*pte))
 			printk(KERN_ERR "alloc_area_pte: page already exists\n");
+
 		if (!page)
 			return -ENOMEM;
+
+		/* Mark used and move to the next PTE */
 		set_pte(pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
@@ -117,57 +241,106 @@
 	return 0;
 }

+/**
+ *
+ * alloc_area_pmd - Allocate all the PTE's necessary for the allocation
+ * @pmd: the PMD we are currently at
+ * @address: Starts as the base address of the PMD
+ * @size: The total size of the allocation
+ */
 static inline int alloc_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	unsigned long end;

+	/* Address becomes an offset within the PGD */
 	address &= ~PGDIR_MASK;
 	end = address + size;
+
+	/* Don't overflow on this PGD */
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
+		/*
+		 * fixme: The return value will be ignored, was it
+		 *        originally intended to pass this up to the higher
+		 *        caller functions?
+		 */
 		pte_t * pte = pte_alloc(&init_mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		if (alloc_area_pte(pte, address, end - address, gfp_mask, prot))
 			return -ENOMEM;
+
+		/* Move to the next PMD entry making sure we are PMD aligned */
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
+
 	return 0;
 }

+/**
+ *
+ * vmalloc_area_pages - Allocates all the PMD's necessary
+ * @address - The beginning of the linear address
+ * @size - A page aligned size of the allocation
+ * @gfp_mask - The flags for this allocation
+ * @prot - Probably going to be PAGE_KERNEL
+ *
+ * The cache is flushed at the end in case the page allocated accidently gets
+ * aliased by the cache. See Documentation/cachetlb.txt
+ */
 inline int vmalloc_area_pages (unsigned long address, unsigned long size,
                                int gfp_mask, pgprot_t prot)
 {
 	pgd_t * dir;
+
 	unsigned long end = address + size;
 	int ret;

+	/* The first PGD needed for this allocation */
 	dir = pgd_offset_k(address);
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;

+		/* Allocate a PMD for this PGD entry to point to */
 		pmd = pmd_alloc(&init_mm, dir, address);
+
+		/*
+		 * NOTE: Doesn't matter what vmalloc_area_pages actually
+		 *       returns as long as it's non-zero. Possible fixme
+		 */
 		ret = -ENOMEM;
 		if (!pmd)
 			break;

+		/* fixme: Dead code. ret was set a few lines ago */
 		ret = -ENOMEM;
+
 		if (alloc_area_pmd(pmd, address, end - address, gfp_mask, prot))
 			break;

+		/* Move to next PGD entry and make sure it is PGD aligned */
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;

 		ret = 0;
 	} while (address && (address < end));
 	spin_unlock(&init_mm.page_table_lock);
+
+	/* Flush cache if necessary. A no-op on many architectures */
 	flush_cache_all();
 	return ret;
 }

+/**
+ *
+ * get_vm_area - Get a vm_struct for the allocation
+ *
+ * This function is responsible for finding a linear address space large enough
+ * to accommodate the allocation
+ */
 struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
 {
 	unsigned long addr;
@@ -176,48 +349,94 @@
 	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
 	if (!area)
 		return NULL;
+
+	/* Pad out size so that there is a PAGE_SIZE gap between vm_structs */
 	size += PAGE_SIZE;
+
+	/*
+	 * Start at VMALLOC_START and move forward. If no allocation has been
+	 * made yet, the first one will be at VMALLOC_START.
+	 *
+	 * QUERY: Doesn't this presume vmlist will be initialised as NULL?
+	 *        There doesn't appear to be a vmlist = NULL anywhere during
+	 *        startup.
+	 */
 	addr = VMALLOC_START;
 	write_lock(&vmlist_lock);
+
 	for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
+
+		/* Don't overflow */
 		if ((size + addr) < addr)
 			goto out;
+
+		/* Break if the gap is large enough */
 		if (size + addr <= (unsigned long) tmp->addr)
 			break;
+
+		/* Move addr to the end of the current vm_struct */
 		addr = tmp->size + (unsigned long) tmp->addr;
 		if (addr > VMALLOC_END-size)
 			goto out;
 	}
+
+	/* Insert the new area */
 	area->flags = flags;
 	area->addr = (void *)addr;
 	area->size = size;
 	area->next = *p;
 	*p = area;
+
 	write_unlock(&vmlist_lock);
 	return area;

 out:
+	/* Allocation failed, clean up */
 	write_unlock(&vmlist_lock);
 	kfree(area);
 	return NULL;
 }

+/**
+ *
+ * vfree - Free an area of non-contiguous memory allocated by vmalloc
+ * @addr: The base address to free
+ *
+ * This function takes the base address. It must be page aligned and the one
+ * returned by vmalloc earlier. It cycles through the vm_structs and ultimately
+ * deallocate all the PMD's, PTE's and page frames previously allocated
+ **/
 void vfree(void * addr)
 {
 	struct vm_struct **p, *tmp;

 	if (!addr)
 		return;
+
+	/*
+	 * Check the address is page aligned. As all allocations had to be page
+	 * aligned, a non-page aligned vfree request has to be bogus
+	 */
 	if ((PAGE_SIZE-1) & (unsigned long) addr) {
 		printk(KERN_ERR "Trying to vfree() bad address (%p)\n", addr);
 		return;
 	}
+
+	/* Cycle through the vmlist looking for the right area */
 	write_lock(&vmlist_lock);
 	for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
+			/*
+			 * Area found so remove it from the vmlist. Lock is not
+			 * released now just in case another process realloced
+			 * the same area and started trying to alloc PTE's at
+			 * the same time we are freeing them
+			 */
 			*p = tmp->next;
 			vmfree_area_pages(VMALLOC_VMADDR(tmp->addr), tmp->size);
 			write_unlock(&vmlist_lock);
+
+			/* Free the vm_struct back to the slab allocator */
 			kfree(tmp);
 			return;
 		}
@@ -226,20 +445,43 @@
 	printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n", addr);
 }

+/**
+ *
+ * __vmalloc - Allocate a set of pages in non-contiguous memory
+ * @size: size of allocation
+ * @gfp_mask: The flags for the allocation. currently GFP_KERNEL | __GFP_HIGHMEM
+ * @prot: PAGE_KERNEL to stop it been swapped out
+ *
+ * This does the real work of the allocation. Pages allocated will not be
+ * contiguous in physical memory, only in the linear address space. Do not
+ * call this function directly. Use vmalloc which will call with the correct
+ * flags and protection.
+ **/
 void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	void * addr;
 	struct vm_struct *area;

+	/* size has to be page aligned other bits of pages would be wasted */
 	size = PAGE_ALIGN(size);
+
+	/* Can't alloc 0 bytes or more than available physical pages */
 	if (!size || (size >> PAGE_SHIFT) > num_physpages) {
 		BUG();
 		return NULL;
 	}
+
+	/* Find a large enough linear block in memory */
 	area = get_vm_area(size, VM_ALLOC);
 	if (!area)
 		return NULL;
 	addr = area->addr;
+
+	/*
+	 * vmalloc_area_pages begins the work of allocating the PMD, PTE's
+	 * and finally the physical pages for the allocation. vfree() will
+	 * clean up failed allocations
+	 */
 	if (vmalloc_area_pages(VMALLOC_VMADDR(addr), size, gfp_mask, prot)) {
 		vfree(addr);
 		return NULL;
@@ -247,21 +489,44 @@
 	return addr;
 }

+/**
+ *
+ * vread - Read bytes from vmalloced memory like a char device
+ * @buf: Buffer to read into
+ * @addr: Starting address
+ * @count: Number of bytes to read
+ *
+ * This reads an area of vmalloced memory like a character device would. It
+ * does not have to read from a "valid" area. If the reader enters an area
+ * that is not in use, it will put 0's in the buf
+ **/
 long vread(char *buf, char *addr, unsigned long count)
 {
 	struct vm_struct *tmp;
 	char *vaddr, *buf_start = buf;
 	unsigned long n;

-	/* Don't allow overflow */
+	/*
+	 * Don't allow overflow. If we would overflow, count equal to
+	 * -addr will read as much address space as possible
+	 */
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;

 	read_lock(&vmlist_lock);
+
+	/*
+	 * Cycle through the vmlist until we find the vm_struct closest to
+	 * or containing the address to read from
+	 */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		vaddr = (char *) tmp->addr;
+
+		/* Takes into account the PAGE_SIZE padding */
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
+
+		/* Zero fill if reading an invalid area */
 		while (addr < vaddr) {
 			if (count == 0)
 				goto finished;
@@ -270,6 +535,8 @@
 			addr++;
 			count--;
 		}
+
+		/* Read to the end of the area or read count number of bytes */
 		n = vaddr + tmp->size - PAGE_SIZE - addr;
 		do {
 			if (count == 0)
@@ -279,27 +546,61 @@
 			addr++;
 			count--;
 		} while (--n > 0);
+
 	}
+
+	/* QUERY: Lets say n bytes had been read and we had reached the
+	 *        end of the last vm_struct but count was still 100.
+	 *        These would not be zero filled possibly leaving in
+	 *        old data in a buffer. Is this a bug or is it
+	 *        considered that a person shouldn't be reading invalid
+	 *        areas anyway?
+	 *
+	 *        Solution would be to write in count number of 0's into the
+	 *        buffer ala
+	 *
+	 *        while (count--) *(buf++) = 0;
+	 *
+	 *        or something similar?
+	 */
+
 finished:
 	read_unlock(&vmlist_lock);
 	return buf - buf_start;
 }

+/**
+ *
+ * vwrite - Write bytes from a buffer into vmalloced memory like a char device
+ * @buf: Buffer to read from
+ * @addr: Starting address to write to
+ * @count: Number of bytes to write
+ *
+ * This writes to a vmalloced area like a character device would. This works
+ * in a similar fashion to vread. The principle difference is that data that
+ * would write to an invalid area is simply silently dropped
+ **/
 long vwrite(char *buf, char *addr, unsigned long count)
 {
 	struct vm_struct *tmp;
 	char *vaddr, *buf_start = buf;
 	unsigned long n;

-	/* Don't allow overflow */
+	/* Don't allow overflow. If we would overflow, count equal to
+	 * -addr will read as much address space as possible
+	 */
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;

 	read_lock(&vmlist_lock);
+
+	/* Cycle through vmlist like vread does */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		vaddr = (char *) tmp->addr;
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
+
+		/* If area is invalid, just silently drop the bytes */
 		while (addr < vaddr) {
 			if (count == 0)
 				goto finished;
@@ -307,6 +608,8 @@
 			addr++;
 			count--;
 		}
+
+		/* Valid area, write to end of area or count number of bytes */
 		n = vaddr + tmp->size - PAGE_SIZE - addr;
 		do {
 			if (count == 0)


