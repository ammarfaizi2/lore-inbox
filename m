Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSDTSiD>; Sat, 20 Apr 2002 14:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSDTSiC>; Sat, 20 Apr 2002 14:38:02 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:36879 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S313083AbSDTSh4>;
	Sat, 20 Apr 2002 14:37:56 -0400
Date: Sat, 20 Apr 2002 19:37:50 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-kernel@vger.kernel.org
Subject: vmalloc comments patch
Message-ID: <Pine.LNX.4.44.0204201740480.3995-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.19pre7 is a first cut effort at commenting how
vmalloc does its work for allocation of pages that are not linear in
physical memory only in virtual memory. No code is changed, it's only
commentry.

I also have a more verbose document posted at
http://www.csn.ul.ie/~mel/projects/vm/docs/vmalloc.html along with a few
other docs at http://www.csn.ul.ie/~mel/projects/vm/ . They are fairly
rough at the moment and there is very few there but I'll be posting a lot
more there over time for those interested

			Mel

--- linux-2.4.19pre7.orig/mm/vmalloc.c	Mon Feb 25 19:38:14 2002
+++ linux-2.4.19pre7.mel/mm/vmalloc.c	Fri Apr 19 02:10:30 2002
@@ -16,100 +16,215 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>

+/* Allocation/Freeing of non-contiguous memory
+ *
+ * These are the functions for assigning a block of linear addresses for pages.
+ * To give a safety margin, the linear address starts about 8MB after the end
+ * of physical memory at VMALLOC_START. This is to try and catch memory
+ * overruns.
+ *
+ * Each area allocated is tracked by a struct vm_struct. There is a
+ * PAGE_SIZE'd gap between each area, also to try and prevent accidental memory
+ * overruns
+ */
+
 rwlock_t vmlist_lock = RW_LOCK_UNLOCKED;
 struct vm_struct * vmlist;

+/* free_area_pte
+ *
+ * This function is responsible for freeing all the page frames and their PTE's
+ * the given PMD is able to address
+ */
 static inline void free_area_pte(pmd_t * pmd, unsigned long address, unsigned long size)
 {
 	pte_t * pte;
 	unsigned long end;

+	/* If this PMD is already gone, return. This can happen if a vmalloc
+	 * earlier failed */
 	if (pmd_none(*pmd))
 		return;
+
+	/* A PMD can be bad if it's either read only or the accessed or dirty
+	 * bits are not cleared
+	 */
 	if (pmd_bad(*pmd)) {
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
 	}
+
+	/* Get the first PTE in this PMD for the address */
 	pte = pte_offset(pmd, address);
+
+	/* Treat the address as if it starts from 0 relative to the beginning
+	 * of the PMD*/
 	address &= ~PMD_MASK;
 	end = address + size;
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
+		/* If the PTE is already gone, move to the next one */
 		if (pte_none(page))
 			continue;
+
 		if (pte_present(page)) {
 			struct page *ptpage = pte_page(page);
+
+			/* QUERY: Is ignoring the PageReserved not a bug?
+			 *        Here, we just skip over the page and move
+			 *        along. The vm_struct will be later freed
+			 *        and the page will be efficively forgotton
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
+		/* If the page is not present, some muppet put it on a LRU
+		 * list and it got swapped out. We're in trouble
+		 */
 		printk(KERN_CRIT "Whee.. Swapped out page in kernel page table\n");
 	} while (address < end);
 }

+/* free_area_pmd
+ *
+ * For each entry in this PMD, try and free up the PTE's associated with it */
 static inline void free_area_pmd(pgd_t * dir, unsigned long address, unsigned long size)
 {
 	pmd_t * pmd;
 	unsigned long end;

+	/* If this PGD is already gone, return. This can happen if a vmalloc
+	 * earlier failed */
 	if (pgd_none(*dir))
 		return;
+
+	/* pgd_bad is a null-op for most architectures. In others (e.g. alpha),
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
+	/* Tread the address as if the first PTE was at 0 */
 	address &= ~PGDIR_MASK;
 	end = address + size;
+
+        /* If this free would need to go to the next PGD, make sure we
+	 * exit out at the end of this PGD
+	 */
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
+		/* Free the PTE's and page frames this PMD refers to */
 		free_area_pte(pmd, address, end - address);
+
+		/* Move to the next PMD making sure we are PMD aligned */
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
 }

+/* vmfree_area_pages
+ *
+ * This begins the steps through the page tables to free up all the page frames
+ * of the allocation
+ */
 void vmfree_area_pages(unsigned long address, unsigned long size)
 {
 	pgd_t * dir;
 	unsigned long end = address + size;

+	/* Get the first PGD */
 	dir = pgd_offset_k(address);
+
+	/* Flush the CPU cache so that refernces won't be made to the pages we
+	 * are about to clear */
 	flush_cache_all();
 	do {
+		/* Step into the PMD and begin trying to free the PTE's it
+		 * refers to
+		 */
 		free_area_pmd(dir, address, end - address);
+
+		/* Move to the next PGD making sure address is PGD aligned */
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
+
+	/* The TLB is now invalid as the page tables are differnet so flush */
 	flush_tlb_all();
 }

+/* alloc_area_pte - Allocate all the page frames necessary for the allocation
+ * pte - the PTE we are currently at
+ * address - Starts as the base address of the PTE
+ * size - The total size of the allocation
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
+		/* The page table is unlocked because we don't need to traverse
+		 * the page tables while a page is been allocated. As
+		 * alloc_page could block for a long time, let go the lock
+		 */
 		spin_unlock(&init_mm.page_table_lock);
 		page = alloc_page(gfp_mask);
 		spin_lock(&init_mm.page_table_lock);
+
+		/* QUERY: If this is true, it means someone allocated took this
+		 *        PTE in the middle of our address space when the lock
+		 *        was released. How could this happen and if it did, is
+		 *        it not a serious bug? As in, wouldn't a second
+		 *        process have to be trying to allocate a vm_struct
+		 *        that overlaps the one we are working on?
+		 */
 		if (!pte_none(*pte))
 			printk(KERN_ERR "alloc_area_pte: page already exists\n");
+
+		/* If out of memory, return back and free up the pages used so
+		 * far */
 		if (!page)
 			return -ENOMEM;
+
+		/* mark the PTE as used and move onto the next PTE to be
+		 * allocated */
 		set_pte(pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
@@ -117,107 +232,225 @@
 	return 0;
 }

+/* alloc_area_pmd - Allocate all the PTE's necessary for the allocation
+ * pmd - the PMD we are currently at
+ * address - Starts as the base address of the PMD
+ * size - The total size of the allocation
+ */
 static inline int alloc_area_pmd(pmd_t * pmd, unsigned long address, unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	unsigned long end;

+	/* This is a bit subtle
+	 * The PGD bits of the address are masked out so it's like the first
+	 * PMD is now at address 0 and end will be size. This way we know not
+	 * to go beyound the end of the PMD entry
+	 */
 	address &= ~PGDIR_MASK;
 	end = address + size;
+
+	/* If this allocation would need to go to the next PGD, make sure we
+	 * exit out at the end of this PGD
+	 */
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
+		/* Allocate a PTE and then try and assign the physical pages
+		 *
+		 * QUERY: Again, the return value will be ignored, was it
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

+/* vmalloc_area_pages - Allocates all the PMD's necessary
+ * @address - The beginning of the linear address
+ * @size - A page aligned size of the allocation
+ * @gfp_mask - The flags for this allocation
+ * @prot - Probably going to be PAGE_KERNEL
+ */
 inline int vmalloc_area_pages (unsigned long address, unsigned long size,
                                int gfp_mask, pgprot_t prot)
 {
 	pgd_t * dir;
+
+	/* size reaches the end of the linear address needed for this
+	 * allocation
+	 */
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
+		/* Return -ENOMEM if a PMD could not be allocated
+		 *
+		 * NOTE: Doesn't matter what vmalloc_area_pages actually
+		 *       returns as long as it's non-zero.
+		 */
 		ret = -ENOMEM;
 		if (!pmd)
 			break;

+		/* QUERY: Dead code? ret was set a few lines ago */
 		ret = -ENOMEM;
+
+		/* Allocate all the PTE's needed for this PMD and in turn
+		 * allocate the page frames
+		 */
 		if (alloc_area_pmd(pmd, address, end - address, gfp_mask, prot))
 			break;

+		/* Move the address onto the next PGD entry and make sure it is
+		 * PGD aligned
+		 */
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+
+		/* a pgd_t is essentially an array so dir++ moves to the next
+		 * PGD entry
+		 */
 		dir++;

 		ret = 0;
 	} while (address && (address < end));
 	spin_unlock(&init_mm.page_table_lock);
+
+	/* On some processors, it's necessary to flush the CPU cache. There
+	 * won't be TLB entries for any PTE's allocated so a tlb flush is
+	 * unnecessary
+	 */
 	flush_cache_all();
 	return ret;
 }

+/* get_vm_area - Get a vm_struct for the allocation
+ *
+ * This function is responsible for finding a linear address space large enough
+ * to accomodate the allocation
+ */
 struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
 {
 	unsigned long addr;
 	struct vm_struct **p, *tmp, *area;

+	/* Call the slab allocator to allocate space for the vm_struct we are
+	 * about to insert into the vmlist
+	 */
 	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
 	if (!area)
 		return NULL;
+
+	/* Pad out size so that there is a PAGE_SIZE gap between vm_structs */
 	size += PAGE_SIZE;
+
+	/* Start at VMALLOC_START and move forward. If no allocation has been
+	 * made yet, the first one will be at VMALLOC_START.
+	 *
+	 * QUERY: Doesn't this presume vmlist will be initialised as NULL?
+	 *        There doesn't appear to be a vmlist = NULL anywhere during
+	 *        startup.
+	 */
 	addr = VMALLOC_START;
 	write_lock(&vmlist_lock);
+
+	/* Cycle through the whole vmlist */
 	for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
+
+		/* Make sure we don't overflow over the end of the address
+		 * space */
 		if ((size + addr) < addr)
 			goto out;
+
+		/* If the gap we are at now would fit the allocation, break and
+		 * use it
+		 */
 		if (size + addr <= (unsigned long) tmp->addr)
 			break;
+
+		/* Move addr to the end of the current allocated block. Make
+		 * sure the address doesn't go beyond the end of VMALLOC_END
+		 */
 		addr = tmp->size + (unsigned long) tmp->addr;
 		if (addr > VMALLOC_END-size)
 			goto out;
 	}
+
+	/* A large enough area has been found so fill in the details of the
+	 * allocated area and insert it into the vmlist
+	 */
 	area->flags = flags;
 	area->addr = (void *)addr;
 	area->size = size;
 	area->next = *p;
 	*p = area;
+
 	write_unlock(&vmlist_lock);
 	return area;

 out:
+	/* Allocation failed, free vmlist and return the vm_struct back to the
+	 * slab allocator
+	 */
 	write_unlock(&vmlist_lock);
 	kfree(area);
 	return NULL;
 }

+/**
+ * vfree - Free an area of non-contiguous memory allocated by vmalloc
+ * addr - The base address to free
+ *
+ * This function takes the base address. It must be page aligned and the one
+ * returned by vmalloc earlier. It cycles through the vm_structs and ultimatly
+ * deallocate all the PMD's, PTE's and page frames previously allocated
+ */
 void vfree(void * addr)
 {
 	struct vm_struct **p, *tmp;

 	if (!addr)
 		return;
+
+	/* Check the address is page aligned. As all allocations had to be page
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
+			/* Area found so remove it from the vmlist. Lock is not
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
@@ -226,42 +459,94 @@
 	printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n", addr);
 }

+/**
+ * __vmalloc - Allocate a set of pages in non-contiguous memory
+ * size: size of allocation
+ * gfp_mask: The flags for the allocation. currently GFP_KERNEL | __GFP_HIGHMEM
+ * prot: PAGE_KERNEL to stop it been swapped out
+ *
+ * This does the real work of the allocation. Pages allocated will not be
+ * contiguous in physical memory, only in the linear address space. Do not
+ * call this function directly. Use vmalloc which will call with the correct
+ * flags and protection.
+ */
 void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot)
 {
 	void * addr;
 	struct vm_struct *area;

+	/* size has to be page aligned other bits of pages would be wasted */
 	size = PAGE_ALIGN(size);
+
+	/* If the size is 0 or the allocation is larger than the number of
+	 * physical frames, fail the allocation
+	 */
 	if (!size || (size >> PAGE_SHIFT) > num_physpages) {
 		BUG();
 		return NULL;
 	}
+
+	/* get_vm_area allocates a block of linear addresses that can fit
+	 * the allocation
+	 */
 	area = get_vm_area(size, VM_ALLOC);
 	if (!area)
 		return NULL;
 	addr = area->addr;
+
+	/* vmalloc_area_pages begins the work of allocating the PMD, PTE's
+	 * and finally the physical pages for the allocation
+	 */
 	if (vmalloc_area_pages(VMALLOC_VMADDR(addr), size, gfp_mask, prot)) {
+		/* If the allocation fails at any point, vfree will go through
+		 * the whole area and try and free up the entries that are now
+		 * no longer needed
+		 */
 		vfree(addr);
 		return NULL;
 	}
 	return addr;
 }

+/**
+ * vread - Read bytes from vmalloced memory like a char device
+ * @buf: Buffer to read into
+ * @addr: Starting address
+ * @count: Number of bytes to read
+ *
+ * This reads an area of vmalloced memory like a character device would. It
+ * does not have to read from a "valid" area. If the reader enters an area
+ * that is not in use, it will put 0's in the buf
+ */
 long vread(char *buf, char *addr, unsigned long count)
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
+	/* Cycle through the vmlist until we find the vm_struct closest to
+	 * or containing the address to read from
+	 */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
 		vaddr = (char *) tmp->addr;
+
+		/* If the address is beyond this vm_struct's vaddr minus it's
+		 * padding, then get the next struct
+		 */
 		if (addr >= vaddr + tmp->size - PAGE_SIZE)
 			continue;
+
+		/* If addr is before the vaddr, zero fill the buffer
+		 * until the vaddr is reached
+		 */
 		while (addr < vaddr) {
 			if (count == 0)
 				goto finished;
@@ -270,6 +555,11 @@
 			addr++;
 			count--;
 		}
+
+		/* n is the number of bytes that can be read from this
+		 * vm_struct before the end of it is reached. The while
+		 * exits when either n bytes or read or count finishes
+		 */
 		n = vaddr + tmp->size - PAGE_SIZE - addr;
 		do {
 			if (count == 0)
@@ -279,27 +569,62 @@
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
+ * vwrite - Write bytes from a buffer into vmalloced memory like a char device
+ * @buf: Buffer to read from
+ * @addr: Starting address to write to
+ * @count: Number of bytes to write
+ *
+ * This writes to a vmalloced area like a character device would. This works
+ * in a similar fashion to vread. The principle difference is that data that
+ * would write to an invalid area is simply silently dropped
+ */
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
+		/* If this is an invalid area, silently drop the bytes
+		 * what would be written
+		 */
 		while (addr < vaddr) {
 			if (count == 0)
 				goto finished;
@@ -307,6 +632,10 @@
 			addr++;
 			count--;
 		}
+
+		/* Reached a valid area, write n or count bytes depending
+		 * which gets to 0 first
+		 */
 		n = vaddr + tmp->size - PAGE_SIZE - addr;
 		do {
 			if (count == 0)




