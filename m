Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUCDNvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUCDNvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:51:53 -0500
Received: from gprs40-143.eurotel.cz ([160.218.40.143]:16346 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261907AbUCDNpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:45:51 -0500
Date: Thu, 4 Mar 2004 14:44:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040304134422.GE308@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C109A3935@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C109A3935@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've merged powernow-k8-acpi.h with powernow-k8.h, and moved common
code (static inline function) from powernow-k8.c and
powernow-k8-acpi.c there.

Diffstat looks reasonably nice:

pavel@amd:/usr/src/linux$ cat /tmp/delme.quilt-diff  | diffstat
 powernow-k8-acpi.c |  138 ++++++++++++++++++++++-------------------
 powernow-k8-acpi.h |  144 ------------------------------------------
 powernow-k8.c      |  178 +++++++++++++++++------------------------------------
 powernow-k8.h      |  128 ++++++++++++++++++++++++++------------
 4 files changed, 220 insertions(+), 368 deletions(-)

I guess that next step is to convert per-cpu state into struct, and
make both powernow-k8-acpi and powernow-k8 use that struct.
								Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-04 14:33:36.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-04 14:32:11.000000000 +0100
@@ -36,9 +36,82 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
+#define PFX "powernow-k8-acpi: "
+#define DFX KERN_DEBUG PFX
+#define IFX KERN_INFO  PFX
+#define EFX KERN_ERR   PFX
+
 #undef DEBUG
 #define VERSION "Version 1.20.02a"
-#include "powernow-k8-acpi.h"
+#include "powernow-k8.h"
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
 
 static u8 **procs;                  /* per processor data structure     */
 static u32 rstps;                   /* pstates allowed restrictions     */
@@ -59,11 +132,6 @@
 	.owner = THIS_MODULE,
 };
 
-static inline u32 freq_from_fid(u8 fid)
-{
-	return 800 + (fid * 100);
-}
-
 static inline u32 kfreq_from_fid(u8 fid)
 {
 	return KHZ * freq_from_fid(fid);
@@ -74,24 +142,6 @@
 	return (freq - 800) / 100;
 }
 
-static inline u32 convert_fid_to_vfid(u8 fid)
-{
-	if (fid < HI_FID_TABLE_BOTTOM) {
-		return 8 + (2 * fid);
-	} else {
-		return fid;
-	}
-}
-
-static inline int pending_bit_stuck(void)
-{
-	u32 lo;
-	u32 hi;
-
-	rdmsr(MSR_FIDVID_STAT, lo, hi);
-	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
-}
-
 static int query_current_values_with_pending_wait(u8 *perproc)
 {
 	u32 lo = MSR_S_LO_CHANGE_PENDING;
@@ -127,16 +177,6 @@
 	wrmsr(MSR_FIDVID_CTL, lo, hi);
 }
 
-static inline void count_off_irt(u8 irt)
-{
-	udelay((1 << irt) * 10);
-}
-
-static inline void count_off_vst(u8 vstable)
-{
-	udelay(vstable * VST_UNITS_20US);
-}
-
 static int write_new_fid(u8 *perproc, u32 idx, u8 fid)
 {
 	u32 lo;
@@ -413,36 +453,6 @@
 	return 0;
 }
 
-static inline int check_supported_cpu(void)
-{
-	struct cpuinfo_x86 *c = cpu_data;
-	u32 eax, ebx, ecx, edx;
-
-	if (c->x86_vendor != X86_VENDOR_AMD)
-		return 0;
-
-	eax = cpuid_eax(CPUID_PROCESSOR_SIGNATURE);
-	if (!(((eax & CPUID_XFAM_MOD) == ATHLON64_XFAM_MOD) ||
-	      ((eax & CPUID_XFAM_MOD) == OPTERON_XFAM_MOD))) {
-		dprintk(DFX "AMD Athlon 64 / Opteron processor required\n");
-		return 0;
-	}
-
-	eax = cpuid_eax(CPUID_GET_MAX_CAPABILITIES);
-	if (eax < CPUID_FREQ_VOLT_CAPABILITIES) {
-		printk(IFX "No freq change capabilities\n");
-		return 0;
-	}
-
-	cpuid(CPUID_FREQ_VOLT_CAPABILITIES, &eax, &ebx, &ecx, &edx);
-	if ((edx & P_STATE_TRANSITION_CAPABLE) != P_STATE_TRANSITION_CAPABLE) {
-		printk(IFX "P-state transitions not supported\n");
-		return 0;
-	}
-
-	return 1;
-}
-
 /* evaluating this object tells us whether we are using mains or battery */
 static inline int process_psr(acpi_handle objh)
 {
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.h	2004-03-04 14:33:36.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.h	2004-03-04 14:18:38.000000000 +0100
@@ -1,144 +0,0 @@
-/*
- *   (c) 2003, 2004 Advanced Micro Devices, Inc.
- *  Your use of this code is subject to the terms and conditions of the
- *  GNU general public license version 2. See "../../../../../COPYING" or
- *  http://www.gnu.org/licenses/gpl.html
- */
-
-/* processor's cpuid instruction support */
-#define CPUID_PROCESSOR_SIGNATURE             1	/* function 1               */
-#define CPUID_XFAM_MOD               0x0ff00ff0	/* xtended fam, fam + model */
-#define ATHLON64_XFAM_MOD            0x00000f40	/* xtended fam, fam + model */
-#define OPTERON_XFAM_MOD             0x00000f50	/* xtended fam, fam + model */
-#define CPUID_GET_MAX_CAPABILITIES   0x80000000
-#define CPUID_FREQ_VOLT_CAPABILITIES 0x80000007
-#define P_STATE_TRANSITION_CAPABLE            6
-
-#define MSR_FIDVID_CTL      0xc0010041
-#define MSR_FIDVID_STAT     0xc0010042
-
-/* control MSR - low part */
-#define MSR_C_LO_INIT             0x00010000
-#define MSR_C_LO_NEW_VID          0x00001f00
-#define MSR_C_LO_NEW_FID          0x0000003f
-#define MSR_C_LO_VID_SHIFT        8
-
-/* control MSR - high part */
-#define MSR_C_HI_STP_GNT_TO       0x000fffff
-#define MSR_C_HI_STP_GNT_BENIGN   1
-
-/* status MSR - low part */
-#define MSR_S_LO_CHANGE_PENDING   0x80000000   /* cleared when completed */
-#define MSR_S_LO_MAX_RAMP_VID     0x1f000000
-#define MSR_S_LO_MAX_FID          0x003f0000
-#define MSR_S_LO_START_FID        0x00003f00
-#define MSR_S_LO_CURRENT_FID      0x0000003f
-
-/* status MSR - high part */
-#define MSR_S_HI_MAX_WORKING_VID  0x001f0000
-#define MSR_S_HI_START_VID        0x00001f00
-#define MSR_S_HI_CURRENT_VID      0x0000001f
-
-#define LO_FID_TABLE_TOP        6     /* valid fids exist in 2 tables */
-#define HI_FID_TABLE_BOTTOM     8
-#define LO_VCOFREQ_TABLE_TOP    1400  /* corresponding vco frequency values */
-#define HI_VCOFREQ_TABLE_BOTTOM 1600
-
-#define MIN_FREQ_RESOLUTION  200 /* fids jump by 2 matching freq jumps by 200 */
-#define FSTEP                  2
-#define KHZ                 1000
-
-#define MAX_FID 0x2a	/* Spec only gives FID values as far as 5 GHz */
-#define LEAST_VID 0x1e	/* Lowest (numerically highest) useful vid value */
-
-#define MIN_FREQ 800
-#define MAX_FREQ 5000
-
-#define INVALID_FID_MASK 0xffffffc1  /* not a valid fid if these bits are set */
-#define INVALID_VID_MASK 0xffffffe0  /* not a valid vid if these bits are set */
-
-
-#define STOP_GRANT_5NS    1 /* min memory access latency for voltage change   */
-#define MAXIMUM_VID_STEPS 1 /* Current cpus only allow a single step of 25mV  */
-#define VST_UNITS_20US   20 /* Voltage Stabilization Time is in units of 20us */
-
-#define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
-
-/* byte offsets into the perproc struct */
-#define PP_OFF_NUMPS  0   /* number of p-states      */
-#define PP_OFF_SHARE  1   /* index of shared control */
-#define PP_OFF_CVID   2   /* current voltage id      */
-#define PP_OFF_CFID   3   /* current frequency id    */
-#define PP_OFF_BYTES  4   /* size in bytes           */   
-
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
-/* Explanation of the perproc data structures:
- * static u8 **procs; declared in the .c file is an array of pointers to u8.
- * There is one such pointer for each cpu in the system.
- * Each pointer points to 4 u8s (indexed by the PP_OFF constants above),
- * followed by an array of struct pstate, where each processor may have
- * a different number of entries in its array. I.e., processor 0 may have
- * 3 pstates, processor 1 may have 5 pstates.
- */
-
-struct proc_pss {  /* the acpi _PSS structure */
-	acpi_integer freq;
-	acpi_integer pow;
-	acpi_integer tlat;
-	acpi_integer blat;
-	acpi_integer cntl;
-	acpi_integer stat;
-};
-
-#define PSS_FMT_STR "NNNNNN"
-
-#define IRT_SHIFT      30
-#define RVO_SHIFT      28
-#define PLL_L_SHIFT    20
-#define MVS_SHIFT      18
-#define VST_SHIFT      11
-#define VID_SHIFT       6
-#define IRT_MASK        3
-#define RVO_MASK        3
-#define PLL_L_MASK   0x7f
-#define MVS_MASK        3
-#define VST_MASK     0x7f
-#define VID_MASK     0x1f
-#define FID_MASK     0x3f
-
-#define POW_AC  0  /* The power supply states we care about - mains, battery, */
-#define POW_BAT 1  /* or unknown, which presumably means that there is no     */
-#define POW_UNK 2  /* acpi support for the psr object, so there is no battery.*/
-
-#define POLLER_NOT_RUNNING 0  /* The state of the poller (which watches for   */
-#define POLLER_RUNNING     1  /* power transitions). It is only running if we */
-#define POLLER_UNLOAD      2  /* are on mains power, at a high frequency, and */
-#define POLLER_DEAD        3  /* if there are battery restrictions.           */
-
-#define PFX "powernow-k8-acpi: "
-#define DFX KERN_DEBUG PFX
-#define IFX KERN_INFO  PFX
-#define EFX KERN_ERR   PFX
-
-#ifdef DEBUG
-#define dprintk(msg...) printk(msg)
-#else
-#define dprintk(msg...) do { } while(0)
-#endif
-
-static void start_ac_poller(int frompoller);
-static int powernowk8_verify(struct cpufreq_policy *p);
-static int powernowk8_target(struct cpufreq_policy *p, unsigned t, unsigned r);
-static int __init powernowk8_cpu_init(struct cpufreq_policy *p);
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-04 14:33:36.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-04 14:29:22.000000000 +0100
@@ -36,6 +36,45 @@
 #define VERSION "version 1.00.08b"
 #include "powernow-k8.h"
 
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
+
+static inline int core_voltage_pre_transition(u32 reqvid);
+static inline int core_voltage_post_transition(u32 reqvid);
+static inline int core_frequency_transition(u32 reqfid);
+
 static u32 vstable;	/* voltage stabalization time, from PSB, units 20 us */
 static u32 plllock;	/* pll lock time, from PSB, units 1 us */
 static u32 numps;	/* number of p-states, from PSB */
@@ -70,37 +109,6 @@
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
-	rdmsr(MSR_FIDVID_STAT, lo, hi);
-	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
-}
-
 /*
  * Update the global current fid / vid values from the status msr. Returns 1
  * on error.
@@ -119,29 +127,11 @@
 		}
 		rdmsr(MSR_FIDVID_STAT, lo, hi);
 	}
-
 	currvid = hi & MSR_S_HI_CURRENT_VID;
 	currfid = lo & MSR_S_LO_CURRENT_FID;
-
 	return 0;
 }
 
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
 write_new_fid(u32 fid)
@@ -164,7 +154,7 @@
 	if (query_current_values_with_pending_wait())
 		return 1;
 
-	count_off_irt();
+	count_off_irt(irt);
 
 	if (savevid != currvid) {
 		printk(KERN_ERR PFX
@@ -237,7 +227,7 @@
 	if (write_new_vid(reqvid))
 		return 1;
 
-	count_off_vst();
+	count_off_vst(vstable);
 
 	return 0;
 }
@@ -248,25 +238,19 @@
 {
 	if (core_voltage_pre_transition(reqvid))
 		return 1;
-
 	if (core_frequency_transition(reqfid))
 		return 1;
-
 	if (core_voltage_post_transition(reqvid))
 		return 1;
-
 	if (query_current_values_with_pending_wait())
 		return 1;
-
 	if ((reqfid != currfid) || (reqvid != currvid)) {
 		printk(KERN_ERR PFX "failed: req 0x%x 0x%x, curr 0x%x 0x%x\n",
 		       reqfid, reqvid, currfid, currvid);
 		return 1;
 	}
-
 	dprintk(KERN_INFO PFX
 		"transitioned: new fid 0x%x, vid 0x%x\n", currfid, currvid);
-
 	return 0;
 }
 
@@ -342,8 +326,8 @@
 		"ph2 starting, currfid 0x%x, currvid 0x%x, reqfid 0x%x\n",
 		currfid, currvid, reqfid);
 
-	vcoreqfid = convert_fid_to_vco_fid(reqfid);
-	vcocurrfid = convert_fid_to_vco_fid(currfid);
+	vcoreqfid = convert_fid_to_vfid(reqfid);
+	vcocurrfid = convert_fid_to_vfid(currfid);
 	vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
 	    : vcoreqfid - vcocurrfid;
 
@@ -355,7 +339,7 @@
 				}
 			} else {
 				if (write_new_fid
-				    (2 + convert_fid_to_vco_fid(currfid))) {
+				    (2 + convert_fid_to_vfid(currfid))) {
 					return 1;
 				}
 			}
@@ -364,7 +348,7 @@
 				return 1;
 		}
 
-		vcocurrfid = convert_fid_to_vco_fid(currfid);
+		vcocurrfid = convert_fid_to_vfid(currfid);
 		vcofiddiff = vcocurrfid > vcoreqfid ? vcocurrfid - vcoreqfid
 		    : vcoreqfid - vcocurrfid;
 	}
@@ -444,57 +428,6 @@
 	return 0;
 }
 
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
@@ -599,7 +532,7 @@
 
 		maxvid = psb->maxvid;
 		printk("maxfid 0x%x (%d MHz), maxvid 0x%x\n", 
-		       psb->maxfid, find_freq_from_fid(psb->maxfid), maxvid);
+		       psb->maxfid, freq_from_fid(psb->maxfid), maxvid);
 
 		numps = arima ? 3 : psb->numpstates;
 		if (numps < 2) {
@@ -649,7 +582,7 @@
 		}
 
 		for (j = 0; j < numps; j++) {
-			powernow_table[j].frequency = find_freq_from_fid(powernow_table[j].index & 0xff)*1000;
+			powernow_table[j].frequency = freq_from_fid(powernow_table[j].index & 0xff)*1000;
 			printk(KERN_INFO PFX "   %d : fid 0x%x (%d MHz), vid 0x%x\n", j,
 			       powernow_table[j].index & 0xff, 
 			       powernow_table[j].frequency/1000,
@@ -665,7 +598,7 @@
 		}
 
 		printk(KERN_INFO PFX "currfid 0x%x (%d MHz), currvid 0x%x\n",
-		       currfid, find_freq_from_fid(currfid), currvid);
+		       currfid, freq_from_fid(currfid), currvid);
 
 		for (j = 0; j < numps; j++)
 			if ((pst[j].fid==currfid) && (pst[j].vid==currvid))
@@ -720,13 +653,13 @@
 
 	freqs.cpu = 0;	/* only true because SMP not supported */
 
-	freqs.old = find_freq_from_fid(currfid);
-	freqs.new = find_freq_from_fid(fid);
+	freqs.old = freq_from_fid(currfid);
+	freqs.new = freq_from_fid(fid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	res = transition_fid_vid(fid, vid);
 
-	freqs.new = find_freq_from_fid(currfid);
+	freqs.new = freq_from_fid(currfid);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return res;
@@ -769,7 +702,7 @@
 		return 1;
 	}
 
-	pol->cur = 1000 * find_freq_from_fid(currfid);
+	pol->cur = 1000 * freq_from_fid(currfid);
 
 	return 0;
 }
@@ -805,7 +738,7 @@
 	if (query_current_values_with_pending_wait())
 		return -EIO;
 
-	pol->cur = 1000 * find_freq_from_fid(currfid);
+	pol->cur = 1000 * freq_from_fid(currfid);
 	dprintk(KERN_DEBUG PFX "policy current frequency %d kHz\n", pol->cur);
 
 	/* min/max the cpu is capable of */
@@ -855,6 +788,11 @@
 	}
 #endif
 
+	if (num_online_cpus() != 1) {
+		printk(KERN_INFO PFX "multiprocessor systems not supported\n");
+		return -ENODEV;
+	}
+
 	if (check_supported_cpu() == 0)
 		return -ENODEV;
 
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-04 14:33:36.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-04 14:29:33.000000000 +0100
@@ -22,11 +22,12 @@
 /* control MSR - low part */
 #define MSR_C_LO_INIT             0x00010000
 #define MSR_C_LO_NEW_VID          0x00001f00
-#define MSR_C_LO_NEW_FID          0x0000002f
+#define MSR_C_LO_NEW_FID          0x0000002f   /* FIXME: acpi driver uses 0x3f here?! */
 #define MSR_C_LO_VID_SHIFT        8
 
 /* control MSR - high part */
 #define MSR_C_HI_STP_GNT_TO       0x000fffff
+#define MSR_C_HI_STP_GNT_BENIGN   1
 
 /* status MSR - low part */
 #define MSR_S_LO_CHANGE_PENDING   0x80000000   /* cleared when completed */
@@ -47,6 +48,8 @@
 #define HI_VCOFREQ_TABLE_BOTTOM 1600
 
 #define MIN_FREQ_RESOLUTION  200 /* fids jump by 2 matching freq jumps by 200 */
+#define FSTEP                  2
+#define KHZ                 1000
 
 #define MAX_FID 0x2a	/* Spec only gives FID values as far as 5 GHz */
 #define LEAST_VID 0x1e	/* Lowest (numerically highest) useful vid value */
@@ -64,48 +67,93 @@
 
 #define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
 
-
-/*
- * Version 1.4 of the PSB table. This table is constructed by BIOS and is
- * to tell the OS's power management driver which VIDs and FIDs are
- * supported by this particular processor. This information is obtained from
- * the data sheets for each processor model by the system vendor and
- * incorporated into the BIOS.
- * If the data in the PSB / PST is wrong, then this driver will program the
- * wrong values into hardware, which is very likely to lead to a crash.
- */
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
-
-/* Pairs of fid/vid values are appended to the version 1.4 PSB table. */
-struct pst_s {
-	u8 fid;
-	u8 vid;
-};
-
 #ifdef DEBUG
 #define dprintk(msg...) printk(msg)
 #else
 #define dprintk(msg...) do { } while(0)
 #endif
 
-static inline int core_voltage_pre_transition(u32 reqvid);
-static inline int core_voltage_post_transition(u32 reqvid);
-static inline int core_frequency_transition(u32 reqfid);
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
+
+/*
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
+		if ((eax & CPUID_F1_STEP) < ATHLON64_REV_C0) {
+			printk(KERN_INFO PFX "Revision C0 or better "
+			       "AMD Athlon 64 processor required\n");
+			return 0;
+		}
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
+	printk(KERN_INFO PFX "Found AMD64 processor supporting PowerNow (" VERSION ")\n");
+	return 1;
+}



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
