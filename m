Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUCEN0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 08:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUCEN0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 08:26:39 -0500
Received: from gprs40-161.eurotel.cz ([160.218.40.161]:32973 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262589AbUCENYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 08:24:01 -0500
Date: Fri, 5 Mar 2004 14:22:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
       davej@redhat.com, cpufreq@www.linux.org.uk
Subject: Share more code between pn-k8 and pn-k8-acpi
Message-ID: <20040305132257.GA7126@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I added struct percpu to powernow-k8 driver, too, and now a lot more
code can be easily shared between pn-k8 and pn-k8-acpi drivers. There
are about 100 more lines of duplicated code, but those are not so easy
to deal with. Rest of driver is reading tables etc, and seems unique
to each driver. Plus acpi one includes "ac-power-poller".
								Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-05 14:08:28.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-05 14:04:37.000000000 +0100
@@ -37,34 +37,11 @@
 #include <asm/delay.h>
 
 #define PFX "powernow-k8-acpi: "
-#define DFX KERN_DEBUG PFX
-#define IFX KERN_INFO  PFX
-#define EFX KERN_ERR   PFX
 
 #undef DEBUG
 #define VERSION "Version 1.20.02a"
 #include "powernow-k8.h"
 
-struct pstate {    /* info on each performance state, per processor */
-	u16 freq;  /* frequency is in megahertz */
-	u8 fid;
-	u8 vid;
-	u8 irt;
-	u8 rvo;
-	u8 plllock;
-	u8 vidmvs;
-	u8 vstable;
-	u8 pad1;
-	u16 pad2;
-};
-
-struct cpu_power {
-	int numps;
-	int cvid;
-	int cfid;
-	struct pstate pst[0];
-};
-
 /*
  * Each processor may have
  * a different number of entries in its array. I.e., processor 0 may have
@@ -139,23 +116,6 @@
 	return (freq - 800) / 100;
 }
 
-static int query_current_values_with_pending_wait(struct cpu_power *perproc)
-{
-	u32 lo = MSR_S_LO_CHANGE_PENDING;
-	u32 hi;
-	u32 i = 0;
-
-	while (lo & MSR_S_LO_CHANGE_PENDING) {
-		if (i++ > 0x1000000) {
-			printk(EFX "change pending stuck\n");
-			return 1;
-		}
-		rdmsr(MSR_FIDVID_STAT, lo, hi);
-	}
-	perproc->cvid = hi & MSR_S_HI_CURRENT_VID;
-	perproc->cfid = lo & MSR_S_LO_CURRENT_FID;
-	return 0;
-}
 
 /* need to init the control msr to a safe value (for each cpu) */
 static void fidvid_msr_init(void)
@@ -213,36 +173,6 @@
 	return 0;
 }
 
-static int write_new_vid(struct cpu_power *perproc, u8 vid)
-{
-	u32 lo;
-	u8 savefid = perproc->cfid;
-
-	if ((savefid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
-		printk(EFX "overflow on vid write\n");
-		return 1;
-	}
-
-	lo = perproc->cfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
-	dprintk(DFX "cpu%d, writing vid %x, lo %x, hi %x\n",
-		smp_processor_id(), vid, lo, STOP_GRANT_5NS);
-	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
-	if (query_current_values_with_pending_wait(perproc))
-		return 1;
-
-	if (savefid != perproc->cfid) {
-		printk(EFX "fid change on vid trans, old %x new %x\n",
-		       savefid, perproc->cfid);
-		return 1;
-	}
-	if (vid != perproc->cvid) {
-		printk(EFX "vid trans failed, vid %x, cvid %x\n",
-		       vid, perproc->cfid);
-		return 1;
-	}
-	return 0;
-}
-
 static int decrease_vid_code_by_step(struct cpu_power *perproc, u32 idx, u8 reqvid, u8 step)
 {
 	struct pstate *pst;
@@ -309,144 +239,6 @@
 	return 0;
 }
 
-static inline int core_frequency_transition(struct cpu_power *perproc, u32 idx, u8 reqfid)
-{
-	u8 vcoreqfid;
-	u8 vcocurrfid;
-	u8 vcofiddiff;
-	u8 savevid = perproc->cvid;
-
-	if ((reqfid < HI_FID_TABLE_BOTTOM)
-	    && (perproc->cfid < HI_FID_TABLE_BOTTOM)) {
-		printk(EFX "ph2 illegal lo-lo transition %x %x\n",
-		       reqfid, perproc->cfid);
-		return 1;
-	}
-
-	if (perproc->cfid == reqfid) {
-		printk(EFX "ph2 null fid transition %x\n", reqfid );
-		return 0;
-	}
-
-	dprintk(DFX "ph2 start%d, cfid %x, cvid %x, rfid %x\n",
-		smp_processor_id(),
-		perproc->cfid, perproc->cvid, reqfid);
-
-	vcoreqfid = convert_fid_to_vfid(reqfid);
-	vcocurrfid = convert_fid_to_vfid(perproc->cfid);
-	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
-						: vcoreqfid - vcocurrfid;
-
-	while (vcofiddiff > FSTEP) {
-		if (reqfid > perproc->cfid) {
-			if (perproc->cfid > LO_FID_TABLE_TOP) {
-				if (write_new_fid(perproc, idx,
-						  perproc->cfid + FSTEP))
-					return 1;
-			} else {
-				if (write_new_fid(perproc, idx, FSTEP +
-				     convert_fid_to_vfid(perproc->cfid)))
-					return 1;
-			}
-		} else {
-			if (write_new_fid(perproc, idx,
-					  perproc->cfid-FSTEP))
-				return 1;
-		}
-
-		vcocurrfid = convert_fid_to_vfid(perproc->cfid);
-		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
-						    : vcoreqfid - vcocurrfid;
-	}
-	if (write_new_fid(perproc, idx, reqfid))
-		return 1;
-	if (query_current_values_with_pending_wait(perproc))
-		return 1;
-
-	if (perproc->cfid != reqfid) {
-		printk(EFX "ph2 mismatch, failed transn, curr %x, req %x\n",
-		       perproc->cfid, reqfid);
-		return 1;
-	}
-
-	if (savevid != perproc->cvid) {
-		printk(EFX "ph2 vid changed, save %x, curr %x\n", savevid,
-		       perproc->cvid);
-		return 1;
-	}
-
-	dprintk(DFX "ph2 complete%d, currfid 0x%x, currvid 0x%x\n",
-		smp_processor_id(),
-		perproc->cfid, perproc->cvid);
-	return 0;
-}
-
-static inline int core_voltage_post_transition(struct cpu_power *perproc, u32 idx, u8 reqvid)
-{
-	u8 savefid = perproc->cfid;
-	u8 savereqvid = reqvid;
-
-	dprintk(DFX "ph3 starting%d, cfid 0x%x, cvid 0x%x\n",
-		smp_processor_id(),
-		perproc->cfid, perproc->cvid);
-
-	if (reqvid != perproc->cvid) {
-		if (write_new_vid(perproc, reqvid))
-			return 1;
-
-		if (savefid != perproc->cfid) {
-			printk(EFX "ph3: bad fid change, save %x, curr %x\n",
-			       savefid, perproc->cfid);
-			return 1;
-		}
-
-		if (perproc->cvid != reqvid) {
-			printk(EFX "ph3: failed vid trans\n, req %x, curr %x",
-			       reqvid, perproc->cvid);
-			return 1;
-		}
-	}
-	if (query_current_values_with_pending_wait(perproc))
-		return 1;
-
-	if (savereqvid != perproc->cvid) {
-		dprintk(EFX "ph3 failed, currvid 0x%x\n", perproc->cvid);
-		return 1;
-	}
-
-	if (savefid != perproc->cfid) {
-		dprintk(EFX "ph3 failed, currfid changed 0x%x\n",
-			perproc->cfid);
-		return 1;
-	}
-
-	dprintk(DFX "ph3 done%d, cfid 0x%x, cvid 0x%x\n",
-		smp_processor_id(),
-		perproc->cfid, perproc->cvid);
-	return 0;
-}
-
-static inline int transition_fid_vid(struct cpu_power *perproc, u32 idx, u8 rfid, u8 rvid)
-{
-	if (core_voltage_pre_transition(perproc, idx, rvid))
-		return 1;
-	if (core_frequency_transition(perproc, idx, rfid))
-		return 1;
-	if (core_voltage_post_transition(perproc, idx, rvid))
-		return 1;
-	if (query_current_values_with_pending_wait(perproc))
-		return 1;
-	if ((rfid != perproc->cfid) || (rvid != perproc->cvid)) {
-		printk(EFX "failed%d: req %x %x, curr %x %x\n",
-		       smp_processor_id(), rfid, rvid,
-		       perproc->cfid, perproc->cvid);
-		return 1;
-	}
-	dprintk(IFX "transitioned%d: new fid 0x%x, vid 0x%x\n",
-		smp_processor_id(),
-		perproc->cfid, perproc->cvid);
-	return 0;
-}
 
 /* evaluating this object tells us whether we are using mains or battery */
 static inline int process_psr(acpi_handle objh)
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-05 14:08:27.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-05 14:06:43.000000000 +0100
@@ -72,18 +72,15 @@
 	u8 vid;
 };
 
-static inline int core_voltage_pre_transition(u32 reqvid);
-static inline int core_voltage_post_transition(u32 reqvid);
-static inline int core_frequency_transition(u32 reqfid);
-
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
 
@@ -110,103 +107,41 @@
 static u32 batps;	/* limit on the number of p states when on battery */
 			/* - set by BIOS in the PSB/PST                    */
 
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
-		rdmsr(MSR_FIDVID_STAT, lo, hi);
-	}
-	currvid = hi & MSR_S_HI_CURRENT_VID;
-	currfid = lo & MSR_S_LO_CURRENT_FID;
-	return 0;
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
 
-	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
+	lo = fid | (perproc->cvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
 
 	dprintk(KERN_DEBUG PFX "writing fid %x, lo %x, hi %x\n",
 		fid, lo, plllock * PLL_LOCK_CONVERSION);
 
 	wrmsr(MSR_FIDVID_CTL, lo, plllock * PLL_LOCK_CONVERSION);
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
 	count_off_irt(irt);
 
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
-	lo = currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
-
-	dprintk(KERN_DEBUG PFX "writing vid %x, lo %x, hi %x\n",
-		vid, lo, STOP_GRANT_5NS);
-
-	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
-
-	if (query_current_values_with_pending_wait())
-		return 1;
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
 
@@ -221,10 +156,10 @@
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
 
 	count_off_vst(vstable);
@@ -232,198 +167,51 @@
 	return 0;
 }
 
-/* Change the fid and vid, by the 3 phases. */
-static inline int
-transition_fid_vid(u32 reqfid, u32 reqvid)
-{
-	if (core_voltage_pre_transition(reqvid))
-		return 1;
-	if (core_frequency_transition(reqfid))
-		return 1;
-	if (core_voltage_post_transition(reqvid))
-		return 1;
-	if (query_current_values_with_pending_wait())
-		return 1;
-	if ((reqfid != currfid) || (reqvid != currvid)) {
-		printk(KERN_ERR PFX "failed: req 0x%x 0x%x, curr 0x%x 0x%x\n",
-		       reqfid, reqvid, currfid, currvid);
-		return 1;
-	}
-	dprintk(KERN_INFO PFX
-		"transitioned: new fid 0x%x, vid 0x%x\n", currfid, currvid);
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
+	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
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
-	vcoreqfid = convert_fid_to_vfid(reqfid);
-	vcocurrfid = convert_fid_to_vfid(currfid);
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
-				    (2 + convert_fid_to_vfid(currfid))) {
-					return 1;
-				}
-			}
-		} else {
-			if (write_new_fid(currfid - 2))
-				return 1;
-		}
-
-		vcocurrfid = convert_fid_to_vfid(currfid);
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
-		return 1;
-	}
-
-	if (savevid != currvid) {
-		printk(KERN_ERR PFX
-		       "ph2 vid changed, save %x, curr %x\n", savevid,
-		       currvid);
-		return 1;
-	}
-
-	dprintk(KERN_DEBUG PFX "ph2 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
-
-	return 0;
-}
-
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
+	if (savefid != perproc->cfid) {
+		printk(KERN_ERR PFX "ph1 err, perproc->cfid changed 0x%x\n", perproc->cfid);
 		return 1;
 	}
 
-	dprintk(KERN_DEBUG PFX "ph3 complete, currfid 0x%x, currvid 0x%x\n",
-		currfid, currvid);
+	dprintk(KERN_DEBUG PFX "ph1 complete, perproc->cfid 0x%x, perproc->cvid 0x%x\n",
+		perproc->cfid, perproc->cvid);
 
 	return 0;
 }
@@ -433,7 +221,7 @@
 	unsigned int j;
 	u8 lastfid = 0xFF;
 
-	for (j = 0; j < numps; j++) {
+	for (j = 0; j < perproc->numps; j++) {
 		if (pst[j].vid > LEAST_VID) {
 			printk(KERN_ERR PFX "vid %d invalid : 0x%x\n", j, pst[j].vid);
 			return -EINVAL;
@@ -518,9 +306,9 @@
 		printk(", isochronous relief time: %d", irt);
 		printk(", maximum voltage step: %d\n", mvs);
 
-		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
+		dprintk(KERN_DEBUG PFX "perproc->numpst: 0x%x\n", psb->perproc->numpst);
 		if (psb->numpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
+			printk(KERN_ERR BFX "perproc->numpst must be 1\n");
 			return -ENODEV;
 		}
 
@@ -533,26 +321,26 @@
 		printk("maxfid 0x%x (%d MHz), maxvid 0x%x\n", 
 		       psb->maxfid, freq_from_fid(psb->maxfid), maxvid);
 
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
 			       "Use the ACPI driver to access all %d p-states\n",
-			       numps);
+			       perproc->numps);
 		}
 
-		if (numps <= 1) {
+		if (perproc->numps <= 1) {
 			printk(KERN_ERR PFX "only 1 p-state to transition\n");
 			return -ENODEV;
 		}
@@ -561,7 +349,7 @@
 		if (check_pst_table(pst, maxvid))
 			return -EINVAL;
 
-		powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) * (numps + 1)), GFP_KERNEL);
+		powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) * (perproc->numps + 1)), GFP_KERNEL);
 		if (!powernow_table) {
 			printk(KERN_ERR PFX "powernow_table memory alloc failure\n");
 			return -ENOMEM;
@@ -575,7 +363,7 @@
 		/* If you want to override your frequency tables, this
 		   is right place. */
 
-		for (j = 0; j < numps; j++) {
+		for (j = 0; j < perproc->numps; j++) {
 			powernow_table[j].frequency = freq_from_fid(powernow_table[j].index & 0xff)*1000;
 			printk(KERN_INFO PFX "   %d : fid 0x%x (%d MHz), vid 0x%x\n", j,
 			       powernow_table[j].index & 0xff,
@@ -583,22 +371,22 @@
 			       powernow_table[j].index >> 8);
 		}
 
-		powernow_table[numps].frequency = CPUFREQ_TABLE_END;
-		powernow_table[numps].index = 0;
+		powernow_table[perproc->numps].frequency = CPUFREQ_TABLE_END;
+		powernow_table[perproc->numps].index = 0;
 
-		if (query_current_values_with_pending_wait()) {
+		if (query_current_values_with_pending_wait(perproc)) {
 			kfree(powernow_table);
 			return -EIO;
 		}
 
-		printk(KERN_INFO PFX "currfid 0x%x (%d MHz), currvid 0x%x\n",
-		       currfid, freq_from_fid(currfid), currvid);
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
 
@@ -626,20 +414,20 @@
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
 
@@ -647,13 +435,13 @@
 
 	freqs.cpu = 0;	/* only true because SMP not supported */
 
-	freqs.old = freq_from_fid(currfid);
+	freqs.old = freq_from_fid(perproc->cfid);
 	freqs.new = freq_from_fid(fid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
-	res = transition_fid_vid(fid, vid);
+	res = transition_fid_vid(perproc, 0, fid, vid);
 
-	freqs.new = freq_from_fid(currfid);
+	freqs.new = freq_from_fid(perproc->cfid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return res;
@@ -663,8 +451,8 @@
 static int
 powernowk8_target(struct cpufreq_policy *pol, unsigned targfreq, unsigned relation)
 {
-	u32 checkfid = currfid;
-	u32 checkvid = currvid;
+	u32 checkfid = perproc->cfid;
+	u32 checkvid = perproc->cvid;
 	unsigned int newstate;
 
 	if (pending_bit_stuck()) {
@@ -675,16 +463,16 @@
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
@@ -696,7 +484,7 @@
 		return 1;
 	}
 
-	pol->cur = 1000 * freq_from_fid(currfid);
+	pol->cur = 1000 * freq_from_fid(perproc->cfid);
 
 	return 0;
 }
@@ -729,10 +517,10 @@
 	pol->cpuinfo.transition_latency = (((rvo + 8) * vstable * VST_UNITS_20US)
 	    + (3 * (1 << irt) * 10)) * 1000;
 
-	if (query_current_values_with_pending_wait())
+	if (query_current_values_with_pending_wait(perproc))
 		return -EIO;
 
-	pol->cur = 1000 * freq_from_fid(currfid);
+	pol->cur = 1000 * freq_from_fid(perproc->cfid);
 	dprintk(KERN_DEBUG PFX "policy current frequency %d kHz\n", pol->cur);
 
 	/* min/max the cpu is capable of */
@@ -743,7 +531,7 @@
 	}
 
 	printk(KERN_INFO PFX "cpu_init done, current fid 0x%x, vid 0x%x\n",
-	       currfid, currvid);
+	       perproc->cfid, perproc->cvid);
 
 	return 0;
 }
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-05 14:08:28.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-05 14:02:51.000000000 +0100
@@ -71,6 +71,10 @@
 #define dprintk(msg...) do { } while(0)
 #endif
 
+#define DFX KERN_DEBUG PFX
+#define IFX KERN_INFO  PFX
+#define EFX KERN_ERR   PFX
+
 /* Return a frequency in MHz, given an input fid */
 static inline u32 freq_from_fid(u8 fid)
 {
@@ -150,3 +154,221 @@
 	printk(KERN_INFO PFX "Found AMD64 processor (" VERSION ")\n");
 	return 1;
 }
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
+struct cpu_power {
+	int numps;
+	int cvid;
+	int cfid;
+	struct pstate pst[0];
+};
+
+static int write_new_fid(struct cpu_power *perproc, u32 idx, u8 fid);
+static inline int core_voltage_pre_transition(struct cpu_power *perproc, u32 idx, u8 rvid);
+
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
