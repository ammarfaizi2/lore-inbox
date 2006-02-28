Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWB1Frm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWB1Frm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWB1Frm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:47:42 -0500
Received: from ozlabs.org ([203.10.76.45]:36027 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750904AbWB1Frm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:47:42 -0500
Date: Tue, 28 Feb 2006 16:47:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: hugepage: Serialize hugepage allocation and instantiation
Message-ID: <20060228054705.GG2570@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies on top of
hugepage-small-fixes-to-hugepage-clear-copy-path.patch in -mm.

Currently, no lock or mutex is held between allocating a hugepage and
inserting it into the pagetables / page cache.  When we do go to
insert the page into pagetables or page cache, we recheck and may free
the newly allocated hugepage.  However, since the number of hugepages
in the system is strictly limited, and it's usualy to want to use all
of them, this can still lead to spurious allocation failures.

For example, suppose two processes are both mapping (MAP_SHARED) the
same hugepage file, large enough to consume the entire available
hugepage pool.  If they race instantiating the last page in the
mapping, they will both attempt to allocate the last available
hugepage.  One will fail, of course, returning OOM from the fault and
thus causing the process to be killed, despite the fact that the
entire mapping can, in fact, be instantiated.

The patch below fixes this race by the simple method of adding a
(sleeping) mutex to serialize the hugepage fault path between
allocation and insertion into pagetables and/or page cache.  It would
be possible to avoid the serialization by catching the allocation
failures, waiting on some condition, then rechecking to see if someone
else has instantiated the page for us.  Given the likely frequency of
hugepage instantiations, it seems very doubtful it's worth the extra
complexity.

This patch causes no regression on the libhugetlbfs testsuite, and one
test, which can trigger this race now passes where it previously
failed.

Actually, the test still sometimes fails, though less often and only
as a shmat() failure, rather processes getting OOM killed by the VM.
The dodgy heuristic tests in fs/hugetlbfs/inode.c for whether there's
enough hugepage space aren't protected by the new mutex, and would be
ugly to do so, so there's still a race there.  Another patch to
replace those tests with something saner for this reason as well as
others coming...

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2006-02-28 16:12:06.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2006-02-28 16:20:36.000000000 +1100
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/mempolicy.h>
 #include <linux/cpuset.h>
+#include <linux/mutex.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -54,6 +55,13 @@ static void copy_huge_page(struct page *
  */
 static DEFINE_SPINLOCK(hugetlb_lock);
 
+/*
+ * Serializes hugepage allocation and instantiation, so that we don't
+ * get spurious allocation failures if two CPUs race to instantiate
+ * the same page in the page cache.
+ */
+static DEFINE_MUTEX(hugetlb_instantiation_mutex);
+
 static void enqueue_huge_page(struct page *page)
 {
 	int nid = page_to_nid(page);
@@ -512,9 +520,13 @@ int hugetlb_fault(struct mm_struct *mm, 
 	if (!ptep)
 		return VM_FAULT_OOM;
 
+	mutex_lock(&hugetlb_instantiation_mutex);
 	entry = *ptep;
-	if (pte_none(entry))
-		return hugetlb_no_page(mm, vma, address, ptep, write_access);
+	if (pte_none(entry)) {
+		ret = hugetlb_no_page(mm, vma, address, ptep, write_access);
+		mutex_unlock(&hugetlb_instantiation_mutex);
+		return ret;
+	}
 
 	ret = VM_FAULT_MINOR;
 
@@ -524,6 +536,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 		if (write_access && !pte_write(entry))
 			ret = hugetlb_cow(mm, vma, address, ptep, entry);
 	spin_unlock(&mm->page_table_lock);
+	mutex_unlock(&hugetlb_instantiation_mutex);
 
 	return ret;
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
