Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVHWSKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVHWSKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVHWSKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:10:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29694 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932265AbVHWSKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:10:18 -0400
Subject: Re: [Hugetlb x86] 1/3 Add pte_huge() macro
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124819866.4415.13.camel@localhost.localdomain>
References: <1124819866.4415.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 23 Aug 2005 13:04:47 -0500
Message-Id: <1124820287.4415.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed whitespace issue in asm-x86_64/pgtable.h

Initial Post (Wed, 17 Aug 2005)

This patch adds a macro pte_huge(pte) for i386/x86_64  which is needed by a
patch later in the series.  Instead of repeating (_PAGE_PRESENT | _PAGE_PSE),
I've added __LARGE_PTE to i386 to match x86_64.

Diffed against 2.6.13-rc6-git7

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 asm-i386/pgtable.h   |    4 +++-
 asm-x86_64/pgtable.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)
diff -upN reference/include/asm-i386/pgtable.h current/include/asm-i386/pgtable.h
--- reference/include/asm-i386/pgtable.h
+++ current/include/asm-i386/pgtable.h
@@ -215,11 +215,13 @@ extern unsigned long pg0[];
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
+#define __LARGE_PTE (_PAGE_PSE | _PAGE_PRESENT)
 static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
+static inline int pte_huge(pte_t pte)		{ return ((pte).pte_low & __LARGE_PTE) == __LARGE_PTE; }
 
 /*
  * The following only works if pte_present() is not true.
@@ -236,7 +238,7 @@ static inline pte_t pte_mkexec(pte_t pte
 static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
-static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
+static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= __LARGE_PTE; return pte; }
 
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
diff -upN reference/include/asm-x86_64/pgtable.h current/include/asm-x86_64/pgtable.h
--- reference/include/asm-x86_64/pgtable.h
+++ current/include/asm-x86_64/pgtable.h
@@ -247,6 +247,7 @@ static inline pte_t pfn_pte(unsigned lon
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
+#define __LARGE_PTE (_PAGE_PSE|_PAGE_PRESENT)
 static inline int pte_user(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 extern inline int pte_read(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 extern inline int pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
@@ -254,8 +255,8 @@ extern inline int pte_dirty(pte_t pte)		
 extern inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 extern inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_huge(pte_t pte)		{ return (pte_val(pte) & __LARGE_PTE) == __LARGE_PTE; }
 
-#define __LARGE_PTE (_PAGE_PSE|_PAGE_PRESENT)
 extern inline pte_t pte_rdprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_USER)); return pte; }
 extern inline pte_t pte_exprotect(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_USER)); return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) & ~_PAGE_DIRTY)); return pte; }


