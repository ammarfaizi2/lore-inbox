Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbUKUQUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbUKUQUS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUKUQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 11:18:16 -0500
Received: from [213.85.13.118] ([213.85.13.118]:29571 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261775AbUKUQPR (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 21 Nov 2004 11:15:17 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KRuiu7EswP"
Content-Transfer-Encoding: 7bit
Message-ID: <16800.48889.428100.518358@gargle.gargle.HOWL>
Date: Sun, 21 Nov 2004 19:14:49 +0300
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Osdl.ORG>, Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH]: 3/4 mm/rmap.c cleanup
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
References: <16800.47063.386282.752478@gargle.gargle.HOWL>
	<m1zn1bmbu3.fsf@clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KRuiu7EswP
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Nikita Danilov <nikita@clusterfs.com> writes:

> Nikita Danilov <nikita@clusterfs.com> writes:
>
>> identical code that
>
> Hmm... hungry grues everywhere. First lines should have been
>
>     mm/rmap.c:page_referenced_one() and mm/rmap.c:try_to_unmap_one() contain
>     identical code that
>
> Patch is also but. Try again, this time attached.

This time for sure, I promise.

Nikita.

--KRuiu7EswP
Content-Type: text/plain
Content-Disposition: inline;
	filename="rmap-cleanup.patch"
Content-Transfer-Encoding: 7bit


mm/rmap.c:page_referenced_one() and mm/rmap.c:try_to_unmap_one() contain
identical code that

 - takes mm->page_table_lock;

 - drills through page tables;

 - checks that correct pte is reached.

Coalesce this into page_check_address()


 mm/rmap.c |   95 +++++++++++++++++++++++++++-----------------------------------
 1 files changed, 42 insertions(+), 53 deletions(-)

diff -puN mm/rmap.c~rmap-cleanup mm/rmap.c
--- bk-linux/mm/rmap.c~rmap-cleanup	2004-11-21 18:59:59.759523776 +0300
+++ bk-linux-nikita/mm/rmap.c	2004-11-21 18:59:59.761523472 +0300
@@ -250,6 +250,34 @@ unsigned long page_address_in_vma(struct
 }
 
 /*
+ * Check that @page is mapped at @address into @mm.
+ *
+ * On success returns with mapped pte and locked mm->page_table_lock.
+ */
+static inline pte_t *page_check_address(struct page *page, struct mm_struct *mm,
+					unsigned long address)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	spin_lock(&mm->page_table_lock);
+	pgd = pgd_offset(mm, address);
+	if (likely(pgd_present(*pgd))) {
+		pmd = pmd_offset(pgd, address);
+		if (likely(pmd_present(*pmd))) {
+			pte = pte_offset_map(pmd, address);
+			if (likely(pte_present(*pte) &&
+				   page_to_pfn(page) == pte_pfn(*pte)))
+				return pte;
+			pte_unmap(pte);
+		}
+	}
+	spin_unlock(&mm->page_table_lock);
+	return ERR_PTR(-ENOENT);
+}
+
+/*
  * Subfunctions of page_referenced: page_referenced_one called
  * repeatedly from either page_referenced_anon or page_referenced_file.
  */
@@ -258,8 +286,6 @@ static int page_referenced_one(struct pa
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pgd_t *pgd;
-	pmd_t *pmd;
 	pte_t *pte;
 	int referenced = 0;
 
@@ -269,35 +295,18 @@ static int page_referenced_one(struct pa
 	if (address == -EFAULT)
 		goto out;
 
-	spin_lock(&mm->page_table_lock);
-
-	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
-		goto out_unlock;
-
-	pmd = pmd_offset(pgd, address);
-	if (!pmd_present(*pmd))
-		goto out_unlock;
-
-	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		goto out_unmap;
-
-	if (page_to_pfn(page) != pte_pfn(*pte))
-		goto out_unmap;
-
-	if (ptep_clear_flush_young(vma, address, pte))
-		referenced++;
-
-	if (mm != current->mm && !ignore_token && has_swap_token(mm))
-		referenced++;
+	pte = page_check_address(page, mm, address);
+	if (!IS_ERR(pte)) {
+		if (ptep_clear_flush_young(vma, address, pte))
+			referenced++;
 
-	(*mapcount)--;
+		if (mm != current->mm && !ignore_token && has_swap_token(mm))
+			referenced++;
 
-out_unmap:
-	pte_unmap(pte);
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
+		(*mapcount)--;
+		pte_unmap(pte);
+		spin_unlock(&mm->page_table_lock);
+	}
 out:
 	return referenced;
 }
@@ -501,8 +510,6 @@ static int try_to_unmap_one(struct page 
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pgd_t *pgd;
-	pmd_t *pmd;
 	pte_t *pte;
 	pte_t pteval;
 	int ret = SWAP_AGAIN;
@@ -513,26 +520,9 @@ static int try_to_unmap_one(struct page 
 	if (address == -EFAULT)
 		goto out;
 
-	/*
-	 * We need the page_table_lock to protect us from page faults,
-	 * munmap, fork, etc...
-	 */
-	spin_lock(&mm->page_table_lock);
-
-	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
-		goto out_unlock;
-
-	pmd = pmd_offset(pgd, address);
-	if (!pmd_present(*pmd))
-		goto out_unlock;
-
-	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		goto out_unmap;
-
-	if (page_to_pfn(page) != pte_pfn(*pte))
-		goto out_unmap;
+	pte = page_check_address(page, mm, address);
+	if (IS_ERR(pte))
+		goto out;
 
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
@@ -598,7 +588,6 @@ static int try_to_unmap_one(struct page 
 
 out_unmap:
 	pte_unmap(pte);
-out_unlock:
 	spin_unlock(&mm->page_table_lock);
 out:
 	return ret;
@@ -697,7 +686,6 @@ static void try_to_unmap_cluster(unsigne
 	}
 
 	pte_unmap(pte);
-
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
 }
@@ -849,3 +837,4 @@ int try_to_unmap(struct page *page)
 		ret = SWAP_SUCCESS;
 	return ret;
 }
+

_

--KRuiu7EswP--
