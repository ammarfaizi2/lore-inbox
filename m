Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVDLTZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVDLTZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVDLTSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:18:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:38345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262112AbVDLKca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:30 -0400
Message-Id: <200504121032.j3CAWHoj005549@shell0.pdx.osdl.net>
Subject: [patch 103/198] x86, x86_64: dual core proc-cpuinfo and sibling-map fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>

- broken sibling_map setup in x86_64

- grouping all the core and HT related cpuinfo fields.
  We are reasonably sure that adding new cpuinfo fields after "siblings" field,
  will not cause any app failure. Thats because today's /proc/cpuinfo
  format is completely different on x86, x86_64 and we haven't heard of any
  x86 app breakage because of this issue. Grouping these fields will 
  result in more or less common format on all architectures (ia64, x86 and 
  x86_64) and will cause less confusion.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/cpu/proc.c  |    9 ++-------
 25-akpm/arch/x86_64/kernel/setup.c   |   11 +++--------
 25-akpm/arch/x86_64/kernel/smpboot.c |    2 +-
 3 files changed, 6 insertions(+), 16 deletions(-)

diff -puN arch/i386/kernel/cpu/proc.c~x86-x86_64-dual-core-proc-cpuinfo-and-sibling-map-fix arch/i386/kernel/cpu/proc.c
--- 25/arch/i386/kernel/cpu/proc.c~x86-x86_64-dual-core-proc-cpuinfo-and-sibling-map-fix	2005-04-12 03:21:27.681928608 -0700
+++ 25-akpm/arch/i386/kernel/cpu/proc.c	2005-04-12 03:21:27.687927696 -0700
@@ -98,6 +98,8 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
 		seq_printf(m, "siblings\t: %d\n",
 				c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
+		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
 	}
 #endif
 	
@@ -130,13 +132,6 @@ static int show_cpuinfo(struct seq_file 
 		     c->loops_per_jiffy/(500000/HZ),
 		     (c->loops_per_jiffy/(5000/HZ)) % 100);
 
-#ifdef CONFIG_SMP
-	/* Put new fields at the end to lower the probability of
-	   breaking user space parsers. */
-	seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
-	seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
-#endif
-
 	return 0;
 }
 
diff -puN arch/x86_64/kernel/setup.c~x86-x86_64-dual-core-proc-cpuinfo-and-sibling-map-fix arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86-x86_64-dual-core-proc-cpuinfo-and-sibling-map-fix	2005-04-12 03:21:27.683928304 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:27.688927544 -0700
@@ -1152,6 +1152,8 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[cpu]);
 		seq_printf(m, "siblings\t: %d\n",
 				c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[cpu]);
+		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
 	}
 #endif	
 
@@ -1195,15 +1197,8 @@ static int show_cpuinfo(struct seq_file 
 			}
 	}
 
-	seq_printf(m, "\n");
+	seq_printf(m, "\n\n");
 
-#ifdef CONFIG_SMP
-	/* Put new fields at the end to lower the probability of
-	   breaking user space parsers. */
-	seq_printf(m, "core id\t\t: %d\n", cpu_core_id[c - cpu_data]);
-	seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
-#endif
-	seq_printf(m, "\n");
 	return 0;
 }
 
diff -puN arch/x86_64/kernel/smpboot.c~x86-x86_64-dual-core-proc-cpuinfo-and-sibling-map-fix arch/x86_64/kernel/smpboot.c
--- 25/arch/x86_64/kernel/smpboot.c~x86-x86_64-dual-core-proc-cpuinfo-and-sibling-map-fix	2005-04-12 03:21:27.684928152 -0700
+++ 25-akpm/arch/x86_64/kernel/smpboot.c	2005-04-12 03:21:27.689927392 -0700
@@ -652,7 +652,7 @@ static __cpuinit void detect_siblings(vo
 		int i;
 		if (smp_num_siblings > 1) {
 			for_each_online_cpu (i) {
-				if (cpu_core_id[cpu] == phys_proc_id[i]) {
+				if (cpu_core_id[cpu] == cpu_core_id[i]) {
 					siblings++;
 					cpu_set(i, cpu_sibling_map[cpu]);
 				}
_
