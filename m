Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272552AbTGZOlC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272527AbTGZOka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:30 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:8247 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272528AbTGZOcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:51 -0400
Date: Sat, 26 Jul 2003 16:51:54 +0200
Message-Id: <200307261451.h6QEpsnQ002424@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k RTC updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use genrtc on all m68k platforms

--- linux-2.6.x/arch/m68k/Kconfig	Mon Jun 23 10:06:14 2003
+++ linux-m68k-2.6.x/arch/m68k/Kconfig	Sat Jun 28 17:16:54 2003
@@ -1151,37 +1151,8 @@
 	  <file:Documentation/modules.txt>. The module will be called
 	  softdog.
 
-config RTC
-	bool "Enhanced Real Time Clock Support"
-	depends on ATARI
-	---help---
-	  If you say Y here and create a character special file /dev/rtc with
-	  major number 10 and minor number 135 using mknod ("man mknod"), you
-	  will get access to the real time clock (or hardware clock) built
-	  into your computer.
-
-	  Every PC has such a clock built in. It can be used to generate
-	  signals from as low as 1Hz up to 8192Hz, and can also be used
-	  as a 24 hour alarm. It reports status information via the file
-	  /proc/driver/rtc and its behaviour is set by various ioctls on
-	  /dev/rtc.
-
-	  If you run Linux on a multiprocessor machine and said Y to
-	  "Symmetric Multi Processing" above, you should say Y here to read
-	  and set the RTC in an SMP compatible fashion.
-
-	  If you think you have a use for such a device (such as periodic data
-	  sampling), then say Y here, and read <file:Documentation/rtc.txt>
-	  for details.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called rtc. If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation" if !SUN3
-	depends on !ATARI
 	default y if SUN3
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
--- linux-2.6.x/arch/m68k/atari/time.c	Tue May 27 19:02:32 2003
+++ linux-m68k-2.6.x/arch/m68k/atari/time.c	Sat Jun 28 18:09:05 2003
@@ -17,7 +17,7 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 
-#include <asm/rtc.h>
+#include <asm/atariints.h>
 
 void __init
 atari_sched_init(irqreturn_t (*timer_routine)(int, void *, struct pt_regs *))
--- linux-2.6.x/include/asm-m68k/mc146818rtc.h	Sat May 18 14:32:21 2002
+++ linux-m68k-2.6.x/include/asm-m68k/mc146818rtc.h	Sat Jun 28 17:16:10 2003
@@ -4,37 +4,12 @@
 #ifndef _ASM_MC146818RTC_H
 #define _ASM_MC146818RTC_H
 
-#include <linux/config.h>
-#include <asm/atarihw.h>
-
 #ifdef CONFIG_ATARI
 /* RTC in Atari machines */
 
 #include <asm/atarihw.h>
-#include <asm/atariints.h>
-#include <asm/io.h>
-#define RTC_HAS_IRQ	(ATARIHW_PRESENT(TT_MFP))
-#define RTC_IRQ 	IRQ_TT_MFP_RTC
-#define RTC_IRQ_FLAGS	IRQ_TYPE_FAST
-#define RTC_PORT(x)	(TT_RTC_BAS + 2*(x))
-#define RTC_ALWAYS_BCD	0	/* TOS uses binary mode, Linux should be able
-				 * to deal with both modes */
 
-#define RTC_CHECK_DRIVER_INIT() (MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
-#define RTC_MACH_INIT()							\
-    do {								\
-	epoch = atari_rtc_year_offset + 1900;				\
-	if (RTC_HAS_IRQ)						\
-	    /* select RTC int on H->L edge */				\
-	    tt_mfp.active_edge &= ~0x40;				\
-    } while(0)
-#define RTC_MACH_EXIT()
-
-/* On Atari, the year was stored with base 1970 in old TOS versions (before
- * 3.06). Later, Atari recognized that this broke leap year recognition, and
- * changed the base to 1968. Medusa and Hades always use the new version. */
-#define RTC_CENTURY_SWITCH	-1	/* no century switch */
-#define RTC_MINYEAR		epoch
+#define RTC_PORT(x)	(TT_RTC_BAS + 2*(x))
 
 #define CMOS_READ(addr) ({ \
 atari_outb_p((addr),RTC_PORT(0)); \

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
