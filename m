Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbTLaW6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTLaW6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:58:54 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:50905 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265277AbTLaW6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:58:53 -0500
Subject: [PATCH] MSI broke voyager build
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 31 Dec 2003 16:58:41 -0600
Message-Id: <1072911523.1892.30.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The author made the arch/i386 compile depend on NR_VECTORS being
defined.

This symbol, however, was put only into mach-default/irq_vectors.h

The attached patch adds it to voyager; visws and pc9800 however, are
still broken.

The code that breaks is this (in arch/i386/kernel/i8259.c):

 	 * us. (some of these will be overridden and become
 	 * 'special' SMP interrupts)
 	 */
-	for (i = 0; i < NR_IRQS; i++) {
+	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
+		if (i >= NR_IRQS)
+			break;
 		if (vector != SYSCALL_VECTOR) 
 			set_intr_gate(vector, interrupt[i]);

as far as I can see, with NR_VECTORS set at 256, FIRST_EXTERNAL_VECTOR
at 32 and NR_IRQS set at 224 the two forms of the loop are identical. 
The only case it would make a difference would be for NR_IRQ >
NR_VECTORS + FIRST_EXTERNAL_VECTOR which doesn't seem to make any
sense.  Perhaps just backing this change out of i8259.c would be
better?  NR_VECTORS seems to have no other defined use in the MSI code.

James


===== include/asm-i386/mach-voyager/irq_vectors.h 1.4 vs edited =====
--- 1.4/include/asm-i386/mach-voyager/irq_vectors.h	Wed Oct 22 11:34:51 2003
+++ edited/include/asm-i386/mach-voyager/irq_vectors.h	Wed Dec 31 16:30:15 2003
@@ -55,6 +55,7 @@
 #define VIC_CPU_BOOT_CPI		VIC_CPI_LEVEL0
 #define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
 
+#define NR_VECTORS 256
 #define NR_IRQS 224
 #define NR_IRQ_VECTORS NR_IRQS
 

