Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUKIKl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUKIKl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUKIKiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:38:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62101 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261472AbUKIKh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:37:29 -0500
Subject: [PATCH 1/11] oprofile: add check_user_page_readable()
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-mTtxKPgocZnGUuToOUQn"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996636.1985.781.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:37:16 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mTtxKPgocZnGUuToOUQn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-mTtxKPgocZnGUuToOUQn
Content-Disposition: attachment; filename=check-user-page
Content-Type: text/plain; name=check-user-page; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Add check_user_page_readable() for kernel modules which need
to follow user space addresses but can't use get_user().

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 include/linux/mm.h |    1 +
 mm/memory.c        |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h	2004-11-06 01:12:07.%N +1100
+++ linux/include/linux/mm.h	2004-11-07 17:59:40.%N +1100
@@ -789,6 +789,7 @@ extern struct page * vmalloc_to_page(voi
 extern unsigned long vmalloc_to_pfn(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
+extern int check_user_page_readable(struct mm_struct *mm, unsigned long address);
 int remap_pfn_range(struct vm_area_struct *, unsigned long,
 		unsigned long, unsigned long, pgprot_t);
 
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c	2004-11-06 01:11:57.%N +1100
+++ linux/mm/memory.c	2004-11-07 17:59:40.%N +1100
@@ -746,8 +746,8 @@ void zap_page_range(struct vm_area_struc
  * Do a quick page-table lookup for a single page.
  * mm->page_table_lock must be held.
  */
-struct page *
-follow_page(struct mm_struct *mm, unsigned long address, int write) 
+static struct page *
+__follow_page(struct mm_struct *mm, unsigned long address, int read, int write)
 {
 	pml4_t *pml4;
 	pgd_t *pgd;
@@ -790,6 +790,8 @@ follow_page(struct mm_struct *mm, unsign
 	if (pte_present(pte)) {
 		if (write && !pte_write(pte))
 			goto out;
+		if (read && !pte_read(pte))
+			goto out;
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
@@ -804,6 +806,20 @@ out:
 	return NULL;
 }
 
+struct page *
+follow_page(struct mm_struct *mm, unsigned long address, int write) 
+{
+	return __follow_page(mm, address, /*read*/0, write);
+}
+
+int
+check_user_page_readable(struct mm_struct *mm, unsigned long address)
+{
+	return __follow_page(mm, address, /*read*/1, /*write*/0) != NULL;
+}
+
+EXPORT_SYMBOL(check_user_page_readable);
+
 /* 
  * Given a physical address, is there a useful struct page pointing to
  * it?  This may become more complex in the future if we start dealing

--=-mTtxKPgocZnGUuToOUQn--

