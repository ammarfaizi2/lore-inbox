Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTAMMOl>; Mon, 13 Jan 2003 07:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267846AbTAMMOk>; Mon, 13 Jan 2003 07:14:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58813 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267494AbTAMMOj>; Mon, 13 Jan 2003 07:14:39 -0500
Date: Mon, 13 Jan 2003 18:06:02 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 3/4 -- x86_64 arch
Message-ID: <20030113123602.GE2714@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113122835.GC2714@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one's for x86_64


diff -ruN -X dontdiff linux-2.5.55/arch/x86_64/kernel/apic.c prof_counter-2.5.55/arch/x86_64/kernel/apic.c
--- linux-2.5.55/arch/x86_64/kernel/apic.c	Thu Jan  9 09:33:55 2003
+++ prof_counter-2.5.55/arch/x86_64/kernel/apic.c	Mon Jan 13 14:27:46 2003
@@ -39,7 +39,7 @@
 
 int prof_multiplier[NR_CPUS] = { 1, };
 int prof_old_multiplier[NR_CPUS] = { 1, };
-int prof_counter[NR_CPUS] = { 1, };
+DEFINE_PER_CPU(int, prof_counter) =  1;
 
 int get_maxlvt(void)
 {
@@ -901,7 +901,7 @@
 
 	x86_do_profile(regs);
 
-	if (--prof_counter[cpu] <= 0) {
+	if (--per_cpu(prof_counter, cpu) <= 0) {
 		/*
 		 * The multiplier may have changed since the last time we got
 		 * to this point as a result of the user writing to
@@ -910,10 +910,11 @@
 		 *
 		 * Interrupts are already masked off at this point.
 		 */
-		prof_counter[cpu] = prof_multiplier[cpu];
-		if (prof_counter[cpu] != prof_old_multiplier[cpu]) {
-			__setup_APIC_LVTT(calibration_result/prof_counter[cpu]);
-			prof_old_multiplier[cpu] = prof_counter[cpu];
+		per_cpu(prof_counter, cpu) = prof_multiplier[cpu];
+		if (per_cpu(prof_counter, cpu) != prof_old_multiplier[cpu]) {
+			__setup_APIC_LVTT(calibration_result/
+					per_cpu(prof_counter, cpu));
+			prof_old_multiplier[cpu] = per_cpu(prof_counter, cpu);
 		}
 
 #ifdef CONFIG_SMP
diff -ruN -X dontdiff linux-2.5.55/arch/x86_64/kernel/smpboot.c prof_counter-2.5.55/arch/x86_64/kernel/smpboot.c
--- linux-2.5.55/arch/x86_64/kernel/smpboot.c	Thu Jan  9 09:34:28 2003
+++ prof_counter-2.5.55/arch/x86_64/kernel/smpboot.c	Mon Jan 13 14:30:00 2003
@@ -774,7 +774,7 @@
 
 extern int prof_multiplier[NR_CPUS];
 extern int prof_old_multiplier[NR_CPUS];
-extern int prof_counter[NR_CPUS];
+DECLARE_PER_CPU(int, prof_counter);
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
@@ -787,7 +787,7 @@
 
 	for (apicid = 0; apicid < NR_CPUS; apicid++) {
 		x86_apicid_to_cpu[apicid] = -1;
-		prof_counter[apicid] = 1;
+		per_cpu(prof_counter, apicid) = 1;
 		prof_old_multiplier[apicid] = 1;
 		prof_multiplier[apicid] = 1;
 	}
