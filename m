Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSJOWov>; Tue, 15 Oct 2002 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265054AbSJOWoZ>; Tue, 15 Oct 2002 18:44:25 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:55052 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264814AbSJOW0W>; Tue, 15 Oct 2002 18:26:22 -0400
Date: Tue, 15 Oct 2002 17:32:07 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [PATCH 2.5.42-mm3] Fix mremap for shared page tables
Message-ID: <291360000.1034721127@baldur.austin.ibm.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========715598336=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========715598336==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hugh Dickens was right.  mremap was broken wrt shared page tables.  Here's
the fix.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========715598336==========
Content-Type: text/plain; charset=iso-8859-1; name="shpte-2.5.42-mm3-3.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="shpte-2.5.42-mm3-3.diff"; size=2694

--- 2.5.42-mm3-shsent/mm/mremap.c	2002-10-15 09:59:37.000000000 -0500
+++ 2.5.42-mm3-shpte/mm/mremap.c	2002-10-15 17:16:59.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/swap.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/rmap-locking.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -23,6 +24,7 @@
=20
 static pte_t *get_one_pte_map_nested(struct mm_struct *mm, unsigned long =
addr)
 {
+	struct page *ptepage;
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte =3D NULL;
@@ -45,8 +47,17 @@
 		goto end;
 	}
=20
+	ptepage =3D pmd_page(*pmd);
+	pte_page_lock(ptepage);
+#ifdef CONFIG_SHAREPTE
+	if (page_count(ptepage) > 1) {
+		pte_unshare(mm, pmd, addr);
+		ptepage =3D pmd_page(*pmd);
+	}
+#endif
 	pte =3D pte_offset_map_nested(pmd, addr);
 	if (pte_none(*pte)) {
+		pte_page_unlock(ptepage);
 		pte_unmap_nested(pte);
 		pte =3D NULL;
 	}
@@ -54,6 +65,32 @@
 	return pte;
 }
=20
+static inline void drop_pte_nested(struct mm_struct *mm, unsigned long =
addr, pte_t *pte)
+{
+	struct page *ptepage;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	pgd =3D pgd_offset(mm, addr);
+	pmd =3D pmd_offset(pgd, addr);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_unlock(ptepage);
+	pte_unmap_nested(pte);
+}
+
+static inline void drop_pte(struct mm_struct *mm, unsigned long addr, =
pte_t *pte)
+{
+	struct page *ptepage;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	pgd =3D pgd_offset(mm, addr);
+	pmd =3D pmd_offset(pgd, addr);
+	ptepage =3D pmd_page(*pmd);
+	pte_page_unlock(ptepage);
+	pte_unmap(pte);
+}
+
 #ifdef CONFIG_HIGHPTE	/* Save a few cycles on the sane machines */
 static inline int page_table_present(struct mm_struct *mm, unsigned long =
addr)
 {
@@ -72,12 +109,24 @@
=20
 static inline pte_t *alloc_one_pte_map(struct mm_struct *mm, unsigned long =
addr)
 {
+	struct page *ptepage;
 	pmd_t * pmd;
 	pte_t * pte =3D NULL;
=20
 	pmd =3D pmd_alloc(mm, pgd_offset(mm, addr), addr);
-	if (pmd)
+	if (pmd) {
+		ptepage =3D pmd_page(*pmd);
+#ifdef CONFIG_SHAREPTE
+		pte_page_lock(ptepage);
+		if (page_count(ptepage) > 1) {
+			pte_unshare(mm, pmd, addr);
+			ptepage =3D pmd_page(*pmd);
+		}
+		pte_page_unlock(ptepage);
+#endif
 		pte =3D pte_alloc_map(mm, pmd, addr);
+		pte_page_lock(ptepage);
+	}
 	return pte;
 }
=20
@@ -121,15 +170,15 @@
 		 * atomic kmap
 		 */
 		if (!page_table_present(mm, new_addr)) {
-			pte_unmap_nested(src);
+			drop_pte_nested(mm, old_addr, src);
 			src =3D NULL;
 		}
 		dst =3D alloc_one_pte_map(mm, new_addr);
 		if (src =3D=3D NULL)
 			src =3D get_one_pte_map_nested(mm, old_addr);
 		error =3D copy_one_pte(mm, src, dst);
-		pte_unmap_nested(src);
-		pte_unmap(dst);
+		drop_pte_nested(mm, old_addr, src);
+		drop_pte(mm, new_addr, dst);
 	}
 	flush_tlb_page(vma, old_addr);
 	spin_unlock(&mm->page_table_lock);

--==========715598336==========--

