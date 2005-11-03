Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbVKCVcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVKCVcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVKCVcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:32:31 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:46759 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1030498AbVKCVca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:32:30 -0500
Date: Thu, 3 Nov 2005 22:29:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ben-s3c2410@fluff.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup include/asm-arm/arch-s3c2410/system.h
Message-ID: <20051103212949.GM23366@stusta.de>
References: <20051103181916.GE23366@stusta.de> <20051103184126.GK28038@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103184126.GK28038@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 06:41:26PM +0000, Russell King wrote:
> On Thu, Nov 03, 2005 at 07:19:16PM +0100, Adrian Bunk wrote:
> > Can anyone please explain the contents of 
> > include/asm-arm/arch-s3c2410/system.h ?
> > 
> > This file looks like a C file accidentially named .h ...
> 
> It's the machine specific bits for arch/arm/kernel/process.c, part of
> the structure left over from 1996ish time.
> 
> The functions in there are supposed to be inlined.

IOW, the (untested) patch below changes them to what was intended?

> Russell King

cu
Adrian


<--  snip  -->


This patch makes the functions in include/asm-arm/arch-s3c2410/system.h 
static inline as they should be.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/mach-s3c2410/mach-smdk2440.c |    2 -
 include/asm-arm/arch-s3c2410/idle.h   |   28 --------------------------
 include/asm-arm/arch-s3c2410/system.h |   10 +++------
 3 files changed, 5 insertions(+), 35 deletions(-)

--- linux-2.6.14-rc5-mm1-full/include/asm-arm/arch-s3c2410/system.h.old	2005-11-03 22:13:46.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/include/asm-arm/arch-s3c2410/system.h	2005-11-03 22:14:13.000000000 +0100
@@ -21,14 +21,13 @@
 #include <asm/io.h>
 
 #include <asm/arch/map.h>
-#include <asm/arch/idle.h>
 
 #include <asm/arch/regs-watchdog.h>
 #include <asm/arch/regs-clock.h>
 
-void (*s3c24xx_idle)(void);
+static void (*s3c24xx_idle)(void);
 
-void s3c24xx_default_idle(void)
+static inline void s3c24xx_default_idle(void)
 {
 	void __iomem *reg = S3C2410_CLKCON;
 	unsigned long tmp;
@@ -52,7 +51,7 @@
 	__raw_writel(__raw_readl(reg) & ~(1<<2), reg);
 }
 
-static void arch_idle(void)
+static inline void arch_idle(void)
 {
 	if (s3c24xx_idle != NULL)
 		(s3c24xx_idle)();
@@ -61,8 +60,7 @@
 }
 
 
-static void
-arch_reset(char mode)
+static inline void arch_reset(char mode)
 {
 	if (mode == 's') {
 		cpu_reset(0);
--- linux-2.6.14-rc5-mm1-full/arch/arm/mach-s3c2410/mach-smdk2440.c.old	2005-11-03 22:14:24.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/arch/arm/mach-s3c2410/mach-smdk2440.c	2005-11-03 22:28:48.000000000 +0100
@@ -41,7 +41,7 @@
 //#include <asm/debug-ll.h>
 #include <asm/arch/regs-serial.h>
 #include <asm/arch/regs-gpio.h>
-#include <asm/arch/idle.h>
+#include <asm/arch/system.h>
 
 #include "s3c2410.h"
 #include "s3c2440.h"
--- linux-2.6.14-rc5-mm1-modular-2.95/include/asm-arm/arch-s3c2410/idle.h	2005-08-29 01:41:01.000000000 +0200
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,28 +0,0 @@
-/* linux/include/asm-arm/arch-s3c2410/idle.h
- *
- * Copyright (c) 2004 Simtec Electronics <linux@simtec.co.uk>
- *		http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 CPU Idle controls
- *
- *  Changelog:
- *	28-Oct-2004  BJD  Initial version
- *
-*/
-
-#ifndef __ASM_ARCH_IDLE_H
-#define __ASM_ARCH_IDLE_H __FILE__
-
-/* This allows the over-ride of the default idle code, in case there
- * is any other things to be done over idle (like DVS)
-*/
-
-extern void (*s3c24xx_idle)(void);
-
-extern void s3c24xx_default_idle(void);
-
-#endif /* __ASM_ARCH_IDLE_H */

