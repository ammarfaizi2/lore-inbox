Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTFPPAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFPPAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:00:15 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:50623 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263949AbTFPO60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:58:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16109.56914.269879.622094@gargle.gargle.HOWL>
Date: Mon, 16 Jun 2003 17:12:18 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.71] x86-64 floppy.h missing irqreturn_t conversion
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

In the 2.5.71 x86-64 kernel, floppy.h is incompletely converted
for the recent irqreturn_t changes. This doesn't show up as a
compile-time warning. The error is that floppy_hardint() always
returns IRQ_HANDLED in the !doing_pdma case, instead of returning
whatever floppy_interrupt() returned, which can be IRQ_NONE.

This patch is basically just a merge with asm-i386/floppy.h.

/Mikael

diff -ruN linux-2.5.71-andi/include/asm-x86_64/floppy.h linux-2.5.71-mikpe/include/asm-x86_64/floppy.h
--- linux-2.5.71-andi/include/asm-x86_64/floppy.h	2003-05-28 22:16:03.000000000 +0200
+++ linux-2.5.71-mikpe/include/asm-x86_64/floppy.h	2003-06-16 16:09:26.000000000 +0200
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
-		return IRQ_HANDLED;
-	}
+	if (!doing_pdma)
+		return floppy_interrupt(irq, dev_id, regs);
 
 #ifdef TRACE_FLPY_INT
 	if(!calls)
