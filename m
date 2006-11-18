Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755334AbWKRWj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbWKRWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbWKRWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:39:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:31351 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1755334AbWKRWj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:39:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,437,1157353200"; 
   d="scan'208"; a="163682526:sNHT78767276"
Date: Sat, 18 Nov 2006 14:16:12 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Dhaval Giani <dhaval.giani@gmail.com>
Subject: [PATCH] Bug fix for acpi-cpufreq and cpufreq_stats oops on frequency change notification
Message-ID: <20061118141612.A25909@unix-os.sc.intel.com>
References: <8aa016e10611171322h2f736d3fo413ec81298f6a8a2@mail.gmail.com> <8aa016e10611171425u6461a170ydf0b930b46b4ad85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8aa016e10611171425u6461a170ydf0b930b46b4ad85@mail.gmail.com>; from dhaval.giani@gmail.com on Sat, Nov 18, 2006 at 03:55:06AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes the oops in cpufreq_stats with acpi_cpufreq driver.
The issue was that the frequency was reported as 0 in acpi-cpufreq.c.
The bug is due to different indicies for freq_table and ACPI perf table.

Also adds a check in cpufreq_stats to check for error return from
freq_table_get_index() and avoid using the error return value.

Patch fixes the issue reported at
http://www.ussg.iu.edu/hypermail/linux/kernel/0611.2/0629.html
and also other similar issue here
http://bugme.osdl.org/show_bug.cgi?id=7383 comment 53

Signed-off-by: Dhaval Giani <dhaval.giani@gmail.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-2.6.19-rc-mm.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-2.6.19-rc-mm/drivers/cpufreq/cpufreq_stats.c
@@ -285,6 +285,7 @@ cpufreq_stat_notifier_trans (struct noti
 	stat = cpufreq_stats_table[freq->cpu];
 	if (!stat)
 		return 0;
+
 	old_index = freq_table_get_index(stat, freq->old);
 	new_index = freq_table_get_index(stat, freq->new);
 
@@ -292,6 +293,9 @@ cpufreq_stat_notifier_trans (struct noti
 	if (old_index == new_index)
 		return 0;
 
+	if (old_index == -1 || new_index == -1)
+		return 0;
+
 	spin_lock(&cpufreq_stats_lock);
 	stat->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
Index: linux-2.6.19-rc-mm/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.19-rc-mm.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6.19-rc-mm/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -390,8 +390,8 @@ static int acpi_cpufreq_target(struct cp
 	cpumask_t online_policy_cpus;
 	struct drv_cmd cmd;
 	unsigned int msr;
-	unsigned int next_state = 0;
-	unsigned int next_perf_state = 0;
+	unsigned int next_state = 0; /* Index into freq_table */
+	unsigned int next_perf_state = 0; /* Index into perf table */
 	unsigned int i;
 	int result = 0;
 
@@ -456,8 +456,8 @@ static int acpi_cpufreq_target(struct cp
 	else
 		cpu_set(policy->cpu, cmd.mask);
 
-	freqs.old = data->freq_table[perf->state].frequency;
-	freqs.new = data->freq_table[next_perf_state].frequency;
+	freqs.old = perf->states[perf->state].core_frequency * 1000;
+	freqs.new = data->freq_table[next_state].frequency;
 	for_each_cpu_mask(i, cmd.mask) {
 		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
@@ -694,6 +694,7 @@ static int acpi_cpufreq_cpu_init(struct 
 		valid_states++;
 	}
 	data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
+	perf->state = 0;
 
 	result = cpufreq_frequency_table_cpuinfo(policy, data->freq_table);
 	if (result)
