Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUCIVyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUCIVyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:54:24 -0500
Received: from gprs40-175.eurotel.cz ([160.218.40.175]:19682 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262236AbUCIVvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:51:42 -0500
Date: Tue, 9 Mar 2004 22:48:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: patches@x86-64.org, kernel list <linux-kernel@vger.kernel.org>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>, davej@redhat.com
Subject: powernow-k8 updates
Message-ID: <20040309214830.GA1240@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds powernow-k8-acpi driver, which likes on more machines than
powernow-k8, but depends on acpi. I'd like to get this into
2.6.5... Does it look okay?

Also if you have problems with your eMachines cpufreq, apply this and
switch to -acpi driver. It should fix it for you.
								Pavel


--- clean/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-02-05 01:53:54.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2004-03-03 23:07:26.000000000 +0100
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
 
--- clean/arch/i386/kernel/cpu/cpufreq/Makefile	2003-10-09 00:13:13.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/Makefile	2004-03-03 23:07:22.000000000 +0100
@@ -1,6 +1,7 @@
 obj-$(CONFIG_X86_POWERNOW_K6)	+= powernow-k6.o
 obj-$(CONFIG_X86_POWERNOW_K7)	+= powernow-k7.o
 obj-$(CONFIG_X86_POWERNOW_K8)	+= powernow-k8.o
+obj-$(CONFIG_X86_POWERNOW_K8_ACPI)	+= powernow-k8-acpi.o
 obj-$(CONFIG_X86_LONGHAUL)	+= longhaul.o
 obj-$(CONFIG_X86_P4_CLOCKMOD)	+= p4-clockmod.o
 obj-$(CONFIG_ELAN_CPUFREQ)	+= elanfreq.o
--- clean/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-03 12:30:35.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-06 00:31:44.000000000 +0100
@@ -0,0 +1,987 @@
+/*
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
+ *  Your use of this code is subject to the terms and conditions of the
+ *  GNU general public license version 2. See COPYING or
+ *  http://www.gnu.org/licenses/gpl.html
+ *
+ *  This is the ACPI version of the cpu frequency driver. There is a
+ *  less functional version of this driver that does not
+ *  use ACPI, and also does not support SMP.
+ *
+ *  Support : paul.devriendt@amd.com
+ *
+ *  Based on the powernow-k7.c module written by Dave Jones.
+ *  (c) 2003 Dave Jones <davej@codemonkey.org.uk> on behalf of SuSE Labs
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
+#define PFX "powernow-k8-acpi: "
+
+#undef DEBUG
+#define VERSION "Version 1.20.02a"
+#include "powernow-k8.h"
+
+/*
+ * Each processor may have
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
+#define POW_AC  0  /* The power supply states we care about - mains, battery, */
+#define POW_BAT 1  /* or unknown, which presumably means that there is no     */
+#define POW_UNK 2  /* acpi support for the psr object, so there is no battery.*/
+
+#define POLLER_NOT_RUNNING 0  /* The state of the poller (which watches for   */
+#define POLLER_RUNNING     1  /* power transitions). It is only running if we */
+#define POLLER_UNLOAD      2  /* are on mains power, at a high frequency, and */
+#define POLLER_DEAD        3  /* if there are battery restrictions.           */
+
+static void start_ac_poller(int frompoller);
+static int powernowk8_verify(struct cpufreq_policy *p);
+static int powernowk8_target(struct cpufreq_policy *p, unsigned t, unsigned r);
+static int __init powernowk8_cpu_init(struct cpufreq_policy *p);
+
+static struct cpu_power **procs;    /* per processor data structure     */
+static u32 rstps;                   /* pstates allowed restrictions     */
+static u32 seenrst;                 /* remember old bat restrictions    */
+static int pollflg;	            /* remember the state of the poller, protected by poll_sem */
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
+static int write_new_fid(struct cpu_power *perproc, u32 idx, u8 fid)
+{
+	u32 lo;
+	u32 hi;
+	struct pstate *pst;
+	u8 savevid = perproc->cvid;
+
+	if (idx >= perproc->numps) {
+		printk(EFX "idx overflow fid write\n");
+		return 1;
+	}
+	pst = &perproc->pst[idx];
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
+	if (savevid != perproc->cvid) {
+		printk(EFX "vid change on fid trans, old %x, new %x\n",
+		       savevid, perproc->cvid);
+		return 1;
+	}
+	if (perproc->cfid != fid) {
+		printk(EFX "fid trans failed, targ %x, new %x\n",
+		       fid, perproc->cfid);
+		return 1;
+	}
+	return 0;
+}
+
+static int decrease_vid_code_by_step(struct cpu_power *perproc, u32 idx, u8 reqvid, u8 step)
+{
+	struct pstate *pst;
+
+	if (idx >= perproc->numps) {
+		printk(EFX "idx overflow vid step\n");
+		return 1;
+	}
+	pst = &perproc->pst[idx];
+
+	if (step == 0)  /* BIOS error if this is the case, but continue */
+		step = 1;
+
+	if ((perproc->cvid - reqvid) > step)
+		reqvid = perproc->cvid - step;
+	if (write_new_vid(perproc, reqvid))
+		return 1;
+	count_off_vst(pst->vstable);
+	return 0;
+}
+
+static inline int core_voltage_pre_transition(struct cpu_power *perproc, u32 idx, u8 rvid)
+{
+	struct pstate *pst;
+	u8 rvosteps;
+	u8 savefid = perproc->cfid;
+
+	pst = &perproc->pst[idx];
+
+	rvosteps = pst->rvo;
+	dprintk(DFX "ph1 start%d, cfid 0x%x, cvid 0x%x, rvid 0x%x, rvo %x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid, rvid, pst->rvo);
+
+	while (perproc->cvid > rvid) {
+		dprintk(DFX "ph1 curr %x, req vid %x\n",
+			    perproc->cvid, rvid);
+		if (decrease_vid_code_by_step(perproc, idx, rvid, pst->vidmvs))
+			return 1;
+	}
+
+	while (rvosteps) {
+		if (perproc->cvid == 0) {
+			rvosteps = 0;
+		} else {
+			dprintk(DFX "ph1 changing vid for rvo, req 0x%x\n",
+				perproc->cvid - 1);
+			if (decrease_vid_code_by_step(perproc, idx,
+						perproc->cvid - 1, 1))
+				return 1;
+			rvosteps--;
+		}
+	}
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (savefid != perproc->cfid) {
+		printk(EFX "ph1 err, cfid changed %x\n", perproc->cfid);
+		return 1;
+	}
+	dprintk(DFX "ph1 done%d, cfid 0x%x, cvid 0x%x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid);
+	return 0;
+}
+
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
+	struct cpu_power *perproc;
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
+	i = sizeof(struct cpu_power) + (sizeof(struct pstate) * pstc);
+	perproc = kmalloc(i, GFP_KERNEL);
+	if (!perproc) {
+		printk(EFX "perproc memory alloc failure\n");
+		return -ENOMEM;
+	}
+	memset(perproc, 0, i);
+	pst = &perproc->pst[0];
+	perproc->numps = pstc;
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
+		if (pst[i].freq > MAX_FREQ) {
+			printk(EFX "frequency out of range %x, stopping extract\n",
+				pst[i].freq );
+			perproc->numps = i;
+			break;
+		}
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
+			pst = (&procs[i]->pst[0]);
+			for (j = 0; j < procs[i]->numps; j++)
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
+static int find_match(struct cpu_power *perproc, u16 *ptargfreq, u16 *pmin, u16 *pmax,
+			u8 *pfid, u8 *pvid, u32 *idx)
+{
+	u32 availpstates = perproc->numps;
+	u8 targfid = find_closest_fid(*ptargfreq);
+	u8 minfid = find_closest_fid(*pmin);
+	u8 maxfid = find_closest_fid(*pmax);
+	u32 maxidx = 0;
+	u32 minidx = availpstates - 1;
+	u32 targidx = 0xffffffff;
+	int i;
+	struct pstate *pst = &perproc->pst[0];
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
+transition_frequency(struct cpu_power *perproc, u16 *preq, u16 *pmin, u16 *pmax)
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
+	if ((perproc->cvid == vid) && (perproc->cfid == fid)) {
+		dprintk(DFX "targ matches curr (fid %x, vid %x)\n", fid, vid);
+		return 0;
+	}
+
+	if ((fid < HI_FID_TABLE_BOTTOM)
+	    && (perproc->cfid < HI_FID_TABLE_BOTTOM)) {
+		printk(EFX "ignoring change in lo freq table: %x to %x\n",
+		       perproc->cfid, fid);
+		return 1;
+	}
+
+	dprintk(DFX "cpu%d to fid %x vid %x\n", smp_processor_id(), fid, vid);
+
+	freqs.cpu = smp_processor_id();
+	freqs.old = freq_from_fid(perproc->cfid);
+	freqs.new = freq_from_fid(fid);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	down(&fidvid_sem);
+	res = transition_fid_vid(perproc, idx, fid, vid);
+	up(&fidvid_sem);
+
+	freqs.new = freq_from_fid(perproc->cfid);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return res;
+}
+
+static int need_poller(void)   /* if running at a freq only allowed for a/c */
+{
+	struct cpu_power *perproc = procs[0];
+	struct pstate *pst = &perproc->pst[0];
+        u32 maxidx;
+
+        if (num_online_cpus() > 1)
+		return 0;
+
+        process_ppc(0);
+	if (rstps > perproc->numps)
+		return 0;
+	maxidx = perproc->numps - rstps;
+	pst += maxidx;
+	if (rstps && (perproc->cfid > pst->fid ))
+		return 1;
+	return 0;
+}
+
+/* transition if needed, restart if needed */
+static void ac_poller(unsigned long x)  
+{
+	int pow;
+	struct cpu_power *perproc = procs[0];
+	struct pstate *pst = &perproc->pst[0];
+        u32 maxidx = perproc->numps - rstps;
+	u16 rf = pst[maxidx].freq;
+	u16 minfreq = pst[perproc->numps-1].freq;
+	u16 maxfreq = pst[maxidx].freq;
+
+	down(&poll_sem);
+	if (pollflg == POLLER_UNLOAD) {
+		pollflg = POLLER_DEAD;
+		up(&poll_sem);
+		return;
+	}
+        process_ppc(0);
+	if (rstps > perproc->numps) {
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
+	struct cpu_power *perproc;
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
+	checkfid = perproc->cfid;
+	checkvid = perproc->cvid;
+	if (query_current_values_with_pending_wait(perproc)) {
+		printk(EFX "drv targ fail: change pending bit set\n");
+		rc = -EIO;
+		goto targ_exit;
+	}
+	dprintk(DFX "targ%d: curr fid %x, vid %x\n", smp_processor_id(),
+		perproc->cfid, perproc->cvid);
+	if ((checkvid != perproc->cvid)
+	    || (checkfid != perproc->cfid)) {
+		printk(EFX "error - out of sync, fid %x %x, vid %x %x\n",
+		       checkfid, perproc->cfid, checkvid,
+		       perproc->cvid);
+	}
+
+	if (transition_frequency(perproc, &reqfreq, &minfreq, &maxfreq)) {
+		printk(EFX "transition frequency failed\n");
+		rc = -EIO;
+		goto targ_exit;
+	}
+
+	pol->cur = kfreq_from_fid(perproc->cfid);
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
+	struct cpu_power *perproc;
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
+	struct cpu_power *perproc = procs[smp_processor_id()];
+	struct pstate *pst = &perproc->pst[0];
+
+	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
+	pol->cpuinfo.transition_latency =             /* crude guess */
+		((pst[0].rvo + 8) * pst[0].vstable * VST_UNITS_20US)
+		+ (3 * (1 << pst[0].irt) * 10);
+
+	pol->cur = kfreq_from_fid(perproc->cfid);
+	dprintk(DFX "policy cfreq %d kHz\n", pol->cur);
+
+	/* min/max this cpu is capable of */
+	pol->cpuinfo.min_freq =kfreq_from_fid(pst[perproc->numps-1].fid);
+	pol->cpuinfo.max_freq = kfreq_from_fid(pst[0].fid);
+	pol->min = pol->cpuinfo.min_freq;
+	pol->max = pol->cpuinfo.max_freq;
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+static void smp_k8_init( void *retval )
+{
+	struct cpu_power *perproc = procs[smp_processor_id()];
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
+			procs[i]->cfid, procs[i]->cvid );
+
+	return cpufreq_register_driver(&cpufreq_amd64_driver);
+}
+
+static void __exit powernowk8_exit(void)
+{
+	int pollwait = num_online_cpus() == 1 ? 1 : 0;
+	struct cpu_power *perproc = procs[0];
+	struct pstate *pst = &perproc->pst[0];
+        u32 maxidx = perproc->numps - seenrst;
+	u16 rf = pst[maxidx].freq;
+	u16 minfreq = pst[perproc->numps-1].freq;
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
+	if (seenrst && (perproc->cfid > pst->fid )) {
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
--- clean/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-20 12:29:10.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-05 14:06:43.000000000 +0100
@@ -1,13 +1,15 @@
 /*
- *   (c) 2003 Advanced Micro Devices, Inc.
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
  *  Your use of this code is subject to the terms and conditions of the
- *  GNU general public license version 2. See "../../../COPYING" or
+ *  GNU general public license version 2. See "COPYING" or
  *  http://www.gnu.org/licenses/gpl.html
  *
  *  Support : paul.devriendt@amd.com
  *
  *  Based on the powernow-k7.c module written by Dave Jones.
- *  (C) 2003 Dave Jones <davej@codemonkey.ork.uk> on behalf of SuSE Labs
+ *  (C) 2003 Dave Jones <davej@codemonkey.org.uk> on behalf of SuSE Labs
+ *  (C) 2004 Dominik Brodowski <linux@brodo.de>
+ *  (C) 2004 Pavel Machek <pavel@suse.cz>
  *  Licensed under the terms of the GNU GPL License version 2.
  *  Based upon datasheets & sample CPUs kindly provided by AMD.
  *
@@ -24,6 +26,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <acpi/acpi_bus.h> 	/* For acpi_disabled */
 
 #include <asm/msr.h>
 #include <asm/io.h>
@@ -31,21 +34,53 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.00.08a"
+#define VERSION "version 1.00.13"
 #include "powernow-k8.h"
 
-#ifdef CONFIG_PREEMPT
-#warning this driver has not been tested on a preempt system
-#endif
+/*
+ * Version 1.4 of the PSB table. This table is constructed by BIOS and is
+ * to tell the OS's power management driver which VIDs and FIDs are
+ * supported by this particular processor. This information is obtained from
+ * the data sheets for each processor model by the system vendor and
+ * incorporated into the BIOS.
+ * If the data in the PSB / PST is wrong, then this driver will program the
+ * wrong values into hardware, which is very likely to lead to a crash.
+ */
+
+#define PSB_ID_STRING      "AMDK7PNOW!"
+#define PSB_ID_STRING_LEN  10
+
+#define PSB_VERSION_1_4  0x14
+
+struct psb_s {
+	u8 signature[10];
+	u8 tableversion;
+	u8 flags1;
+	u16 voltagestabilizationtime;
+	u8 flags2;
+	u8 numpst;
+	u32 cpuid;
+	u8 plllocktime;
+	u8 maxfid;
+	u8 maxvid;
+	u8 numpstates;
+};
+
+/* Pairs of fid/vid values are appended to the version 1.4 PSB table. */
+struct pst_s {
+	u8 fid;
+	u8 vid;
+};
 
 static u32 vstable;	/* voltage stabalization time, from PSB, units 20 us */
 static u32 plllock;	/* pll lock time, from PSB, units 1 us */
-static u32 numps;	/* number of p-states, from PSB */
 static u32 rvo;		/* ramp voltage offset, from PSB */
 static u32 irt;		/* isochronous relief time, from PSB */
 static u32 vidmvs;	/* usable value calculated from mvs, from PSB */
-static u32 currvid;	/* keep track of the current fid / vid */
-static u32 currfid;
+
+/* We have only one processor, but this way code can be shared */
+static struct cpu_power single_cpu_power;
+static struct cpu_power *perproc = &single_cpu_power;
 
 static struct cpufreq_frequency_table *powernow_table;
 
@@ -72,153 +107,41 @@
 static u32 batps;	/* limit on the number of p states when on battery */
 			/* - set by BIOS in the PSB/PST                    */
 
- /* Return a frequency in MHz, given an input fid */
-static u32 find_freq_from_fid(u32 fid)
-{
- 	return 800 + (fid * 100);
-}
-
-
-/* Return the vco fid for an input fid */
-static u32
-convert_fid_to_vco_fid(u32 fid)
-{
-	if (fid < HI_FID_TABLE_BOTTOM) {
-		return 8 + (2 * fid);
-	} else {
-		return fid;
-	}
-}
-
-/*
- * Return 1 if the pending bit is set. Unless we are actually just told the
- * processor to transition a state, seeing this bit set is really bad news.
- */
-static inline int
-pending_bit_stuck(void)
-{
-	u32 lo, hi;
-
-	rdmsr(MSR_FIDVID_STATUS, lo, hi);
-	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
-}
-
-/*
- * Update the global current fid / vid values from the status msr. Returns 1
- * on error.
- */
-static int
-query_current_values_with_pending_wait(void)
-{
-	u32 lo, hi;
-	u32 i = 0;
-
-	lo = MSR_S_LO_CHANGE_PENDING;
-	while (lo & MSR_S_LO_CHANGE_PENDING) {
-		if (i++ > 0x1000000) {
-			printk(KERN_ERR PFX "detected change pending stuck\n");
-			return 1;
-		}
-		rdmsr(MSR_FIDVID_STATUS, lo, hi);
-	}
-
-	currvid = hi & MSR_S_HI_CURRENT_VID;
-	currfid = lo & MSR_S_LO_CURRENT_FID;
-
-	return 0;
-}
-
-/* the isochronous relief time */
-static inline void
-count_off_irt(void)
-{
-	udelay((1 << irt) * 10);
-	return;
-}
-
-/* the voltage stabalization time */
-static inline void
-count_off_vst(void)
-{
-	udelay(vstable * VST_UNITS_20US);
-	return;
-}
-
 /* write the new fid value along with the other control fields to the msr */
 static int
-write_new_fid(u32 fid)
+write_new_fid(struct cpu_power *perproc, u32 idx, u8 fid)
 {
 	u32 lo;
-	u32 savevid = currvid;
+	u32 savevid = perproc->cvid;
 
-	if ((fid & INVALID_FID_MASK) || (currvid & INVALID_VID_MASK)) {
+	if ((fid & INVALID_FID_MASK) || (perproc->cvid & INVALID_VID_MASK)) {
 		printk(KERN_ERR PFX "internal error - overflow on fid write\n");
 		return 1;
 	}
 
-	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
+	lo = fid | (perproc->cvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
 
 	dprintk(KERN_DEBUG PFX "writing fid %x, lo %x, hi %x\n",
 		fid, lo, plllock * PLL_LOCK_CONVERSION);
 
 	wrmsr(MSR_FIDVID_CTL, lo, plllock * PLL_LOCK_CONVERSION);
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
-	count_off_irt();
+	count_off_irt(irt);
 
-	if (savevid != currvid) {
+	if (savevid != perproc->cvid) {
 		printk(KERN_ERR PFX
-		       "vid changed on fid transition, save %x, currvid %x\n",
-		       savevid, currvid);
+		       "vid changed on fid transition, save %x, perproc->cvid %x\n",
+		       savevid, perproc->cvid);
 		return 1;
 	}
 
-	if (fid != currfid) {
+	if (fid != perproc->cfid) {
 		printk(KERN_ERR PFX
-		       "fid transition failed, fid %x, currfid %x\n",
-		        fid, currfid);
-		return 1;
-	}
-
-	return 0;
-}
-
-/* Write a new vid to the hardware */
-static int
-write_new_vid(u32 vid)
-{
-	u32 lo;
-	u32 savefid = currfid;
-
-	if ((currfid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
-		printk(KERN_ERR PFX "internal error - overflow on vid write\n");
-		return 1;
-	}
-
-	lo = currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
-
-	dprintk(KERN_DEBUG PFX "writing vid %x, lo %x, hi %x\n",
-		vid, lo, STOP_GRANT_5NS);
-
-	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
-
-	if (query_current_values_with_pending_wait()) {
-		return 1;
-	}
-
-	if (savefid != currfid) {
-		printk(KERN_ERR PFX
-		       "fid changed on vid transition, save %x currfid %x\n",
-		       savefid, currfid);
-		return 1;
-	}
-
-	if (vid != currvid) {
-		printk(KERN_ERR PFX
-		       "vid transition failed, vid %x, currvid %x\n",
-		       vid, currvid);
+		       "fid transition failed, fid %x, perproc->cfid %x\n",
+		        fid, perproc->cfid);
 		return 1;
 	}
 
@@ -233,276 +156,72 @@
 static int
 decrease_vid_code_by_step(u32 reqvid, u32 step)
 {
-	if ((currvid - reqvid) > step)
-		reqvid = currvid - step;
+	if ((perproc->cvid - reqvid) > step)
+		reqvid = perproc->cvid - step;
 
-	if (write_new_vid(reqvid))
+	if (write_new_vid(perproc, reqvid))
 		return 1;
 
-	count_off_vst();
+	count_off_vst(vstable);
 
 	return 0;
 }
 
-/* Change the fid and vid, by the 3 phases. */
-static inline int
-transition_fid_vid(u32 reqfid, u32 reqvid)
-{
-	if (core_voltage_pre_transition(reqvid))
-		return 1;
-
-	if (core_frequency_transition(reqfid))
-		return 1;
-
-	if (core_voltage_post_transition(reqvid))
-		return 1;
-
-	if (query_current_values_with_pending_wait())
-		return 1;
-
-	if ((reqfid != currfid) || (reqvid != currvid)) {
-		printk(KERN_ERR PFX "failed: req 0x%x 0x%x, curr 0x%x 0x%x\n",
-		       reqfid, reqvid, currfid, currvid);
-		return 1;
-	}
-
-	dprintk(KERN_INFO PFX
-		"transitioned: new fid 0x%x, vid 0x%x\n", currfid, currvid);
-
-	return 0;
-}
 
 /*
  * Phase 1 - core voltage transition ... setup appropriate voltage for the
  * fid transition.
  */
 static inline int
-core_voltage_pre_transition(u32 reqvid)
+core_voltage_pre_transition(struct cpu_power *perproc, u32 idx, u8 reqvid)
 {
 	u32 rvosteps = rvo;
-	u32 savefid = currfid;
+	u32 savefid = perproc->cfid;
 
 	dprintk(KERN_DEBUG PFX
-		"ph1: start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo %x\n",
-		currfid, currvid, reqvid, rvo);
+		"ph1: start, perproc->cfid 0x%x, perproc->cvid 0x%x, reqvid 0x%x, rvo %x\n",
+		perproc->cfid, perproc->cvid, reqvid, rvo);
 
-	while (currvid > reqvid) {
+	while (perproc->cvid > reqvid) {
 		dprintk(KERN_DEBUG PFX "ph1: curr 0x%x, requesting vid 0x%x\n",
-			currvid, reqvid);
+			perproc->cvid, reqvid);
 		if (decrease_vid_code_by_step(reqvid, vidmvs))
 			return 1;
 	}
 
-	while (rvosteps > 0) {
-		if (currvid == 0) {
+	while (rvosteps) {
+		if (perproc->cvid == 0) {
 			rvosteps = 0;
 		} else {
 			dprintk(KERN_DEBUG PFX
 				"ph1: changing vid for rvo, requesting 0x%x\n",
-				currvid - 1);
-			if (decrease_vid_code_by_step(currvid - 1, 1))
+				perproc->cvid - 1);
+			if (decrease_vid_code_by_step(perproc->cvid - 1, 1))
 				return 1;
 			rvosteps--;
 		}
 	}
 
-	if (query_current_values_with_pending_wait())
-		return 1;
-
-	if (savefid != currfid) {
-		printk(KERN_ERR PFX "ph1 err, currfid changed 0x%x\n", currfid);
-		return 1;
-	}
-
-	dprintk(KERN_DEBUG PFX "ph1 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
-
-	return 0;
-}
-
-/* Phase 2 - core frequency transition */
-static inline int
-core_frequency_transition(u32 reqfid)
-{
-	u32 vcoreqfid;
-	u32 vcocurrfid;
-	u32 vcofiddiff;
-	u32 savevid = currvid;
-
-	if ((reqfid < HI_FID_TABLE_BOTTOM) && (currfid < HI_FID_TABLE_BOTTOM)) {
-		printk(KERN_ERR PFX "ph2 illegal lo-lo transition 0x%x 0x%x\n",
-		       reqfid, currfid);
-		return 1;
-	}
-
-	if (currfid == reqfid) {
-		printk(KERN_ERR PFX "ph2 null fid transition 0x%x\n", currfid);
-		return 0;
-	}
-
-	dprintk(KERN_DEBUG PFX
-		"ph2 starting, currfid 0x%x, currvid 0x%x, reqfid 0x%x\n",
-		currfid, currvid, reqfid);
-
-	vcoreqfid = convert_fid_to_vco_fid(reqfid);
-	vcocurrfid = convert_fid_to_vco_fid(currfid);
-	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
-	    : vcoreqfid - vcocurrfid;
-
-	while (vcofiddiff > 2) {
-		if (reqfid > currfid) {
-			if (currfid > LO_FID_TABLE_TOP) {
-				if (write_new_fid(currfid + 2)) {
-					return 1;
-				}
-			} else {
-				if (write_new_fid
-				    (2 + convert_fid_to_vco_fid(currfid))) {
-					return 1;
-				}
-			}
-		} else {
-			if (write_new_fid(currfid - 2))
-				return 1;
-		}
-
-		vcocurrfid = convert_fid_to_vco_fid(currfid);
-		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
-		    : vcoreqfid - vcocurrfid;
-	}
-
-	if (write_new_fid(reqfid))
-		return 1;
-
-	if (query_current_values_with_pending_wait())
-		return 1;
-
-	if (currfid != reqfid) {
-		printk(KERN_ERR PFX
-		       "ph2 mismatch, failed fid transition, curr %x, req %x\n",
-		       currfid, reqfid);
+	if (query_current_values_with_pending_wait(perproc))
 		return 1;
-	}
 
-	if (savevid != currvid) {
-		printk(KERN_ERR PFX
-		       "ph2 vid changed, save %x, curr %x\n", savevid,
-		       currvid);
+	if (savefid != perproc->cfid) {
+		printk(KERN_ERR PFX "ph1 err, perproc->cfid changed 0x%x\n", perproc->cfid);
 		return 1;
 	}
 
-	dprintk(KERN_DEBUG PFX "ph2 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
+	dprintk(KERN_DEBUG PFX "ph1 complete, perproc->cfid 0x%x, perproc->cvid 0x%x\n",
+		perproc->cfid, perproc->cvid);
 
 	return 0;
 }
 
-/* Phase 3 - core voltage transition flow ... jump to the final vid. */
-static inline int
-core_voltage_post_transition(u32 reqvid)
-{
-	u32 savefid = currfid;
-	u32 savereqvid = reqvid;
-
-	dprintk(KERN_DEBUG PFX "ph3 starting, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
-
-	if (reqvid != currvid) {
-		if (write_new_vid(reqvid))
-			return 1;
-
-		if (savefid != currfid) {
-			printk(KERN_ERR PFX
-			       "ph3: bad fid change, save %x, curr %x\n",
-			       savefid, currfid);
-			return 1;
-		}
-
-		if (currvid != reqvid) {
-			printk(KERN_ERR PFX
-			       "ph3: failed vid transition\n, req %x, curr %x",
-			       reqvid, currvid);
-			return 1;
-		}
-	}
-
-	if (query_current_values_with_pending_wait())
-		return 1;
-
-	if (savereqvid != currvid) {
-		dprintk(KERN_ERR PFX "ph3 failed, currvid 0x%x\n", currvid);
-		return 1;
-	}
-
-	if (savefid != currfid) {
-		dprintk(KERN_ERR PFX "ph3 failed, currfid changed 0x%x\n",
-			currfid);
-		return 1;
-	}
-
-	dprintk(KERN_DEBUG PFX "ph3 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
-
-	return 0;
-}
-
-static inline int
-check_supported_cpu(void)
-{
-	struct cpuinfo_x86 *c = cpu_data;
-	u32 eax, ebx, ecx, edx;
-
-	if (num_online_cpus() != 1) {
-		printk(KERN_INFO PFX "multiprocessor systems not supported\n");
-		return 0;
-	}
-
-	if (c->x86_vendor != X86_VENDOR_AMD) {
-#ifdef MODULE
-		printk(KERN_INFO PFX "Not an AMD processor\n");
-#endif
-		return 0;
-	}
-
-	eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
-	if ((eax & CPUID_XFAM_MOD) == ATHLON64_XFAM_MOD) {
-		dprintk(KERN_DEBUG PFX "AMD Althon 64 Processor found\n");
-		if ((eax & CPUID_F1_STEP) < ATHLON64_REV_C0) {
-			printk(KERN_INFO PFX "Revision C0 or better "
-			       "AMD Athlon 64 processor required\n");
-			return 0;
-		}
-	} else if ((eax & CPUID_XFAM_MOD) == OPTERON_XFAM_MOD) {
-		dprintk(KERN_DEBUG PFX "AMD Opteron Processor found\n");
-	} else {
-		printk(KERN_INFO PFX
-		       "AMD Athlon 64 or AMD Opteron processor required\n");
-		return 0;
-	}
-
-	eax = cpuid_eax(CPUID_GET_MAX_CAPABILITIES);
-	if (eax < CPUID_FREQ_VOLT_CAPABILITIES) {
-		printk(KERN_INFO PFX
-		       "No frequency change capabilities detected\n");
-		return 0;
-	}
-
-	cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
-	if ((edx & P_STATE_TRANSITION_CAPABLE) != P_STATE_TRANSITION_CAPABLE) {
-		printk(KERN_INFO PFX "Power state transitions not supported\n");
-		return 0;
-	}
-
-	printk(KERN_INFO PFX "Found AMD64 processor supporting PowerNow (" VERSION ")\n");
-	return 1;
-}
-
 static int check_pst_table(struct pst_s *pst, u8 maxvid)
 {
 	unsigned int j;
 	u8 lastfid = 0xFF;
 
-	for (j = 0; j < numps; j++) {
+	for (j = 0; j < perproc->numps; j++) {
 		if (pst[j].vid > LEAST_VID) {
 			printk(KERN_ERR PFX "vid %d invalid : 0x%x\n", j, pst[j].vid);
 			return -EINVAL;
@@ -521,7 +240,8 @@
 		}
 		if ((pst[j].fid > MAX_FID)
 		    || (pst[j].fid & 1)
-		    || (pst[j].fid < HI_FID_TABLE_BOTTOM)){
+		    || (j && (pst[j].fid < HI_FID_TABLE_BOTTOM))) {
+			/* Only first fid is allowed to be in "low" range */
 			printk(KERN_ERR PFX "fid %d invalid : 0x%x\n", j, pst[j].fid);
 			return -EINVAL;
 		}
@@ -586,9 +306,9 @@
 		printk(", isochronous relief time: %d", irt);
 		printk(", maximum voltage step: %d\n", mvs);
 
-		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
+		dprintk(KERN_DEBUG PFX "perproc->numpst: 0x%x\n", psb->perproc->numpst);
 		if (psb->numpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
+			printk(KERN_ERR BFX "perproc->numpst must be 1\n");
 			return -ENODEV;
 		}
 
@@ -599,28 +319,28 @@
 
 		maxvid = psb->maxvid;
 		printk("maxfid 0x%x (%d MHz), maxvid 0x%x\n", 
-		       psb->maxfid, find_freq_from_fid(psb->maxfid), maxvid);
+		       psb->maxfid, freq_from_fid(psb->maxfid), maxvid);
 
-		numps = psb->numpstates;
-		if (numps < 2) {
+		perproc->numps = psb->numpstates;
+		if (perproc->numps < 2) {
 			printk(KERN_ERR BFX "no p states to transition\n");
 			return -ENODEV;
 		}
 
 		if (batps == 0) {
-			batps = numps;
-		} else if (batps > numps) {
-			printk(KERN_ERR BFX "batterypstates > numpstates\n");
-			batps = numps;
+			batps = perproc->numps;
+		} else if (batps > perproc->numps) {
+			printk(KERN_ERR BFX "batterypstates > perproc->numpstates\n");
+			batps = perproc->numps;
 		} else {
 			printk(KERN_ERR PFX
 			       "Restricting operation to %d p-states\n", batps);
 			printk(KERN_ERR PFX
-			       "Check for an updated driver to access all "
-			       "%d p-states\n", numps);
+			       "Use the ACPI driver to access all %d p-states\n",
+			       perproc->numps);
 		}
 
-		if (numps <= 1) {
+		if (perproc->numps <= 1) {
 			printk(KERN_ERR PFX "only 1 p-state to transition\n");
 			return -ENODEV;
 		}
@@ -629,35 +349,44 @@
 		if (check_pst_table(pst, maxvid))
 			return -EINVAL;
 
-		powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) * (numps + 1)), GFP_KERNEL);
+		powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) * (perproc->numps + 1)), GFP_KERNEL);
 		if (!powernow_table) {
 			printk(KERN_ERR PFX "powernow_table memory alloc failure\n");
 			return -ENOMEM;
 		}
 
-		for (j = 0; j < numps; j++) {
-			printk(KERN_INFO PFX "   %d : fid 0x%x (%d MHz), vid 0x%x\n", j,
-			       pst[j].fid, find_freq_from_fid(pst[j].fid), pst[j].vid);
+		for (j = 0; j < psb->numpstates; j++) {
 			powernow_table[j].index = pst[j].fid; /* lower 8 bits */
 			powernow_table[j].index |= (pst[j].vid << 8); /* upper 8 bits */
-			powernow_table[j].frequency = find_freq_from_fid(pst[j].fid);
 		}
-		powernow_table[numps].frequency = CPUFREQ_TABLE_END;
-		powernow_table[numps].index = 0;
 
-		if (query_current_values_with_pending_wait()) {
+		/* If you want to override your frequency tables, this
+		   is right place. */
+
+		for (j = 0; j < perproc->numps; j++) {
+			powernow_table[j].frequency = freq_from_fid(powernow_table[j].index & 0xff)*1000;
+			printk(KERN_INFO PFX "   %d : fid 0x%x (%d MHz), vid 0x%x\n", j,
+			       powernow_table[j].index & 0xff,
+			       powernow_table[j].frequency/1000,
+			       powernow_table[j].index >> 8);
+		}
+
+		powernow_table[perproc->numps].frequency = CPUFREQ_TABLE_END;
+		powernow_table[perproc->numps].index = 0;
+
+		if (query_current_values_with_pending_wait(perproc)) {
 			kfree(powernow_table);
 			return -EIO;
 		}
 
-		printk(KERN_INFO PFX "currfid 0x%x (%d MHz), currvid 0x%x\n",
-		       currfid, find_freq_from_fid(currfid), currvid);
+		printk(KERN_INFO PFX "perproc->cfid 0x%x (%d MHz), perproc->cvid 0x%x\n",
+		       perproc->cfid, freq_from_fid(perproc->cfid), perproc->cvid);
 
-		for (j = 0; j < numps; j++)
-			if ((pst[j].fid==currfid) && (pst[j].vid==currvid))
+		for (j = 0; j < perproc->numps; j++)
+			if ((pst[j].fid==perproc->cfid) && (pst[j].vid==perproc->cvid))
 				return 0;
 
-		printk(KERN_ERR BFX "currfid/vid do not match PST, ignoring\n");
+		printk(KERN_ERR BFX "perproc->cfid/vid do not match PST, ignoring\n");
 		return 0;
 	}
 
@@ -685,20 +414,20 @@
 	dprintk(KERN_DEBUG PFX "table matched fid 0x%x, giving vid 0x%x\n",
 		fid, vid);
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
-	if ((currvid == vid) && (currfid == fid)) {
+	if ((perproc->cvid == vid) && (perproc->cfid == fid)) {
 		dprintk(KERN_DEBUG PFX
 			"target matches current values (fid 0x%x, vid 0x%x)\n",
 			fid, vid);
 		return 0;
 	}
 
-	if ((fid < HI_FID_TABLE_BOTTOM) && (currfid < HI_FID_TABLE_BOTTOM)) {
+	if ((fid < HI_FID_TABLE_BOTTOM) && (perproc->cfid < HI_FID_TABLE_BOTTOM)) {
 		printk(KERN_ERR PFX
 		       "ignoring illegal change in lo freq table-%x to %x\n",
-		       currfid, fid);
+		       perproc->cfid, fid);
 		return 1;
 	}
 
@@ -706,13 +435,13 @@
 
 	freqs.cpu = 0;	/* only true because SMP not supported */
 
-	freqs.old = find_freq_from_fid(currfid);
-	freqs.new = find_freq_from_fid(fid);
+	freqs.old = freq_from_fid(perproc->cfid);
+	freqs.new = freq_from_fid(fid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
-	res = transition_fid_vid(fid, vid);
+	res = transition_fid_vid(perproc, 0, fid, vid);
 
-	freqs.new = find_freq_from_fid(currfid);
+	freqs.new = freq_from_fid(perproc->cfid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return res;
@@ -722,8 +451,8 @@
 static int
 powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
 {
-	u32 checkfid = currfid;
-	u32 checkvid = currvid;
+	u32 checkfid = perproc->cfid;
+	u32 checkvid = perproc->cvid;
 	unsigned int newstate;
 
 	if (pending_bit_stuck()) {
@@ -734,16 +463,16 @@
 	dprintk(KERN_DEBUG PFX "targ: %d kHz, min %d, max %d, relation %d\n",
 		targfreq, pol->min, pol->max, relation);
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(perproc))
 		return -EIO;
 
 	dprintk(KERN_DEBUG PFX "targ: curr fid 0x%x, vid 0x%x\n",
-		currfid, currvid);
+		perproc->cfid, perproc->cvid);
 
-	if ((checkvid != currvid) || (checkfid != currfid)) {
+	if ((checkvid != perproc->cvid) || (checkfid != perproc->cfid)) {
 		printk(KERN_ERR PFX
 		       "error - out of sync, fid 0x%x 0x%x, vid 0x%x 0x%x\n",
-		       checkfid, currfid, checkvid, currvid);
+		       checkfid, perproc->cfid, checkvid, perproc->cvid);
 	}
 
 	if (cpufreq_frequency_table_target(pol, powernow_table, targfreq, relation, &newstate))
@@ -755,7 +484,7 @@
 		return 1;
 	}
 
-	pol->cur = 1000 * find_freq_from_fid(currfid);
+	pol->cur = 1000 * freq_from_fid(perproc->cfid);
 
 	return 0;
 }
@@ -788,10 +517,10 @@
 	pol->cpuinfo.transition_latency = (((rvo + 8) * vstable * VST_UNITS_20US)
 	    + (3 * (1 << irt) * 10)) * 1000;
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(perproc))
 		return -EIO;
 
-	pol->cur = 1000 * find_freq_from_fid(currfid);
+	pol->cur = 1000 * freq_from_fid(perproc->cfid);
 	dprintk(KERN_DEBUG PFX "policy current frequency %d kHz\n", pol->cur);
 
 	/* min/max the cpu is capable of */
@@ -802,7 +531,7 @@
 	}
 
 	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
-	       currfid, currvid);
+	       perproc->cfid, perproc->cvid);
 
 	return 0;
 }
@@ -834,6 +563,18 @@
 {
 	int rc;
 
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
+	if (!acpi_disabled) {
+		printk(KERN_INFO PFX "Turning off powernow-k8, powernow-k8-acpi will take over\n");
+		return -EINVAL;
+	}
+#endif
+
+	if (num_online_cpus() != 1) {
+		printk(KERN_INFO PFX "multiprocessor systems not supported\n");
+		return -ENODEV;
+	}
+
 	if (check_supported_cpu() == 0)
 		return -ENODEV;
 
Only in linux/arch/i386/kernel/cpu/cpufreq: powernow-k8.c-new
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' clean/arch/i386/kernel/cpu/cpufreq/powernow-k8.h linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h
--- clean/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-02-20 12:29:10.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-05 14:02:51.000000000 +0100
@@ -1,122 +1,374 @@
 /*
- *   (c) 2003 Advanced Micro Devices, Inc.
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
  *  Your use of this code is subject to the terms and conditions of the
- *  GNU general public license version 2. See "../../../COPYING" or
+ *  GNU general public license version 2. See "COPYING" or
  *  http://www.gnu.org/licenses/gpl.html
  */
 
 /* processor's cpuid instruction support */
 #define CPUID_PROCESSOR_SIGNATURE             1	/* function 1               */
-#define CPUID_F1_FAM                 0x00000f00	/* family mask              */
-#define CPUID_F1_XFAM                0x0ff00000	/* extended family mask     */
-#define CPUID_F1_MOD                 0x000000f0	/* model mask               */
-#define CPUID_F1_STEP                0x0000000f	/* stepping level mask      */
 #define CPUID_XFAM_MOD               0x0ff00ff0	/* xtended fam, fam + model */
 #define ATHLON64_XFAM_MOD            0x00000f40	/* xtended fam, fam + model */
 #define OPTERON_XFAM_MOD             0x00000f50	/* xtended fam, fam + model */
-#define ATHLON64_REV_C0                       8
 #define CPUID_GET_MAX_CAPABILITIES   0x80000000
 #define CPUID_FREQ_VOLT_CAPABILITIES 0x80000007
 #define P_STATE_TRANSITION_CAPABLE            6
 
-/* Model Specific Registers for p-state transitions. MSRs are 64-bit. For     */
-/* writes (wrmsr - opcode 0f 30), the register number is placed in ecx, and   */
-/* the value to write is placed in edx:eax. For reads (rdmsr - opcode 0f 32), */
-/* the register number is placed in ecx, and the data is returned in edx:eax. */
-
 #define MSR_FIDVID_CTL      0xc0010041
-#define MSR_FIDVID_STATUS   0xc0010042
+#define MSR_FIDVID_STAT     0xc0010042
 
-/* Field definitions within the FID VID Low Control MSR : */
-#define MSR_C_LO_INIT_FID_VID     0x00010000
+/* control MSR - low part */
+#define MSR_C_LO_INIT             0x00010000
 #define MSR_C_LO_NEW_VID          0x00001f00
-#define MSR_C_LO_NEW_FID          0x0000002f
+#define MSR_C_LO_NEW_FID          0x0000003f
 #define MSR_C_LO_VID_SHIFT        8
 
-/* Field definitions within the FID VID High Control MSR : */
+/* control MSR - high part */
 #define MSR_C_HI_STP_GNT_TO       0x000fffff
+#define MSR_C_HI_STP_GNT_BENIGN   1
 
-/* Field definitions within the FID VID Low Status MSR : */
-#define MSR_S_LO_CHANGE_PENDING   0x80000000	/* cleared when completed */
+/* status MSR - low part */
+#define MSR_S_LO_CHANGE_PENDING   0x80000000   /* cleared when completed */
 #define MSR_S_LO_MAX_RAMP_VID     0x1f000000
 #define MSR_S_LO_MAX_FID          0x003f0000
 #define MSR_S_LO_START_FID        0x00003f00
 #define MSR_S_LO_CURRENT_FID      0x0000003f
 
-/* Field definitions within the FID VID High Status MSR : */
+/* status MSR - high part */
 #define MSR_S_HI_MAX_WORKING_VID  0x001f0000
 #define MSR_S_HI_START_VID        0x00001f00
 #define MSR_S_HI_CURRENT_VID      0x0000001f
 
 /* fids (frequency identifiers) are arranged in 2 tables - lo and hi */
-#define LO_FID_TABLE_TOP     6
-#define HI_FID_TABLE_BOTTOM  8
-
-#define LO_VCOFREQ_TABLE_TOP    1400	/* corresponding vco frequency values */
+#define LO_FID_TABLE_TOP        6
+#define HI_FID_TABLE_BOTTOM     8
+#define LO_VCOFREQ_TABLE_TOP    1400  /* corresponding vco frequency values */
 #define HI_VCOFREQ_TABLE_BOTTOM 1600
 
 #define MIN_FREQ_RESOLUTION  200 /* fids jump by 2 matching freq jumps by 200 */
+#define FSTEP                  2
+#define KHZ                 1000
 
 #define MAX_FID 0x2a	/* Spec only gives FID values as far as 5 GHz */
-
 #define LEAST_VID 0x1e	/* Lowest (numerically highest) useful vid value */
 
 #define MIN_FREQ 800	/* Min and max freqs, per spec */
 #define MAX_FREQ 5000
 
 #define INVALID_FID_MASK 0xffffffc1  /* not a valid fid if these bits are set */
-
 #define INVALID_VID_MASK 0xffffffe0  /* not a valid vid if these bits are set */
 
-#define STOP_GRANT_5NS 1 /* min poss memory access latency for voltage change */
+
+#define STOP_GRANT_5NS    1 /* min memory access latency for voltage change   */
+#define MAXIMUM_VID_STEPS 1 /* Current cpus only allow a single step of 25mV  */
+#define VST_UNITS_20US   20 /* Voltage Stabilization Time is in units of 20us */
 
 #define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
 
-#define MAXIMUM_VID_STEPS 1  /* Current cpus only allow a single step of 25mV */
+#ifdef DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0)
+#endif
 
-#define VST_UNITS_20US 20   /* Voltage Stabalization Time is in units of 20us */
+#define DFX KERN_DEBUG PFX
+#define IFX KERN_INFO  PFX
+#define EFX KERN_ERR   PFX
+
+/* Return a frequency in MHz, given an input fid */
+static inline u32 freq_from_fid(u8 fid)
+{
+ 	return 800 + (fid * 100);
+}
+
+/* Return the vco fid for an input fid */
+static inline u32 convert_fid_to_vfid(u8 fid)
+{
+	if (fid < HI_FID_TABLE_BOTTOM) {
+		return 8 + (2 * fid);
+	} else {
+		return fid;
+	}
+}
 
 /*
-Version 1.4 of the PSB table. This table is constructed by BIOS and is
-to tell the OS's power management driver which VIDs and FIDs are
-supported by this particular processor. This information is obtained from
-the data sheets for each processor model by the system vendor and
-incorporated into the BIOS.
-If the data in the PSB / PST is wrong, then this driver will program the
-wrong values into hardware, which is very likely to lead to a crash.
-*/
-
-#define PSB_ID_STRING      "AMDK7PNOW!"
-#define PSB_ID_STRING_LEN  10
-
-#define PSB_VERSION_1_4  0x14
-
-struct psb_s {
-	u8 signature[10];
-	u8 tableversion;
-	u8 flags1;
-	u16 voltagestabilizationtime;
-	u8 flags2;
-	u8 numpst;
-	u32 cpuid;
-	u8 plllocktime;
-	u8 maxfid;
-	u8 maxvid;
-	u8 numpstates;
-};
+ * Return 1 if the pending bit is set. Unless we are actually just told the
+ * processor to transition a state, seeing this bit set is really bad news.
+ */
+static inline int
+pending_bit_stuck(void)
+{
+	u32 lo, hi;
+
+	rdmsr(MSR_FIDVID_STAT, lo, hi);
+	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
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
+static inline int
+check_supported_cpu(void)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	u32 eax, ebx, ecx, edx;
+
+	if (c->x86_vendor != X86_VENDOR_AMD) {
+#ifdef MODULE
+		printk(KERN_INFO PFX "Not an AMD processor\n");
+#endif
+		return 0;
+	}
+
+	eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
+	if ((eax & CPUID_XFAM_MOD) == ATHLON64_XFAM_MOD) {
+		dprintk(KERN_DEBUG PFX "AMD Althon 64 Processor found\n");
+	} else if ((eax & CPUID_XFAM_MOD) == OPTERON_XFAM_MOD) {
+		dprintk(KERN_DEBUG PFX "AMD Opteron Processor found\n");
+	} else {
+		printk(KERN_INFO PFX
+		       "AMD Athlon 64 or AMD Opteron processor required\n");
+		return 0;
+	}
+
+	eax = cpuid_eax(CPUID_GET_MAX_CAPABILITIES);
+	if (eax < CPUID_FREQ_VOLT_CAPABILITIES) {
+		printk(KERN_INFO PFX
+		       "No frequency change capabilities detected\n");
+		return 0;
+	}
+
+	cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
+	if ((edx & P_STATE_TRANSITION_CAPABLE) != P_STATE_TRANSITION_CAPABLE) {
+		printk(KERN_INFO PFX "Power state transitions not supported\n");
+		return 0;
+	}
+
+	printk(KERN_INFO PFX "Found AMD64 processor (" VERSION ")\n");
+	return 1;
+}
 
-/* Pairs of fid/vid values are appended to the version 1.4 PSB table. */
-struct pst_s {
+struct pstate {    /* info on each performance state, per processor */
+	u16 freq;  /* frequency is in megahertz */
 	u8 fid;
 	u8 vid;
+	u8 irt;
+	u8 rvo;
+	u8 plllock;
+	u8 vidmvs;
+	u8 vstable;
+	u8 pad1;
+	u16 pad2;
 };
 
-#ifdef DEBUG
-#define dprintk(msg...) printk(msg)
-#else
-#define dprintk(msg...) do { } while(0)
-#endif
+struct cpu_power {
+	int numps;
+	int cvid;
+	int cfid;
+	struct pstate pst[0];
+};
+
+static int write_new_fid(struct cpu_power *perproc, u32 idx, u8 fid);
+static inline int core_voltage_pre_transition(struct cpu_power *perproc, u32 idx, u8 rvid);
 
-static inline int core_voltage_pre_transition(u32 reqvid);
-static inline int core_voltage_post_transition(u32 reqvid);
-static inline int core_frequency_transition(u32 reqfid);
+/*
+ * Update the global current fid / vid values from the status msr. Returns 1
+ * on error.
+ */
+static int query_current_values_with_pending_wait(struct cpu_power *perproc)
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
+	perproc->cvid = hi & MSR_S_HI_CURRENT_VID;
+	perproc->cfid = lo & MSR_S_LO_CURRENT_FID;
+	return 0;
+}
+
+/* Write a new vid to the hardware */
+static int write_new_vid(struct cpu_power *perproc, u8 vid)
+{
+	u32 lo;
+	u8 savefid = perproc->cfid;
+
+	if ((savefid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
+		printk(EFX "overflow on vid write\n");
+		return 1;
+	}
+
+	lo = perproc->cfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
+	dprintk(DFX "cpu%d, writing vid %x, lo %x, hi %x\n",
+		smp_processor_id(), vid, lo, STOP_GRANT_5NS);
+	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (savefid != perproc->cfid) {
+		printk(EFX "fid change on vid trans, old %x new %x\n",
+		       savefid, perproc->cfid);
+		return 1;
+	}
+	if (vid != perproc->cvid) {
+		printk(EFX "vid trans failed, vid %x, cvid %x\n",
+		       vid, perproc->cfid);
+		return 1;
+	}
+	return 0;
+}
+
+/* Phase 2 */
+static inline int core_frequency_transition(struct cpu_power *perproc, u32 idx, u8 reqfid)
+{
+	u8 vcoreqfid;
+	u8 vcocurrfid;
+	u8 vcofiddiff;
+	u8 savevid = perproc->cvid;
+
+	if ((reqfid < HI_FID_TABLE_BOTTOM)
+	    && (perproc->cfid < HI_FID_TABLE_BOTTOM)) {
+		printk(EFX "ph2 illegal lo-lo transition %x %x\n",
+		       reqfid, perproc->cfid);
+		return 1;
+	}
+
+	if (perproc->cfid == reqfid) {
+		printk(EFX "ph2 null fid transition %x\n", reqfid );
+		return 0;
+	}
+
+	dprintk(DFX "ph2 start%d, cfid %x, cvid %x, rfid %x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid, reqfid);
+
+	vcoreqfid = convert_fid_to_vfid(reqfid);
+	vcocurrfid = convert_fid_to_vfid(perproc->cfid);
+	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
+						: vcoreqfid - vcocurrfid;
+
+	while (vcofiddiff > FSTEP) {
+		if (reqfid > perproc->cfid) {
+			if (perproc->cfid > LO_FID_TABLE_TOP) {
+				if (write_new_fid(perproc, idx,
+						  perproc->cfid + FSTEP))
+					return 1;
+			} else {
+				if (write_new_fid(perproc, idx, FSTEP +
+				     convert_fid_to_vfid(perproc->cfid)))
+					return 1;
+			}
+		} else {
+			if (write_new_fid(perproc, idx,
+					  perproc->cfid-FSTEP))
+				return 1;
+		}
+
+		vcocurrfid = convert_fid_to_vfid(perproc->cfid);
+		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
+						    : vcoreqfid - vcocurrfid;
+	}
+	if (write_new_fid(perproc, idx, reqfid))
+		return 1;
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (perproc->cfid != reqfid) {
+		printk(EFX "ph2 mismatch, failed transn, curr %x, req %x\n",
+		       perproc->cfid, reqfid);
+		return 1;
+	}
+
+	if (savevid != perproc->cvid) {
+		printk(EFX "ph2 vid changed, save %x, curr %x\n", savevid,
+		       perproc->cvid);
+		return 1;
+	}
+
+	dprintk(DFX "ph2 complete%d, currfid 0x%x, currvid 0x%x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid);
+	return 0;
+}
+
+/* Phase 3 - core voltage transition flow ... jump to the final vid. */
+static inline int core_voltage_post_transition(struct cpu_power *perproc, u32 idx, u8 reqvid)
+{
+	u8 savefid = perproc->cfid;
+	u8 savereqvid = reqvid;
+
+	dprintk(DFX "ph3 starting%d, cfid 0x%x, cvid 0x%x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid);
+
+	if (reqvid != perproc->cvid) {
+		if (write_new_vid(perproc, reqvid))
+			return 1;
+
+		if (savefid != perproc->cfid) {
+			printk(EFX "ph3: bad fid change, save %x, curr %x\n",
+			       savefid, perproc->cfid);
+			return 1;
+		}
+
+		if (perproc->cvid != reqvid) {
+			printk(EFX "ph3: failed vid trans\n, req %x, curr %x",
+			       reqvid, perproc->cvid);
+			return 1;
+		}
+	}
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+
+	if (savereqvid != perproc->cvid) {
+		dprintk(EFX "ph3 failed, currvid 0x%x\n", perproc->cvid);
+		return 1;
+	}
+
+	if (savefid != perproc->cfid) {
+		dprintk(EFX "ph3 failed, currfid changed 0x%x\n",
+			perproc->cfid);
+		return 1;
+	}
+
+	dprintk(DFX "ph3 done%d, cfid 0x%x, cvid 0x%x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid);
+	return 0;
+}
+
+/* Change the fid and vid, by the 3 phases. */
+static inline int transition_fid_vid(struct cpu_power *perproc, u32 idx, u8 rfid, u8 rvid)
+{
+	if (core_voltage_pre_transition(perproc, idx, rvid))
+		return 1;
+	if (core_frequency_transition(perproc, idx, rfid))
+		return 1;
+	if (core_voltage_post_transition(perproc, idx, rvid))
+		return 1;
+	if (query_current_values_with_pending_wait(perproc))
+		return 1;
+	if ((rfid != perproc->cfid) || (rvid != perproc->cvid)) {
+		printk(EFX "failed%d: req %x %x, curr %x %x\n",
+		       smp_processor_id(), rfid, rvid,
+		       perproc->cfid, perproc->cvid);
+		return 1;
+	}
+	dprintk(IFX "transitioned%d: new fid 0x%x, vid 0x%x\n",
+		smp_processor_id(),
+		perproc->cfid, perproc->cvid);
+	return 0;
+}

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
