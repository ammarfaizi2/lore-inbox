Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVKQTbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVKQTbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKQTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:31:24 -0500
Received: from gold.veritas.com ([143.127.12.110]:29751 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964802AbVKQTbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:31:23 -0500
Date: Thu, 17 Nov 2005 19:30:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] unpaged: private write VM_RESERVED
In-Reply-To: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:31:22.0987 (UTC) FILETIME=[7E3F3BB0:01C5EBAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PageReserved removal in 2.6.15-rc1 issued a "deprecated" message
when you tried to mmap or mprotect MAP_PRIVATE PROT_WRITE a VM_RESERVED,
and failed with -EACCES: because do_wp_page lacks the refinement to COW
pages in those areas, nor do we expect to find anonymous pages in them;
and it seemed just bloat to add code for handling such a peculiar case.
But immediately it caused vbetool and ddcprobe (using lrmi) to fail.

So revert the "deprecated" messages, letting mmap and mprotect succeed.
But leave do_wp_page's BUG_ON(vma->vm_flags & VM_RESERVED) in place
until we've added the code to do it right: so this particular patch is
only good if the app doesn't really need to write to that private area.

Dave Jones has changed vbetool & ddcprobe to use MAP_SHARED or PROT_READ
just as well, but we don't want to force people to update their tools.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c     |   11 -----------
 mm/mprotect.c |    8 --------
 2 files changed, 19 deletions(-)

--- unpaged01/mm/mmap.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged02/mm/mmap.c	2005-11-17 15:10:20.000000000 +0000
@@ -1076,17 +1076,6 @@ munmap_back:
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-		if ((vma->vm_flags & (VM_SHARED | VM_WRITE | VM_RESERVED))
-						== (VM_WRITE | VM_RESERVED)) {
-			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
-				"PROT_WRITE mmap of VM_RESERVED memory, which "
-				"is deprecated. Please report this to "
-				"linux-kernel@vger.kernel.org\n",current->comm);
-			if (vma->vm_ops && vma->vm_ops->close)
-				vma->vm_ops->close(vma);
-			error = -EACCES;
-			goto unmap_and_free_vma;
-		}
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
--- unpaged01/mm/mprotect.c	2005-11-12 09:01:25.000000000 +0000
+++ unpaged02/mm/mprotect.c	2005-11-17 15:10:20.000000000 +0000
@@ -124,14 +124,6 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (oldflags & VM_RESERVED) {
-			BUG_ON(oldflags & VM_WRITE);
-			printk(KERN_WARNING "program %s is using MAP_PRIVATE, "
-				"PROT_WRITE mprotect of VM_RESERVED memory, "
-				"which is deprecated. Please report this to "
-				"linux-kernel@vger.kernel.org\n",current->comm);
-			return -EACCES;
-		}
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED|VM_HUGETLB))) {
 			charged = nrpages;
 			if (security_vm_enough_memory(charged))
