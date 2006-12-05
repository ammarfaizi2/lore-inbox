Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968141AbWLELKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968141AbWLELKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968131AbWLELKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:10:10 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:64915 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759954AbWLELJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:09:20 -0500
Date: Tue, 5 Dec 2006 03:07:21 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B7Lsc017716@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] 2.6.19 perfmon2 : new x86_64 files
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the new x86_64 files.

The files are as follows:


arch/x86_64/perfmon/Kconfig:
	- add menuconfig options

arch/x86_64/perfmon/Makefile:
	- makefile for arch specific files

arch/x86_64/perfmon/perfmon_k8.c:
	- PMU description for Opteron/Althon64 PMU for both 32 and 64-bit modes

arch/x86_64/perfmon/perfmon_core.c:
	- PMU description for Intel Core-bsaed processors

include/asm-x86_64/perfmon.h:
	- architecture specific header definitions



--- linux-2.6.19.base/arch/x86_64/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/x86_64/perfmon/Kconfig	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,55 @@
+menu "Hardware Performance Monitoring support"
+config PERFMON
+ 	bool "Perfmon2 performance monitoring interface"
+	default n
+ 	help
+  	Enables the perfmon2 interface to access the hardware
+	performance counters. See <http://perfmon2.sf.net/> for
+ 	more details.
+
+config PERFMON_DEBUG
+ 	bool "Perfmon debugging"
+	default n
+	depends on PERFMON
+ 	help
+  	Enables perfmon debugging support
+
+config X86_64_PERFMON_K8
+	tristate "Support 64-bit mode AMD Athlon64 and Opteron64 hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for 64-bit mode AMD Athlon64 and Opteron64 processors
+	hardware performance counters.
+
+config X86_64_PERFMON_P4
+	tristate "Support for Intel 64-bit Pentium 4/Xeon hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for Intel 64-bit mode Pentium 4/Xeon hardware performance
+	counters.
+
+config  X86_64_PERFMON_CORE
+	tristate "Support for Intel Core-based performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables 64-bit support for Intel Core-based performance counters. Enable
+	this option to support Intel Core 2 Duo processors.
+
+config X86_64_PERFMON_GEN_IA32
+	tristate "Support for Intel architectural performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables 64-bit support for Intel architectural performance counters.
+
+config X86_64_PERFMON_PEBS
+	tristate "Support for Intel Precise Event-Based Sampling (PEBS)"
+	depends on PERFMON
+	default n
+	help
+	Enables support for 64-bit Precise Event-Based Sampling (PEBS) on the Intel
+	Pentium 4, Xeon, and Core-based processors which support it.
+endmenu
--- linux-2.6.19.base/arch/x86_64/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/x86_64/perfmon/Makefile	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,16 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+
+obj-$(CONFIG_PERFMON)			+= perfmon.o
+obj-$(CONFIG_X86_64_PERFMON_K8)		+= perfmon_k8.o
+obj-$(CONFIG_X86_64_PERFMON_P4)		+= perfmon_p4.o
+obj-$(CONFIG_X86_64_PERFMON_CORE)	+= perfmon_core.o
+obj-$(CONFIG_X86_64_PERFMON_GEN_IA32)	+= perfmon_gen_ia32.o
+obj-$(CONFIG_X86_64_PERFMON_PEBS)	+= perfmon_pebs_smpl.o
+
+perfmon-$(subst m,y,$(CONFIG_PERFMON)) += ../../i386/perfmon/perfmon.o
+perfmon_p4-$(subst m,y,$(CONFIG_X86_64_PERFMON_P4)) += ../../i386/perfmon/perfmon_p4.o
+perfmon_gen_ia32-$(subst m,y,$(CONFIG_X86_64_PERFMON_GEN_IA32)) += ../../i386/perfmon/perfmon_gen_ia32.o
+perfmon_pebs_smpl-$(subst m,y,$(CONFIG_X86_64_PERFMON_PEBS)) += ../../i386/perfmon/perfmon_pebs_smpl.o
--- linux-2.6.19.base/arch/x86_64/perfmon/perfmon_core.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/x86_64/perfmon/perfmon_core.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,285 @@
+/*
+ * This file contains the Intel Core PMU registers description tables.
+ * Intel Core 2 processor are based on the Intel Core microarchitecture.
+ *
+ * Copyright (c) 2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/nmi.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Intel Core");
+MODULE_LICENSE("GPL");
+
+/*
+ * - upper 32 bits are reserved
+ * - INT: APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ *
+ *   RSVD: reserved bits must be 1
+ */
+#define PFM_CORE_PMC_RSVD ((~((1ULL<<32)-1)) \
+		  	| (1ULL<<20)   \
+			| (1ULL<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ * disable with NO_EMUL64
+ */
+#define PFM_CORE_PMC_VAL	(1ULL<<20)
+#define PFM_CORE_NO64		(1ULL<<20)
+
+#define PFM_CORE_NA { .reg_type = PFM_REGT_NA}
+
+#define PFM_CORE_CA(m, c, t) \
+	{ \
+	  .addrs[0] = m, \
+	  .ctr = c, \
+	  .reg_type = t \
+	}
+/*
+ * physical addresses of MSR controlling the perfevtsel and counter registers
+ */
+struct pfm_arch_pmu_info pfm_core_pmu_info={
+	.pmc_addrs = {
+		PFM_CORE_CA(MSR_CORE_PERF_GLOBAL_CTRL, 0, PFM_REGT_EN),
+		PFM_CORE_CA(MSR_IA32_PEBS_ENABLE, 0, PFM_REGT_EN),
+		PFM_CORE_CA(MSR_CORE_PERF_FIXED_CTR_CTRL, 0, PFM_REGT_OTH),
+		PFM_CORE_NA,
+		PFM_CORE_CA(MSR_P6_EVNTSEL0, 4, PFM_REGT_OTH),
+		PFM_CORE_CA(MSR_P6_EVNTSEL1, 5, PFM_REGT_OTH)
+	},
+	.pmd_addrs = {
+		PFM_CORE_CA(MSR_CORE_PERF_FIXED_CTR0, 0, PFM_REGT_CTR),
+		PFM_CORE_CA(MSR_CORE_PERF_FIXED_CTR1, 0, PFM_REGT_CTR),
+		PFM_CORE_CA(MSR_CORE_PERF_FIXED_CTR2, 0, PFM_REGT_CTR),
+		PFM_CORE_NA,
+		PFM_CORE_CA(MSR_P6_PERFCTR0, 0, PFM_REGT_CTR),
+		PFM_CORE_CA(MSR_P6_PERFCTR1, 0, PFM_REGT_CTR)
+	},
+	.pebs_ctr_idx = 4, /* IA32_PMC0 */
+	.pmu_style = PFM_X86_PMU_CORE
+};
+
+/*
+ * force PMI bit on
+ */
+#define PFM_CORE_CTR_CTRL_VAL  (0x444ULL)
+#define PFM_CORE_CTR_CTRL_RSVD (~0xfffULL)
+
+static struct pfm_reg_desc pfm_core_pmc_desc[]={
+/* pmc0  */ { .type = PFM_REG_I,
+	      .desc = "GLOBAL_CTRL",
+	      .dfl_val = 0,
+	      .rsvd_msk = 0xfffffff8fffffffcULL,
+	      .no_emul64_msk = 0,
+	      .hw_addr = MSR_CORE_PERF_GLOBAL_CTRL
+	    },
+/* pmc1  */ { .type = PFM_REG_I,
+	      .desc = "PEBS_ENABLE",
+	      .dfl_val = 0,
+	      .rsvd_msk = 0xfffffffffffffffeULL,
+	      .no_emul64_msk = 0,
+	      .hw_addr = MSR_IA32_PEBS_ENABLE
+	    },
+/* pmc2  */ { .type = PFM_REG_I|PFM_REG_WC,
+	      .desc = "FIXED_CTRL",
+	      .dfl_val = 0x888ULL,
+	      .rsvd_msk = 0xfffffffffffff444ULL,
+	      .no_emul64_msk = 0,
+	      .hw_addr = MSR_CORE_PERF_FIXED_CTR_CTRL
+	    },
+/* pmc3  */ PMX_NA,
+/* pmc4  */ {
+	      .type = PFM_REG_I64|PFM_REG_NO64,
+	      .desc = "PERFEVTSEL0",
+	      .dfl_val = PFM_CORE_PMC_VAL,
+	      .rsvd_msk = PFM_CORE_PMC_RSVD,
+	      .no_emul64_msk = PFM_CORE_NO64,
+	      .hw_addr = MSR_P6_EVNTSEL0
+	    },
+/* pmc5  */ {
+	      .type = PFM_REG_I64|PFM_REG_WC|PFM_REG_NO64,
+	      .desc = "PERFEVTSEL1",
+	      .dfl_val = PFM_CORE_PMC_VAL,
+	      .rsvd_msk = PFM_CORE_PMC_RSVD,
+	      .no_emul64_msk = PFM_CORE_NO64,
+	      .hw_addr = MSR_P6_EVNTSEL1
+	    }
+};
+
+#define PFM_CORE_D(n) PMD_D(PFM_REG_C, "PMC"#n, MSR_P6_PERFCTR0+n)
+#define PFM_CORE_FD(n) PMD_D(PFM_REG_C, "FIXED_CTR"#n, MSR_CORE_PERF_FIXED_CTR0+n)
+
+static int nmi_uses_pmc0;
+
+static struct pfm_reg_desc pfm_core_pmd_desc[]={
+/* pmd0  */ PFM_CORE_FD(0),
+/* pmd1  */ PFM_CORE_FD(1),
+/* pmd2  */ PFM_CORE_FD(2),
+/* pmd3  */ PMX_NA,
+/* pmd4  */ PFM_CORE_D(0),
+/* pmd5  */ PFM_CORE_D(1)
+};
+#define PFM_CORE_NUM_PMCS	ARRAY_SIZE(pfm_core_pmc_desc)
+#define PFM_CORE_NUM_PMDS	ARRAY_SIZE(pfm_core_pmd_desc)
+
+static struct pfm_pmu_config pfm_core_pmu_conf;
+
+static int pfm_core_detect_nmi(void)
+{
+	unsigned int i;
+	int cnt, disabled = -1;
+
+	PFM_INFO("nmi_watchdog=%d nmi_active=%d", nmi_watchdog, atomic_read(&nmi_active));
+
+	/* NMI not using PMU */
+	if (nmi_watchdog != NMI_LOCAL_APIC)
+		return 0;
+
+	/*
+	 * assume NMI does not used the fixed counter. In any case, it cannot
+	 * because FIXED_CTR_CTRL is common to all fixed counters, so it would be
+	 * hard to share the other 2 fixed counters with somebody else.
+	 */
+
+	/* test IA32_PMC0, IA32_PMC1 */
+	for (i=4; i < 6; i++) {
+		if (avail_to_resrv_perfctr_nmi(pfm_core_pmd_desc[i].hw_addr))
+			continue;
+		if (disabled != -1) {
+			PFM_INFO("more than one counter used by NMI, not supported");
+			return -1;
+		}
+		PFM_INFO("NMI watchdog using %s/%s, disabling them for perfmon",
+			pfm_core_pmd_desc[i].desc,
+			pfm_core_pmc_desc[i].desc);
+
+		pfm_core_pmc_desc[i].type = PFM_REG_NA;
+		pfm_core_pmu_info.pmc_addrs[i].reg_type = PFM_REGT_EN;
+
+		pfm_core_pmd_desc[i].type = PFM_REG_NA;
+		pfm_core_pmu_info.pmd_addrs[i].reg_type = PFM_REGT_NA;
+		disabled = i;
+	}
+	/*
+	 * if NMI uses IA32_PMC0 or IA32_PMC1, we cannot use global controls
+	 * to start stop all counters. We disabled the global controls and
+	 * mark generic counters as each having enbale bits
+	 */
+
+	/* disable GLOBAL_CTRL */
+	pfm_core_pmc_desc[0].type = PFM_REG_NA;
+	pfm_core_pmu_info.pmc_addrs[0].reg_type = PFM_REGT_NA;
+
+	cnt = disabled == 4 ? 5 : 4;
+
+	/* mark fixed counters as having enable bit. All 3 controlled together */
+	pfm_core_pmu_info.pmc_addrs[2].reg_type = PFM_REGT_EN;/* FIXED_CTR_CTRL */
+
+	/* mark left-over counter as having enable bit */
+	pfm_core_pmu_info.pmc_addrs[cnt].reg_type = PFM_REGT_EN;
+
+	if (disabled == 4)
+		nmi_uses_pmc0 = 1;
+
+	pfm_core_pmu_info.flags |= PFM_X86_FL_USE_NMI;
+
+	return 0;
+}
+
+static int pfm_core_probe_pmu(void)
+{
+	int ret;
+
+	/*
+	 * only works on Intel processors
+	 */
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		PFM_INFO("not running on Intel processor");
+		return -1;
+	}
+
+	if (cpu_data->x86 != 6 || cpu_data->x86_model != 15)
+		return -1;
+
+	if (!cpu_has_apic) {
+		PFM_INFO("no Local APIC, unsupported");
+		return -1;
+	}
+
+	ret = pfm_core_detect_nmi();
+	if (ret == -1)
+		return -1;
+
+	/*
+	 * verify that DS/PEBS support is present
+	 */
+	if (cpu_has_ds) {
+		PFM_INFO("Data Save Area (DS) supported");
+
+		pfm_core_pmu_info.flags |= PFM_X86_FL_PMU_DS;
+
+		if (cpu_has_pebs && nmi_uses_pmc0 == 0) {
+			pfm_core_pmu_info.flags |= PFM_X86_FL_PMU_PEBS;
+			PFM_INFO("PEBS supported, enabled");
+		} else {
+			if (cpu_has_pebs && nmi_uses_pmc0)
+				PFM_INFO("PEBS supported, but disabled because NMI uses IA32_PMC0");
+			pfm_core_pmc_desc[1].type = PFM_REG_NA;
+			pfm_core_pmu_info.pmc_addrs[1].reg_type = PFM_REGT_NA;
+		}
+	}
+	return 0;
+}
+
+static int pfm_core_pmc_check(struct pfm_context *ctx,
+			     struct pfm_event_set *set,
+			     struct pfarg_pmc *req)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	/*
+	 * we come here only for the PMC that are forbidden
+	 * when PEBS is enabled
+	 */
+	return ctx_arch->flags & PFM_X86_USE_PEBS ?  -EINVAL : 0;
+}
+
+/*
+ * Counters may have model-specific width. Yet the documentation says
+ * that only the lower 32 bits can be written to. bits [w-32]
+ * are sign extensions of bit 31. As such the effective width of
+ * a counter is 31 bits only.
+ */
+static struct pfm_pmu_config pfm_core_pmu_conf={
+	.pmu_name = "Intel Core",
+	.pmd_desc = pfm_core_pmd_desc,
+	.counter_width = 31,
+	.num_pmc_entries = PFM_CORE_NUM_PMCS,
+	.num_pmd_entries = PFM_CORE_NUM_PMDS,
+	.pmc_write_check = pfm_core_pmc_check,
+	.pmc_desc = pfm_core_pmc_desc,
+	.probe_pmu = pfm_core_probe_pmu,
+	.version = "1.0",
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+	.arch_info = &pfm_core_pmu_info
+};
+	
+static int __init pfm_core_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_core_pmu_conf);
+}
+
+static void __exit pfm_core_pmu_cleanup_module(void)
+{
+	pfm_pmu_unregister(&pfm_core_pmu_conf);
+}
+
+module_init(pfm_core_pmu_init_module);
+module_exit(pfm_core_pmu_cleanup_module);
--- linux-2.6.19.base/arch/x86_64/perfmon/perfmon_k8.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/x86_64/perfmon/perfmon_k8.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,151 @@
+/*
+ * This file contains the PMU description for the Ahtlon64 and Opteron64
+ * processors. It supports 32 and 64-bit modes.
+ *
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/nmi.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Athlon/Opteron 64 (K8) PMU description table");
+MODULE_LICENSE("GPL");
+
+static struct pfm_arch_pmu_info pfm_k8_pmu_info={
+	.pmc_addrs = {
+		{{MSR_K7_EVNTSEL0, 0}, 0, PFM_REGT_EN},
+		{{MSR_K7_EVNTSEL1, 0}, 1, PFM_REGT_EN},
+		{{MSR_K7_EVNTSEL2, 0}, 2, PFM_REGT_EN},
+		{{MSR_K7_EVNTSEL3, 0}, 3, PFM_REGT_EN},
+	},
+	.pmd_addrs = {
+		{{MSR_K7_PERFCTR0, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR1, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR2, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR3, 0}, 0, PFM_REGT_CTR},
+	},
+	.pmu_style = PFM_X86_PMU_P6
+};
+
+/*
+ * reserved bits must be zero
+ *
+ * - upper 32 bits are reserved
+ * - APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ */
+#define PFM_K8_RSVD	((~((1ULL<<32)-1)) \
+			| (1ULL<<20)	\
+			| (1ULL<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ */
+#define PFM_K8_VAL	(1ULL<<20)
+#define PFM_K8_NO64	(1ULL<<20)
+
+static struct pfm_reg_desc pfm_k8_pmc_desc[]={
+/* pmc0  */ PMC_D(PFM_REG_I64, "PERFSEL0", PFM_K8_VAL, PFM_K8_RSVD, PFM_K8_NO64, MSR_K7_EVNTSEL0),
+/* pmc1  */ PMC_D(PFM_REG_I64, "PERFSEL1", PFM_K8_VAL, PFM_K8_RSVD, PFM_K8_NO64, MSR_K7_EVNTSEL1),
+/* pmc2  */ PMC_D(PFM_REG_I64, "PERFSEL2", PFM_K8_VAL, PFM_K8_RSVD, PFM_K8_NO64, MSR_K7_EVNTSEL2),
+/* pmc3  */ PMC_D(PFM_REG_I64, "PERFSEL3", PFM_K8_VAL, PFM_K8_RSVD, PFM_K8_NO64, MSR_K7_EVNTSEL3),
+};
+#define PFM_AMD_NUM_PMCS ARRAY_SIZE(pfm_k8_pmc_desc)
+
+static struct pfm_reg_desc pfm_k8_pmd_desc[]={
+/* pmd0  */ PMD_D(PFM_REG_C, "PERFCTR0", MSR_K7_PERFCTR0),
+/* pmd1  */ PMD_D(PFM_REG_C, "PERFCTR1", MSR_K7_PERFCTR1),
+/* pmd2  */ PMD_D(PFM_REG_C, "PERFCTR2", MSR_K7_PERFCTR2),
+/* pmd3  */ PMD_D(PFM_REG_C, "PERFCTR3", MSR_K7_PERFCTR3),
+};
+#define PFM_AMD_NUM_PMDS ARRAY_SIZE(pfm_k8_pmd_desc)
+
+static int pfm_k8_probe_pmu(void)
+{
+	unsigned int i;
+
+	if (cpu_data->x86_vendor != X86_VENDOR_AMD) {
+		PFM_INFO("not an AMD processor");
+		return -1;
+	}
+
+	if (cpu_data->x86 != 15) {
+		PFM_INFO("unsupported family=%d", cpu_data->x86);
+		return -1;
+	}
+
+	/*
+	 * check for local APIC (required)
+	 */
+	if (!cpu_has_apic) {
+		PFM_INFO("no local APIC, unsupported");
+		return -1;
+	}
+
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		/*
+		 * assume NMI watchdog is initialized before PMU description module
+		 * auto-detect which perfctr/eventsel is used by NMI watchdog
+		 */
+		for (i=0; i < PFM_AMD_NUM_PMDS; i++) {
+			if (avail_to_resrv_perfctr_nmi(pfm_k8_pmd_desc[i].hw_addr))
+				continue;
+
+			PFM_INFO("NMI watchdog using %s/%s, disabling for perfmon",
+				pfm_k8_pmc_desc[i].desc,
+				pfm_k8_pmd_desc[i].desc);
+
+			pfm_k8_pmc_desc[i].type = PFM_REG_NA;
+			pfm_k8_pmd_desc[i].type = PFM_REG_NA;
+			pfm_k8_pmu_info.pmc_addrs[i].reg_type = PFM_REGT_NA;
+			pfm_k8_pmu_info.pmd_addrs[i].reg_type = PFM_REGT_NA;
+		}
+		PFM_INFO("using NMI interrupt");
+		pfm_k8_pmu_info.flags |= PFM_X86_FL_USE_NMI;
+	}
+
+	return 0;
+}
+
+static struct pfm_pmu_config pfm_k8_pmu_conf={
+	.pmu_name = "AMD K8",
+	.counter_width = 47,
+	.pmd_desc = pfm_k8_pmd_desc,
+	.pmc_desc = pfm_k8_pmc_desc,
+	.num_pmc_entries = PFM_AMD_NUM_PMCS,
+	.num_pmd_entries = PFM_AMD_NUM_PMDS,
+	.probe_pmu = pfm_k8_probe_pmu,
+	.version = "1.0",
+	.arch_info = &pfm_k8_pmu_info,
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+	
+static int __init pfm_k8_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_k8_pmu_conf);
+}
+
+static void __exit pfm_k8_pmu_cleanup_module(void)
+{
+	pfm_pmu_unregister(&pfm_k8_pmu_conf);
+}
+
+module_init(pfm_k8_pmu_init_module);
+module_exit(pfm_k8_pmu_cleanup_module);
--- linux-2.6.19.base/include/asm-x86_64/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/include/asm-x86_64/perfmon.h	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file contains X86-64 Processor Family specific definitions
+ * for the perfmon interface.
+ *
+ * This file MUST never be included directly. Use linux/perfmon.h.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <asm-i386/perfmon.h>
--- linux-2.6.19.base/include/asm-x86_64/perfmon_pebs_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/include/asm-x86_64/perfmon_pebs_smpl.h	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <asm-i386/perfmon_pebs_smpl.h>
