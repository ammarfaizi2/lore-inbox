Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUIOSkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUIOSkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUIOSkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:40:33 -0400
Received: from main.gmane.org ([80.91.229.2]:63173 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267251AbUIOSkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:40:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: [PATCH][2.6.8.1] MSR fallback support for powernow-k7
Date: Wed, 15 Sep 2004 19:24:54 +0100
Message-ID: <m0em12-lqe.ln1@yggdrasl.demon.co.uk>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: yggdrasl.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NB: This is not aimed at a mainline merge - I'd have no objections,
but Dave Jones is working on a similar idea, and I'd trust his code
over mine any day...  This is more by way of a stop-gap, posted in
case anyone out there might find it useful.


This patch adds support for reading the model-specific registers
of K7 mobile processors when building the CPU frequency tables
if the BIOS fails to provide any useful information.  Typically
it will result in two power states being available - the BIOS
boot speed and the CPU's maximum rated speed.

This is primarily of use to anyone running an Athlon XP-M in a
desktop motherboard, since any laptop worth the money should
already work properly.

I've been running it on my main desktop machine for a couple of
weeks now (Athlon XP-M 2600+ in an Epox 8KHA+/VIA KT266A board)
and have had no problems so far.  That said, this feature has
the theoretical potential to *fry your hardware*.  Be warned.


Three parameters are added to the powernow-k7 module:

msr_force: Set to 1 to enable MSR fallback mode.

msr_force_latency: Set the state transition latency in microseconds.
The default is 200us, which should work on most systems, and the
minimum is 100us.  If you experience hangs on state changes, you
might want to increase this value.

msr_force_voltage_scaling: Set to 1 to enable CPU core voltage
scaling.  This is off by default, since the voltage regulators
on desktop boards may not like changing voltage on the fly.


Recommended usage:

Since enabling voltage scaling could be a bad idea, it's probably
safest to set your CPU core voltage high enough to support the
fastest speed at which the processor is going to run.  Set the
multiplier in the BIOS to the speed you want for the low-power mode,
since the module will work out the fastest speed quite happily.


I intend to maintain an up-to-date version of this patch at
http://www.yggdrasl.demon.co.uk/code/ until such time as something
better-written comes along (which I hope will be soon :) .


Sincere thanks to Dave Jones for all his help and advice in
getting this working.


Signed-off-by: Adam Jones <adam@yggdrasl.demon.co.uk>

--- linux-2.6.8.1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c.orig	2004-08-23 22:09:54.730011446 +0100
+++ linux-2.6.8.1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-08-24 18:27:07.975895358 +0100
@@ -97,6 +97,9 @@ static int fid_codes[32] = {
  */
 
 static int acpi_force;
+static int msr_force;
+static int msr_force_latency;
+static int msr_force_voltage_scaling;
 
 static struct cpufreq_frequency_table *powernow_table;
 
@@ -414,6 +417,116 @@ static int powernow_acpi_init(void)
 }
 #endif
 
+static int powernow_decode_msr (union msr_fidvidstatus *fidvidstatus)
+{
+	unsigned int i;
+	unsigned int add_initial, add_max;
+
+	/* FIXME: Is there a way to determine a safe value here
+         *        in the absence of any hints from the BIOS? */
+	if (msr_force_latency > 0) {
+		if (msr_force_latency < 100) {
+			printk (KERN_INFO PFX "Settling time passed as %d microseconds."
+				"Should be at least 100. Correcting.\n", msr_force_latency);
+			msr_force_latency = 100;
+		}
+		latency = msr_force_latency;
+	} else {
+		latency = 200;
+	}
+	dprintk (KERN_INFO PFX "Settling Time: %d microseconds.\n", latency);
+
+	/* We have three possible settings - initial, current
+         * and maximum. */
+	number_scales = 3;
+
+	/* Whatever the BIOS set up initially must work... */
+	if (fidvidstatus->bits.CFID != fidvidstatus->bits.SFID) {
+		dprintk (KERN_INFO PFX "Current frequency differs from initial BIOS setting.\n");
+		add_initial = 1;
+	} else {
+		add_initial = 0;
+	}
+
+	/* If the CPU-reported maximum is different to our current
+	 * setting, we want to make it available. */
+	if ((fidvidstatus->bits.CFID != fidvidstatus->bits.MFID) &&
+		(fidvidstatus->bits.MFID != fidvidstatus->bits.SFID)) {
+
+		dprintk (KERN_INFO PFX "Current frequency differs from CPU reported maximum.\n");
+		add_max = 1;
+	} else {
+		add_max = 0;
+	}
+
+	powernow_table = kmalloc((sizeof(struct cpufreq_frequency_table) * (number_scales + 1)), GFP_KERNEL);
+	if (!powernow_table)
+		return -ENOMEM;
+	memset(powernow_table, 0, (sizeof(struct cpufreq_frequency_table) * (number_scales + 1)));
+
+	for (i = 0; i < number_scales; i++) {
+		unsigned int speed, valid;
+		u8 fid, vid;
+
+		switch (i) {
+		case 0:
+			/* Current settings */
+			fid = fidvidstatus->bits.CFID;
+			vid = fidvidstatus->bits.CVID;
+			valid = 1;
+			break;
+		case 1:
+			/* BIOS initial settings */
+			fid = fidvidstatus->bits.SFID;
+			vid = fidvidstatus->bits.SVID;
+			valid = add_initial;
+			break;
+		case 2:
+			/* CPU-reported maximum settings */
+			fid = fidvidstatus->bits.MFID;
+			vid = fidvidstatus->bits.MVID;
+			valid = add_max;
+			break;
+		default:
+			vid = 0;
+			fid = 0;
+			valid = 0;
+		}
+
+		if (valid) {
+			/* Add to frequency table */
+			speed = fsb * fid_codes[fid] / 10;
+
+			/* Do not scale voltages unless forced,
+			 * since it could be dangerous. */
+			if (!msr_force_voltage_scaling) {
+				vid = fidvidstatus->bits.CVID;
+			}
+
+			dprintk (KERN_INFO PFX "   FID: 0x%x (%d.%dx [%dMHz])\t", fid, fid_codes[fid] / 10, fid_codes[fid] % 10, speed/1000);
+			dprintk ("VID: 0x%x (%d.%03dV)\n", vid,	mobile_vid_table[vid]/1000, mobile_vid_table[vid]%1000);
+
+			powernow_table[i].frequency = speed;
+			powernow_table[i].index = fid; /* lower 8 bits */
+			powernow_table[i].index |= (vid << 8); /* upper 8 bits */
+			if (speed < minimum_speed)
+				minimum_speed = speed;
+			if (speed > maximum_speed)
+				maximum_speed = speed;
+		} else {
+			/* Add a dummy entry and carry on */
+			powernow_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+			powernow_table[i].index = 0;
+		}
+	}
+
+	/* Terminate frequency list */
+	powernow_table[number_scales].frequency = CPUFREQ_TABLE_END;
+	powernow_table[number_scales].index = 0;
+
+	return 0;
+}
+
 static int powernow_decode_bios (int maxfid, int startvid)
 {
 	struct psb_s *psb;
@@ -620,6 +733,11 @@ static int __init powernow_cpu_init (str
 		}
 	}
 
+	if (result && msr_force) {
+		printk (KERN_INFO PFX "Building frequency table from MSR info.\n");
+		result = powernow_decode_msr(&fidvidstatus);
+	}
+
 	if (result)
 		return result;
 
@@ -681,6 +799,12 @@ static void __exit powernow_exit (void)
 
 module_param(acpi_force,  int, 0444);
 MODULE_PARM_DESC(acpi_force, "Force ACPI to be used");
+module_param(msr_force,  int, 0444);
+MODULE_PARM_DESC(msr_force, "Force fallback to CPU MSR info");
+module_param(msr_force_latency,  int, 0444);
+MODULE_PARM_DESC(msr_force_latency, "Set state transition latency in microseconds (default 200us)");
+module_param(msr_force_voltage_scaling,  int, 0444);
+MODULE_PARM_DESC(msr_force_voltage_scaling, "Enable CPU core voltage scaling");
 
 MODULE_AUTHOR ("Dave Jones <davej@codemonkey.org.uk>");
 MODULE_DESCRIPTION ("Powernow driver for AMD K7 processors.");


-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

