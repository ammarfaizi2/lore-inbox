Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWADV7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWADV7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWADV7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:59:54 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:21746 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030293AbWADV7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:59:44 -0500
Date: Wed, 04 Jan 2006 16:59:21 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 02/15] p4-clockmod: Workaround for CPU's with N60 errata
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00NSH93D1L@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore clock frequencies below 2Ghz for CPU's detected with N60 errata
bug.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

3d55de109e8c3061041c1d9d0e80047ab820c835
diff --git a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
index 270f218..cc73a7a 100644
--- a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
+++ b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
@@ -52,6 +52,7 @@ enum {
 
 
 static int has_N44_O17_errata[NR_CPUS];
+static int has_N60_errata[NR_CPUS];
 static unsigned int stock_freq;
 static struct cpufreq_driver p4clockmod_driver;
 static unsigned int cpufreq_p4_get(unsigned int cpu);
@@ -226,6 +227,12 @@ static int cpufreq_p4_cpu_init(struct cp
 	case 0x0f12:
 		has_N44_O17_errata[policy->cpu] = 1;
 		dprintk("has errata -- disabling low frequencies\n");
+		break;
+
+	case 0x0f29:
+		has_N60_errata[policy->cpu] = 1;
+		dprintk("has errata -- disabling frequencies lower than 2ghz\n");
+		break;
 	}
 	
 	/* get max frequency */
@@ -237,6 +244,8 @@ static int cpufreq_p4_cpu_init(struct cp
 	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+		else if (has_N60_errata[policy->cpu] && p4clockmod_table[i].frequency < 2000000)
+			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;
 	}
-- 
1.0.5
