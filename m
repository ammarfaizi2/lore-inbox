Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbUCZMd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbUCZMdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:33:25 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:24448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264039AbUCZMcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:32:02 -0500
Date: Fri, 26 Mar 2004 13:29:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: paul.devriendt@amd.com, mark.langsdorf@amd.com,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, davej@redhat.com
Subject: powernow-k8: support acpi
Message-ID: <20040326122931.GA321@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C1163C8D7@txexmtae.amd.com> <20040321185417.GA7969@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321185417.GA7969@dominikbrodowski.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Other than that, I'd strongly appreciate pushing the change "upstream" to
> Dave Jones / Andrew Morton / Linus Torvalds

Here it is.

This is new version of powernow-k8 driver. It adds SMP support, and
support for getting tables through ACPI. (ACPI support is really
important, because many machines have broken "legacy" tables). Please
apply,

								Pavel

--- clean/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-11 18:10:38.000000000 +0100
+++ linux-pn/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-26 13:23:08.000000000 +0100
@@ -1,22 +1,24 @@
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
  *  (C) 2004 Dominik Brodowski <linux@brodo.de>
  *  (C) 2004 Pavel Machek <pavel@suse.cz>
  *  Licensed under the terms of the GNU GPL License version 2.
  *  Based upon datasheets & sample CPUs kindly provided by AMD.
  *
+ *  Valuable input gratefully received from Dave Jones, Pavel Machek, Dominik
+ *  Brodowski, and others.
+ *
  *  Processor information obtained from Chapter 9 (Power and Thermal Management)
  *  of the "BIOS and Kernel Developer's Guide for the AMD Athlon 64 and AMD
- *  Opteron Processors", revision 3.03, available for download from www.amd.com
- *
+ *  Opteron Processors" available for download from www.amd.com
  */
 
 #include <linux/kernel.h>
@@ -31,55 +33,47 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
+#ifdef CONFIG_ACPI
+#define CONFIG_X86_POWERNOW_K8_ACPI
+#endif
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
+
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+
+#endif /* CONFIG_X86_POWERNOW_K8_ACPI */
+
+
 #define PFX "powernow-k8: "
-#define BFX PFX "BIOS error: "
-#define VERSION "version 1.00.08a"
+#define VERSION "version 1.20.08b - March 20, 2004"
 #include "powernow-k8.h"
 
-static u32 vstable;	/* voltage stabalization time, from PSB, units 20 us */
-static u32 plllock;	/* pll lock time, from PSB, units 1 us */
-static u32 numps;	/* number of p-states, from PSB */
-static u32 rvo;		/* ramp voltage offset, from PSB */
-static u32 irt;		/* isochronous relief time, from PSB */
-static u32 vidmvs;	/* usable value calculated from mvs, from PSB */
-static u32 currvid;	/* keep track of the current fid / vid */
-static u32 currfid;
+/* serialize freq changes  */
+static DECLARE_MUTEX(fidvid_sem);
 
-static struct cpufreq_frequency_table *powernow_table;
+static struct powernow_k8_data *powernow_data[NR_CPUS];
 
-/*
-The PSB table supplied by BIOS allows for the definition of the number of
-p-states that can be used when running on a/c, and the number of p-states
-that can be used when running on battery. This allows laptop manufacturers
-to force the system to save power when running from battery. The relationship 
-is :
-   1 <= number_of_battery_p_states <= maximum_number_of_p_states
-
-This driver does NOT have the support in it to detect transitions from
-a/c power to battery power, and thus trigger the transition to a lower
-p-state if required. This is because I need ACPI and the 2.6 kernel to do 
-this, and this is a 2.4 kernel driver. Check back for a new improved driver
-for the 2.6 kernel soon.
-
-This code therefore assumes it is on battery at all times, and thus
-restricts performance to number_of_battery_p_states. For desktops, 
-  number_of_battery_p_states == maximum_number_of_pstates, 
-so this is not actually a restriction.
-*/
 
-static u32 batps;	/* limit on the number of p states when on battery */
-			/* - set by BIOS in the PSB/PST                    */
+/* Return a frequency in MHz, given an input fid */
+static inline u32 find_freq_from_fid(u32 fid)
+{
+	return 800 + (fid * 100);
+}
 
- /* Return a frequency in MHz, given an input fid */
-static u32 find_freq_from_fid(u32 fid)
+/* Return a frequency in KHz, given an input fid */
+static inline u32 find_khz_freq_from_fid(u32 fid)
 {
- 	return 800 + (fid * 100);
+	return 1000 * find_freq_from_fid(fid);
 }
 
+/* Return a voltage in miliVolts, given an input vid */
+static inline u32 find_milivolts_from_vid(struct powernow_k8_data *data, u32 vid)
+{
+	return 1550-vid*25;
+}
 
 /* Return the vco fid for an input fid */
-static u32
-convert_fid_to_vco_fid(u32 fid)
+static u32 convert_fid_to_vco_fid(u32 fid)
 {
 	if (fid < HI_FID_TABLE_BOTTOM) {
 		return 8 + (2 * fid);
@@ -89,11 +83,10 @@
 }
 
 /*
- * Return 1 if the pending bit is set. Unless we are actually just told the
- * processor to transition a state, seeing this bit set is really bad news.
+ * Return 1 if the pending bit is set. Unless we just instructed the processor
+ * to transition to a new state, seeing this bit set is really bad news.
  */
-static inline int
-pending_bit_stuck(void)
+static inline int pending_bit_stuck(void)
 {
 	u32 lo, hi;
 
@@ -102,11 +95,10 @@
 }
 
 /*
- * Update the global current fid / vid values from the status msr. Returns 1
- * on error.
+ * Update the global current fid / vid values from the status msr. Returns
+ * 1 on error.
  */
-static int
-query_current_values_with_pending_wait(void)
+static int query_current_values_with_pending_wait(struct powernow_k8_data *data)
 {
 	u32 lo, hi;
 	u32 i = 0;
@@ -120,63 +112,69 @@
 		rdmsr(MSR_FIDVID_STATUS, lo, hi);
 	}
 
-	currvid = hi & MSR_S_HI_CURRENT_VID;
-	currfid = lo & MSR_S_LO_CURRENT_FID;
+	data->currvid = hi & MSR_S_HI_CURRENT_VID;
+	data->currfid = lo & MSR_S_LO_CURRENT_FID;
 
 	return 0;
 }
 
 /* the isochronous relief time */
-static inline void
-count_off_irt(void)
+static inline void count_off_irt(struct powernow_k8_data *data)
 {
-	udelay((1 << irt) * 10);
+	udelay((1 << data->irt) * 10);
 	return;
 }
 
-/* the voltage stabalization time */
-static inline void
-count_off_vst(void)
+/* the voltage stabilization time */
+static inline void count_off_vst(struct powernow_k8_data *data)
 {
-	udelay(vstable * VST_UNITS_20US);
+	udelay(data->vstable * VST_UNITS_20US);
 	return;
 }
 
+/* need to init the control msr to a safe value (for each cpu) */
+static void fidvid_msr_init(void)
+{
+	u32 lo, hi;
+	u8 fid, vid;
+
+	rdmsr(MSR_FIDVID_STATUS, lo, hi);
+	vid = hi & MSR_S_HI_CURRENT_VID;
+	fid = lo & MSR_S_LO_CURRENT_FID;
+	lo = fid | (vid << MSR_C_LO_VID_SHIFT);
+	hi = MSR_C_HI_STP_GNT_BENIGN;
+	dprintk(PFX "cpu%d, init lo %x, hi %x\n", smp_processor_id(), lo, hi);
+	wrmsr(MSR_FIDVID_CTL, lo, hi);
+}
+
 /* write the new fid value along with the other control fields to the msr */
-static int
-write_new_fid(u32 fid)
+static int write_new_fid(struct powernow_k8_data *data, u32 fid)
 {
 	u32 lo;
-	u32 savevid = currvid;
+	u32 savevid = data->currvid;
 
-	if ((fid & INVALID_FID_MASK) || (currvid & INVALID_VID_MASK)) {
+	if ((fid & INVALID_FID_MASK) || (data->currvid & INVALID_VID_MASK)) {
 		printk(KERN_ERR PFX "internal error - overflow on fid write\n");
 		return 1;
 	}
 
-	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
-
+	lo = fid | (data->currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
 	dprintk(KERN_DEBUG PFX "writing fid %x, lo %x, hi %x\n",
-		fid, lo, plllock * PLL_LOCK_CONVERSION);
-
-	wrmsr(MSR_FIDVID_CTL, lo, plllock * PLL_LOCK_CONVERSION);
-
-	if (query_current_values_with_pending_wait())
+		fid, lo, data->plllock * PLL_LOCK_CONVERSION);
+	wrmsr(MSR_FIDVID_CTL, lo, data->plllock * PLL_LOCK_CONVERSION);
+	if (query_current_values_with_pending_wait(data))
 		return 1;
+	count_off_irt(data);
 
-	count_off_irt();
-
-	if (savevid != currvid) {
-		printk(KERN_ERR PFX
-		       "vid changed on fid transition, save %x, currvid %x\n",
-		       savevid, currvid);
+	if (savevid != data->currvid) {
+		printk(KERN_ERR PFX "vid change on fid trans, old %x, new %x\n",
+		       savevid, data->currvid);
 		return 1;
 	}
 
-	if (fid != currfid) {
-		printk(KERN_ERR PFX
-		       "fid transition failed, fid %x, currfid %x\n",
-		        fid, currfid);
+	if (fid != data->currfid) {
+		printk(KERN_ERR PFX "fid trans failed, fid %x, curr %x\n", fid,
+		       data->currfid);
 		return 1;
 	}
 
@@ -184,40 +182,33 @@
 }
 
 /* Write a new vid to the hardware */
-static int
-write_new_vid(u32 vid)
+static int write_new_vid(struct powernow_k8_data *data, u32 vid)
 {
 	u32 lo;
-	u32 savefid = currfid;
+	u32 savefid = data->currfid;
 
-	if ((currfid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
+	if ((data->currfid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
 		printk(KERN_ERR PFX "internal error - overflow on vid write\n");
 		return 1;
 	}
 
-	lo = currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
-
+	lo = data->currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
 	dprintk(KERN_DEBUG PFX "writing vid %x, lo %x, hi %x\n",
 		vid, lo, STOP_GRANT_5NS);
-
 	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
-
-	if (query_current_values_with_pending_wait()) {
+	if (query_current_values_with_pending_wait(data))
 		return 1;
-	}
 
-	if (savefid != currfid) {
-		printk(KERN_ERR PFX
-		       "fid changed on vid transition, save %x currfid %x\n",
-		       savefid, currfid);
+	if (savefid != data->currfid) {
+		printk(KERN_ERR PFX "fid changed on vid trans, old %x new %x\n",
+		       savefid, data->currfid);
 		return 1;
 	}
 
-	if (vid != currvid) {
-		printk(KERN_ERR PFX
-		       "vid transition failed, vid %x, currvid %x\n",
-		       vid, currvid);
-		return 1;
+	if (vid != data->currvid) {
+		printk(KERN_ERR PFX "vid trans failed, vid %x, curr %x\n", vid,
+		       data->currvid);
+ 		return 1;
 	}
 
 	return 0;
@@ -228,300 +219,279 @@
  * Decreasing vid codes represent increasing voltages:
  * vid of 0 is 1.550V, vid of 0x1e is 0.800V, vid of 0x1f is off.
  */
-static int
-decrease_vid_code_by_step(u32 reqvid, u32 step)
+static int decrease_vid_code_by_step(struct powernow_k8_data *data, u32 reqvid, u32 step)
 {
-	if ((currvid - reqvid) > step)
-		reqvid = currvid - step;
-
-	if (write_new_vid(reqvid))
+	if ((data->currvid - reqvid) > step)
+		reqvid = data->currvid - step;
+	if (write_new_vid(data, reqvid))
 		return 1;
-
-	count_off_vst();
-
+	count_off_vst(data);
 	return 0;
 }
 
 /* Change the fid and vid, by the 3 phases. */
-static inline int
-transition_fid_vid(u32 reqfid, u32 reqvid)
+static inline int transition_fid_vid(struct powernow_k8_data *data, u32 reqfid, u32 reqvid)
 {
-	if (core_voltage_pre_transition(reqvid))
+	if (core_voltage_pre_transition(data, reqvid))
 		return 1;
-
-	if (core_frequency_transition(reqfid))
+	if (core_frequency_transition(data, reqfid))
 		return 1;
-
-	if (core_voltage_post_transition(reqvid))
+	if (core_voltage_post_transition(data, reqvid))
 		return 1;
-
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(data))
 		return 1;
 
-	if ((reqfid != currfid) || (reqvid != currvid)) {
-		printk(KERN_ERR PFX "failed: req 0x%x 0x%x, curr 0x%x 0x%x\n",
-		       reqfid, reqvid, currfid, currvid);
+	if ((reqfid != data->currfid) || (reqvid != data->currvid)) {
+		printk(KERN_ERR PFX "failed (cpu%d): req %x %x, curr %x %x\n",
+		       smp_processor_id(),
+		       reqfid, reqvid, data->currfid, data->currvid);
 		return 1;
 	}
 
-	dprintk(KERN_INFO PFX
-		"transitioned: new fid 0x%x, vid 0x%x\n", currfid, currvid);
-
+	dprintk(KERN_INFO PFX "transitioned (cpu%d): new fid %x, vid %x\n",
+		smp_processor_id(), data->currfid, data->currvid);
 	return 0;
 }
 
-/*
- * Phase 1 - core voltage transition ... setup appropriate voltage for the
- * fid transition.
- */
-static inline int
-core_voltage_pre_transition(u32 reqvid)
+/* Phase 1 - core voltage transition ... setup voltage */
+static inline int core_voltage_pre_transition(struct powernow_k8_data *data, u32 reqvid)
 {
-	u32 rvosteps = rvo;
-	u32 savefid = currfid;
+	u32 rvosteps = data->rvo;
+	u32 savefid = data->currfid;
 
 	dprintk(KERN_DEBUG PFX
-		"ph1: start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo %x\n",
-		currfid, currvid, reqvid, rvo);
-
-	while (currvid > reqvid) {
-		dprintk(KERN_DEBUG PFX "ph1: curr 0x%x, requesting vid 0x%x\n",
-			currvid, reqvid);
-		if (decrease_vid_code_by_step(reqvid, vidmvs))
+		"ph1 (cpu%d): start, currfid %x, currvid %x, reqvid %x, rvo %x\n",
+		smp_processor_id(),
+		data->currfid, data->currvid, reqvid, data->rvo);
+
+	while (data->currvid > reqvid) {
+		dprintk(KERN_DEBUG PFX "ph1: curr %x, req vid %x\n",
+			data->currvid, reqvid);
+		if (decrease_vid_code_by_step(data, reqvid, data->vidmvs))
 			return 1;
 	}
 
 	while (rvosteps > 0) {
-		if (currvid == 0) {
+		if (data->currvid == 0) {
 			rvosteps = 0;
 		} else {
 			dprintk(KERN_DEBUG PFX
-				"ph1: changing vid for rvo, requesting 0x%x\n",
-				currvid - 1);
-			if (decrease_vid_code_by_step(currvid - 1, 1))
+				"ph1: changing vid for rvo, req %x\n",
+				data->currvid - 1);
+			if (decrease_vid_code_by_step(data, data->currvid - 1, 1))
 				return 1;
 			rvosteps--;
 		}
 	}
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(data))
 		return 1;
 
-	if (savefid != currfid) {
-		printk(KERN_ERR PFX "ph1 err, currfid changed 0x%x\n", currfid);
+	if (savefid != data->currfid) {
+		printk(KERN_ERR PFX "ph1: err, currfid changed %x\n", data->currfid);
 		return 1;
 	}
 
-	dprintk(KERN_DEBUG PFX "ph1 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
+	dprintk(KERN_DEBUG PFX "ph1: complete, currfid %x, currvid %x\n",
+		data->currfid, data->currvid);
 
 	return 0;
 }
 
 /* Phase 2 - core frequency transition */
-static inline int
-core_frequency_transition(u32 reqfid)
+static inline int core_frequency_transition(struct powernow_k8_data *data, u32 reqfid)
 {
 	u32 vcoreqfid;
 	u32 vcocurrfid;
 	u32 vcofiddiff;
-	u32 savevid = currvid;
+	u32 savevid = data->currvid;
 
-	if ((reqfid < HI_FID_TABLE_BOTTOM) && (currfid < HI_FID_TABLE_BOTTOM)) {
-		printk(KERN_ERR PFX "ph2 illegal lo-lo transition 0x%x 0x%x\n",
-		       reqfid, currfid);
+	if ((reqfid < HI_FID_TABLE_BOTTOM) && (data->currfid < HI_FID_TABLE_BOTTOM)) {
+		printk(KERN_ERR PFX "ph2: illegal lo-lo transition %x %x\n",
+		       reqfid, data->currfid);
 		return 1;
 	}
 
-	if (currfid == reqfid) {
-		printk(KERN_ERR PFX "ph2 null fid transition 0x%x\n", currfid);
+	if (data->currfid == reqfid) {
+		printk(KERN_ERR PFX "ph2: null fid transition %x\n", data->currfid);
 		return 0;
 	}
 
 	dprintk(KERN_DEBUG PFX
-		"ph2 starting, currfid 0x%x, currvid 0x%x, reqfid 0x%x\n",
-		currfid, currvid, reqfid);
+		"ph2 (cpu%d): starting, currfid %x, currvid %x, reqfid %x\n",
+		smp_processor_id(),
+		data->currfid, data->currvid, reqfid);
 
 	vcoreqfid = convert_fid_to_vco_fid(reqfid);
-	vcocurrfid = convert_fid_to_vco_fid(currfid);
+	vcocurrfid = convert_fid_to_vco_fid(data->currfid);
 	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
 	    : vcoreqfid - vcocurrfid;
 
 	while (vcofiddiff > 2) {
-		if (reqfid > currfid) {
-			if (currfid > LO_FID_TABLE_TOP) {
-				if (write_new_fid(currfid + 2)) {
+		if (reqfid > data->currfid) {
+			if (data->currfid > LO_FID_TABLE_TOP) {
+				if (write_new_fid(data, data->currfid + 2)) {
 					return 1;
 				}
 			} else {
 				if (write_new_fid
-				    (2 + convert_fid_to_vco_fid(currfid))) {
+				    (data, 2 + convert_fid_to_vco_fid(data->currfid))) {
 					return 1;
 				}
 			}
 		} else {
-			if (write_new_fid(currfid - 2))
+			if (write_new_fid(data, data->currfid - 2))
 				return 1;
 		}
 
-		vcocurrfid = convert_fid_to_vco_fid(currfid);
+		vcocurrfid = convert_fid_to_vco_fid(data->currfid);
 		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
 		    : vcoreqfid - vcocurrfid;
 	}
 
-	if (write_new_fid(reqfid))
+	if (write_new_fid(data, reqfid))
 		return 1;
-
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(data))
 		return 1;
 
-	if (currfid != reqfid) {
+	if (data->currfid != reqfid) {
 		printk(KERN_ERR PFX
-		       "ph2 mismatch, failed fid transition, curr %x, req %x\n",
-		       currfid, reqfid);
+		       "ph2: mismatch, failed fid transition, curr %x, req %x\n",
+		       data->currfid, reqfid);
 		return 1;
 	}
 
-	if (savevid != currvid) {
-		printk(KERN_ERR PFX
-		       "ph2 vid changed, save %x, curr %x\n", savevid,
-		       currvid);
+	if (savevid != data->currvid) {
+		printk(KERN_ERR PFX "ph2: vid changed, save %x, curr %x\n",
+		       savevid, data->currvid);
 		return 1;
 	}
 
-	dprintk(KERN_DEBUG PFX "ph2 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
+	dprintk(KERN_DEBUG PFX "ph2: complete, currfid %x, currvid %x\n",
+		data->currfid, data->currvid);
 
 	return 0;
 }
 
 /* Phase 3 - core voltage transition flow ... jump to the final vid. */
-static inline int
-core_voltage_post_transition(u32 reqvid)
+static inline int core_voltage_post_transition(struct powernow_k8_data *data, u32 reqvid)
 {
-	u32 savefid = currfid;
+	u32 savefid = data->currfid;
 	u32 savereqvid = reqvid;
 
-	dprintk(KERN_DEBUG PFX "ph3 starting, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
+	dprintk(KERN_DEBUG PFX "ph3 (cpu%d): starting, currfid %x, currvid %x\n",
+		smp_processor_id(),
+		data->currfid, data->currvid);
 
-	if (reqvid != currvid) {
-		if (write_new_vid(reqvid))
+	if (reqvid != data->currvid) {
+		if (write_new_vid(data, reqvid))
 			return 1;
 
-		if (savefid != currfid) {
+		if (savefid != data->currfid) {
 			printk(KERN_ERR PFX
 			       "ph3: bad fid change, save %x, curr %x\n",
-			       savefid, currfid);
+			       savefid, data->currfid);
 			return 1;
 		}
 
-		if (currvid != reqvid) {
+		if (data->currvid != reqvid) {
 			printk(KERN_ERR PFX
 			       "ph3: failed vid transition\n, req %x, curr %x",
-			       reqvid, currvid);
+			       reqvid, data->currvid);
 			return 1;
 		}
 	}
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(data))
 		return 1;
 
-	if (savereqvid != currvid) {
-		dprintk(KERN_ERR PFX "ph3 failed, currvid 0x%x\n", currvid);
+	if (savereqvid != data->currvid) {
+		printk(KERN_ERR PFX "ph3: failed, currvid %x\n", data->currvid);
 		return 1;
 	}
 
-	if (savefid != currfid) {
-		dprintk(KERN_ERR PFX "ph3 failed, currfid changed 0x%x\n",
-			currfid);
+	if (savefid != data->currfid) {
+		printk(KERN_ERR PFX "ph3: failed, currfid changed %x\n",
+			data->currfid);
 		return 1;
 	}
 
-	dprintk(KERN_DEBUG PFX "ph3 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
-
+	dprintk(KERN_DEBUG PFX "ph3: complete, currfid %x, currvid %x\n",
+		data->currfid, data->currvid);
 	return 0;
 }
 
-static inline int
-check_supported_cpu(void)
+static inline int check_supported_cpu(unsigned int cpu)
 {
-	struct cpuinfo_x86 *c = cpu_data;
+	cpumask_t oldmask = CPU_MASK_ALL;
 	u32 eax, ebx, ecx, edx;
+	unsigned int rc = 0;
 
-	if (num_online_cpus() != 1) {
-		printk(KERN_INFO PFX "multiprocessor systems not supported\n");
-		return 0;
-	}
+	oldmask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	schedule();
 
-	if (c->x86_vendor != X86_VENDOR_AMD) {
-#ifdef MODULE
-		printk(KERN_INFO PFX "Not an AMD processor\n");
-#endif
-		return 0;
+	if (smp_processor_id() != cpu) {
+		printk(KERN_ERR "limiting to cpu %u failed\n", cpu);
+		goto out;
 	}
 
+	if (current_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		goto out;
+
 	eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
 	if ((eax & CPUID_XFAM_MOD) == ATHLON64_XFAM_MOD) {
 		dprintk(KERN_DEBUG PFX "AMD Althon 64 Processor found\n");
-		if ((eax & CPUID_F1_STEP) < ATHLON64_REV_C0) {
-			printk(KERN_INFO PFX "Revision C0 or better "
-			       "AMD Athlon 64 processor required\n");
-			return 0;
-		}
 	} else if ((eax & CPUID_XFAM_MOD) == OPTERON_XFAM_MOD) {
 		dprintk(KERN_DEBUG PFX "AMD Opteron Processor found\n");
 	} else {
 		printk(KERN_INFO PFX
 		       "AMD Athlon 64 or AMD Opteron processor required\n");
-		return 0;
+		goto out;
 	}
 
 	eax = cpuid_eax(CPUID_GET_MAX_CAPABILITIES);
 	if (eax < CPUID_FREQ_VOLT_CAPABILITIES) {
-		printk(KERN_INFO PFX
-		       "No frequency change capabilities detected\n");
-		return 0;
+		printk(KERN_INFO PFX "No freq change capabilities\n");
+		goto out;
 	}
 
 	cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
 	if ((edx & P_STATE_TRANSITION_CAPABLE) != P_STATE_TRANSITION_CAPABLE) {
 		printk(KERN_INFO PFX "Power state transitions not supported\n");
-		return 0;
+		goto out;
 	}
 
-	printk(KERN_INFO PFX "Found AMD64 processor supporting PowerNow (" VERSION ")\n");
-	return 1;
+	rc = 1;
+
+ out:
+	set_cpus_allowed(current, oldmask);
+	schedule();
+	return rc;
 }
 
-static int check_pst_table(struct pst_s *pst, u8 maxvid)
+static int check_pst_table(struct powernow_k8_data *data, struct pst_s *pst, u8 maxvid)
 {
 	unsigned int j;
-	u8 lastfid = 0xFF;
+	u8 lastfid = 0xff;
 
-	for (j = 0; j < numps; j++) {
+	for (j = 0; j < data->numps; j++) {
 		if (pst[j].vid > LEAST_VID) {
-			printk(KERN_ERR PFX "vid %d invalid : 0x%x\n", j, pst[j].vid);
+			printk(KERN_ERR PFX "vid %d bad: %x\n", j, pst[j].vid);
 			return -EINVAL;
 		}
-		if (pst[j].vid < rvo) {	/* vid + rvo >= 0 */
-			printk(KERN_ERR PFX
-			       "BIOS error - 0 vid exceeded with pstate %d\n",
-			       j);
+		if (pst[j].vid < data->rvo) {	/* vid + rvo >= 0 */
+			printk(KERN_ERR PFX "0 vid exceeded with pst %d\n", j);
 			return -ENODEV;
 		}
-		if (pst[j].vid < maxvid + rvo) {	/* vid + rvo >= maxvid */
-			printk(KERN_ERR PFX
-			       "BIOS error - maxvid exceeded with pstate %d\n",
-			       j);
+		if (pst[j].vid < maxvid + data->rvo) { /* vid + rvo >= maxvid */
+			printk(KERN_ERR PFX "maxvid exceeded with pst %d\n", j);
 			return -ENODEV;
 		}
 		if ((pst[j].fid > MAX_FID)
 		    || (pst[j].fid & 1)
 		    || (j && (pst[j].fid < HI_FID_TABLE_BOTTOM))) {
-			/* Only first fid is allowed to be in "low" range */
-			printk(KERN_ERR PFX "fid %d invalid : 0x%x\n", j, pst[j].fid);
+			printk(KERN_ERR PFX "fid %d bad: %x\n", j, pst[j].fid);
 			return -EINVAL;
 		}
 		if (pst[j].fid < lastfid)
@@ -531,20 +501,87 @@
 		printk(KERN_ERR PFX "lastfid invalid\n");
 		return -EINVAL;
 	}
-	if (lastfid > LO_FID_TABLE_TOP) {
-		printk(KERN_INFO PFX  "first fid not from lo freq table\n");
+	if (lastfid > LO_FID_TABLE_TOP)
+		printk(KERN_INFO PFX "first fid not from lo freq table\n");
+
+	return 0;
+}
+
+static void print_basics(struct powernow_k8_data *data)
+{
+	int j;
+	for (j = 0; j < data->numps; j++) {
+		printk(KERN_INFO PFX "   %d : fid %x (%d MHz), vid %x (%d mV)\n", j,
+		       data->powernow_table[j].index & 0xff, 
+		       data->powernow_table[j].frequency/1000, 
+		       data->powernow_table[j].index >> 8, 
+		       find_milivolts_from_vid(data, data->powernow_table[j].index >> 8));
+	}
+	if (data->batps)
+		printk(KERN_INFO PFX "Only %d pstates on battery\n", data->batps);
+}
+
+static inline int fill_powernow_table(struct powernow_k8_data *data, struct pst_s *pst, u8 maxvid)
+{
+	struct cpufreq_frequency_table *powernow_table;
+	unsigned int j;
+
+	if (data->batps) {    /* use ACPI support to get full speed on mains power */
+		printk(KERN_WARNING PFX "Only %d pstates usable (use ACPI driver for full range\n", data->batps);
+		data->numps = data->batps;
 	}
 
+	for ( j=1; j<data->numps; j++ )
+		if (pst[j-1].fid >= pst[j].fid) {
+			printk(KERN_ERR PFX "PST out of sequence\n");
+			return -EINVAL;
+		}
+
+	if (data->numps < 2) {
+		printk(KERN_ERR PFX "no p states to transition\n");
+		return -ENODEV;
+	}
+
+	if (check_pst_table(data, pst, maxvid))
+		return -EINVAL;
+
+	powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) 
+				  * (data->numps + 1)), GFP_KERNEL);
+	if (!powernow_table) {
+		printk(KERN_ERR PFX "powernow_table memory alloc failure\n");
+		return -ENOMEM;
+	}
+
+	for (j = 0; j < data->numps; j++) {
+		powernow_table[j].index = pst[j].fid; /* lower 8 bits */
+		powernow_table[j].index |= (pst[j].vid << 8); /* upper 8 bits */
+		powernow_table[j].frequency = find_khz_freq_from_fid(pst[j].fid);
+	}
+	powernow_table[data->numps].frequency = CPUFREQ_TABLE_END;
+	powernow_table[data->numps].index = 0;
+
+	if (query_current_values_with_pending_wait(data)) {
+		kfree(powernow_table);
+		return -EIO;
+	}
+
+	dprintk(KERN_INFO PFX "cfid %x, cvid %x\n", data->currfid, data->currvid);
+	data->powernow_table = powernow_table;
+	print_basics(data);
+
+	for (j = 0; j < data->numps; j++)
+		if ((pst[j].fid==data->currfid) && (pst[j].vid==data->currvid))
+			return 0;
+
+	dprintk(KERN_ERR PFX "currfid/vid do not match PST, ignoring\n");
 	return 0;
 }
 
 /* Find and validate the PSB/PST table in BIOS. */
-static inline int
-find_psb_table(void)
+static inline int find_psb_table(struct powernow_k8_data *data)
 {
 	struct psb_s *psb;
-	struct pst_s *pst;
-	unsigned int i, j;
+	unsigned int i;
 	u32 mvs;
 	u8 maxvid;
 
@@ -556,276 +593,427 @@
 		if (memcmp(psb, PSB_ID_STRING, PSB_ID_STRING_LEN) != 0)
 			continue;
 
-		dprintk(KERN_DEBUG PFX "found PSB header at 0x%p\n", psb);
-
-		dprintk(KERN_DEBUG PFX "table vers: 0x%x\n", psb->tableversion);
+		dprintk(KERN_DEBUG PFX "found PSB header at %p\n", psb);
+		dprintk(KERN_DEBUG PFX "table version: %x\n",
+			psb->tableversion);
 		if (psb->tableversion != PSB_VERSION_1_4) {
-			printk(KERN_INFO BFX "PSB table is not v1.4\n");
+			printk(KERN_INFO PFX "PSB table is not v1.4\n");
 			return -ENODEV;
 		}
 
-		dprintk(KERN_DEBUG PFX "flags: 0x%x\n", psb->flags1);
+		dprintk(KERN_DEBUG PFX "flags: %x\n", psb->flags1);
 		if (psb->flags1) {
-			printk(KERN_ERR BFX "unknown flags\n");
+			printk(KERN_ERR PFX "unknown flags\n");
 			return -ENODEV;
 		}
 
-		vstable = psb->voltagestabilizationtime;
-		dprintk(KERN_DEBUG PFX "flags2: 0x%x\n", psb->flags2);
-		rvo = psb->flags2 & 3;
-		irt = ((psb->flags2) >> 2) & 3;
+		data->vstable = psb->voltagestabilizationtime;
+		dprintk(KERN_INFO PFX "voltage stabilization time: %d(*20us)\n", data->vstable);
+
+		dprintk(KERN_DEBUG PFX "flags2: %x\n", psb->flags2);
+ 
+		data->rvo = psb->flags2 & 3;
+		data->irt = ((psb->flags2) >> 2) & 3;
 		mvs = ((psb->flags2) >> 4) & 3;
-		vidmvs = 1 << mvs;
-		batps = ((psb->flags2) >> 6) & 3;
+		data->vidmvs = 1 << mvs;
+		data->batps = ((psb->flags2) >> 6) & 3;
 
-		printk(KERN_INFO PFX "voltage stable in %d usec", vstable * 20);
-		if (batps)
-			printk(", only %d lowest states on battery", batps);
-		printk(", ramp voltage offset: %d", rvo);
-		printk(", isochronous relief time: %d", irt);
-		printk(", maximum voltage step: %d\n", mvs);
+		dprintk(KERN_INFO PFX "ramp voltage offset: %d\n", data->rvo);
+		dprintk(KERN_INFO PFX "isochronous relief time: %d\n", data->irt);
+		dprintk(KERN_INFO PFX "maximum voltage step: %d - %x\n",
+			mvs, data->vidmvs);
 
 		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
 		if (psb->numpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
+			printk(KERN_ERR PFX "numpst must be 1\n");
 			return -ENODEV;
 		}
 
-		dprintk(KERN_DEBUG PFX "cpuid: 0x%x\n", psb->cpuid);
-
-		plllock = psb->plllocktime;
-		printk(KERN_INFO PFX "pll lock time: 0x%x, ", plllock);
-
+		data->plllock = psb->plllocktime;
+		dprintk(KERN_INFO PFX "plllocktime: %x (units 1us)\n",
+			psb->plllocktime);
+		dprintk(KERN_INFO PFX "maxfid: %x\n", psb->maxfid);
+		dprintk(KERN_INFO PFX "maxvid: %x\n", psb->maxvid);
 		maxvid = psb->maxvid;
-		printk("maxfid 0x%x (%d MHz), maxvid 0x%x\n", 
-		       psb->maxfid, find_freq_from_fid(psb->maxfid), maxvid);
 
-		numps = psb->numpstates;
-		if (numps < 2) {
-			printk(KERN_ERR BFX "no p states to transition\n");
-			return -ENODEV;
-		}
+		data->numps = psb->numpstates;
+		dprintk(KERN_INFO PFX "numpstates: %x\n", data->numps);
+		return fill_powernow_table(data, (struct pst_s *)(psb+1), maxvid);
+	}
 
-		if (batps == 0) {
-			batps = numps;
-		} else if (batps > numps) {
-			printk(KERN_ERR BFX "batterypstates > numpstates\n");
-			batps = numps;
-		} else {
-			printk(KERN_ERR PFX
-			       "Restricting operation to %d p-states\n", batps);
-			printk(KERN_ERR PFX
-			       "Check for an updated driver to access all "
-			       "%d p-states\n", numps);
-		}
+	/*
+	 * If you see this message, complain to BIOS manufacturer. If
+	 * he tells you "we do not support Linux" or some similar
+	 * nonsense, remember that Windows 2000 uses the same legacy
+	 * mechanism that the old Linux PSB driver uses. Tell them it
+	 * is broken with Windows 2000.
+	 *
+	 * The reference to the AMD documentation is chapter 9 in the
+	 * BIOS and Kernel Developer's Guide, which is available on
+	 * www.amd.com
+	 */
+	printk(KERN_ERR PFX "BIOS error - no PSB\n");
+	return -ENODEV;
+}
 
-		if (numps <= 1) {
-			printk(KERN_ERR PFX "only 1 p-state to transition\n");
-			return -ENODEV;
-		}
 
-		pst = (struct pst_s *) (psb + 1);
-		if (check_pst_table(pst, maxvid))
-			return -EINVAL;
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
 
-		powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) * (numps + 1)), GFP_KERNEL);
-		if (!powernow_table) {
-			printk(KERN_ERR PFX "powernow_table memory alloc failure\n");
-			return -ENOMEM;
-		}
+static inline void powernow_k8_acpi_pst_values(struct powernow_k8_data *data, unsigned int index)
+{
+	if (!data->acpi_data.state_count)
+		return;
 
-		for (j = 0; j < psb->numpstates; j++) {
-			powernow_table[j].index = pst[j].fid; /* lower 8 bits */
-			powernow_table[j].index |= (pst[j].vid << 8); /* upper 8 bits */
-		}
+	data->irt = (data->acpi_data.states[index].control >> IRT_SHIFT) & IRT_MASK;
+	data->rvo = (data->acpi_data.states[index].control >> RVO_SHIFT) & RVO_MASK;
+	data->plllock = (data->acpi_data.states[index].control >> PLL_L_SHIFT) & PLL_L_MASK;
+	data->vidmvs = 1 << ((data->acpi_data.states[index].control >> MVS_SHIFT) & MVS_MASK);
+	data->vstable = (data->acpi_data.states[index].control >> VST_SHIFT) & VST_MASK;
+}
 
-		/* If you want to override your frequency tables, this
-		   is right place. */
+static int powernow_k8_cpu_init_acpi(struct powernow_k8_data *data) 
+{ 
+	int i;
+	int cntlofreq = 0;
+	struct cpufreq_frequency_table *powernow_table;
 
-		for (j = 0; j < numps; j++) {
-			powernow_table[j].frequency = find_freq_from_fid(powernow_table[j].index & 0xff)*1000;
-			printk(KERN_INFO PFX "   %d : fid 0x%x (%d MHz), vid 0x%x\n", j,
-			       powernow_table[j].index & 0xff,
-			       powernow_table[j].frequency/1000,
-			       powernow_table[j].index >> 8);
+	if (acpi_processor_register_performance(&data->acpi_data, data->cpu)) {
+		dprintk(KERN_DEBUG PFX "register performance failed\n");
+		return -EIO;
+	}
+
+	/* verify the data contained in the ACPI structures */
+	if (data->acpi_data.state_count <= 1) {
+		dprintk(KERN_DEBUG PFX "No ACPI P-States\n");
+		goto err_out;
+ 	}
+
+	if ((data->acpi_data.control_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) ||
+	    (data->acpi_data.status_register.space_id != ACPI_ADR_SPACE_FIXED_HARDWARE)) {
+		dprintk(KERN_DEBUG PFX "Invalid control/status registers\n");
+		goto err_out;
+	}
+
+	/* fill in data->powernow_table */
+	powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) 
+				  * (data->acpi_data.state_count + 1)), GFP_KERNEL);
+	if (!powernow_table) {
+		dprintk(KERN_ERR PFX "powernow_table memory alloc failure\n");
+		goto err_out;
+	}
+
+	for (i = 0; i < data->acpi_data.state_count; i++) {
+		u32 fid = data->acpi_data.states[i].control & FID_MASK;
+		u32 vid = (data->acpi_data.states[i].control >> VID_SHIFT) & VID_MASK;
+
+		dprintk(KERN_INFO PFX "   %d : fid %x, vid %x\n", i, fid, vid);
+
+		powernow_table[i].index = fid; /* lower 8 bits */
+		powernow_table[i].index |= (vid << 8); /* upper 8 bits */
+		powernow_table[i].frequency = find_khz_freq_from_fid(fid);
+
+		/* verify frequency is OK */
+		if ((powernow_table[i].frequency > (MAX_FREQ * 1000)) ||
+		    (powernow_table[i].frequency < (MIN_FREQ * 1000))) {
+			dprintk(KERN_INFO PFX "invalid freq %u kHz\n", powernow_table[i].frequency);
+			powernow_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+			continue;
 		}
 
-		powernow_table[numps].frequency = CPUFREQ_TABLE_END;
-		powernow_table[numps].index = 0;
+		/* verify only 1 entry from the lo frequency table */
+		if ((fid < HI_FID_TABLE_BOTTOM) && (cntlofreq++)) {
+			printk(KERN_ERR PFX "Too many lo freq table entries\n");
+			goto err_out;
+		}
 
-		if (query_current_values_with_pending_wait()) {
-			kfree(powernow_table);
-			return -EIO;
+		if (powernow_table[i].frequency != (data->acpi_data.states[i].core_frequency * 1000)) {
+			printk(KERN_INFO PFX "invalid freq entries %u kHz vs. %u kHz\n", 
+			       powernow_table[i].frequency, 
+			       (unsigned int) (data->acpi_data.states[i].core_frequency * 1000));
+			powernow_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+			continue;
 		}
+	}
+	powernow_table[data->acpi_data.state_count].frequency = CPUFREQ_TABLE_END;
+	powernow_table[data->acpi_data.state_count].index = 0;
+	data->powernow_table = powernow_table;
+
+	/* fill in data */
+	data->numps = data->acpi_data.state_count;
+	print_basics(data);
 
-		printk(KERN_INFO PFX "currfid 0x%x (%d MHz), currvid 0x%x\n",
-		       currfid, find_freq_from_fid(currfid), currvid);
+	powernow_k8_acpi_pst_values(data, 0);
 
-		for (j = 0; j < numps; j++)
-			if ((pst[j].fid==currfid) && (pst[j].vid==currvid))
-				return 0;
+	return 0;
 
-		printk(KERN_ERR BFX "currfid/vid do not match PST, ignoring\n");
-		return 0;
-	}
+ err_out:
+	acpi_processor_unregister_performance(&data->acpi_data, data->cpu);
+
+	/* data->acpi_data.state_count informs us at ->exit() whether ACPI was used */
+	data->acpi_data.state_count = 0;
 
-	printk(KERN_ERR BFX "no PSB\n");
 	return -ENODEV;
 }
 
+static void powernow_k8_cpu_exit_acpi(struct powernow_k8_data *data) 
+{
+	if (data->acpi_data.state_count)
+		acpi_processor_unregister_performance(&data->acpi_data, data->cpu);
+}
+
+#else
+static inline int powernow_k8_cpu_init_acpi(struct powernow_k8_data *data) { return -ENODEV; }
+static inline void powernow_k8_cpu_exit_acpi(struct powernow_k8_data *data) { return; }
+static inline void powernow_k8_acpi_pst_values(struct powernow_k8_data *data, unsigned int index) { return; }
+#endif /* CONFIG_X86_POWERNOW_K8_ACPI */
+
+
 /* Take a frequency, and issue the fid/vid transition command */
-static inline int
-transition_frequency(unsigned int index)
+static inline int transition_frequency(struct powernow_k8_data *data, unsigned int index)
 {
 	u32 fid;
 	u32 vid;
 	int res;
 	struct cpufreq_freqs freqs;
 
+        dprintk(KERN_DEBUG PFX "cpu %d transition to index %u\n",
+		smp_processor_id(), index );
+
 	/* fid are the lower 8 bits of the index we stored into
 	 * the cpufreq frequency table in find_psb_table, vid are 
 	 * the upper 8 bits.
 	 */
 
-	fid = powernow_table[index].index & 0xFF;
-	vid = (powernow_table[index].index & 0xFF00) >> 8;
+	fid = data->powernow_table[index].index & 0xFF;
+	vid = (data->powernow_table[index].index & 0xFF00) >> 8;
 
-	dprintk(KERN_DEBUG PFX "table matched fid 0x%x, giving vid 0x%x\n",
-		fid, vid);
+	dprintk(KERN_DEBUG PFX "matched fid %x, giving vid %x\n", fid, vid);
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(data))
 		return 1;
 
-	if ((currvid == vid) && (currfid == fid)) {
-		dprintk(KERN_DEBUG PFX
-			"target matches current values (fid 0x%x, vid 0x%x)\n",
+	if ((data->currvid == vid) && (data->currfid == fid)) {
+		dprintk(KERN_DEBUG PFX "target matches curr (fid %x, vid %x)\n",
 			fid, vid);
 		return 0;
 	}
 
-	if ((fid < HI_FID_TABLE_BOTTOM) && (currfid < HI_FID_TABLE_BOTTOM)) {
+	if ((fid < HI_FID_TABLE_BOTTOM) && (data->currfid < HI_FID_TABLE_BOTTOM)) {
 		printk(KERN_ERR PFX
 		       "ignoring illegal change in lo freq table-%x to %x\n",
-		       currfid, fid);
+		       data->currfid, fid);
 		return 1;
 	}
 
-	dprintk(KERN_DEBUG PFX "changing to fid 0x%x, vid 0x%x\n", fid, vid);
-
-	freqs.cpu = 0;	/* only true because SMP not supported */
+	dprintk(KERN_DEBUG PFX "cpu %d, changing to fid %x, vid %x\n",
+		smp_processor_id(), fid, vid);
+	freqs.cpu = data->cpu;
 
-	freqs.old = find_freq_from_fid(currfid);
-	freqs.new = find_freq_from_fid(fid);
+	freqs.old = find_khz_freq_from_fid(data->currfid);
+	freqs.new = find_khz_freq_from_fid(fid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
-	res = transition_fid_vid(fid, vid);
+	down(&fidvid_sem);
+	res = transition_fid_vid(data, fid, vid);
+	up(&fidvid_sem);
 
-	freqs.new = find_freq_from_fid(currfid);
+	freqs.new = find_khz_freq_from_fid(data->currfid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return res;
 }
 
 /* Driver entry point to switch to the target frequency */
-static int
-powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
+static int powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
 {
-	u32 checkfid = currfid;
-	u32 checkvid = currvid;
+	cpumask_t oldmask = CPU_MASK_ALL;
+	struct powernow_k8_data *data = powernow_data[pol->cpu];
+	u32 checkfid = data->currfid;
+	u32 checkvid = data->currvid;
 	unsigned int newstate;
+	int ret = -EIO;
+
+	/* only run on specific CPU from here on */
+	oldmask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
+	schedule();
+
+	if (smp_processor_id() != pol->cpu) {
+		printk(KERN_ERR "limiting to cpu %u failed\n", pol->cpu);
+		goto err_out;
+	}
+
+	/* from this point, do not exit without restoring preempt and cpu */
+	preempt_disable();
 
 	if (pending_bit_stuck()) {
-		printk(KERN_ERR PFX "drv targ fail: change pending bit set\n");
-		return -EIO;
+		printk(KERN_ERR PFX "failing targ, change pending bit set\n");
+		goto err_out;
 	}
 
-	dprintk(KERN_DEBUG PFX "targ: %d kHz, min %d, max %d, relation %d\n",
-		targfreq, pol->min, pol->max, relation);
+	dprintk(KERN_DEBUG PFX "targ: cpu %d, %d kHz, min %d, max %d, relation %d\n",
+		pol->cpu, targfreq, pol->min, pol->max, relation);
 
-	if (query_current_values_with_pending_wait())
-		return -EIO;
+	if (query_current_values_with_pending_wait(data)) {
+		ret = -EIO;
+		goto err_out;
+	}
 
-	dprintk(KERN_DEBUG PFX "targ: curr fid 0x%x, vid 0x%x\n",
-		currfid, currvid);
+	dprintk(KERN_DEBUG PFX "targ: curr fid %x, vid %x\n",
+		data->currfid, data->currvid);
 
-	if ((checkvid != currvid) || (checkfid != currfid)) {
-		printk(KERN_ERR PFX
-		       "error - out of sync, fid 0x%x 0x%x, vid 0x%x 0x%x\n",
-		       checkfid, currfid, checkvid, currvid);
+	if ((checkvid != data->currvid) || (checkfid != data->currfid)) {
+		printk(KERN_ERR PFX "out of sync, fid %x %x, vid %x %x\n",
+		       checkfid, data->currfid, checkvid, data->currvid);
 	}
 
-	if (cpufreq_frequency_table_target(pol, powernow_table, targfreq, relation, &newstate))
-		return -EINVAL;
-	
-	if (transition_frequency(newstate))
+	if (cpufreq_frequency_table_target(pol, data->powernow_table, targfreq, relation, &newstate)) 
+		goto err_out;
+
+	powernow_k8_acpi_pst_values(data, newstate);
+
+	if (transition_frequency(data, newstate))
 	{
 		printk(KERN_ERR PFX "transition frequency failed\n");
-		return 1;
+		ret = 1;
+		goto err_out;
 	}
 
-	pol->cur = 1000 * find_freq_from_fid(currfid);
+	pol->cur = find_khz_freq_from_fid(data->currfid);
+	ret = 0;
 
-	return 0;
+ err_out:
+	preempt_enable_no_resched();
+	set_cpus_allowed(current, oldmask);
+	schedule();
+
+	return ret;
 }
 
 /* Driver entry point to verify the policy and range of frequencies */
-static int
-powernowk8_verify(struct cpufreq_policy *pol)
+static int powernowk8_verify(struct cpufreq_policy *pol)
 {
-	if (pending_bit_stuck()) {
-		printk(KERN_ERR PFX "failing verify, change pending bit set\n");
-		return -EIO;
-	}
+	struct powernow_k8_data *data = powernow_data[pol->cpu];
 
-	return cpufreq_frequency_table_verify(pol, powernow_table);
+	return cpufreq_frequency_table_verify(pol, data->powernow_table);
 }
 
 /* per CPU init entry point to the driver */
-static int __init
-powernowk8_cpu_init(struct cpufreq_policy *pol)
+static int __init powernowk8_cpu_init(struct cpufreq_policy *pol)
 {
-	if (pol->cpu != 0) {
-		printk(KERN_ERR PFX "init not cpu 0\n");
+	cpumask_t oldmask = CPU_MASK_ALL;
+	int rc;
+	struct powernow_k8_data *data;
+
+	if (!check_supported_cpu(pol->cpu))
 		return -ENODEV;
+
+	data = kmalloc(sizeof(struct powernow_k8_data), GFP_KERNEL);
+	if (!data) {
+		printk(KERN_ERR PFX "unable to alloc powernow_k8_data");
+		return -ENOMEM;
+	}
+	memset(data,0,sizeof(struct powernow_k8_data));
+
+	data->cpu = pol->cpu;
+
+	if (powernow_k8_cpu_init_acpi(data)) {
+		/* 
+		 * Use the PSB BIOS structure. This is only availabe on
+		 * an UP version, and is deprecated by AMD.
+		 */
+
+		if (pol->cpu != 0) {
+			printk(KERN_ERR PFX "init - cpu 0\n");
+			kfree(data);
+			return -ENODEV;
+		}
+
+		if ((num_online_cpus() != 1) || (num_possible_cpus() != 1)) {
+			printk(KERN_INFO PFX "MP systems not supported by PSB BIOS structure\n");
+			kfree(data);
+			return 0;
+		}
+
+		rc = find_psb_table(data);
+		if (rc) {
+			kfree(data);
+			return -ENODEV;
+		}
 	}
 
+	/* only run on specific CPU from here on */
+	oldmask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
+	schedule();
+
+	if (smp_processor_id() != pol->cpu) {
+		printk(KERN_ERR "limiting to cpu %u failed\n", pol->cpu);
+		goto err_out;
+	}
+
+	if (pending_bit_stuck()) {
+		printk(KERN_ERR PFX "failing init, change pending bit set\n");
+		goto err_out;
+	}
+
+	if (query_current_values_with_pending_wait(data)) {
+		goto err_out;
+	}
+
+	fidvid_msr_init();
+
+
+	/* run on any CPU again */
+	set_cpus_allowed(current, oldmask);
+	schedule();
+
 	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
 
 	/* Take a crude guess here. 
-	 * That guess was in microseconds, so multply with 1000 */
-	pol->cpuinfo.transition_latency = (((rvo + 8) * vstable * VST_UNITS_20US)
-	    + (3 * (1 << irt) * 10)) * 1000;
-
-	if (query_current_values_with_pending_wait())
-		return -EIO;
+	 * That guess was in microseconds, so multiply with 1000 */
+	pol->cpuinfo.transition_latency = (((data->rvo + 8) * data->vstable * VST_UNITS_20US)
+	    + (3 * (1 << data->irt) * 10)) * 1000;
 
-	pol->cur = 1000 * find_freq_from_fid(currfid);
+	pol->cur = find_khz_freq_from_fid(data->currfid);
 	dprintk(KERN_DEBUG PFX "policy current frequency %d kHz\n", pol->cur);
 
 	/* min/max the cpu is capable of */
-	if (cpufreq_frequency_table_cpuinfo(pol, powernow_table)) {
+	if (cpufreq_frequency_table_cpuinfo(pol, data->powernow_table)) {
 		printk(KERN_ERR PFX "invalid powernow_table\n");
-		kfree(powernow_table);
+		kfree(data->powernow_table);
+		kfree(data);
 		return -EINVAL;
 	}
+	cpufreq_frequency_table_get_attr(data->powernow_table, pol->cpu);
 
-	cpufreq_frequency_table_get_attr(powernow_table, pol->cpu);
+	dprintk(KERN_INFO PFX "init, curr fid %x vid %x\n", data->currfid, data->currvid);
 
-	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
-	       currfid, currvid);
+	powernow_data[pol->cpu] = data;
 
 	return 0;
+
+ err_out:
+	set_cpus_allowed(current, oldmask);
+	schedule();
+
+	kfree(data);
+	return -ENODEV;
 }
 
 static int __exit powernowk8_cpu_exit (struct cpufreq_policy *pol)
 {
-	if (pol->cpu != 0)
+	struct powernow_k8_data *data = powernow_data[pol->cpu];
+
+	if (!data)
 		return -EINVAL;
 
+	powernow_k8_cpu_exit_acpi(data);
+
 	cpufreq_frequency_table_put_attr(pol->cpu);
 
-	if (powernow_table)
-		kfree(powernow_table);
+	kfree(data->powernow_table);
+	kfree(data);
 
 	return 0;
 }
@@ -845,33 +1033,31 @@
 	.attr = powernow_k8_attr,
 };
 
-
 /* driver entry point for init */
-static int __init
-powernowk8_init(void)
+static int __init powernowk8_init(void)
 {
-	int rc;
-
-	if (check_supported_cpu() == 0)
-		return -ENODEV;
+	unsigned int i, supported_cpus = 0;
 
-	rc = find_psb_table();
-	if (rc)
-		return rc;
+	for (i=0; i<NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		if (check_supported_cpu(i))
+			supported_cpus++;
+	}
 
-	if (pending_bit_stuck()) {
-		printk(KERN_ERR PFX "powernowk8_init fail, change pending bit set\n");
-		return -EIO;
+	if (supported_cpus == num_online_cpus()) {
+		printk(KERN_INFO PFX "Found %d AMD Athlon 64 / Opteron processors (" VERSION ")\n",
+		       supported_cpus);
+		return cpufreq_register_driver(&cpufreq_amd64_driver);
 	}
 
-	return cpufreq_register_driver(&cpufreq_amd64_driver);
+	return -ENODEV;
 }
 
 /* driver entry point for term */
-static void __exit
-powernowk8_exit(void)
+static void __exit powernowk8_exit(void)
 {
-	dprintk(KERN_INFO PFX "powernowk8_exit\n");
+	dprintk(KERN_INFO PFX "exit\n");
 
 	cpufreq_unregister_driver(&cpufreq_amd64_driver);
 }
@@ -880,5 +1066,5 @@
 MODULE_DESCRIPTION("AMD Athlon 64 and Opteron processor frequency driver.");
 MODULE_LICENSE("GPL");
 
-module_init(powernowk8_init);
+late_initcall(powernowk8_init);
 module_exit(powernowk8_exit);
--- clean/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-02-20 12:29:10.000000000 +0100
+++ linux-pn/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-26 12:44:27.000000000 +0100
@@ -1,20 +1,46 @@
 /*
- *   (c) 2003 Advanced Micro Devices, Inc.
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
  *  Your use of this code is subject to the terms and conditions of the
- *  GNU general public license version 2. See "../../../COPYING" or
+ *  GNU general public license version 2. See "COPYING" or
  *  http://www.gnu.org/licenses/gpl.html
  */
 
+struct powernow_k8_data {
+	unsigned int	cpu;
+
+	u32	numps;	/* number of p-states */
+	u32	batps; 	/* number of p-states supported on battery */
+
+	/* these values are constant when the PSB is used to determine
+	 * vid/fid pairings, but are modified during the ->target() call
+	 * when ACPI is used */
+	u32	rvo;	 /* ramp voltage offset */
+	u32	irt;	 /* isochronous relief time */
+	u32	vidmvs;	 /* usable value calculated from mvs */
+	u32	vstable; /* voltage stabilization time, units 20 us */
+	u32 	plllock; /* pll lock time, units 1 us */
+
+	/* keep track of the current fid / vid */
+	u32	currvid;
+	u32	currfid;
+
+	/* the powernow_table includes all frequency and vid/fid pairings:
+	 * fid are the lower 8 bits of the index, vid are the upper 8 bits.
+	 * frequency is in kHz */
+	struct cpufreq_frequency_table	*powernow_table;
+
+#ifdef CONFIG_X86_POWERNOW_K8_ACPI
+	/* the acpi table needs to be kept. it's only available if ACPI was
+	 * used to determine valid frequency/vid/fid states */
+	struct acpi_processor_performance acpi_data;
+#endif
+};
+
 /* processor's cpuid instruction support */
-#define CPUID_PROCESSOR_SIGNATURE             1	/* function 1               */
-#define CPUID_F1_FAM                 0x00000f00	/* family mask              */
-#define CPUID_F1_XFAM                0x0ff00000	/* extended family mask     */
-#define CPUID_F1_MOD                 0x000000f0	/* model mask               */
-#define CPUID_F1_STEP                0x0000000f	/* stepping level mask      */
-#define CPUID_XFAM_MOD               0x0ff00ff0	/* xtended fam, fam + model */
-#define ATHLON64_XFAM_MOD            0x00000f40	/* xtended fam, fam + model */
-#define OPTERON_XFAM_MOD             0x00000f50	/* xtended fam, fam + model */
-#define ATHLON64_REV_C0                       8
+#define CPUID_PROCESSOR_SIGNATURE             1	/* function 1 */
+#define CPUID_XFAM_MOD               0x0ff00ff0	/* extended fam, fam + model */
+#define ATHLON64_XFAM_MOD            0x00000f40	/* extended fam, fam + model */
+#define OPTERON_XFAM_MOD             0x00000f50	/* extended fam, fam + model */
 #define CPUID_GET_MAX_CAPABILITIES   0x80000000
 #define CPUID_FREQ_VOLT_CAPABILITIES 0x80000007
 #define P_STATE_TRANSITION_CAPABLE            6
@@ -23,7 +49,6 @@
 /* writes (wrmsr - opcode 0f 30), the register number is placed in ecx, and   */
 /* the value to write is placed in edx:eax. For reads (rdmsr - opcode 0f 32), */
 /* the register number is placed in ecx, and the data is returned in edx:eax. */
-
 #define MSR_FIDVID_CTL      0xc0010041
 #define MSR_FIDVID_STATUS   0xc0010042
 
@@ -47,10 +72,24 @@
 #define MSR_S_HI_MAX_WORKING_VID  0x001f0000
 #define MSR_S_HI_START_VID        0x00001f00
 #define MSR_S_HI_CURRENT_VID      0x0000001f
+#define MSR_C_HI_STP_GNT_BENIGN   0x00000001
+
+/*
+   There are restrictions frequencies have to follow:
+   - only 1 entry in the low fid table ( <=1.4GHz )
+   - lowest entry in the high fid table must be >= 2 * the
+     entry in the low fid table
+   - lowest entry in the high fid table must be a <= 200MHz +
+     2 * the entry in the low fid table
+   - the parts can only step at 200 MHz intervals, so 1.9 GHz is
+     never valid
+   - lowest frequency must be >= interprocessor hypertransport link
+     speed (only applies to MP systems obviously)
+ */
 
 /* fids (frequency identifiers) are arranged in 2 tables - lo and hi */
-#define LO_FID_TABLE_TOP     6
-#define HI_FID_TABLE_BOTTOM  8
+#define LO_FID_TABLE_TOP           6   /* fid values marking the boundary    */
+#define HI_FID_TABLE_BOTTOM        8   /* between the low and high tables    */
 
 #define LO_VCOFREQ_TABLE_TOP    1400	/* corresponding vco frequency values */
 #define HI_VCOFREQ_TABLE_BOTTOM 1600
@@ -58,33 +97,44 @@
 #define MIN_FREQ_RESOLUTION  200 /* fids jump by 2 matching freq jumps by 200 */
 
 #define MAX_FID 0x2a	/* Spec only gives FID values as far as 5 GHz */
-
 #define LEAST_VID 0x1e	/* Lowest (numerically highest) useful vid value */
-
 #define MIN_FREQ 800	/* Min and max freqs, per spec */
 #define MAX_FREQ 5000
 
-#define INVALID_FID_MASK 0xffffffc1  /* not a valid fid if these bits are set */
-
-#define INVALID_VID_MASK 0xffffffe0  /* not a valid vid if these bits are set */
+#define INVALID_FID_MASK 0xffffffc1 /* not a valid fid if these bits are set */
+#define INVALID_VID_MASK 0xffffffe0 /* not a valid vid if these bits are set */
 
 #define STOP_GRANT_5NS 1 /* min poss memory access latency for voltage change */
-
 #define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
-
 #define MAXIMUM_VID_STEPS 1  /* Current cpus only allow a single step of 25mV */
+#define VST_UNITS_20US 20   /* Voltage Stabilization Time is in units of 20us */
 
-#define VST_UNITS_20US 20   /* Voltage Stabalization Time is in units of 20us */
+/*
+ * Most values of interest are enocoded in a single field of the _PSS
+ * entries: the "control" value.
+ */
 
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
 /*
-Version 1.4 of the PSB table. This table is constructed by BIOS and is
-to tell the OS's power management driver which VIDs and FIDs are
-supported by this particular processor. This information is obtained from
-the data sheets for each processor model by the system vendor and
-incorporated into the BIOS.
-If the data in the PSB / PST is wrong, then this driver will program the
-wrong values into hardware, which is very likely to lead to a crash.
-*/
+ * Version 1.4 of the PSB table. This table is constructed by BIOS and is
+ * to tell the OS's power management driver which VIDs and FIDs are
+ * supported by this particular processor.
+ * If the data in the PSB / PST is wrong, then this driver will program the
+ * wrong values into hardware, which is very likely to lead to a crash.
+ */
 
 #define PSB_ID_STRING      "AMDK7PNOW!"
 #define PSB_ID_STRING_LEN  10
@@ -117,6 +167,7 @@
 #define dprintk(msg...) do { } while(0)
 #endif
 
-static inline int core_voltage_pre_transition(u32 reqvid);
-static inline int core_voltage_post_transition(u32 reqvid);
-static inline int core_frequency_transition(u32 reqfid);
+static inline int core_voltage_pre_transition(struct powernow_k8_data *data, u32 reqvid);
+static inline int core_voltage_post_transition(struct powernow_k8_data *data, u32 reqvid);
+static inline int core_frequency_transition(struct powernow_k8_data *data, u32 reqfid);
+static inline void powernow_k8_acpi_pst_values(struct powernow_k8_data *data, unsigned int index);




-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
