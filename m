Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVDMBaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVDMBaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVDLTy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:54:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:47304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262108AbVDLKbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:50 -0400
Message-Id: <200504121031.j3CAVjBt005395@shell0.pdx.osdl.net>
Subject: [patch 067/198] x86-64/i386: Revert cpuinfo siblings behaviour back to 2.6.10
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       Suresh.b.siddha@intel.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andi Kleen <ak@suse.de>

Only display physical id/siblings when there are siblings or dual core.

In 2.6.11 I accidentially broke it and it was always displaying these
fields But for compatibility to all these /proc parsers around it is better
to do it in the old way again.  

Noticed by Suresh Siddha

Cc: <Suresh.b.siddha@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/cpu/proc.c |    7 +++++--
 25-akpm/arch/x86_64/kernel/setup.c  |    8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/cpu/proc.c~x86-64-i386-revert-cpuinfo-siblings-behaviour-back-to-2610 arch/i386/kernel/cpu/proc.c
--- 25/arch/i386/kernel/cpu/proc.c~x86-64-i386-revert-cpuinfo-siblings-behaviour-back-to-2610	2005-04-12 03:21:19.576160872 -0700
+++ 25-akpm/arch/i386/kernel/cpu/proc.c	2005-04-12 03:21:19.580160264 -0700
@@ -94,8 +94,11 @@ static int show_cpuinfo(struct seq_file 
 	if (c->x86_cache_size >= 0)
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 #ifdef CONFIG_X86_HT
-	seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
-	seq_printf(m, "siblings\t: %d\n", c->x86_num_cores * smp_num_siblings);
+	if (c->x86_num_cores * smp_num_siblings > 1) {
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+		seq_printf(m, "siblings\t: %d\n",
+				c->x86_num_cores * smp_num_siblings);
+	}
 #endif
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
diff -puN arch/x86_64/kernel/setup.c~x86-64-i386-revert-cpuinfo-siblings-behaviour-back-to-2610 arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86-64-i386-revert-cpuinfo-siblings-behaviour-back-to-2610	2005-04-12 03:21:19.577160720 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:19.581160112 -0700
@@ -1113,8 +1113,12 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 	
 #ifdef CONFIG_SMP
-	seq_printf(m, "physical id\t: %d\n", phys_proc_id[c - cpu_data]);
-	seq_printf(m, "siblings\t: %d\n", c->x86_num_cores * smp_num_siblings);
+	if (smp_num_siblings * c->x86_num_cores > 1) {
+		int cpu = c - cpu_data;
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[cpu]);
+		seq_printf(m, "siblings\t: %d\n",
+				c->x86_num_cores * smp_num_siblings);
+	}
 #endif	
 
 	seq_printf(m,
_
