Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUDMIkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDMIjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:39:20 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:45664 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263273AbUDMIiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:18 -0400
Date: Tue, 13 Apr 2004 10:38:15 +0200
Message-Id: <200404130838.i3D8cF9b018485@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 435] M68k TLB fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k TLB fixes from Roman Zippel:
  - Check current->active_mm for currently active mm
  - Set correct context to flush the right ATC entry
This is especially important for kswapd to correctly flush unmapped entries (it
caused random segfaults during large compiles)

--- linux-2.6.5/include/asm-m68k/tlbflush.h	2004-04-05 10:41:53.000000000 +0200
+++ linux-m68k-2.6.5/include/asm-m68k/tlbflush.h	2004-04-06 11:03:51.000000000 +0200
@@ -65,20 +65,24 @@
 
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
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
-	if (vma->vm_mm == current->mm)
+	if (vma->vm_mm == current->active_mm)
 		__flush_tlb();
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
