Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbTHVOCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTHVOCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:02:42 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:27860 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263224AbTHVOBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:01:14 -0400
Date: Fri, 22 Aug 2003 15:59:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: davej@codemonkey.org.uk, kernel list <linux-kernel@vger.kernel.org>
Cc: paul.devriendt@amd.com, aj@suse.de
Subject: Cpufreq for opteron
Message-ID: <20030822135946.GA2194@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What about this patch? It looks reasonable to me... It adds support
for voltage scaling on amd64 machines. Please apply and/or comment.

								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-07-06 20:06:50.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/cpu/cpufreq/Kconfig	2003-08-22 14:59:21.000000000 +0200
@@ -88,6 +88,16 @@
 
 	  If in doubt, say N.
 
+config X86_POWERNOW_K8
+	tristate "AMD K8 PowerNow!"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for AMD K8.
+
+	  For details, take a look at linux/Documentation/cpu-freq. 
+
+	  If in doubt, say N.
+
 config X86_GX_SUSPMOD
 	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
 	depends on CPU_FREQ
--- /usr/src/tmp/linux/arch/i386/kernel/cpu/cpufreq/Makefile	2003-07-06 20:06:50.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/cpu/cpufreq/Makefile	2003-08-22 14:59:28.000000000 +0200
@@ -1,5 +1,6 @@
 obj-$(CONFIG_X86_POWERNOW_K6)	+= powernow-k6.o
 obj-$(CONFIG_X86_POWERNOW_K7)	+= powernow-k7.o
+obj-$(CONFIG_X86_POWERNOW_K8)	+= powernow-k8.o
 obj-$(CONFIG_X86_LONGHAUL)	+= longhaul.o
 obj-$(CONFIG_X86_P4_CLOCKMOD)	+= p4-clockmod.o
 obj-$(CONFIG_ELAN_CPUFREQ)	+= elanfreq.o
--- /usr/src/tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2003-08-22 14:58:23.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2003-08-22 15:14:15.000000000 +0200
@@ -0,0 +1,1253 @@
+/*
+ *   (c) 2003 Advanced Micro Devices, Inc.
+ *   (c) 2003 Pavel Machek <pavel@suse.cz>
+ *  Your use of this code is subject to the terms
+ *  and conditions of the GNU general public license version 2.
+ *  (See "../../../COPYING" or http://www.gnu.org/licenses/gpl.html)
+ *
+ *  Support : paul.devriendt@amd.com
+ *
+ *  Based on the powernow-k7.c module written by Dave Jones.
+ *  (C) 2003 Dave Jones <davej@suse.de>
+ *  Based upon datasheets & sample CPUs kindly provided by AMD.
+ *
+ *  Processor information obtained from Chapter 9 (Power and Thermal Management)
+ *  of the "BIOS and Kernel Developer's Guide for the AMD Athlon 64 and AMD
+ *  Opteron Processors", revision 3.03, available for download from www.amd.com
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/cpufreq.h>
+
+#include <asm/msr.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#undef DEBUG
+#undef TRACE
+
+#define PFX "amd64-cpuf: "
+
+#define VERSION "version 1.00.06 - August 13, 2003"
+
+#include "powernow-k8.h"
+
+#ifdef CONFIG_SMP
+#error cpufreq support is disabled for config_smp
+#endif
+#ifdef CONFIG_PREEMPT
+#warning noone tested this on preempt system, beware
+#endif
+
+#ifdef LOG_CHANGES
+static char *vid_name(u32 vid);
+static char *fid_name(u32 fid);
+#endif
+
+static u32 convert_fid_to_vco_fid(u32 fid);
+static inline u32 find_freq_from_fid(u32 fid);
+static inline u32 find_fid_from_freq(u32 freq);
+static u32 find_closest_fid(u32 freq, int searchup);
+static inline void sort_pst(struct pst_s *ppst, u32 numpstates);
+static inline void count_off_vst(void);
+static inline void count_off_irt(void);
+static inline int transition_frequency(u32 * preq, u32 * pmin, u32 * pmax,
+				       u32 searchup);
+static int find_match(u32 * ptargfreq, u32 * pmin, u32 * pmax, int searchup,
+		      u32 * pfid, u32 * pvid);
+static inline int transition_fid_vid(u32 reqfid, u32 reqvid);
+static int decrease_vid_code_by_step(u32 reqvid, u32 step);
+static int write_new_fid(u32 fid);
+static int write_new_vid(u32 vid);
+static inline int pending_bit_stuck(void);
+static int query_current_values_with_pending_wait(void);
+static inline int core_voltage_pre_transition(u32 reqvid);
+static inline int core_voltage_post_transition(u32 reqvid);
+static inline int core_frequency_transition(u32 reqfid);
+static inline int find_psb_table(void);
+static inline int check_supported_cpu(void);
+static int drv_verify(struct cpufreq_policy *pol);
+static int drv_target(struct cpufreq_policy *pol, unsigned targfreq,
+		      unsigned relation);
+static int __init drv_cpu_init(struct cpufreq_policy *pol);
+static void __exit drv_exit(void);
+
+static u32 vstable;	/* voltage stabalization time, from the PSB, units 20 us */
+static u32 plllock;	/* pll lock time, from the PSB, units 1 us */
+static u32 numpstates;	/* number of p-states, from the PSB */
+static u32 rvo;	/* ramp voltage offset, from the PSB */
+static u32 irt;	/* isochronous relief time, from the PSB */
+static u32 vidmvs;/* usable value calculated from mvs, which is in the PSB */
+struct pst_s *ppst;	/* array of p states, valid for this part */
+static u32 currvid;/* keep track of what we think the current fid / vid are */
+static u32 currfid;
+
+/*
+The PSB table supplied by BIOS allows for the definition of the number of
+p-states that can be used when running on a/c, and the number of p-states
+that can be used when running on battery. This allows laptop manufacturers
+to force the system to save power when running from battery. The relationship 
+is :
+   1 <= number_of_battery_p_states <= maximum_number_of_p_states
+
+This driver does NOT have the support in it to detect transitions from
+a/c power to battery power, and thus trigger the transition to a lower
+p-state if required. This is because I need ACPI and the 2.6 kernel to do 
+this, and this is a 2.4 kernel driver. Check back for a new improved driver
+for the 2.6 kernel soon.
+
+This code therefore assumes it is on battery at all times, and thus
+restricts performance to number_of_battery_p_states. For desktops, 
+  number_of_battery_p_states == maximum_number_of_pstates, 
+so this is not actually a restriction.
+*/
+
+static u32 batterypstates;	/* limit on the number of p states when on battery */
+			   /* - set by BIOS in the PSB/PST                    */
+
+static int onbattery = 1;	/* Set if running on battery, reset otherwise. */
+			   /* Of no relevance unless batterypstates <     */
+			   /* numpstates, as defined in the PSB/PST.      */
+
+static struct cpufreq_driver cpufreq_amd64_driver = {
+	.verify = drv_verify,
+	.target = drv_target,
+	.init = drv_cpu_init,
+	.name = "cpufreq-amd64",
+	.owner = THIS_MODULE,
+};
+
+#define SEARCH_UP     1
+#define SEARCH_DOWN   0
+
+#ifdef LOG_CHANGES
+static char *pVIDs[] = {
+	"1.550V", "1.525V", "1.500V",
+	"1.475V", "1.450V", "1.425V", "1.400V",
+	"1.375V", "1.350V", "1.325V", "1.300V",
+	"1.275V", "1.250V", "1.225V", "1.200V",
+	"1.175V", "1.150V", "1.125V", "1.100V",
+	"1.075V", "1.050V", "1.025V", "1.000V",
+	"0.975V", "0.950V", "0.925V", "0.900V",
+	"0.875V", "0.850V", "0.825V", "0.800V",
+	"off",	"error - impossible vid"
+};
+
+/* Return a printable text name, given an input vid. Used only for debug. */
+static char *
+vid_name(u32 vid)
+{
+	if (vid & INVALID_VID_MASK)
+		return (pVIDs[32]);
+	else
+		return (pVIDs[vid]);
+}
+
+/* Return a printable text name, given an input fid. Used only for debug. */
+/* Warning, not reentrant due to the static "return" buffer.              */
+static char *
+fid_name(u32 fid)
+{
+	unsigned freq;
+	static char fidnamebuffer[32];
+
+	if (fid & INVALID_FID_MASK) {
+		return ("error - impossible fid");
+	}
+
+	else if (fid < HI_FID_TABLE_BOTTOM) {
+		switch (fid) {
+		case 0:
+			return ("800 MHz - lo tbl");
+
+		case 2:
+			return ("1.0 GHz - lo tbl");
+
+		case 4:
+			return ("1.2 GHz - lo tbl");
+
+		case 6:
+			return ("1.4 GHz - lo tbl");
+
+		default:
+			return ("error - impossible fid (lo tbl)");
+		}
+	}
+
+	else {
+		freq =
+		    HI_VCOFREQ_TABLE_BOTTOM +
+		    (((fid >> 1) - 4) * MIN_FREQ_RESOLUTION);
+		sprintf(fidnamebuffer, "%d MHz", freq);
+		return (fidnamebuffer);
+	}
+}
+#endif
+
+/* Return a frequency in MHz, given an input fid */
+u32
+find_freq_from_fid(u32 fid)
+{
+#ifdef DEBUG
+	if (fid & INVALID_FID_MASK) {
+		printk(KERN_ERR PFX "bad fid 0x%x for conversion to freq\n",
+		       fid);
+		return 0;
+	}
+#endif
+	return 800 + (fid * 100);
+}
+
+/* Return a fid matching an input frequency in MHz */
+u32
+find_fid_from_freq(u32 freq)
+{
+#ifdef DEBUG
+	if ((freq % MIN_FREQ_RESOLUTION) || (freq < MIN_FREQ)
+	    || (freq > MAX_FREQ)) {
+		printk(KERN_ERR PFX "bad freq %d for conversion to fid\n",
+		       freq);
+		return 0;
+	}
+#endif
+	return (freq - 800) / 100;
+}
+
+/* Return the vco fid for an input fid */
+static u32
+convert_fid_to_vco_fid(u32 fid)
+{
+#ifdef DEBUG
+	if (fid & INVALID_FID_MASK) {
+		printk(KERN_ERR PFX "bad fid 0x%x for vco conversion\n", fid);
+	}
+#endif
+
+	if (fid < HI_FID_TABLE_BOTTOM) {
+		return 8 + (2 * fid);
+	} else {
+		return fid;
+	}
+}
+
+/* Sort the fid/vid frequency table into ascending order by fid. The spec */
+/* implies that it will be sorted by BIOS, but, it only implies it, and I */
+/* prefer not to trust when I can check.                                  */
+/* Yes, it is a simple bubble sort, but the PST is really small, so the   */
+/* choice of algorithm is pretty irrelevant.                              */
+static inline void
+sort_pst(struct pst_s *ppst, u32 numpstates)
+{
+	u32 i;
+	u8 tempfid;
+	u8 tempvid;
+	int swaps = 1;
+
+	while (swaps) {
+		swaps = 0;
+		for (i = 0; i < (numpstates - 1); i++) {
+			if (ppst[i].fid > ppst[i + 1].fid) {
+				swaps = 1;
+				tempfid = ppst[i].fid;
+				tempvid = ppst[i].vid;
+				ppst[i].fid = ppst[i + 1].fid;
+				ppst[i].vid = ppst[i + 1].vid;
+				ppst[i + 1].fid = tempfid;
+				ppst[i + 1].vid = tempvid;
+			}
+		}
+	}
+
+	return;
+}
+
+/* Return 1 if the pending bit is set. Unless we are actually just told the processor */
+/* to transition a state, seeing this bit set is really bad news.                     */
+static inline int
+pending_bit_stuck()
+{
+	u32 lo;
+	u32 hi;
+
+	rdmsr(MSR_FIDVID_STATUS, lo, hi);
+	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
+}
+
+/* Update the global current fid / vid values from the status msr. 
+   Returns 1 on error. */
+static int
+query_current_values_with_pending_wait()
+{
+	u32 lo;
+	u32 hi;
+	u32 i = 0;
+
+	lo = MSR_S_LO_CHANGE_PENDING;
+	while (lo & MSR_S_LO_CHANGE_PENDING) {
+		if (i++ > 0x1000000) {
+			printk(KERN_ERR PFX "detected change pending stuck\n");
+			return 1;
+		}
+		rdmsr(MSR_FIDVID_STATUS, lo, hi);
+	}
+
+	currvid = hi & MSR_S_HI_CURRENT_VID;
+	currfid = lo & MSR_S_LO_CURRENT_FID;
+
+	return 0;
+}
+
+/* the isochronous relief time */
+static inline void
+count_off_irt()
+{
+	tprintk(KERN_DEBUG PFX "irt - udelay for %x\n", (1 << irt) * 10);
+	udelay((1 << irt) * 10);
+	return;
+}
+
+/* the voltage stabalization time */
+static inline void
+count_off_vst()
+{
+	tprintk(KERN_DEBUG PFX "vst - udelay for %x\n",
+		vstable * VST_UNITS_20US);
+	udelay(vstable * VST_UNITS_20US);
+	return;
+}
+
+/* write the new fid value along with the other control fields to the msr */
+static int
+write_new_fid(u32 fid)
+{
+	u32 lo;
+	u32 savevid = currvid;
+
+	if ((fid & INVALID_FID_MASK) || (currvid & INVALID_VID_MASK)) {
+		printk(KERN_ERR PFX
+		       "internal error - fid/vid overflow on fid write\n");
+		return 1;
+	}
+
+	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
+
+	tprintk(KERN_DEBUG PFX "writing fid %x, lo %x, hi %x\n",
+		fid, lo, plllock * PLL_LOCK_CONVERSION);
+
+	wrmsr(MSR_FIDVID_CTL, lo, plllock * PLL_LOCK_CONVERSION);
+
+	if (query_current_values_with_pending_wait())
+		return 1;
+
+	count_off_irt();
+
+#ifdef DEBUG
+	if (savevid != currvid) {
+		printk(KERN_ERR PFX
+		       "vid changed on fid transition, save %x, currvid %x\n",
+		       savevid, currvid);
+		return 1;
+	}
+
+	if (fid != currfid) {
+		printk(KERN_ERR PFX
+		       "fid transition failed, fid %x, currfid %x\n", fid,
+		       currfid);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+/* Write a new vid to the hardware */
+static int
+write_new_vid(u32 vid)
+{
+	u32 lo;
+	u32 savefid = currfid;
+
+	if ((currfid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
+		printk(KERN_ERR PFX
+		       "internal error - fid/vid overflow on vid write\n");
+		return 1;
+	}
+
+	lo = currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
+
+	tprintk(KERN_DEBUG PFX "writing vid %x, lo %x, hi %x\n",
+		vid, lo, STOP_GRANT_5NS);
+
+	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
+
+	if (query_current_values_with_pending_wait()) {
+		return 1;
+	}
+#ifdef DEBUG
+	if (savefid != currfid) {
+		printk(KERN_ERR PFX
+		       "fid changed on vid transition, save %x currfid %x\n",
+		       savefid, currfid);
+		return 1;
+	}
+
+	if (vid != currvid) {
+		printk(KERN_ERR PFX
+		       "vid transition failed, vid %x, currvid %x\n", vid,
+		       currvid);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+/* Reduce the vid by the max of step or reqvid.                   */
+/* Decreasing vid codes represent increasing voltages :           */
+/* vid of 0 is 1.550V, vid of 0x1e is 0.800V, vid of 0x1f is off. */
+static int
+decrease_vid_code_by_step(u32 reqvid, u32 step)
+{
+#ifdef DEBUG
+	if ((currvid <= reqvid) || (!step)) {
+		printk(KERN_ERR PFX "impossible vid decrease\n");
+		return 1;
+	}
+#endif
+	if ((currvid - reqvid) > step)
+		reqvid = currvid - step;
+	if (write_new_vid(reqvid))
+		return 1;
+	count_off_vst();
+	return 0;
+}
+
+/* Change the fid and vid, by the 3 phases. */
+static inline int
+transition_fid_vid(u32 reqfid, u32 reqvid)
+{
+	if (core_voltage_pre_transition(reqvid))
+		return 1;
+	if (core_frequency_transition(reqfid))
+		return 1;
+	if (core_voltage_post_transition(reqvid))
+		return 1;
+#ifdef DEBUG
+	if (query_current_values_with_pending_wait())
+		return 1;
+#endif
+	if ((reqfid != currfid) || (reqvid != currvid)) {
+		printk(KERN_ERR PFX "failed: req 0x%x 0x%x, curr 0x%x 0x%x\n",
+		       reqfid, reqvid, currfid, currvid);
+		return 1;
+	}
+
+	lprintk(KERN_INFO PFX
+		"transitioned: new fid 0x%x (%s), vid 0x%x (%s)\n", currfid,
+		fid_name(currfid), currvid, vid_name(currvid));
+
+	return 0;
+}
+
+/* Phase 1 - core voltage transition ... setup appropriate voltage for the */
+/* fid transition.                                                         */
+static inline int
+core_voltage_pre_transition(u32 reqvid)
+{
+	u32 rvosteps = rvo;
+	u32 savefid = currfid;
+
+	dprintk(KERN_DEBUG PFX
+		"ph1: start, currfid 0x%x, currvid 0x%x, reqvid 0x%x, rvo %x\n",
+		currfid, currvid, reqvid, rvo);
+
+	while (currvid > reqvid) {
+		dprintk(KERN_DEBUG PFX "ph1: curr 0x%x, requesting vid 0x%x\n",
+			currvid, reqvid);
+		if (decrease_vid_code_by_step(reqvid, vidmvs)) {
+			return 1;
+		}
+	}
+
+	while (rvosteps > 0) {
+		if (currvid == 0) {
+			rvosteps = 0;
+		} else {
+			dprintk(KERN_DEBUG PFX
+				"ph1: changing vid for rvo, requesting 0x%x\n",
+				currvid - 1);
+			if (decrease_vid_code_by_step(currvid - 1, 1)) {
+				return 1;
+			}
+			rvosteps--;
+		}
+	}
+
+#ifdef DEBUG
+	if (query_current_values_with_pending_wait()) {
+		return 1;
+	}
+
+	if (savefid != currfid) {
+		printk(KERN_ERR PFX "ph1: error, currfid changed 0x%x\n",
+		       currfid);
+		return 1;
+	}
+
+	printk(KERN_DEBUG PFX "ph1: complete, currfid 0x%x, currvid 0x%x\n",
+	       currfid, currvid);
+#endif
+	return 0;
+}
+
+/* Phase 2 - core frequency transition */
+static inline int
+core_frequency_transition(u32 reqfid)
+{
+	u32 vcoreqfid;
+	u32 vcocurrfid;
+	u32 vcofiddiff;
+
+#ifdef DEBUG
+	u32 savevid = currvid;
+
+	if ((reqfid < HI_FID_TABLE_BOTTOM) && (currfid < HI_FID_TABLE_BOTTOM)) {
+		printk(KERN_ERR PFX "ph2: illegal lo-lo transition 0x%x 0x%x\n",
+		       reqfid, currfid);
+		return 1;
+	}
+
+	if (currfid == reqfid) {
+		printk(KERN_ERR PFX "ph2: null fid transition 0x%x\n", currfid);
+		return 1;
+	}
+#endif
+
+	dprintk(KERN_DEBUG PFX
+		"ph2: starting, currfid 0x%x, currvid 0x%x, reqfid 0x%x\n",
+		currfid, currvid, reqfid);
+
+	vcoreqfid = convert_fid_to_vco_fid(reqfid);
+	vcocurrfid = convert_fid_to_vco_fid(currfid);
+	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
+	    : vcoreqfid - vcocurrfid;
+
+	while (vcofiddiff > 2) {
+		if (reqfid > currfid) {
+			if (currfid > LO_FID_TABLE_TOP) {
+				if (write_new_fid(currfid + 2)) {
+					return 1;
+				}
+			} else {
+				if (write_new_fid
+				    (2 + convert_fid_to_vco_fid(currfid))) {
+					return 1;
+				}
+			}
+		} else {
+			if (write_new_fid(currfid - 2)) {
+				return 1;
+			}
+		}
+
+		vcocurrfid = convert_fid_to_vco_fid(currfid);
+		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
+		    : vcoreqfid - vcocurrfid;
+	}
+
+	if (write_new_fid(reqfid)) {
+		return 1;
+	}
+#ifdef DEBUG
+	if (query_current_values_with_pending_wait()) {
+		return 1;
+	}
+
+	if (currfid != reqfid) {
+		printk(KERN_ERR PFX
+		       "ph2: mismatch, failed fid transition, curr %x, req %x\n",
+		       currfid, reqfid);
+		return 1;
+	}
+
+	if (savevid != currvid) {
+		printk(KERN_ERR PFX
+		       "ph2: vid changed, save %x, curr %x\n", savevid,
+		       currvid);
+		return 1;
+	}
+
+	printk(KERN_DEBUG PFX "ph2: complete, currfid 0x%x, currvid 0x%x\n",
+	       currfid, currvid);
+#endif
+
+	return 0;
+}
+
+/* Phase 3 - core voltage transition flow ... jump to the final vid. */
+static inline int
+core_voltage_post_transition(u32 reqvid)
+{
+	u32 savefid = currfid;
+	u32 savereqvid = reqvid;
+
+	dprintk(KERN_DEBUG PFX "ph3: starting, currfid 0x%x, currvid 0x%x\n",
+		currfid, currvid);
+
+	if (reqvid != currvid) {
+		if (write_new_vid(reqvid)) {
+			return 1;
+		}
+#ifdef DEBUG
+		if (savefid != currfid) {
+			printk(KERN_ERR PFX
+			       "ph3: bad fid change, save %x, curr %x\n",
+			       savefid, currfid);
+			return 1;
+		}
+
+		if (currvid != reqvid) {
+			printk(KERN_ERR PFX
+			       "ph3: failed vid transition\n, req %x, curr %x",
+			       reqvid, currvid);
+			return 1;
+		}
+#endif
+
+	}
+
+#ifdef DEBUG
+	if (query_current_values_with_pending_wait()) {
+		return 1;
+	}
+
+	if (savereqvid != currvid) {
+		printk(KERN_ERR PFX "ph3: failed, currvid 0x%x\n", currvid);
+		return 1;
+	}
+
+	if (savefid != currfid) {
+		printk(KERN_ERR PFX "ph3: failed, currfid changed 0x%x\n",
+		       currfid);
+		return 1;
+	}
+
+	printk(KERN_DEBUG PFX "ph3: complete, currfid 0x%x, currvid 0x%x\n",
+	       currfid, currvid);
+#endif
+
+	return 0;
+}
+
+/* Take a frequency, and issue the fid/vid transition command */
+static inline int
+transition_frequency(u32 * preq, u32 * pmin, u32 * pmax, u32 searchup)
+{
+	u32 fid;
+	u32 vid;
+	int res;
+	struct cpufreq_freqs freqs;
+
+	if (find_match(preq, pmin, pmax, searchup, &fid, &vid)) {
+		return 1;
+	}
+	dprintk(KERN_DEBUG PFX "table matched fid 0x%x, giving vid 0x%x\n", fid,
+		vid);
+
+	if (query_current_values_with_pending_wait()) {
+		return 1;
+	}
+
+	if ((currvid == vid) && (currfid == fid)) {
+		dprintk(KERN_DEBUG PFX
+			"target matches current values (fid 0x%x, vid 0x%x)\n",
+			fid, vid);
+		return 0;
+	}
+
+	if ((fid < HI_FID_TABLE_BOTTOM) && (currfid < HI_FID_TABLE_BOTTOM)) {
+		printk(KERN_ERR PFX
+		       "ignoring illegal change in lo freq table-%x to %x\n",
+		       currfid, fid);
+		return 1;
+	}
+
+	lprintk(KERN_DEBUG PFX "changing to fid 0x%x (%s), vid 0x%x (%s)\n",
+		fid, fid_name(fid), vid, vid_name(vid));
+
+	/* WARNING - the cpufreq calls end up doing nothing in a SMP kernel.       */
+	/* This code will not work too well in such a kernel. This module protects */
+	/* itself from being compiled ifdef CONFIG_SMP.                            */
+
+	freqs.cpu = 0;		/* only tru because SMP not supported */
+
+	freqs.old = find_freq_from_fid(currfid);
+	freqs.new = find_freq_from_fid(fid);
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	res = transition_fid_vid(fid, vid);
+
+	freqs.new = find_freq_from_fid(currfid);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return res;
+}
+
+static inline int
+check_supported_cpu(void)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	u32 eax, ebx, ecx, edx;
+
+	if (num_online_cpus() != 1) {
+		printk(KERN_ERR PFX "multiprocessor systems not currently supported\n");
+		return 0;
+	}
+
+	if (c->x86_vendor != X86_VENDOR_AMD) {
+		printk(KERN_INFO PFX "Not an AMD processor\n");
+		return 0;
+	}
+
+	eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
+	if ((eax & CPUID_XFAM_MOD) == ATHLON64_XFAM_MOD) {
+		dprintk(KERN_DEBUG PFX "AMD Althon 64 Processor found\n");
+		if ((eax & CPUID_F1_STEP) < ATHLON64_REV_C0) {
+			printk(KERN_ERR PFX "Revision C0 or better AMD Athlon 64 processor required\n");
+			return 0;
+		}
+	} else if ((eax & CPUID_XFAM_MOD) == OPTERON_XFAM_MOD) {
+		dprintk(KERN_DEBUG PFX "AMD Opteron Processor found\n");
+	} else {
+		printk(KERN_ERR PFX "AMD Athlon 64 or AMD Opteron processor required\n");
+		return 0;
+	}
+
+	eax = cpuid_eax(CPUID_GET_MAX_CAPABILITIES);
+	if (eax < CPUID_FREQ_VOLT_CAPABILITIES) {
+		printk(KERN_INFO PFX "No frequency change capabilities detected\n");
+		return 0;
+	}
+
+	cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
+	if ((edx & P_STATE_TRANSITION_CAPABLE) != P_STATE_TRANSITION_CAPABLE) {
+		printk(KERN_INFO PFX "Power state transitions not supported\n");
+		return 0;
+	}
+
+	printk(KERN_INFO PFX "Found AMD Athlon 64 / Opteron processor supporting p-state transitions\n");
+	return 1;
+}
+
+/* Converts a frequency (that might not necessarily be a multiple of 200) to a fid */
+u32
+find_closest_fid(u32 freq, int searchup)
+{
+	if (searchup == SEARCH_UP) {
+		freq += MIN_FREQ_RESOLUTION - 1;
+	}
+	freq = (freq / MIN_FREQ_RESOLUTION) * MIN_FREQ_RESOLUTION;
+
+	if (freq < MIN_FREQ) {
+		freq = MIN_FREQ;
+	} else if (freq > MAX_FREQ) {
+		freq = MAX_FREQ;
+	}
+
+	return find_fid_from_freq(freq);
+}
+
+/* Takes a target freq and a range, and finds a suitable freq and range to match */
+static int
+find_match(u32 * ptargfreq, u32 * pmin, u32 * pmax, int searchup, u32 * pfid,
+	   u32 * pvid)
+{
+	u32 availpstates = onbattery ? batterypstates : numpstates;
+	u32 targfid = find_closest_fid(*ptargfreq, searchup);
+	u32 minfid = find_closest_fid(*pmin, SEARCH_DOWN);
+	u32 maxfid = find_closest_fid(*pmax, SEARCH_UP);
+	u32 minidx = 0;
+	u32 maxidx = availpstates - 1;
+	u32 targidx = 0xffffffff;
+	int i;
+
+	dprintk(KERN_DEBUG PFX "find match: freq %d MHz, min %d, max %d\n",
+		*ptargfreq, *pmin, *pmax);
+
+	/* Restrict values to the frequency choices in the PST */
+	if (minfid < ppst[0].fid)
+		minfid = ppst[0].fid;
+	if (maxfid > ppst[maxidx].fid)
+		maxfid = ppst[maxidx].fid;
+
+	/* Find appropriate PST index for the minimim fid */
+	for (i = 0; i < (int) availpstates; i++) {
+		if (minfid >= ppst[i].fid)
+			minidx = i;
+	}
+
+	/* Find appropriate PST index for the maximum fid */
+	for (i = availpstates - 1; i >= 0; i--) {
+		if (maxfid <= ppst[i].fid)
+			maxidx = i;
+	}
+
+	if (minidx > maxidx)
+		maxidx = minidx;
+
+	/* Frequency ids are now constrained by limits matching PST entries */
+	minfid = ppst[minidx].fid;
+	maxfid = ppst[maxidx].fid;
+
+	/* Limit the target frequency to these limits */
+	if (targfid < minfid)
+		targfid = minfid;
+	else if (targfid > maxfid)
+		targfid = maxfid;
+
+	/* Find the best target index into the PST, contrained by the range */
+	if (searchup == SEARCH_UP) {
+		for (i = maxidx; i >= (int) minidx; i--) {
+			if (targfid <= ppst[i].fid)
+				targidx = i;
+		}
+	} else {
+		for (i = minidx; i <= (int) maxidx; i++) {
+			if (targfid >= ppst[i].fid)
+				targidx = i;
+		}
+	}
+
+	if (targidx == 0xffffffff) {
+		printk(KERN_ERR PFX "could not find target\n");
+		return 1;
+	}
+
+	*pmin = find_freq_from_fid(minfid);
+	*pmax = find_freq_from_fid(maxfid);
+	*ptargfreq = find_freq_from_fid(ppst[targidx].fid);
+
+	if (pfid)
+		*pfid = ppst[targidx].fid;
+	if (pvid)
+		*pvid = ppst[targidx].vid;
+
+	return 0;
+}
+
+/* Find and validate the PSB/PST table in BIOS. */
+static inline int
+find_psb_table(void)
+{
+	struct psb_s *psb;
+	struct pst_s *pst;
+	unsigned i, j;
+	u32 lastfid;
+	u32 mvs;
+	u8 maxvid;
+
+	for (i = 0xc0000; i < 0xffff0; i += 0x10) {	/* Scan BIOS looking for the signature.    */
+		/* It can not be at ffff0 - it is too big. */
+
+		psb = phys_to_virt(i);
+		if (memcmp(psb, PSB_ID_STRING, PSB_ID_STRING_LEN) == 0) {
+
+			lprintk(KERN_DEBUG PFX "found PSB header at 0x%p\n", psb);
+
+			tprintk(KERN_DEBUG PFX "table version: 0x%x\n",
+				psb->tableversion);
+			if (psb->tableversion != PSB_VERSION_1_4) {
+				printk(KERN_INFO PFX
+				       "BIOS error - PSB table is not v1.4\n");
+				return -ENODEV;
+			}
+
+			tprintk(KERN_DEBUG PFX "flags: 0x%x\n", psb->flags1);
+			if (psb->flags1) {
+				printk(KERN_ERR PFX
+				       "BIOS error - unknown flags\n");
+				return -ENODEV;
+			}
+
+			vstable = psb->voltagestabilizationtime;
+			printk(KERN_INFO PFX "voltage stabilization time: %d (units 20us)\n", vstable);
+
+			dprintk(KERN_DEBUG PFX "flags2: 0x%x\n", psb->flags2);
+			rvo = psb->flags2 & 3;
+			irt = ((psb->flags2) >> 2) & 3;
+			mvs = ((psb->flags2) >> 4) & 3;
+			vidmvs = 1 << mvs;
+			batterypstates = ((psb->flags2) >> 6) & 3;
+			printk(KERN_INFO PFX "p states on battery: %d ",
+			       batterypstates);
+			switch (batterypstates) {
+			case 0:
+				printk("- all available\n");
+				break;
+			case 1:
+				printk("- only the minimum\n");
+				break;
+			case 2:
+				printk("- only the 2 lowest\n");
+				break;
+			case 3:
+				printk("- only the 3 lowest\n");
+				break;
+			}
+			printk(KERN_INFO PFX "ramp voltage offset: %d\n", rvo);
+			printk(KERN_INFO PFX "isochronous relief time: %d\n",
+			       irt);
+			printk(KERN_INFO PFX
+			       "maximum voltage step: %d - 0x%x\n", mvs,
+			       vidmvs);
+
+			tprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
+			/* This is the number of PSBs that we might find 
+			*  when we dig around in BIOS. On Athlon 64 / Opteron, 
+			*  it must be 1. The Athlon processor allowed for more
+			*  than 1, and the driver would have to figure out 
+			*  which one of the n was the correct one for the 
+			*  processor.           */
+			if (psb->numpst != 1) {
+				printk(KERN_ERR PFX
+				       "BIOS error - numpst must be 1\n");
+				return -ENODEV;
+			}
+
+			dprintk(KERN_DEBUG PFX "cpuid: 0x%x\n", psb->cpuid);
+
+			plllock = psb->plllocktime;
+			printk(KERN_INFO PFX "plllocktime: 0x%x (units 1us)\n",
+			       psb->plllocktime);
+
+			printk(KERN_INFO PFX "maxfid: 0x%x\n", psb->maxfid);
+			printk(KERN_INFO PFX "maxvid: 0x%x\n", psb->maxvid);
+			maxvid = psb->maxvid;
+
+			numpstates = psb->numpstates;
+			printk(KERN_INFO PFX "numpstates: 0x%x\n", numpstates);
+			if (numpstates < 2) {
+				printk(KERN_ERR PFX
+				       "BIOS error - no p states to transition\n");
+				return -ENODEV;
+			}
+
+			if (batterypstates == 0) {	/* all available */
+				batterypstates = numpstates;
+			} else if (batterypstates > numpstates) {
+				printk(KERN_ERR PFX
+				       "batterypstates > numpstates\n");
+				batterypstates = numpstates;
+			} else {
+				printk(KERN_ERR PFX
+				       "Restricting operation to %d p-states\n",
+				       batterypstates);
+				printk(KERN_ERR PFX
+				       "Check for an updated driver to access all %d p-states\n",
+				       numpstates);
+			}
+
+			if ((numpstates <= 1) || (batterypstates <= 1)) {
+				printk(KERN_ERR PFX
+				       "only 1 p-state, nothing to transition\n");
+				return -ENODEV;
+			}
+
+			ppst =
+			    kmalloc(sizeof (struct pst_s) * numpstates,
+				    GFP_KERNEL);
+			if (!ppst) {
+				printk(KERN_ERR PFX
+				       "ppst memory alloc failure\n");
+				return -ENOMEM;
+			}
+
+			pst = (struct pst *) (psb + 1);
+			for (j = 0; j < numpstates; j++) {
+				ppst[j].fid = pst[j].fid;
+				ppst[j].vid = pst[j].vid;
+				printk(KERN_INFO PFX
+				       "   %d : fid 0x%x, vid 0x%x\n", j,
+				       ppst[j].fid, ppst[j].vid);
+			}
+			sort_pst(ppst, numpstates);
+
+			lastfid = ppst[0].fid;
+			if (lastfid > LO_FID_TABLE_TOP) {
+				printk(KERN_INFO PFX
+				       "first fid not from lo freq table\n");
+			}
+			if ((lastfid > MAX_FID) || (lastfid & 1)
+			    || (ppst[0].vid > LEAST_VID)) {
+				printk(KERN_ERR PFX
+				       "first fid/vid invalid (0x%x - 0x%x)\n",
+				       lastfid, ppst[0].vid);
+				kfree(ppst);
+				ppst = 0;
+				return -ENODEV;
+			}
+
+			for (j = 1; j < numpstates; j++) {
+				if ((lastfid >= ppst[j].fid)
+				    || (ppst[j].fid & 1)
+				    || (ppst[j].fid < HI_FID_TABLE_BOTTOM)
+				    || (ppst[j].fid > MAX_FID)
+				    || (ppst[j].vid > LEAST_VID)) {
+					printk(KERN_ERR PFX
+					       "BIOS error - invalid fid/vid in pst(%x %x)\n",
+					       ppst[j].fid, ppst[j].vid);
+					kfree(ppst);
+					ppst = 0;
+					return -ENODEV;
+				}
+				lastfid = ppst[j].fid;
+			}
+
+			for (j = 0; j < numpstates; j++) {
+				if (ppst[j].vid < rvo) {	/* vid + rvo >= 0 */
+					printk(KERN_ERR PFX
+					       "BIOS error - 0 vid exceeded with pstate %d\n",
+					       j);
+					return -ENODEV;
+				}
+				if (ppst[j].vid < maxvid + rvo) {	/* vid + rvo >= maxvid */
+					printk(KERN_ERR PFX
+					       "BIOS error - maxvid exceeded with pstate %d\n",
+					       j);
+					return -ENODEV;
+				}
+			}
+
+			if (query_current_values_with_pending_wait()) {
+				kfree(ppst);
+				ppst = 0;
+				return 1;
+			}
+			printk(KERN_INFO PFX "currfid 0x%x, currvid 0x%x\n",
+			       currfid, currvid);
+
+			for (j = 0; j < numpstates; j++) {
+				if ((ppst[j].fid == currfid)
+				    && (ppst[j].vid == currvid)) {
+					return (0);
+				}
+			}
+
+			printk(KERN_ERR PFX "BIOS error, currfid/vid do not match PST, ignoring\n");
+			return 0;
+		}
+	}
+
+	printk(KERN_ERR PFX "BIOS error - no PSB\n");
+	return -ENODEV;
+}
+
+/* Driver entry point to switch to the target frequency */
+static int
+drv_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
+{
+	u32 checkfid = currfid;
+	u32 checkvid = currvid;
+	u32 reqfreq = targfreq / 1000;
+	u32 minfreq = pol->min / 1000;
+	u32 maxfreq = pol->max / 1000;
+
+	if (ppst == 0) {
+		printk(KERN_ERR PFX "targ: ppst 0\n");
+		return -ENODEV;
+	}
+
+	if (pending_bit_stuck()) {
+		printk(KERN_ERR PFX
+		       "failing drv targ, change pending bit set\n");
+		return -EIO;
+	}
+
+	dprintk(KERN_DEBUG PFX "targ: %d kHz, min %d, max %d, relation %d\n",
+		targfreq, pol->min, pol->max, relation);
+
+	if (query_current_values_with_pending_wait()) {
+		return -EIO;
+	}
+	lprintk(KERN_DEBUG PFX "targ: curr fid 0x%x (%s), vid 0x%x (%s)\n",
+		currfid, fid_name(currfid), currvid, vid_name(currvid));
+
+	if ((checkvid != currvid) || (checkfid != currfid)) {
+		printk(KERN_ERR PFX
+		       "error - out of sync, fid 0x%x 0x%x, vid 0x%x 0x%x\n",
+		       checkfid, currfid, checkvid, currvid);
+	}
+
+	if (transition_frequency(&reqfreq, &minfreq, &maxfreq,
+				 relation ==
+				 CPUFREQ_RELATION_H ? SEARCH_UP : SEARCH_DOWN))
+	{
+		printk(KERN_ERR PFX "transition frequency failed\n");
+		return -EIO;
+	}
+
+	pol->cur = 1000 * find_freq_from_fid(currfid);
+
+#ifdef DEBUG
+	if (pol->min != minfreq * 1000) {
+		printk(KERN_ERR PFX
+		       "discrepency on min : %d policy, %d actual\n", pol->min,
+		       minfreq);
+	}
+
+	if (pol->max != maxfreq * 1000) {
+		printk(KERN_ERR PFX
+		       "discrepency on max : %d policy, %d actual\n", pol->max,
+		       maxfreq);
+	}
+
+	if (targfreq != pol->cur) {
+		printk(KERN_ERR PFX
+		       "discrepency on curr : %d policy, %d actual\n", pol->cur,
+		       targfreq);
+	}
+#endif
+
+	return 0;
+}
+
+/* Driver entry point to verify the policy and range of frequencies */
+static int
+drv_verify(struct cpufreq_policy *pol)
+{
+	u32 min = pol->min / 1000;
+	u32 max = pol->max / 1000;
+	u32 targ = min;
+	int res;
+
+	if (ppst == 0) {
+		printk(KERN_ERR PFX "verify - ppst 0\n");
+		return -ENODEV;
+	}
+
+	if (pending_bit_stuck()) {
+		printk(KERN_ERR PFX "failing verify, change pending bit set\n");
+		return -EIO;
+	}
+
+	dprintk(KERN_DEBUG PFX
+		"ver: cpu%d, min %d, max %d, cur %d, pol %d (%s)\n", pol->cpu,
+		pol->min, pol->max, pol->cur, pol->policy,
+		pol->policy ==
+		CPUFREQ_POLICY_POWERSAVE ? "psave" : pol->policy ==
+		CPUFREQ_POLICY_PERFORMANCE ? "perf" : "unk");
+
+	if (pol->cpu != 0) {
+		printk(KERN_ERR PFX "verify - cpu not 0\n");
+		return -ENODEV;
+	}
+
+	res = find_match(&targ, &min, &max,
+			 pol->policy ==
+			 CPUFREQ_POLICY_POWERSAVE ? SEARCH_DOWN : SEARCH_UP, 0,
+			 0);
+	if (!res) {
+		pol->min = min * 1000;
+		pol->max = max * 1000;
+	}
+	return res;
+}
+
+/* per CPU init entry point to the driver */
+static int __init
+drv_cpu_init(struct cpufreq_policy *pol)
+{
+	if (pol->cpu != 0) {
+		printk(KERN_ERR PFX "init - cpu 0\n");
+		return -ENODEV;
+	}
+
+	pol->policy = CPUFREQ_POLICY_PERFORMANCE;	/* boot as fast as we can */
+
+	/* Take a crude guess here. 8 vid transitions plus 3 fid
+	 * transitions seems reasonable. */
+	pol->cpuinfo.transition_latency = ((rvo + 8) * vstable * VST_UNITS_20US)
+	    + (3 * (1 << irt) * 10);
+
+	if (query_current_values_with_pending_wait())
+		return -EIO;
+
+	pol->cur = 1000 * find_freq_from_fid(currfid);
+	dprintk(KERN_DEBUG PFX "policy current frequency %d kHz\n", pol->cur);
+
+	/* min/max the cpu is capable of */
+	pol->cpuinfo.min_freq = 1000 * find_freq_from_fid(ppst[0].fid);
+	pol->cpuinfo.max_freq =
+	    1000 * find_freq_from_fid(ppst[numpstates - 1].fid);
+
+	pol->min = 1000 * find_freq_from_fid(ppst[0].fid);
+	if (onbattery) {	/* remove test when battery a/c detection done */
+		pol->max =
+		    1000 * find_freq_from_fid(ppst[batterypstates - 1].fid);
+	} else {
+		pol->max = 1000 * find_freq_from_fid(ppst[numpstates - 1].fid);
+	}
+
+#ifdef LOG_CHANGES
+	printk(KERN_INFO PFX
+	       "cpu_init done, current fid 0x%x (%s), vid 0x%x (%s)\n", currfid,
+	       fid_name(currfid), currvid, vid_name(currvid));
+#else
+	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
+	       currfid, currvid);
+#endif
+	return 0;
+}
+
+/* driver entry point for init */
+static int __init
+drv_init(void)
+{
+	int rc;
+
+	printk(KERN_INFO PFX VERSION "\n");
+
+	if (check_supported_cpu() == 0) {
+		return -ENODEV;
+	}
+
+	rc = find_psb_table();
+	if (rc) {
+		return rc;
+	}
+
+	chipset_force_pm();
+	if (pending_bit_stuck()) {
+		printk(KERN_ERR PFX "failing driver init, change pending bit set\n");
+		kfree(ppst);
+		ppst = 0;
+		return -EIO;
+	}
+	return cpufreq_register_driver(&cpufreq_amd64_driver);
+}
+
+/* driver entry point for term */
+static void __exit
+drv_exit(void)
+{
+	dprintk(KERN_INFO PFX "drv_exit\n");
+
+	cpufreq_unregister_driver(&cpufreq_amd64_driver);
+	if (ppst) {
+		kfree(ppst);
+		ppst = 0;
+	}
+	return;
+}
+
+MODULE_AUTHOR("Paul Devriendt <paul.devriendt@amd.com>");
+MODULE_DESCRIPTION("AMD Athlon 64 and Opteron processor frequency driver.");
+MODULE_LICENSE("GPL");
+
+module_init(drv_init);
+module_exit(drv_exit);
--- /usr/src/tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2003-08-22 14:58:24.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2003-08-22 14:58:43.000000000 +0200
@@ -0,0 +1,164 @@
+/*
+ *   (c) 2003 Advanced Micro Devices, Inc.
+ *  Your use of this code is subject to the terms
+ *  and conditions of the GNU general public license
+ *  found in the "../../../COPYING" file that is
+ *  included with this file and posted at
+ *  http://www.gnu.org/licenses/gpl.html
+ */
+
+/* processor's cpuid instruction support */
+#define CPUID_PROCESSOR_SIGNATURE             1	/* function 1 */
+#define CPUID_F1_FAM                 0x00000f00	/* family mask */
+#define CPUID_F1_XFAM                0x0ff00000	/* extended family mask */
+#define CPUID_F1_MOD                 0x000000f0	/* model mask */
+#define CPUID_F1_STEP                0x0000000f	/* stepping level mask */
+#define CPUID_XFAM_MOD               0x0ff00ff0	/* extended family, family + model */
+#define ATHLON64_XFAM_MOD            0x00000f40	/* extended family, family + model */
+#define OPTERON_XFAM_MOD             0x00000f50	/* extended family, family + model */
+#define ATHLON64_REV_C0                       8
+#define CPUID_GET_MAX_CAPABILITIES   0x80000000
+#define CPUID_FREQ_VOLT_CAPABILITIES 0x80000007
+#define P_STATE_TRANSITION_CAPABLE            6
+
+/* Model Specific Registers for p-state transitions. MSRs are 64-bit. For     */
+/* writes (wrmsr - opcode 0f 30), the register number is placed in ecx, and   */
+/* the value to write is placed in edx:eax. For reads (rdmsr - opcode 0f 32), */
+/* the register number is placed in ecx, and the data is returned in edx:eax. */
+
+#define MSR_FIDVID_CTL      0xc0010041
+#define MSR_FIDVID_STATUS   0xc0010042
+
+/* Field definitions within the FID VID Low Control MSR : */
+#define MSR_C_LO_INIT_FID_VID     0x00010000
+#define MSR_C_LO_NEW_VID          0x00001f00
+#define MSR_C_LO_NEW_FID          0x0000002f
+#define MSR_C_LO_VID_SHIFT        8
+
+/* Field definitions within the FID VID High Control MSR : */
+#define MSR_C_HI_STP_GNT_TO       0x000fffff
+
+/* Field definitions within the FID VID Low Status MSR : */
+#define MSR_S_LO_CHANGE_PENDING   0x80000000	/* cleared when completed */
+#define MSR_S_LO_MAX_RAMP_VID     0x1f000000
+#define MSR_S_LO_MAX_FID          0x003f0000
+#define MSR_S_LO_START_FID        0x00003f00
+#define MSR_S_LO_CURRENT_FID      0x0000003f
+
+/* Field definitions within the FID VID High Status MSR : */
+#define MSR_S_HI_MAX_WORKING_VID  0x001f0000
+#define MSR_S_HI_START_VID        0x00001f00
+#define MSR_S_HI_CURRENT_VID      0x0000001f
+
+/* fids (frequency identifiers) are arranged in 2 tables - lo and hi freq tables */
+#define LO_FID_TABLE_TOP     6	/* fid values marking the boundary between */
+#define HI_FID_TABLE_BOTTOM  8	/*                the low and high tables. */
+
+#define LO_VCOFREQ_TABLE_TOP    1400	/* corresponding vco frequency values */
+#define HI_VCOFREQ_TABLE_BOTTOM 1600
+
+#define MIN_FREQ_RESOLUTION  200	/* fids jump by 2 matching freq jumps by 200 */
+
+#define MAX_FID 0x2a		/* Spec only gives FID values as far as 5 GHz */
+
+#define LEAST_VID 0x1e		/* Lowest (numerically highest) useful vid value */
+
+#define MIN_FREQ 800		/* Min and max freqs, per spec */
+#define MAX_FREQ 5000
+
+#define INVALID_FID_MASK 0xffffffc1	/* not a valid fid if these bits are set */
+
+#define INVALID_VID_MASK 0xffffffe0	/* not a valid vid if these bits are set */
+
+#define STOP_GRANT_5NS 1	/* minimum possible memory access latency on a voltage change */
+
+#define PLL_LOCK_CONVERSION (1000/5)	/* Convert ms to ns, then divide by clock period */
+
+#define MAXIMUM_VID_STEPS 1	/* Current processors only allow a single step of 25mV */
+
+#define VST_UNITS_20US 20	/* Voltage Stabalization Time is in units of 20us */
+
+/* Version 1.4 of the PSB table. This table is constructed by BIOS and is    
+* to tell the OS's power management driver which VIDs and FIDs are          
+* supported by this particular processor. This information is obtained from 
+* the data sheets for each processor model by the system vendor and         
+* incorporated into the BIOS.                                               
+* If the data in the PSB / PST is wrong, then this driver will program the  
+* wrong values into hardware, which is very likely to lead to a crash.      */
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
+
+#ifdef LOG_CHANGES
+#define lprintk(msg...) printk(msg)
+#else
+#define lprintk(msg...) do { } while(0)
+#endif
+
+#ifdef DEBUG
+#define dprintk(msg...) printk(msg)
+#else
+#define dprintk(msg...) do { } while(0)
+#endif
+
+#ifdef TRACE
+#define tprintk(msg...) printk(msg)
+#else
+#define tprintk(msg...) do { } while(0)
+#endif
+
+/* Attempt to force the BIOS to enable power management in the chipset if 
+ * it has not already done so. At least 1 BIOS is delaying the enablement 
+ * until ACPI init, which never happens without an ACPI enabled Linux 
+ * kernel. This can be regarded as a BIOS bug, but that is of little help 
+ * when you are facing the situation. Do not enable this code unless you 
+ * are sure as to what you are doing.                            */
+#ifdef CHIPSET_HACK
+#define chipset_force_pm() do {                                                          \
+        unsigned val;                                                                    \
+        unsigned port = 0x1010;                                                          \
+        val = inw( port );                                                               \
+        printk( KERN_INFO PFX "power management enable port 0x%x = 0x%x\n", port, val ); \
+        val |= 0x300;                                                                    \
+        outw( val, port );                                                               \
+        udelay( 200 );                                                                   \
+        val = inw( port );                                                               \
+        printk( KERN_INFO PFX "port 0x%x modified to 0x%x\n", port, val );               \
+        } while(0)
+#else
+#define chipset_force_pm() do { } while(0)
+#endif
+
+#ifdef TRACE
+#define chipset_force_pm() do {                                                          \
+        unsigned val;                                                                    \
+        unsigned port = 0x1010;                                                          \
+        val = inw( port );                                                               \
+        printk( KERN_INFO PFX "power management enable port 0x%x = 0x%x\n", port, val ); \
+        } while(0)
+#else
+#define chipset_force_pm() do { } while(0)
+#endif
+

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
