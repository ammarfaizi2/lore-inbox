Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTDGXxd (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTDGXwK (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:52:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27777
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263888AbTDGX2k (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:28:40 -0400
Date: Tue, 8 Apr 2003 01:47:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080047.h380lUJq009384@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: make APM machine independant using mach headers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/kernel/apm.c linux-2.5.67-ac1/arch/i386/kernel/apm.c
--- linux-2.5.67/arch/i386/kernel/apm.c	2003-04-08 00:37:34.000000000 +0100
+++ linux-2.5.67-ac1/arch/i386/kernel/apm.c	2003-04-04 01:12:19.000000000 +0100
@@ -227,6 +227,8 @@
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 
+#include "io_ports.h"
+
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -295,6 +297,8 @@
  */
 #define APM_ZERO_SEGS
 
+#include "apm.h"
+
 /*
  * Define to make all _set_limit calls use 64k limits.  The APM 1.1 BIOS is
  * supposed to provide limit information that it recognizes.  Many machines
@@ -556,24 +560,11 @@
 		unsigned int saved_fs; unsigned int saved_gs;
 #	define APM_DO_SAVE_SEGS \
 		savesegment(fs, saved_fs); savesegment(gs, saved_gs)
-#	define APM_DO_ZERO_SEGS \
-		"pushl %%ds\n\t" \
-		"pushl %%es\n\t" \
-		"xorl %%edx, %%edx\n\t" \
-		"mov %%dx, %%ds\n\t" \
-		"mov %%dx, %%es\n\t" \
-		"mov %%dx, %%fs\n\t" \
-		"mov %%dx, %%gs\n\t"
-#	define APM_DO_POP_SEGS \
-		"popl %%es\n\t" \
-		"popl %%ds\n\t"
 #	define APM_DO_RESTORE_SEGS \
 		loadsegment(fs, saved_fs); loadsegment(gs, saved_gs)
 #else
 #	define APM_DECL_SEGS
 #	define APM_DO_SAVE_SEGS
-#	define APM_DO_ZERO_SEGS
-#	define APM_DO_POP_SEGS
 #	define APM_DO_RESTORE_SEGS
 #endif
 
@@ -615,22 +606,7 @@
 	local_save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
-	/*
-	 * N.B. We do NOT need a cld after the BIOS call
-	 * because we always save and restore the flags.
-	 */
-	__asm__ __volatile__(APM_DO_ZERO_SEGS
-		"pushl %%edi\n\t"
-		"pushl %%ebp\n\t"
-		"lcall *%%cs:apm_bios_entry\n\t"
-		"setc %%al\n\t"
-		"popl %%ebp\n\t"
-		"popl %%edi\n\t"
-		APM_DO_POP_SEGS
-		: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx),
-		  "=S" (*esi)
-		: "a" (func), "b" (ebx_in), "c" (ecx_in)
-		: "memory", "cc");
+	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
 	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
@@ -673,26 +649,7 @@
 	local_save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
-	{
-		int	cx, dx, si;
-
-		/*
-		 * N.B. We do NOT need a cld after the BIOS call
-		 * because we always save and restore the flags.
-		 */
-		__asm__ __volatile__(APM_DO_ZERO_SEGS
-			"pushl %%edi\n\t"
-			"pushl %%ebp\n\t"
-			"lcall *%%cs:apm_bios_entry\n\t"
-			"setc %%bl\n\t"
-			"popl %%ebp\n\t"
-			"popl %%edi\n\t"
-			APM_DO_POP_SEGS
-			: "=a" (*eax), "=b" (error), "=c" (cx), "=d" (dx),
-			  "=S" (si)
-			: "a" (func), "b" (ebx_in), "c" (ecx_in)
-			: "memory", "cc");
-	}
+	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
 	local_irq_restore(flags);
 	cpu_gdt_table[smp_processor_id()][0x40 / 8] = save_desc_40;
@@ -1212,11 +1169,11 @@
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
 	/* set the clock to 100 Hz */
-	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
-	outb_p(LATCH & 0xff , 0x40);	/* LSB */
+	outb_p(LATCH & 0xff, PIT_CH0);	/* LSB */
 	udelay(10);
-	outb(LATCH >> 8 , 0x40);	/* MSB */
+	outb(LATCH >> 8, PIT_CH0);	/* MSB */
 	udelay(10);
 #endif
 }
