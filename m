Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTFHAnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTFHAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:43:21 -0400
Received: from holomorphy.com ([66.224.33.161]:49609 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264146AbTFHAnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:43:16 -0400
Date: Sat, 7 Jun 2003 17:55:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-ID: <20030608005543.GM20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org> <20030607132432.26846b8a.akpm@digeo.com> <20030607205046.GL20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607205046.GL20413@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 01:50:46PM -0700, William Lee Irwin III wrote:
> These limits could be slightly relaxed by the kernel with some slightly
> more complex bit twiddlings to recover up to 6 bits of the lower byte
> of a non-present PTE for 64 swapfiles. The limitation on size seems to
> be in userspace.  It appears the kernel has 24 bits for offsets in 4KB
> units, for up to something approaching 64GB swapfiles. Andi Kleen tells
> me newer distributions have fixed the mkswap(8) userspace limitation.
> So non-PAE x86 should be able to do 4TB of aggregate swapspace modulo
> vmallocspace and/or ZONE_NORMAL exhaustion from swap maps. Also, PAE
> should be able to do 64TB of aggregate swapspace (modulo vmallocespace)
> since it has an additional 4 bits usage for page offsets. But I didn't
> audit intensively, so some silly limits may be lurking in dark corners.

Santamarta on #kn tested the following patch to allow up to 64
swapfiles.


diff -prauN linux-2.5.70/include/asm-i386/pgtable.h swap-2.5.70/include/asm-i386/pgtable.h
--- linux-2.5.70/include/asm-i386/pgtable.h	Thu May  1 19:15:41 2003
+++ swap-2.5.70/include/asm-i386/pgtable.h	Sat Jun  7 16:47:04 2003
@@ -106,6 +106,7 @@
 #define _PAGE_BIT_PCD		4
 #define _PAGE_BIT_ACCESSED	5
 #define _PAGE_BIT_DIRTY		6
+#define _PAGE_BIT_FILE		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
 
@@ -320,12 +321,38 @@
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
 
-/* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 1) & 0x1f)
+/*
+ * Encode and de-code a swap entry
+ * PAE could use more swapspace if swp_entry_t were wider, as there
+ * is an additional word in PTE's with 4 bits available. The benefit
+ * of extending it for such is, however, questionable.
+ */
+
 #define __swp_offset(x)			((x).val >> 8)
-#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+
+/*
+ * Bit 0 is reserved for present/non-present, and _PAGE_BIT_FILE is
+ * reserved for non-present PTE's representing file pages.
+ */
+#define __swp_type(entry)						\
+({									\
+	unsigned long __val__ = (entry).val;				\
+	(__val__ & (_PAGE_FILE - 1)) >> 1				\
+		| (__val__ & (_PAGE_FILE << 1)) >> 2;			\
+})
+
+#define __swp_entry(type, offset)					\
+({									\
+	unsigned long __type__ = type;					\
+	(swp_entry_t)							\
+		{ (offset) << 8						\
+			| ((__type__ << 1) & (_PAGE_FILE - 1))		\
+			| ((__type__ << 2) & (_PAGE_FILE << 1)) };	\
+})
+
+#define MAX_SWAPFILES_SHIFT	_PAGE_BIT_FILE
 
 #endif /* !__ASSEMBLY__ */
 
diff -prauN linux-2.5.70/include/linux/swap.h swap-2.5.70/include/linux/swap.h
--- linux-2.5.70/include/linux/swap.h	Wed May  7 21:19:58 2003
+++ swap-2.5.70/include/linux/swap.h	Sat Jun  7 15:09:28 2003
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
@@ -25,10 +26,14 @@
  * be swapped to.  The swap type and the offset into that swap type are
  * encoded into pte's and into pgoff_t's in the swapcache.  Using five bits
  * for the type means that the maximum number of swapcache pages is 27 bits
- * on 32-bit-pgoff_t architectures.  And that assumes that the architecture packs
- * the type/offset into the pte as 5/27 as well.
+ * on 32-bit-pgoff_t architectures.  And that assumes that the
+ * architecture packs the type/offset into the pte as 5/27 as well.
+ * Architectures can override this by simply defining MAX_SWAPFILES_SHIFT
+ * in appropriate headers.
  */
+#ifndef MAX_SWAPFILES_SHIFT
 #define MAX_SWAPFILES_SHIFT	5
+#endif
 #define MAX_SWAPFILES		(1 << MAX_SWAPFILES_SHIFT)
 
 /*
