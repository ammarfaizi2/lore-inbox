Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946168AbWJSQfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946168AbWJSQfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946194AbWJSQfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:35:33 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:14048 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1946168AbWJSQfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:35:31 -0400
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/3] Fix COW D-cache aliasing on fork
Date: Thu, 19 Oct 2006 17:35:46 +0100
Message-Id: <1161275748231-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Problem:

1. There is a process containing two thread (T1 and T2).  The
   thread T1 calls fork().  Then dup_mmap() function called on T1 context.

static inline int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
	...
	flush_cache_mm(current->mm);
	...	/* A */
	(write-protect all Copy-On-Write pages)
	...	/* B */
	flush_tlb_mm(current->mm);
	...

2. When preemption happens between A and B (or on SMP kernel), the
   thread T2 can run and modify data on COW pages without page fault
   (modified data will stay in cache).

3. Some time after fork() completed, the thread T2 may cause a page
   fault by write-protect on a COW page.

4. Then data of the COW page will be copied to newly allocated
   physical page (copy_cow_page()).  It reads data via kernel mapping.
   The kernel mapping can have different 'color' with user space
   mapping of the thread T2 (dcache aliasing).  Therefore
   copy_cow_page() will copy stale data.  Then the modified data in
   cache will be lost.

In order to allow architecture code to deal with this problem allow
architecture code to override copy_user_highpage() by defining
__HAVE_ARCH_COPY_USER_HIGHPAGE in <asm/page.h>.

The main part of this patch was originally written by Ralf Baechle;
Atushi Nemoto did the the debugging.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/linux/highmem.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: upstream-linus/include/linux/highmem.h
===================================================================
--- upstream-linus.orig/include/linux/highmem.h	2006-10-17 00:14:43.000000000 +0100
+++ upstream-linus/include/linux/highmem.h	2006-10-17 00:15:21.000000000 +0100
@@ -94,6 +94,8 @@ static inline void memclear_highpage_flu
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
+#ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
+
 static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
 {
 	char *vfrom, *vto;
@@ -107,6 +109,8 @@ static inline void copy_user_highpage(st
 	smp_wmb();
 }
 
+#endif
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
