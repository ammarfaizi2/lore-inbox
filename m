Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbSJYW6f>; Fri, 25 Oct 2002 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSJYW6f>; Fri, 25 Oct 2002 18:58:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7157 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261627AbSJYW6d>;
	Fri, 25 Oct 2002 18:58:33 -0400
Message-ID: <3DB9CDEC.DE09AAF1@mvista.com>
Date: Fri, 25 Oct 2002 16:04:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nwourms@netscape.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ac3 fix High-res-timers part 2 (x86 platform code) take 
 7
References: <3DB9A314.6CECA1AC@mvista.com> <apce14$n0o$1@main.gmane.org>
Content-Type: multipart/mixed;
 boundary="------------4F5F832CD5BFFEB492A1774A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------4F5F832CD5BFFEB492A1774A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Nicholas Wourms wrote:
> 
> george anzinger wrote:
> 
> >
> > This patch, in conjunction with the "core" high-res-timers
> > patch implements high resolution timers on the i386
> > platforms.  The high-res-timers use the periodic interrupt
> > to "remind" the system to look at the clock.  The clock
> > should be relatively high resolution (1 micro second or
> > better).  This patch allows configuring of three possible
> > clocks, the TSC, the ACPI pm timer, or the Programmable
> > interrupt timer (PIT).  Most of the changes in this patch
> > are in the arch/i386/kernel/timer/* code.
> >
> Any suggestions on making this patch "more friendly" with 2.5.44-ac3?
> Apparently some of his patch mucked around in the timers source files as
> well as defining completely opposite macros in
> arch/i386/kernel/timers/Makefile.  I might of missed it, but I didn't
> notice anything in his changelog which would jump out at me, except for
> some of the Cyrix fixes.  I'm going to give it a shot, but I thought I'd
> ask as well.

This is what I think it should look like, but I confess I am
guessing that make will do the += -= in the order presented.

Just apply the attached patch after the "hrtimers-i386"
patch and it should fix every thing up.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------4F5F832CD5BFFEB492A1774A
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-i386-2.5.44-ac3-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-i386-2.5.44-ac3-fix.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.44-ac3-hr-base/arch/i386/kernel/timers/Makefile linux/arch/i386/kernel/timers/Makefile
--- linux-2.5.44-ac3-hr-base/arch/i386/kernel/timers/Makefile	Fri Oct 25 15:46:50 2002
+++ linux/arch/i386/kernel/timers/Makefile	Fri Oct 25 15:52:38 2002
@@ -7,5 +7,10 @@
 obj-$(CONFIG_X86_TSC)		+= timer_tsc.o
 obj-$(CONFIG_X86_PIT)		+= timer_pit.o
 obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
-
+obj-$(CONFIG_HIGH_RES_TIMERS) -= timer_tsc.o
+obj-$(CONFIG_HIGH_RES_TIMER_ACPI_PM) += hrtimer_pm.o
+obj-$(CONFIG_HIGH_RES_TIMER_ACPI_PM) += high-res-tbxfroot.o
+obj-$(CONFIG_HIGH_RES_TIMER_TSC) += hrtimer_tsc.o
+obj-$(CONFIG_HIGH_RES_TIMER_PIT) += hrtimer_pit.o
+ 
 include $(TOPDIR)/Rules.make
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.44-ac3-hr-base/arch/i386/kernel/timers/timer.c linux/arch/i386/kernel/timers/timer.c
--- linux-2.5.44-ac3-hr-base/arch/i386/kernel/timers/timer.c	Fri Oct 25 15:46:50 2002
+++ linux/arch/i386/kernel/timers/timer.c	Fri Oct 25 15:57:15 2002
@@ -1,17 +1,34 @@
 #include <linux/kernel.h>
 #include <asm/timer.h>
+/*
+ * export this here so it can be used by more than one clock source
+ */
+unsigned long fast_gettimeoffset_quotient;
 
 /* list of externed timers */
 extern struct timer_opts timer_pit;
 extern struct timer_opts timer_tsc;
+extern struct timer_opts hrtimer_tsc;
+extern struct timer_opts hrtimer_pm;
+extern struct timer_opts hrtimer_pit;
 
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
+#ifdef CONFIG_HIGH_RES_TIMERS
+#ifdef CONFIG_HIGH_RES_TIMER_ACPI_PM
+	&hrtimer_pm,
+#elif  CONFIG_HIGH_RES_TIMER_TSC
+	&hrtimer_tsc,
+#elif  CONFIG_HIGH_RES_TIMER_PIT
+	&hrtimer_pit,
+#endif
+#else
 #ifdef CONFIG_X86_TSC
 	&timer_tsc,
 #endif
 #ifdef CONFIG_X86_PIT
 	&timer_pit,
+#endif
 #endif
 	NULL,
 };
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.44-ac3-hr-base/arch/i386/kernel/timers/timer_pit.c linux/arch/i386/kernel/timers/timer_pit.c
--- linux-2.5.44-ac3-hr-base/arch/i386/kernel/timers/timer_pit.c	Fri Oct 25 15:46:50 2002
+++ linux/arch/i386/kernel/timers/timer_pit.c	Fri Oct 25 15:58:29 2002
@@ -11,6 +11,7 @@
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
+#include <linux/hrtime.h>
 
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;

--------------4F5F832CD5BFFEB492A1774A--

