Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268095AbTBWJbn>; Sun, 23 Feb 2003 04:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTBWJbn>; Sun, 23 Feb 2003 04:31:43 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:41344 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268095AbTBWJ3W>; Sun, 23 Feb 2003 04:29:22 -0500
Date: Sun, 23 Feb 2003 18:36:48 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (2/21) APM
Message-ID: <20030223093648.GC1324@yuzuki.cinet.co.jp>
References: <20030223092116.GA1324@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223092116.GA1324@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.62-ac1. (2/21)

APM support for PC98. Including PC98's BIOS bug fix.
I've cleaned up this patch by using mach-* scheme.

Regards,
Osamu Tomita

diff -Nru linux-2.5.62/arch/i386/kernel/apm.c linux98-2.5.62/arch/i386/kernel/apm.c
--- linux-2.5.62/arch/i386/kernel/apm.c	2003-02-22 08:34:41.000000000 +0900
+++ linux98-2.5.62/arch/i386/kernel/apm.c	2003-02-23 16:37:51.000000000 +0900
@@ -226,6 +226,8 @@
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 
+#include "io_ports.h"
+
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -294,6 +296,8 @@
  */
 #define APM_ZERO_SEGS
 
+#include "apm.h"
+
 /*
  * Define to make all _set_limit calls use 64k limits.  The APM 1.1 BIOS is
  * supposed to provide limit information that it recognizes.  Many machines
@@ -555,24 +559,11 @@
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
 
@@ -614,22 +605,7 @@
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
@@ -672,26 +648,7 @@
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
@@ -1211,11 +1168,11 @@
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
diff -Nru linux-2.5.62/include/asm-i386/mach-default/apm.h linux98-2.5.62/include/asm-i386/mach-default/apm.h
--- linux-2.5.62/include/asm-i386/mach-default/apm.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.62/include/asm-i386/mach-default/apm.h	2003-02-23 16:34:37.000000000 +0900
@@ -0,0 +1,75 @@
+/*
+ *  include/asm-i386/mach-default/apm.h
+ *
+ *  Machine specific APM BIOS functions for generic.
+ *  Split out from apm.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+#ifndef _ASM_APM_H
+#define _ASM_APM_H
+
+#ifdef APM_ZERO_SEGS
+#	define APM_DO_ZERO_SEGS \
+		"pushl %%ds\n\t" \
+		"pushl %%es\n\t" \
+		"xorl %%edx, %%edx\n\t" \
+		"mov %%dx, %%ds\n\t" \
+		"mov %%dx, %%es\n\t" \
+		"mov %%dx, %%fs\n\t" \
+		"mov %%dx, %%gs\n\t"
+#	define APM_DO_POP_SEGS \
+		"popl %%es\n\t" \
+		"popl %%ds\n\t"
+#else
+#	define APM_DO_ZERO_SEGS
+#	define APM_DO_POP_SEGS
+#endif
+
+static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
+					u32 *eax, u32 *ebx, u32 *ecx,
+					u32 *edx, u32 *esi)
+{
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%al\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx),
+		  "=S" (*esi)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+}
+
+static inline u8 apm_bios_call_simple_asm(u32 func, u32 ebx_in,
+						u32 ecx_in, u32 *eax)
+{
+	int	cx, dx, si;
+	u8	error;
+
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%bl\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (error), "=c" (cx), "=d" (dx),
+		  "=S" (si)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+	return error;
+}
+
+#endif /* _ASM_APM_H */
diff -Nru linux-2.5.62/include/asm-i386/mach-pc9800/apm.h linux98-2.5.62/include/asm-i386/mach-pc9800/apm.h
--- linux-2.5.62/include/asm-i386/mach-pc9800/apm.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.62/include/asm-i386/mach-pc9800/apm.h	2003-02-23 16:35:36.000000000 +0900
@@ -0,0 +1,82 @@
+/*
+ *  include/asm-i386/mach-pc9800/apm.h
+ *
+ *  Machine specific APM BIOS functions for NEC PC9800.
+ *  Split out from apm.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+#ifndef _ASM_APM_H
+#define _ASM_APM_H
+
+#include <linux/apm_bios.h>
+
+#ifdef APM_ZERO_SEGS
+#	define APM_DO_ZERO_SEGS \
+		"pushl %%ds\n\t" \
+		"pushl %%es\n\t" \
+		"xorl %%edx, %%edx\n\t" \
+		"mov %%dx, %%ds\n\t" \
+		"mov %%dx, %%es\n\t" \
+		"mov %%dx, %%fs\n\t" \
+		"mov %%dx, %%gs\n\t"
+#	define APM_DO_POP_SEGS \
+		"popl %%es\n\t" \
+		"popl %%ds\n\t"
+#else
+#	define APM_DO_ZERO_SEGS
+#	define APM_DO_POP_SEGS
+#endif
+
+static inline void apm_bios_call_asm(u32 func, u32 ebx_in, u32 ecx_in,
+					u32 *eax, u32 *ebx, u32 *ecx,
+					u32 *edx, u32 *esi)
+{
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"pushfl\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%al\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx),
+		  "=S" (*esi)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+}
+
+static inline u8 apm_bios_call_simple_asm(u32 func, u32 ebx_in,
+						u32 ecx_in, u32 *eax)
+{
+	int	cx, dx, si;
+	u8	error;
+
+	/*
+	 * N.B. We do NOT need a cld after the BIOS call
+	 * because we always save and restore the flags.
+	 */
+	__asm__ __volatile__(APM_DO_ZERO_SEGS
+		"pushl %%edi\n\t"
+		"pushl %%ebp\n\t"
+		"pushfl\n\t"
+		"lcall *%%cs:apm_bios_entry\n\t"
+		"setc %%bl\n\t"
+		"popl %%ebp\n\t"
+		"popl %%edi\n\t"
+		APM_DO_POP_SEGS
+		: "=a" (*eax), "=b" (error), "=c" (cx), "=d" (dx),
+		  "=S" (si)
+		: "a" (func), "b" (ebx_in), "c" (ecx_in)
+		: "memory", "cc");
+	if (func == APM_FUNC_VERSION)
+		*eax = (*eax & 0xff00) | ((*eax & 0x00f0) >> 4);
+
+	return error;
+}
+
+#endif /* _ASM_APM_H */
diff -Nru linux-2.5.61/include/linux/apm_bios.h linux98-2.5.61/include/linux/apm_bios.h
--- linux-2.5.61/include/linux/apm_bios.h	2003-02-15 08:51:47.000000000 +0900
+++ linux98-2.5.61/include/linux/apm_bios.h	2003-02-20 08:51:34.000000000 +0900
@@ -20,6 +20,7 @@
 typedef unsigned short	apm_eventinfo_t;
 
 #ifdef __KERNEL__
+#include <linux/config.h>
 
 #define APM_CS		(GDT_ENTRY_APMBIOS_BASE * 8)
 #define APM_CS_16	(APM_CS + 8)
@@ -60,6 +61,28 @@
 /*
  * The APM function codes
  */
+#ifdef CONFIG_X86_PC9800
+#define	APM_FUNC_INST_CHECK	0x9a00
+#define	APM_FUNC_REAL_CONN	0x9a01
+#define	APM_FUNC_16BIT_CONN	0x9a02
+#define	APM_FUNC_32BIT_CONN	0x9a03
+#define	APM_FUNC_DISCONN	0x9a04
+#define	APM_FUNC_IDLE		0x9a05
+#define	APM_FUNC_BUSY		0x9a06
+#define	APM_FUNC_SET_STATE	0x9a07
+#define	APM_FUNC_ENABLE_PM	0x9a08
+#define	APM_FUNC_RESTORE_BIOS	0x9a09
+#define	APM_FUNC_GET_STATUS	0x9a3a
+#define	APM_FUNC_GET_EVENT	0x9a0b
+#define	APM_FUNC_GET_STATE	0x9a0c
+#define	APM_FUNC_ENABLE_DEV_PM	0x9a0d
+#define	APM_FUNC_VERSION	0x9a3e
+#define	APM_FUNC_ENGAGE_PM	0x9a3f
+#define	APM_FUNC_GET_CAP	0x9a10
+#define	APM_FUNC_RESUME_TIMER	0x9a11
+#define	APM_FUNC_RESUME_ON_RING	0x9a12
+#define	APM_FUNC_TIMER		0x9a13
+#else
 #define	APM_FUNC_INST_CHECK	0x5300
 #define	APM_FUNC_REAL_CONN	0x5301
 #define	APM_FUNC_16BIT_CONN	0x5302
@@ -80,6 +103,7 @@
 #define	APM_FUNC_RESUME_TIMER	0x5311
 #define	APM_FUNC_RESUME_ON_RING	0x5312
 #define	APM_FUNC_TIMER		0x5313
+#endif
 
 /*
  * Function code for APM_FUNC_RESUME_TIMER
