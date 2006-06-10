Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWFJBeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWFJBeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFJBeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:34:16 -0400
Received: from smtp-out.google.com ([216.239.45.12]:65382 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932295AbWFJBeP
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:34:15 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=buglcYt9NAUW/hGsQfqcLqehPOnlCHz0m6/wcifF1yW9X7sb2/oGSG6d/yMNFlxif
	oJefzouYFHi0k53DfkivQ==
Subject: [PATCH]: Adding a counter in vma to indicate the number of
	physical pages backing it
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-mm@kvack.org, Linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 09 Jun 2006 18:33:55 -0700
Message-Id: <1149903235.31417.84.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch that adds number of physical pages that each vma is
using in a process.  Exporting this information to user space
using /proc/<pid>/maps interface.

There is currently /proc/<pid>/smaps that prints the detailed
information about the usage of physical pages but that is a very
expensive operation as it traverses all the PTs (for some one who is
just interested in getting that data for each vma).


Signed-off-by: Rohit Seth <rohitseth@google.com>
 

 fs/exec.c          |    1 +
 fs/proc/task_mmu.c |    4 ++--
 include/linux/mm.h |    1 +
 mm/fremap.c        |    2 ++
 mm/hugetlb.c       |    3 +++
 mm/memory.c        |    5 +++++
 mm/migrate.c       |    1 +
 mm/rmap.c          |    2 ++
 mm/swapfile.c      |    1 +
 9 files changed, 18 insertions(+), 2 deletions(-)





--- linux-2.6.17-rc5-mm3.org/fs/exec.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/fs/exec.c	2006-06-05 15:56:42.000000000 -0700
@@ -326,6 +326,7 @@
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_new_anon_rmap(page, vma, address);
+	vma->nphys++;
 	pte_unmap_unlock(pte, ptl);
 
 	/* no need for flush_tlb */
--- linux-2.6.17-rc5-mm3.org/fs/proc/task_mmu.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/fs/proc/task_mmu.c	2006-06-06 14:23:48.000000000 -0700
@@ -145,14 +145,14 @@
 		ino = inode->i_ino;
 	}
 
-	seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
+	seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %08lu %02x:%02x %lu %n",
 			vma->vm_start,
 			vma->vm_end,
 			flags & VM_READ ? 'r' : '-',
 			flags & VM_WRITE ? 'w' : '-',
 			flags & VM_EXEC ? 'x' : '-',
 			flags & VM_MAYSHARE ? 's' : 'p',
-			vma->vm_pgoff << PAGE_SHIFT,
+			vma->vm_pgoff << PAGE_SHIFT, vma->nphys,
 			MAJOR(dev), MINOR(dev), ino, &len);
 
 	/*
--- linux-2.6.17-rc5-mm3.org/include/linux/mm.h	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/include/linux/mm.h	2006-06-05 16:27:05.000000000 -0700
@@ -111,6 +111,7 @@
 #ifdef CONFIG_NUMA
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
+	unsigned long 	nphys;		/* Num phys pages backing this vma */
 };
 
 /*
--- linux-2.6.17-rc5-mm3.org/mm/migrate.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/mm/migrate.c	2006-06-09 17:17:31.000000000 -0700
@@ -181,6 +181,7 @@
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, pte);
 	lazy_mmu_prot_update(pte);
+	vma->nphys++;
 
 out:
 	pte_unmap_unlock(ptep, ptl);
--- linux-2.6.17-rc5-mm3.org/mm/swapfile.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/mm/swapfile.c	2006-06-09 17:24:24.000000000 -0700
@@ -500,6 +500,7 @@
 	 * immediately swapped out again after swapon.
 	 */
 	activate_page(page);
+	vma->nphys++;
 }
 
 static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
--- linux-2.6.17-rc5-mm3.org/mm/rmap.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/mm/rmap.c	2006-06-09 17:22:59.000000000 -0700
@@ -620,6 +620,7 @@
 		dec_mm_counter(mm, file_rss);
 
 
+	vma->nphys--;
 	page_remove_rmap(page);
 	page_cache_release(page);
 
@@ -710,6 +711,7 @@
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
+		vma->nphys--;
 		page_remove_rmap(page);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
--- linux-2.6.17-rc5-mm3.org/mm/memory.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/mm/memory.c	2006-06-05 15:57:16.000000000 -0700
@@ -677,6 +677,7 @@
 					mark_page_accessed(page);
 				file_rss--;
 			}
+			vma->nphys--;
 			page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
 			continue;
@@ -2001,6 +2002,7 @@
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, pte);
 	lazy_mmu_prot_update(pte);
+	vma->nphys++;
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 out:
@@ -2063,6 +2065,7 @@
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
+	vma->nphys++;
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	return VM_FAULT_MINOR;
@@ -2201,6 +2204,7 @@
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
+	vma->nphys++;
 unlock:
 	pte_unmap_unlock(page_table, ptl);
 	return ret;
@@ -2480,6 +2484,7 @@
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_page_prot = PAGE_READONLY;
 	gate_vma.vm_flags = 0;
+	gate_vma.nphys = 1;
 	return 0;
 }
 __initcall(gate_vma_init);
--- linux-2.6.17-rc5-mm3.org/mm/fremap.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/mm/fremap.c	2006-06-08 15:00:11.000000000 -0700
@@ -35,6 +35,7 @@
 				set_page_dirty(page);
 			page_remove_rmap(page);
 			page_cache_release(page);
+			vma->nphys--;
 		}
 	} else {
 		if (!pte_file(pte))
@@ -84,6 +85,7 @@
 	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
 	lazy_mmu_prot_update(pte_val);
+	vma->nphys++;
 	err = 0;
 unlock:
 	pte_unmap_unlock(pte, ptl);
--- linux-2.6.17-rc5-mm3.org/mm/hugetlb.c	2006-06-05 11:08:40.000000000 -0700
+++ linux-2.6.17-rc5-mm3/mm/hugetlb.c	2006-06-09 18:23:56.000000000 -0700
@@ -346,6 +346,7 @@
 			get_page(ptepage);
 			add_mm_counter(dst, file_rss, HPAGE_SIZE / PAGE_SIZE);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
+			vma->nphys += (HPAGE_SIZE / PAGE_SIZE);
 		}
 		spin_unlock(&src->page_table_lock);
 		spin_unlock(&dst->page_table_lock);
@@ -386,6 +387,7 @@
 		page = pte_page(pte);
 		put_page(page);
 		add_mm_counter(mm, file_rss, (int) -(HPAGE_SIZE / PAGE_SIZE));
+		vma->nphys -= (HPAGE_SIZE / PAGE_SIZE);
 	}
 
 	spin_unlock(&mm->page_table_lock);
@@ -493,6 +495,7 @@
 				&& (vma->vm_flags & VM_SHARED)));
 	set_huge_pte_at(mm, address, ptep, new_pte);
 
+	vma->nphys += (HPAGE_SIZE / PAGE_SIZE);
 	if (write_access && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
 		ret = hugetlb_cow(mm, vma, address, ptep, new_pte);


