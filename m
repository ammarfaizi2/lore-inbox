Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTH2OzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbTH2Oxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:53:45 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:4665 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261294AbTH2Ovt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:51:49 -0400
Date: Fri, 29 Aug 2003 16:50:57 +0200
Message-Id: <200308291450.h7TEovIR005871@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k RTC updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use genrtc on all m68k platforms

--- linux-2.4.23-pre1/arch/m68k/atari/time.c	Wed May 29 10:12:36 2002
+++ linux-m68k-2.4.23-pre1/arch/m68k/atari/time.c	Mon Jun 30 15:15:40 2003
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/rtc.h>
 
-#include <asm/rtc.h>
+#include <asm/atariints.h>
 
 void __init
 atari_sched_init(void (*timer_routine)(int, void *, struct pt_regs *))
--- linux-2.4.23-pre1/arch/m68k/config.in	Mon Jul 21 16:52:40 2003
+++ linux-m68k-2.4.23-pre1/arch/m68k/config.in	Wed Jul  9 13:38:18 2003
@@ -527,14 +513,10 @@
    bool '  Disable watchdog shutdown on close' CONFIG_WATCHDOG_NOWAYOUT
    bool '  Software Watchdog' CONFIG_SOFT_WATCHDOG
 fi
-if [ "$CONFIG_ATARI" = "y" ]; then
-   bool 'Enhanced Real Time Clock Support' CONFIG_RTC
+if [ "$CONFIG_SUN3" = "y" ]; then
+   define_bool CONFIG_GEN_RTC y
 else
-   if [ "$CONFIG_SUN3" = "y" ]; then
-      define_bool CONFIG_GEN_RTC y
-   else
-      tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC      
-   fi
+   tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC      
 fi
 if [ "$CONFIG_GEN_RTC" != "n" ]; then
    bool '   Extended RTC operation' CONFIG_GEN_RTC_X
--- linux-2.4.23-pre1/include/asm-m68k/mc146818rtc.h	Wed Oct 17 12:41:21 2001
+++ linux-m68k-2.4.23-pre1/include/asm-m68k/mc146818rtc.h	Mon Jun 30 15:15:42 2003
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
