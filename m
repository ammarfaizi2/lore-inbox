Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276309AbRI1U5X>; Fri, 28 Sep 2001 16:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276310AbRI1U5P>; Fri, 28 Sep 2001 16:57:15 -0400
Received: from colorfullife.com ([216.156.138.34]:6408 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276309AbRI1U5G>;
	Fri, 28 Sep 2001 16:57:06 -0400
Message-ID: <3BB4E434.240F6D68@colorfullife.com>
Date: Fri, 28 Sep 2001 22:57:24 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] new single copy pipe version
Content-Type: multipart/mixed;
 boundary="------------395F5A365060E2AAE4067094"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------395F5A365060E2AAE4067094
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I found 2 bugs in my previous single copy pipe version:

* Could deadlock on the mmap_semaphore with multithreaded apps.
* It doesn't follow the atomicity requirements with blocking transfers
if a signal arrives. SuS isn't 100% clear, but FreeBSD and Tru64
guarantee it.

I've uploaded the new patches to
http://www.colorfullife.com/~manfred/linux-2.5/kiopipe/

* patch-pgw: enum_user_pages - helper function for getting 'struct
page*' from virtual addresses, and use it for access_process_vm and
map_user_kiobuf.
	net 62 lines removed ;-)
* patch-kiopipe: actual single copy pipe, not tuned. based on patch-pgw.
* patch-expand: unrelated.

Unfortunately kiopipe is visible to broken user space aps.
(run test5.cpp - it stalls with kiopipe, but finishes on all other Unix
versions I tested)

patch-pgw is attached - it simplifies access_process_vm and
map_user_kiobuf.
I'd apreciate any comments.

--
	Manfred
--------------395F5A365060E2AAE4067094
Content-Type: text/plain; charset=us-ascii;
 name="patch-pgw"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pgw"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 10
//  EXTRAVERSION =
--- 2.4/include/linux/mm.h	Sun Sep 23 21:20:54 2001
+++ build-2.4/include/linux/mm.h	Fri Sep 28 19:00:56 2001
@@ -431,6 +431,9 @@
 extern int ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 
+int enum_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
+		unsigned int len, int write, struct page **pages, struct vm_area_struct **vmas);
+
 /*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc() that does all
diff -ur 2.4/mm/memory.c build-2.4/mm/memory.c
--- 2.4/mm/memory.c	Sun Sep 23 21:20:55 2001
+++ build-2.4/mm/memory.c	Fri Sep 28 20:31:20 2001
@@ -402,17 +402,16 @@
 	spin_unlock(&mm->page_table_lock);
 }
 
-
 /*
  * Do a quick page-table lookup for a single page. 
  */
-static struct page * follow_page(unsigned long address, int write) 
+static struct page * follow_page(struct mm_struct *mm, unsigned long address, int write) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
 
-	pgd = pgd_offset(current->mm, address);
+	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || pgd_bad(*pgd))
 		goto out;
 
@@ -448,21 +447,72 @@
 	return page;
 }
 
+int enum_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
+		unsigned int len, int write, struct page **pages, struct vm_area_struct **vmas)
+{
+	int i = 0;
+	do {
+		struct vm_area_struct *	vma;
+
+		vma = find_extend_vma(mm, start);
+		if (!vma) {
+			if (i) return i;
+			return -EFAULT;
+		}
+		if (write && (!(vma->vm_flags & VM_WRITE))) {
+			if (i) return i;
+			return -EFAULT;
+		} else if (!(vma->vm_flags & VM_READ)) {
+			if (i) return i;
+			return -EFAULT;
+		}
+
+		spin_lock(&mm->page_table_lock);
+		do {
+			struct page *map;
+			while (!(map = follow_page(mm, start, write))) {
+				spin_unlock(&mm->page_table_lock);
+				switch (handle_mm_fault(mm, vma, start, write)) {
+				case 1:
+					tsk->min_flt++;
+					break;
+				case 2:
+					tsk->maj_flt++;
+					break;
+				case 0:
+					if (i) return i;
+					return -EFAULT;
+				default:
+					if (i) return i;
+					return -ENOMEM;
+				}
+				spin_lock(&mm->page_table_lock);
+			}
+			if (pages) {
+				pages[i] = get_page_map(map);
+				if (pages[i]) get_page(pages[i]);
+			}
+			if (vmas)
+				vmas[i] = vma;
+			i++;
+			start += PAGE_SIZE;
+			len--;
+		} while(len && start < vma->vm_end);
+		spin_unlock(&mm->page_table_lock);
+	} while(len);
+	return i;
+}
+
 /*
  * Force in an entire range of pages from the current process's user VA,
  * and pin them in physical memory.  
  */
-
 #define dprintk(x...)
+
 int map_user_kiobuf(int rw, struct kiobuf *iobuf, unsigned long va, size_t len)
 {
-	unsigned long		ptr, end;
-	int			err;
+	int pgcount, err;
 	struct mm_struct *	mm;
-	struct vm_area_struct *	vma = 0;
-	struct page *		map;
-	int			i;
-	int			datain = (rw == READ);
 	
 	/* Make sure the iobuf is not already mapped somewhere. */
 	if (iobuf->nr_pages)
@@ -471,79 +521,39 @@
 	mm = current->mm;
 	dprintk ("map_user_kiobuf: begin\n");
 	
-	ptr = va & PAGE_MASK;
-	end = (va + len + PAGE_SIZE - 1) & PAGE_MASK;
-	err = expand_kiobuf(iobuf, (end - ptr) >> PAGE_SHIFT);
+	pgcount = (va + len + PAGE_SIZE - 1)/PAGE_SIZE - va/PAGE_SIZE;
+	/* mapping 0 bytes is not permitted */
+	if (!pgcount) BUG();
+	err = expand_kiobuf(iobuf, pgcount);
 	if (err)
 		return err;
 
-	down_read(&mm->mmap_sem);
-
-	err = -EFAULT;
 	iobuf->locked = 0;
 	iobuf->offset = va & ~PAGE_MASK;
 	iobuf->length = len;
 	
-	i = 0;
-	
 	/* 
-	 * First of all, try to fault in all of the necessary pages
+	 * Try to fault in all of the necessary pages
 	 */
-	while (ptr < end) {
-		if (!vma || ptr >= vma->vm_end) {
-			vma = find_vma(current->mm, ptr);
-			if (!vma) 
-				goto out_unlock;
-			if (vma->vm_start > ptr) {
-				if (!(vma->vm_flags & VM_GROWSDOWN))
-					goto out_unlock;
-				if (expand_stack(vma, ptr))
-					goto out_unlock;
-			}
-			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
-					(!(vma->vm_flags & VM_READ))) {
-				err = -EACCES;
-				goto out_unlock;
-			}
-		}
-		spin_lock(&mm->page_table_lock);
-		while (!(map = follow_page(ptr, datain))) {
-			int ret;
-
-			spin_unlock(&mm->page_table_lock);
-			ret = handle_mm_fault(current->mm, vma, ptr, datain);
-			if (ret <= 0) {
-				if (!ret)
-					goto out_unlock;
-				else {
-					err = -ENOMEM;
-					goto out_unlock;
-				}
-			}
-			spin_lock(&mm->page_table_lock);
-		}			
-		map = get_page_map(map);
-		if (map) {
-			flush_dcache_page(map);
-			atomic_inc(&map->count);
-		} else
-			printk (KERN_INFO "Mapped page missing [%d]\n", i);
-		spin_unlock(&mm->page_table_lock);
-		iobuf->maplist[i] = map;
-		iobuf->nr_pages = ++i;
-		
-		ptr += PAGE_SIZE;
-	}
-
+	down_read(&mm->mmap_sem);
+	/* rw==READ means read from disk, write into memory area */
+	err = enum_user_pages(current, mm, va & ~PAGE_MASK, pgcount,
+			(rw==READ), iobuf->maplist, NULL);
 	up_read(&mm->mmap_sem);
+	
+	if (err) {
+		unmap_kiobuf(iobuf);
+		dprintk ("map_user_kiobuf: end %d\n", err);
+		return err;
+	}
+	do {
+		/* FIXME: flush superflous for rw==READ,
+		 * probably wrong function for rw==WRITE
+		 */
+		flush_dcache_page(iobuf->maplist[--pgcount]);
+	} while(pgcount);
 	dprintk ("map_user_kiobuf: end OK\n");
 	return 0;
-
- out_unlock:
-	up_read(&mm->mmap_sem);
-	unmap_kiobuf(iobuf);
-	dprintk ("map_user_kiobuf: end %d\n", err);
-	return err;
 }
 
 /*
@@ -593,6 +603,7 @@
 		if (map) {
 			if (iobuf->locked)
 				UnlockPage(map);
+			/* FIXME: cache flush missing for rw==READ*/
 			__free_page(map);
 		}
 	}
@@ -1433,23 +1444,23 @@
 	return pte_offset(pmd, address);
 }
 
-/*
- * Simplistic page force-in..
- */
 int make_pages_present(unsigned long addr, unsigned long end)
 {
-	int write;
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct * vma;
-
-	vma = find_vma(mm, addr);
-	write = (vma->vm_flags & VM_WRITE) != 0;
-	if (addr >= end)
-		BUG();
-	do {
-		if (handle_mm_fault(mm, vma, addr, write) < 0)
-			return -1;
-		addr += PAGE_SIZE;
-	} while (addr < end);
+	int ret;
+	int write = 0;
+	{
+		struct vm_area_struct * vma;
+		vma = find_vma(current->mm, addr);
+		write = (vma->vm_flags & VM_WRITE) != 0;
+		if (addr >= end)
+			BUG();
+		if (end > vma->vm_end)
+			BUG();
+	}
+	ret = enum_user_pages(current, current->mm, addr,
+			(end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE,
+			write, NULL, NULL);
+	if (ret < 0)
+		return -1;
 	return 0;
 }
diff -ur 2.4/kernel/ptrace.c build-2.4/kernel/ptrace.c
--- 2.4/kernel/ptrace.c	Sun Sep 23 21:20:55 2001
+++ build-2.4/kernel/ptrace.c	Fri Sep 28 19:09:42 2001
@@ -85,119 +85,17 @@
 }
 
 /*
- * Access another process' address space, one page at a time.
+ * Access another process' address space.
+ * Source/target buffer must be kernel space, 
+ * Do not walk the page table directly, use enum_user_pages
  */
-static int access_one_page(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
-{
-	pgd_t * pgdir;
-	pmd_t * pgmiddle;
-	pte_t * pgtable;
-	char *maddr; 
-	struct page *page;
-
-repeat:
-	spin_lock(&mm->page_table_lock);
-	pgdir = pgd_offset(vma->vm_mm, addr);
-	if (pgd_none(*pgdir))
-		goto fault_in_page;
-	if (pgd_bad(*pgdir))
-		goto bad_pgd;
-	pgmiddle = pmd_offset(pgdir, addr);
-	if (pmd_none(*pgmiddle))
-		goto fault_in_page;
-	if (pmd_bad(*pgmiddle))
-		goto bad_pmd;
-	pgtable = pte_offset(pgmiddle, addr);
-	if (!pte_present(*pgtable))
-		goto fault_in_page;
-	if (write && (!pte_write(*pgtable) || !pte_dirty(*pgtable)))
-		goto fault_in_page;
-	page = pte_page(*pgtable);
-
-	/* ZERO_PAGE is special: reads from it are ok even though it's marked reserved */
-	if (page != ZERO_PAGE(addr) || write) {
-		if ((!VALID_PAGE(page)) || PageReserved(page)) {
-			spin_unlock(&mm->page_table_lock);
-			return 0;
-		}
-	}
-	get_page(page);
-	spin_unlock(&mm->page_table_lock);
-	flush_cache_page(vma, addr);
-
-	if (write) {
-		maddr = kmap(page);
-		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
-		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
-		kunmap(page);
-	} else {
-		maddr = kmap(page);
-		memcpy(buf, maddr + (addr & ~PAGE_MASK), len);
-		flush_page_to_ram(page);
-		kunmap(page);
-	}
-	put_page(page);
-	return len;
-
-fault_in_page:
-	spin_unlock(&mm->page_table_lock);
-	/* -1: out of memory. 0 - unmapped page */
-	if (handle_mm_fault(mm, vma, addr, write) > 0)
-		goto repeat;
-	return 0;
-
-bad_pgd:
-	spin_unlock(&mm->page_table_lock);
-	pgd_ERROR(*pgdir);
-	return 0;
-
-bad_pmd:
-	spin_unlock(&mm->page_table_lock);
-	pmd_ERROR(*pgmiddle);
-	return 0;
-}
-
-static int access_mm(struct mm_struct *mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
-{
-	int copied = 0;
-
-	for (;;) {
-		unsigned long offset = addr & ~PAGE_MASK;
-		int this_len = PAGE_SIZE - offset;
-		int retval;
-
-		if (this_len > len)
-			this_len = len;
-		retval = access_one_page(mm, vma, addr, buf, this_len, write);
-		copied += retval;
-		if (retval != this_len)
-			break;
-
-		len -= retval;
-		if (!len)
-			break;
-
-		addr += retval;
-		buf += retval;
-
-		if (addr < vma->vm_end)
-			continue;	
-		if (!vma->vm_next)
-			break;
-		if (vma->vm_next->vm_start != vma->vm_end)
-			break;
-	
-		vma = vma->vm_next;
-	}
-	return copied;
-}
 
 int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
 {
-	int copied;
 	struct mm_struct *mm;
-	struct vm_area_struct * vma;
+	struct vm_area_struct *vma;
+	struct page *page;
+	int old_buf = buf;
 
 	/* Worry about races with exit() */
 	task_lock(tsk);
@@ -209,14 +107,40 @@
 		return 0;
 
 	down_read(&mm->mmap_sem);
-	vma = find_extend_vma(mm, addr);
-	copied = 0;
-	if (vma)
-		copied = access_mm(mm, vma, addr, buf, len, write);
+	/* ignore errors, just check how much was sucessfully transfered */
+	while (len) {
+		int bytes, ret, offset;
+		void *maddr;
 
+		ret = enum_user_pages(current, mm, addr, 1, write, &page, &vma);
+		if (!ret)
+			break;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE-1);
+		if (bytes > PAGE_SIZE-offset)
+			bytes = PAGE_SIZE-offset;
+
+		flush_cache_page(vma, addr);
+
+		maddr = kmap(page);
+		if (write) {
+			memcpy(maddr + offset, buf, bytes);
+			flush_page_to_ram(page);
+			flush_icache_page(vma, page);
+		} else {
+			memcpy(buf, maddr + offset, bytes);
+			flush_page_to_ram(page);
+		}
+		kunmap(page);
+		put_page(page);
+		len -= bytes;
+		buf += bytes;
+	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);
-	return copied;
+	
+	return buf - old_buf;
 }
 
 int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len)


--------------395F5A365060E2AAE4067094--


