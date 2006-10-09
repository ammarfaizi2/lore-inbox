Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932893AbWJIOMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbWJIOMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbWJIOLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:55 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:33521 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932893AbWJIOLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:24 -0400
Date: Mon, 9 Oct 2006 07:10:28 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EASIt026259@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] 2.6.18 perfmon2 : new x86_64 files
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

arch/x86_64/perfmon/perfmon_amd64.c:
	- PMU description for AMD64 PMU for both 32 and 64-bit modes

include/asm-x86_64/perfmon.h:
	- architecture specific header definitions



--- linux-2.6.18.base/arch/x86_64/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/x86_64/perfmon/Kconfig	2006-09-22 01:59:06.000000000 -0700
@@ -0,0 +1,39 @@
+menu "Hardware Performance Monitoring support"
+config PERFMON
+ 	bool "Perfmon2 performance monitoring interface"
+	default n
+ 	help
+  	Enables the perfmon2 interface to access the hardware
+	performance counters. See <http://perfmon2.sf.net/> for
+ 	more details.
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
+config X86_64_PERFMON_GEN_IA32
+	tristate "Support for Intel architectural performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables 64-bit support for Intel architectural performance counters.
+
+config X86_64_PERFMON_P4_PEBS
+	tristate "Support for Intel Precise Event-Based Sampling (PEBS)"
+	default n
+	help
+	Enables support for 64-bit Precise Event-Based Sampling (PEBS) on the Intel
+	Pentium 4 and Xeon processors which supports it.
+endmenu
--- linux-2.6.18.base/arch/x86_64/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/x86_64/perfmon/Makefile	2006-09-22 01:59:06.000000000 -0700
@@ -0,0 +1,15 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+
+obj-$(CONFIG_PERFMON)			+= perfmon.o
+obj-$(CONFIG_X86_64_PERFMON_K8)		+= perfmon_k8.o
+obj-$(CONFIG_X86_64_PERFMON_P4)		+= perfmon_p4.o
+obj-$(CONFIG_X86_64_PERFMON_GEN_IA32)	+= perfmon_gen_ia32.o
+obj-$(CONFIG_X86_64_PERFMON_P4_PEBS)	+= perfmon_p4_pebs_smpl.o
+
+perfmon-$(subst m,y,$(CONFIG_PERFMON)) += ../../i386/perfmon/perfmon.o
+perfmon_p4-$(subst m,y,$(CONFIG_X86_64_PERFMON_P4)) += ../../i386/perfmon/perfmon_p4.o
+perfmon_gen_ia32-$(subst m,y,$(CONFIG_X86_64_PERFMON_GEN_IA32)) += ../../i386/perfmon/perfmon_gen_ia32.o
+perfmon_p4_pebs_smpl-$(subst m,y,$(CONFIG_X86_64_PERFMON_P4_PEBS)) += ../../i386/perfmon/perfmon_p4_pebs_smpl.o
--- linux-2.6.18.base/arch/x86_64/perfmon/perfmon_k8.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/x86_64/perfmon/perfmon_k8.c	2006-09-25 12:15:31.000000000 -0700
@@ -0,0 +1,134 @@
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
+	.pmu_style = PFM_X86_PMU_P6,
+};
+
+/*
+ * reserved bits must be zero
+ *
+ * - upper 32 bits are reserved
+ * - APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ */
+#define PFM_K8_RSVD	~((0xffffffffULL<<32)	\
+			| (PFM_ONE_64<<20)	\
+			| (PFM_ONE_64<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ */
+#define PFM_K8_VAL	(PFM_ONE_64<<20)
+#define PFM_K8_NO64	(PFM_ONE_64<<20)
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
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		PFM_INFO("NMI watchdog using PERFEVTSEL0/PERTCTR0, disabling them for perfmon");
+		pfm_k8_pmc_desc[0].type = PFM_REG_NA;
+		pfm_k8_pmd_desc[0].type = PFM_REG_NA;
+		pfm_k8_pmu_info.pmc_addrs[0].reg_type = PFM_REGT_NA;
+		pfm_k8_pmu_info.pmd_addrs[0].reg_type = PFM_REGT_NA;
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
--- linux-2.6.18.base/include/asm-x86_64/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/asm-x86_64/perfmon.h	2006-09-25 12:17:56.000000000 -0700
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
--- linux-2.6.18.base/include/asm-x86_64/perfmon_p4_pebs_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/asm-x86_64/perfmon_p4_pebs_smpl.h	2006-09-25 12:18:06.000000000 -0700
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
+#include <asm-i386/perfmon_p4_pebs_smpl.h>
