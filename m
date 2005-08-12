Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVHLStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVHLStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVHLSt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:27 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39339 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1750942AbVHLSsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:53 -0400
Subject: [patch 30/39] remap_file_pages protection support: ia64 bits
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       mingo@elte.hu
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:13 +0200
Message-Id: <20050812183613.AE59524E7DC@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

I've attached a 'blind' port of the prot bits of fremap to ia64.  I've
compiled it with a cross-compiler but otherwise it's untested.  (and it's
very likely i got the pte bits wrong - but it's roughly OK.)

This should at least make ia64 compile.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-ia64/pgtable.h |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff -puN include/asm-ia64/pgtable.h~rfp-arch-ia64 include/asm-ia64/pgtable.h
--- linux-2.6.git/include/asm-ia64/pgtable.h~rfp-arch-ia64	2005-08-12 19:27:03.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ia64/pgtable.h	2005-08-12 19:27:03.000000000 +0200
@@ -433,7 +433,8 @@ extern void paging_init (void);
  * Format of file pte:
  *	bit   0   : present bit (must be zero)
  *	bit   1   : _PAGE_FILE (must be one)
- *	bits  2-62: file_offset/PAGE_SIZE
+ *	bit   2   : _PAGE_AR_RW
+ *	bits  3-62: file_offset/PAGE_SIZE
  *	bit  63   : _PAGE_PROTNONE bit
  */
 #define __swp_type(entry)		(((entry).val >> 2) & 0x7f)
@@ -442,9 +443,17 @@ extern void paging_init (void);
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define PTE_FILE_MAX_BITS		61
-#define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
-#define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
+#define PTE_FILE_MAX_BITS		59
+#define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 4)
+
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_AR_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(__ACCESS_BITS | _PAGE_PL_3)))
+
+#define pgoff_prot_to_pte(off, prot) \
+       ((pte_t) { _PAGE_FILE + \
+               (pgprot_val(prot) & (_PAGE_AR_RW | _PAGE_PROTNONE)) + (off) })
 
 /* XXX is this right? */
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
_
