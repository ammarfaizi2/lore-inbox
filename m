Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTJIKmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTJIKmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:42:38 -0400
Received: from zero.aec.at ([193.170.194.10]:62224 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261968AbTJIKmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:42:32 -0400
Date: Thu, 9 Oct 2003 12:42:18 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bos@serpentine.com
Subject: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009104218.GA1935@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The x86-64 ld.so always puts a PROT_NONE mapping into every 64bit process'
address space.

2a95791000-2a9586d000 ---p 00124000 03:01 788090                         /lib64/libc.so.6

This broke mlockall on x86-64 which ran into this mapping and always
returned an error and stopped early before mlocking everything.

This patch fixes mlockall to ignore errors for such mappings.

I added a new argument force==2 to get_user_pages that means to ignore
SIGBUS or unaccessible pages errors. MAY_* is still checked for like
with the old force ==1, it just doesn't error out now for SIGBUS
errors on handle_mm_fault. 

make_pages_present also has a new "tolerant" argument now that sets
force == 2. The patch sets it for mlockall and mmap (which didn't 
check its return arguments), but not for mlock(). Arguably it could
be not set for mmap on a VM_LOCKED vma.

-Andi

diff -u linux-test7-work/mm/memory.c-o linux-test7-work/mm/memory.c
--- linux-test7-work/mm/memory.c-o	2003-10-09 00:29:01.000000000 +0200
+++ linux-test7-work/mm/memory.c	2003-12-04 11:27:43.000000000 +0100
@@ -674,12 +674,15 @@
 
 static inline struct page *get_page_map(struct page *page)
 {
+	if (!page)
+		return 0;
 	if (!pfn_valid(page_to_pfn(page)))
 		return 0;
 	return page;
 }
 
 
+/* force == 2 means tolerate holes in the mapping */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -763,6 +766,10 @@
 					tsk->maj_flt++;
 					break;
 				case VM_FAULT_SIGBUS:
+					if (force == 2) { 
+						map = NULL;
+						break;
+					}
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
 					return i ? i : -ENOMEM;
@@ -770,19 +777,22 @@
 					BUG();
 				}
 				spin_lock(&mm->page_table_lock);
+				if (!map) 
+					break; 
 			}
 			if (pages) {
 				pages[i] = get_page_map(map);
-				if (!pages[i]) {
+				if (!pages[i] && force != 2) {
 					spin_unlock(&mm->page_table_lock);
 					while (i--)
 						page_cache_release(pages[i]);
 					i = -EFAULT;
 					goto out;
+				} else { 
+					flush_dcache_page(pages[i]);
+					if (!PageReserved(pages[i]))
+						page_cache_get(pages[i]);
 				}
-				flush_dcache_page(pages[i]);
-				if (!PageReserved(pages[i]))
-					page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -1655,7 +1665,7 @@
 	return pmd_offset(pgd, address);
 }
 
-int make_pages_present(unsigned long addr, unsigned long end)
+int make_pages_present(unsigned long addr, unsigned long end, int tolerant)
 {
 	int ret, len, write;
 	struct vm_area_struct * vma;
@@ -1668,7 +1678,7 @@
 		BUG();
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
 	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
+			len, write, tolerant ? 2 : 0, NULL, NULL);
 	if (ret < 0)
 		return ret;
 	return ret == len ? 0 : -1;
diff -u linux-test7-work/mm/mlock.c-o linux-test7-work/mm/mlock.c
--- linux-test7-work/mm/mlock.c-o	2003-09-28 10:53:25.000000000 +0200
+++ linux-test7-work/mm/mlock.c	2003-12-04 10:58:22.000000000 +0100
@@ -10,7 +10,8 @@
 
 
 static int mlock_fixup(struct vm_area_struct * vma, 
-	unsigned long start, unsigned long end, unsigned int newflags)
+	unsigned long start, unsigned long end, unsigned int newflags,
+	int tolerant)
 {
 	struct mm_struct * mm = vma->vm_mm;
 	int pages;
@@ -43,7 +44,7 @@
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
 		pages = -pages;
-		ret = make_pages_present(start, end);
+		ret = make_pages_present(start, end, tolerant);
 	}
 
 	vma->vm_mm->locked_vm -= pages;
@@ -79,13 +80,13 @@
 			newflags &= ~VM_LOCKED;
 
 		if (vma->vm_end >= end) {
-			error = mlock_fixup(vma, nstart, end, newflags);
+			error = mlock_fixup(vma, nstart, end, newflags, 0);
 			break;
 		}
 
 		tmp = vma->vm_end;
 		next = vma->vm_next;
-		error = mlock_fixup(vma, nstart, tmp, newflags);
+		error = mlock_fixup(vma, nstart, tmp, newflags, 0);
 		if (error)
 			break;
 		nstart = tmp;
@@ -154,7 +155,7 @@
 		newflags = vma->vm_flags | VM_LOCKED;
 		if (!(flags & MCL_CURRENT))
 			newflags &= ~VM_LOCKED;
-		error = mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
+		error = mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags, 1);
 		if (error)
 			break;
 	}
diff -u linux-test7-work/mm/mremap.c-o linux-test7-work/mm/mremap.c
--- linux-test7-work/mm/mremap.c-o	2003-09-11 04:12:42.000000000 +0200
+++ linux-test7-work/mm/mremap.c	2003-12-04 11:00:25.000000000 +0100
@@ -281,7 +281,7 @@
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
 			if (new_len > old_len)
 				make_pages_present(new_addr + old_len,
-						   new_addr + new_len);
+						   new_addr + new_len, 2);
 		}
 		return new_addr;
 	}
@@ -405,7 +405,7 @@
 			if (vma->vm_flags & VM_LOCKED) {
 				current->mm->locked_vm += pages;
 				make_pages_present(addr + old_len,
-						   addr + new_len);
+						   addr + new_len, 2);
 			}
 			ret = addr;
 			goto out;
diff -u linux-test7-work/mm/mmap.c-o linux-test7-work/mm/mmap.c
--- linux-test7-work/mm/mmap.c-o	2003-10-09 00:29:01.000000000 +0200
+++ linux-test7-work/mm/mmap.c	2003-12-04 11:02:17.000000000 +0100
@@ -655,7 +655,7 @@
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		make_pages_present(addr, addr + len, 2);
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
@@ -910,7 +910,7 @@
 	if (!prev || expand_stack(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED) {
-		make_pages_present(addr, prev->vm_end);
+		make_pages_present(addr, prev->vm_end, 2);
 	}
 	return prev;
 }
@@ -971,7 +971,7 @@
 	if (expand_stack(vma, addr))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED) {
-		make_pages_present(addr, start);
+		make_pages_present(addr, start, 2);
 	}
 	return vma;
 }
@@ -1345,7 +1345,7 @@
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		make_pages_present(addr, addr + len, 2);
 	}
 	return addr;
 }
diff -u linux-test7-work/include/linux/mm.h-o linux-test7-work/include/linux/mm.h
--- linux-test7-work/include/linux/mm.h-o	2003-10-09 00:29:00.000000000 +0200
+++ linux-test7-work/include/linux/mm.h	2003-12-04 11:00:25.000000000 +0100
@@ -433,7 +433,7 @@
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
-extern int make_pages_present(unsigned long addr, unsigned long end);
+extern int make_pages_present(unsigned long addr, unsigned long end, int tolerant);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 extern long sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
 extern long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);

