Return-Path: <linux-kernel-owner+w=401wt.eu-S932250AbWLLRPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWLLRPN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWLLRPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:15:12 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:34651 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbWLLRPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:15:06 -0500
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/4] Fix COW D-cache aliasing on fork
Date: Tue, 12 Dec 2006 17:14:54 +0000
Message-Id: <11659436992820-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11659436971966-git-send-email-ralf@linux-mips.org>
References: <11659436971966-git-send-email-ralf@linux-mips.org>
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

Index: upstream-alias/include/linux/highmem.h
===================================================================
--- upstream-alias.orig/include/linux/highmem.h
+++ upstream-alias/include/linux/highmem.h
@@ -96,6 +96,8 @@ static inline void memclear_highpage_flu
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
+#ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
+
 static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
 {
 	char *vfrom, *vto;
@@ -109,6 +111,8 @@ static inline void copy_user_highpage(st
 	smp_wmb();
 }
 
+#endif
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
