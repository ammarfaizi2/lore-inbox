Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTDCWBS 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263566AbTDCWBS 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 17:01:18 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:44195 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263564AbTDCWBM 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 17:01:12 -0500
Date: Thu, 03 Apr 2003 16:12:19 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm3] New page_convert_anon
Message-ID: <75590000.1049407939@baldur.austin.ibm.com>
In-Reply-To: <20030403135522.254e700c.akpm@digeo.com>
References: <61050000.1049405305@baldur.austin.ibm.com>
 <20030403135522.254e700c.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========922520887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========922520887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On Thursday, April 03, 2003 13:55:22 -0800 Andrew Morton <akpm@digeo.com>
wrote:

> OK.  I'd still be more comfortable if that page was locked though.  I
> expect page->mapping is safe because truncate takes down pagetable before
> pagecache, but it seems way cleaner.
> 
> Is there any reason you didn't do that?

Because my mind slipped a gear and I did it wrong.  I tried to put it
inside page_convert_anon and messed it up.  How does this patch look?

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========922520887==========
Content-Type: text/plain; charset=iso-8859-1; name="objfix-2.5.66-mm3-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="objfix-2.5.66-mm3-2.diff";
 size=6500

--- 2.5.66-mm3/mm/rmap.c	2003-04-03 10:37:42.000000000 -0600
+++ 2.5.66-mm3-objfix/mm/rmap.c	2003-04-03 16:11:03.000000000 -0600
@@ -460,23 +460,6 @@ void page_remove_rmap(struct page * page
 			}
 		}
 	}
-#ifdef DEBUG_RMAP
-	/* Not found. This should NEVER happen! */
-	printk(KERN_ERR "page_remove_rmap: pte_chain %p not present.\n", ptep);
-	printk(KERN_ERR "page_remove_rmap: only found: ");
-	if (PageDirect(page)) {
-		printk("%llx", (u64)page->pte.direct);
-	} else {
-		for (pc =3D page->pte.chain; pc; pc =3D pc->next) {
-			int i;
-			for (i =3D 0; i < NRPTE; i++)
-				printk(" %d:%llx", i, (u64)pc->ptes[i]);
-		}
-	}
-	printk("\n");
-	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
-#endif
-
 out:
 	pte_chain_unlock(page);
 	if (!page_mapped(page))
@@ -781,152 +764,94 @@ out:
  * Find all the mappings for an object-based page and convert them
  * to 'anonymous', ie create a pte_chain and store all the pte pointers =
there.
  *
- * This function takes the address_space->i_shared_sem and the =
pte_chain_lock
- * for the page.  It jumps through some hoops to preallocate the correct =
number
- * of pte_chain structures to ensure that it can complete without =
releasing
- * the lock.
+ * This function does a lock_page, takes the
+ * address_space->i_shared_sem, sets the PageAnon flag, then sets the
+ * mm->page_table_lock for each vma and calls page_add_rmap.  This
+ * means there is a period when PageAnon is set, but still has some
+ * mappings with no pte_chain entry.  This is in fact safe, since
+ * page_remove_rmap will simply not find it.  try_to_unmap is safe because
+ * of the lock_page.
  */
 int page_convert_anon(struct page *page)
 {
 	struct address_space *mapping =3D page->mapping;
 	struct vm_area_struct *vma;
-	struct pte_chain *pte_chain =3D NULL, *ptec;
+	struct pte_chain *pte_chain =3D NULL;
 	pte_t *pte;
-	pte_addr_t pte_paddr =3D 0;
-	int mapcount;
-	int ptecount;
-	int index =3D 1;
 	int err =3D 0;
=20
+	lock_page(page);
 	down(&mapping->i_shared_sem);
-	pte_chain_lock(page);
=20
+	/* Take this only during setup */
+	pte_chain_lock(page);
 	/*
 	 * Has someone else done it for us before we got the lock?
 	 * If so, pte.direct or pte.chain has replaced pte.mapcount.
 	 */
-	if (PageAnon(page))
+	if (PageAnon(page)) {
+		pte_chain_unlock(page);
 		goto out_unlock;
+	}
=20
-	/*
-	 * Preallocate the pte_chains outside the lock.
-	 * If mapcount grows while we're allocating here, retry.
-	 * If mapcount shrinks, we free the excess before returning.
-	 */
-	mapcount =3D page->pte.mapcount;
-	while (index < mapcount) {
+	SetPageAnon(page);
+	if (page->pte.mapcount =3D=3D 0) {
 		pte_chain_unlock(page);
-		up(&mapping->i_shared_sem);
-		for (; index < mapcount; index +=3D NRPTE) {
-			if (index =3D=3D 1)
-				index =3D 0;
-			ptec =3D pte_chain_alloc(GFP_KERNEL);
-			if (!ptec) {
-				err =3D -ENOMEM;
-				goto out_free;
-			}
-			ptec->next =3D pte_chain;
-			pte_chain =3D ptec;
-		}
-		down(&mapping->i_shared_sem);
-		pte_chain_lock(page);
-		/*
-		 * Has someone else done it while we were allocating?
-		 */
-		if (PageAnon(page))
-			goto out_unlock;
-		mapcount =3D page->pte.mapcount;
+		goto out_unlock;
 	}
-	if (!mapcount)
-		goto set_anon;
+	/* This is gonna get incremented by page_add_rmap */
+	dec_page_state(nr_mapped);
+	page->pte.mapcount =3D 0;
=20
-again:
 	/*
-	 * We don't try for page_table_lock (what would we do when a
-	 * trylock fails?), therefore there's a small chance that we
-	 * catch a vma just as it's being unmapped and its page tables
-	 * freed.  Our pte_chain_lock prevents that on vmas that really
-	 * contain our page, but not on the others we look at.  So we
-	 * might locate junk that looks just like our page's pfn.  It's
-	 * a transient and very unlikely occurrence (much less likely
-	 * than a trylock failing), so check how many maps we find,
-	 * and if too many, start all over again.
+	 * Now that the page is marked as anon, unlock it.  page_add_rmap will =
lock
+	 * it as necessary.
 	 */
-	ptecount =3D 0;
-	ptec =3D pte_chain;
-
-	/*
-	 * Arrange for the first pte_chain to be partially filled at
-	 * the top, and the last (and any intermediates) to be full.
-	 */
-	index =3D mapcount % NRPTE;
-	if (index)
-		index =3D NRPTE - index;
+	pte_chain_unlock(page);
=20
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
 		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
 			break;
+		if (!pte_chain) {
+			pte_chain =3D pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				err =3D 1;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&vma->vm_mm->page_table_lock);
 		pte =3D find_pte(vma, page, NULL);
 		if (pte) {
-			ptecount++;
-			if (unlikely(ptecount > mapcount))
-				goto again;
-			pte_paddr =3D ptep_to_paddr(pte);
-			pte_unmap(pte);
-			if (ptec) {
-				ptec->ptes[index] =3D pte_paddr;
-				index++;
-				if (index =3D=3D NRPTE) {
-					ptec =3D ptec->next;
-					index =3D 0;
-				}
-			}
+			/* Make sure this isn't a duplicate */
+			page_remove_rmap(page, pte);
+			pte_chain =3D page_add_rmap(page, pte, pte_chain);
 		}
+		spin_unlock(&vma->vm_mm->page_table_lock);
 	}
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 		if (vma->vm_pgoff > (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT)))
 			break;
+		if (!pte_chain) {
+			pte_chain =3D pte_chain_alloc(GFP_KERNEL);
+			if (!pte_chain) {
+				err =3D 1;
+				goto out_unlock;
+			}
+		}
+		spin_lock(&vma->vm_mm->page_table_lock);
 		pte =3D find_pte(vma, page, NULL);
 		if (pte) {
-			ptecount++;
-			if (unlikely(ptecount > mapcount))
-				goto again;
-			pte_paddr =3D ptep_to_paddr(pte);
-			pte_unmap(pte);
-			if (ptec) {
-				ptec->ptes[index] =3D pte_paddr;
-				index++;
-				if (index =3D=3D NRPTE) {
-					ptec =3D ptec->next;
-					index =3D 0;
-				}
-			}
+			/* Make sure this isn't a duplicate */
+			page_remove_rmap(page, pte);
+			pte_chain =3D page_add_rmap(page, pte, pte_chain);
 		}
+		spin_unlock(&vma->vm_mm->page_table_lock);
 	}
=20
-	BUG_ON(ptecount !=3D mapcount);
-	if (mapcount =3D=3D 1) {
-		SetPageDirect(page);
-		page->pte.direct =3D pte_paddr;
-		/* If pte_chain is set, it's all excess to be freed */
-	} else {
-		page->pte.chain =3D pte_chain;
-		/* Point pte_chain to any excess to be freed */
-		pte_chain =3D ptec;
-		BUG_ON(index);
-	}
-
-set_anon:
-	SetPageAnon(page);
 out_unlock:
-	pte_chain_unlock(page);
+	pte_chain_free(pte_chain);
 	up(&mapping->i_shared_sem);
-out_free:
-	while (pte_chain) {
-		ptec =3D pte_chain->next;
-		pte_chain_free(pte_chain);
-		pte_chain =3D ptec;
-	}
+	unlock_page(page);
 	return err;
 }
=20

--==========922520887==========--

