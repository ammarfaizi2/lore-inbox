Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUG1VTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUG1VTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUG1VTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:19:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18121 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264113AbUG1VTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:19:39 -0400
Subject: [PATCH] Create cpu_sibling_map for PPC64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE Tech <lse-tech@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091049554.19459.33.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jul 2004 14:19:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In light of some proposed changes in the sched_domains code, I coded up
this little ditty that simply creates and populates a cpu_sibling_map
for PPC64 machines.  The patch just checks the CPU flags to determine if
the CPU supports SMT (aka Hyper-Threading aka Multi-Threading aka ...)
and fills in a mask of the siblings for each CPU in the system.  This
should allow us to build sched_domains for PPC64 with generic code in
kernel/sched.c for the SMT systems.  SMT is becoming more popular and is
turning up in more and more architectures.  I don't think it will be too
long until this feature is supported by most arches...

[mcd@arrakis source]$ diffstat
~/linux/patches/ppc64-cpu_sibling_map.patch
 arch/ppc64/kernel/smp.c |    7 +++++++
 include/asm-ppc64/smp.h |    1 +
 2 files changed, 8 insertions(+)

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

-Matt


diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/arch/ppc64/kernel/smp.c linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/arch/ppc64/kernel/smp.c
--- linux-2.6.8-rc2-mm1/arch/ppc64/kernel/smp.c	2004-07-28 10:50:29.000000000 -0700
+++ linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/arch/ppc64/kernel/smp.c	2004-07-28 12:02:38.000000000 -0700
@@ -64,6 +64,7 @@ cpumask_t cpu_possible_map = CPU_MASK_NO
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t cpu_available_map = CPU_MASK_NONE;
 cpumask_t cpu_present_at_boot = CPU_MASK_NONE;
+cpumask_t cpu_sibling_map[NR_CPUS] = { [0 .. NR_CPUS-1] = CPU_MASK_NONE };
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
@@ -870,6 +871,12 @@ void __init smp_prepare_cpus(unsigned in
 	for_each_cpu(cpu)
 		if (cpu != boot_cpuid)
 			smp_create_idle(cpu);
+
+	for_each_cpu(cpu) {
+		cpu_set(cpu, cpu_sibling_map[cpu]);
+		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
+	}
 }
 
 void __devinit smp_prepare_boot_cpu(void)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-ppc64/smp.h linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/include/asm-ppc64/smp.h
--- linux-2.6.8-rc2-mm1/include/asm-ppc64/smp.h	2004-07-28 10:50:50.000000000 -0700
+++ linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/include/asm-ppc64/smp.h	2004-07-28 12:02:38.000000000 -0700
@@ -49,6 +49,7 @@ extern cpumask_t cpu_present_at_boot;
 extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
 extern cpumask_t cpu_available_map;
+extern cpumask_t cpu_sibling_map[NR_CPUS];
 
 #define cpu_present_at_boot(cpu) cpu_isset(cpu, cpu_present_at_boot)
 #define cpu_available(cpu)       cpu_isset(cpu, cpu_available_map) 


