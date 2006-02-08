Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWBHMdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWBHMdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWBHMdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:33:39 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:51539 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030373AbWBHMdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:33:39 -0500
Date: Wed, 8 Feb 2006 13:33:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 03/10] s390: earlier initialization of cpu_possible_map
Message-ID: <20060208123337.GD1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Initiliazing of cpu_possible_map was done in smp_prepare_cpus which is
way too late. Therefore assign a static value to cpu_possible_map, since
we don't have access to max_cpus in setup_arch.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/smp.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-02-08 10:48:03.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-02-08 10:48:43.000000000 +0100
@@ -52,7 +52,7 @@ extern volatile int __cpu_logical_map[];
 struct _lowcore *lowcore_ptr[NR_CPUS];
 
 cpumask_t cpu_online_map;
-cpumask_t cpu_possible_map;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
 
 static struct task_struct *current_set[NR_CPUS];
 
@@ -514,9 +514,6 @@ __init smp_check_cpus(unsigned int max_c
 		num_cpus++;
 	}
 
-	for (cpu = 1; cpu < max_cpus; cpu++)
-		cpu_set(cpu, cpu_possible_map);
-
 	printk("Detected %d CPU's\n",(int) num_cpus);
 	printk("Boot cpu address %2X\n", boot_cpu_addr);
 }
@@ -810,7 +807,6 @@ void __devinit smp_prepare_boot_cpu(void
 
 	cpu_set(0, cpu_online_map);
 	cpu_set(0, cpu_present_map);
-	cpu_set(0, cpu_possible_map);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
 }
