Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUFFVrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUFFVrh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUFFVrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:47:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:56450 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264174AbUFFVrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:47:21 -0400
Subject: Re: [PATCH] (urgent) ppc32: Fix CPUs with soft loaded TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org>
References: <1086556255.1859.14.camel@gaston>
	 <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1086558299.1873.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 16:45:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Admittedly on ppc64, the flush_tlb_page_nohash() function would be a
> no-op, since it always has the hash tables, but I'm a blue-eyed optimists,
> and I'm still hoping that some day IBM will see the error of their ways, 
> and get rid of the hash tables entirely. At which point ppc64 too will 
> need to flush the TLB entry.

Hrm... we could. In case you really want it, here's the patch:

Adds a dummy flush_tlb_page_nohash() called by ptep_set_access_bits(),
to be used if we ever have a ppc64 CPU with software loaded TLB.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc64/pgtable.h 1.35 vs edited =====
--- 1.35/include/asm-ppc64/pgtable.h	2004-05-30 23:33:05 -05:00
+++ edited/include/asm-ppc64/pgtable.h	2004-06-06 16:39:49 -05:00
@@ -428,7 +428,10 @@
 	:"cc");
 }
 #define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-        __ptep_set_access_flags(__ptep, __entry, __dirty)
+	do {								   \
+		__ptep_set_access_flags(__ptep, __entry, __dirty);	   \
+		flush_tlb_page_nohash(__vma, __address);	       	   \
+	} while(0)
 
 /*
  * Macro to mark a page protection value as "uncacheable".
===== include/asm-ppc64/tlbflush.h 1.5 vs edited =====
--- 1.5/include/asm-ppc64/tlbflush.h	2004-02-27 06:16:07 -06:00
+++ edited/include/asm-ppc64/tlbflush.h	2004-06-06 16:39:29 -05:00
@@ -6,6 +6,7 @@
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_pgtables(mm, start, end) flushes a range of page tables
@@ -39,6 +40,7 @@
 
 #define flush_tlb_mm(mm)			flush_tlb_pending()
 #define flush_tlb_page(vma, addr)		flush_tlb_pending()
+#define flush_tlb_page_nohash(vma, addr)       	do { } while (0)
 #define flush_tlb_range(vma, start, end) \
 		do { (void)(start); flush_tlb_pending(); } while (0)
 #define flush_tlb_kernel_range(start, end)	flush_tlb_pending()


