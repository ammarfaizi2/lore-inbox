Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTBTMc4>; Thu, 20 Feb 2003 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBTMcl>; Thu, 20 Feb 2003 07:32:41 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:31616 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265446AbTBTMag>; Thu, 20 Feb 2003 07:30:36 -0500
Date: Thu, 20 Feb 2003 21:39:14 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 additional for 2.5.61-ac1 (21/21) traps
Message-ID: <20030220123914.GT1657@yuzuki.cinet.co.jp>
References: <20030220121620.GA1618@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220121620.GA1618@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.61-ac1. (21/21)

Support difference of NMI handling, using mach-* scheme.

diff -Nru linux-2.5.61-ac1/arch/i386/kernel/traps.c linux98-2.5.61/arch/i386/kernel/traps.c
--- linux-2.5.61-ac1/arch/i386/kernel/traps.c	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/traps.c	2003-02-18 13:50:05.000000000 +0900
@@ -50,6 +50,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 
+#include "mach_traps.h"
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -387,8 +389,7 @@
 	printk("You probably have a hardware problem with your RAM chips\n");
 
 	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
+	clear_mem_error(reason);
 }
 
 static void io_check_error(unsigned char reason, struct pt_regs * regs)
@@ -425,7 +426,7 @@
 
 static void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = inb(0x61);
+	unsigned char reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
@@ -449,10 +450,7 @@
 	 * Reassert NMI in case it became active meanwhile
 	 * as it's edge-triggered.
 	 */
-	outb(0x8f, 0x70);
-	inb(0x71);		/* dummy */
-	outb(0x0f, 0x70);
-	inb(0x71);		/* dummy */
+	reassert_nmi();
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
diff -Nru linux/include/asm-i386/mach-default/mach_traps.h linux98/include/asm-i386/mach-default/mach_traps.h
--- linux/include/asm-i386/mach-default/mach_traps.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_traps.h	2002-11-05 22:42:05.000000000 +0900
@@ -0,0 +1,29 @@
+/*
+ *  include/asm-i386/mach-default/mach_traps.h
+ *
+ *  Machine specific NMI handling for generic.
+ *  Split out from traps.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	reason = (reason & 0xf) | 4;
+	outb(reason, 0x61);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return inb(0x61);
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x8f, 0x70);
+	inb(0x71);		/* dummy */
+	outb(0x0f, 0x70);
+	inb(0x71);		/* dummy */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -Nru linux/include/asm-i386/mach-pc9800/mach_traps.h linux98/include/asm-i386/mach-pc9800/mach_traps.h
--- linux/include/asm-i386/mach-pc9800/mach_traps.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_traps.h	2002-11-05 22:46:55.000000000 +0900
@@ -0,0 +1,27 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_traps.h
+ *
+ *  Machine specific NMI handling for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	outb(0x08, 0x37);
+	outb(0x09, 0x37);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return (inb(0x33) & 6) ? 0x80 : 0;
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x09, 0x50);	/* disable NMI once */
+	outb(0x09, 0x52);	/* re-enable it */
+}
+
+#endif /* !_MACH_TRAPS_H */
