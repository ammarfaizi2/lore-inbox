Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbTBRVcr>; Tue, 18 Feb 2003 16:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268024AbTBRVcr>; Tue, 18 Feb 2003 16:32:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10505 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268022AbTBRVcp>; Tue, 18 Feb 2003 16:32:45 -0500
Date: Tue, 18 Feb 2003 22:42:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, davej@suse.de, linux@brodo.de
Subject: Select voltage manually in cpufreq
Message-ID: <20030218214220.GA1058@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've added possibility to manualy force specified frequency and
voltage... That's fairly usefull for testing, and I believe this (or
something equivalent) is needed because every 2nd bios seems to be
b0rken.

Take a look and apply if you want to...
								Pavel

--- clean/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-02-15 18:51:11.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2003-02-18 17:36:29.000000000 +0100
@@ -210,7 +210,7 @@
 }
 
 
-static void change_speed (unsigned int index)
+static void change_speed (unsigned int index, unsigned int voltage)
 {
 	u8 fid, vid;
 	struct cpufreq_freqs freqs;
@@ -226,6 +226,14 @@
 	fid = powernow_table[index].index & 0xFF;
 	vid = (powernow_table[index].index & 0xFF00) >> 8;
 
+	if (voltage) {
+		int i;
+		for (i=0; i<32; i++)
+			if (mobile_vid_table[i] == voltage)
+				vid = i;
+		printk("Voltage overriden to %d mV, index 0x%x\n", voltage, vid);
+	}
+
 	freqs.cpu = 0;
 
 	rdmsrl (MSR_K7_FID_VID_STATUS, fidvidstatus.val);
@@ -338,7 +346,7 @@
 	if (cpufreq_frequency_table_target(policy, powernow_table, target_freq, relation, &newstate))
 		return -EINVAL;
 
-	change_speed(newstate);
+	change_speed(newstate, policy->voltage);
 
 	return 0;
 }
--- clean/drivers/cpufreq/proc_intf.c	2003-02-18 12:24:32.000000000 +0100
+++ linux/drivers/cpufreq/proc_intf.c	2003-02-18 14:23:48.000000000 +0100
@@ -28,6 +28,7 @@
 	unsigned int            min = 0;
 	unsigned int            max = 0;
 	unsigned int            cpu = 0;
+	unsigned int		voltage = 0;
 	char			str_governor[16];
 	struct cpufreq_policy   current_policy;
 	unsigned int            result = -EFAULT;
@@ -37,9 +38,24 @@
 
 	policy->min = 0;
 	policy->max = 0;
+	policy->voltage = 0;
 	policy->policy = 0;
 	policy->cpu = CPUFREQ_ALL_CPUS;
 
+	if (sscanf(input_string, "%d:%d:%d:%15s", &cpu, &min, &voltage, str_governor) == 4)
+	{
+		if (!strcmp(str_governor, "mVforce")) {
+			printk("Have request to go to %d mV\n", voltage);
+			policy->min = min;
+			policy->max = min;
+			policy->voltage = voltage;
+			policy->cpu = cpu;
+			result = 0;
+			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+			return 0;
+		}
+	}
+
 	if (sscanf(input_string, "%d:%d:%d:%15s", &cpu, &min, &max, str_governor) == 4) 
 	{
 		policy->min = min;
--- clean/include/linux/cpufreq.h	2003-02-18 12:24:38.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-02-18 12:25:10.000000000 +0100
@@ -63,6 +63,7 @@
 	unsigned int            min;    /* in kHz */
 	unsigned int            max;    /* in kHz */
         unsigned int            policy; /* see above */
+	unsigned int		voltage;/* in mV, 0 == trust bios */
 	struct cpufreq_governor *governor; /* see below */
 	struct cpufreq_cpuinfo  cpuinfo;     /* see above */
 	struct intf_data        intf;   /* interface data */

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
