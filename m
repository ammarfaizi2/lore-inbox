Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWIALLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWIALLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIALLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:11:15 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:9656 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751481AbWIALLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:11:11 -0400
Date: Fri, 1 Sep 2006 13:10:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 5/9] Guest page hinting: mlocked pages.
Message-ID: <20060901111022.GF15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 5/9] Guest page hinting: mlocked pages.

Add code to get mlock() working with guest page hinting. The problem
with mlock is that locked pages may not be removed from page cache.
That means they need to be stable. page_make_volatile needs a way to
check if a page has been locked. To avoid traversing vma lists - which
would hurt performance a lot - a field is added in the struct
address_space. This field is set in mlock_fixup if a vma gets mlocked.
The bit never gets removed - once a file had an mlocked vma all future
pages added to it will stay stable.

To complete the picture make_pages_present has to check for the host
page state besides making the pages present in the linux page table.
This is done by a call to get_user_pages with a pages parameter. Since
the VM_LOCKED bit of the vma will be set prior to the call to
get_user_pages an additional check is needed in the try_to_unmap_one
function. If get_user_pages finds a discarded page it needs to remove
the page from the page cache and all page tables dispite the fact that
VM_LOCKED is set. After get_user_pages is back the pages are stable.
The references to the pages can be returned immediatly, the pages will
stay in stable because the mlocked bit is now set for the mapping.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/fs.h |    1 +
 mm/memory.c        |   25 +++++++++++++++++++++++++
 mm/mlock.c         |    2 ++
 mm/page-discard.c  |    5 ++++-
 mm/rmap.c          |   13 +++++++++++--
 5 files changed, 43 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/include/linux/fs.h linux-2.6-patched/include/linux/fs.h
--- linux-2.6/include/linux/fs.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/linux/fs.h	2006-09-01 12:50:24.000000000 +0200
@@ -466,6 +466,7 @@ struct address_space {
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+	unsigned int		mlocked;	/* set if VM_LOCKED vmas present */
 } __attribute__((aligned(sizeof(long))));
 	/*
 	 * On most architectures that alignment is already the case; but
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
@@ -2523,6 +2523,31 @@ int make_pages_present(unsigned long add
 	BUG_ON(addr >= end);
 	BUG_ON(end > vma->vm_end);
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
+
+	if (page_host_discards() && (vma->vm_flags & VM_LOCKED)) {
+		int rlen = len;
+		ret = 0;
+		while (rlen > 0) {
+			struct page *page_refs[32];
+			int chunk, cret, i;
+
+			chunk = rlen < 32 ? rlen : 32;
+			cret = get_user_pages(current, current->mm, addr,
+					      chunk, write, 0,
+					      page_refs, NULL);
+			if (cret > 0) {
+				for (i = 0; i < cret; i++)
+					page_cache_release(page_refs[i]);
+				ret += cret;
+			}
+			if (cret < chunk)
+				return ret ? : cret;
+			addr += 32*PAGE_SIZE;
+			rlen -= 32;
+		}
+		return ret == len ? 0 : -1;
+	}
+
 	ret = get_user_pages(current, current->mm, addr,
 			len, write, 0, NULL, NULL);
 	if (ret < 0)
diff -urpN linux-2.6/mm/mlock.c linux-2.6-patched/mm/mlock.c
--- linux-2.6/mm/mlock.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/mm/mlock.c	2006-09-01 12:50:24.000000000 +0200
@@ -60,6 +60,8 @@ success:
 	 */
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
+		if (vma->vm_file && vma->vm_file->f_mapping)
+			vma->vm_file->f_mapping->mlocked = 1;
 		pages = -pages;
 		if (!(newflags & VM_IO))
 			ret = make_pages_present(start, end);
diff -urpN linux-2.6/mm/page-discard.c linux-2.6-patched/mm/page-discard.c
--- linux-2.6/mm/page-discard.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/page-discard.c	2006-09-01 12:50:24.000000000 +0200
@@ -27,6 +27,8 @@
  */
 static inline int __page_discardable(struct page *page,unsigned int offset)
 {
+	struct address_space *mapping;
+
 	/*
 	 * There are several conditions that prevent a page from becoming
 	 * volatile. The first check is for the page bits.
@@ -42,7 +44,8 @@ static inline int __page_discardable(str
 	 * it volatile. It will be freed soon. If the mapping ever had
 	 * locked pages all pages of the mapping will stay stable.
 	 */
-	if (!page_mapping(page))
+	mapping = page_mapping(page);
+	if (!mapping || mapping->mlocked)
 		return 0;
 
 	/*
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-09-01 12:50:24.000000000 +0200
+++ linux-2.6-patched/mm/rmap.c	2006-09-01 12:50:24.000000000 +0200
@@ -627,8 +627,17 @@ static int try_to_unmap_one(struct page 
 	 */
 	if (!migration && ((vma->vm_flags & VM_LOCKED) ||
 			(ptep_clear_flush_young(vma, address, pte)))) {
-		ret = SWAP_FAIL;
-		goto out_unmap;
+		/*
+		 * Check for discarded pages. This can happen if there have
+		 * been discarded pages before a vma gets mlocked. The code
+		 * in make_pages_present will force all discarded pages out
+		 * and reload them. That happens after the VM_LOCKED bit
+		 * has been set.
+		 */
+		if (likely(!page_host_discards() || !PageDiscarded(page))) {
+			ret = SWAP_FAIL;
+			goto out_unmap;
+		}
 	}
 
 	/* Nuke the page table entry. */
