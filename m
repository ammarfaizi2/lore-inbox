Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266126AbSKFVcF>; Wed, 6 Nov 2002 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266148AbSKFVcF>; Wed, 6 Nov 2002 16:32:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:34737 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266126AbSKFVcD>; Wed, 6 Nov 2002 16:32:03 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1036590222.9803.17.camel@irongate.swansea.linux.org.uk>
References: <200211052045.gA5KjCW04537@localhost.localdomain> 
	<1036549864.6098.76.camel@cog> 
	<1036590222.9803.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 13:35:35 -0800
Message-Id: <1036618536.6193.179.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 05:43, Alan Cox wrote:
> On Wed, 2002-11-06 at 02:31, john stultz wrote:
> > I'm fine w/ the X86_TSC change, but I'd drop the X86_PIT for now. 
> > 
> > Then make the arch/i386/timers/Makefile change to be something like:
> > 
> > obj-y := timer.o timer_tsc.o timer_pit.o
> > obj-$(CONFIG_X86_TSC)		-= timer_pit.o #does this(-=) work?
> > obj-$(CONFIG_X86_CYCYLONE)	+= timer_cyclone.o
> 
> Not everything is going to have a PIT. Also I need to know if there is a
> PIT for a few other things so I'd prefer to keep it, but I'm not
> excessively bothered

Hmmm. Ok, How about something like what is below? This is very similar
to what James is suggesting, but tries to fix some of the corner cases
as well. The only problem I see with this is that in some places we're
using _X86_PIT_TIMER as an imagined !_X86_TSC_ONLY, so one couldn't have
a kernel that compiled in the Cyclone timer, not the PIT timer, and
allowed one to disable the TSC. 

I'm still not sure this is the way to go, but at least gives James a
chance to poke at my code rather then the other way around. 

thanks
-john


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Nov  4 17:15:15 2002
+++ b/arch/i386/Kconfig	Mon Nov  4 17:15:15 2002
@@ -430,6 +430,11 @@
 	depends on NUMA
 	default y
 
+config X86_PIT_TIMER
+	bool
+	depends on !X86_TSC || X86_NUMAQ
+	default n
+
 config X86_MCE
 	bool "Machine Check Exception"
 	---help---
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Mon Nov  4 17:15:15 2002
+++ b/arch/i386/kernel/cpu/common.c	Mon Nov  4 17:15:15 2002
@@ -42,7 +42,7 @@
 }
 __setup("cachesize=", cachesize_setup);
 
-#ifndef CONFIG_X86_TSC
+#ifdef CONFIG_X86_PIT_TIMER
 static int tsc_disable __initdata = 0;
 
 static int __init tsc_setup(char *str)
@@ -55,7 +55,7 @@
 
 static int __init tsc_setup(char *str)
 {
-	printk("notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.\n");
+	printk("notsc: Kernel not compiled with CONFIG_X86_PIT_TIMER, cannot disable TSC.\n");
 	return 1;
 }
 #endif
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Mon Nov  4 17:15:15 2002
+++ b/arch/i386/kernel/timers/Makefile	Mon Nov  4 17:15:15 2002
@@ -5,7 +5,7 @@
 obj-y := timer.o
 
 obj-y += timer_tsc.o
-obj-y += timer_pit.o
+obj-$(CONFIG_X86_PIT_TIMER) += timer_pit.o
 obj-$(CONFIG_X86_CYCLONE)   += timer_cyclone.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Nov  4 17:15:15 2002
+++ b/arch/i386/kernel/timers/timer.c	Mon Nov  4 17:15:15 2002
@@ -8,7 +8,7 @@
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
 	&timer_tsc,
-#ifndef CONFIG_X86_TSC
+#ifdef CONFIG_X86_PIT_TIMER
 	&timer_pit,
 #endif
 	NULL,

