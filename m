Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288925AbSAQSsw>; Thu, 17 Jan 2002 13:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289139AbSAQSsc>; Thu, 17 Jan 2002 13:48:32 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16791 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288925AbSAQSsW>;
	Thu, 17 Jan 2002 13:48:22 -0500
Date: Thu, 17 Jan 2002 12:47:45 -0600
From: David Engebretsen <engebret@vnet.ibm.com>
Message-Id: <200201171847.g0HIljp01458@skunk.rchland.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vm_page_prot value
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is a patch against 2.4.18-pre3 which fixes a problem where the 
protection on user stack pages are not marked executable even though 
the flags indicate the page is executable.  Some more aggressive cache 
flush optimizations may rely on the execution marking to indicate if a page 
needs to be flushed as it might be present in an icache which is not 
coherent with the dcache.

Pat Mccarthy, Don Reed, Dave Engebretsen


diff -Naur linux.orig/fs/exec.c linuxppc64_2_4/fs/exec.c
--- linux.orig/fs/exec.c	Fri Dec 21 11:41:55 2001
+++ linuxppc64_2_4/fs/exec.c	Thu Jan 10 11:32:48 2002
@@ -313,7 +312,7 @@
 		mpnt->vm_mm = current->mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
-		mpnt->vm_page_prot = PAGE_COPY;
+		mpnt->vm_page_prot = protection_map[VM_STACK_FLAGS & 0xf];
 		mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
