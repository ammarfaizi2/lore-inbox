Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268286AbUHYTHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268286AbUHYTHQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYTHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:07:16 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:26134 "EHLO
	kernel.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S268286AbUHYTGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:06:54 -0400
Subject: [patch 1/2] make page table index functions take void*
To: ak@muc.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 25 Aug 2004 12:06:08 -0700
Message-Id: <E1C0363-0007uM-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi, since this is your code, I thought I'd send these to you to look over
first.  Do you have any good test cases for this code?  I don't think I have
any hardware that uses the NX bit.  

Instead of casting the void*'s into "unsigned long"s to pass into the pagetable
functions: p{gd,md,te}_index(), do a cast inside the macro.  All of the current
callers should be "unsigned long"s already, so this should have no other
effect than making it valid to pass a void* to those functions.  

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/asm-i386/pgtable.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN include/asm-i386/pgtable.h~AA0-index-functions-take-voidstar include/asm-i386/pgtable.h
--- memhotplug/include/asm-i386/pgtable.h~AA0-index-functions-take-voidstar	2004-08-25 11:53:57.000000000 -0700
+++ memhotplug-dave/include/asm-i386/pgtable.h	2004-08-25 11:58:08.000000000 -0700
@@ -309,7 +309,8 @@ static inline pte_t pte_modify(pte_t pte
  * this macro returns the index of the entry in the pgd page which would
  * control the given virtual address
  */
-#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index(address) \
+	(((unsigned long)(address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
 /*
  * pgd_offset() returns a (pgd_t *)
@@ -330,7 +331,7 @@ static inline pte_t pte_modify(pte_t pte
  * control the given virtual address
  */
 #define pmd_index(address) \
-		(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+		(((unsigned long)(address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
@@ -339,7 +340,7 @@ static inline pte_t pte_modify(pte_t pte
  * control the given virtual address
  */
 #define pte_index(address) \
-		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+		(((unsigned long)(address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) \
 	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
 
_
