Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUCCXNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCCXNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:13:05 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:19528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261247AbUCCXMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:12:00 -0500
Date: Thu, 4 Mar 2004 00:11:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
       paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303231143.GH222@elf.ucw.cz>
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com> <20040303223510.GE222@elf.ucw.cz> <20040303224841.GB16874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303224841.GB16874@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > We could make that functionality depend on CONFIG_ACPI, and allow
>  > runtime selection only if its defined... But those two drivers are
>  > pretty different just now and acpi-dependend chunk is pretty big. (It
>  > does funny stuff like polling for AC plug removal if we are in
>  > high-power state  and battery would not handle that. Old driver simply
>  > refused to use high-power states on such machines.)
> 
> you're aware of Dominik/Bruno's work on the 'acpilib'[1] stuff in this
> area right ? We'll need that anyway for Powernow-k7 and maybe longhaul too
> and its senseless duplicating this code.
> 
> One thing is bugging me though. Whats wrong with the ACPI P-state cpufreq
> driver ? Does that not work these days ? It's been a long time since I
> even looked at it.

Dave, could you apply these? That are cleanups from Paul's new version
of driver (killed few unused defines, right names for MSR's
(hopefully!), more linux-like comments). No code changes.
								Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-04 00:01:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-03-03 23:56:36.000000000 +0100
@@ -7,7 +7,7 @@
  *  Support : paul.devriendt@amd.com
  *
  *  Based on the powernow-k7.c module written by Dave Jones.
- *  (C) 2003 Dave Jones <davej@codemonkey.ork.uk> on behalf of SuSE Labs
+ *  (C) 2003 Dave Jones <davej@codemonkey.org.uk> on behalf of SuSE Labs
  *  (C) 2004 Dominik Brodowski <linux@brodo.de>
  *  (C) 2004 Pavel Machek <pavel@suse.cz>
  *  Licensed under the terms of the GNU GPL License version 2.
@@ -33,7 +33,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.00.08a"
+#define VERSION "version 1.00.08b"
 #include "powernow-k8.h"
 
 static u32 vstable;	/* voltage stabalization time, from PSB, units 20 us */
@@ -97,7 +97,7 @@
 {
 	u32 lo, hi;
 
-	rdmsr(MSR_FIDVID_STATUS, lo, hi);
+	rdmsr(MSR_FIDVID_STAT, lo, hi);
 	return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
 }
 
@@ -117,7 +117,7 @@
 			printk(KERN_ERR PFX "detected change pending stuck\n");
 			return 1;
 		}
-		rdmsr(MSR_FIDVID_STATUS, lo, hi);
+		rdmsr(MSR_FIDVID_STAT, lo, hi);
 	}
 
 	currvid = hi & MSR_S_HI_CURRENT_VID;
@@ -154,7 +154,7 @@
 		return 1;
 	}
 
-	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
+	lo = fid | (currvid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
 
 	dprintk(KERN_DEBUG PFX "writing fid %x, lo %x, hi %x\n",
 		fid, lo, plllock * PLL_LOCK_CONVERSION);
@@ -195,7 +195,7 @@
 		return 1;
 	}
 
-	lo = currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT_FID_VID;
+	lo = currfid | (vid << MSR_C_LO_VID_SHIFT) | MSR_C_LO_INIT;
 
 	dprintk(KERN_DEBUG PFX "writing vid %x, lo %x, hi %x\n",
 		vid, lo, STOP_GRANT_5NS);
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-02-20 12:29:10.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2004-03-04 00:00:23.000000000 +0100
@@ -1,15 +1,12 @@
 /*
- *   (c) 2003 Advanced Micro Devices, Inc.
+ *   (c) 2003, 2004 Advanced Micro Devices, Inc.
  *  Your use of this code is subject to the terms and conditions of the
- *  GNU general public license version 2. See "../../../COPYING" or
+ *  GNU general public license version 2. See "../../../../../COPYING" or
  *  http://www.gnu.org/licenses/gpl.html
  */
 
 /* processor's cpuid instruction support */
 #define CPUID_PROCESSOR_SIGNATURE             1	/* function 1               */
-#define CPUID_F1_FAM                 0x00000f00	/* family mask              */
-#define CPUID_F1_XFAM                0x0ff00000	/* extended family mask     */
-#define CPUID_F1_MOD                 0x000000f0	/* model mask               */
 #define CPUID_F1_STEP                0x0000000f	/* stepping level mask      */
 #define CPUID_XFAM_MOD               0x0ff00ff0	/* xtended fam, fam + model */
 #define ATHLON64_XFAM_MOD            0x00000f40	/* xtended fam, fam + model */
@@ -19,72 +16,64 @@
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
 #define MSR_C_LO_NEW_FID          0x0000002f
 #define MSR_C_LO_VID_SHIFT        8
 
-/* Field definitions within the FID VID High Control MSR : */
+/* control MSR - high part */
 #define MSR_C_HI_STP_GNT_TO       0x000fffff
 
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
 
 #define MAX_FID 0x2a	/* Spec only gives FID values as far as 5 GHz */
-
 #define LEAST_VID 0x1e	/* Lowest (numerically highest) useful vid value */
 
 #define MIN_FREQ 800	/* Min and max freqs, per spec */
 #define MAX_FREQ 5000
 
 #define INVALID_FID_MASK 0xffffffc1  /* not a valid fid if these bits are set */
-
 #define INVALID_VID_MASK 0xffffffe0  /* not a valid vid if these bits are set */
 
-#define STOP_GRANT_5NS 1 /* min poss memory access latency for voltage change */
 
-#define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
+#define STOP_GRANT_5NS    1 /* min memory access latency for voltage change   */
+#define MAXIMUM_VID_STEPS 1 /* Current cpus only allow a single step of 25mV  */
+#define VST_UNITS_20US   20 /* Voltage Stabilization Time is in units of 20us */
 
-#define MAXIMUM_VID_STEPS 1  /* Current cpus only allow a single step of 25mV */
+#define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
 
-#define VST_UNITS_20US 20   /* Voltage Stabalization Time is in units of 20us */
 
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
+ * supported by this particular processor. This information is obtained from
+ * the data sheets for each processor model by the system vendor and
+ * incorporated into the BIOS.
+ * If the data in the PSB / PST is wrong, then this driver will program the
+ * wrong values into hardware, which is very likely to lead to a crash.
+ */
 
 #define PSB_ID_STRING      "AMDK7PNOW!"
 #define PSB_ID_STRING_LEN  10

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
