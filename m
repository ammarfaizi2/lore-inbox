Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJJT0z>; Thu, 10 Oct 2002 15:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJJT0z>; Thu, 10 Oct 2002 15:26:55 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:40576 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261972AbSJJT0s>; Thu, 10 Oct 2002 15:26:48 -0400
Date: Thu, 10 Oct 2002 14:32:18 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.41-mm2+] Shared page table bugfix for mprotect
Message-ID: <167610000.1034278338@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1014540887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1014540887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I discovered I hadn't done the right things for mprotect, so here's a patch
that fixes it.  It goes on top of the #ifdef cleanup I sent earlier today.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1014540887==========
Content-Type: text/plain; charset=iso-8859-1; name="shpte-2.5.41-mm2-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shpte-2.5.41-mm2-2.diff"; size=4158

--- 2.5.41-mm2-shsent/./include/linux/mm.h	2002-10-10 10:34:58.000000000 =
-0500
+++ 2.5.41-mm2-shpte/./include/linux/mm.h	2002-10-10 13:23:30.000000000 =
-0500
@@ -360,6 +360,7 @@
=20
 extern void zap_page_range(struct vm_area_struct *vma, unsigned long =
address, unsigned long size);
 #ifdef CONFIG_SHAREPTE
+extern pte_t *pte_unshare(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address);
 extern int share_page_range(struct mm_struct *dst, struct mm_struct *src, =
struct vm_area_struct *vma, pmd_t **prev_pmd);
 #else
 extern int copy_page_range(struct mm_struct *dst, struct mm_struct *src, =
struct vm_area_struct *vma);
--- 2.5.41-mm2-shsent/./include/asm-i386/pgtable.h	2002-10-10 =
10:17:55.000000000 -0500
+++ 2.5.41-mm2-shpte/./include/asm-i386/pgtable.h	2002-10-10 =
13:14:48.000000000 -0500
@@ -212,6 +212,7 @@
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |=3D _PAGE_RW; =
return pte; }
 static inline int pmd_write(pmd_t pmd)		{ return (pmd).pmd & _PAGE_RW; }
 static inline pmd_t pmd_wrprotect(pmd_t pmd)	{ (pmd).pmd &=3D ~_PAGE_RW; =
return pmd; }
+static inline pmd_t pmd_mkwrite(pmd_t pmd)	{ (pmd).pmd |=3D _PAGE_RW; =
return pmd; }
=20
 static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return =
test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
 static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return =
test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low); }
--- 2.5.41-mm2-shsent/./mm/mprotect.c	2002-10-10 10:17:57.000000000 -0500
+++ 2.5.41-mm2-shpte/./mm/mprotect.c	2002-10-10 13:31:14.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -24,10 +25,11 @@
 #include <asm/tlbflush.h>
=20
 static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
+change_pte_range(struct vm_area_struct *vma, pmd_t *pmd, unsigned long =
address,
 		unsigned long size, pgprot_t newprot)
 {
 	pte_t * pte;
+	struct page *ptepage;
 	unsigned long end;
=20
 	if (pmd_none(*pmd))
@@ -37,11 +39,32 @@
 		pmd_clear(pmd);
 		return;
 	}
-	pte =3D pte_offset_map(pmd, address);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
 	address &=3D ~PMD_MASK;
 	end =3D address + size;
 	if (end > PMD_SIZE)
 		end =3D PMD_SIZE;
+
+#ifdef CONFIG_SHAREPTE
+	if (page_count(ptepage) > 1) {
+		if ((address =3D=3D 0) && (end =3D=3D PMD_SIZE)) {
+			pmd_t	pmdval =3D *pmd;
+
+			if (vma->vm_flags & VM_MAYWRITE)
+				pmdval =3D pmd_mkwrite(pmdval);
+			else
+				pmdval =3D pmd_wrprotect(pmdval);
+			set_pmd(pmd, pmdval);
+			pte_page_unlock(ptepage);
+			return;
+		}
+		pte =3D pte_unshare(vma->vm_mm, pmd, address);
+		ptepage =3D pmd_page(*pmd);
+	} else
+#endif
+		pte =3D pte_offset_map(pmd, address);
+
 	do {
 		if (pte_present(*pte)) {
 			pte_t entry;
@@ -56,11 +79,12 @@
 		address +=3D PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
+	pte_page_unlock(ptepage);
 	pte_unmap(pte - 1);
 }
=20
 static inline void
-change_pmd_range(pgd_t *pgd, unsigned long address,
+change_pmd_range(struct vm_area_struct *vma, pgd_t *pgd, unsigned long =
address,
 		unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
@@ -79,7 +103,7 @@
 	if (end > PGDIR_SIZE)
 		end =3D PGDIR_SIZE;
 	do {
-		change_pte_range(pmd, address, end - address, newprot);
+		change_pte_range(vma, pmd, address, end - address, newprot);
 		address =3D (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -98,7 +122,7 @@
 		BUG();
 	spin_lock(&current->mm->page_table_lock);
 	do {
-		change_pmd_range(dir, start, end - start, newprot);
+		change_pmd_range(vma, dir, start, end - start, newprot);
 		start =3D (start + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (start && (start < end));
--- 2.5.41-mm2-shsent/./mm/memory.c	2002-10-10 10:35:34.000000000 -0500
+++ 2.5.41-mm2-shpte/./mm/memory.c	2002-10-10 13:22:29.000000000 -0500
@@ -218,7 +218,7 @@
  * held.
  */
=20
-static pte_t *pte_unshare(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address)
+pte_t *pte_unshare(struct mm_struct *mm, pmd_t *pmd, unsigned long =
address)
 {
 	pte_t	*src_ptb, *dst_ptb;
 	struct page *oldpage, *newpage, *tmppage;

--==========1014540887==========--

