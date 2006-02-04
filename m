Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946246AbWBDBKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946246AbWBDBKN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946244AbWBDBKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:10:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44303 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946246AbWBDBKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:10:09 -0500
Date: Sat, 4 Feb 2006 02:10:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       Kyle McMartin <kyle@parisc-linux.org>
Subject: [2.6 patch] kill include/linux/platform.h, default_idle() cleanup
Message-ID: <20060204011008.GA4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/platform.h contained nothing that was actually used except 
the default_idle() prototype, and is therefore removed by this patch.

This patch does the following with the platform specific default_idle() 
functions on different architectures:
- remove the unused function:
  - parisc
  - sparc64
- make the needlessly global function static:
  - arm
  - h8300
  - m68k
  - m68knommu
  - s390
  - v850
  - x86_64
- add a prototype in asm/system.h:
  - cris
  - i386
  - ia64


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Patrick Mochel <mochel@digitalimplant.org>
Acked-by: Kyle McMartin <kyle@parisc-linux.org

---

This patch was already sent on:
- 28 Jan 2006

 arch/arm/kernel/process.c       |    2 -
 arch/cris/kernel/process.c      |    3 --
 arch/h8300/kernel/process.c     |    4 +-
 arch/i386/kernel/apm.c          |    2 -
 arch/i386/mach-visws/reboot.c   |    1 
 arch/ia64/kernel/setup.c        |    1 
 arch/m68k/kernel/process.c      |    2 -
 arch/m68knommu/kernel/process.c |    2 -
 arch/parisc/kernel/process.c    |    5 ---
 arch/s390/kernel/process.c      |    2 -
 arch/sh/kernel/process.c        |    1 
 arch/sparc64/kernel/process.c   |    7 -----
 arch/v850/kernel/process.c      |    2 -
 arch/x86_64/kernel/process.c    |    2 -
 include/asm-cris/system.h       |    2 +
 include/asm-i386/system.h       |    2 +
 include/asm-ia64/system.h       |    2 +
 include/linux/platform.h        |   43 --------------------------------
 18 files changed, 15 insertions(+), 70 deletions(-)

--- linux-2.6.16-rc1-mm3-full/arch/arm/kernel/process.c.old	2006-01-28 20:21:43.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/arm/kernel/process.c	2006-01-28 20:21:54.000000000 +0100
@@ -83,7 +83,7 @@
  * This is our default idle handler.  We need to disable
  * interrupts here to ensure we don't miss a wakeup call.
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (hlt_counter)
 		cpu_relax();
--- linux-2.6.16-rc1-mm3-full/include/asm-cris/system.h.old	2006-01-28 20:24:22.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/include/asm-cris/system.h	2006-01-28 20:24:36.000000000 +0100
@@ -71,4 +71,6 @@
 
 #define arch_align_stack(x) (x)
 
+void default_idle(void);
+
 #endif
--- linux-2.6.16-rc1-mm3-full/arch/cris/kernel/process.c.old	2006-01-28 20:25:30.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/cris/kernel/process.c	2006-01-28 20:25:50.000000000 +0100
@@ -116,6 +116,7 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/fs_struct.h>
@@ -194,8 +195,6 @@
  */
 void (*pm_idle)(void);
 
-extern void default_idle(void);
-
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
--- linux-2.6.16-rc1-mm3-full/arch/h8300/kernel/process.c.old	2006-01-28 20:25:58.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/h8300/kernel/process.c	2006-01-28 20:26:11.000000000 +0100
@@ -51,7 +51,7 @@
  * The idle loop on an H8/300..
  */
 #if !defined(CONFIG_H8300H_SIM) && !defined(CONFIG_H8S_SIM)
-void default_idle(void)
+static void default_idle(void)
 {
 	local_irq_disable();
 	if (!need_resched()) {
@@ -62,7 +62,7 @@
 		local_irq_enable();
 }
 #else
-void default_idle(void)
+static void default_idle(void)
 {
 	cpu_relax();
 }
--- linux-2.6.16-rc1-mm3-full/include/asm-i386/system.h.old	2006-01-28 20:26:47.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/include/asm-i386/system.h	2006-01-28 20:26:59.000000000 +0100
@@ -498,4 +498,6 @@
 
 extern unsigned long arch_align_stack(unsigned long sp);
 
+void default_idle(void);
+
 #endif
--- linux-2.6.16-rc1-mm3-full/arch/i386/kernel/apm.c.old	2006-01-28 20:27:11.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/i386/kernel/apm.c	2006-01-28 20:27:19.000000000 +0100
@@ -824,8 +824,6 @@
 
 static void (*original_pm_idle)(void);
 
-extern void default_idle(void);
-
 /**
  * apm_cpu_idle		-	cpu idling for APM capable Linux
  *
--- linux-2.6.16-rc1-mm3-full/include/asm-ia64/system.h.old	2006-01-28 20:27:54.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/include/asm-ia64/system.h	2006-01-28 20:28:07.000000000 +0100
@@ -283,6 +283,8 @@
 
 #define arch_align_stack(x) (x)
 
+void default_idle(void);
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
--- linux-2.6.16-rc1-mm3-full/arch/m68k/kernel/process.c.old	2006-01-28 20:28:59.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/m68k/kernel/process.c	2006-01-28 20:29:07.000000000 +0100
@@ -77,7 +77,7 @@
 /*
  * The idle loop on an m68k..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (!need_resched())
 #if defined(MACH_ATARI_ONLY) && !defined(CONFIG_HADES)
--- linux-2.6.16-rc1-mm3-full/arch/m68knommu/kernel/process.c.old	2006-01-28 20:29:15.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/m68knommu/kernel/process.c	2006-01-28 20:29:27.000000000 +0100
@@ -43,7 +43,7 @@
 /*
  * The idle loop on an m68knommu..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	local_irq_disable();
  	while (!need_resched()) {
--- linux-2.6.16-rc1-mm3-full/arch/parisc/kernel/process.c.old	2006-01-28 20:29:40.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/parisc/kernel/process.c	2006-01-28 20:29:45.000000000 +0100
@@ -54,11 +54,6 @@
 #include <asm/uaccess.h>
 #include <asm/unwind.h>
 
-void default_idle(void)
-{
-	barrier();
-}
-
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
--- linux-2.6.16-rc1-mm3-full/arch/s390/kernel/process.c.old	2006-01-28 20:30:24.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/s390/kernel/process.c	2006-01-28 20:30:32.000000000 +0100
@@ -103,7 +103,7 @@
 /*
  * The idle loop on a S390...
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	int cpu, rc;
 
--- linux-2.6.16-rc1-mm3-full/arch/sparc64/kernel/process.c.old	2006-01-28 20:30:41.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/sparc64/kernel/process.c	2006-01-28 20:30:47.000000000 +0100
@@ -48,13 +48,6 @@
 
 /* #define VERBOSE_SHOWREGS */
 
-/*
- * Nothing special yet...
- */
-void default_idle(void)
-{
-}
-
 #ifndef CONFIG_SMP
 
 /*
--- linux-2.6.16-rc1-mm3-full/arch/v850/kernel/process.c.old	2006-01-28 20:31:00.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/v850/kernel/process.c	2006-01-28 20:31:07.000000000 +0100
@@ -34,7 +34,7 @@
 
 
 /* The idle loop.  */
-void default_idle (void)
+static void default_idle (void)
 {
 	while (! need_resched ())
 		asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
--- linux-2.6.16-rc1-mm3-full/arch/x86_64/kernel/process.c.old	2006-01-28 20:31:14.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/arch/x86_64/kernel/process.c	2006-01-28 20:31:22.000000000 +0100
@@ -114,7 +114,7 @@
  * We use this if we don't have any better
  * idle routine..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	local_irq_enable();
 
--- linux-2.6.14-rc2-mm2-full/arch/i386/mach-visws/reboot.c.old	2005-10-02 01:08:55.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/mach-visws/reboot.c	2005-10-02 01:09:00.000000000 +0200
@@ -1,7 +1,6 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
-#include <linux/platform.h>
 
 #include <asm/io.h>
 #include "piix4.h"
--- linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c.old	2005-10-02 01:09:11.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/ia64/kernel/setup.c	2005-10-02 01:09:15.000000000 +0200
@@ -41,7 +41,6 @@
 #include <linux/serial_core.h>
 #include <linux/efi.h>
 #include <linux/initrd.h>
-#include <linux/platform.h>
 #include <linux/pm.h>
 
 #include <asm/ia32.h>
--- linux-2.6.14-rc2-mm2-full/arch/sh/kernel/process.c.old	2005-10-02 01:09:24.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/sh/kernel/process.c	2005-10-02 01:09:49.000000000 +0200
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/a.out.h>
 #include <linux/ptrace.h>
-#include <linux/platform.h>
 #include <linux/kallsyms.h>
 
 #include <asm/io.h>
--- linux-2.6.14-rc2-mm2-full/include/linux/platform.h	2005-08-29 01:41:01.000000000 +0200
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,43 +0,0 @@
-/*
- * include/linux/platform.h - platform driver definitions
- *
- * Because of the prolific consumerism of the average American,
- * and the dominant marketing budgets of PC OEMs, we have been
- * blessed with frequent updates of the PC architecture. 
- *
- * While most of these calls are singular per architecture, they 
- * require an extra layer of abstraction on the x86 so the right
- * subsystem gets the right call. 
- *
- * Basically, this consolidates the power off and reboot callbacks 
- * into one structure, as well as adding power management hooks.
- *
- * When adding a platform driver, please make sure all callbacks are 
- * filled. There are defaults defined below that do nothing; use those
- * if you do not support that callback.
- */ 
-
-#ifndef _PLATFORM_H_
-#define _PLATFORM_H_
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-struct platform_t {
-	char	* name;
-	u32	suspend_states;
-	void	(*reboot)(char * cmd);
-	void	(*halt)(void);
-	void	(*power_off)(void);
-	int	(*suspend)(int state, int flags);
-	void	(*idle)(void);
-};
-
-extern struct platform_t * platform;
-extern void default_reboot(char * cmd);
-extern void default_halt(void);
-extern int default_suspend(int state, int flags);
-extern void default_idle(void);
-
-#endif /* __KERNEL__ */
-#endif /* _PLATFORM_H */


