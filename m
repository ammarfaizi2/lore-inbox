Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTEFNwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTEFNv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:51:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:16260 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263726AbTEFNvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:51:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.49364.106094.795419@gargle.gargle.HOWL>
Date: Tue, 6 May 2003 16:04:04 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix x86_64 pte_user() and floppy.h for 2.5.69
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

2.5.69 failed to link on x86_64 due to a missing reference to pte_user().
I simply stole the one that i386 added in .68 -> .69.
There's also irqreturn_t warnings on floppy.h -- fixed also by syncing
with i386' floppy.h.

Boots fine on Simics.

/Mikael

--- linux-2.5.69/include/asm-x86_64/floppy.h.~1~	2003-05-05 22:56:30.000000000 +0200
+++ linux-2.5.69/include/asm-x86_64/floppy.h	2003-05-06 15:19:34.000000000 +0200
@@ -22,7 +22,7 @@
  * floppy accesses go through the track buffer.
  */
 #define _CROSS_64KB(a,s,vdma) \
-(!vdma && ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64))
+(!(vdma) && ((unsigned long)(a)/K_64 != ((unsigned long)(a) + (s) - 1) / K_64))
 
 #define CROSS_64KB(a,s) _CROSS_64KB(a,s,use_virtual_dma & 1)
 
@@ -62,10 +62,8 @@
 	static int bytes=0;
 	static int dma_wait=0;
 #endif
-	if(!doing_pdma) {
-		floppy_interrupt(irq, dev_id, regs);
-		return;
-	}
+	if (!doing_pdma)
+		return floppy_interrupt(irq, dev_id, regs);
 
 #ifdef TRACE_FLPY_INT
 	if(!calls)
@@ -96,7 +94,7 @@
 	calls++;
 #endif
 	if(st == 0x20)
-		return;
+		return IRQ_HANDLED;
 	if(!(st & 0x20)) {
 		virtual_dma_residue += virtual_dma_count;
 		virtual_dma_count=0;
--- linux-2.5.69/include/asm-x86_64/pgtable.h.~1~	2003-04-08 01:47:26.000000000 +0200
+++ linux-2.5.69/include/asm-x86_64/pgtable.h	2003-05-06 15:12:40.000000000 +0200
@@ -241,6 +241,7 @@
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
+extern inline int pte_user(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 extern inline int pte_read(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 extern inline int pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_USER; }
 extern inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
