Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261879AbSIYCP6>; Tue, 24 Sep 2002 22:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261880AbSIYCP6>; Tue, 24 Sep 2002 22:15:58 -0400
Received: from dp.samba.org ([66.70.73.150]:24812 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261879AbSIYCP5>;
	Tue, 24 Sep 2002 22:15:57 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15761.7405.707435.845733@argo.ozlabs.ibm.com>
Date: Wed, 25 Sep 2002 12:18:21 +1000 (EST)
To: torvalds@transmeta.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix null dereference in sys_mprotect
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

As it is at the moment, sys_mprotect will dereference a null pointer
if you use it on a region that is contained within the first vma.  I
have a little program that demonstrates this (I'll post it if anyone
is interested).  What happens then is that the process hangs in
do_page_fault at the down_read on the mm->mmap_sem, since sys_mprotect
has done a down_write on mm->mmap_sem.

The problem is that mprotect_fixup isn't updating prev properly.  Thus
we can finish the main loop in sys_mprotect with prev == NULL.  This
has been the case since Christoph's cleanups went in.  Prior to that,
mprotect_fixup always set prev to something non-NULL.  I suspect that
not updating prev could also cause vmas to get dropped completely if
the region being mprotected spans more than one vma.

The patch below fixes the problem by making mprotect_fixup set prev to
a reasonable value in all circumstances.

Paul.

diff -urN linux-2.5/mm/mprotect.c pmac-2.5/mm/mprotect.c
--- linux-2.5/mm/mprotect.c	Wed Sep 18 15:42:48 2002
+++ pmac-2.5/mm/mprotect.c	Wed Sep 25 10:39:49 2002
@@ -193,6 +193,11 @@
 		if (error)
 			goto fail;
 	}
+	/*
+	 * Unless it returns an error, this function always sets *pprev to
+	 * the first vma for which vma->vm_end >= end.
+	 */
+	*pprev = vma;
 
 	if (end != vma->vm_end) {
 		error = split_vma(mm, vma, end, 0);
