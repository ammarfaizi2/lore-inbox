Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265062AbSJOWtI>; Tue, 15 Oct 2002 18:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSJOWZf>; Tue, 15 Oct 2002 18:25:35 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:34671 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264899AbSJOWQl>; Tue, 15 Oct 2002 18:16:41 -0400
Date: Tue, 15 Oct 2002 17:22:13 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 2.5.42-mm3] Fix unmap_page_range again for shared page
 tables
Message-ID: <274410000.1034720533@baldur.austin.ibm.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========2232157794=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========2232157794==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


My previous attempt at getting unmap_page_range right had a bad race
condition.  Here's a patch that should resolve it correctly.

This patch applies on top of the patch I sent earlier in the day.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========2232157794==========
Content-Type: text/plain; charset=iso-8859-1; name="shpte-2.5.42-mm3-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shpte-2.5.42-mm3-2.diff"; size=5804

--- 2.5.42-mm3-shsent/./mm/mmap.c	2002-10-15 09:59:37.000000000 -0500
+++ 2.5.42-mm3-shpte/./mm/mmap.c	2002-10-15 14:02:17.000000000 -0500
@@ -23,7 +23,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
=20
-extern void unmap_page_range(mmu_gather_t *,struct vm_area_struct *vma, =
unsigned long address, unsigned long size);
+extern void unmap_page_range(mmu_gather_t **,struct vm_area_struct *vma, =
unsigned long address, unsigned long size);
 #ifdef CONFIG_SHAREPTE
 extern void unmap_shared_range(struct mm_struct *mm, unsigned long =
address, unsigned long end);
 #endif
@@ -994,10 +994,6 @@
 {
 	mmu_gather_t *tlb;
=20
-#ifdef CONFIG_SHAREPTE
-	/* Make sure all the pte pages in the range are unshared if necessary */
-	unmap_shared_range(mm, start, end);
-#endif
 	tlb =3D tlb_gather_mmu(mm, 0);
=20
 	do {
@@ -1006,7 +1002,7 @@
 		from =3D start < mpnt->vm_start ? mpnt->vm_start : start;
 		to =3D end > mpnt->vm_end ? mpnt->vm_end : end;
=20
-		unmap_page_range(tlb, mpnt, from, to);
+		unmap_page_range(&tlb, mpnt, from, to);
=20
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			len =3D to - from;
--- 2.5.42-mm3-shsent/./mm/memory.c	2002-10-15 14:11:54.000000000 -0500
+++ 2.5.42-mm3-shpte/./mm/memory.c	2002-10-15 14:01:46.000000000 -0500
@@ -720,82 +720,11 @@
 }
 #endif
=20
-#ifdef CONFIG_SHAREPTE
-static inline void unmap_shared_pmd(struct mm_struct *mm, pgd_t *pgd,
-				    unsigned long address, unsigned long end)
-{
-	struct page *ptepage;
-	pmd_t * pmd;
-
-	if (pgd_none(*pgd))
-		return;
-	if (pgd_bad(*pgd)) {
-		pgd_ERROR(*pgd);
-		pgd_clear(pgd);
-		return;
-	}
-	pmd =3D pmd_offset(pgd, address);
-	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
-		end =3D ((address + PGDIR_SIZE) & PGDIR_MASK);
-	do {
-		if (pmd_none(*pmd))
-			goto skip_pmd;
-		if (pmd_bad(*pmd)) {
-			pmd_ERROR(*pmd);
-			pmd_clear(pmd);
-			goto skip_pmd;
-		}
-
-		ptepage =3D pmd_page(*pmd);
-		pte_page_lock(ptepage);
-
-		if (page_count(ptepage) > 1) {
-			if ((address <=3D ptepage->index) &&
-			    (end >=3D (ptepage->index + PMD_SIZE))) {
-				pmd_clear(pmd);
-				pgtable_remove_rmap_locked(ptepage, mm);
-				mm->rss -=3D ptepage->private;
-				put_page(ptepage);
-			} else {
-				pte_unshare(mm, pmd, address);
-				ptepage =3D pmd_page(*pmd);
-			}
-		}
-		pte_page_unlock(ptepage);
-skip_pmd:
-		address =3D (address + PMD_SIZE) & PMD_MASK;=20
-		pmd++;
-	} while (address < end);
-}
-
-void unmap_shared_range(struct mm_struct *mm, unsigned long address, =
unsigned long end)
-{
-	pgd_t * pgd;
-
-	if (address >=3D end)
-		BUG();
-	pgd =3D pgd_offset(mm, address);
-	do {
-		unmap_shared_pmd(mm, pgd, address, end - address);
-		address =3D (address + PGDIR_SIZE) & PGDIR_MASK;
-		pgd++;
-	} while (address && (address < end));
-}
-#endif
-
 static void zap_pte_range(mmu_gather_t *tlb, pmd_t * pmd, unsigned long =
address, unsigned long size)
 {
 	unsigned long offset;
 	pte_t *ptep;
=20
-	if (pmd_none(*pmd))
-		return;
-	if (pmd_bad(*pmd)) {
-		pmd_ERROR(*pmd);
-		pmd_clear(pmd);
-		return;
-	}
-
 	offset =3D address & ~PMD_MASK;
 	if (offset + size > PMD_SIZE)
 		size =3D PMD_SIZE - offset;
@@ -833,9 +762,10 @@
 	pte_unmap(ptep-1);
 }
=20
-static void zap_pmd_range(mmu_gather_t *tlb, pgd_t * dir, unsigned long =
address, unsigned long size)
+static void zap_pmd_range(mmu_gather_t **tlb, pgd_t * dir, unsigned long =
address, unsigned long size)
 {
 	struct page *ptepage;
+	struct mm_struct *mm =3D (*tlb)->mm;
 	pmd_t * pmd;
 	unsigned long end;
=20
@@ -851,35 +781,56 @@
 	if (end > ((address + PGDIR_SIZE) & PGDIR_MASK))
 		end =3D ((address + PGDIR_SIZE) & PGDIR_MASK);
 	do {
-		if (pmd_present(*pmd)) {
-			ptepage =3D pmd_page(*pmd);
-			pte_page_lock(ptepage);
+		if (pmd_none(*pmd))
+			goto skip_pmd;
+		if (pmd_bad(*pmd)) {
+			pmd_ERROR(*pmd);
+			pmd_clear(pmd);
+			goto skip_pmd;
+		}
+
+		ptepage =3D pmd_page(*pmd);
+		pte_page_lock(ptepage);
 #ifdef CONFIG_SHAREPTE
-			if (page_count(ptepage) > 1)
-				BUG();
-#endif
-			zap_pte_range(tlb, pmd, address, end - address);
-			pte_page_unlock(ptepage);
+		if (page_count(ptepage) > 1) {
+			if ((address <=3D ptepage->index) &&
+			    (end >=3D (ptepage->index + PMD_SIZE))) {
+				pmd_clear(pmd);
+				pgtable_remove_rmap_locked(ptepage, mm);
+				mm->rss -=3D ptepage->private;
+				put_page(ptepage);
+				goto unlock_pte;
+			} else {
+				tlb_finish_mmu(*tlb, address, end);
+				pte_unshare(mm, pmd, address);
+				*tlb =3D tlb_gather_mmu(mm, 0);
+				ptepage =3D pmd_page(*pmd);
+			}
 		}
+#endif
+		zap_pte_range(*tlb, pmd, address, end - address);
+unlock_pte:
+		pte_page_unlock(ptepage);
+skip_pmd:
 		address =3D (address + PMD_SIZE) & PMD_MASK;=20
 		pmd++;
 	} while (address < end);
 }
=20
-void unmap_page_range(mmu_gather_t *tlb, struct vm_area_struct *vma, =
unsigned long address, unsigned long end)
+void unmap_page_range(mmu_gather_t **tlb, struct vm_area_struct *vma, =
unsigned long address, unsigned long end)
 {
 	pgd_t * dir;
=20
 	BUG_ON(address >=3D end);
=20
 	dir =3D pgd_offset(vma->vm_mm, address);
-	tlb_start_vma(tlb, vma);
+	tlb_start_vma(*tlb, vma);
 	do {
 		zap_pmd_range(tlb, dir, address, end - address);
 		address =3D (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (address && (address < end));
-	tlb_end_vma(tlb, vma);
+	tlb_end_vma(*tlb, vma);
 }
=20
 /* Dispose of an entire mmu_gather_t per rescheduling point */
@@ -911,9 +862,6 @@
=20
 	spin_lock(&mm->page_table_lock);
=20
-#ifdef CONFIG_SHAREPTE
-	unmap_shared_range(mm, address, address + size);
-#endif
   	/*
  	 * This was once a long-held spinlock.  Now we break the
  	 * work up into ZAP_BLOCK_SIZE units and relinquish the
@@ -926,7 +874,7 @@
 =20
  		flush_cache_range(vma, address, end);
  		tlb =3D tlb_gather_mmu(mm, 0);
- 		unmap_page_range(tlb, vma, address, end);
+ 		unmap_page_range(&tlb, vma, address, end);
  		tlb_finish_mmu(tlb, address, end);
 =20
  		cond_resched_lock(&mm->page_table_lock);

--==========2232157794==========--

