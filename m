Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266559AbUBESvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUBESvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:51:11 -0500
Received: from gprs146-93.eurotel.cz ([160.218.146.93]:129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266559AbUBESuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:50:52 -0500
Date: Thu, 5 Feb 2004 19:48:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040205184841.GB590@elf.ucw.cz>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205181704.GC7658@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Someone should really bug them to fix their BIOS. (BTW does keyboard work
> > ok for you?) 
> 
> No problems with keyboard, and the cpufreq works fine with the patch, but
> not at all without the patch.

Attached is my cpufreq patch. You may still prefer yours, but this one
has correct tables derived from ACPI.

> There are some ACPI related issues though, such as: via-rhine gets wrong 
> irq with ACPI on, system hangs with yenta_socket loaded if I 
> connect/disconnect the power cord... So for now, I don't use the
> PCMCIA.

They did something very stupid with io-ports at 0x4000. This should
work around it. [Note, I probably have slightly different machine from
you.]

Index: linux/include/asm-i386/pci.h
===================================================================
--- linux.orig/include/asm-i386/pci.h	2004-02-04 23:51:38.000000000 +0100
+++ linux/include/asm-i386/pci.h	2004-02-05 02:26:36.000000000 +0100
@@ -20,7 +20,7 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
-#define PCIBIOS_MIN_CARDBUS_IO	0x4000
+#define PCIBIOS_MIN_CARDBUS_IO	0x5000
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
Index: linux/include/asm-x86_64/pci.h
===================================================================
--- linux.orig/include/asm-x86_64/pci.h	2004-02-04 23:51:38.000000000 +0100
+++ linux/include/asm-x86_64/pci.h	2004-02-05 02:26:36.000000000 +0100
@@ -24,7 +24,7 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
 
-#define PCIBIOS_MIN_CARDBUS_IO	0x4000
+#define PCIBIOS_MIN_CARDBUS_IO	0x5000
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);

 

> > Going though ACPI solves this, and I have perhaps better
> > patch to hardcode right values...
> 
> Still, the max speed check should be safe. Maybe pass values as module
> options too? I would not trust on ACPI working right on this machine :)
> 
> Tony


Index: linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-04 23:51:40.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-02-05 02:25:37.000000000 +0100
@@ -31,7 +31,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.00.08 - September 26, 2003"
+#define VERSION "version 1.00.08a"
 #include "powernow-k8.h"
 
 #ifdef CONFIG_PREEMPT
@@ -44,7 +44,7 @@
 static u32 rvo;		/* ramp voltage offset, from PSB */
 static u32 irt;		/* isochronous relief time, from PSB */
 static u32 vidmvs;	/* usable value calculated from mvs, from PSB */
-struct pst_s *ppst;	/* array of p states, valid for this part */
+static struct pst_s *ppst; /* array of p states, valid for this part */
 static u32 currvid;	/* keep track of the current fid / vid */
 static u32 currfid;
 
@@ -107,23 +107,27 @@
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
 	u32 i;
 	u8 tempfid;
 	u8 tempvid;
-	int swaps = 1;
+	int swaps = 2;
 
 	while (swaps) {
 		swaps = 0;
 		for (i = 0; i < (numpstates - 1); i++) {
 			if (ppst[i].fid > ppst[i + 1].fid) {
+				if (swaps == 2)
+					printk(KERN_WARNING BFX "PST table not sorted according to frequency, fixed.");
 				swaps = 1;
 				tempfid = ppst[i].fid;
 				tempvid = ppst[i].vid;
@@ -134,29 +138,29 @@
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
@@ -271,9 +275,11 @@
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
@@ -316,8 +322,10 @@
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
@@ -500,7 +508,9 @@
 	}
 
 	if (c->x86_vendor != X86_VENDOR_AMD) {
+#ifdef MODULE
 		printk(KERN_INFO PFX "Not an AMD processor\n");
+#endif
 		return 0;
 	}
 
@@ -533,9 +543,7 @@
 		return 0;
 	}
 
-	printk(KERN_INFO PFX "Found AMD Athlon 64 / Opteron processor "
-	       "supporting p-state transitions\n");
-
+	printk(KERN_INFO PFX "Found AMD processor supporting PowerNow (" VERSION ")\n");
 	return 1;
 }
 
@@ -549,6 +557,7 @@
 	u32 lastfid;
 	u32 mvs;
 	u8 maxvid;
+	int arima = 0;
 
 	for (i = 0xc0000; i < 0xffff0; i += 0x10) {
 		/* Scan BIOS looking for the signature. */
@@ -573,51 +582,40 @@
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
 			printk(KERN_ERR BFX "numpst must be 1\n");
-			return -ENODEV;
+			if (psb->numpst == 3) {
+				printk(KERN_INFO PFX "assuming arima notebug\n");
+				arima = 1;
+			} else
+				return -ENODEV;
 		}
 
 		dprintk(KERN_DEBUG PFX "cpuid: 0x%x\n", psb->cpuid);
 
 		plllock = psb->plllocktime;
-		printk(KERN_INFO PFX "pll lock time: 0x%x\n", plllock);
+		printk(KERN_INFO PFX "pll lock time: 0x%x, ", plllock);
 
 		maxvid = psb->maxvid;
-		printk(KERN_INFO PFX "maxfid: 0x%x\n", psb->maxfid);
-		printk(KERN_INFO PFX "maxvid: 0x%x\n", maxvid);
+		printk("maxfid 0x%x (%d MHz), maxvid 0x%x\n", 
+		       psb->maxfid, find_freq_from_fid(psb->maxfid), maxvid);
 
 		numps = psb->numpstates;
-		printk(KERN_INFO PFX "numpstates: 0x%x\n", numps);
 		if (numps < 2) {
 			printk(KERN_ERR BFX "no p states to transition\n");
 			return -ENODEV;
@@ -637,10 +635,15 @@
 		}
 
 		if ((numps <= 1) || (batps <= 1)) {
+			/* FIXME: Is this right? I can see one state on battery, two states total as an usefull config */
 			printk(KERN_ERR PFX "only 1 p-state to transition\n");
 			return -ENODEV;
 		}
 
+#ifdef THREE
+		if (arima)
+			numps = 3;
+#endif
 		ppst = kmalloc(sizeof (struct pst_s) * numps, GFP_KERNEL);
 		if (!ppst) {
 			printk(KERN_ERR PFX "ppst memory alloc failure\n");
@@ -651,12 +654,23 @@
 		for (j = 0; j < numps; j++) {
 			ppst[j].fid = pst[j].fid;
 			ppst[j].vid = pst[j].vid;
-			printk(KERN_INFO PFX
-			       "   %d : fid 0x%x, vid 0x%x\n", j,
-			       ppst[j].fid, ppst[j].vid);
+		}
+		if (arima) {
+			ppst[1].fid = 0x8;
+			ppst[1].vid = 0x6;
+#ifdef THREE
+			ppst[2].fid = 0xa;
+			ppst[2].vid = 0x2;
+#endif
 		}
 		sort_pst(ppst, numps);
 
+		for (j = 0; j < numps; j++) {
+			printk(KERN_INFO PFX
+			       "   %d : fid 0x%x (%d MHz), vid 0x%x\n", j,
+			       ppst[j].fid, find_freq_from_fid(ppst[j].fid), ppst[j].vid);
+		}
+
 		lastfid = ppst[0].fid;
 		if (lastfid > LO_FID_TABLE_TOP)
 			printk(KERN_INFO BFX "first fid not in lo freq tbl\n");
@@ -687,14 +701,10 @@
 			if (ppst[j].vid < rvo) {	/* vid+rvo >= 0 */
 				printk(KERN_ERR BFX
 				       "0 vid exceeded with pstate %d\n", j);
-				kfree(ppst);
-				return -ENODEV;
 			}
 			if (ppst[j].vid < maxvid+rvo) { /* vid+rvo >= maxvid */
 				printk(KERN_ERR BFX
 				       "maxvid exceeded with pstate %d\n", j);
-				kfree(ppst);
-				return -ENODEV;
 			}
 		}
 
@@ -703,8 +713,8 @@
 			return -EIO;
 		}
 
-		printk(KERN_INFO PFX "currfid 0x%x, currvid 0x%x\n",
-		       currfid, currvid);
+		printk(KERN_INFO PFX "currfid 0x%x (%d MHz), currvid 0x%x\n",
+		       currfid, find_freq_from_fid(currfid), currvid);
 
 		for (j = 0; j < numps; j++)
 			if ((ppst[j].fid==currfid) && (ppst[j].vid==currvid))
@@ -718,8 +728,10 @@
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
@@ -985,8 +997,6 @@
 {
 	int rc;
 
-	printk(KERN_INFO PFX VERSION "\n");
-
 	if (check_supported_cpu() == 0)
 		return -ENODEV;
 



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
