Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbTCLWjL>; Wed, 12 Mar 2003 17:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262055AbTCLWjL>; Wed, 12 Mar 2003 17:39:11 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:12663 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262054AbTCLWjD>; Wed, 12 Mar 2003 17:39:03 -0500
Date: Wed, 12 Mar 2003 16:49:38 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.64-mm5] objrmap fix for nonlinear
Message-ID: <110230000.1047509378@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1914519384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1914519384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


This patch should fix the remap_file_pages problem for object-based rmap.
I added a function that converts an object-based page to a pte_chain-based
page.  It's a little tricky because it has to preallocated all the
pte_chains it needs before taking the lock since the page can't be allowed
outside the lock in an intermediate state.  Fortunately I know how many
pte_chains are needed in advance.

I also condensed some of the common code and added comments.  One side
effect is I removed taking the page_table_lock during the pte lookups.
I've convinced myself that anyone else trying to touch those areas will
block on the locks I already hold.  It survives the abuse test I've thrown
at it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1914519384==========
Content-Type: text/plain; charset=iso-8859-1; name="objfix-2.5.64-mm5-1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="objfix-2.5.64-mm5-1.diff";
 size=10444

--- 2.5.64-mm5/./mm/fremap.c	2003-03-12 11:05:35.000000000 -0600
+++ 2.5.64-mm5-fix/./mm/fremap.c	2003-03-12 15:57:15.000000000 -0600
@@ -62,6 +62,16 @@
 	pte_chain =3D pte_chain_alloc(GFP_KERNEL);
 	if (!pte_chain)
 		goto err;
+
+	/*
+	 * Convert this page to anon for objrmap if it's nonlinear
+	 */
+	pgidx =3D (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgidx +=3D vma->vm_pgoff;
+	pgidx >>=3D PAGE_CACHE_SHIFT - PAGE_SHIFT;
+	if (!PageAnon(page) && (page->index !=3D pgidx))
+		page_convert_anon(page);
+
 	pgd =3D pgd_offset(mm, addr);
 	spin_lock(&mm->page_table_lock);
=20
@@ -80,11 +90,6 @@
 	flush_icache_page(vma, page);
 	entry =3D mk_pte(page, prot);
 	set_pte(pte, entry);
-	pgidx =3D (addr - vma->vm_start) >> PAGE_SHIFT;
-	pgidx +=3D vma->vm_pgoff;
-	pgidx >>=3D PAGE_CACHE_SHIFT - PAGE_SHIFT;
-	if (page->index !=3D pgidx)
-		SetPageAnon(page);
 	pte_chain =3D page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
  	if (flush)
--- 2.5.64-mm5/./mm/rmap.c	2003-03-12 11:05:35.000000000 -0600
+++ 2.5.64-mm5-fix/./mm/rmap.c	2003-03-12 16:32:02.000000000 -0600
@@ -76,18 +76,21 @@
  **/
=20
 /**
- * page_referenced - test if the page was referenced
- * @page: the page to test
+ * find_pte - Find a pte pointer given a vma and a struct page.
+ * @vma: the vma to search
+ * @page: the page to find
  *
- * Quick test_and_clear_referenced for all mappings to a page,
- * returns the number of processes which referenced the page.
- * Caller needs to hold the pte_chain_lock.
+ * Determine if this page is mapped in this vma.  If it is, map and rethrn
+ * the pte pointer associated with it.  Return null if the page is not
+ * mapped in this vma for any reason.
  *
- * If the page has a single-entry pte_chain, collapse that back to a =
PageDirect
- * representation.  This way, it's only done under memory pressure.
+ * This is strictly an internal helper function for the object-based rmap
+ * functions.
+ *=20
+ * It is the caller's responsibility to unmap the pte if it is returned.
  */
-static inline int
-page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
+static inline pte_t *
+find_pte(struct vm_area_struct *vma, struct page *page, unsigned long =
*addr)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	pgd_t *pgd;
@@ -95,7 +98,6 @@
 	pte_t *pte;
 	unsigned long loffset;
 	unsigned long address;
-	int referenced =3D 0;
=20
 	loffset =3D (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
 	if (loffset < vma->vm_pgoff)
@@ -106,17 +108,13 @@
 	if (address >=3D vma->vm_end)
 		goto out;
=20
-	if (!spin_trylock(&mm->page_table_lock)) {
-		referenced =3D 1;
-		goto out;
-	}
 	pgd =3D pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
-		goto out_unlock;
+		goto out;
=20
 	pmd =3D pmd_offset(pgd, address);
 	if (!pmd_present(*pmd))
-		goto out_unlock;
+		goto out;
=20
 	pte =3D pte_offset_map(pmd, address);
 	if (!pte_present(*pte))
@@ -125,18 +123,57 @@
 	if (page_to_pfn(page) !=3D pte_pfn(*pte))
 		goto out_unmap;
=20
-	if (ptep_test_and_clear_young(pte))
-		referenced++;
+	if (addr)
+		*addr =3D address;
+
+	return pte;
+
 out_unmap:
 	pte_unmap(pte);
+out:
+	return NULL;
+}
=20
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
+/**
+ * page_referenced_obj_one - referenced check for object-based rmap
+ * @vma: the vma to look in.
+ * @page: the page we're working on.
+ *
+ * Find a pte entry for a page/vma pair, then check and clear the =
referenced
+ * bit.
+ *
+ * This is strictly a helper function for page_referenced_obj.
+ */
+static int
+page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
+{
+	pte_t *pte;
+	int referenced =3D 0;
+
+	pte =3D find_pte(vma, page, NULL);
+	if (pte) {
+		if (ptep_test_and_clear_young(pte))
+			referenced++;
+		pte_unmap(pte);
+	}
=20
-out:
 	return referenced;
 }
=20
+/**
+ * page_referenced_obj_one - referenced check for object-based rmap
+ * @page: the page we're checking references on.
+ *
+ * For an object-based mapped page, find all the places it is mapped and
+ * check/clear the referenced flag.  This is done by following the =
page->mapping
+ * pointer, then walking the chain of vmas it holds.  It returns the =
number
+ * of references it found.
+ *
+ * This function is only called from page_referenced for object-based =
pages.
+ *
+ * The semaphore address_space->i_shared_sem is tried.  If it can't be =
gotten,
+ * assume a reference count of 1.
+ */
 static int
 page_referenced_obj(struct page *page)
 {
@@ -167,6 +204,17 @@
 	return referenced;
 }
=20
+/**
+ * page_referenced - test if the page was referenced
+ * @page: the page to test
+ *
+ * Quick test_and_clear_referenced for all mappings to a page,
+ * returns the number of processes which referenced the page.
+ * Caller needs to hold the pte_chain_lock.
+ *
+ * If the page has a single-entry pte_chain, collapse that back to a =
PageDirect
+ * representation.  This way, it's only done under memory pressure.
+ */
 int page_referenced(struct page * page)
 {
 	struct pte_chain * pc;
@@ -245,6 +293,10 @@
=20
 	pte_chain_lock(page);
=20
+	/*
+	 * If this is an object-based page, just count it.  We can
+	 * find the mappings by walking the object vma chain for that object.
+	 */
 	if (!PageAnon(page)) {
 		if (!page->mapping)
 			BUG();
@@ -345,6 +397,10 @@
=20
 	pte_chain_lock(page);
=20
+	/*
+	 * If this is an object-based page, just uncount it.  We can
+	 * find the mappings by walking the object vma chain for that object.
+	 */
 	if (!PageAnon(page)) {
 		if (!page->mapping)
 			BUG();
@@ -422,46 +478,27 @@
 	return;
 }
=20
+/**
+ * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Determine whether a page is mapped in a given vma and unmap it if it's =
found.
+ *
+ * This function is strictly a helper function for try_to_unmap_obj.
+ */
 static inline int
 try_to_unmap_obj_one(struct vm_area_struct *vma, struct page *page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	pgd_t *pgd;
-	pmd_t *pmd;
+	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
-	unsigned long loffset;
-	unsigned long address;
 	int ret =3D SWAP_SUCCESS;
=20
-	loffset =3D (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
-	if (loffset < vma->vm_pgoff)
-		goto out;
-
-	address =3D vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
-
-	if (address >=3D vma->vm_end)
+	pte =3D find_pte(vma, page, &address);
+	if (!pte)
 		goto out;
=20
-	if (!spin_trylock(&mm->page_table_lock)) {
-		ret =3D SWAP_AGAIN;
-		goto out;
-	}
-	pgd =3D pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
-		goto out_unlock;
-
-	pmd =3D pmd_offset(pgd, address);
-	if (!pmd_present(*pmd))
-		goto out_unlock;
-
-	pte =3D pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		goto out_unmap;
-
-	if (page_to_pfn(page) !=3D pte_pfn(*pte))
-		goto out_unmap;
-
 	if (vma->vm_flags & VM_LOCKED) {
 		ret =3D  SWAP_FAIL;
 		goto out_unmap;
@@ -484,13 +521,22 @@
 out_unmap:
 	pte_unmap(pte);
=20
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
-
 out:
 	return ret;
 }
=20
+/**
+ * try_to_unmap_obj - unmap a page using the object-based rmap method
+ * @page: the page to unmap
+ *
+ * Find all the mappings of a page using the mapping pointer and the vma =
chains
+ * contained in the address_space struct it points to.
+ *
+ * This function is only called from try_to_unmap for object-based pages.
+ *
+ * The semaphore address_space->i_shared_sem is tried.  If it can't be =
gotten,
+ * return a temporary error.
+ */
 static int
 try_to_unmap_obj(struct page *page)
 {
@@ -648,6 +694,10 @@
 	if (!page->mapping)
 		BUG();
=20
+	/*
+	 * If it's an object-based page, use the object vma chain to find all
+	 * the mappings.
+	 */
 	if (!PageAnon(page)) {
 		ret =3D try_to_unmap_obj(page);
 		goto out;
@@ -717,6 +767,115 @@
 }
=20
 /**
+ * page_convert_anon - Convert an object-based mapped page to =
pte_chain-based.
+ * @page: the page to convert
+ *
+ * Find all the mappings for an object-based page and convert them
+ * to 'anonymous', ie create a pte_chain and store all the pte pointers =
there.
+ *
+ * This function takes the address_space->i_shared_sem and the =
pte_chain_lock
+ * for the page.  It jumps through some hoops to preallocate the correct =
number
+ * of pte_chain structures to ensure that it can complete without =
releasing
+ * the lock.
+ */
+void
+page_convert_anon(struct page *page)
+{
+	struct address_space *mapping =3D page->mapping;
+	struct vm_area_struct *vma;
+	struct pte_chain *pte_chain =3D NULL, *ptec;
+	pte_t *pte;
+	pte_addr_t pte_paddr;
+	int mapcount;
+	int index =3D 0;
+
+	if (PageAnon(page))
+		goto out;
+
+retry:
+	/*
+	 * Preallocate the pte_chains outside the lock.
+	 */
+	mapcount =3D page->pte.mapcount;
+	if (mapcount > 1) {
+		for (; index < mapcount; index +=3D NRPTE) {
+			ptec =3D pte_chain_alloc(GFP_KERNEL);
+			ptec->next =3D pte_chain;
+			pte_chain =3D ptec;
+		}
+	}
+	down(&mapping->i_shared_sem);
+	pte_chain_lock(page);
+
+	/*
+	 * Check to make sure the number of mappings didn't change.  If they
+	 * did, either retry or free enough pte_chains to compensate.
+	 */
+	if (mapcount < page->pte.mapcount) {
+		pte_chain_unlock(page);
+		goto retry;
+	} else if ((mapcount > page->pte.mapcount) && (mapcount > 1)) {
+		mapcount =3D page->pte.mapcount;
+		while ((index - NRPTE) > mapcount) {
+			index -=3D NRPTE;
+			ptec =3D pte_chain->next;
+			pte_chain_free(pte_chain);
+			pte_chain =3D ptec;
+		}
+		if (mapcount <=3D 1)
+			pte_chain_free(pte_chain);
+	}
+	SetPageAnon(page);
+
+	if (mapcount =3D=3D 0)
+		goto out;
+	else if (mapcount =3D=3D 1) {
+		SetPageDirect(page);
+		page->pte.direct =3D 0;
+	} else
+		page->pte.chain =3D pte_chain;
+
+	index =3D NRPTE-1;
+	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		pte =3D find_pte(vma, page, NULL);
+		if (pte) {
+			pte_paddr =3D ptep_to_paddr(pte);
+			pte_unmap(pte);
+			if (PageDirect(page)) {
+				page->pte.direct =3D pte_paddr;
+				goto out_unlock;
+			}
+			pte_chain->ptes[index] =3D pte_paddr;
+			if (!--index) {
+				pte_chain =3D pte_chain->next;
+				index =3D NRPTE-1;
+			}
+		}
+	}
+	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		pte =3D find_pte(vma, page, NULL);
+		if (pte) {
+			pte_paddr =3D ptep_to_paddr(pte);
+			pte_unmap(pte);
+			if (PageDirect(page)) {
+				page->pte.direct =3D pte_paddr;
+				goto out_unlock;
+			}
+			pte_chain->ptes[index] =3D pte_paddr;
+			if (!--index) {
+				pte_chain =3D pte_chain->next;
+				index =3D NRPTE-1;
+			}
+		}
+	}
+out_unlock:
+	pte_chain_unlock(page);
+	up(&mapping->i_shared_sem);
+out:
+	return;
+}
+
+/**
  ** No more VM stuff below this comment, only pte_chain helper
  ** functions.
  **/

--==========1914519384==========--

