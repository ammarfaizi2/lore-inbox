Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJANDU>; Tue, 1 Oct 2002 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJANDT>; Tue, 1 Oct 2002 09:03:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31343 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261609AbSJANDJ>; Tue, 1 Oct 2002 09:03:09 -0400
Date: Tue, 1 Oct 2002 14:09:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
In-Reply-To: <dny99icwp0.fsf@magla.zg.iskon.hr>
Message-ID: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Zlatko Calusic wrote:
> 
> Still having problems with Oracle on 2.5.x (it can't even be started),
> I devoted some time trying to pinpoint where the problem is. Reading
> many traces of Oracle, and rebooting a dozen times, I finally found
> that the culprit is weird behaviour of shmat/shmdt functions in 2.5,
> when combined with mprotect() calls. I wrote a simple test app
> (attached) and I'm also appending output of it below (running on
> 2.4.19 & 2.5.39 kernels, see the difference).

Exemplary bug report!  Many thanks for taking so much trouble to
reproduce the problem.  Patch below (against 2.5.39) should fix it:
I'll send Linus and Andrew when I can get hold of a 2.5.40 tree.

Hugh

--- 2.5.39/mm/mmap.c	Fri Sep 20 17:57:49 2002
+++ linux/mm/mmap.c	Tue Oct  1 13:59:54 2002
@@ -1055,7 +1055,7 @@ int split_vma(struct mm_struct * mm, str
 	if (new_below) {
 		new->vm_end = addr;
 		vma->vm_start = addr;
-		vma->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
+		vma->vm_pgoff += ((addr - new->vm_start) >> PAGE_SHIFT);
 	} else {
 		vma->vm_end = addr;
 		new->vm_start = addr;

