Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSLOLWm>; Sun, 15 Dec 2002 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSLOLWm>; Sun, 15 Dec 2002 06:22:42 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:5951 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266368AbSLOLWk>; Sun, 15 Dec 2002 06:22:40 -0500
Message-ID: <3DFC6765.9DC4C74D@cinet.co.jp>
Date: Sun, 15 Dec 2002 20:28:37 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (6/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------81DEAAD46C48AC24166078BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------81DEAAD46C48AC24166078BE
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (6/21)
This is APM support patch.
Split "BIOS version bug fix" into mach-pc9800/setup.c.
SMP Fix for ASUS A7M266D works good for PC-9800 too. So I can
remove many #ifdefs. Thanks!

diffstat:
 arch/i386/kernel/apm.c   |   18 ++++++++++++++----
 include/linux/apm_bios.h |   24 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

Regards,
Osamu Tomita
--------------81DEAAD46C48AC24166078BE
Content-Type: text/plain; charset=iso-2022-jp;
 name="apm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apm.patch"

diff -urN linux/arch/i386/kernel/apm.c linux98/arch/i386/kernel/apm.c
--- linux/arch/i386/kernel/apm.c	2002-12-10 09:17:48.000000000 +0900
+++ linux98/arch/i386/kernel/apm.c	2002-12-13 01:25:12.000000000 +0900
@@ -227,6 +227,10 @@
 
 #include <linux/sysrq.h>
 
+#include "io_ports.h"
+
+extern int pc98;	/* Indicates PC-9800 architecture  No:0 Yes:1 */
+
 extern rwlock_t xtime_lock;
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
@@ -629,6 +633,9 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
+#ifdef CONFIG_PC9800
+		"pushfl\n\t"
+#endif
 		"lcall *%%cs:apm_bios_entry\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
@@ -690,6 +697,9 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
+#ifdef CONFIG_PC9800
+			"pushfl\n\t"
+#endif
 			"lcall *%%cs:apm_bios_entry\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
@@ -730,7 +740,7 @@
 
 	if (apm_bios_call_simple(APM_FUNC_VERSION, 0, *val, &eax))
 		return (eax >> 8) & 0xff;
-	*val = eax;
+	*val = pc98 ? ((eax & 0xff00) | ((eax & 0x00f0) >> 4)) : eax;
 	return APM_SUCCESS;
 }
 
@@ -1243,11 +1253,11 @@
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
diff -urN linux/include/linux/apm_bios.h linux98/include/linux/apm_bios.h
--- linux/include/linux/apm_bios.h	Wed Aug 28 09:52:31 2002
+++ linux98/include/linux/apm_bios.h	Wed Aug 28 13:34:09 2002
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
+#ifndef CONFIG_PC9800
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

--------------81DEAAD46C48AC24166078BE--

