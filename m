Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbULFSxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbULFSxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbULFSxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:53:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58303 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261616AbULFSwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:52:47 -0500
Date: Mon, 6 Dec 2004 12:52:21 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jesse Barnes <jbarnes@sgi.com>, piggin@cyberone.com.au
Subject: [PATCH] isolcpus option broken in 2.6.10-rc2-bk2
Message-ID: <20041206185221.GA23917@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The isolcpus option is broken in 2.6.10-rc2-bk2.  The domains are no longer
being properly initialized (which results in a panic at bootup).

The following patch fixes this.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux/arch/ia64/kernel/domain.c
===================================================================
--- linux.orig/arch/ia64/kernel/domain.c	2004-12-03 15:43:47.000000000 -0600
+++ linux/arch/ia64/kernel/domain.c	2004-12-06 12:28:42.788584850 -0600
@@ -220,6 +220,23 @@ void __devinit arch_init_sched_domains(v
 						&cpu_to_phys_group);
 	}
 
+	/* Initialize isolated CPU (physical) domains and groups */
+	for_each_cpu_mask(i, cpu_isolated_map) {
+		struct sched_domain *sd = NULL;
+		int group;
+
+		sd = &per_cpu(phys_domains, i);
+		group = cpu_to_phys_group(i);
+		*sd = SD_CPU_INIT;
+		cpu_set(i, sd->span);
+		sd->flags = 0;
+		sd->balance_interval = INT_MAX;
+		sd->groups = &sched_group_phys[group];
+		init_sched_build_groups(sched_group_phys, sd->span,
+						&cpu_to_phys_group);
+		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+	}
+
 #ifdef CONFIG_NUMA
 	init_sched_build_groups(sched_group_allnodes, cpu_default_map,
 				&cpu_to_allnodes_group);
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-12-03 15:44:08.000000000 -0600
+++ linux/kernel/sched.c	2004-12-06 12:28:35.359689609 -0600
@@ -4323,6 +4323,23 @@ static void __devinit arch_init_sched_do
 						&cpu_to_phys_group);
 	}
 
+        /* Initialize isolated CPU (physical) domains and groups */
+	for_each_cpu_mask(i, cpu_isolated_map) {
+		struct sched_domain *sd = NULL;
+		int group;
+
+		sd = &per_cpu(phys_domains, i);
+		group = cpu_to_phys_group(i);
+		*sd = SD_CPU_INIT;
+		cpu_set(i, sd->span);
+		sd->flags = 0;
+		sd->balance_interval = INT_MAX;
+		sd->groups = &sched_group_phys[group];
+		init_sched_build_groups(sched_group_phys, sd->span,
+						&cpu_to_phys_group);
+		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+	}
+
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
 	init_sched_build_groups(sched_group_nodes, cpu_default_map,



