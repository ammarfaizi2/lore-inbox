Return-Path: <linux-kernel-owner+w=401wt.eu-S1751084AbXAFCZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbXAFCZY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbXAFCZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:25:24 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47683 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbXAFCZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:25:22 -0500
Message-Id: <20070106022919.691295000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:27:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, hugh@veritas.com, Ramiro.Voicu@cern.ch
Subject: [patch 03/50] read_zero_pagealigned() locking fix
Content-Disposition: inline; filename=read_zero_pagealigned-locking-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Hugh Dickins <hugh@veritas.com>

Ramiro Voicu hits the BUG_ON(!pte_none(*pte)) in zeromap_pte_range: kernel
bugzilla 7645.  Right: read_zero_pagealigned uses down_read of mmap_sem,
but another thread's racing read of /dev/zero, or a normal fault, can
easily set that pte again, in between zap_page_range and zeromap_page_range
getting there.  It's been wrong ever since 2.4.3.

The simple fix is to use down_write instead, but that would serialize reads
of /dev/zero more than at present: perhaps some app would be badly
affected.  So instead let zeromap_page_range return the error instead of
BUG_ON, and read_zero_pagealigned break to the slower clear_user loop in
that case - there's no need to optimize for it.

Use -EEXIST for when a pte is found: BUG_ON in mmap_zero (the other user of
zeromap_page_range), though it really isn't interesting there.  And since
mmap_zero wants -EAGAIN for out-of-memory, the zeromaps better return that
than -ENOMEM.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Cc: Ramiro Voicu: <Ramiro.Voicu@cern.ch>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/char/mem.c |   12 ++++++++----
 mm/memory.c        |   32 +++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 15 deletions(-)

--- linux-2.6.19.1.orig/drivers/char/mem.c
+++ linux-2.6.19.1/drivers/char/mem.c
@@ -646,7 +646,8 @@ static inline size_t read_zero_pagealign
 			count = size;
 
 		zap_page_range(vma, addr, count, NULL);
-        	zeromap_page_range(vma, addr, count, PAGE_COPY);
+        	if (zeromap_page_range(vma, addr, count, PAGE_COPY))
+			break;
 
 		size -= count;
 		buf += count;
@@ -713,11 +714,14 @@ out:
 
 static int mmap_zero(struct file * file, struct vm_area_struct * vma)
 {
+	int err;
+
 	if (vma->vm_flags & VM_SHARED)
 		return shmem_zero_setup(vma);
-	if (zeromap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
+	err = zeromap_page_range(vma, vma->vm_start,
+			vma->vm_end - vma->vm_start, vma->vm_page_prot);
+	BUG_ON(err == -EEXIST);
+	return err;
 }
 #else /* CONFIG_MMU */
 static ssize_t read_zero(struct file * file, char * buf, 
--- linux-2.6.19.1.orig/mm/memory.c
+++ linux-2.6.19.1/mm/memory.c
@@ -1110,23 +1110,29 @@ static int zeromap_pte_range(struct mm_s
 {
 	pte_t *pte;
 	spinlock_t *ptl;
+	int err = 0;
 
 	pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
-		return -ENOMEM;
+		return -EAGAIN;
 	arch_enter_lazy_mmu_mode();
 	do {
 		struct page *page = ZERO_PAGE(addr);
 		pte_t zero_pte = pte_wrprotect(mk_pte(page, prot));
+
+		if (unlikely(!pte_none(*pte))) {
+			err = -EEXIST;
+			pte++;
+			break;
+		}
 		page_cache_get(page);
 		page_add_file_rmap(page);
 		inc_mm_counter(mm, file_rss);
-		BUG_ON(!pte_none(*pte));
 		set_pte_at(mm, addr, pte, zero_pte);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(pte - 1, ptl);
-	return 0;
+	return err;
 }
 
 static inline int zeromap_pmd_range(struct mm_struct *mm, pud_t *pud,
@@ -1134,16 +1140,18 @@ static inline int zeromap_pmd_range(stru
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int err;
 
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
-		return -ENOMEM;
+		return -EAGAIN;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (zeromap_pte_range(mm, pmd, addr, next, prot))
-			return -ENOMEM;
+		err = zeromap_pte_range(mm, pmd, addr, next, prot);
+		if (err)
+			break;
 	} while (pmd++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 static inline int zeromap_pud_range(struct mm_struct *mm, pgd_t *pgd,
@@ -1151,16 +1159,18 @@ static inline int zeromap_pud_range(stru
 {
 	pud_t *pud;
 	unsigned long next;
+	int err;
 
 	pud = pud_alloc(mm, pgd, addr);
 	if (!pud)
-		return -ENOMEM;
+		return -EAGAIN;
 	do {
 		next = pud_addr_end(addr, end);
-		if (zeromap_pmd_range(mm, pud, addr, next, prot))
-			return -ENOMEM;
+		err = zeromap_pmd_range(mm, pud, addr, next, prot);
+		if (err)
+			break;
 	} while (pud++, addr = next, addr != end);
-	return 0;
+	return err;
 }
 
 int zeromap_page_range(struct vm_area_struct *vma,

--
