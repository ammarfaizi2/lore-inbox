Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWGKFUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWGKFUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWGKFUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:20:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:13131 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965158AbWGKFUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:20:13 -0400
X-IronPort-AV: i="4.06,223,1149490800"; 
   d="scan'208"; a="63304065:sNHT16970254"
Subject: [BUG] cpu_khz isn't reliable at boot time
From: Shaohua Li <shaohua.li@intel.com>
To: cpufreq@lists.linux.org.uk, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 13:17:36 +0800
Message-Id: <1152595057.21189.150.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mobile system, BIOS usually sets CPU to low speed. In modern CPU, TSC
is constant speed regardless of CPU speed. Linux uses TSC to calculate
cpu_khz, which is the full speed frequence of CPU instead of low speed
in some systems. This might invoke some potential issues. One is NMI
watchdog, which runs less frequently in cpu low speed mode.

Below workaround from Len addressed the NMI issue, any idea?

diff --git a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
index d43b498..b157186 100644
--- a/arch/i386/kernel/nmi.c
+++ b/arch/i386/kernel/nmi.c
@@ -150,7 +150,12 @@ #ifdef CONFIG_SMP
 		if (!cpu_isset(cpu, cpu_callin_map))
 			continue;
 #endif
-		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
+		/*
+		 * Fail if there were NO watchdog interrupts recorded.
+		 * We don't know the exact number to expect because
+		 * cpu_khz is variable.
+		 */
+		if ((nmi_count(cpu) - prev_nmi_count[cpu]) == 0) {
 			endflag = 1;
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
 				cpu,
@@ -357,6 +362,11 @@ static void clear_msr_range(unsigned int
 		wrmsr(base+i, 0, 0);
 }
 
+/*
+ * n.b.
+ * cpu_khz may not reflect the current or future khz of the processor
+ * depending on what speed the system booted at and if cpufreq is running
+ */
 static void write_watchdog_counter(const char *descr)
 {
 	u64 count = (u64)cpu_khz * 1000;
