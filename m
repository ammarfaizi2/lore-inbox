Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTICOlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTICOlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:41:39 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:58763 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263786AbTICOlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:41:05 -0400
Date: Wed, 3 Sep 2003 15:40:45 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030903144045.GC21530@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain> <20030903025605.5C1722C05F@lists.samba.org> <20030903073628.GA19920@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903073628.GA19920@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch name: futex-nonlinear-2.6.0-test4-02jl
Depends on: futex-fixes-2.6.0-test4-01jl

This fixes a couple of bugs in the previous patch:

   1. A typo in futex.c.  It affects the FUTEX_REQUEUE operation,
      which is a fairly recent addition.

   2. VM_NONLINEAR would not be set under some conditions when it should be.
      The bug only affected futexes on non-linear shared mappings.

Enjoy,
-- Jamie


diff -urN --exclude-from=dontdiff futex1-2.6.0-test4/kernel/futex.c futex2-2.6.0-test4/kernel/futex.c
--- futex1-2.6.0-test4/kernel/futex.c	2003-09-03 12:48:59.000000000 +0100
+++ futex2-2.6.0-test4/kernel/futex.c	2003-09-03 12:56:03.000000000 +0100
@@ -224,7 +224,7 @@
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = __get_page_keys(uaddr2 - offset1, keys1);
+	ret = __get_page_keys(uaddr1 - offset1, keys1);
 	if (unlikely(ret != 0))
 		goto out;
 	ret = __get_page_keys(uaddr2 - offset2, keys2);
diff -urN --exclude-from=dontdiff futex1-2.6.0-test4/mm/fremap.c futex2-2.6.0-test4/mm/fremap.c
--- futex1-2.6.0-test4/mm/fremap.c	2003-09-03 12:29:36.000000000 +0100
+++ futex2-2.6.0-test4/mm/fremap.c	2003-09-03 13:02:35.000000000 +0100
@@ -153,9 +153,9 @@
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end) {
 
-		if (start != vma->vm_start || end != vma->vm_end)
-			vma->vm_flags |= VM_NONLINEAR;
-		else
+		vma->vm_flags |= VM_NONLINEAR;
+		if (start == vma->vm_start && end == vma->vm_end &&
+				pgoff == vma->vm_pgoff)
 			vma->vm_flags &= ~VM_NONLINEAR;
 
 		err = vma->vm_ops->populate(vma, start, size, vma->vm_page_prot,
