Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUFFVpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUFFVpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUFFVpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:45:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:53890 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264164AbUFFVpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:45:04 -0400
Subject: Re: [PATCH] (urgent) ppc32: Fix CPUs with soft loaded TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org>
References: <1086556255.1859.14.camel@gaston>
	 <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1086558161.10538.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 16:42:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 16:20, Linus Torvalds wrote:
> On Sun, 6 Jun 2004, Benjamin Herrenschmidt wrote:
> > 
> > The recent introduction of ptep_set_access_flags() with the optimisation
> > of not flushing the TLB unfortunately broke ppc32 CPUs with no hash table.
> 
> Makes sense, applied.

ARGH. Missed one file. Here is an additional patch (missed tlbflush.h patch)

Sorry.

This adds the definiction of flush_tlb_page_nohash() that was missing
from the previous patch fixing SW-TLB loaded PPCs

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 
===== include/asm-ppc/tlbflush.h 1.9 vs edited =====
--- 1.9/include/asm-ppc/tlbflush.h	2003-09-15 15:59:05 -05:00
+++ edited/include/asm-ppc/tlbflush.h	2004-06-06 16:01:50 -05:00
@@ -29,6 +29,9 @@
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
 	{ _tlbie(vmaddr); }
+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
+					 unsigned long vmaddr)
+	{ _tlbie(vmaddr); }
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 	{ __tlbia(); }
@@ -44,6 +47,9 @@
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				unsigned long vmaddr)
 	{ _tlbie(vmaddr); }
+static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
+					 unsigned long vmaddr)
+	{ _tlbie(vmaddr); }
 static inline void flush_tlb_range(struct mm_struct *mm,
 				unsigned long start, unsigned long end)
 	{ __tlbia(); }
@@ -56,6 +62,7 @@
 struct vm_area_struct;
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);



