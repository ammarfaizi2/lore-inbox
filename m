Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945908AbWBOO1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945908AbWBOO1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBOO1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:27:54 -0500
Received: from gold.veritas.com ([143.127.12.110]:63376 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932453AbWBOO1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:27:54 -0500
X-IronPort-AV: i="4.02,117,1139212800"; 
   d="scan'208"; a="55224809:sNHT29363108"
Date: Wed, 15 Feb 2006 14:28:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: William Irwin <wli@holomorphy.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove VM_DONTCOPY bogosities
Message-ID: <Pine.LNX.4.61.0602151422520.4142@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Feb 2006 14:27:53.0791 (UTC) FILETIME=[01E5ECF0:01C6323C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it's madvisable, remove two pieces of VM_DONTCOPY bogosity:

1. There was and is no logical reason why VM_DONTCOPY should be in the
   list of flags which forbid vma merging (and those drivers which set
   it are also setting VM_IO, which itself forbids the merge).

2. It's hard to understand the purpose of the VM_HUGETLB, VM_DONTCOPY
   block in vm_stat_account: but never mind, it's under CONFIG_HUGETLB,
   which (unlike CONFIG_HUGETLB_PAGE or CONFIG_HUGETLBFS) has never been
   defined.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

---
Looks like wli is offline at present: I had been hoping to hear from him
before removing that block from vm_stat_account; but now that it turns
out never to have done anything anyway, let's go ahead and remove it.

 mm/mmap.c |   10 +---------
 1 files changed, 1 insertion(+), 9 deletions(-)

--- 2.6.16-rc3-git4/mm/mmap.c	2006-02-13 09:38:13.000000000 +0000
+++ linux/mm/mmap.c	2006-02-15 12:42:07.000000000 +0000
@@ -612,7 +612,7 @@ again:			remove_next = 1 + (end > next->
  * If the vma has a ->close operation then the driver probably needs to release
  * per-vma resources, so we don't attempt to merge those.
  */
-#define VM_SPECIAL (VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_RESERVED | VM_PFNMAP)
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_RESERVED | VM_PFNMAP)
 
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
 			struct file *file, unsigned long vm_flags)
@@ -845,14 +845,6 @@ void vm_stat_account(struct mm_struct *m
 	const unsigned long stack_flags
 		= VM_STACK_FLAGS & (VM_GROWSUP|VM_GROWSDOWN);
 
-#ifdef CONFIG_HUGETLB
-	if (flags & VM_HUGETLB) {
-		if (!(flags & VM_DONTCOPY))
-			mm->shared_vm += pages;
-		return;
-	}
-#endif /* CONFIG_HUGETLB */
-
 	if (file) {
 		mm->shared_vm += pages;
 		if ((flags & (VM_EXEC|VM_WRITE)) == VM_EXEC)
