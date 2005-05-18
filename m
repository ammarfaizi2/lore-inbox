Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVERMxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVERMxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVERMxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:53:13 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:35597 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261509AbVERMxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:53:07 -0400
Message-Id: <200505180420.j4I4KDvv017310@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/9] UML - Page fault fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any access to a PROT_NONE page should segfault the process.  A JVM seems to
do this on purpose.  Also, Al noticed some bogus code, which is now deleted.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/trap_kern.c	2005-05-17 16:34:45.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/trap_kern.c	2005-05-17 18:03:10.000000000 -0400
@@ -57,10 +57,11 @@ int handle_page_fault(unsigned long addr
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
+
+        if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
+                goto out;
+
 	page = address & PAGE_MASK;
-	pgd = pgd_offset(mm, page);
-	pud = pud_offset(pgd, page);
-	pmd = pmd_offset(pud, page);
 	do {
  survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){

