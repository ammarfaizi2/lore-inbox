Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTDMM5b (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTDMM5a (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:57:30 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:11579 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S263502AbTDMM4O (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:56:14 -0400
Date: Sun, 13 Apr 2003 15:05:08 +0200
Message-Id: <200304131305.h3DD58bt001269@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Generic RTC driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the remaining parts of the generic RTC driver. The core driver genrtc.c is
already in the main tree, but documentation, configuration, includes, and
architecture-specific (m68k/ppc) glue code are still missing.

--- linux-2.4.21-pre7/Documentation/Configure.help	Sun Apr  6 10:28:15 2003
+++ linux-m68k-2.4.21-pre7/Documentation/Configure.help	Sun Apr  6 11:25:58 2003
@@ -19126,6 +19126,34 @@
   The module is called rtc.o. If you want to compile it as a module,
   say M here and read <file:Documentation/modules.txt>.
 
+Generic Real Time Clock Support
+CONFIG_GEN_RTC
+  If you say Y here and create a character special file /dev/rtc with
+  major number 10 and minor number 135 using mknod ("man mknod"), you
+  will get access to the real time clock (or hardware clock) built
+  into your computer.
+
+  In 2.4 and later kernels this is the only way to set and get rtc
+  time on m68k systems so it is highly recommended.
+
+  It reports status information via the file /proc/driver/rtc and its 
+  behaviour is set by various ioctls on /dev/rtc. If you enable the
+  "extended RTC operation" below it will also provide an emulation
+  for RTC_UIE which is required by some programs and may improve
+  precision in some cases.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module is called genrtc.o. If you want to compile it as a module,
+  say M here and read <file:Documentation/modules.txt>. To load the
+  module automatically add 'alias char-major-10-135 genrtc' to your
+  /etc/modules.conf
+
+Extended RTC operation
+CONFIG_GEN_RTC_X
+  Provides an emulation for RTC_UIE which is required by some programs 
+  and may improve precision of the generic RTC support in some cases.
+
 Tadpole ANA H8 Support
 CONFIG_H8
   The Hitachi H8/337 is a microcontroller used to deal with the power
--- linux-2.4.21-pre7/arch/m68k/config.in	Sun Apr  6 10:28:29 2003
+++ linux-m68k-2.4.21-pre7/arch/m68k/config.in	Sun Mar  2 21:16:32 2003
@@ -519,8 +519,11 @@
    if [ "$CONFIG_SUN3" = "y" ]; then
       define_bool CONFIG_GEN_RTC y
    else
-      bool 'Generic /dev/rtc emulation' CONFIG_GEN_RTC
+      tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC      
    fi
+fi
+if [ "$CONFIG_GEN_RTC" != "n" ]; then
+   bool '   Extended RTC operation' CONFIG_GEN_RTC_X
 fi
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
--- linux-2.4.21-pre7/arch/m68k/kernel/m68k_ksyms.c	Fri Apr 11 15:18:49 2003
+++ linux-m68k-2.4.21-pre7/arch/m68k/kernel/m68k_ksyms.c	Mon Apr  7 13:06:13 2003
@@ -18,6 +18,7 @@
 #include <asm/checksum.h>
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
+#include <asm/rtc.h>
 
 asmlinkage long long __ashldi3 (long long, int);
 asmlinkage long long __ashrdi3 (long long, int);
@@ -47,7 +48,11 @@
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(kernel_set_cachemode);
 #endif /* !CONFIG_SUN3 */
 EXPORT_SYMBOL(m68k_debug_device);
+EXPORT_SYMBOL(mach_hwclk);
+EXPORT_SYMBOL(mach_get_ss);
+EXPORT_SYMBOL(mach_get_rtc_pll);
+EXPORT_SYMBOL(mach_set_rtc_pll);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
--- linux-2.4.21-pre7/arch/m68k/kernel/setup.c	Fri Sep 13 10:15:01 2002
+++ linux-m68k-2.4.21-pre7/arch/m68k/kernel/setup.c	Mon Sep  9 13:07:29 2002
@@ -90,6 +90,9 @@
 void (*mach_gettod) (int*, int*, int*, int*, int*, int*);
 int (*mach_hwclk) (int, struct rtc_time*) = NULL;
 int (*mach_set_clock_mmss) (unsigned long) = NULL;
+unsigned int (*mach_get_ss)(void) = NULL;
+int (*mach_get_rtc_pll)(struct rtc_pll_info *) = NULL;
+int (*mach_set_rtc_pll)(struct rtc_pll_info *) = NULL;
 void (*mach_reset)( void );
 void (*mach_halt)( void ) = NULL;
 void (*mach_power_off)( void ) = NULL;
--- linux-2.4.21-pre7/arch/m68k/q40/config.c	Fri Sep 13 10:15:02 2002
+++ linux-m68k-2.4.21-pre7/arch/m68k/q40/config.c	Mon Sep  9 13:07:29 2002
@@ -58,7 +58,10 @@
 extern void q40_gettod (int *year, int *mon, int *day, int *hour,
                            int *min, int *sec);
 extern int q40_hwclk (int, struct rtc_time *);
+extern unsigned int q40_get_ss (void);
 extern int q40_set_clock_mmss (unsigned long);
+static int q40_get_rtc_pll(struct rtc_pll_info *pll);
+static int q40_set_rtc_pll(struct rtc_pll_info *pll);
 extern void q40_reset (void);
 void q40_halt(void);
 extern void q40_waitbut(void);
@@ -196,6 +199,9 @@
     mach_gettimeoffset   = q40_gettimeoffset; 
     mach_gettod  	 = q40_gettod;
     mach_hwclk           = q40_hwclk; 
+    mach_get_ss          = q40_get_ss; 
+    mach_get_rtc_pll     = q40_get_rtc_pll; 
+    mach_set_rtc_pll     = q40_set_rtc_pll; 
     mach_set_clock_mmss	 = q40_set_clock_mmss;
 
     mach_reset		 = q40_reset;
@@ -331,6 +337,11 @@
 	return 0;
 }
 
+unsigned int q40_get_ss()
+{
+	return bcd2bin(Q40_RTC_SECS);
+}
+
 /*
  * Set the minutes and seconds from seconds value 'nowtime'.  Fail if
  * clock is out by > 30 minutes.  Logic lifted from atari code.
@@ -362,3 +373,33 @@
 	return retval;
 }
 
+
+/* get and set PLL calibration of RTC clock */
+#define Q40_RTC_PLL_MASK ((1<<5)-1)
+#define Q40_RTC_PLL_SIGN (1<<5)
+
+static int q40_get_rtc_pll(struct rtc_pll_info *pll)
+{
+      int tmp=Q40_RTC_CTRL;
+      pll->pll_value = tmp & Q40_RTC_PLL_MASK;
+      if (tmp & Q40_RTC_PLL_SIGN) 
+	  pll->pll_value = -pll->pll_value;
+      pll->pll_max=31;
+      pll->pll_min=-31;
+      pll->pll_posmult=512;
+      pll->pll_negmult=256;
+      pll->pll_clock=125829120;
+      return 0;
+  }
+
+static int q40_set_rtc_pll(struct rtc_pll_info *pll)
+{
+  if (!pll->pll_ctrl){
+      /* the docs are a bit unclear so I am doublesetting RTC_WRITE here ... */
+      int tmp=(pll->pll_value & 31) | (pll->pll_value<0 ? 32 : 0) | Q40_RTC_WRITE;
+      Q40_RTC_CTRL |= Q40_RTC_WRITE;
+      Q40_RTC_CTRL = tmp;
+      Q40_RTC_CTRL &= ~(Q40_RTC_WRITE);
+      return 0;
+  } else return -EINVAL;
+}
--- linux-2.4.21-pre7/arch/ppc/config.in	Sun Apr  6 10:28:33 2003
+++ linux-m68k-2.4.21-pre7/arch/ppc/config.in	Thu Mar 27 16:52:42 2003
@@ -196,12 +196,9 @@
 
 source drivers/parport/Config.in
 
-if [ "$CONFIG_4xx" != "y" ]; then
-  if [ "$CONFIG_APUS" != "y" ]; then
-    tristate 'Support for /dev/rtc' CONFIG_PPC_RTC
-  else
-    bool 'Generic /dev/rtc emulation' CONFIG_GEN_RTC
-  fi
+tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC
+if [ "$CONFIG_GEN_RTC" = "n" -a "$CONFIG_APUS" != "y" ]; then
+  tristate 'Support for /dev/rtc' CONFIG_PPC_RTC
 fi
 
 if [ "$CONFIG_ALL_PPC" = "y" -a "$CONFIG_POWER3" = "n" ] ; then
--- linux-2.4.21-pre7/drivers/char/genrtc.c	Sun Apr  6 10:28:44 2003
+++ linux-m68k-2.4.21-pre7/drivers/char/genrtc.c	Thu Mar 27 18:03:52 2003
@@ -99,7 +99,7 @@
 static void gen_rtc_interrupt(unsigned long arg);
 
 /*
- * Routine to poll RTC seconds field for change as often as posible,
+ * Routine to poll RTC seconds field for change as often as possible,
  * after first RTC_UIE use timer to reduce polling
  */
 static void genrtc_troutine(void *data)
--- linux-2.4.21-pre7/include/asm-m68k/machdep.h	Wed May 29 10:14:12 2002
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/machdep.h	Mon Sep  9 13:07:29 2002
@@ -5,6 +5,7 @@
 struct kbd_repeat;
 struct mktime;
 struct rtc_time;
+struct rtc_pll_info;
 struct gendisk;
 struct buffer_head;
 
@@ -29,6 +30,9 @@
 extern void (*mach_gettod)(int *year, int *mon, int *day, int *hour,
 			   int *min, int *sec);
 extern int (*mach_hwclk)(int, struct rtc_time*);
+extern unsigned int (*mach_get_ss)(void);
+extern int (*mach_get_rtc_pll)(struct rtc_pll_info *);
+extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_clock_mmss)(unsigned long);
 extern void (*mach_reset)( void );
 extern void (*mach_halt)( void );
--- linux-2.4.21-pre7/include/asm-m68k/rtc.h	Wed May 29 10:14:13 2002
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/rtc.h	Mon Jan 20 18:13:12 2003
@@ -13,24 +13,64 @@
 
 #ifdef __KERNEL__
 
-#include <linux/config.h>
 #include <linux/rtc.h>
-#include <linux/delay.h>
+#include <asm/errno.h>
 #include <asm/machdep.h>
 
 #define RTC_PIE 0x40		/* periodic interrupt enable */
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */
 
-extern void gen_rtc_interrupt(unsigned long);
-
 /* some dummy definitions */
+#define RTC_BATT_BAD 0x100	/* battery bad */
 #define RTC_SQWE 0x08		/* enable square-wave output */
 #define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
 
+static inline unsigned int get_rtc_time(struct rtc_time *time)
+{
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+	mach_hwclk(0, time);
+	return RTC_24H;
+}
+
+static inline int set_rtc_time(struct rtc_time *time)
+{
+	return mach_hwclk(1, time);
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	if (mach_get_ss)
+		return mach_get_ss();
+	else{
+		struct rtc_time h;
+		
+		get_rtc_time(&h);
+		return h.tm_sec;
+	}
+}
 
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	if (mach_get_rtc_pll)
+		return mach_get_rtc_pll(pll);
+	else
+		return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	if (mach_set_rtc_pll)
+		return mach_set_rtc_pll(pll);
+	else
+		return -EINVAL;
+}
 #endif /* __KERNEL__ */
 
 #endif /* _ASM__RTC_H */
--- linux-2.4.21-pre7/include/asm-ppc/rtc.h	Thu Jan  1 01:00:00 1970
+++ linux-m68k-2.4.21-pre7/include/asm-ppc/rtc.h	Sun Feb  2 15:02:23 2003
@@ -0,0 +1,98 @@
+/* 
+ * inclue/asm-ppc/rtc.h
+ *
+ * Author: Tom Rini <trini@mvista.com>
+ *
+ * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Based on:
+ * include/asm-m68k/rtc.h
+ *
+ * Copyright Richard Zidlicky
+ * implementation details for genrtc/q40rtc driver
+ *
+ * And the old drivers/macintosh/rtc.c which was heavily based on:
+ * Linux/SPARC Real Time Clock Driver
+ * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
+ *
+ * With additional work by Paul Mackerras and Franz Sirl.
+ */
+
+#ifndef __ASM_RTC_H__
+#define __ASM_RTC_H__
+
+#ifdef __KERNEL__
+
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+#define RTC_PIE 0x40		/* periodic interrupt enable */
+#define RTC_AIE 0x20		/* alarm interrupt enable */
+#define RTC_UIE 0x10		/* update-finished interrupt enable */
+
+extern void gen_rtc_interrupt(unsigned long);
+
+/* some dummy definitions */
+#define RTC_BATT_BAD 0x100	/* battery bad */
+#define RTC_SQWE 0x08		/* enable square-wave output */
+#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
+#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
+
+static inline unsigned int get_rtc_time(struct rtc_time *time)
+{
+	if (ppc_md.get_rtc_time) {
+		unsigned long nowtime;
+
+		nowtime = (ppc_md.get_rtc_time)();
+
+		to_tm(nowtime, time);
+
+		time->tm_year -= 1900;
+		time->tm_mon -= 1; /* Make sure userland has a 0-based month */
+	}
+
+	return RTC_24H;
+}
+
+/* Set the current date and time in the real time clock. */
+static inline int set_rtc_time(struct rtc_time *time)
+{
+	if (ppc_md.get_rtc_time) {
+		unsigned long nowtime;
+
+		nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
+				time->tm_mday, time->tm_hour, time->tm_min,
+				time->tm_sec);
+
+		(ppc_md.set_rtc_time)(nowtime);
+
+		return 0;
+	} else
+		return -EINVAL;
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_RTC_H__ */
--- linux-2.4.21-pre7/include/linux/rtc.h	Mon Feb 19 09:47:19 2001
+++ linux-m68k-2.4.21-pre7/include/linux/rtc.h	Sun Mar  2 18:14:12 2003
@@ -39,10 +39,32 @@
 	struct rtc_time time;	/* time the alarm is set to */
 };
 
+/*
+ * Data structure to control PLL correction some better RTC feature
+ * pll_value is used to get or set current value of correction,
+ * the rest of the struct is used to query HW capabilities.
+ * This is modeled after the RTC used in Q40/Q60 computers but
+ * should be sufficiently flexible for other devices
+ *
+ * +ve pll_value means clock will run faster by
+ *   pll_value*pll_posmult/pll_clock
+ * -ve pll_value means clock will run slower by
+ *   pll_value*pll_negmult/pll_clock
+ */ 
+
+struct rtc_pll_info {
+	int pll_ctrl;       /* placeholder for fancier control */
+	int pll_value;      /* get/set correction value */
+	int pll_max;        /* max +ve (faster) adjustment value */
+	int pll_min;        /* max -ve (slower) adjustment value */
+	int pll_posmult;    /* factor for +ve correction */
+	int pll_negmult;    /* factor for -ve correction */
+	long pll_clock;     /* base PLL frequency */
+};
 
 /*
- * ioctl calls that are permitted to the /dev/rtc interface, if 
- * CONFIG_RTC/CONFIG_EFI_RTC was enabled.
+ * ioctl calls that are permitted to the /dev/rtc interface, if
+ * any of the RTC drivers are enabled.
  */
 
 #define RTC_AIE_ON	_IO('p', 0x01)	/* Alarm int. enable on		*/
@@ -66,4 +88,6 @@
 #define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
 #define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/
 
+#define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
+#define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
 #endif /* _LINUX_RTC_H_ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
