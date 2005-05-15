Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVEOKsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVEOKsx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVEOKsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:48:53 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:20444 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261603AbVEOKsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:48:47 -0400
Date: Sun, 15 May 2005 19:48:28 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc4] mips: add resource management to pmu
Message-Id: <20050515194828.55ca082f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had added resource management to vr41xx's pmu.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc4-orig/arch/mips/vr41xx/common/pmu.c rc4/arch/mips/vr41xx/common/pmu.c
--- rc4-orig/arch/mips/vr41xx/common/pmu.c	Sat May  7 14:20:31 2005
+++ rc4/arch/mips/vr41xx/common/pmu.c	Sun May 15 18:14:50 2005
@@ -1,7 +1,7 @@
 /*
  *  pmu.c, Power Management Unit routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,7 +17,9 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/types.h>
@@ -27,20 +29,31 @@
 #include <asm/reboot.h>
 #include <asm/system.h>
 
-#define PMUCNT2REG	KSEG1ADDR(0x0f0000c6)
+#define PMU_TYPE1_BASE	0x0b0000a0UL
+#define PMU_TYPE1_SIZE	0x0eUL
+
+#define PMU_TYPE2_BASE	0x0f0000c0UL
+#define PMU_TYPE2_SIZE	0x10UL
+
+#define PMUCNT2REG	0x06
  #define SOFTRST	0x0010
 
+static void __iomem *pmu_base;
+
+#define pmu_read(offset)		readw(pmu_base + (offset))
+#define pmu_write(offset, value)	writew((value), pmu_base + (offset))
+
 static inline void software_reset(void)
 {
-	uint16_t val;
+	uint16_t pmucnt2;
 
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		val = readw(PMUCNT2REG);
-		val |= SOFTRST;
-		writew(val, PMUCNT2REG);
+		pmucnt2 = pmu_read(PMUCNT2REG);
+		pmucnt2 |= SOFTRST;
+		pmu_write(PMUCNT2REG, pmucnt2);
 		break;
 	default:
 		break;
@@ -71,6 +84,34 @@
 
 static int __init vr41xx_pmu_init(void)
 {
+	unsigned long start, size;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		start = PMU_TYPE1_BASE;
+		size = PMU_TYPE1_SIZE;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		start = PMU_TYPE2_BASE;
+		size = PMU_TYPE2_SIZE;
+		break;
+	default:
+		printk("Unexpected CPU of NEC VR4100 series\n");
+		return -ENODEV;
+	}
+
+	if (request_mem_region(start, size, "PMU") == NULL)
+		return -EBUSY;
+
+	pmu_base = ioremap(start, size);
+	if (pmu_base == NULL) {
+		release_mem_region(start, size);
+		return -EBUSY;
+	}
+
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
 	_machine_power_off = vr41xx_power_off;
@@ -78,4 +119,4 @@
 	return 0;
 }
 
-early_initcall(vr41xx_pmu_init);
+core_initcall(vr41xx_pmu_init);
