Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTCFMQ4>; Thu, 6 Mar 2003 07:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267778AbTCFMQz>; Thu, 6 Mar 2003 07:16:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16738 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S264628AbTCFMQy>; Thu, 6 Mar 2003 07:16:54 -0500
Date: Thu, 6 Mar 2003 12:29:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vm_area_struct slab corruption
Message-ID: <Pine.LNX.4.44.0303061208470.2196-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix vm_area_struct slab corruption due to mremap's move_vma mistaking
(okay, okay, _my_ mistaking) how do_munmap splits vmas in one case.

This patch fits do_munmap to move_vma's expectation: you may well feel
that's the wrong way round to fix it (and not the way I promised a few
days ago), but at present I'm more comfortable with this simpler fix;
and it does seem preferable for do_munmap to reuse the existing vma.

Hugh

--- 2.5.64/mm/mmap.c	Wed Mar  5 07:26:34 2003
+++ linux/mm/mmap.c	Thu Mar  6 11:47:44 2003
@@ -1258,20 +1258,24 @@
  
 	/*
 	 * If we need to split any vma, do it now to save pain later.
+	 *
+	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
+	 * unmapped vm_area_struct will remain in use: so lower split_vma
+	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > mpnt->vm_start) {
 		if (split_vma(mm, mpnt, start, 0))
 			return -ENOMEM;
 		prev = mpnt;
-		mpnt = mpnt->vm_next;
 	}
 
 	/* Does it split the last one? */
 	last = find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		if (split_vma(mm, last, end, 0))
+		if (split_vma(mm, last, end, 1))
 			return -ENOMEM;
 	}
+	mpnt = prev? prev->vm_next: mm->mmap;
 
 	/*
 	 * Remove the vma's, and unmap the actual pages

