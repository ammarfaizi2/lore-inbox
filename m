Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVCBW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVCBW6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVCBWzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:55:40 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:17356 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262501AbVCBWwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:52:16 -0500
Date: Thu, 3 Mar 2005 07:52:01 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2.6.11-rc5-mm1] mips: calculate clock at any time
Message-Id: <20050303075201.121fd260.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes bcu.c to calculate clock at any time.
Because clock can be changed.
Moreover, EXPORT_SYMBOL_GPLs are added to it.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/bcu.c a/arch/mips/vr41xx/common/bcu.c
--- a-orig/arch/mips/vr41xx/common/bcu.c	Fri Feb 25 01:40:40 2005
+++ a/arch/mips/vr41xx/common/bcu.c	Thu Mar  3 07:04:29 2005
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -28,20 +28,16 @@
  *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *  - Added support for NEC VR4133.
  */
-#include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
 #include <asm/io.h>
 
-#define IO_MEM_RESOURCE_START	0UL
-#define IO_MEM_RESOURCE_END	0x1fffffffUL
-
-#define CLKSPEEDREG_TYPE1	KSEG1ADDR(0x0b000014)
-#define CLKSPEEDREG_TYPE2	KSEG1ADDR(0x0f000014)
+#define CLKSPEEDREG_TYPE1	(void __iomem *)KSEG1ADDR(0x0b000014)
+#define CLKSPEEDREG_TYPE2	(void __iomem *)KSEG1ADDR(0x0f000014)
  #define CLKSP(x)		((x) & 0x001f)
  #define CLKSP_VR4133(x)	((x) & 0x0007)
 
@@ -63,11 +59,15 @@
 	return vr41xx_vtclock;
 }
 
+EXPORT_SYMBOL_GPL(vr41xx_get_vtclock_frequency);
+
 unsigned long vr41xx_get_tclock_frequency(void)
 {
 	return vr41xx_tclock;
 }
 
+EXPORT_SYMBOL_GPL(vr41xx_get_tclock_frequency);
+
 static inline uint16_t read_clkspeed(void)
 {
 	switch (current_cpu_data.cputype) {
@@ -207,7 +207,7 @@
 	return tclock;
 }
 
-static int __init vr41xx_bcu_init(void)
+void vr41xx_calculate_clock_frequency(void)
 {
 	unsigned long pclock;
 	uint16_t clkspeed;
@@ -217,11 +217,6 @@
 	pclock = calculate_pclock(clkspeed);
 	vr41xx_vtclock = calculate_vtclock(clkspeed, pclock);
 	vr41xx_tclock = calculate_tclock(clkspeed, pclock, vr41xx_vtclock);
-
-	iomem_resource.start = IO_MEM_RESOURCE_START;
-	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-	return 0;
 }
 
-early_initcall(vr41xx_bcu_init);
+EXPORT_SYMBOL_GPL(vr41xx_calculate_clock_frequency);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/init.c a/arch/mips/vr41xx/common/init.c
--- a-orig/arch/mips/vr41xx/common/init.c	Fri Feb 25 01:40:31 2005
+++ a/arch/mips/vr41xx/common/init.c	Thu Mar  3 07:05:03 2005
@@ -1,7 +1,7 @@
 /*
  *  init.c, Common initialization routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,9 +18,20 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
+#include <asm/vr41xx/vr41xx.h>
+
+#define IO_MEM_RESOURCE_START	0UL
+#define IO_MEM_RESOURCE_END	0x1fffffffUL
+
+static void __init iomem_resource_init(void)
+{
+	iomem_resource.start = IO_MEM_RESOURCE_START;
+	iomem_resource.end = IO_MEM_RESOURCE_END;
+}
 
 void __init prom_init(void)
 {
@@ -35,6 +46,10 @@
 		if (i < (argc - 1))
 			strcat(arcs_cmdline, " ");
 	}
+
+	vr41xx_calculate_clock_frequency();
+
+	iomem_resource_init();
 }
 
 unsigned long __init prom_free_prom_memory (void)
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/ksyms.c a/arch/mips/vr41xx/common/ksyms.c
--- a-orig/arch/mips/vr41xx/common/ksyms.c	Fri Feb 25 01:40:05 2005
+++ a/arch/mips/vr41xx/common/ksyms.c	Thu Mar  3 00:51:33 2005
@@ -22,9 +22,6 @@
 
 #include <asm/vr41xx/vr41xx.h>
 
-EXPORT_SYMBOL(vr41xx_get_vtclock_frequency);
-EXPORT_SYMBOL(vr41xx_get_tclock_frequency);
-
 EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
 EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
 EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/vr41xx.h a/include/asm-mips/vr41xx/vr41xx.h
--- a-orig/include/asm-mips/vr41xx/vr41xx.h	Wed Mar  2 01:05:57 2005
+++ a/include/asm-mips/vr41xx/vr41xx.h	Thu Mar  3 07:05:43 2005
@@ -45,6 +45,7 @@
 /*
  * Bus Control Uint
  */
+extern unsigned long vr41xx_calculate_clock_frequency(void);
 extern unsigned long vr41xx_get_vtclock_frequency(void);
 extern unsigned long vr41xx_get_tclock_frequency(void);
 
