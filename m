Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSJOPf0>; Tue, 15 Oct 2002 11:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSJOPf0>; Tue, 15 Oct 2002 11:35:26 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:7586 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264702AbSJOPfU>; Tue, 15 Oct 2002 11:35:20 -0400
Date: Tue, 15 Oct 2002 10:40:50 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 2.5.42-mm3] More shared page table fixes
Message-ID: <75990000.1034696450@baldur.austin.ibm.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1880309384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1880309384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


This patch gets the unmap_all_pages function right for PAE-enabled
machines.  It also adds a forgotten spinlock to pte_try_to_share.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1880309384==========
Content-Type: text/plain; charset=us-ascii; name="shpte-2.5.42-mm3-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shpte-2.5.42-mm3-1.diff"; size=5123

--- 2.5.42-mm3/./mm/memory.c	2002-10-15 09:59:37.000000000 -0500
+++ 2.5.42-mm3-shpte/./mm/memory.c	2002-10-15 10:18:15.000000000 -0500
@@ -372,6 +372,7 @@
 	struct vm_area_struct *lvma;
 	struct page *ptepage;
 	unsigned long base;
+	pte_t *pte = NULL;
 
 	/*
 	 * It already has a pte page.  No point in checking further.
@@ -394,6 +395,8 @@
 
 	as = vma->vm_file->f_dentry->d_inode->i_mapping;
 
+	spin_lock(&as->i_shared_lock);
+
 	list_for_each_entry(lvma, &as->i_mmap_shared, shared) {
 		pgd_t *lpgd;
 		pmd_t *lpmd;
@@ -431,9 +434,11 @@
 		else
 			pmdval = pmd_wrprotect(*lpmd);
 		set_pmd(pmd, pmdval);
-		return pte_page_map(ptepage, address);
+		pte = pte_page_map(ptepage, address);
+		break;
 	}
-	return NULL;
+	spin_unlock(&as->i_shared_lock);
+	return pte;
 }
 #endif
 
@@ -846,14 +851,16 @@
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		ptepage = pmd_page(*pmd);
-		pte_page_lock(ptepage);
+		if (pmd_present(*pmd)) {
+			ptepage = pmd_page(*pmd);
+			pte_page_lock(ptepage);
 #ifdef CONFIG_SHAREPTE
-		if (page_count(ptepage) > 1)
-			BUG();
+			if (page_count(ptepage) > 1)
+				BUG();
 #endif
-		zap_pte_range(tlb, pmd, address, end - address);
-		pte_page_unlock(ptepage);
+			zap_pte_range(tlb, pmd, address, end - address);
+			pte_page_unlock(ptepage);
+		}
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
 	} while (address < end);
@@ -938,72 +945,105 @@
 	mmu_gather_t *tlb;
 	pgd_t *pgd;
 	pmd_t *pmd;
-	unsigned long address;
-	unsigned long end;
+	unsigned long address = 0;
+	unsigned long vm_end = 0, prev_end, pmd_end;
 
 	tlb = tlb_gather_mmu(mm, 1);
 
 	vma = mm->mmap;
-	if (!vma)
-		goto out;
-
-	mm->map_count--;
-	if (is_vm_hugetlb_page(vma)) {
-		vma->vm_ops->close(vma);
-		goto next_vma;
-	}
-
-	address = vma->vm_start;
-	end = ((address + PGDIR_SIZE) & PGDIR_MASK);
+	for (;;) {
+		if (address >= vm_end) {
+			if (!vma)
+				goto out;
 
-	pgd = pgd_offset(mm, address);
-	pmd = pmd_offset(pgd, address);
-	do {
-		do {
-			if (pmd_none(*pmd))
-				goto skip_pmd;
-			if (pmd_bad(*pmd)) {
-				pmd_ERROR(*pmd);
-				pmd_clear(pmd);
-				goto skip_pmd;
-			}
-		
-			ptepage = pmd_page(*pmd);
-			pte_page_lock(ptepage);
-			if (page_count(ptepage) > 1) {
-				pmd_clear(pmd);
-				pgtable_remove_rmap_locked(ptepage, mm);
-				mm->rss -= ptepage->private;
-				put_page(ptepage);
-			} else {
-				zap_pte_range(tlb, pmd, address, end - address);
-			}
-			pte_page_unlock(ptepage);
-skip_pmd:
-			pmd++;
-			address = (address + PMD_SIZE) & PMD_MASK;
-			if (address >= vma->vm_end) {
+			address = vma->vm_start;
 next_vma:
-				vma = vma->vm_next;
-				if (!vma)
-					goto out;
-
-				mm->map_count--;
-				if (is_vm_hugetlb_page(vma)) {
+			prev_end = vm_end;
+			vm_end = vma->vm_end;
+			mm->map_count--;
+			/*
+			 * Advance the vma pointer to the next vma.
+			 * To facilitate coalescing adjacent vmas, the
+			 * pointer always points to the next one
+			 * beyond the range we're currently working
+			 * on, which means vma will be null on the
+			 * last iteration.
+			 */
+			vma = vma->vm_next;
+			if (vma) {
+				/*
+				 * Go ahead and include hugetlb vmas
+				 * in the range we process.  The pmd
+				 * entry will be cleared by close, so
+				 * we'll just skip over them.  This is
+				 * easier than trying to avoid them.
+				 */
+				if (is_vm_hugetlb_page(vma))
 					vma->vm_ops->close(vma);
+
+				/*
+				 * Coalesce adjacent vmas and process
+				 * them all in one iteration.
+				 */
+				if (vma->vm_start == prev_end) {
 					goto next_vma;
 				}
+			}
+		}
+		pgd = pgd_offset(mm, address);
+		do {
+			if (pgd_none(*pgd))
+				goto skip_pgd;
 
-				address = vma->vm_start;
-				end = ((address + PGDIR_SIZE) & PGDIR_MASK);
-				pgd = pgd_offset(mm, address);
-				pmd = pmd_offset(pgd, address);
+			if (pgd_bad(*pgd)) {
+				pgd_ERROR(*pgd);
+				pgd_clear(pgd);
+skip_pgd:
+				address += PGDIR_SIZE;
+				if (address > vm_end)
+					address = vm_end;
+				goto next_pgd;
 			}
-		} while (address < end);
-		pgd++;
-		pmd = pmd_offset(pgd, address);
-		end = ((address + PGDIR_SIZE) & PGDIR_MASK);
-	} while (vma);
+			pmd = pmd_offset(pgd, address);
+			if (vm_end > ((address + PGDIR_SIZE) & PGDIR_MASK))
+				pmd_end = (address + PGDIR_SIZE) & PGDIR_MASK;
+			else
+				pmd_end = vm_end;
+
+			for (;;) {
+				if (pmd_none(*pmd))
+					goto next_pmd;
+				if (pmd_bad(*pmd)) {
+					pmd_ERROR(*pmd);
+					pmd_clear(pmd);
+					goto next_pmd;
+				}
+				
+				ptepage = pmd_page(*pmd);
+				pte_page_lock(ptepage);
+				if (page_count(ptepage) > 1) {
+					pmd_clear(pmd);
+					pgtable_remove_rmap_locked(ptepage, mm);
+					mm->rss -= ptepage->private;
+					put_page(ptepage);
+				} else
+					zap_pte_range(tlb, pmd, address,
+						      vm_end - address);
+
+				pte_page_unlock(ptepage);
+next_pmd:
+				address += PMD_SIZE;
+				if (address >= pmd_end) {
+					address = pmd_end;
+					break;
+				}
+				pmd++;
+			}
+next_pgd:
+			pgd++;
+		} while (address < vm_end);
+
+	}
 
 out:
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);

--==========1880309384==========--

