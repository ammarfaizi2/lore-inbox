Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUAaUf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 15:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAaUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 15:35:28 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:41745
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264095AbUAaUfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 15:35:10 -0500
Date: Sat, 31 Jan 2004 12:35:12 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: davej@redhat.com
Subject: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040131203512.GA21909@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Following is a little patch to do a sanity check on the max speed and 
voltage values provided by the bios.

Some buggy bioses provide bad values if the cpu changes, for example, in 
my case the bios claims the max cpu speed is 1600MHz, while it's running at
1800MHz. (Cheapo Emachines m6805 you know...) This could also happen on 
machines where the cpu is upgraded.

These checks should be safe, as they only change things if the machine is
already running at a higher speed than the bios claims.

Regards,

Tony

A here's some sample output after applying the patch:
...
powernow-k8: Found AMD Athlon 64 / Opteron processor supporting p-state transitions
powernow-k8: voltage stable time: 5 (units 20us)
powernow-k8: p states on battery: 0 - all available
powernow-k8: ramp voltage offset: 2
powernow-k8: isochronous relief time: 3
powernow-k8: maximum voltage step: 0
powernow-k8: BIOS error: numpst listed as 8 should be 1. Using 1.
powernow-k8: pll lock time: 0x2
powernow-k8: maxfid: 0x8
powernow-k8: maxvid: 0x0
powernow-k8: numpstates: 0x2
powernow-k8:    0 : fid 0x0, vid 0x12
powernow-k8:    1 : fid 0x8, vid 0x0
powernow-k8: BIOS error: max speed fid listed as 0x08, should be at least 0x0a. Using current speed.
powernow-k8: BIOS error: max voltage vid listed as 0x00, should be at least 0x06. Using current speed.
powernow-k8: currfid 0xa, currvid 0x6
powernow-k8: cpu_init done, current fid 0xa, vid 0x6
...


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.2-pre3-powernow-k8-max-speed-check"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1550  -> 1.1551 
#	arch/i386/kernel/cpu/cpufreq/powernow-k8.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/31	tony@atomide.com	1.1551
# Sanity check on the BIOS provided max speed vs. current speed
# 
# - Moves the current speed detection a bit earlier
# - Overrides the max speed and voltage if current running values are
#   greater than BIOS provided values
# - Ignores incorrect BIOS numpst value as it is not used anyways
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Sat Jan 31 12:21:04 2004
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Sat Jan 31 12:21:05 2004
@@ -539,6 +539,34 @@
 	return 1;
 }
 
+/* Use current frequency if greater than BIOS value. */
+static inline int
+fid_check_max(int cur, int max)
+{
+	if (max < cur) {
+		printk(KERN_WARNING BFX "max speed fid listed as 0x%02x, "
+		       "should be at least 0x%02x. Using current speed.\n", 
+		       max, cur);
+		return cur;
+	}
+
+	return max;
+}
+
+/* Use current voltage if greater than BIOS value. */
+static inline int
+vid_check_max(int cur, int max)
+{
+	if (max < cur) {
+		printk(KERN_WARNING BFX "max voltage vid listed as 0x%02x, "
+		       "should be at least 0x%02x. Using current speed.\n", 
+		       max, cur);
+		return cur;
+	}
+
+	return max;
+}
+
 /* Find and validate the PSB/PST table in BIOS. */
 static inline int
 find_psb_table(void)
@@ -603,8 +631,8 @@
 
 		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
 		if (psb->numpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
-			return -ENODEV;
+			printk(KERN_WARNING BFX "numpst listed as %i "
+			       "should be 1. Using 1.\n", psb->numpst);
 		}
 
 		dprintk(KERN_DEBUG PFX "cpuid: 0x%x\n", psb->cpuid);
@@ -668,6 +696,15 @@
 			return -ENODEV;
 		}
 
+		if (query_current_values_with_pending_wait()) {
+			kfree(ppst);
+			return -EIO;
+		}
+
+		/* Do a sanity check on the max values vs. current values */
+		ppst[numps-1].fid = fid_check_max(currfid, ppst[numps-1].fid);
+		ppst[numps-1].vid = vid_check_max(currvid, ppst[numps-1].vid);
+
 		for (j = 1; j < numps; j++) {
 			if ((lastfid >= ppst[j].fid)
 			    || (ppst[j].fid & 1)
@@ -696,11 +733,6 @@
 				kfree(ppst);
 				return -ENODEV;
 			}
-		}
-
-		if (query_current_values_with_pending_wait()) {
-			kfree(ppst);
-			return -EIO;
 		}
 
 		printk(KERN_INFO PFX "currfid 0x%x, currvid 0x%x\n",

--UugvWAfsgieZRqgk--
