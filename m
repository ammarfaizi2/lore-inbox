Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUCDXUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUCDXUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:20:23 -0500
Received: from [160.218.40.186] ([160.218.40.186]:25568 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261972AbUCDXSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:18:32 -0500
Date: Fri, 5 Mar 2004 00:16:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: richard.brunner@amd.com
Cc: davej@redhat.com, cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040304231658.GD12988@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C0FD3862D@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0FD3862D@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We stopped paying our lawyers by the number of letters in 
> copyright notices several months ago, so I think it is ok.

:-)))

Here's one more update. It kills "store structure inside array"
hack. It compiles, I'll test it shortly.

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-05 00:08:20.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-05 00:07:26.000000000 +0100
@@ -45,13 +45,6 @@
 #define VERSION "Version 1.20.02a"
 #include "powernow-k8.h"
 
-/* byte offsets into the perproc struct */
-#define PP_OFF_NUMPS  0   /* number of p-states      */
-#define PP_OFF_SHARE  1   /* index of shared control */
-#define PP_OFF_CVID   2   /* current voltage id      */
-#define PP_OFF_CFID   3   /* current frequency id    */
-#define PP_OFF_BYTES  4   /* size in bytes           */   
-
 struct pstate {    /* info on each performance state, per processor */
 	u16 freq;  /* frequency is in megahertz */
 	u8 fid;
@@ -65,11 +58,15 @@
 	u16 pad2;
 };
 
-/* Explanation of the perproc data structures:
- * static u8 **procs; declared in the .c file is an array of pointers to u8.
- * There is one such pointer for each cpu in the system.
- * Each pointer points to 4 u8s (indexed by the PP_OFF constants above),
- * followed by an array of struct pstate, where each processor may have
+struct cpu_power {
+	int numps;
+	int cvid;
+	int cfid;
+	struct pstate pst[0];
+};
+
+/*
+ * Each processor may have
  * a different number of entries in its array. I.e., processor 0 may have
  * 3 pstates, processor 1 may have 5 pstates.
  */
@@ -113,7 +110,7 @@
 static int powernowk8_target(struct cpufreq_policy *p, unsigned t, unsigned r);
 static int __init powernowk8_cpu_init(struct cpufreq_policy *p);
 
-static u8 **procs;                  /* per processor data structure     */
+static struct cpu_power **procs;    /* per processor data structure     */
 static u32 rstps;                   /* pstates allowed restrictions     */
 static u32 seenrst;                 /* remember old bat restrictions    */
 static int pollflg;	            /* remember the state of the poller, protected by poll_sem */
@@ -142,7 +139,7 @@
 	return (freq - 800) / 100;
 }
 
-static int query_current_values_with_pending_wait(u8 *perproc)
+static int query_current_values_with_pending_wait(struct cpu_power *perproc)
 {
 	u32 lo = MSR_S_LO_CHANGE_PENDING;
 	u32 hi;
@@ -155,8 +152,8 @@
 		}
 		rdmsr(MSR_FIDVID_STAT, lo, hi);
 	}
-	perproc[PP_OFF_CVID] = hi & MSR_S_HI_CURRENT_VID;
-	perproc[PP_OFF_CFID] = lo & MSR_S_LO_CURRENT_FID;
+	perproc->cvid = hi & MSR_S_HI_CURRENT_VID;
+	perproc->cfid = lo & MSR_S_LO_CURRENT_FID;
 	return 0;
 }
 
@@ -177,19 +174,18 @@
 	wrmsr(MSR_FIDVID_CTL, lo, hi);
 }
 
-static int write_new_fid(u8 *perproc, u32 idx, u8 fid)
+static int write_new_fid(struct cpu_power *perproc, u32 idx, u8 fid)
 {
 	u32 lo;
 	u32 hi;
 	struct pstate *pst;
-	u8 savevid = perproc[PP_OFF_CVID];
+	u8 savevid = perproc->cvid;
 
-	if (idx >= perproc[PP_OFF_NUMPS]) {
+	if (idx >= perproc->numps) {
 		printk(EFX "idx overflow fid write\n");
 		return 1;
 	}
-	pst = (struct pstate *)(perproc + PP_OFF_BYTES);
-	pst += idx;
+	pst = &perproc->pst[idx];
 
 	if ((fid & INVALID_FID_MASK) || (savevid & INVALID_VID_MASK)) {
 		printk(EFX "overflow on fid write\n");
@@ -204,99 +200,98 @@
 		return 1;
 	count_off_irt(pst->irt);
 
-	if (savevid != perproc[PP_OFF_CVID]) {
+	if (savevid != perproc->cvid) {
 		printk(EFX "vid change on fid trans, old %x, new %x\n",
-		       savevid, perproc[PP_OFF_CVID]);
+		       savevid, perproc->cvid);
 		return 1;
 	}
-	if (perproc[PP_OFF_CFID] != fid) {
+	if (perproc->cfid != fid) {
 		printk(EFX "fid trans failed, targ %x, new %x\n",
-		       fid, perproc[PP_OFF_CFID]);
+		       fid, perproc->cfid);
 		return 1;
 	}
 	return 0;
 }
 
-static int write_new_vid(u8 *perproc, u8 vid)
+static int write_new_vid(struct cpu_power *perproc, u8 vid)
 {
 	u32 lo;
-	u8 savefid = perproc[PP_OFF_CFID];
+	u8 savefid = perproc->cfid;
 
 	if ((savefid & INVALID_FID_MASK) || (vid & INVALID_VID_MASK)) {
 		printk(EFX "overflow on vid write\n");
 		return 1;
 	}
 
-	lo = perproc[PP_OFF_CFID] | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
+	lo = perproc->cfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
 	dprintk(DFX "cpu%d, writing vid %x, lo %x, hi %x\n",
 		smp_processor_id(), vid, lo, STOP_GRANT_5NS);
 	wrmsr(MSR_FIDVID_CTL, lo, STOP_GRANT_5NS);
 	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
-	if (savefid != perproc[PP_OFF_CFID]) {
+	if (savefid != perproc->cfid) {
 		printk(EFX "fid change on vid trans, old %x new %x\n",
-		       savefid, perproc[PP_OFF_CFID]);
+		       savefid, perproc->cfid);
 		return 1;
 	}
-	if (vid != perproc[PP_OFF_CVID]) {
+	if (vid != perproc->cvid) {
 		printk(EFX "vid trans failed, vid %x, cvid %x\n",
-		       vid, perproc[PP_OFF_CFID]);
+		       vid, perproc->cfid);
 		return 1;
 	}
 	return 0;
 }
 
-static int decrease_vid_code_by_step(u8 *perproc, u32 idx, u8 reqvid, u8 step)
+static int decrease_vid_code_by_step(struct cpu_power *perproc, u32 idx, u8 reqvid, u8 step)
 {
 	struct pstate *pst;
 
-	if (idx >= perproc[PP_OFF_NUMPS]) {
+	if (idx >= perproc->numps) {
 		printk(EFX "idx overflow vid step\n");
 		return 1;
 	}
-	pst = (struct pstate *) (perproc + PP_OFF_BYTES);
-	pst += idx;
+	pst = &perproc->pst[idx];
 
 	if (step == 0)  /* BIOS error if this is the case, but continue */
 		step = 1;
 
-	if ((perproc[PP_OFF_CVID] - reqvid) > step)
-		reqvid = perproc[PP_OFF_CVID] - step;
+	if ((perproc->cvid - reqvid) > step)
+		reqvid = perproc->cvid - step;
 	if (write_new_vid(perproc, reqvid))
 		return 1;
 	count_off_vst(pst->vstable);
 	return 0;
 }
 
-static inline int core_voltage_pre_transition(u8 *perproc, u32 idx, u8 rvid)
+static inline int core_voltage_pre_transition(struct cpu_power *perproc, u32 idx, u8 rvid)
 {
 	struct pstate *pst;
 	u8 rvosteps;
-	u8 savefid = perproc[PP_OFF_CFID];
+	u8 savefid = perproc->cfid;
+
+	pst = &perproc->pst[idx];
 
-	pst = (struct pstate *) (perproc + PP_OFF_BYTES);
-	pst += idx;
 	rvosteps = pst->rvo;
 	dprintk(DFX "ph1 start%d, cfid 0x%x, cvid 0x%x, rvid 0x%x, rvo %x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID], rvid, pst->rvo);
+		perproc->cfid, perproc->cvid, rvid, pst->rvo);
 
-	while (perproc[PP_OFF_CVID] > rvid) {
+	while (perproc->cvid > rvid) {
 		dprintk(DFX "ph1 curr %x, req vid %x\n",
-			    perproc[PP_OFF_CVID], rvid);
+			    perproc->cvid, rvid);
 		if (decrease_vid_code_by_step(perproc, idx, rvid, pst->vidmvs))
 			return 1;
 	}
 
 	while (rvosteps) {
-		if (perproc[PP_OFF_CVID] == 0) {
+		if (perproc->cvid == 0) {
 			rvosteps = 0;
 		} else {
 			dprintk(DFX "ph1 changing vid for rvo, req 0x%x\n",
-				perproc[PP_OFF_CVID] - 1);
+				perproc->cvid - 1);
 			if (decrease_vid_code_by_step(perproc, idx,
-						perproc[PP_OFF_CVID] - 1, 1))
+						perproc->cvid - 1, 1))
 				return 1;
 			rvosteps--;
 		}
@@ -304,62 +299,62 @@
 	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
-	if (savefid != perproc[PP_OFF_CFID]) {
-		printk(EFX "ph1 err, cfid changed %x\n", perproc[PP_OFF_CFID]);
+	if (savefid != perproc->cfid) {
+		printk(EFX "ph1 err, cfid changed %x\n", perproc->cfid);
 		return 1;
 	}
 	dprintk(DFX "ph1 done%d, cfid 0x%x, cvid 0x%x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		perproc->cfid, perproc->cvid);
 	return 0;
 }
 
-static inline int core_frequency_transition(u8 * perproc, u32 idx, u8 reqfid)
+static inline int core_frequency_transition(struct cpu_power *perproc, u32 idx, u8 reqfid)
 {
 	u8 vcoreqfid;
 	u8 vcocurrfid;
 	u8 vcofiddiff;
-	u8 savevid = perproc[PP_OFF_CVID];
+	u8 savevid = perproc->cvid;
 
 	if ((reqfid < HI_FID_TABLE_BOTTOM)
-	    && (perproc[PP_OFF_CFID] < HI_FID_TABLE_BOTTOM)) {
+	    && (perproc->cfid < HI_FID_TABLE_BOTTOM)) {
 		printk(EFX "ph2 illegal lo-lo transition %x %x\n",
-		       reqfid, perproc[PP_OFF_CFID]);
+		       reqfid, perproc->cfid);
 		return 1;
 	}
 
-	if (perproc[PP_OFF_CFID] == reqfid) {
+	if (perproc->cfid == reqfid) {
 		printk(EFX "ph2 null fid transition %x\n", reqfid );
 		return 0;
 	}
 
 	dprintk(DFX "ph2 start%d, cfid %x, cvid %x, rfid %x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID], reqfid);
+		perproc->cfid, perproc->cvid, reqfid);
 
 	vcoreqfid = convert_fid_to_vfid(reqfid);
-	vcocurrfid = convert_fid_to_vfid(perproc[PP_OFF_CFID]);
+	vcocurrfid = convert_fid_to_vfid(perproc->cfid);
 	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
 						: vcoreqfid - vcocurrfid;
 
 	while (vcofiddiff > FSTEP) {
-		if (reqfid > perproc[PP_OFF_CFID]) {
-			if (perproc[PP_OFF_CFID] > LO_FID_TABLE_TOP) {
+		if (reqfid > perproc->cfid) {
+			if (perproc->cfid > LO_FID_TABLE_TOP) {
 				if (write_new_fid(perproc, idx,
-						  perproc[PP_OFF_CFID] + FSTEP))
+						  perproc->cfid + FSTEP))
 					return 1;
 			} else {
 				if (write_new_fid(perproc, idx, FSTEP +
-				     convert_fid_to_vfid(perproc[PP_OFF_CFID])))
+				     convert_fid_to_vfid(perproc->cfid)))
 					return 1;
 			}
 		} else {
 			if (write_new_fid(perproc, idx,
-					  perproc[PP_OFF_CFID]-FSTEP))
+					  perproc->cfid-FSTEP))
 				return 1;
 		}
 
-		vcocurrfid = convert_fid_to_vfid(perproc[PP_OFF_CFID]);
+		vcocurrfid = convert_fid_to_vfid(perproc->cfid);
 		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
 						    : vcoreqfid - vcocurrfid;
 	}
@@ -368,70 +363,70 @@
 	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
-	if (perproc[PP_OFF_CFID] != reqfid) {
+	if (perproc->cfid != reqfid) {
 		printk(EFX "ph2 mismatch, failed transn, curr %x, req %x\n",
-		       perproc[PP_OFF_CFID], reqfid);
+		       perproc->cfid, reqfid);
 		return 1;
 	}
 
-	if (savevid != perproc[PP_OFF_CVID]) {
+	if (savevid != perproc->cvid) {
 		printk(EFX "ph2 vid changed, save %x, curr %x\n", savevid,
-		       perproc[PP_OFF_CVID]);
+		       perproc->cvid);
 		return 1;
 	}
 
 	dprintk(DFX "ph2 complete%d, currfid 0x%x, currvid 0x%x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		perproc->cfid, perproc->cvid);
 	return 0;
 }
 
-static inline int core_voltage_post_transition(u8 * perproc, u32 idx, u8 reqvid)
+static inline int core_voltage_post_transition(struct cpu_power *perproc, u32 idx, u8 reqvid)
 {
-	u8 savefid = perproc[PP_OFF_CFID];
+	u8 savefid = perproc->cfid;
 	u8 savereqvid = reqvid;
 
 	dprintk(DFX "ph3 starting%d, cfid 0x%x, cvid 0x%x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		perproc->cfid, perproc->cvid);
 
-	if (reqvid != perproc[PP_OFF_CVID]) {
+	if (reqvid != perproc->cvid) {
 		if (write_new_vid(perproc, reqvid))
 			return 1;
 
-		if (savefid != perproc[PP_OFF_CFID]) {
+		if (savefid != perproc->cfid) {
 			printk(EFX "ph3: bad fid change, save %x, curr %x\n",
-			       savefid, perproc[PP_OFF_CFID]);
+			       savefid, perproc->cfid);
 			return 1;
 		}
 
-		if (perproc[PP_OFF_CVID] != reqvid) {
+		if (perproc->cvid != reqvid) {
 			printk(EFX "ph3: failed vid trans\n, req %x, curr %x",
-			       reqvid, perproc[PP_OFF_CVID]);
+			       reqvid, perproc->cvid);
 			return 1;
 		}
 	}
 	if (query_current_values_with_pending_wait(perproc))
 		return 1;
 
-	if (savereqvid != perproc[PP_OFF_CVID]) {
-		dprintk(EFX "ph3 failed, currvid 0x%x\n", perproc[PP_OFF_CVID]);
+	if (savereqvid != perproc->cvid) {
+		dprintk(EFX "ph3 failed, currvid 0x%x\n", perproc->cvid);
 		return 1;
 	}
 
-	if (savefid != perproc[PP_OFF_CFID]) {
+	if (savefid != perproc->cfid) {
 		dprintk(EFX "ph3 failed, currfid changed 0x%x\n",
-			perproc[PP_OFF_CFID]);
+			perproc->cfid);
 		return 1;
 	}
 
 	dprintk(DFX "ph3 done%d, cfid 0x%x, cvid 0x%x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		perproc->cfid, perproc->cvid);
 	return 0;
 }
 
-static inline int transition_fid_vid(u8 *perproc, u32 idx, u8 rfid, u8 rvid)
+static inline int transition_fid_vid(struct cpu_power *perproc, u32 idx, u8 rfid, u8 rvid)
 {
 	if (core_voltage_pre_transition(perproc, idx, rvid))
 		return 1;
@@ -441,15 +436,15 @@
 		return 1;
 	if (query_current_values_with_pending_wait(perproc))
 		return 1;
-	if ((rfid != perproc[PP_OFF_CFID]) || (rvid != perproc[PP_OFF_CVID])) {
+	if ((rfid != perproc->cfid) || (rvid != perproc->cvid)) {
 		printk(EFX "failed%d: req %x %x, curr %x %x\n",
 		       smp_processor_id(), rfid, rvid,
-		       perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		       perproc->cfid, perproc->cvid);
 		return 1;
 	}
 	dprintk(IFX "transitioned%d: new fid 0x%x, vid 0x%x\n",
 		smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
+		perproc->cfid, perproc->cvid);
 	return 0;
 }
 
@@ -478,7 +473,7 @@
 static int process_pss(acpi_handle objh, unsigned cpunumb)
 {
 	struct proc_pss proc;
-	u8 *perproc;
+	struct cpu_power *perproc;
 	struct pstate *pst;
 	u32 pstc;
 	acpi_status rc;
@@ -515,15 +510,15 @@
 		return -ENODEV;
 	}
 
-	i = (PP_OFF_BYTES * sizeof(u8)) + (sizeof(struct pstate) * pstc);
+	i = sizeof(struct cpu_power) + (sizeof(struct pstate) * pstc);
 	perproc = kmalloc(i, GFP_KERNEL);
 	if (!perproc) {
 		printk(EFX "perproc memory alloc failure\n");
 		return -ENOMEM;
 	}
 	memset(perproc, 0, i);
-	pst = (struct pstate *) (perproc + PP_OFF_BYTES);
-	perproc[PP_OFF_NUMPS] = pstc;
+	pst = &perproc->pst[0];
+	perproc->numps = pstc;
 
 	data = obj->package.elements;
 	for (i = 0; i < pstc; i++) {
@@ -685,8 +680,8 @@
 
 	for (i = 0; i < num_online_cpus(); i++) {
 		if (procs[i]) {
-			pst = (struct pstate *) (procs[i] + PP_OFF_BYTES);
-			for (j = 0; j < procs[i][PP_OFF_NUMPS]; j++)
+			pst = (&procs[i]->pst[0]);
+			for (j = 0; j < procs[i]->numps; j++)
 				dprintk(IFX
 			            "cpu%d: freq %d: fid %x, vid %x, irt %x, "
 				    "rvo %x, plllock %x, vidmvs %x, vstbl %x\n",
@@ -727,10 +722,10 @@
 	return fid_from_freq(freq);
 }
 
-static int find_match(u8 *perproc, u16 *ptargfreq, u16 *pmin, u16 *pmax,
+static int find_match(struct cpu_power *perproc, u16 *ptargfreq, u16 *pmin, u16 *pmax,
 			u8 *pfid, u8 *pvid, u32 *idx)
 {
-	u32 availpstates = perproc[PP_OFF_NUMPS];
+	u32 availpstates = perproc->numps;
 	u8 targfid = find_closest_fid(*ptargfreq);
 	u8 minfid = find_closest_fid(*pmin);
 	u8 maxfid = find_closest_fid(*pmax);
@@ -738,7 +733,7 @@
 	u32 minidx = availpstates - 1;
 	u32 targidx = 0xffffffff;
 	int i;
-	struct pstate *pst = (struct pstate *) (perproc + PP_OFF_BYTES);
+	struct pstate *pst = &perproc->pst[0];
 
 	dprintk(DFX "find match: freq %d MHz (%x), min %d (%x), max %d (%x)\n",
 		*ptargfreq, targfid, *pmin, minfid, *pmax, maxfid);
@@ -805,7 +800,7 @@
 }
 
 static inline int
-transition_frequency(u8 *perproc, u16 *preq, u16 *pmin, u16 *pmax)
+transition_frequency(struct cpu_power *perproc, u16 *preq, u16 *pmin, u16 *pmax)
 {
 	u32 idx;
 	int res;
@@ -819,22 +814,22 @@
 
 	if (query_current_values_with_pending_wait(perproc))
 		return 1;
-	if ((perproc[PP_OFF_CVID] == vid) && (perproc[PP_OFF_CFID] == fid)) {
+	if ((perproc->cvid == vid) && (perproc->cfid == fid)) {
 		dprintk(DFX "targ matches curr (fid %x, vid %x)\n", fid, vid);
 		return 0;
 	}
 
 	if ((fid < HI_FID_TABLE_BOTTOM)
-	    && (perproc[PP_OFF_CFID] < HI_FID_TABLE_BOTTOM)) {
+	    && (perproc->cfid < HI_FID_TABLE_BOTTOM)) {
 		printk(EFX "ignoring change in lo freq table: %x to %x\n",
-		       perproc[PP_OFF_CFID], fid);
+		       perproc->cfid, fid);
 		return 1;
 	}
 
 	dprintk(DFX "cpu%d to fid %x vid %x\n", smp_processor_id(), fid, vid);
 
 	freqs.cpu = smp_processor_id();
-	freqs.old = freq_from_fid(perproc[PP_OFF_CFID]);
+	freqs.old = freq_from_fid(perproc->cfid);
 	freqs.new = freq_from_fid(fid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
@@ -842,7 +837,7 @@
 	res = transition_fid_vid(perproc, idx, fid, vid);
 	up(&fidvid_sem);
 
-	freqs.new = freq_from_fid(perproc[PP_OFF_CFID]);
+	freqs.new = freq_from_fid(perproc->cfid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return res;
@@ -850,19 +845,19 @@
 
 static int need_poller(void)   /* if running at a freq only allowed for a/c */
 {
-	u8 *perproc = procs[0];
-	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+	struct cpu_power *perproc = procs[0];
+	struct pstate *pst = &perproc->pst[0];
         u32 maxidx;
 
         if (num_online_cpus() > 1)
 		return 0;
 
         process_ppc(0);
-	if (rstps > perproc[PP_OFF_NUMPS])
+	if (rstps > perproc->numps)
 		return 0;
-	maxidx = perproc[PP_OFF_NUMPS] - rstps;
+	maxidx = perproc->numps - rstps;
 	pst += maxidx;
-	if (rstps && (perproc[PP_OFF_CFID] > pst->fid ))
+	if (rstps && (perproc->cfid > pst->fid ))
 		return 1;
 	return 0;
 }
@@ -871,11 +866,11 @@
 static void ac_poller(unsigned long x)  
 {
 	int pow;
-	u8 *perproc = procs[0];
-	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
-        u32 maxidx = perproc[PP_OFF_NUMPS] - rstps;
+	struct cpu_power *perproc = procs[0];
+	struct pstate *pst = &perproc->pst[0];
+        u32 maxidx = perproc->numps - rstps;
 	u16 rf = pst[maxidx].freq;
-	u16 minfreq = pst[perproc[PP_OFF_NUMPS]-1].freq;
+	u16 minfreq = pst[perproc->numps-1].freq;
 	u16 maxfreq = pst[maxidx].freq;
 
 	down(&poll_sem);
@@ -885,7 +880,7 @@
 		return;
 	}
         process_ppc(0);
-	if (rstps > perproc[PP_OFF_NUMPS]) {
+	if (rstps > perproc->numps) {
 		pollflg = POLLER_NOT_RUNNING;
 		up(&poll_sem);
 		return;
@@ -936,7 +931,7 @@
 	u16 reqfreq = (u16)(targfreq / KHZ);
 	u16 minfreq = (u16)(pol->min / KHZ);
 	u16 maxfreq = (u16)(pol->max / KHZ);
-	u8 *perproc;
+	struct cpu_power *perproc;
 	u8 checkfid;
 	u8 checkvid;
 
@@ -972,20 +967,20 @@
 	dprintk(DFX "targ cpu %d, curr cpu %d (mask %lx)\n", pol->cpu,
 		    smp_processor_id(),	current->cpus_allowed);
 
-	checkfid = perproc[PP_OFF_CFID];
-	checkvid = perproc[PP_OFF_CVID];
+	checkfid = perproc->cfid;
+	checkvid = perproc->cvid;
 	if (query_current_values_with_pending_wait(perproc)) {
 		printk(EFX "drv targ fail: change pending bit set\n");
 		rc = -EIO;
 		goto targ_exit;
 	}
 	dprintk(DFX "targ%d: curr fid %x, vid %x\n", smp_processor_id(),
-		perproc[PP_OFF_CFID], perproc[PP_OFF_CVID]);
-	if ((checkvid != perproc[PP_OFF_CVID])
-	    || (checkfid != perproc[PP_OFF_CFID])) {
+		perproc->cfid, perproc->cvid);
+	if ((checkvid != perproc->cvid)
+	    || (checkfid != perproc->cfid)) {
 		printk(EFX "error - out of sync, fid %x %x, vid %x %x\n",
-		       checkfid, perproc[PP_OFF_CFID], checkvid,
-		       perproc[PP_OFF_CVID]);
+		       checkfid, perproc->cfid, checkvid,
+		       perproc->cvid);
 	}
 
 	if (transition_frequency(perproc, &reqfreq, &minfreq, &maxfreq)) {
@@ -994,7 +989,7 @@
 		goto targ_exit;
 	}
 
-	pol->cur = kfreq_from_fid(perproc[PP_OFF_CFID]);
+	pol->cur = kfreq_from_fid(perproc->cfid);
 
 targ_exit:
 	preempt_enable_no_resched();
@@ -1013,7 +1008,7 @@
 	u16 min = (u16)(pol->min / KHZ);
 	u16 max = (u16)(pol->max / KHZ);
 	u16 targ = min;
-	u8 *perproc;
+	struct cpu_power *perproc;
 	int res;
 	u32 idx;
 	u8 fid;
@@ -1046,19 +1041,19 @@
 
 static int __init powernowk8_cpu_init(struct cpufreq_policy *pol)
 {
-	u8 *perproc = procs[smp_processor_id()];
-	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
+	struct cpu_power *perproc = procs[smp_processor_id()];
+	struct pstate *pst = &perproc->pst[0];
 
 	pol->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	pol->cpuinfo.transition_latency =             /* crude guess */
 		((pst[0].rvo + 8) * pst[0].vstable * VST_UNITS_20US)
 		+ (3 * (1 << pst[0].irt) * 10);
 
-	pol->cur = kfreq_from_fid(perproc[PP_OFF_CFID]);
+	pol->cur = kfreq_from_fid(perproc->cfid);
 	dprintk(DFX "policy cfreq %d kHz\n", pol->cur);
 
 	/* min/max this cpu is capable of */
-	pol->cpuinfo.min_freq =kfreq_from_fid(pst[perproc[PP_OFF_NUMPS]-1].fid);
+	pol->cpuinfo.min_freq =kfreq_from_fid(pst[perproc->numps-1].fid);
 	pol->cpuinfo.max_freq = kfreq_from_fid(pst[0].fid);
 	pol->min = pol->cpuinfo.min_freq;
 	pol->max = pol->cpuinfo.max_freq;
@@ -1068,7 +1063,7 @@
 #ifdef CONFIG_SMP
 static void smp_k8_init( void *retval )
 {
-	u8 *perproc = procs[smp_processor_id()];
+	struct cpu_power *perproc = procs[smp_processor_id()];
 	int *rc = (int *)retval;
 	rc += smp_processor_id();
 
@@ -1150,11 +1145,11 @@
 static void __exit powernowk8_exit(void)
 {
 	int pollwait = num_online_cpus() == 1 ? 1 : 0;
-	u8 *perproc = procs[0];
-	struct pstate *pst = (struct pstate *)(perproc + PP_OFF_BYTES);
-        u32 maxidx = perproc[PP_OFF_NUMPS] - seenrst;
+	struct cpu_power *perproc = procs[0];
+	struct pstate *pst = &perproc->pst[0];
+        u32 maxidx = perproc->numps - seenrst;
 	u16 rf = pst[maxidx].freq;
-	u16 minfreq = pst[perproc[PP_OFF_NUMPS]-1].freq;
+	u16 minfreq = pst[perproc->numps-1].freq;
 	u16 maxfreq = pst[maxidx].freq;
 
 	dprintk(IFX "powernowk8_exit, pollflg=%x\n", pollflg);
@@ -1175,7 +1170,7 @@
 
 	/* need to be on a battery frequency when the module is unloaded */
 	pst += maxidx;
-	if (seenrst && (perproc[PP_OFF_CFID] > pst->fid )) {
+	if (seenrst && (perproc->cfid > pst->fid )) {
 		if (POW_BAT == query_ac()) {
 			dprintk(DFX "unload emergency transition\n" );
                         transition_frequency(perproc, &rf, &minfreq, &maxfreq);


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
