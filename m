Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbUAMVwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUAMVwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:52:37 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265385AbUAMVw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:52:28 -0500
Date: Tue, 13 Jan 2004 22:51:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: davej@codemonkey.org.uk, cpufreq@www.linux.org.uk, linux@brodo.de,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com
Subject: Cleanups for powernow-k8
Message-ID: <20040113215149.GA236@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

powernow-k8 uses strange kind of comments, and is way too
verbose. Also powernow-k7 should just shut up when it is monolithic
kernel and cpu is not k7.

[Oh and look at this:
@@ -637,6 +629,7 @@
 		}
 
 		if ((numps <= 1) || (batps <= 1)) {
+			/* FIXME: Is this right? I can see one state on battery, two states total as an usefull config */
 			printk(KERN_ERR PFX "only 1 p-state to transition\n");
 			return -ENODEV;
 		}
the test probably should be numps <= 1 only, but it does not matter as
we force numps = batps]

Please apply,
								Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-01-09 20:24:13.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-01-13 21:53:29.000000000 +0100
@@ -91,18 +91,13 @@
 	struct cpuinfo_x86 *c = cpu_data;
 	unsigned int maxei, eax, ebx, ecx, edx;
 
-	if (c->x86_vendor != X86_VENDOR_AMD) {
-		printk (KERN_INFO PFX "AMD processor not detected.\n");
-		return 0;
-	}
-
-	if (c->x86 !=6) {
+	if ((c->x86_vendor != X86_VENDOR_AMD) || (c->x86 !=6)) {
+#ifdef MODULE
 		printk (KERN_INFO PFX "This module only works with AMD K7 CPUs\n");
+#endif
 		return 0;
 	}
 
-	printk (KERN_INFO PFX "AMD K7 CPU detected.\n");
-
 	if ((c->x86_model == 6) && (c->x86_mask == 0)) {
 		printk (KERN_INFO PFX "K7 660[A0] core detected, enabling errata workarounds\n");
 		have_a0 = 1;
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-01-09 20:24:13.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-01-13 22:24:08.000000000 +0100
@@ -31,7 +31,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.00.08 - September 26, 2003"
+#define VERSION "version 1.00.08a"
 #include "powernow-k8.h"
 
 #ifdef CONFIG_PREEMPT
@@ -107,11 +107,13 @@
 	}
 }
 
-/* Sort the fid/vid frequency table into ascending order by fid. The spec */
-/* implies that it will be sorted by BIOS, but, it only implies it, and I */
-/* prefer not to trust when I can check.                                  */
-/* Yes, it is a simple bubble sort, but the PST is really small, so the   */
-/* choice of algorithm is pretty irrelevant.                              */
+/*
+ * Sort the fid/vid frequency table into ascending order by fid. The spec
+ * implies that it will be sorted by BIOS, but, it only implies it, and I
+ * prefer not to trust when I can check.
+ * Yes, it is a simple bubble sort, but the PST is really small, so the
+ * choice of algorithm is pretty irrelevant.
+ */
 static inline void
 sort_pst(struct pst_s *ppst, u32 numpstates)
 {
@@ -134,29 +136,29 @@
 			}
 		}
 	}
-
 	return;
 }
 
-/* Return 1 if the pending bit is set. Unless we are actually just told the */
-/* processor to transition a state, seeing this bit set is really bad news. */
+/*
+ * Return 1 if the pending bit is set. Unless we are actually just told the
+ * processor to transition a state, seeing this bit set is really bad news.
+ */
 static inline int
 pending_bit_stuck(void)
 {
-	u32 lo;
-	u32 hi;
-
+	u32 lo, hi;
 	rdmsr(MSR_FIDVID_STATUS, lo, hi);
 	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
 }
 
-/* Update the global current fid / vid values from the status msr. Returns 1 */
-/* on error.                                                                 */
+/*
+ * Update the global current fid / vid values from the status msr. Returns 1
+ * on error.
+ */
 static int
 query_current_values_with_pending_wait(void)
 {
-	u32 lo;
-	u32 hi;
+	u32 lo, hi;
 	u32 i = 0;
 
 	lo = MSR_S_LO_CHANGE_PENDING;
@@ -271,9 +273,11 @@
 	return 0;
 }
 
-/* Reduce the vid by the max of step or reqvid.                   */
-/* Decreasing vid codes represent increasing voltages :           */
-/* vid of 0 is 1.550V, vid of 0x1e is 0.800V, vid of 0x1f is off. */
+/*
+ * Reduce the vid by the max of step or reqvid.
+ * Decreasing vid codes represent increasing voltages:
+ * vid of 0 is 1.550V, vid of 0x1e is 0.800V, vid of 0x1f is off.
+ */
 static int
 decrease_vid_code_by_step(u32 reqvid, u32 step)
 {
@@ -316,8 +320,10 @@
 	return 0;
 }
 
-/* Phase 1 - core voltage transition ... setup appropriate voltage for the */
-/* fid transition.                                                         */
+/*
+ * Phase 1 - core voltage transition ... setup appropriate voltage for the
+ * fid transition.
+ */
 static inline int
 core_voltage_pre_transition(u32 reqvid)
 {
@@ -500,7 +506,9 @@
 	}
 
 	if (c->x86_vendor != X86_VENDOR_AMD) {
+#ifdef MODULE
 		printk(KERN_INFO PFX "Not an AMD processor\n");
+#endif
 		return 0;
 	}
 
@@ -533,9 +541,7 @@
 		return 0;
 	}
 
-	printk(KERN_INFO PFX "Found AMD Athlon 64 / Opteron processor "
-	       "supporting p-state transitions\n");
-
+	printk(KERN_INFO PFX "Found AMD processor supporting PowerNow (" VERSION ")\n");
 	return 1;
 }
 
@@ -573,33 +579,19 @@
 		}
 
 		vstable = psb->voltagestabilizationtime;
-		printk(KERN_INFO PFX "voltage stable time: %d (units 20us)\n",
-		       vstable);
-
 		dprintk(KERN_DEBUG PFX "flags2: 0x%x\n", psb->flags2);
 		rvo = psb->flags2 & 3;
 		irt = ((psb->flags2) >> 2) & 3;
 		mvs = ((psb->flags2) >> 4) & 3;
 		vidmvs = 1 << mvs;
 		batps = ((psb->flags2) >> 6) & 3;
-		printk(KERN_INFO PFX "p states on battery: %d ", batps);
-		switch (batps) {
-		case 0:
-			printk("- all available\n");
-			break;
-		case 1:
-			printk("- only the minimum\n");
-			break;
-		case 2:
-			printk("- only the 2 lowest\n");
-			break;
-		case 3:
-			printk("- only the 3 lowest\n");
-			break;
-		}
-		printk(KERN_INFO PFX "ramp voltage offset: %d\n", rvo);
-		printk(KERN_INFO PFX "isochronous relief time: %d\n", irt);
-		printk(KERN_INFO PFX "maximum voltage step: %d\n", mvs);
+
+		printk(KERN_INFO PFX "voltage stable in %d usec", vstable * 20);
+		if (batps)
+			printk(", only %d lowest states on battery", batps);
+		printk(", ramp voltage offset: %d", rvo);
+		printk(", isochronous relief time: %d", irt);
+		printk(", maximum voltage step: %d\n", mvs);
 
 		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
 		if (psb->numpst != 1) {
@@ -718,8 +711,10 @@
 	return -ENODEV;
 }
 
-/* Converts a frequency (that might not necessarily be a multiple of 200) */
-/* to a fid.                                                              */
+/*
+ * Converts a frequency (that might not necessarily be a multiple of 200)
+ * to a fid.
+ */
 static u32
 find_closest_fid(u32 freq, int searchup)
 {
@@ -985,8 +980,6 @@
 {
 	int rc;
 
-	printk(KERN_INFO PFX VERSION "\n");
-
 	if (check_supported_cpu() == 0)
 		return -ENODEV;
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
