Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUKPXYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUKPXYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUKPXWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:22:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:39638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261889AbUKPXTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:19:41 -0500
Date: Tue, 16 Nov 2004 15:19:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Message-ID: <20041116151937.E2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Heinz built an a.out binary that could map bss from 0x0 to
0xc0000000, and setup_arg_pages() would BUG() in insert_vma_struct
because the arg pages overlapped.  This just checks before inserting,
and bails out if it would overlap.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/exec.c 1.143 vs edited =====
--- 1.143/fs/exec.c	2004-10-28 00:40:03 -07:00
+++ edited/fs/exec.c	2004-11-11 19:24:54 -08:00
@@ -413,6 +413,7 @@
 
 	down_write(&mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
 		mpnt->vm_mm = mm;
 #ifdef CONFIG_STACK_GROWSUP
 		mpnt->vm_start = stack_base;
@@ -433,6 +434,12 @@
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
+		vma = find_vma(mm, mpnt->vm_start);
+		if (vma) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(mm, mpnt);
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}
