Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268404AbTBNNCT>; Fri, 14 Feb 2003 08:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268417AbTBNMxK>; Fri, 14 Feb 2003 07:53:10 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:22542 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268409AbTBNMwj>;
	Fri, 14 Feb 2003 07:52:39 -0500
Date: Fri, 14 Feb 2003 15:57:53 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: export some functions from i8259.c (2/13)
Message-ID: <20030214125753.GB8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This trivial patch exports some functions from 8259.c file.
Visws subarch needs them to handle interrupts from legacy devices 
connected to PIIX4 i8259s, which are in turn connected to SGI 
Cobalt APIC.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-i8259

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/i8259.h linux-2.5.60/include/asm-i386/i8259.h
--- linux-2.5.60.vanilla/include/asm-i386/i8259.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/include/asm-i386/i8259.h	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,17 @@
+#ifndef __ASM_I8259_H__
+#define __ASM_I8259_H__
+
+extern unsigned int cached_irq_mask;
+
+#define __byte(x,y) 	(((unsigned char *) &(y))[x])
+#define cached_21	(__byte(0, cached_irq_mask))
+#define cached_A1	(__byte(1, cached_irq_mask))
+
+extern spinlock_t i8259A_lock;
+
+extern void init_8259A(int auto_eoi);
+extern void enable_8259A_irq(unsigned int irq);
+extern void disable_8259A_irq(unsigned int irq);
+extern unsigned int startup_8259A_irq(unsigned int irq);
+
+#endif	/* __ASM_I8259_H__ */
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/kernel/i8259.c linux-2.5.60/arch/i386/kernel/i8259.c
--- linux-2.5.60.vanilla/arch/i386/kernel/i8259.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/kernel/i8259.c	Thu Feb 13 20:42:02 2003
@@ -22,6 +22,7 @@
 #include <asm/desc.h>
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
+#include <asm/i8259.h>
 
 #include <linux/irq.h>
 
@@ -47,7 +48,7 @@
 
 void mask_and_ack_8259A(unsigned int);
 
-static unsigned int startup_8259A_irq(unsigned int irq)
+unsigned int startup_8259A_irq(unsigned int irq)
 { 
 	enable_8259A_irq(irq);
 	return 0; /* never anything pending */
@@ -71,11 +72,7 @@
 /*
  * This contains the irq mask for both 8259A irq controllers,
  */
-static unsigned int cached_irq_mask = 0xffff;
-
-#define __byte(x,y) 	(((unsigned char *)&(y))[x])
-#define cached_21	(__byte(0,cached_irq_mask))
-#define cached_A1	(__byte(1,cached_irq_mask))
+unsigned int cached_irq_mask = 0xffff;
 
 /*
  * Not all IRQs can be routed through the IO-APIC, eg. on certain (older)

--GPJrCs/72TxItFYR--
