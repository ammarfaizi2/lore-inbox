Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUFSQ3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUFSQ3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUFSQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:26:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10129
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264461AbUFSQY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:24:57 -0400
Date: Sat, 19 Jun 2004 18:25:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: mincore on anon mappings
Message-ID: <20040619162503.GC12019@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

here a first (untested) attempt to allow mincore on anon vmas too.

I heard you need this from gcc, right?

(btw, returning -ENOMEM for anon vmas was pretty bogus, -EINVAL or
even -ENOSYS would been more correct)

--- sles/mm/mincore.c.~1~	2004-02-04 16:07:06.000000000 +0100
+++ sles/mm/mincore.c	2004-06-15 00:42:52.122127224 +0200
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -22,7 +24,7 @@
  * and is up to date; i.e. that no page-in operation would be required
  * at this time if an application were to map and access this page.
  */
-static unsigned char mincore_page(struct vm_area_struct * vma,
+static unsigned char mincore_page_inode(struct vm_area_struct * vma,
 	unsigned long pgoff)
 {
 	unsigned char present = 0;
@@ -38,16 +40,74 @@ static unsigned char mincore_page(struct
 	return present;
 }
 
+/*
+ * Careful this only works with anon-vma for the vma->vm_pgoff settings.
+ */
+static unsigned char mincore_page_anon(struct vm_area_struct * vma,
+				       unsigned long pgoff)
+{
+	unsigned char present = 0;
+	struct page * page;
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+	unsigned long address;
+
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
+
+	spin_lock(&mm->page_table_lock);
+
+	pgd = pgd_offset(mm, address);
+	if (!pgd_present(*pgd))
+		goto out_unlock;
+
+	pmd = pmd_offset(pgd, address);
+	if (!pmd_present(*pmd))
+		goto out_unlock;
+
+	ptep = pte_offset_map(pmd, address);
+	pte = *ptep;
+	pte_unmap(ptep);
+
+	spin_unlock(&mm->page_table_lock);
+
+	if (pte_none(pte))
+		goto out;
+	if (!pte_present(pte)) {
+		swp_entry_t entry = pte_to_swp_entry(pte);
+		page = lookup_swap_cache(entry);
+		if (page) {
+			present = PageUptodate(page);
+			page_cache_release(page);
+		}
+	} else
+		present = 1;
+
+ out:
+	return present;
+
+ out_unlock:
+	spin_unlock(&mm->page_table_lock);
+	goto out;
+}
+
+static unsigned char mincore_page(struct vm_area_struct * vma,
+				  unsigned long pgoff)
+{
+	if (vma->vm_file)
+		return mincore_page_inode(vma, pgoff);
+	else
+		return mincore_page_anon(vma, pgoff);
+}
+
 static long mincore_vma(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, unsigned char __user * vec)
 {
 	long error, i, remaining;
 	unsigned char * tmp;
 
-	error = -ENOMEM;
-	if (!vma->vm_file)
-		return error;
-
 	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	if (end > vma->vm_end)
 		end = vma->vm_end;
