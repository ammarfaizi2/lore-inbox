Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUCYXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUCYXBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:01:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63890
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263702AbUCYW60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:58:26 -0500
Date: Thu, 25 Mar 2004 23:59:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: akpm@osdl.org, torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040325225919.GL20019@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

this will allow compilation with hugetlbfs, please review. thanks.

I just finished adapting the priotree to work on my -aa tree (on top of
anonvma and objrmap-core).

It compiles cleanly, next is to try to boot it, in a few hours I will
know more. If it's sort of stable I'll load it in my main desktop and
I'll release a new 2.6-aa with it.

The quality of the prio-tree code is excellent (so it was easy to adapt
to my anon-vma changes that cleanups the vma merging removing useless
locks etc..), thanks.

As soon as the thing works the three patches
(objrmap-core+anon-vma+prio-tree) are ready for inclusion into mainline.

really one could nitpick that anon-vma may need a prio tree too, but
pratically the beauty of anon-vma is that a prio tree is not needed and
in real life it performs a lot better than a find_vma for every mm
mapping the page.

btw, the truncate of hugetlbfs didn't serialize correctly against the
do_no_page page faults, that's fixed too.

--- x/fs/hugetlbfs/inode.c.~1~	2004-03-21 15:09:25.000000000 +0100
+++ x/fs/hugetlbfs/inode.c	2004-03-25 23:50:32.979427008 +0100
@@ -265,11 +265,13 @@ static void hugetlbfs_drop_inode(struct 
  * vma->vm_pgoff is in PAGE_SIZE units.
  */
 static void
-hugetlb_vmtruncate_list(struct list_head *list, unsigned long h_pgoff)
+hugetlb_vmtruncate_list(struct prio_tree_root *root, unsigned long h_pgoff)
 {
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
 
-	list_for_each_entry(vma, list, shared) {
+	vma = __vma_prio_tree_first(root, &iter, h_pgoff, h_pgoff);
+	while (vma) {
 		unsigned long h_vm_pgoff;
 		unsigned long v_length;
 		unsigned long h_length;
@@ -301,6 +303,8 @@ hugetlb_vmtruncate_list(struct list_head
 		zap_hugepage_range(vma,
 				vma->vm_start + v_offset,
 				v_length - v_offset);
+
+		vma = __vma_prio_tree_next(vma, root, &iter, h_pgoff, h_pgoff);
 	}
 }
 
@@ -320,9 +324,11 @@ static int hugetlb_vmtruncate(struct ino
 
 	inode->i_size = offset;
 	down(&mapping->i_shared_sem);
-	if (!list_empty(&mapping->i_mmap))
+	/* Protect against page fault */
+	atomic_inc(&mapping->truncate_count);
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
-	if (!list_empty(&mapping->i_mmap_shared))
+	if (unlikely(!prio_tree_empty(&mapping->i_mmap_shared)))
 		hugetlb_vmtruncate_list(&mapping->i_mmap_shared, pgoff);
 	up(&mapping->i_shared_sem);
 	truncate_hugepages(mapping, offset);
