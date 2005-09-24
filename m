Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVIXPEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVIXPEc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVIXPEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:04:32 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:62482 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S932186AbVIXPEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:04:32 -0400
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/msync.c cleanup
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 25 Sep 2005 00:04:19 +0900
Message-ID: <874q8amrrg.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is not problem actually, but sync_page_range() is using for
exported function to filesystems.

The msync_xxx is more readable at least to me.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 mm/msync.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff -puN mm/msync.c~msync-rename mm/msync.c
--- linux-2.6.14-rc2/mm/msync.c~msync-rename	2005-09-24 23:52:28.000000000 +0900
+++ linux-2.6.14-rc2-hirofumi/mm/msync.c	2005-09-24 23:53:14.000000000 +0900
@@ -22,7 +22,7 @@
  * threads/the swapper from ripping pte's out from under us.
  */
 
-static void sync_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static void msync_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end)
 {
 	pte_t *pte;
@@ -50,7 +50,7 @@ static void sync_pte_range(struct vm_are
 	pte_unmap(pte - 1);
 }
 
-static inline void sync_pmd_range(struct vm_area_struct *vma, pud_t *pud,
+static inline void msync_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end)
 {
 	pmd_t *pmd;
@@ -61,11 +61,11 @@ static inline void sync_pmd_range(struct
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		sync_pte_range(vma, pmd, addr, next);
+		msync_pte_range(vma, pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
 }
 
-static inline void sync_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
+static inline void msync_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end)
 {
 	pud_t *pud;
@@ -76,11 +76,11 @@ static inline void sync_pud_range(struct
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		sync_pmd_range(vma, pud, addr, next);
+		msync_pmd_range(vma, pud, addr, next);
 	} while (pud++, addr = next, addr != end);
 }
 
-static void sync_page_range(struct vm_area_struct *vma,
+static void msync_page_range(struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -101,14 +101,14 @@ static void sync_page_range(struct vm_ar
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		sync_pud_range(vma, pgd, addr, next);
+		msync_pud_range(vma, pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&mm->page_table_lock);
 }
 
 #ifdef CONFIG_PREEMPT
-static inline void filemap_sync(struct vm_area_struct *vma,
-				unsigned long addr, unsigned long end)
+static inline void filemap_msync(struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end)
 {
 	const size_t chunk = 64 * 1024;	/* bytes */
 	unsigned long next;
@@ -117,15 +117,15 @@ static inline void filemap_sync(struct v
 		next = addr + chunk;
 		if (next > end || next < addr)
 			next = end;
-		sync_page_range(vma, addr, next);
+		msync_page_range(vma, addr, next);
 		cond_resched();
 	} while (addr = next, addr != end);
 }
 #else
-static inline void filemap_sync(struct vm_area_struct *vma,
-				unsigned long addr, unsigned long end)
+static inline void filemap_msync(struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end)
 {
-	sync_page_range(vma, addr, end);
+	msync_page_range(vma, addr, end);
 }
 #endif
 
@@ -150,7 +150,7 @@ static int msync_interval(struct vm_area
 		return -EBUSY;
 
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		filemap_sync(vma, addr, end);
+		filemap_msync(vma, addr, end);
 
 		if (flags & MS_SYNC) {
 			struct address_space *mapping = file->f_mapping;
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
