Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSKKUu5>; Mon, 11 Nov 2002 15:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSKKUu5>; Mon, 11 Nov 2002 15:50:57 -0500
Received: from host194.steeleye.com ([66.206.164.34]:53518 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261318AbSKKUuy>; Mon, 11 Nov 2002 15:50:54 -0500
Message-Id: <200211112057.gABKvS620539@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: john stultz <johnstul@us.ibm.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46 
In-Reply-To: Message from john stultz <johnstul@us.ibm.com> 
   of "11 Nov 2002 12:40:49 PST." <1037047250.1625.5.camel@cornchips> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Nov 2002 15:57:28 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a beginning, what about the attached patch?  It eliminates the compile time 
TSC options (and thus hopefully the sources of confusion).  I've exported 
tsc_disable, so it can be set by the subarchs if desired (voyager does this) 
and moved the notsc option into the timer_tsc code (which is where it looks 
like it belongs).

James

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	v2.5.47 -> 1.825  
#	arch/i386/kernel/timers/Makefile	1.2     -> 1.4    
#	arch/i386/kernel/cpu/common.c	1.13    -> 1.14   
#	include/asm-i386/processor.h	1.31    -> 1.32   
#	   arch/i386/Kconfig	1.2.1.4 -> 1.6    
#	arch/i386/kernel/timers/timer_tsc.c	1.5     -> 1.6    
#	arch/i386/mach-voyager/setup.c	1.1     -> 1.2    
#	arch/i386/kernel/timers/timer_pit.c	1.3.1.2 -> 1.7    
#	arch/i386/kernel/timers/timer.c	1.3     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/10	torvalds@home.transmeta.com	1.823
# Linux v2.5.47
# --------------------------------------------
# 02/11/11	jejb@mulgrave.(none)	1.824
# Merge mulgrave.(none):/home/jejb/BK/timer-2.5
# into mulgrave.(none):/home/jejb/BK/timer-new-2.5
# --------------------------------------------
# 02/11/11	jejb@mulgrave.(none)	1.825
# make TSC purely a run-time determined thing
# 
# - remove X86_TSC and X86_PIT compile time options
# - export tsc_disable for architecture setup
# - disable tsc in voyager pre_arch_setup_hook()
# - move "notsc" option into timers_tsc
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/Kconfig	Mon Nov 11 15:56:40 2002
@@ -253,11 +253,6 @@
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || 
MK6 || M586MMX || M586TSC || M586 || M486
 	default y
 
-config X86_TSC
-	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || 
MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || M586TSC
-	default y
-
 config X86_GOOD_APIC
 	bool
 	depends on MK7 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/kernel/cpu/common.c	Mon Nov 11 15:56:40 2002
@@ -42,25 +42,6 @@
 }
 __setup("cachesize=", cachesize_setup);
 
-#ifndef CONFIG_X86_TSC
-static int tsc_disable __initdata = 0;
-
-static int __init tsc_setup(char *str)
-{
-	tsc_disable = 1;
-	return 1;
-}
-#else
-#define tsc_disable 0
-
-static int __init tsc_setup(char *str)
-{
-	printk("notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC.\n");
-	return 1;
-}
-#endif
-__setup("notsc", tsc_setup);
-
 int __init get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int *v;
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/kernel/timers/Makefile	Mon Nov 11 15:56:40 2002
@@ -2,10 +2,8 @@
 # Makefile for x86 timers
 #
 
-obj-y:= timer.o
+obj-y:= timer.o timer_tsc.o timer_pit.o
 
-obj-y += timer_tsc.o
-obj-y += timer_pit.o
-obj-$(CONFIG_X86_CYCLONE)   += timer_cyclone.o
+obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/kernel/timers/timer.c	Mon Nov 11 15:56:40 2002
@@ -8,9 +8,7 @@
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
 	&timer_tsc,
-#ifndef CONFIG_X86_TSC
 	&timer_pit,
-#endif
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer
_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Nov 11 15:56:40 2002
@@ -9,7 +9,9 @@
 #include <linux/irq.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
+#include <asm/smp.h>
 #include <asm/io.h>
+#include <asm/arch_hooks.h>
 
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer
_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 11 15:56:40 2002
@@ -11,6 +11,10 @@
 
 #include <asm/timer.h>
 #include <asm/io.h>
+/* processor.h for distable_tsc flag */
+#include <asm/processor.h>
+
+int tsc_disable __initdata = 0;
 
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
@@ -286,6 +290,18 @@
 	}
 	return -ENODEV;
 }
+
+/* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
+ * in cpu/common.c */
+static int __init tsc_setup(char *str)
+{
+	tsc_disable = 1;
+	return 1;
+}
+
+__setup("notsc", tsc_setup);
+
+
 
 /************************************************************/
 
diff -Nru a/arch/i386/mach-voyager/setup.c b/arch/i386/mach-voyager/setup.c
--- a/arch/i386/mach-voyager/setup.c	Mon Nov 11 15:56:40 2002
+++ b/arch/i386/mach-voyager/setup.c	Mon Nov 11 15:56:40 2002
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <asm/arch_hooks.h>
+#include <asm/processor.h>
 
 void __init pre_intr_init_hook(void)
 {
@@ -29,6 +30,7 @@
 
 void __init pre_setup_arch_hook(void)
 {
+	tsc_disable = 1;
 }
 
 void __init trap_init_hook(void)
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Mon Nov 11 15:56:40 2002
+++ b/include/asm-i386/processor.h	Mon Nov 11 15:56:40 2002
@@ -18,6 +18,9 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 
+/* flag for disabling the tsc */
+extern int tsc_disable;
+
 struct desc_struct {
 	unsigned long a,b;
 };


