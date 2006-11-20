Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966320AbWKTSIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966320AbWKTSIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966318AbWKTSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:48335 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934277AbWKTSHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:12 -0500
Message-Id: <20061120180527.593768000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:14 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Kevin Corry <kevcorry@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 20/22] cell: Move PMU-related stuff to include/asm-powerpc/cell-pmu.h
Content-Disposition: inline; filename=cell-move-PMU-related-stuff-to-include_asm-powerpc_cell-pmu-h.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Corry <kevcorry@us.ibm.com>
Move some PMU-related macros and function prototypes from cbe_regs.h
and pmu.h in arch/powerpc/platforms/cell/ to a new header at
include/asm-powerpc/cell-pmu.h

This is cleaner to use from the oprofile code, since that sits in
arch/powerpc/oprofile, not in the cell platform directory.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -15,6 +15,8 @@
 #ifndef CBE_REGS_H
 #define CBE_REGS_H
 
+#include <asm/cell-pmu.h>
+
 /*
  *
  * Some HID register definitions
@@ -35,32 +37,6 @@
  *
  */
 
-/* Macros for the pm_control register. */
-#define CBE_PM_16BIT_CTR(ctr)			(1 << (24 - ((ctr) & (NR_PHYS_CTRS - 1))))
-#define CBE_PM_ENABLE_PERF_MON			0x80000000
-#define CBE_PM_STOP_AT_MAX			0x40000000
-#define CBE_PM_TRACE_MODE_GET(pm_control)	(((pm_control) >> 28) & 0x3)
-#define CBE_PM_TRACE_MODE_SET(mode)		(((mode)  & 0x3) << 28)
-#define CBE_PM_COUNT_MODE_SET(count)		(((count) & 0x3) << 18)
-#define CBE_PM_FREEZE_ALL_CTRS			0x00100000
-#define CBE_PM_ENABLE_EXT_TRACE			0x00008000
-
-/* Macros for the trace_address register. */
-#define CBE_PM_TRACE_BUF_FULL			0x00000800
-#define CBE_PM_TRACE_BUF_EMPTY			0x00000400
-#define CBE_PM_TRACE_BUF_DATA_COUNT(ta)		((ta) & 0x3ff)
-#define CBE_PM_TRACE_BUF_MAX_COUNT		0x400
-
-/* Macros for the pm07_control registers. */
-#define CBE_PM_CTR_INPUT_MUX(pm07_control)	(((pm07_control) >> 26) & 0x3f)
-#define CBE_PM_CTR_INPUT_CONTROL		0x02000000
-#define CBE_PM_CTR_POLARITY			0x01000000
-#define CBE_PM_CTR_COUNT_CYCLES			0x00800000
-#define CBE_PM_CTR_ENABLE			0x00400000
-
-/* Macros for the pm_status register. */
-#define CBE_PM_CTR_OVERFLOW_INTR(ctr)		(1 << (31 - ((ctr) & 7)))
-
 union spe_reg {
 	u64 val;
 	u8 spe[8];
@@ -160,9 +136,6 @@ extern struct cbe_pmd_regs __iomem *cbe_
  * counters currently have a value waiting to be written.
  */
 
-#define NR_PHYS_CTRS	4
-#define NR_CTRS		(NR_PHYS_CTRS * 2)
-
 struct cbe_pmd_shadow_regs {
 	u32 group_control;
 	u32 debug_bus_control;
Index: linux-2.6/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pmu.c
+++ linux-2.6/arch/powerpc/platforms/cell/pmu.c
@@ -30,7 +30,6 @@
 
 #include "cbe_regs.h"
 #include "interrupt.h"
-#include "pmu.h"
 
 /*
  * When writing to write-only mmio addresses, save a shadow copy. All of the
Index: linux-2.6/arch/powerpc/platforms/cell/pmu.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pmu.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Cell Broadband Engine Performance Monitor
- *
- * (C) Copyright IBM Corporation 2001,2006
- *
- * Author:
- *   David Erb (djerb@us.ibm.com)
- *   Kevin Corry (kevcorry@us.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __PERFMON_H__
-#define __PERFMON_H__
-
-enum pm_reg_name {
-	group_control,
-	debug_bus_control,
-	trace_address,
-	ext_tr_timer,
-	pm_status,
-	pm_control,
-	pm_interval,
-	pm_start_stop,
-};
-
-extern u32  cbe_read_phys_ctr(u32 cpu, u32 phys_ctr);
-extern void cbe_write_phys_ctr(u32 cpu, u32 phys_ctr, u32 val);
-extern u32  cbe_read_ctr(u32 cpu, u32 ctr);
-extern void cbe_write_ctr(u32 cpu, u32 ctr, u32 val);
-
-extern u32  cbe_read_pm07_control(u32 cpu, u32 ctr);
-extern void cbe_write_pm07_control(u32 cpu, u32 ctr, u32 val);
-extern u32  cbe_read_pm (u32 cpu, enum pm_reg_name reg);
-extern void cbe_write_pm (u32 cpu, enum pm_reg_name reg, u32 val);
-
-extern u32  cbe_get_ctr_size(u32 cpu, u32 phys_ctr);
-extern void cbe_set_ctr_size(u32 cpu, u32 phys_ctr, u32 ctr_size);
-
-extern void cbe_enable_pm(u32 cpu);
-extern void cbe_disable_pm(u32 cpu);
-
-extern void cbe_read_trace_buffer(u32 cpu, u64 *buf);
-
-#endif
Index: linux-2.6/include/asm-powerpc/cell-pmu.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-powerpc/cell-pmu.h
@@ -0,0 +1,90 @@
+/*
+ * Cell Broadband Engine Performance Monitor
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Author:
+ *   David Erb (djerb@us.ibm.com)
+ *   Kevin Corry (kevcorry@us.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_CELL_PMU_H__
+#define __ASM_CELL_PMU_H__
+
+/* The Cell PMU has four hardware performance counters, which can be
+ * configured as four 32-bit counters or eight 16-bit counters.
+ */
+#define NR_PHYS_CTRS 4
+#define NR_CTRS      (NR_PHYS_CTRS * 2)
+
+/* Macros for the pm_control register. */
+#define CBE_PM_16BIT_CTR(ctr)              (1 << (24 - ((ctr) & (NR_PHYS_CTRS - 1))))
+#define CBE_PM_ENABLE_PERF_MON             0x80000000
+#define CBE_PM_STOP_AT_MAX                 0x40000000
+#define CBE_PM_TRACE_MODE_GET(pm_control)  (((pm_control) >> 28) & 0x3)
+#define CBE_PM_TRACE_MODE_SET(mode)        (((mode)  & 0x3) << 28)
+#define CBE_PM_COUNT_MODE_SET(count)       (((count) & 0x3) << 18)
+#define CBE_PM_FREEZE_ALL_CTRS             0x00100000
+#define CBE_PM_ENABLE_EXT_TRACE            0x00008000
+
+/* Macros for the trace_address register. */
+#define CBE_PM_TRACE_BUF_FULL              0x00000800
+#define CBE_PM_TRACE_BUF_EMPTY             0x00000400
+#define CBE_PM_TRACE_BUF_DATA_COUNT(ta)    ((ta) & 0x3ff)
+#define CBE_PM_TRACE_BUF_MAX_COUNT         0x400
+
+/* Macros for the pm07_control registers. */
+#define CBE_PM_CTR_INPUT_MUX(pm07_control) (((pm07_control) >> 26) & 0x3f)
+#define CBE_PM_CTR_INPUT_CONTROL           0x02000000
+#define CBE_PM_CTR_POLARITY                0x01000000
+#define CBE_PM_CTR_COUNT_CYCLES            0x00800000
+#define CBE_PM_CTR_ENABLE                  0x00400000
+
+/* Macros for the pm_status register. */
+#define CBE_PM_CTR_OVERFLOW_INTR(ctr)      (1 << (31 - ((ctr) & 7)))
+
+enum pm_reg_name {
+	group_control,
+	debug_bus_control,
+	trace_address,
+	ext_tr_timer,
+	pm_status,
+	pm_control,
+	pm_interval,
+	pm_start_stop,
+};
+
+/* Routines for reading/writing the PMU registers. */
+extern u32  cbe_read_phys_ctr(u32 cpu, u32 phys_ctr);
+extern void cbe_write_phys_ctr(u32 cpu, u32 phys_ctr, u32 val);
+extern u32  cbe_read_ctr(u32 cpu, u32 ctr);
+extern void cbe_write_ctr(u32 cpu, u32 ctr, u32 val);
+
+extern u32  cbe_read_pm07_control(u32 cpu, u32 ctr);
+extern void cbe_write_pm07_control(u32 cpu, u32 ctr, u32 val);
+extern u32  cbe_read_pm(u32 cpu, enum pm_reg_name reg);
+extern void cbe_write_pm(u32 cpu, enum pm_reg_name reg, u32 val);
+
+extern u32  cbe_get_ctr_size(u32 cpu, u32 phys_ctr);
+extern void cbe_set_ctr_size(u32 cpu, u32 phys_ctr, u32 ctr_size);
+
+extern void cbe_enable_pm(u32 cpu);
+extern void cbe_disable_pm(u32 cpu);
+
+extern void cbe_read_trace_buffer(u32 cpu, u64 *buf);
+
+#endif /* __ASM_CELL_PMU_H__ */

--

