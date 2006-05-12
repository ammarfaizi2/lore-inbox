Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWELQmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWELQmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWELQmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:42:14 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:56539 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S932153AbWELQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:40:20 -0400
Date: Fri, 12 May 2006 09:33:51 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200605121633.k4CGXpTY027382@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] perfmon2 patch for review: new x86_64 files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the new files for x86_64 (AMD and Intel EM64T).




--- linux-2.6.17-rc4.orig/arch/x86_64/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/arch/x86_64/perfmon/Kconfig	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,27 @@
+config X86_64_PERFMON_AMD
+	tristate "Support AMD X86-64 generic hardware performance counters"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the generic AMD X86-64 hardware performance
+	counters. Does not work with Intel EM64T processors.
+	If unsure, say m.
+
+config X86_64_PERFMON_EM64T
+	tristate "Support Intel EM64T hardware performance counters"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the Intel EM64T hardware performance
+	counters. Does not work with AMD X86-64 processors.
+	If unsure, say m.
+
+config X86_64_PERFMON_EM64T_PEBS
+	tristate "Support for Intel EM64T PEBS sampling format"
+	depends on X86_64_PERFMON_EM64T
+	default m
+	help
+	Enables support for Precise Event-Based Sampling (PEBS) on the Intel
+	EM64T processors which support it.  Does not work with AMD X86-64
+	processors.
+	If unsure, say m.
--- linux-2.6.17-rc4.orig/arch/x86_64/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/arch/x86_64/perfmon/Makefile	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,11 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+
+obj-$(CONFIG_PERFMON)			+= perfmon.o
+obj-$(CONFIG_X86_64_PERFMON_AMD)	+= perfmon_amd.o
+obj-$(CONFIG_X86_64_PERFMON_EM64T)	+= ../../i386/perfmon/perfmon_p4.o
+obj-$(CONFIG_X86_64_PERFMON_EM64T_PEBS)	+= perfmon_em64t_pebs_smpl.o
+
+perfmon-$(subst m,y,$(CONFIG_PERFMON)) += ../../i386/perfmon/perfmon.o
--- linux-2.6.17-rc4.orig/arch/x86_64/perfmon/perfmon_amd.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/arch/x86_64/perfmon/perfmon_amd.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,127 @@
+/*
+ * This file contains the AMD generic X86-64 PMU register
+ * description tables and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("AMD X86-64 PMU description table");
+MODULE_LICENSE("GPL");
+
+static struct pfm_arch_pmu_info pfm_x86_64_pmu_info={
+	.pmc_addrs = {
+		{{MSR_K7_EVNTSEL0, 0}, 0, PFM_REGT_PERFSEL},
+		{{MSR_K7_EVNTSEL1, 0}, 1, PFM_REGT_PERFSEL},
+		{{MSR_K7_EVNTSEL2, 0}, 2, PFM_REGT_PERFSEL},
+		{{MSR_K7_EVNTSEL3, 0}, 3, PFM_REGT_PERFSEL},
+	},
+	.pmd_addrs = {
+		{{MSR_K7_PERFCTR0, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR1, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR2, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR3, 0}, 0, PFM_REGT_CTR},
+	},
+	.pmu_style = PFM_X86_PMU_P6,
+	.lps_per_core = 1
+};
+
+/*
+ * reserved bits must be zero
+ *
+ * - upper 32 bits are reserved
+ * - APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ */
+#define PFM_X86_64_RSVD	~((0xffffffffULL<<32)	\
+				| (PFM_ONE_64<<20)	\
+				| (PFM_ONE_64<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ */
+#define PFM_X86_64_VAL  (PFM_ONE_64<<20)
+#define PFM_X86_64_NO64	    (PFM_ONE_64<<20)
+
+static struct pfm_reg_desc pfm_x86_64_pmc_desc[]={
+/* pmc0  */ { PFM_REG_W64, "PERFSEL0", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+/* pmc1  */ { PFM_REG_W64, "PERFSEL1", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+/* pmc2  */ { PFM_REG_W64, "PERFSEL2", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+/* pmc3  */ { PFM_REG_W64, "PERFSEL3", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+};
+#define PFM_AMD_NUM_PMCS ARRAY_SIZE(pfm_x86_64_pmc_desc)
+
+static struct pfm_reg_desc pfm_x86_64_pmd_desc[]={
+/* pmd0  */ { PFM_REG_C, "PERFCTR0", 0x0, -1},
+/* pmd1  */ { PFM_REG_C, "PERFCTR1", 0x0, -1},
+/* pmd2  */ { PFM_REG_C, "PERFCTR2", 0x0, -1},
+/* pmd3  */ { PFM_REG_C, "PERFCTR3", 0x0, -1},
+};
+#define PFM_AMD_NUM_PMDS ARRAY_SIZE(pfm_x86_64_pmd_desc)
+
+static int pfm_x86_64_probe_pmu(void)
+{
+	PFM_INFO("family=%d x86_model=%d",
+		 cpu_data->x86, cpu_data->x86_model);
+
+	if (cpu_data->x86 != 15) {
+		PFM_INFO("unsupported family=%d", cpu_data->x86);
+		return -1;
+	}
+
+	if (cpu_data->x86_vendor != X86_VENDOR_AMD) {
+		PFM_INFO("not an AMD processor");
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
+	return 0;
+}
+
+static struct pfm_pmu_config pfm_x86_64_pmu_conf={
+	.pmu_name = "AMD X86-64",
+	.counter_width = 47,
+	.pmd_desc = pfm_x86_64_pmd_desc,
+	.pmc_desc = pfm_x86_64_pmc_desc,
+	.num_pmc_entries = PFM_AMD_NUM_PMCS,
+	.num_pmd_entries = PFM_AMD_NUM_PMDS,
+	.probe_pmu = pfm_x86_64_probe_pmu,
+	.version = "1.0",
+	.arch_info = &pfm_x86_64_pmu_info,
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+	
+static int __init pfm_x86_64_pmu_init_module(void)
+{
+	unsigned int i;
+
+	/*
+	 * XXX: could be hardcoded for this PMU model
+	 */
+	bitmap_zero(ulp(pfm_x86_64_pmu_info.enable_mask), PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (pfm_x86_64_pmu_info.pmc_addrs[i].reg_type &
+		    PFM_REGT_PERFSEL) {
+			pfm_bv_set(pfm_x86_64_pmu_info.enable_mask, i);
+		}
+	}
+	return pfm_register_pmu_config(&pfm_x86_64_pmu_conf);
+}
+
+static void __exit pfm_x86_64_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_x86_64_pmu_conf);
+}
+
+module_init(pfm_x86_64_pmu_init_module);
+module_exit(pfm_x86_64_pmu_cleanup_module);
--- linux-2.6.17-rc4.orig/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,218 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for Intel
+ * EM64T Intel Pentium 4/Xeon processors. It does not work
+ * with Intel 32-bit P4/Xeon processors.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+#include <asm/msr.h>
+
+#include <linux/perfmon.h>
+#include <asm/perfmon_em64t_pebs_smpl.h>
+
+#ifndef __x86_64__
+#error "this module is for the Intel EM64T processors"
+#endif
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Intel 64-bit P4/Xeon PEBS sampling");
+MODULE_LICENSE("GPL");
+
+static int pfm_pebs_fmt_validate(u32 flags, u16 npmds, void *data)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_em64t_pebs_smpl_arg *arg = data;
+	size_t min_buf_size;
+
+	/*
+	 * host CPU does not have PEBS support
+	 */
+	if ((arch_info->flags & PFM_X86_PMU_PEBS) == 0) {
+		PFM_DBG("host PMU does not support PEBS sampling");
+		return -EINVAL;
+	}
+
+	/*
+	 * need to define at least the size of the buffer
+	 */
+	if (data == NULL) {
+		PFM_DBG("no argument passed");
+		return -EINVAL;
+	}
+
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(struct pfm_em64t_pebs_smpl_hdr) + sizeof(struct pfm_em64t_pebs_smpl_entry);
+
+	PFM_DBG("validate flags=0x%x min_buf_size=%zu buf_size=%zu",
+		  flags,
+		  min_buf_size,
+		  arg->buf_size);
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_get_size(unsigned int flags, void *data, size_t *size)
+{
+	struct pfm_em64t_pebs_smpl_arg *arg = data;
+
+	/*
+	 * size has been validated in pebs_fmt_validate()
+	 */
+	*size = arg->buf_size + 256;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_init(struct pfm_context *ctx, void *buf,
+			     u32 flags, u16 npmds, void *data)
+{
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_em64t_pebs_smpl_hdr *hdr;
+	struct pfm_em64t_pebs_smpl_arg *arg = data;
+	unsigned long base;
+	struct pfm_em64t_ds_area *ds;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	hdr = buf;
+	ds = &hdr->hdr_ds;
+
+	hdr->hdr_version = PFM_EM64T_PEBS_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_overflows = 0;
+
+	/*
+	 * align base
+	 */
+	base = ((unsigned long)(hdr+1) + 256) & ~0xffUL;
+	hdr->hdr_start_offs = base - (unsigned long)(hdr+1);
+	ds->pebs_buf_base = base;
+	ds->pebs_abs_max = base + arg->buf_size + 1;
+	ds->pebs_intr_thres = base + arg->intr_thres*sizeof(struct pfm_em64t_pebs_smpl_entry);
+	ds->pebs_index = base;
+
+	/*
+	 * save counter reset value for IQ_CCCR4 (thread0) or IQ_CCCR5 (thread1)
+	 */
+	ds->pebs_cnt_reset = arg->cnt_reset;
+
+	/*
+	 * Keep track of DS Area
+	 */
+	ctx_arch->ds_area = ds;
+
+	PFM_DBG("buffer=%p buf_size=%zu  ctx_flags=0x%x"
+		  "pebs_base=0x%llx pebs_max=0x%llx "
+		  "pebs_thres=0x%llx cnt_reset=0x%llx",
+		  buf,
+		  hdr->hdr_buf_size,
+		  ctx_arch->flags,
+		  ds->pebs_buf_base,
+		  ds->pebs_abs_max,
+		  ds->pebs_intr_thres,
+		  ds->pebs_cnt_reset);
+ 
+	return 0;
+}
+
+static int pfm_pebs_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	struct pfm_em64t_pebs_smpl_hdr *hdr;
+
+	hdr = buf;
+
+	PFM_DBG_ovfl("buffer full");
+	/*
+	 * increment number of buffer overflows.
+	 * important to detect duplicate set of samples.
+	 */
+	hdr->hdr_overflows++;
+
+	/*
+	 * request notification and masking of monitoring.
+	 * Notification is still subject to the overflowed
+	 * register having the FL_NOTIFY flag set.
+	 */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY| PFM_OVFL_CTRL_MASK;
+
+	return -ENOBUFS; /* we are full, sorry */
+}
+
+static int pfm_pebs_fmt_restart(int is_active, pfm_flags_t  *ovfl_ctrl, void *buf)
+{
+	struct pfm_em64t_pebs_smpl_hdr *hdr = buf;
+
+	/*
+	 * reset index to base of buffer
+	 */
+	hdr->hdr_ds.pebs_index = hdr->hdr_ds.pebs_buf_base;
+
+	*ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_exit(void *buf)
+{
+	return 0;
+}
+
+static struct pfm_smpl_fmt pebs_fmt={
+	.fmt_name = "Xeon-PEBS-em64t",
+	.fmt_uuid = PFM_EM64T_PEBS_SMPL_UUID,
+	.fmt_arg_size = sizeof(struct pfm_em64t_pebs_smpl_arg),
+	.fmt_validate = pfm_pebs_fmt_validate,
+	.fmt_getsize = pfm_pebs_fmt_get_size,
+	.fmt_init = pfm_pebs_fmt_init,
+	.fmt_handler = pfm_pebs_fmt_handler,
+	.fmt_restart = pfm_pebs_fmt_restart,
+	.fmt_exit = pfm_pebs_fmt_exit,
+	.fmt_flags = PFM_FMT_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL (1<<12) /* PEBS unavailable */
+#define cpu_has_dts boot_cpu_has(X86_FEATURE_DTES)
+
+static int __init pfm_pebs_fmt_init_module(void)
+{
+	int low, high;
+
+	if (!cpu_has_dts) {
+		PFM_INFO("processor does not have Data Save Area (DS)");
+		return -1;
+	}
+	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+
+	if (low & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL) {
+		PFM_INFO("processor does not support PEBS");
+		return -1;
+	}
+	return pfm_register_smpl_fmt(&pebs_fmt);
+}
+
+static void __exit pfm_pebs_fmt_cleanup_module(void)
+{
+	pfm_unregister_smpl_fmt(pebs_fmt.fmt_uuid);
+}
+
+module_init(pfm_pebs_fmt_init_module);
+module_exit(pfm_pebs_fmt_cleanup_module);
--- linux-2.6.17-rc4.orig/include/asm-x86_64/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/include/asm-x86_64/perfmon.h	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,10 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file contains X86-64 Processor Family specific definitions
+ * for the perfmon interface.
+ *
+ * This file MUST never be included directly. Use linux/perfmon.h.
+ */
+#include <asm-i386/perfmon.h>
--- linux-2.6.17-rc4.orig/include/asm-x86_64/perfmon_em64t_pebs_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc4/include/asm-x86_64/perfmon_em64t_pebs_smpl.h	2006-05-12 03:18:52.000000000 -0700
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for 64-bit
+ * Intel EM64T Pentium 4/Xeon processors. Not to be used with
+ * 32-bit Intel processors.
+ */
+#ifndef __PERFMON_EM64T_PEBS_SMPL_H__
+#define __PERFMON_EM64T_PEBS_SMPL_H__ 1
+
+#define PFM_EM64T_PEBS_SMPL_UUID { \
+	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
+	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}
+
+/*
+ * format specific parameters (passed at context creation)
+ *
+ * intr_thres: index from start of buffer of entry where the
+ * PMU interrupt must be triggered. It must be several samples
+ * short of the end of the buffer.
+ */
+struct pfm_em64t_pebs_smpl_arg {
+	size_t	buf_size;	/* size of the buffer in bytes */
+	size_t	intr_thres;	/* index of interrupt threshold entry */
+	u32	flags;		/* buffer specific flags */
+	u64	cnt_reset;	/* counter reset value */
+	u32	res1;		/* for future use */
+	u64	reserved[2];	/* for future use */
+};
+
+/*
+ * combined context+format specific structure. Can be passed
+ * to pfm_context_create()
+ */
+struct pfm_em64t_pebs_smpl_ctx_arg {
+	struct pfarg_ctx		ctx_arg;
+	struct pfm_em64t_pebs_smpl_arg	buf_arg;
+};
+
+/*
+ * DS Save Area as described in section 15.10.5 for
+ * 32-bit but extended to 64-bit
+ */
+struct pfm_em64t_ds_area {
+	u64	bts_buf_base;
+	u64	bts_index;
+	u64	bts_abs_max;
+	u64	bts_intr_thres;
+	u64	pebs_buf_base;
+	u64	pebs_index;
+	u64	pebs_abs_max;
+	u64	pebs_intr_thres;
+	u64     pebs_cnt_reset;
+};
+
+/*
+ * This header is at the beginning of the sampling buffer returned to the user.
+ *
+ * Because of PEBS alignement constraints, the actual PEBS buffer area does
+ * not necessarily begin right after the header. The hdr_start_offs must be
+ * used to compute the first byte of the buffer. The offset is defined as
+ * the number of bytes between the end of the header and the beginning of
+ * the buffer. As such the formula is:
+ * 	actual_buffer = (unsigned long)(hdr+1)+hdr->hdr_start_offs
+ */
+struct pfm_em64t_pebs_smpl_hdr {
+	u64			hdr_overflows;	/* #overflows for buffer */
+	size_t			hdr_buf_size;	/* bytes in the buffer */
+	size_t			hdr_start_offs; /* actual buffer start offset */
+	u32			hdr_version;	/* smpl format version */
+	u64			hdr_res[3];	/* for future use */
+	struct pfm_em64t_ds_area hdr_ds;	/* DS management Area */
+};
+
+/*
+ * EM64T PEBS record format as described in
+ * http://www.intel.com/technology/64bitextensions/30083502.pdf
+ */
+struct pfm_em64t_pebs_smpl_entry {
+	u64	eflags;
+	u64	ip;
+	u64	eax;
+	u64	ebx;
+	u64	ecx;
+	u64	edx;
+	u64	esi;
+	u64	edi;
+	u64	ebp;
+	u64	esp;
+	u64	r8;
+	u64	r9;
+	u64	r10;
+	u64	r11;
+	u64	r12;
+	u64	r13;
+	u64	r14;
+	u64	r15;
+};
+
+#define PFM_EM64T_PEBS_SMPL_VERSION_MAJ 1U
+#define PFM_EM64T_PEBS_SMPL_VERSION_MIN 0U
+#define PFM_EM64T_PEBS_SMPL_VERSION (((PFM_EM64T_PEBS_SMPL_VERSION_MAJ&0xffff)<<16)|\
+				   (PFM_EM64T_PEBS_SMPL_VERSION_MIN & 0xffff))
+
+#endif /* __PERFMON_EM64T_PEBS_SMPL_H__ */
