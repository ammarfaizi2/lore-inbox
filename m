Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264208AbUEHWFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUEHWFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUEHWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:03:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:7349 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264194AbUEHWC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:02:58 -0400
Date: Sat, 8 May 2004 23:02:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <davidm@hpl.hp.com>,
       <kraxel@bytesex.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 29 VM_RESERVED safety
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082301200.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>

Set VM_RESERVED in videobuf_mmap_mapper, to warn do_no_page and swapout
not to worry about its pages.  Set VM_RESERVED in ia64_elf32_init, it
too provides an unusual nopage which might surprise higher level checks.
Future safety: they don't actually pose a problem in this current tree.

 arch/ia64/ia32/binfmt_elf32.c   |    2 +-
 drivers/media/video/video-buf.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- rmap28/arch/ia64/ia32/binfmt_elf32.c	2004-05-08 20:55:05.446550456 +0100
+++ rmap29/arch/ia64/ia32/binfmt_elf32.c	2004-05-08 20:55:27.517195208 +0100
@@ -78,7 +78,7 @@ ia64_elf32_init (struct pt_regs *regs)
 		vma->vm_start = IA32_GDT_OFFSET;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_page_prot = PAGE_SHARED;
-		vma->vm_flags = VM_READ|VM_MAYREAD;
+		vma->vm_flags = VM_READ|VM_MAYREAD|VM_RESERVED;
 		vma->vm_ops = &ia32_shared_page_vm_ops;
 		down_write(&current->mm->mmap_sem);
 		{
--- rmap28/drivers/media/video/video-buf.c	2004-04-04 03:38:43.000000000 +0100
+++ rmap29/drivers/media/video/video-buf.c	2004-05-08 20:55:27.519194904 +0100
@@ -1176,7 +1176,7 @@ int videobuf_mmap_mapper(struct vm_area_
 	map->end      = vma->vm_end;
 	map->q        = q;
 	vma->vm_ops   = &videobuf_vm_ops;
-	vma->vm_flags |= VM_DONTEXPAND;
+	vma->vm_flags |= VM_DONTEXPAND | VM_RESERVED;
 	vma->vm_flags &= ~VM_IO; /* using shared anonymous pages */
 	vma->vm_private_data = map;
 	dprintk(1,"mmap %p: %08lx-%08lx pgoff %08lx bufs %d-%d\n",

