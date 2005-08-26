Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVHZRIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVHZRIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbVHZRHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:07:52 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:29845 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965118AbVHZRB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:01:58 -0400
Subject: [patch 06/18] remap_file_pages protection support: support private vma for MAP_POPULATE
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:17 +0200
Message-Id: <20050826165318.51AC524B54C@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

Fix MAP_POPULATE | MAP_PRIVATE. We don't need the VMA to be shared if we don't
rearrange pages around. And it's trivial to do.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |    7 ++++---
 linux-2.6.git-paolo/mm/mmap.c   |    4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff -puN mm/fremap.c~rfp-private-vma-2 mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-private-vma-2	2005-08-24 20:57:13.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-24 20:57:13.000000000 +0200
@@ -221,9 +221,6 @@ retry:
 	if (!vma)
 		goto out_unlock;
 
-	if (!(vma->vm_flags & VM_SHARED))
-		goto out_unlock;
-
 	if (!vma->vm_ops || !vma->vm_ops->populate || end <= start || start <
 			vma->vm_start || end > vma->vm_end)
 		goto out_unlock;
@@ -246,6 +243,8 @@ retry:
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start) &&
 		    !(vma->vm_flags & VM_NONLINEAR)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!has_write_lock) {
 				up_read(&mm->mmap_sem);
 				down_write(&mm->mmap_sem);
@@ -264,6 +263,8 @@ retry:
 
 		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
 				!(vma->vm_flags & VM_NONUNIFORM)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!has_write_lock) {
 				up_read(&mm->mmap_sem);
 				down_write(&mm->mmap_sem);
diff -puN mm/mmap.c~rfp-private-vma-2 mm/mmap.c
--- linux-2.6.git/mm/mmap.c~rfp-private-vma-2	2005-08-24 20:57:13.000000000 +0200
+++ linux-2.6.git-paolo/mm/mmap.c	2005-08-24 20:57:13.000000000 +0200
@@ -1124,6 +1124,10 @@ out:	
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);
+		/*
+		 * remap_file_pages() works even if the mapping is private,
+		 * in the linearly-mapped case:
+		 */
 		sys_remap_file_pages(addr, len, 0,
 					pgoff, flags & MAP_NONBLOCK);
 		down_write(&mm->mmap_sem);
_
