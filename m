Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264835AbUDWPKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbUDWPKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbUDWPKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:10:44 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:61502 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S264835AbUDWPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:10:37 -0400
Date: Fri, 23 Apr 2004 17:10:35 +0200
Message-Id: <200404231510.i3NFAZwk022628@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 152] M68k TLB fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k TLB fixes from Roman Zippel:
  - Check current->active_mm for currently active mm
  - Set correct context to flush the right ATC entry
This is especially important for kswapd to correctly flush unmapped entries (it
caused random segfaults during large compiles)

--- linux-2.4.25/include/asm-m68k/motorola_pgalloc.h	2003-12-23 11:31:10.000000000 +0100
+++ linux-m68k-2.4.25/include/asm-m68k/motorola_pgalloc.h	2004-04-06 10:53:50.000000000 +0200
@@ -231,20 +231,24 @@
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	if (mm == current->mm)
+	if (mm == current->active_mm)
 		__flush_tlb();
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	if (vma->vm_mm == current->mm)
+	if (vma->vm_mm == current->active_mm) {
+		mm_segment_t old_fs = get_fs();
+		set_fs(USER_DS);
 		__flush_tlb_one(addr);
+		set_fs(old_fs);
+	}
 }
 
 static inline void flush_tlb_range(struct mm_struct *mm,
 				   unsigned long start, unsigned long end)
 {
-	if (mm == current->mm)
+	if (mm == current->active_mm)
 		__flush_tlb();
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
