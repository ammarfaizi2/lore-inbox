Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUHMFG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUHMFG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268991AbUHMFG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:06:58 -0400
Received: from ozlabs.org ([203.10.76.45]:2248 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268989AbUHMFGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:06:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.19550.817213.699190@cargo.ozlabs.ibm.com>
Date: Fri, 13 Aug 2004 15:06:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (1/4) Use platform numbering of cpus for hypervisor calls.
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were using Linux's cpu numbering for cpu-related hypervisor calls
(e.g. vpa registration, H_CONFER).  It happened to work most of the
time because Linux and the hypervisor usually, but not always, have
the same numbering for cpus.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/smp.c~ppc64_fix_hcall_cpuids arch/ppc64/kernel/smp.c
--- 2.6-tip/arch/ppc64/kernel/smp.c~ppc64_fix_hcall_cpuids	2004-08-03 18:06:53.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/kernel/smp.c	2004-08-03 18:06:53.000000000 -0500
@@ -487,11 +487,11 @@ static void __init smp_space_timers(unsi
 #ifdef CONFIG_PPC_PSERIES
 void vpa_init(int cpu)
 {
-	unsigned long flags;
+	unsigned long flags, pcpu = get_hard_smp_processor_id(cpu);
 
 	/* Register the Virtual Processor Area (VPA) */
 	flags = 1UL << (63 - 18);
-	register_vpa(flags, cpu, __pa((unsigned long)&(paca[cpu].lppaca)));
+	register_vpa(flags, pcpu, __pa((unsigned long)&(paca[cpu].lppaca)));
 }
 
 static inline void smp_xics_do_message(int cpu, int msg)
diff -puN arch/ppc64/lib/locks.c~ppc64_fix_hcall_cpuids arch/ppc64/lib/locks.c
--- 2.6-tip/arch/ppc64/lib/locks.c~ppc64_fix_hcall_cpuids	2004-08-03 18:06:53.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/lib/locks.c	2004-08-03 18:06:53.000000000 -0500
@@ -63,7 +63,8 @@ void __spin_yield(spinlock_t *lock)
 	HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
 		((u64)holder_cpu << 32) | yield_count);
 #else
-	plpar_hcall_norets(H_CONFER, holder_cpu, yield_count);
+	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(holder_cpu),
+			   yield_count);
 #endif
 }
 
@@ -179,7 +180,8 @@ void __rw_yield(rwlock_t *rw)
 	HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
 		((u64)holder_cpu << 32) | yield_count);
 #else
-	plpar_hcall_norets(H_CONFER, holder_cpu, yield_count);
+	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(holder_cpu),
+			   yield_count);
 #endif
 }
 
