Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVBQPlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVBQPlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVBQPlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:41:08 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:29540 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262259AbVBQPkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:40:20 -0500
Message-ID: <4214BAE0.1000500@yahoo.com.au>
Date: Fri, 18 Feb 2005 02:40:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] trim unused functions
References: <4214BA18.50604@yahoo.com.au>
In-Reply-To: <4214BA18.50604@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------010700070100040104000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010700070100040104000604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And lastly, redo this vital optimisation that David
had to remove earlier. Saves a few bytes.


--------------010700070100040104000604
Content-Type: text/plain;
 name="vm-trim-unused.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-trim-unused.patch"




---

 linux-2.6-npiggin/include/asm-generic/pgtable-nopmd.h |    2 ++
 linux-2.6-npiggin/include/asm-generic/pgtable-nopud.h |    2 ++
 linux-2.6-npiggin/mm/memory.c                         |    8 +++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff -puN include/asm-generic/pgtable-nopud.h~vm-trim-unused include/asm-generic/pgtable-nopud.h
--- linux-2.6/include/asm-generic/pgtable-nopud.h~vm-trim-unused	2005-02-18 02:14:30.000000000 +1100
+++ linux-2.6-npiggin/include/asm-generic/pgtable-nopud.h	2005-02-18 02:15:41.000000000 +1100
@@ -3,6 +3,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define __PAGETABLE_PUD_FOLDED
+
 /*
  * Having the pud type consist of a pgd gets the size right, and allows
  * us to conceptually access the pgd entry that this pud is folded into
diff -puN include/asm-generic/pgtable-nopmd.h~vm-trim-unused include/asm-generic/pgtable-nopmd.h
--- linux-2.6/include/asm-generic/pgtable-nopmd.h~vm-trim-unused	2005-02-18 02:14:32.000000000 +1100
+++ linux-2.6-npiggin/include/asm-generic/pgtable-nopmd.h	2005-02-18 02:15:31.000000000 +1100
@@ -5,6 +5,8 @@
 
 #include <asm-generic/pgtable-nopud.h>
 
+#define __PAGETABLE_PMD_FOLDED
+
 /*
  * Having the pmd type consist of a pud gets the size right, and allows
  * us to conceptually access the pud entry that this pmd is folded into
diff -puN mm/memory.c~vm-trim-unused mm/memory.c
--- linux-2.6/mm/memory.c~vm-trim-unused	2005-02-18 02:14:44.000000000 +1100
+++ linux-2.6-npiggin/mm/memory.c	2005-02-18 02:17:34.000000000 +1100
@@ -2006,6 +2006,8 @@ int handle_mm_fault(struct mm_struct *mm
 }
 
 #ifndef __ARCH_HAS_4LEVEL_HACK
+
+#ifndef __PAGETABLE_PUD_FOLDED
 /*
  * Allocate page upper directory.
  *
@@ -2037,7 +2039,9 @@ pud_t fastcall *__pud_alloc(struct mm_st
  out:
 	return pud_offset(pgd, address);
 }
+#endif /* __PAGETABLE_PUD_FOLDED */
 
+#ifndef __PAGETABLE_PMD_FOLDED
 /*
  * Allocate page middle directory.
  *
@@ -2069,7 +2073,9 @@ pmd_t fastcall *__pmd_alloc(struct mm_st
  out:
 	return pmd_offset(pud, address);
 }
-#else
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+#else /* __ARCH_HAS_4LEVEL_HACK */
 pmd_t fastcall *__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	pmd_t *new;

_

--------------010700070100040104000604--

