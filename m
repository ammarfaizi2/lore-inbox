Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbTAMMRA>; Mon, 13 Jan 2003 07:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267848AbTAMMQ6>; Mon, 13 Jan 2003 07:16:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:29168 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267846AbTAMMQz>; Mon, 13 Jan 2003 07:16:55 -0500
Date: Mon, 13 Jan 2003 18:08:25 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 4/4 -- sparc arch
Message-ID: <20030113123825.GF2714@in.ibm.com>
References: <20030113122835.GC2714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113122835.GC2714@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one's for sparc


diff -ruN -X dontdiff linux-2.5.55/arch/sparc/kernel/smp.c prof_counter-2.5.55/arch/sparc/kernel/smp.c
--- linux-2.5.55/arch/sparc/kernel/smp.c	Thu Jan  9 09:33:58 2003
+++ prof_counter-2.5.55/arch/sparc/kernel/smp.c	Mon Jan 13 14:35:15 2003
@@ -256,7 +256,7 @@
 }
 
 unsigned int prof_multiplier[NR_CPUS];
-unsigned int prof_counter[NR_CPUS];
+DEFINE_PER_CPU(unsigned int, prof_counter);
 extern unsigned int lvl14_resolution;
 
 int setup_profiling_timer(unsigned int multiplier)
diff -ruN -X dontdiff linux-2.5.55/arch/sparc/kernel/sun4d_smp.c prof_counter-2.5.55/arch/sparc/kernel/sun4d_smp.c
--- linux-2.5.55/arch/sparc/kernel/sun4d_smp.c	Thu Jan  9 09:33:55 2003
+++ prof_counter-2.5.55/arch/sparc/kernel/sun4d_smp.c	Mon Jan 13 14:37:21 2003
@@ -431,7 +431,7 @@
 }
 
 extern unsigned int prof_multiplier[NR_CPUS];
-extern unsigned int prof_counter[NR_CPUS];
+DECLARE_PER_CPU(unsigned int, prof_counter);
 
 extern void sparc_do_profile(unsigned long pc, unsigned long o7);
 
@@ -455,14 +455,14 @@
 	if(!user_mode(regs))
 		sparc_do_profile(regs->pc, regs->u_regs[UREG_RETPC]);
 
-	if(!--prof_counter[cpu]) {
+	if(!--per_cpu(prof_counter, cpu)) {
 		int user = user_mode(regs);
 
 		irq_enter();
 		update_process_times(user);
 		irq_exit();
 
-		prof_counter[cpu] = prof_multiplier[cpu];
+		per_cpu(prof_counter, cpu) = prof_multiplier[cpu];
 	}
 }
 
@@ -472,7 +472,7 @@
 {
 	int cpu = hard_smp4d_processor_id();
 
-	prof_counter[cpu] = prof_multiplier[cpu] = 1;
+	per_cpu(prof_counter, cpu) = prof_multiplier[cpu] = 1;
 	load_profile_irq(cpu, lvl14_resolution);
 }
 
