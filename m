Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVDGBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVDGBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVDGBTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:19:06 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:49001 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262369AbVDGBQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:16:30 -0400
Date: Thu, 7 Apr 2005 02:16:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] freepgt2: arm26 FIRST_USER_ADDRESS PAGE_SIZE
In-Reply-To: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0504070214490.24723@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM26 define FIRST_USER_ADDRESS as PAGE_SIZE (beyond the machine vectors
when they are mapped low), and use that definition in place of locally
defined MIN_MAP_ADDR.  Previously, ARM26 permitted user mappings at 0 if
the machine vectors were mapped high; but that's inconsistent with ARM,
and FIRST_USER_ADDRESS would then have to be determined at runtime.
Let's fix it at PAGE_SIZE throughout the architecture.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/arm26/kernel/sys_arm.c |    9 ++++-----
 include/asm-arm26/pgtable.h |    7 +++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

--- 2.6.12-rc2-mm1/arch/arm26/kernel/sys_arm.c	2005-03-02 07:38:58.000000000 +0000
+++ linux/arch/arm26/kernel/sys_arm.c	2005-04-05 18:59:00.000000000 +0100
@@ -64,10 +64,10 @@ inline long do_mmap2(
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
 	/*
-	 * If we are doing a fixed mapping, and address < PAGE_SIZE,
+	 * If we are doing a fixed mapping, and address < FIRST_USER_ADDRESS,
 	 * then deny it.
 	 */
-	if (flags & MAP_FIXED && addr < PAGE_SIZE && vectors_base() == 0)
+	if (flags & MAP_FIXED && addr < FIRST_USER_ADDRESS)
 		goto out;
 
 	error = -EBADF;
@@ -121,11 +121,10 @@ sys_arm_mremap(unsigned long addr, unsig
 	unsigned long ret = -EINVAL;
 
 	/*
-	 * If we are doing a fixed mapping, and address < PAGE_SIZE,
+	 * If we are doing a fixed mapping, and address < FIRST_USER_ADDRESS,
 	 * then deny it.
 	 */
-	if (flags & MREMAP_FIXED && new_addr < PAGE_SIZE &&
-	    vectors_base() == 0)
+	if (flags & MREMAP_FIXED && new_addr < FIRST_USER_ADDRESS)
 		goto out;
 
 	down_write(&current->mm->mmap_sem);
--- 2.6.12-rc2-mm1/include/asm-arm26/pgtable.h	2005-04-05 15:20:55.000000000 +0100
+++ linux/include/asm-arm26/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -62,6 +62,13 @@
 #define PTRS_PER_PMD            1
 #define PTRS_PER_PTE            32
 
+/*
+ * This is the lowest virtual address we can permit any user space
+ * mapping to be mapped at.  This is particularly important for
+ * non-high vector CPUs.
+ */
+#define FIRST_USER_ADDRESS	PAGE_SIZE
+
 #define FIRST_USER_PGD_NR       1
 #define USER_PTRS_PER_PGD       ((TASK_SIZE/PGD_SIZE) - FIRST_USER_PGD_NR)
 
