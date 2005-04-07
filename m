Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVDGBPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVDGBPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVDGBPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:15:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63306 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262372AbVDGBOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:14:32 -0400
Date: Thu, 7 Apr 2005 02:14:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] freepgt2: arm FIRST_USER_ADDRESS PAGE_SIZE
In-Reply-To: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0504070213210.24723@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM define FIRST_USER_ADDRESS as PAGE_SIZE (beyond the machine vectors
when they are mapped low), and use that definition in place of locally
defined MIN_MAP_ADDR.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/arm/kernel/sys_arm.c |   11 ++---------
 include/asm-arm/pgtable.h |    7 +++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

--- 2.6.12-rc2-mm1/arch/arm/kernel/sys_arm.c	2005-04-05 15:20:23.000000000 +0100
+++ linux/arch/arm/kernel/sys_arm.c	2005-04-05 18:59:00.000000000 +0100
@@ -51,13 +51,6 @@ asmlinkage int sys_pipe(unsigned long __
 	return error;
 }
 
-/*
- * This is the lowest virtual address we can permit any user space
- * mapping to be mapped at.  This is particularly important for
- * non-high vector CPUs.
- */
-#define MIN_MAP_ADDR	(PAGE_SIZE)
-
 /* common code for old and new mmaps */
 inline long do_mmap2(
 	unsigned long addr, unsigned long len,
@@ -69,7 +62,7 @@ inline long do_mmap2(
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	if (flags & MAP_FIXED && addr < MIN_MAP_ADDR)
+	if (flags & MAP_FIXED && addr < FIRST_USER_ADDRESS)
 		goto out;
 
 	error = -EBADF;
@@ -122,7 +115,7 @@ sys_arm_mremap(unsigned long addr, unsig
 {
 	unsigned long ret = -EINVAL;
 
-	if (flags & MREMAP_FIXED && new_addr < MIN_MAP_ADDR)
+	if (flags & MREMAP_FIXED && new_addr < FIRST_USER_ADDRESS)
 		goto out;
 
 	down_write(&current->mm->mmap_sem);
--- 2.6.12-rc2-mm1/include/asm-arm/pgtable.h	2005-04-05 15:20:55.000000000 +0100
+++ linux/include/asm-arm/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -102,6 +102,13 @@ extern void __pgd_error(const char *file
 #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 
+/*
+ * This is the lowest virtual address we can permit any user space
+ * mapping to be mapped at.  This is particularly important for
+ * non-high vector CPUs.
+ */
+#define FIRST_USER_ADDRESS	PAGE_SIZE
+
 #define FIRST_USER_PGD_NR	1
 #define USER_PTRS_PER_PGD	((TASK_SIZE/PGDIR_SIZE) - FIRST_USER_PGD_NR)
 
