Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269238AbUISNAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269238AbUISNAA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 09:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUISNAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 09:00:00 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52823 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269238AbUISM75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 08:59:57 -0400
Date: Sun, 19 Sep 2004 13:59:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix bound checking in do_mmap_pgoff()
In-Reply-To: <1095581234.26670.6.camel@gaston>
Message-ID: <Pine.LNX.4.44.0409191330420.13231-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Benjamin Herrenschmidt wrote:
> 
> A small issue has been forever in do_mmap_pgoff() in the boundary checking
> in the sense that it won't let you mmap with offset+len enclosing the last
> page of the "address space". For example, an mmap of /dev/mem won't let you
> map the last page of the physical address space (which I need for a ROM dump
> tool on pmac). This fixes it:
> -	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
> +	if ((pgoff + (len >> PAGE_SHIFT) - 1) < pgoff)

Your physical address space happens to be 16TB?  Okay...

I think you need to add in the patch below, to prevent mismerging of vmas.
There might be other places which would get confused by an end pgoff of 0.

Hugh

--- 2.6.9-rc2/mm/mmap.c	2004-09-13 17:54:41.000000000 +0100
+++ linux/mm/mmap.c	2004-09-19 13:50:07.650860552 +0100
@@ -529,10 +529,6 @@ static inline int is_mergeable_anon_vma(
  *
  * We cannot merge two vmas if they have differently assigned (non-NULL)
  * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
- *
- * We don't check here for the merged mmap wrapping around the end of pagecache
- * indices (16TB on ia32) because do_mmap_pgoff() does not permit mmap's which
- * wrap, nor mmaps which cover the final page at index -1UL.
  */
 static int
 can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
@@ -540,7 +536,7 @@ can_vma_merge_before(struct vm_area_stru
 {
 	if (is_mergeable_vma(vma, file, vm_flags) &&
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma)) {
-		if (vma->vm_pgoff == vm_pgoff)
+		if (vma->vm_pgoff == vm_pgoff && vm_pgoff != 0)
 			return 1;
 	}
 	return 0;
@@ -561,7 +557,7 @@ can_vma_merge_after(struct vm_area_struc
 	    is_mergeable_anon_vma(anon_vma, vma->anon_vma)) {
 		pgoff_t vm_pglen;
 		vm_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
+		if (vma->vm_pgoff + vm_pglen == vm_pgoff && vm_pgoff != 0)
 			return 1;
 	}
 	return 0;

