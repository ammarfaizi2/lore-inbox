Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319062AbSHSWXJ>; Mon, 19 Aug 2002 18:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319063AbSHSWXJ>; Mon, 19 Aug 2002 18:23:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61578 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S319062AbSHSWXI>; Mon, 19 Aug 2002 18:23:08 -0400
Date: Mon, 19 Aug 2002 23:27:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mremap corrupts freed vma
Message-ID: <Pine.LNX.4.44.0208192311300.6887-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My tricksy accounting code in mremap's move_vma assumed 2.4 behaviour
in do_munmap, which preserved vma: but 2.5 splitvma may substitute it.
Showed up as Committed_AS growing each time kernel built with kallsyms;
but more seriously, it was writing to an area already kmem_cache_freed.

Patch against 2.5.31 or today's BK: please apply before others corrupted!

--- 2.5.31/mm/mremap.c	Fri Aug  2 21:15:57 2002
+++ linux/mm/mremap.c	Mon Aug 19 22:13:33 2002
@@ -220,6 +220,8 @@
 					split = 1;
 			} else if (addr + old_len == vma->vm_end)
 				vma = NULL;	/* it will be removed */
+			else
+				split = -1;	/* vma may be changed */
 		} else
 			vma = NULL;		/* nothing more to do */
 
@@ -227,8 +229,10 @@
 
 		/* Restore VM_ACCOUNT if one or two pieces of vma left */
 		if (vma) {
+			if (split < 0)
+				vma = find_vma(mm, addr + old_len);
 			vma->vm_flags |= VM_ACCOUNT;
-			if (split)
+			if (split > 0)
 				vma->vm_next->vm_flags |= VM_ACCOUNT;
 		}
 		current->mm->total_vm += new_len >> PAGE_SHIFT;

