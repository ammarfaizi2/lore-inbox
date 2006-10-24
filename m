Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWJXQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWJXQml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWJXQku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:40:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:19415 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030419AbWJXQkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:40:05 -0400
Message-Id: <20061024163815.640685000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:22 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 09/16] cell: add low-level performance monitoring code
Content-Disposition: inline; filename=cbe-pmu-regs.diff
Cc: Kevin Corry <kevcorry@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Corry <kevcorry@us.ibm.com>

Add routines for accessing the registers and counters in the performance
monitoring unit.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6/arch/powerpc/platforms/cell/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
-					   cbe_regs.o spider-pic.o pervasive.o
+					   cbe_regs.o spider-pic.o pervasive.o \
+					   pmu.o
 obj-$(CONFIG_CBE_RAS)			+= ras.o
 
 ifeq ($(CONFIG_SMP),y)
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -35,6 +35,11 @@
  *
  */
 
+/* Macros for the pm_control register. */
+#define CBE_PM_16BIT_CTR(ctr)			(1 << (24 - ((ctr) & (NR_PHYS_CTRS - 1))))
+#define CBE_PM_ENABLE_PERF_MON			0x80000000
+
+
 union spe_reg {
 	u64 val;
 	u8 spe[8];
Index: linux-2.6/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/pmu.c
@@ -0,0 +1,328 @@
+/*
+ * Cell Broadband Engine Performance Monitor
+ *
+ * (C) Copyright IBM Corporation 2001,2006
+ *
+ * Author:
+ *    David Erb (djerb@us.ibm.com)
+ *    Kevin Corry (kevcorry@us.ibm.com)
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
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/reg.h>
+#include <asm/spu.h>
+
+#include "cbe_regs.h"
+#include "interrupt.h"
+#include "pmu.h"
+
+/*
+ * When writing to write-only mmio addresses, save a shadow copy. All of the
+ * registers are 32-bit, but stored in the upper-half of a 64-bit field in
+ * pmd_regs.
+ */
+
+#define WRITE_WO_MMIO(reg, x)					\
+	do {							\
+		u32 _x = (x);					\
+		struct cbe_pmd_regs __iomem *pmd_regs;		\
+		struct cbe_pmd_shadow_regs *shadow_regs;	\
+		pmd_regs = cbe_get_cpu_pmd_regs(cpu);		\
+		shadow_regs = cbe_get_cpu_pmd_shadow_regs(cpu);	\
+		out_be64(&(pmd_regs->reg), (((u64)_x) << 32));	\
+		shadow_regs->reg = _x;				\
+	} while (0)
+
+#define READ_SHADOW_REG(val, reg)				\
+	do {							\
+		struct cbe_pmd_shadow_regs *shadow_regs;	\
+		shadow_regs = cbe_get_cpu_pmd_shadow_regs(cpu);	\
+		(val) = shadow_regs->reg;			\
+	} while (0)
+
+#define READ_MMIO_UPPER32(val, reg)				\
+	do {							\
+		struct cbe_pmd_regs __iomem *pmd_regs;		\
+		pmd_regs = cbe_get_cpu_pmd_regs(cpu);		\
+		(val) = (u32)(in_be64(&pmd_regs->reg) >> 32);	\
+	} while (0)
+
+/*
+ * Physical counter registers.
+ * Each physical counter can act as one 32-bit counter or two 16-bit counters.
+ */
+
+u32 cbe_read_phys_ctr(u32 cpu, u32 phys_ctr)
+{
+	u32 val_in_latch, val = 0;
+
+	if (phys_ctr < NR_PHYS_CTRS) {
+		READ_SHADOW_REG(val_in_latch, counter_value_in_latch);
+
+		/* Read the latch or the actual counter, whichever is newer. */
+		if (val_in_latch & (1 << phys_ctr)) {
+			READ_SHADOW_REG(val, pm_ctr[phys_ctr]);
+		} else {
+			READ_MMIO_UPPER32(val, pm_ctr[phys_ctr]);
+		}
+	}
+
+	return val;
+}
+
+void cbe_write_phys_ctr(u32 cpu, u32 phys_ctr, u32 val)
+{
+	struct cbe_pmd_shadow_regs *shadow_regs;
+	u32 pm_ctrl;
+
+	if (phys_ctr < NR_PHYS_CTRS) {
+		/* Writing to a counter only writes to a hardware latch.
+		 * The new value is not propagated to the actual counter
+		 * until the performance monitor is enabled.
+		 */
+		WRITE_WO_MMIO(pm_ctr[phys_ctr], val);
+
+		pm_ctrl = cbe_read_pm(cpu, pm_control);
+		if (pm_ctrl & CBE_PM_ENABLE_PERF_MON) {
+			/* The counters are already active, so we need to
+			 * rewrite the pm_control register to "re-enable"
+			 * the PMU.
+			 */
+			cbe_write_pm(cpu, pm_control, pm_ctrl);
+		} else {
+			shadow_regs = cbe_get_cpu_pmd_shadow_regs(cpu);
+			shadow_regs->counter_value_in_latch |= (1 << phys_ctr);
+		}
+	}
+}
+
+/*
+ * "Logical" counter registers.
+ * These will read/write 16-bits or 32-bits depending on the
+ * current size of the counter. Counters 4 - 7 are always 16-bit.
+ */
+
+u32 cbe_read_ctr(u32 cpu, u32 ctr)
+{
+	u32 val;
+	u32 phys_ctr = ctr & (NR_PHYS_CTRS - 1);
+
+	val = cbe_read_phys_ctr(cpu, phys_ctr);
+
+	if (cbe_get_ctr_size(cpu, phys_ctr) == 16)
+		val = (ctr < NR_PHYS_CTRS) ? (val >> 16) : (val & 0xffff);
+
+	return val;
+}
+
+void cbe_write_ctr(u32 cpu, u32 ctr, u32 val)
+{
+	u32 phys_ctr;
+	u32 phys_val;
+
+	phys_ctr = ctr & (NR_PHYS_CTRS - 1);
+
+	if (cbe_get_ctr_size(cpu, phys_ctr) == 16) {
+		phys_val = cbe_read_phys_ctr(cpu, phys_ctr);
+
+		if (ctr < NR_PHYS_CTRS)
+			val = (val << 16) | (phys_val & 0xffff);
+		else
+			val = (val & 0xffff) | (phys_val & 0xffff0000);
+	}
+
+	cbe_write_phys_ctr(cpu, phys_ctr, val);
+}
+
+/*
+ * Counter-control registers.
+ * Each "logical" counter has a corresponding control register.
+ */
+
+u32 cbe_read_pm07_control(u32 cpu, u32 ctr)
+{
+	u32 pm07_control = 0;
+
+	if (ctr < NR_CTRS)
+		READ_SHADOW_REG(pm07_control, pm07_control[ctr]);
+
+	return pm07_control;
+}
+
+void cbe_write_pm07_control(u32 cpu, u32 ctr, u32 val)
+{
+	if (ctr < NR_CTRS)
+		WRITE_WO_MMIO(pm07_control[ctr], val);
+}
+
+/*
+ * Other PMU control registers. Most of these are write-only.
+ */
+
+u32 cbe_read_pm(u32 cpu, enum pm_reg_name reg)
+{
+	u32 val = 0;
+
+	switch (reg) {
+	case group_control:
+		READ_SHADOW_REG(val, group_control);
+		break;
+
+	case debug_bus_control:
+		READ_SHADOW_REG(val, debug_bus_control);
+		break;
+
+	case trace_address:
+		READ_MMIO_UPPER32(val, trace_address);
+		break;
+
+	case ext_tr_timer:
+		READ_SHADOW_REG(val, ext_tr_timer);
+		break;
+
+	case pm_status:
+		READ_MMIO_UPPER32(val, pm_status);
+		break;
+
+	case pm_control:
+		READ_SHADOW_REG(val, pm_control);
+		break;
+
+	case pm_interval:
+		READ_SHADOW_REG(val, pm_interval);
+		break;
+
+	case pm_start_stop:
+		READ_SHADOW_REG(val, pm_start_stop);
+		break;
+	}
+
+	return val;
+}
+
+void cbe_write_pm(u32 cpu, enum pm_reg_name reg, u32 val)
+{
+	switch (reg) {
+	case group_control:
+		WRITE_WO_MMIO(group_control, val);
+		break;
+
+	case debug_bus_control:
+		WRITE_WO_MMIO(debug_bus_control, val);
+		break;
+
+	case trace_address:
+		WRITE_WO_MMIO(trace_address, val);
+		break;
+
+	case ext_tr_timer:
+		WRITE_WO_MMIO(ext_tr_timer, val);
+		break;
+
+	case pm_status:
+		WRITE_WO_MMIO(pm_status, val);
+		break;
+
+	case pm_control:
+		WRITE_WO_MMIO(pm_control, val);
+		break;
+
+	case pm_interval:
+		WRITE_WO_MMIO(pm_interval, val);
+		break;
+
+	case pm_start_stop:
+		WRITE_WO_MMIO(pm_start_stop, val);
+		break;
+	}
+}
+
+/*
+ * Get/set the size of a physical counter to either 16 or 32 bits.
+ */
+
+u32 cbe_get_ctr_size(u32 cpu, u32 phys_ctr)
+{
+	u32 pm_ctrl, size = 0;
+
+	if (phys_ctr < NR_PHYS_CTRS) {
+		pm_ctrl = cbe_read_pm(cpu, pm_control);
+		size = (pm_ctrl & CBE_PM_16BIT_CTR(phys_ctr)) ? 16 : 32;
+	}
+
+	return size;
+}
+
+void cbe_set_ctr_size(u32 cpu, u32 phys_ctr, u32 ctr_size)
+{
+	u32 pm_ctrl;
+
+	if (phys_ctr < NR_PHYS_CTRS) {
+		pm_ctrl = cbe_read_pm(cpu, pm_control);
+		switch (ctr_size) {
+		case 16:
+			pm_ctrl |= CBE_PM_16BIT_CTR(phys_ctr);
+			break;
+
+		case 32:
+			pm_ctrl &= ~CBE_PM_16BIT_CTR(phys_ctr);
+			break;
+		}
+		cbe_write_pm(cpu, pm_control, pm_ctrl);
+	}
+}
+
+/*
+ * Enable/disable the entire performance monitoring unit.
+ * When we enable the PMU, all pending writes to counters get committed.
+ */
+
+void cbe_enable_pm(u32 cpu)
+{
+	struct cbe_pmd_shadow_regs *shadow_regs;
+	u32 pm_ctrl;
+
+	shadow_regs = cbe_get_cpu_pmd_shadow_regs(cpu);
+	shadow_regs->counter_value_in_latch = 0;
+
+	pm_ctrl = cbe_read_pm(cpu, pm_control) | CBE_PM_ENABLE_PERF_MON;
+	cbe_write_pm(cpu, pm_control, pm_ctrl);
+}
+
+void cbe_disable_pm(u32 cpu)
+{
+	u32 pm_ctrl;
+	pm_ctrl = cbe_read_pm(cpu, pm_control) & ~CBE_PM_ENABLE_PERF_MON;
+	cbe_write_pm(cpu, pm_control, pm_ctrl);
+}
+
+/*
+ * Reading from the trace_buffer.
+ * The trace buffer is two 64-bit registers. Reading from
+ * the second half automatically increments the trace_address.
+ */
+
+void cbe_read_trace_buffer(u32 cpu, u64 *buf)
+{
+	struct cbe_pmd_regs __iomem *pmd_regs = cbe_get_cpu_pmd_regs(cpu);
+
+	*buf++ = in_be64(&pmd_regs->trace_buffer_0_63);
+	*buf++ = in_be64(&pmd_regs->trace_buffer_64_127);
+}
+
Index: linux-2.6/arch/powerpc/platforms/cell/pmu.h
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/cell/pmu.h
@@ -0,0 +1,57 @@
+/*
+ * Cell Broadband Engine Performance Monitor
+ *
+ * (C) Copyright IBM Corporation 2001,2006
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
+#ifndef __PERFMON_H__
+#define __PERFMON_H__
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
+extern u32  cbe_read_phys_ctr(u32 cpu, u32 phys_ctr);
+extern void cbe_write_phys_ctr(u32 cpu, u32 phys_ctr, u32 val);
+extern u32  cbe_read_ctr(u32 cpu, u32 ctr);
+extern void cbe_write_ctr(u32 cpu, u32 ctr, u32 val);
+
+extern u32  cbe_read_pm07_control(u32 cpu, u32 ctr);
+extern void cbe_write_pm07_control(u32 cpu, u32 ctr, u32 val);
+extern u32  cbe_read_pm (u32 cpu, enum pm_reg_name reg);
+extern void cbe_write_pm (u32 cpu, enum pm_reg_name reg, u32 val);
+
+extern u32  cbe_get_ctr_size(u32 cpu, u32 phys_ctr);
+extern void cbe_set_ctr_size(u32 cpu, u32 phys_ctr, u32 ctr_size);
+
+extern void cbe_enable_pm(u32 cpu);
+extern void cbe_disable_pm(u32 cpu);
+
+extern void cbe_read_trace_buffer(u32 cpu, u64 *buf);
+
+#endif

--

