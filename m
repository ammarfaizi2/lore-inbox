Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUCCV5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUCCV5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:57:50 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:34678 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261166AbUCCVzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:55:51 -0500
Date: Wed, 3 Mar 2004 22:54:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk
Subject: powernow-k8-acpi driver
Message-ID: <20040303215435.GA467@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Lots of machines have broken PST tables, so current in-kernel driver
refuses to works on them. Vendors do get ACPI tables right because
apparently Windows use them ;-). So this driver tends to work.

Comments? Could we get this into mainline?

								Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-02-05 01:53:54.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-03-03 12:39:29.000000000 +0100
@@ -93,6 +93,19 @@
 	depends on CPU_FREQ && EXPERIMENTAL
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
+	  It relies on old "PST" tables. Unfortunately, many BIOSes get this table
+	  wrong. 
+
+	  For details, take a look at linux/Documentation/cpu-freq. 
+
+	  If in doubt, say N.
+
+config X86_POWERNOW_K8_ACPI
+	tristate "AMD Opteron/Athlon64 PowerNow! using ACPI"
+	depends on CPU_FREQ && EXPERIMENTAL
+	help
+	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
+	  It relies on ACPI.
 
 	  For details, take a look at linux/Documentation/cpu-freq. 
 
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/Makefile	2003-10-09 00:13:13.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/Makefile	2004-03-03 12:39:43.000000000 +0100
@@ -1,6 +1,7 @@
 obj-$(CONFIG_X86_POWERNOW_K6)	+= powernow-k6.o
 obj-$(CONFIG_X86_POWERNOW_K7)	+= powernow-k7.o
 obj-$(CONFIG_X86_POWERNOW_K8)	+= powernow-k8.o
+obj-$(CONFIG_X86_POWERNOW_K8_ACPI)	+= powernow-k8-acpi.o
 obj-$(CONFIG_X86_LONGHAUL)	+= longhaul.o
 obj-$(CONFIG_X86_P4_CLOCKMOD)	+= p4-clockmod.o
 obj-$(CONFIG_ELAN_CPUFREQ)	+= elanfreq.o
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-03 12:30:35.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-03 12:38:17.000000000 +0100
@@ -0,0 +1,1184 @@
+/*
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
+ *  Your use of this code is subject to the terms and conditions of the
+ *  GNU general public license version 2. See "../../../../../COPYING" or
+ *  http://www.gnu.org/licenses/gpl.html
+ *
+ *  This is the ACPI version of the cpu frequency driver. There is a
+ *  depreciated (and less functional) version of this driver that does not
+ *  use ACPI, and also does not support SMP.
+ *
+ *  Support : paul.devriendt@amd.com
+ *
+ *  Based on the powernow-k7.c module written by Dave Jones.
+ *  (c) 2003 Dave Jones <davej@codemonkey.ork.uk> on behalf of SuSE Labs
+ *  Licensed under the terms of the GNU GPL License version 2.
+ *  Based upon datasheets & sample CPUs kindly provided by AMD.
+ *
+ *  Valuable input gratefully received from Dave Jones, Pavel Machek, Dominik
+ *  Brodowski, and others.
+ *
+ *  Processor information obtained from Chapter 9 (Power and Thermal Management)
+ *  of the "BIOS and Kernel Developer's Guide for the AMD Athlon 64 and AMD
+ *  Opteron Processors", available for download from www.amd.com
+ */
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/acpi.h>
+
+#include <asm/msr.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#undef DEBUG
+#define VERSION "Version 1.20.02, Mar 1, 2004"
+#include "powernow-k8-acpi.h"
+
+static u8 **procs;                  /* per processor data structure     */
+static u32 rstps;                   /* pstates allowed restrictions     */
+static u32 seenrst;                 /* remember old bat restrictions    */
+static volatile int pollflg;        /* remember the state of the poller */
+static int acpierr;                 /* retain acpi error across walker  */
+static acpi_handle ppch;	    /* handle of the ppc object         */
+static acpi_handle psrh;            /* handle of the acpi power object  */
+static DECLARE_MUTEX(fidvid_sem);   /* serialize freq changes           */
+static DECLARE_MUTEX(poll_sem);     /* serialize poller state changes   */
+static struct timer_list ac_timer;  /* timer for the poller             */
+
+static struct cpufreq_driver cpufreq_amd64_driver = {
+	.verify = powernowk8_verify,
+	.target = powernowk8_target,
+	.init = powernowk8_cpu_init,
+	.name = "powernow-k8",
+	.owner = THIS_MODULE,
+};
+
+static inline u32 freq_from_fid(u8 fid)
+{
+	return 800 + (fid * 100);
+}
+
+static inline u32 kfreq_from_fid(u8 fid)
+{
+	return KHZ * freq_from_fid(fid);
+}
+
+static inline u32 fid_from_freq(u32 freq)
+{
+	return (freq - 800) / 100;
+}
+
+static inline u32 convert_fid_to_vfid(u8 fid)
+{
+	if (fid < HI_FID_TABLE_BOTTOM) {
+		return 8 + (2 * fid);
+	} else {
+		return fid;
+	}
+}
+
+static inline int pending_bit_stuck(void)
+{
+	u32 lo;
+	u32 hi;
+
+	rdmsr(MSR_FIDVID_STAT, lo, hi);
+	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
+}
+
+static int query_current_values_with_pending_wait(u8 *perproc)
+{
+	u32 lo = MSR_S_LO_CHANGE_PENDING;
+	u32 hi;
+	u32 i = 0;
+
+	while (lo & MSR_S_LO_CHANGE_PENDING) {
+		if (i++ > 0x1000000) {
+			printk(EFX "change pending stuck\n");
+			return 1;
+		}
+		rdmsr(MSR_FIDVID_STAT, lo, hi);
+	}
+	perproc[PP_OFF_CVID] = hi & MSR_S_HI_CURRENT_VID;
+	perproc[PP_OFF_CFID] = lo & MSR_S_LO_CURRENT_FID;
+	return 0;
+}
+
+/* need to init the control msr to a safe value (for each cpu) */
+static void fidvid_msr_init(void)
+{
+	u32 lo;
+	u32 hi;
+	u8 fid;
+	u8 vid;
+
+	rdmsr(MSR_FIDVID_STAT, lo, hi);
+	vid = hi & MSR_S_HI_CURRENT_VID;
+	fid = lo & MSR_S_LO_CURRENT_FID;
+	lo = fid | (vid << MSR_C_LO_VID_SHIFT);
+	hi = MSR_C_HI_STP_GNT_BENIGN;
+	dprintk(DFX "cpu%d, init lo %x, hi %x\n", smp_processor_id(), lo, hi);
+	wrmsr(MSR_FIDVID_CTL, lo, hi);
+}
+
+static inline void count_off_irt(u8 irt)
+{
+	udelay((1 << irt) * 10);
+}
+
+static inline void count_off_vst(u8 vstable)
+{
+	udelay(vstable * VST_UNITS_20US);
+}
+
+static int write_new_fid(u8 *perproc, u32 idx, u8 fid)
+{
+	u32 lo;
+	u32 hi;
+	struct pstate *pst;
+	u8 savevid = perproc[PP_OFF_CVID];
+
+	if (idx >= perproc[PP_OFF_NUMPS]) {
+		printk(EFX "idx overflow fid write\n");
+		return 1;
+	}
+	pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+	pst += idx;
+
+	if ((fid & INVALID_FID_MASK) || (savevid & INVALID_VID_MASK)) {
+		printk(EFX "overflow on fid write\n");
+		return 1;
+	}
+	lo = fid | (savevid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
+	hi = pst->plllock * PLL_LOCK_CONVERSION;
+	dprintk(DFX "cpu%d, writing fid %x, lo %x, hi %x\n",
+		smp_processor_id(), fid, lo, hi);
+	wrmsr(MSR_FIDVID_CTL, lo, hi);
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+	count_off_irt(pst->irt);
+
+	if (savevid != perproc[PP_OFF_CVID]) {
+		printk(EFX "vid change on fid trans, old %x, new %x\n",
+		       savevid, perproc[PP_OFF_CVID]);
+		return 1;
+	}
+	if (perproc[PP_OFF_CFID] != fid) {
+		printk(EFX "fid trans failed, targ %x, new %x\n",
+		       fid, perproc[PP_OFF_CFID]);
+		return 1;
+	}
+	return 0;
+}
+
+static int write_new_vid(u8 *perproc, u8 vid)
+{
+	u32 lo;
+	u8 savefid = perproc[PP_OFF_CFID];
+
+	if ((savefid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
+		printk(EFX "overflow on vid write\n");
+		return 1;
+	}
+
+	lo = perproc[PP_OFF_CFID] | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
+	dprintk(DFX "cpu%d, writing vid %x, lo %x, hi %x\n",
+		smp_processor_id(), vid, lo, STOP_GRANT_5NS);
+	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (savefid != perproc[PP_OFF_CFID]) {
+		printk(EFX "fid change on vid trans, old %x new %x\n",
+		       savefid, perproc[PP_OFF_CFID]);
+		return 1;
+	}
+	if (vid != perproc[PP_OFF_CVID]) {
+		printk(EFX "vid trans failed, vid %x, cvid %x\n",
+		       vid, perproc[PP_OFF_CFID]);
+		return 1;
+	}
+	return 0;
+}
+
+static int decrease_vid_code_by_step(u8 *perproc, u32 idx, u8 reqvid, u8 step)
+{
+	struct pstate *pst;
+
+	if (idx >= perproc[PP_OFF_NUMPS]) {
+		printk(EFX "idx overflow vid step\n");
+		return 1;
+	}
+	pst = (struct pstate *) (perproc + PP_OFF_BYTES);
+	pst += idx;
+
+	if (step == 0)  /* BIOS error if this is the case, but continue */
+		step = 1;
+
+	if ((perproc[PP_OFF_CVID] - reqvid) > step)
+		reqvid = perproc[PP_OFF_CVID] - step;
+	if (write_new_vid(perproc, reqvid))
+		return 1;
+	count_off_vst(pst->vstable);
+	return 0;
+}
+
+static inline int core_voltage_pre_transition(u8 *perproc, u32 idx, u8 rvid)
+{
+	struct pstate *pst;
+	u8 rvosteps;
+	u8 savefid = perproc[PP_OFF_CFID];
+
+	pst = (struct pstate *) (perproc + PP_OFF_BYTES);
+	pst += idx;
+	rvosteps = pst->rvo;
+	dprintk(DFX "ph1 start%d, cfid 0x%x, cvid 0x%x, rvid 0x%x, rvo %x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID], rvid, pst->rvo);
+
+	while (perproc[PP_OFF_CVID] > rvid) {
+		dprintk(DFX "ph1 curr %x, req vid %x\n",
+			    perproc[PP_OFF_CVID], rvid);
+		if (decrease_vid_code_by_step(perproc, idx, rvid, pst->vidmvs))
+			return 1;
+	}
+
+	while (rvosteps) {
+		if (perproc[PP_OFF_CVID] == 0) {
+			rvosteps = 0;
+		} else {
+			dprintk(DFX "ph1 changing vid for rvo, req 0x%x\n",
+				perproc[PP_OFF_CVID] - 1);
+			if (decrease_vid_code_by_step(perproc, idx,
+						perproc[PP_OFF_CVID] - 1, 1))
+				return 1;
+			rvosteps--;
+		}
+	}
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (savefid != perproc[PP_OFF_CFID]) {
+		printk(EFX "ph1 err, cfid changed %x\n", perproc[PP_OFF_CFID]);
+		return 1;
+	}
+	dprintk(DFX "ph1 done%d, cfid 0x%x, cvid 0x%x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+	return 0;
+}
+
+static inline int core_frequency_transition(u8 * perproc, u32 idx, u8 reqfid)
+{
+	u8 vcoreqfid;
+	u8 vcocurrfid;
+	u8 vcofiddiff;
+	u8 savevid = perproc[PP_OFF_CVID];
+
+	if ((reqfid < HI_FID_TABLE_BOTTOM)
+	    && (perproc[PP_OFF_CFID] < HI_FID_TABLE_BOTTOM)) {
+		printk(EFX "ph2 illegal lo-lo transition %x %x\n",
+		       reqfid, perproc[PP_OFF_CFID]);
+		return 1;
+	}
+
+	if (perproc[PP_OFF_CFID] == reqfid) {
+		printk(EFX "ph2 null fid transition %x\n", reqfid );
+		return 0;
+	}
+
+	dprintk(DFX "ph2 start%d, cfid %x, cvid %x, rfid %x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID], reqfid);
+
+	vcoreqfid = convert_fid_to_vfid(reqfid);
+	vcocurrfid = convert_fid_to_vfid(perproc[PP_OFF_CFID]);
+	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
+						: vcoreqfid - vcocurrfid;
+
+	while (vcofiddiff > FSTEP) {
+		if (reqfid > perproc[PP_OFF_CFID]) {
+			if (perproc[PP_OFF_CFID] > LO_FID_TABLE_TOP) {
+				if (write_new_fid(perproc, idx,
+						  perproc[PP_OFF_CFID] + FSTEP))
+					return 1;
+			} else {
+				if (write_new_fid(perproc, idx, FSTEP +
+				     convert_fid_to_vfid(perproc[PP_OFF_CFID])))
+					return 1;
+			}
+		} else {
+			if (write_new_fid(perproc, idx,
+					  perproc[PP_OFF_CFID]-FSTEP))
+				return 1;
+		}
+
+		vcocurrfid = convert_fid_to_vfid(perproc[PP_OFF_CFID]);
+		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
+						    : vcoreqfid - vcocurrfid;
+	}
+	if (write_new_fid(perproc, idx, reqfid))
+		return 1;
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (perproc[PP_OFF_CFID] != reqfid) {
+		printk(EFX "ph2 mismatch, failed transn, curr %x, req %x\n",
+		       perproc[PP_OFF_CFID], reqfid);
+		return 1;
+	}
+
+	if (savevid != perproc[PP_OFF_CVID]) {
+		printk(EFX "ph2 vid changed, save %x, curr %x\n", savevid,
+		       perproc[PP_OFF_CVID]);
+		return 1;
+	}
+
+	dprintk(DFX "ph2 complete%d, currfid 0x%x, currvid 0x%x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+	return 0;
+}
+
+static inline int core_voltage_post_transition(u8 * perproc, u32 idx, u8 reqvid)
+{
+	u8 savefid = perproc[PP_OFF_CFID];
+	u8 savereqvid = reqvid;
+
+	dprintk(DFX "ph3 starting%d, cfid 0x%x, cvid 0x%x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+
+	if (reqvid != perproc[PP_OFF_CVID]) {
+		if (write_new_vid(perproc, reqvid))
+			return 1;
+
+		if (savefid != perproc[PP_OFF_CFID]) {
+			printk(EFX "ph3: bad fid change, save %x, curr %x\n",
+			       savefid, perproc[PP_OFF_CFID]);
+			return 1;
+		}
+
+		if (perproc[PP_OFF_CVID] != reqvid) {
+			printk(EFX "ph3: failed vid trans\n, req %x, curr %x",
+			       reqvid, perproc[PP_OFF_CVID]);
+			return 1;
+		}
+	}
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (savereqvid != perproc[PP_OFF_CVID]) {
+		dprintk(EFX "ph3 failed, currvid 0x%x\n", perproc[PP_OFF_CVID]);
+		return 1;
+	}
+
+	if (savefid != perproc[PP_OFF_CFID]) {
+		dprintk(EFX "ph3 failed, currfid changed 0x%x\n",
+			perproc[PP_OFF_CFID]);
+		return 1;
+	}
+
+	dprintk(DFX "ph3 done%d, cfid 0x%x, cvid 0x%x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+	return 0;
+}
+
+static inline int transition_fid_vid(u8 *perproc, u32 idx, u8 rfid, u8 rvid)
+{
+	if (core_voltage_pre_transition(perproc, idx, rvid))
+		return 1;
+	if (core_frequency_transition(perproc, idx, rfid))
+		return 1;
+	if (core_voltage_post_transition(perproc, idx, rvid))
+		return 1;
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+	if ((rfid != perproc[PP_OFF_CFID]) || (rvid != perproc[PP_OFF_CVID])) {
+		printk(EFX "failed%d: req %x %x, curr %x %x\n",
+		       smp_processor_id(), rfid, rvid,
+		       perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		return 1;
+	}
+	dprintk(IFX "transitioned%d: new fid 0x%x, vid 0x%x\n",
+		smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+	return 0;
+}
+
+static inline int check_supported_cpu(void)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	u32 eax, ebx, ecx, edx;
+
+	if (c->x86_vendor != X86_VENDOR_AMD)
+		return 0;
+
+	eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
+	if (!(((eax & CPUID_XFAM_MOD) == ATHLON64_XFAM_MOD) ||
+	      ((eax & CPUID_XFAM_MOD) == OPTERON_XFAM_MOD))) {
+		dprintk(DFX "AMD Athlon 64 / Opteron processor required\n");
+		return 0;
+	}
+
+	eax = cpuid_eax(CPUID_GET_MAX_CAPABILITIES);
+	if (eax < CPUID_FREQ_VOLT_CAPABILITIES) {
+		printk(IFX "No freq change capabilities\n");
+		return 0;
+	}
+
+	cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
+	if ((edx & P_STATE_TRANSITION_CAPABLE) != P_STATE_TRANSITION_CAPABLE) {
+		printk(IFX "P-state transitions not supported\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+/* evaluating this object tells us whether we are using mains or battery */
+static inline int process_psr(acpi_handle objh)
+{
+	if (num_online_cpus() == 1) /* ignore BIOS claiming battery MP boxes */
+		psrh = objh;
+	return 0;
+}
+
+static inline void
+extract_pss_package(struct pstate *pst, struct proc_pss *proc)
+{
+	pst->freq = proc->freq;
+	pst->fid = proc->cntl & FID_MASK;
+	pst->vid = (proc->cntl >> VID_SHIFT) & VID_MASK;
+	pst->irt = (proc->cntl >> IRT_SHIFT) & IRT_MASK;
+	pst->rvo = (proc->cntl >> RVO_SHIFT) & RVO_MASK;
+	pst->plllock = (proc->cntl >> PLL_L_SHIFT) & PLL_L_MASK;
+	pst->vidmvs = 1 << ((proc->cntl >> MVS_SHIFT) & MVS_MASK);
+	pst->vstable = (proc->cntl >> VST_SHIFT) & VST_MASK;
+}
+
+/* per cpu perf states */
+static int process_pss(acpi_handle objh, unsigned cpunumb)
+{
+	struct proc_pss proc;
+	u8 *perproc;
+	struct pstate *pst;
+	u32 pstc;
+	acpi_status rc;
+	char pss_arr[1000];  /* big buffer on the stack rather than dyn alloc */
+	struct acpi_buffer buf = { sizeof(pss_arr), pss_arr };
+	unsigned int i;
+	union acpi_object *obj;
+	union acpi_object *data;
+	struct acpi_buffer format = { sizeof(PSS_FMT_STR), PSS_FMT_STR };
+	struct acpi_buffer state;
+
+	dprintk(DFX "processing _PSS for cpu%d\n", cpunumb);
+
+	if (procs[cpunumb]) {
+		printk(EFX "duplicate cpu data in acpi _pss\n");
+		return -ENODEV;
+	}
+
+	memset(pss_arr, 0, sizeof(pss_arr));
+	rc = acpi_evaluate_object(objh, NULL, NULL, &buf);
+	if (ACPI_FAILURE(rc)) {
+		printk(EFX "evaluate pss failed: %x\n", rc);
+		return -ENODEV;
+	}
+
+	obj = (union acpi_object *) &pss_arr[0];
+	if (obj->package.type != ACPI_TYPE_PACKAGE) {
+		printk(EFX "pss is not a package\n");
+		return -ENODEV;
+	}
+	pstc = obj->package.count;
+	if (pstc < 2) {
+		printk(EFX "insufficient pstates (%d)\n", pstc);
+		return -ENODEV;
+	}
+
+	i = (PP_OFF_BYTES * sizeof(u8)) + (sizeof(struct pstate) * pstc);
+	perproc = kmalloc(i, GFP_KERNEL);
+	if (!perproc) {
+		printk(EFX "perproc memory alloc failure\n");
+		return -ENOMEM;
+	}
+	memset(perproc, 0, i);
+	pst = (struct pstate *) (perproc + PP_OFF_BYTES);
+	perproc[PP_OFF_NUMPS] = pstc;
+
+	data = obj->package.elements;
+	for (i = 0; i < pstc; i++) {
+		if (data[i].package.type != ACPI_TYPE_PACKAGE) {
+			printk(EFX "%d: type %d\n", i, data[i].package.type);
+			kfree(perproc);
+			return -ENODEV;
+		}
+		state.length = sizeof(struct proc_pss);
+		state.pointer = &proc;
+		rc = acpi_extract_package(&obj->package.elements[i],
+					  &format, &state);
+		if (rc) {
+			printk(EFX "extract err %x\n", rc);
+			kfree(perproc);
+			return -ENODEV;
+		}
+		extract_pss_package(pst + i, &proc);
+	}
+
+	procs[cpunumb] = perproc;
+	return 0;
+}
+
+static u32 query_ac(void)
+{
+	acpi_status rc;
+	unsigned long state;
+
+	if (psrh) {
+		rc = acpi_evaluate_integer(psrh, NULL, NULL, &state);
+		if (ACPI_SUCCESS(rc)) {
+			if (state == 1)
+				return POW_AC;
+			else if (state == 0)
+				return POW_BAT;
+			else
+				printk(EFX "psr state %lx\n", state);
+		}
+		else {
+			printk(EFX "error %x evaluating psr\n", rc );
+		}
+	}
+	return POW_UNK;
+}
+
+/* gives us the (optional) battery/thermal restrictions */
+static int process_ppc(acpi_handle objh)
+{
+	acpi_status rc;
+	unsigned long state;
+
+	if (objh) {
+		ppch = objh;
+	} else {
+		if (ppch) {
+			objh = ppch;
+		} else {
+			rstps = 0;
+			return 0;   
+		}
+	}
+
+	if (num_online_cpus() > 1) {
+		/* For future thermal support (next release?), rstps needs   */
+		/* to be per processor, and handled for the SMP case. Later. */
+		dprintk(EFX "ignoring attempt to restrict pstates for SMP\n");
+	}
+	else {
+		rc = acpi_evaluate_integer(objh, NULL, NULL, &state);
+		if (ACPI_SUCCESS(rc)) {
+			rstps = state & 0x0f;
+			//dprintk(DFX "pstate restrictions %x\n", rstps);
+			if (!seenrst)
+				seenrst = rstps;
+		}
+		else {
+			rstps = 0;
+			printk(EFX "error %x processing ppc\n", rc);
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+static int powernow_find_objects(acpi_handle objh, char *nspace)
+{
+	acpi_status rc;
+	char name[80] = { '?', '\0' };
+	struct acpi_buffer buf = { sizeof(name), name };
+	unsigned cpuobj;
+	unsigned len = strlen(nspace);
+	unsigned dotoff = len + 1;
+	unsigned objoff = len + 2;
+
+	rc = acpi_get_name(objh, ACPI_FULL_PATHNAME, &buf);
+	if (ACPI_SUCCESS(rc)) {
+		if (!psrh) {
+			if (!strcmp(name + strlen(name) - 4, "_PSR")) {
+				dprintk(IFX "_psr found in %s\n", name);
+				return process_psr(objh);
+			}
+		}
+
+		if ((!(strncmp(name, nspace, len))) && (name[dotoff] == '.')) {
+			dprintk(IFX "searching %s\n", nspace);
+			cpuobj = name[len] - '0';
+			dprintk(IFX "cpu%u, %s\n", cpuobj, name);
+			if (cpuobj >= num_online_cpus()) {
+				printk(EFX "cpu count mismatch: %d, %d\n",
+                                       cpuobj, num_online_cpus());
+				acpierr = -ENODEV;
+				return 0;
+			}
+
+			if (!(strcmp(name + objoff, "_PSS"))) {
+				dprintk(IFX "_pss found in %s\n", nspace);
+				acpierr = process_pss(objh, cpuobj);
+				return 0;
+			} else if (!(strcmp(name + objoff, "_PPC"))) {
+				dprintk(IFX "_ppc found in %s\n", nspace);
+				acpierr = process_ppc(objh);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
+static acpi_status
+powernow_walker(acpi_handle objh, u32 nestl, void *ctx, void **wrc)
+{
+	int notfound = powernow_find_objects(objh, "\\_SB_.CPU");
+	if (notfound)
+		powernow_find_objects(objh, "\\_PR_.CPU");
+	return AE_OK;
+}
+
+static inline int find_acpi_table(void)
+{
+	acpi_status rc;
+	acpi_status wrc;
+	void *pwrc = &wrc;
+	unsigned i;
+	unsigned j;
+	struct pstate *pst;
+
+	rc = acpi_subsystem_status();
+	if (ACPI_FAILURE(rc)) {
+		printk(EFX "acpi subsys rc: %x\n", rc);
+		return -ENODEV;
+	}
+	rc = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT, 6,
+				 powernow_walker, 0, &pwrc);
+	if (rc)
+		return rc;
+	if (acpierr)
+		return acpierr;
+
+	for (i = 0; i < num_online_cpus(); i++) {
+		if (procs[i]) {
+			pst = (struct pstate *) (procs[i] + PP_OFF_BYTES);
+			for (j = 0; j < procs[i][PP_OFF_NUMPS]; j++)
+				dprintk(IFX
+			            "cpu%d: freq %d: fid %x, vid %x, irt %x, "
+				    "rvo %x, plllock %x, vidmvs %x, vstbl %x\n",
+				    i, pst[j].freq, pst[j].fid, pst[j].vid,
+				    pst[j].irt, pst[j].rvo, pst[j].plllock,
+				    pst[j].vidmvs, pst[j].vstable);
+		} else {
+			printk(EFX "Missing pstates for cpu%d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	i = query_ac();
+	dprintk(IFX "mains power %s\n", POW_AC == i ? "online"
+		       : POW_BAT == i ? "offline" : "unknown");
+
+	return 0;
+}
+
+/* destroy the global table of per processor data */
+static void cleanup_procs(void)  
+{
+	unsigned i;
+	if (procs)
+		for (i = 0; i < num_online_cpus(); i++)
+			kfree(procs[i]);
+	kfree(procs);
+}
+
+static u8 find_closest_fid(u16 freq)
+{
+	freq += MIN_FREQ_RESOLUTION - 1;
+	freq = (freq / MIN_FREQ_RESOLUTION) * MIN_FREQ_RESOLUTION;
+	if (freq < MIN_FREQ)
+		freq = MIN_FREQ;
+	else if (freq > MAX_FREQ)
+		freq = MAX_FREQ;
+	return fid_from_freq(freq);
+}
+
+static int find_match(u8 *perproc, u16 *ptargfreq, u16 *pmin, u16 *pmax,
+			u8 *pfid, u8 *pvid, u32 *idx)
+{
+	u32 availpstates = perproc[PP_OFF_NUMPS];
+	u8 targfid = find_closest_fid(*ptargfreq);
+	u8 minfid = find_closest_fid(*pmin);
+	u8 maxfid = find_closest_fid(*pmax);
+	u32 maxidx = 0;
+	u32 minidx = availpstates - 1;
+	u32 targidx = 0xffffffff;
+	int i;
+	struct pstate *pst = (struct pstate *) (perproc + PP_OFF_BYTES);
+
+	dprintk(DFX "find match: freq %d MHz (%x), min %d (%x), max %d (%x)\n",
+		*ptargfreq, targfid, *pmin, minfid, *pmax, maxfid);
+
+	/* restrict to permitted pstates (battery/thermal) */
+        process_ppc(0);
+	if (rstps > availpstates)
+		rstps = 0;
+	if (rstps && (POW_BAT == query_ac())) { /* not restricting for thermal */
+		maxidx = availpstates - rstps;
+		dprintk(DFX "bat: idx restr %d-%d\n", maxidx, minidx);
+	}
+
+	/* Restrict values to the frequency choices in the pst */
+	if (minfid < pst[minidx].fid)
+		minfid = pst[minidx].fid;
+	if (maxfid > pst[maxidx].fid)
+		maxfid = pst[maxidx].fid;
+
+	/* Find appropriate pst index for the max fid */
+	for (i = 0; i < (int) availpstates; i++) {
+		if (maxfid <= pst[i].fid)
+			maxidx = i;
+	}
+
+	/* Find appropriate pst index for the min fid */
+	for (i = availpstates - 1; i >= 0; i--) {
+		if (minfid >= pst[i].fid)
+			minidx = i;
+	}
+
+	if (minidx < maxidx)
+		minidx = maxidx;
+
+	dprintk(DFX "minidx %d, maxidx %d\n", minidx, maxidx);
+
+	/* Frequency ids are now constrained by limits matching PST entries */
+	minfid = pst[minidx].fid;
+	maxfid = pst[maxidx].fid;
+
+	/* Limit the target frequency to these limits */
+	if (targfid < minfid)
+		targfid = minfid;
+	else if (targfid > maxfid)
+		targfid = maxfid;
+
+	/* Find the best target index into the PST, contrained by the range */
+	for (i = minidx; i >= (int) maxidx; i--) {
+		if (targfid >= pst[i].fid)
+			targidx = i;
+	}
+
+	if (targidx == 0xffffffff) {
+		printk(EFX "could not find target\n");
+		return 1;
+	}
+	*pmin = freq_from_fid(minfid);
+	*pmax = freq_from_fid(maxfid);
+	*ptargfreq = freq_from_fid(pst[targidx].fid);
+	*pfid = pst[targidx].fid;
+	*pvid = pst[targidx].vid;
+	*idx = targidx;
+	return 0;
+}
+
+static inline int
+transition_frequency(u8 *perproc, u16 *preq, u16 *pmin, u16 *pmax)
+{
+	u32 idx;
+	int res;
+	struct cpufreq_freqs freqs;
+	u8 fid;
+	u8 vid;
+
+	if (find_match(perproc, preq, pmin, pmax, &fid, &vid, &idx))
+		return 1;
+	dprintk(DFX "matched idx %x: fid 0x%x vid 0x%x\n", idx, fid, vid);
+
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+	if ((perproc[PP_OFF_CVID] == vid) && (perproc[PP_OFF_CFID] == fid)) {
+		dprintk(DFX "targ matches curr (fid %x, vid %x)\n", fid, vid);
+		return 0;
+	}
+
+	if ((fid < HI_FID_TABLE_BOTTOM)
+	    && (perproc[PP_OFF_CFID] < HI_FID_TABLE_BOTTOM)) {
+		printk(EFX "ignoring change in lo freq table: %x to %x\n",
+		       perproc[PP_OFF_CFID], fid);
+		return 1;
+	}
+
+	dprintk(DFX "cpu%d to fid %x vid %x\n", smp_processor_id(), fid, vid);
+
+	freqs.cpu = smp_processor_id();
+	freqs.old = freq_from_fid(perproc[PP_OFF_CFID]);
+	freqs.new = freq_from_fid(fid);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	down(&fidvid_sem);
+	res = transition_fid_vid(perproc, idx, fid, vid);
+	up(&fidvid_sem);
+
+	freqs.new = freq_from_fid(perproc[PP_OFF_CFID]);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return res;
+}
+
+static int need_poller(void)   /* if running at a freq only allowed for a/c */
+{
+	u8 *perproc = procs[0];
+	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+        u32 maxidx;
+
+        if (num_online_cpus() > 1)
+		return 0;
+
+        process_ppc(0);
+	if (rstps > perproc[PP_OFF_NUMPS])
+		return 0;
+	maxidx = perproc[PP_OFF_NUMPS] - rstps;
+	pst += maxidx;
+	if (rstps && (perproc[PP_OFF_CFID] > pst->fid ))
+		return 1;
+	return 0;
+}
+
+/* transiion if needed, restart if needed */
+static void ac_poller(unsigned long x)  
+{
+	int pow;
+	u8 *perproc = procs[0];
+	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+        u32 maxidx = perproc[PP_OFF_NUMPS] - rstps;
+	u16 rf = pst[maxidx].freq;
+	u16 minfreq = pst[perproc[PP_OFF_NUMPS]-1].freq;
+	u16 maxfreq = pst[maxidx].freq;
+
+	down(&poll_sem);
+	if (pollflg == POLLER_UNLOAD) {
+		pollflg == POLLER_DEAD;
+		up(&poll_sem);
+		return;
+	}
+        process_ppc(0);
+	if (rstps > perproc[PP_OFF_NUMPS]) {
+		pollflg = POLLER_NOT_RUNNING;
+		up(&poll_sem);
+		return;
+	}
+	if (pollflg != POLLER_RUNNING)
+		panic("k8-pn pollflg %x\n", pollflg);
+	up(&poll_sem);
+
+	pow = query_ac();
+	if (POW_AC == pow) {                 /* only poll if cpu is at high */
+		if (need_poller()) {         /* speed and on mains power    */
+			start_ac_poller(1);
+			return;
+		}
+	}
+	else if (POW_BAT == pow) {
+		if (need_poller()) {
+			dprintk(DFX "battery emergency transition\n" );
+                        transition_frequency(perproc, &rf, &minfreq, &maxfreq);
+		}
+	}
+	down(&poll_sem);
+	pollflg = POLLER_NOT_RUNNING;
+	up(&poll_sem);
+}
+
+static void start_ac_poller(int frompoller)
+{
+	down(&poll_sem);
+	if ( (frompoller) || (pollflg == POLLER_NOT_RUNNING) ) {
+		init_timer(&ac_timer);
+		ac_timer.function = ac_poller;
+		ac_timer.data = 0;
+		ac_timer.expires = jiffies + HZ;
+		add_timer( &ac_timer );
+		pollflg = POLLER_RUNNING;
+		//dprintk(DFX "timer added\n");
+	}
+	up(&poll_sem);
+}
+
+static int powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq,
+				unsigned relation)
+{
+	cpumask_t oldmask = CPU_MASK_ALL;
+	unsigned thiscpu;
+	int rc = 0;
+	u16 reqfreq = (u16)(targfreq / KHZ);
+	u16 minfreq = (u16)(pol->min / KHZ);
+	u16 maxfreq = (u16)(pol->max / KHZ);
+	u8 *perproc;
+	u8 checkfid;
+	u8 checkvid;
+
+	dprintk(IFX "proc mask %lx, current %d\n", current->cpus_allowed,
+		smp_processor_id());
+	dprintk(DFX "targ%d: %d kHz, min %d, max %d, relation %d\n",
+		pol->cpu, targfreq, pol->min, pol->max, relation);
+
+	if (pol->cpu > num_online_cpus()) {
+		printk(EFX "targ out of range\n");
+		return -ENODEV;
+	}
+	if (procs == NULL) {
+		printk(EFX "targ: procs 0\n");
+		return -ENODEV;
+	}
+	perproc = procs[pol->cpu];
+	if (perproc == NULL) {
+		printk(EFX "targ: perproc 0 for cpu%d\n", pol->cpu);
+		return -ENODEV;
+	}
+
+        thiscpu = smp_processor_id();
+	if (num_online_cpus()>1) {
+		oldmask = current->cpus_allowed;
+		set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
+		schedule();
+	}
+
+	/* from this point, do not exit without restoring preempt and cpu */
+	preempt_disable();
+
+	dprintk(DFX "targ cpu %d, curr cpu %d (mask %lx)\n", pol->cpu,
+		    smp_processor_id(),	current->cpus_allowed);
+
+	checkfid = perproc[PP_OFF_CFID];
+	checkvid = perproc[PP_OFF_CVID];
+	if (query_current_values_with_pending_wait(perproc)) {
+		printk(EFX "drv targ fail: change pending bit set\n");
+		rc = -EIO;
+		goto targ_exit;
+	}
+	dprintk(DFX "targ%d: curr fid %x, vid %x\n", smp_processor_id(),
+		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+	if ((checkvid != perproc[PP_OFF_CVID])
+	    || (checkfid != perproc[PP_OFF_CFID])) {
+		printk(EFX "error - out of sync, fid %x %x, vid %x %x\n",
+		       checkfid, perproc[PP_OFF_CFID], checkvid,
+		       perproc[PP_OFF_CVID]);
+	}
+
+	if (transition_frequency(perproc, &reqfreq, &minfreq, &maxfreq)) {
+		printk(EFX "transition frequency failed\n");
+		rc = -EIO;
+		goto targ_exit;
+	}
+
+	pol->cur = kfreq_from_fid(perproc[PP_OFF_CFID]);
+
+targ_exit:
+	preempt_enable_no_resched();
+	if (num_online_cpus()>1) {
+		set_cpus_allowed(current, cpumask_of_cpu(thiscpu));
+		schedule();			  
+		set_cpus_allowed(current, oldmask);
+	}
+        if ((POW_AC == query_ac()) && (need_poller()))
+		start_ac_poller(0);
+	return rc;
+}
+
+static int powernowk8_verify(struct cpufreq_policy *pol)
+{
+	u16 min = (u16)(pol->min / KHZ);
+	u16 max = (u16)(pol->max / KHZ);
+	u16 targ = min;
+	u8 *perproc;
+	int res;
+	u32 idx;
+	u8 fid;
+	u8 vid;
+
+	dprintk(DFX "ver: cpu%d, min %d, max %d, cur %d, pol %d\n",
+		pol->cpu, pol->min, pol->max, pol->cur, pol->policy);
+
+	if (pol->cpu > num_online_cpus()) {
+		printk(EFX "ver cpu out of range\n");
+		return -ENODEV;
+	}
+	if (procs == NULL) {
+		printk(EFX "verify - procs 0\n");
+		return -ENODEV;
+	}
+	perproc = procs[pol->cpu];
+	if (perproc == NULL) {
+		printk(EFX "verify: perproc 0 for cpu%d\n", pol->cpu);
+		return -ENODEV;
+	}
+
+	res = find_match(perproc, &targ, &min, &max, &fid, &vid, &idx);
+	if (!res) {
+		pol->min = min * KHZ;
+		pol->max = max * KHZ;
+	}
+	return res;
+}
+
+static int __init powernowk8_cpu_init(struct cpufreq_policy *pol)
+{
+	u8 *perproc = procs[smp_processor_id()];
+	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+
+	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	pol->cpuinfo.transition_latency =             /* crude guess */
+		((pst[0].rvo + 8) * pst[0].vstable * VST_UNITS_20US)
+		+ (3 * (1 << pst[0].irt) * 10);
+
+	pol->cur = kfreq_from_fid(perproc[PP_OFF_CFID]);
+	dprintk(DFX "policy cfreq %d kHz\n", pol->cur);
+
+	/* min/max this cpu is capable of */
+	pol->cpuinfo.min_freq =kfreq_from_fid(pst[perproc[PP_OFF_NUMPS]-1].fid);
+	pol->cpuinfo.max_freq = kfreq_from_fid(pst[0].fid);
+	pol->min = pol->cpuinfo.min_freq;
+	pol->max = pol->cpuinfo.max_freq;
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+static void smp_k8_init( void *retval )
+{
+	u8 *perproc = procs[smp_processor_id()];
+	int *rc = (int *)retval;
+	rc += smp_processor_id();
+
+	dprintk(DFX "smp init on %d\n", smp_processor_id());
+	if (check_supported_cpu() == 0) {
+		*rc = -ENODEV;
+		return;
+	}
+	if (pending_bit_stuck()) {
+		printk(EFX "change pending bit set\n");
+		*rc = -EIO;
+		return;
+	}
+	if (query_current_values_with_pending_wait(perproc)) {
+		*rc = -EIO;
+		return;
+	}
+	fidvid_msr_init();
+}
+#endif
+
+static int __init powernowk8_init(void)
+{
+	int smprc[num_online_cpus()];
+	int rc;
+	int i;
+
+	printk(IFX VERSION " (%d cpus)\n", num_online_cpus());
+
+	if (check_supported_cpu() == 0)
+		return -ENODEV;
+	if (pending_bit_stuck()) {
+		printk(EFX "change pending bit set\n");
+		return -EIO;
+	}
+
+	procs = kmalloc(sizeof(u8 *) * num_online_cpus(), GFP_KERNEL);
+	if (!procs) {
+		printk(EFX "procs memory alloc failure\n");
+		return -ENOMEM;
+	}
+	memset(procs, 0, sizeof(u8 *) * num_online_cpus());
+	rc = find_acpi_table();
+	if (rc) {
+		cleanup_procs();
+		return rc;
+	}
+
+	for (i=0; i<num_online_cpus(); i++) {
+		if (procs[i]==0) {
+			printk(EFX "Error procs 0 for %d\n", i);
+			cleanup_procs();
+			return -ENOMEM;
+		}
+	}
+
+	if (query_current_values_with_pending_wait(procs[0])) {
+		cleanup_procs();
+		return -EIO;
+	}
+	fidvid_msr_init();
+        if (num_online_cpus() > 1) {
+		memset(smprc, 0, sizeof(smprc));
+		smp_call_function(smp_k8_init, &smprc, 0, 1);
+		for (i=0; i<num_online_cpus(); i++) {
+			if (smprc[i]) {
+				cleanup_procs();
+				return smprc[i];
+			}
+		}
+	}
+	for (i=0; i<num_online_cpus(); i++)
+		dprintk(DFX "at init%d : fid %x vid %x\n", i,
+			procs[i][PP_OFF_CFID], procs[i][PP_OFF_CVID] );
+
+	return cpufreq_register_driver(&cpufreq_amd64_driver);
+}
+
+static void __exit powernowk8_exit(void)
+{
+	int pollwait = num_online_cpus() == 1 ? 1 : 0;
+	u8 *perproc = procs[0];
+	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+        u32 maxidx = perproc[PP_OFF_NUMPS] - seenrst;
+	u16 rf = pst[maxidx].freq;
+	u16 minfreq = pst[perproc[PP_OFF_NUMPS]-1].freq;
+	u16 maxfreq = pst[maxidx].freq;
+
+	dprintk(IFX "powernowk8_exit, pollflg=%x\n", pollflg);
+
+	/* do not unload the driver until we are certain the poller is gone */
+	while (pollwait) {
+		down(&poll_sem);
+		if ((pollflg == POLLER_RUNNING) || (pollflg == POLLER_UNLOAD)) {
+			pollflg = POLLER_UNLOAD;
+		}
+		else {
+			pollflg = POLLER_DEAD;
+			pollwait = 0;
+		}
+		up(&poll_sem);
+		schedule();
+	}
+
+	/* need to be on a battery frequency when the module is unloaded */
+	pst += maxidx;
+	if (seenrst && (perproc[PP_OFF_CFID] > pst->fid )) {
+		if (POW_BAT == query_ac()) {
+			dprintk(DFX "unload emergency transition\n" );
+                        transition_frequency(perproc, &rf, &minfreq, &maxfreq);
+		}
+	}
+
+	cpufreq_unregister_driver(&cpufreq_amd64_driver);
+	cleanup_procs();
+}
+
+MODULE_AUTHOR("Paul Devriendt <paul.devriendt@amd.com>");
+MODULE_DESCRIPTION("AMD Athlon 64 and Opteron processor frequency driver.");
+MODULE_LICENSE("GPL");
+
+module_init(powernowk8_init);
+module_exit(powernowk8_exit);
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.h	2004-03-03 12:30:40.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.h	2004-03-03 12:38:17.000000000 +0100
@@ -0,0 +1,143 @@
+/*
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
+ *  Your use of this code is subject to the terms and conditions of the
+ *  GNU general public license version 2. See "../../../../../COPYING" or
+ *  http://www.gnu.org/licenses/gpl.html
+ */
+
+/* processor's cpuid instruction support */
+#define CPUID_PROCESSOR_SIGNATURE             1	/* function 1               */
+#define CPUID_XFAM_MOD               0x0ff00ff0	/* xtended fam, fam + model */
+#define ATHLON64_XFAM_MOD            0x00000f40	/* xtended fam, fam + model */
+#define OPTERON_XFAM_MOD             0x00000f50	/* xtended fam, fam + model */
+#define CPUID_GET_MAX_CAPABILITIES   0x80000000
+#define CPUID_FREQ_VOLT_CAPABILITIES 0x80000007
+#define P_STATE_TRANSITION_CAPABLE            6
+
+#define MSR_FIDVID_CTL      0xc0010041
+#define MSR_FIDVID_STAT     0xc0010042
+
+/* control MSR - low part */
+#define MSR_C_LO_INIT             0x00010000
+#define MSR_C_LO_NEW_VID          0x00001f00
+#define MSR_C_LO_NEW_FID          0x0000003f
+#define MSR_C_LO_VID_SHIFT        8
+
+/* control MSR - high part */
+#define MSR_C_HI_STP_GNT_TO       0x000fffff
+#define MSR_C_HI_STP_GNT_BENIGN   1
+
+/* status MSR - low part */
+#define MSR_S_LO_CHANGE_PENDING   0x80000000 /* cleared when completed */
+#define MSR_S_LO_MAX_RAMP_VID     0x1f000000
+#define MSR_S_LO_MAX_FID          0x003f0000
+#define MSR_S_LO_START_FID        0x00003f00
+#define MSR_S_LO_CURRENT_FID      0x0000003f
+
+/* status MSR - high part */
+#define MSR_S_HI_MAX_WORKING_VID  0x001f0000
+#define MSR_S_HI_START_VID        0x00001f00
+#define MSR_S_HI_CURRENT_VID      0x0000001f
+
+#define LO_FID_TABLE_TOP        6     /* valid fids exist in 2 tables */
+#define HI_FID_TABLE_BOTTOM     8
+#define LO_VCOFREQ_TABLE_TOP    1400  /* corresponding vco frequency values */
+#define HI_VCOFREQ_TABLE_BOTTOM 1600
+
+#define MIN_FREQ_RESOLUTION  200 /* fids jump by 2 matching freq jumps by 200 */
+#define FSTEP                  2
+#define KHZ                 1000
+
+#define MAX_FID 0x2a	/* Spec only gives FID values as far as 5 GHz */
+#define LEAST_VID 0x1e	/* Lowest (numerically highest) useful vid value */
+
+#define MIN_FREQ 800
+#define MAX_FREQ 5000
+
+#define INVALID_FID_MASK 0xc1
+#define INVALID_VID_MASK 0xe0
+
+#define STOP_GRANT_5NS    1 /* min memory access latency for voltage change   */
+#define MAXIMUM_VID_STEPS 1 /* Current cpus only allow a single step of 25mV  */
+#define VST_UNITS_20US   20 /* Voltage Stabalization Time is in units of 20us */
+
+#define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
+
+/* byte offsets into the perproc struct */
+#define PP_OFF_NUMPS  0   /* number of p-states      */
+#define PP_OFF_SHARE  1   /* index of shared control */
+#define PP_OFF_CVID   2   /* current voltage id      */
+#define PP_OFF_CFID   3   /* current frequency id    */
+#define PP_OFF_BYTES  4   /* size in bytes           */   
+
+struct pstate {    /* info on each performance state, per processor */
+	u16 freq;  /* frequency is in megahertz */
+	u8 fid;
+	u8 vid;
+	u8 irt;
+	u8 rvo;
+	u8 plllock;
+	u8 vidmvs;
+	u8 vstable;
+	u8 pad1;
+	u16 pad2;
+};
+
+/* Explanation of the perproc data structures:
+ * static u8 **procs; declared in the .c file is an array of pointers to u8.
+ * There is one such pointer for each cpu in the system.
+ * Each pointer points to 4 u8s (indexed by the PP_OFF constants above),
+ * followed by an array of struct pstate, where each processor may have
+ * a different number of entries in its array. I.e., processor 0 may have
+ * 3 pstates, processor 1 may have 5 pstates.
+ */
+
+struct proc_pss {  /* the acpi _PSS structure */
+	acpi_integer freq;
+	acpi_integer pow;
+	acpi_integer tlat;
+	acpi_integer blat;
+	acpi_integer cntl;
+	acpi_integer stat;
+};
+
+#define PSS_FMT_STR "NNNNNN"
+
+#define IRT_SHIFT      30
+#define RVO_SHIFT      28
+#define PLL_L_SHIFT    20
+#define MVS_SHIFT      18
+#define VST_SHIFT      11
+#define VID_SHIFT       6
+#define IRT_MASK        3
+#define RVO_MASK        3
+#define PLL_L_MASK   0x7f
+#define MVS_MASK        3
+#define VST_MASK     0x7f
+#define VID_MASK     0x1f
+#define FID_MASK     0x3f
+
+#define POW_AC  0  /* The power suppy states we care about - mains, battery,  */
+#define POW_BAT 1  /* or unknown, which presumably means that there is no     */
+#define POW_UNK 2  /* acpi support for the psr object, so there is no battery.*/
+
+#define POLLER_NOT_RUNNING 0  /* The state of the poller (which watches for   */
+#define POLLER_RUNNING     1  /* power transitions). It is only running if we */
+#define POLLER_UNLOAD      2  /* are on mains power, at a high frequency, and */
+#define POLLER_DEAD        3  /* if there are battery restrictions.           */
+
+#define PFX "powernow-k8: "
+#define DFX KERN_DEBUG PFX
+#define IFX KERN_INFO  PFX
+#define EFX KERN_ERR   PFX
+
+#ifdef DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0)
+#endif
+
+static void start_ac_poller(int frompoller);
+static int powernowk8_verify(struct cpufreq_policy *p);
+static int powernowk8_target(struct cpufreq_policy *p, unsigned t, unsigned r);
+static int __init powernowk8_cpu_init(struct cpufreq_policy *p);
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
