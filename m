Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUKKRVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUKKRVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbUKKRRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:17:36 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:56494 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262300AbUKKRPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:15:07 -0500
Date: Thu, 11 Nov 2004 18:14:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: get 4 level pgds working.
Message-ID: <20041111171457.GB4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] s390: get 4 level pgds working.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Replace mm->pgd with mm->pml4 in arch/s390 and add pte_read().

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/process.c |    4 ++--
 include/asm-s390/pgtable.h |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-mm/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2004-11-11 15:59:51.000000000 +0100
+++ linux-2.6-mm/arch/s390/kernel/process.c	2004-11-11 15:44:19.000000000 +0100
@@ -261,14 +261,14 @@
 	save_fp_regs(&current->thread.fp_regs);
 	memcpy(&p->thread.fp_regs, &current->thread.fp_regs,
 	       sizeof(s390_fp_regs));
-        p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _SEGMENT_TABLE;
+        p->thread.user_seg = __pa((unsigned long) p->mm->pml4) | _SEGMENT_TABLE;
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS)
 		p->thread.acrs[0] = regs->gprs[6];
 #else /* CONFIG_ARCH_S390X */
 	/* Save the fpu registers to new thread structure. */
 	save_fp_regs(&p->thread.fp_regs);
-        p->thread.user_seg = __pa((unsigned long) p->mm->pgd) | _REGION_TABLE;
+        p->thread.user_seg = __pa((unsigned long) p->mm->pml4) | _REGION_TABLE;
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS) {
 		if (test_thread_flag(TIF_31BIT)) {
diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-mm/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2004-11-11 16:00:42.000000000 +0100
+++ linux-2.6-mm/include/asm-s390/pgtable.h	2004-11-11 15:52:26.000000000 +0100
@@ -398,6 +398,13 @@
 	return (pte_val(pte) & _PAGE_RO) == 0;
 }
 
+static inline int pte_read(pte_t pte)
+{
+	/* A present pte can always be used for reading.
+	 */
+	return 1;
+}
+
 extern inline int pte_dirty(pte_t pte)
 {
 	/* A pte is neither clean nor dirty on s/390. The dirty bit
