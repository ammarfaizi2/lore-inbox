Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSJ1RXn>; Mon, 28 Oct 2002 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJ1RXn>; Mon, 28 Oct 2002 12:23:43 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:58895 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261386AbSJ1RXk>; Mon, 28 Oct 2002 12:23:40 -0500
Date: Tue, 29 Oct 2002 02:29:59 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 1/23] add support for PC-9800 architecture (apm)
Message-ID: <20021029022959.A2218@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support for NEC PC-9800 architecture, against 2.5.44.

Thanks you very much,
Alan Cox, Andrey Panin, Dave Jones, Geert Uytterhoeven, GOTO Masanori,
Ingo Oeser, Kai Germaschewski, Pete Zaitcev, Russell King, Vojtech Pavlik
 for many comments.

I cleaned up patchset, reduce many "#ifdef"s. And tested both PC-9800 and
AT comaptible box. I hope merge this patchset into kernel.

Best regards
Osamu tomita  sf.jp Linux/98 project
-

This is a part 1/23 of patchset.

Summary:
 APM related modules
  - adapted to BIOS spec. differences.

diffstat:

 arch/i386/kernel/apm.c   |   50 ++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/apm_bios.h |   24 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 5 deletions(-)

patch:
diff -urN linux/arch/i386/kernel/apm.c linux98/arch/i386/kernel/apm.c
--- linux/arch/i386/kernel/apm.c	Sat Oct 19 13:01:09 2002
+++ linux98/arch/i386/kernel/apm.c	Sun Oct 20 13:18:31 2002
@@ -223,6 +223,8 @@
 
 #include <linux/sysrq.h>
 
+#include "io_ports.h"
+
 extern rwlock_t xtime_lock;
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
@@ -588,6 +590,9 @@
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
+#ifdef CONFIG_PC9800
+		"pushfl\n\t"
+#endif
 		"lcall *%%cs:apm_bios_entry\n\t"
 		"setc %%al\n\t"
 		"popl %%ebp\n\t"
@@ -643,6 +648,9 @@
 		__asm__ __volatile__(APM_DO_ZERO_SEGS
 			"pushl %%edi\n\t"
 			"pushl %%ebp\n\t"
+#ifdef CONFIG_PC9800
+			"pushfl\n\t"
+#endif
 			"lcall *%%cs:apm_bios_entry\n\t"
 			"setc %%bl\n\t"
 			"popl %%ebp\n\t"
@@ -909,7 +917,7 @@
 	/*
 	 * This may be called on an SMP machine.
 	 */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_PC9800)
 	/* Some bioses don't like being called from CPU != 0 */
 	if (smp_processor_id() != 0) {
 		current->cpus_allowed = 1;
@@ -1174,11 +1182,11 @@
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
@@ -1653,7 +1661,12 @@
 	      -1: Unknown
 	   8) min = minutes; sec = seconds */
 
-	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+	p += sprintf(p,
+#ifndef CONFIG_PC9800
+		     "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+#else
+		     "%s %d.%02x 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+#endif
 		     driver_version,
 		     (apm_info.bios.version >> 8) & 0xff,
 		     apm_info.bios.version & 0xff,
@@ -1677,6 +1690,8 @@
 	char *		power_stat;
 	char *		bat_stat;
 
+#if !defined(CONFIG_PC9800) || !defined(CONFIG_SMP)
+	/* Deamonize causes freeze on PC-9800 SMP box */
 	kapmd_running = 1;
 
 	daemonize();
@@ -1684,6 +1699,7 @@
 	strcpy(current->comm, "kapmd");
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
+#endif /* !CONFIG_PC9800 || !CONFIG_SMP */
 
 #ifdef CONFIG_SMP
 	/* 2002/08/01 - WT
@@ -1714,6 +1730,17 @@
 				/* Fall back to an APM 1.0 connection. */
 				apm_info.connection_version = 0x100;
 			}
+#ifdef CONFIG_PC9800
+			else {
+				printk("PC-9801 APM BIOS BUG work around: "
+					"fix connection_version 0x%x to ",
+					apm_info.connection_version);
+				apm_info.connection_version =
+				(apm_info.connection_version & 0xff00)
+				| ((apm_info.connection_version & 0x00f0) >> 4);
+				printk("0x%x\n", apm_info.connection_version);
+			}
+#endif /* CONFIG_PC9800 */
 		}
 	}
 
@@ -1886,7 +1913,11 @@
 		return -ENODEV;
 	}
 	printk(KERN_INFO
+#ifndef CONFIG_PC9800
 		"apm: BIOS version %d.%d Flags 0x%02x (Driver version %s)\n",
+#else
+		"apm: BIOS version %d.%02x Flags 0x%02x (Driver version %s)\n",
+#endif
 		((apm_info.bios.version >> 8) & 0xff),
 		(apm_info.bios.version & 0xff),
 		apm_info.bios.flags,
@@ -1913,6 +1944,11 @@
 	if (apm_info.bios.version == 0x001)
 		apm_info.bios.version = 0x100;
 
+#ifdef CONFIG_PC9800
+	/* In PC-9800, APM BIOS version is written in BCD...?? */
+	apm_info.bios.version = (apm_info.bios.version & 0xff00)
+				| ((apm_info.bios.version & 0x00f0) >> 4);
+#endif
 	/* BIOS < 1.2 doesn't set cseg_16_len */
 	if (apm_info.bios.version < 0x102)
 		apm_info.bios.cseg_16_len = 0; /* 64k */
@@ -1988,7 +2024,11 @@
 	if (apm_proc)
 		SET_MODULE_OWNER(apm_proc);
 
+#if defined(CONFIG_PC9800) && defined(CONFIG_SMP)
+	apm(0);
+#else
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
+#endif
 
 	if (num_online_cpus() > 1) {
 		printk(KERN_NOTICE
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
