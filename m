Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265122AbUFBHk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbUFBHk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUFBHk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:40:29 -0400
Received: from ozlabs.org ([203.10.76.45]:2249 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265122AbUFBHk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:40:26 -0400
Date: Wed, 2 Jun 2004 17:37:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, Andy Whitworth <apw@shadowen.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, linuxppc64-dev@lists.linuxppc.org
Subject: Yet another hugepage bug
Message-ID: <20040602073742.GA3673@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	Andy Whitworth <apw@shadowen.org>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply

Currently, calling msync() on a hugepage area will cause the kernel to
blow up with a bad_page() (at least on ppc64, but I think the problem
will exist on other archs too).  The msync path attempts to walk
pagetables which may not be there, or may have an unusual layout for
hugepages.

Lucikly we shouldn't need to do anything for an msync on hugetlbfs
beyond flushing the cache, so this patch should be sufficient to fix
the problem.

Index: working-2.6/mm/msync.c
===================================================================
--- working-2.6.orig/mm/msync.c	2004-05-20 12:59:04.000000000 +1000
+++ working-2.6/mm/msync.c	2004-06-02 17:33:50.775695368 +1000
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -106,6 +107,13 @@
 
 	dir = pgd_offset(vma->vm_mm, address);
 	flush_cache_range(vma, address, end);
+
+	/* For hugepages we can't go walking the page table normally,
+	 * but that's ok, hugetlbfs is memory based, so we don't need
+	 * to do anything more on an msync() */
+	if (is_vm_hugetlb_page(vma))
+		goto out;
+
 	if (address >= end)
 		BUG();
 	do {
@@ -118,7 +126,7 @@
 	 * dirty bits.
 	 */
 	flush_tlb_range(vma, end - size, end);
-
+ out:
 	spin_unlock(&vma->vm_mm->page_table_lock);
 
 	return error;


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
