Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUELX4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUELX4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUELX4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:56:39 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:46598
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263551AbUELX4W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:56:22 -0400
Date: Wed, 12 May 2004 16:56:24 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.ork.uk, pavel@ucw.cz
Subject: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6
Message-ID: <20040512235623.GA9234@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Following is the updated patch to make the powernow-k8 driver work on 
machines with buggy BIOS, such as emachines m6805.

The patch overrides the PST table only if check_pst_table() fails.

The minimum value for the override is 800MHz, which is the lowest value 
on all x86_64 systems AFAIK. The max value is the current running value.

This patch should be safe to apply, even if Pavel's ACPI table check is
added to the driver. Or does anybody see a problem with it?

Regards,

Tony


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.6-powernow-k8-buggy-bios"

Amd64 cpufreq driver patch to override a buggy BIOS table with
current running speed as max value, and 800MHz as the low value.
Allows the driver to work on buggy BIOSes, such as m680x laptops.

This patch contains updates to the following files:
   b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c

diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Wed May 12 15:42:18 2004
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Wed May 12 15:42:18 2004
@@ -42,6 +42,8 @@
 #define VERSION "version 1.00.08b"
 #include "powernow-k8.h"
 
+#define MAX_NR_PST	16
+
 /* serialize freq changes  */
 static DECLARE_MUTEX(fidvid_sem);
 
@@ -482,6 +484,23 @@
 
 }
 
+/*
+ * This is the place to override the buggy BIOS values
+ */
+static int override_pst_table(struct powernow_k8_data *data, struct pst_s *pst) {
+	printk(KERN_INFO PFX "BIOS error: overriding frequency table\n");
+
+	/* Use a safe minimum speed 800MHz */
+	pst[0].fid = 0x00;
+	pst[0].vid = 0x12;
+
+	/* Use current speed as the maximum speed */
+	pst[1].fid = data->currfid;
+	pst[1].vid = data->currvid;
+
+	return 2;
+}
+
 static int check_pst_table(struct powernow_k8_data *data, struct pst_s *pst, u8 maxvid)
 {
 	unsigned int j;
@@ -538,6 +557,7 @@
 {
 	struct cpufreq_frequency_table *powernow_table;
 	unsigned int j;
+	struct pst_s *pst_tmp;
 
 	if (data->batps) {    /* use ACPI support to get full speed on mains power */
 		printk(KERN_WARNING PFX "Only %d pstates usable (use ACPI driver for full range\n", data->batps);
@@ -555,39 +575,49 @@
 		printk(KERN_ERR PFX "no p states to transition\n");
 		return -ENODEV;
 	}
-                                                                                                    
+
+	/* Must have the current values early in case of override_pst_table() */
+	if (query_current_values_with_pending_wait(data))
+		return -EIO;
+
+	/* Copy the BIOS table into a temporary table in case it needs override */
+	pst_tmp = kmalloc(sizeof(struct pst_s) * MAX_NR_PST, GFP_KERNEL);
+	if (!pst_tmp) {
+		printk(KERN_ERR PFX "pst_tmp memory alloc failure\n");
+		return -ENOMEM;
+	}
+	memset(pst_tmp, 0, sizeof(struct pst_s) * MAX_NR_PST);
+	memcpy(pst_tmp, pst, sizeof(struct pst_s) * data->numps);	
+
 	if (check_pst_table(data, pst, maxvid))
-		return -EINVAL;
+		data->numps = override_pst_table(data, pst_tmp);
 
 	powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table)
 		* (data->numps + 1)), GFP_KERNEL);
 	if (!powernow_table) {
 		printk(KERN_ERR PFX "powernow_table memory alloc failure\n");
+		kfree(pst_tmp);
 		return -ENOMEM;
 	}
 
 	for (j = 0; j < data->numps; j++) {
-		powernow_table[j].index = pst[j].fid; /* lower 8 bits */
-		powernow_table[j].index |= (pst[j].vid << 8); /* upper 8 bits */
-		powernow_table[j].frequency = find_khz_freq_from_fid(pst[j].fid);
+		powernow_table[j].index = pst_tmp[j].fid; /* lower 8 bits */
+		powernow_table[j].index |= (pst_tmp[j].vid << 8); /* upper 8 bits */
+		powernow_table[j].frequency = find_khz_freq_from_fid(pst_tmp[j].fid);
 	}
 	powernow_table[data->numps].frequency = CPUFREQ_TABLE_END;
 	powernow_table[data->numps].index = 0;
 
-	if (query_current_values_with_pending_wait(data)) {
-		kfree(powernow_table);
-		return -EIO;
-	}
-
 	dprintk(KERN_INFO PFX "cfid 0x%x, cvid 0x%x\n", data->currfid, data->currvid);
 	data->powernow_table = powernow_table;
 	print_basics(data);
 
 	for (j = 0; j < data->numps; j++)
-		if ((pst[j].fid==data->currfid) && (pst[j].vid==data->currvid))
+		if ((pst_tmp[j].fid==data->currfid) && (pst_tmp[j].vid==data->currvid))
 			return 0;
 
 	dprintk(KERN_ERR PFX "currfid/vid do not match PST, ignoring\n");
+	kfree(pst_tmp);
 	return 0;
 }
 
@@ -637,8 +667,8 @@
 
 		dprintk(KERN_DEBUG PFX "numpst: 0x%x\n", psb->numpst);
 		if (psb->numpst != 1) {
-			printk(KERN_ERR BFX "numpst must be 1\n");
-			return -ENODEV;
+			printk(KERN_WARNING BFX "numpst listed as %i "
+			       "should be 1. Ignoring it.\n", psb->numpst);
 		}
 
 		data->plllock = psb->plllocktime;

--d6Gm4EdcadzBjdND--
