Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTBQNlW>; Mon, 17 Feb 2003 08:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbTBQNlV>; Mon, 17 Feb 2003 08:41:21 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:16000 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267070AbTBQNlT>; Mon, 17 Feb 2003 08:41:19 -0500
Date: Mon, 17 Feb 2003 22:49:55 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (2/26) APM
Message-ID: <20030217134955.GB4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (2/26).

APM support for PC98. Including PC98's BIOS bug fix.

diff -Nru linux-2.5.61/arch/i386/kernel/apm.c linux98-2.5.61/arch/i386/kernel/apm.c
--- linux-2.5.61/arch/i386/kernel/apm.c	2003-02-15 08:51:10.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/apm.c	2003-02-15 13:40:49.000000000 +0900
@@ -226,6 +226,8 @@
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 
+#include "io_ports.h"
+
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -621,6 +623,9 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
+#ifdef CONFIG_X86_PC9800
+		"pushfl\n\t"
+#endif
 		"lcall *%%cs:apm_bios_entry\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
@@ -682,6 +687,9 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
+#ifdef CONFIG_X86_PC9800
+			"pushfl\n\t"
+#endif
 			"lcall *%%cs:apm_bios_entry\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
@@ -722,7 +730,7 @@
 
 	if (apm_bios_call_simple(APM_FUNC_VERSION, 0, *val, &eax))
 		return (eax >> 8) & 0xff;
-	*val = eax;
+	*val = pc98 ? ((eax & 0xff00) | ((eax & 0x00f0) >> 4)) : eax;
 	return APM_SUCCESS;
 }
 
@@ -1211,11 +1219,11 @@
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
diff -Nru linux/include/linux/apm_bios.h linux98/include/linux/apm_bios.h
--- linux/include/linux/apm_bios.h	2003-01-02 12:22:18.000000000 +0900
+++ linux98/include/linux/apm_bios.h	2003-01-04 13:20:28.000000000 +0900
@@ -20,6 +20,7 @@
 typedef unsigned short	apm_eventinfo_t;
 
 #ifdef __KERNEL__
+#include <linux/config.h>
 
 #define APM_CS		(GDT_ENTRY_APMBIOS_BASE * 8)
 #define APM_CS_16	(APM_CS + 8)
@@ -60,6 +61,7 @@
 /*
  * The APM function codes
  */
+#ifndef CONFIG_X86_PC9800
 #define	APM_FUNC_INST_CHECK	0x5300
 #define	APM_FUNC_REAL_CONN	0x5301
 #define	APM_FUNC_16BIT_CONN	0x5302
@@ -80,6 +82,28 @@
 #define	APM_FUNC_RESUME_TIMER	0x5311
 #define	APM_FUNC_RESUME_ON_RING	0x5312
 #define	APM_FUNC_TIMER		0x5313
+#else
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
+#endif
 
 /*
  * Function code for APM_FUNC_RESUME_TIMER
