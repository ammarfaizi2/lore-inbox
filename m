Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWD3RfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWD3RfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWD3RdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:14 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45266 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751185AbWD3Rcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:42 -0400
Message-Id: <20060430173024.179054000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:00 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 07/14] remap_file_pages protection support: support private vma for MAP_POPULATE
Content-Disposition: inline; filename=rfp/07-rfp-private-vma.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Fix mmap(MAP_POPULATE | MAP_PRIVATE). We don't need the VMA to be shared if we
don't rearrange pages around. And it's trivial to do.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/mm/fremap.c
===================================================================
--- linux-2.6.git.orig/mm/fremap.c
+++ linux-2.6.git/mm/fremap.c
@@ -184,9 +184,6 @@ retry:
 	if (!vma)
 		goto out_unlock;
 
-	if (!(vma->vm_flags & VM_SHARED))
-		goto out_unlock;
-
 	if (!vma->vm_ops || !vma->vm_ops->populate)
 		goto out_unlock;
 
@@ -211,6 +208,8 @@ retry:
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start) &&
 		    !(vma->vm_flags & VM_NONLINEAR)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!has_write_lock) {
 				up_read(&mm->mmap_sem);
 				down_write(&mm->mmap_sem);
@@ -229,6 +228,8 @@ retry:
 
 		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
 				!(vma->vm_flags & VM_MANYPROTS)) {
+			if (!(vma->vm_flags & VM_SHARED))
+				goto out_unlock;
 			if (!has_write_lock) {
 				up_read(&mm->mmap_sem);
 				down_write(&mm->mmap_sem);

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
