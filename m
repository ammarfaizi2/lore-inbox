Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVDLF4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVDLF4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVDLF4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:56:07 -0400
Received: from fmr21.intel.com ([143.183.121.13]:36257 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262064AbVDLFyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:54:07 -0400
Date: Mon, 11 Apr 2005 22:42:29 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@muc.de, akpm@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [patch] x86, x86_64: dual core proc-cpuinfo and sibling-map fix
Message-ID: <20050411224228.A5445@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended patch fixes

- broken sibling_map setup in x86_64

- grouping all the core and HT related cpuinfo fields.
  We are reasonably sure that adding new cpuinfo fields after "siblings" field,
  will not cause any app failure. Thats because today's /proc/cpuinfo
  format is completely different on x86, x86_64 and we haven't heard of any
  x86 app breakage because of this issue. Grouping these fields will 
  result in more or less common format on all architectures (ia64, x86 and 
  x86_64) and will cause less confusion.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -Nru linux-2.6.12-rc2-mm3/arch/i386/kernel/cpu/proc.c linux-mc/arch/i386/kernel/cpu/proc.c
--- linux-2.6.12-rc2-mm3/arch/i386/kernel/cpu/proc.c	2005-04-11 17:12:16.939435632 -0700
+++ linux-mc/arch/i386/kernel/cpu/proc.c	2005-04-11 17:13:31.757061624 -0700
@@ -98,6 +98,8 @@
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
 		seq_printf(m, "siblings\t: %d\n",
 				c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
+		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
 	}
 #endif
 	
@@ -130,13 +132,6 @@
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
 
diff -Nru linux-2.6.12-rc2-mm3/arch/x86_64/kernel/setup.c linux-mc/arch/x86_64/kernel/setup.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/setup.c	2005-04-11 17:12:17.074415112 -0700
+++ linux-mc/arch/x86_64/kernel/setup.c	2005-04-11 17:14:34.250561168 -0700
@@ -1179,6 +1179,8 @@
 		seq_printf(m, "physical id\t: %d\n", phys_proc_id[cpu]);
 		seq_printf(m, "siblings\t: %d\n",
 				c->x86_num_cores * smp_num_siblings);
+		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[cpu]);
+		seq_printf(m, "cpu cores\t: %d\n", c->x86_num_cores);
 	}
 #endif	
 
@@ -1222,15 +1224,8 @@
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
 
diff -Nru linux-2.6.12-rc2-mm3/arch/x86_64/kernel/smpboot.c linux-mc/arch/x86_64/kernel/smpboot.c
--- linux-2.6.12-rc2-mm3/arch/x86_64/kernel/smpboot.c	2005-04-11 17:12:17.076414808 -0700
+++ linux-mc/arch/x86_64/kernel/smpboot.c	2005-04-11 17:41:52.704478312 -0700
@@ -652,7 +652,7 @@
 		int i;
 		if (smp_num_siblings > 1) {
 			for_each_online_cpu (i) {
-				if (cpu_core_id[cpu] == phys_proc_id[i]) {
+				if (cpu_core_id[cpu] == cpu_core_id[i]) {
 					siblings++;
 					cpu_set(i, cpu_sibling_map[cpu]);
 				}
