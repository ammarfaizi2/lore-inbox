Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUH2Rbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUH2Rbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268238AbUH2R36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:29:58 -0400
Received: from holomorphy.com ([207.189.100.168]:53934 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268231AbUH2R3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:29:33 -0400
Date: Sun, 29 Aug 2004 10:29:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Message-ID: <20040829172923.GN5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave> <200408290948.06473.jbarnes@engr.sgi.com> <20040829170328.GK5492@holomorphy.com> <1093799390.10990.19.camel@mulgrave> <20040829172250.GM5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829172250.GM5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2004-08-29 at 13:03, William Lee Irwin III wrote:
> >> -#define node_to_cpumask(node)	(cpu_online_map)
> >> +#define node_to_cpumask(node)	(cpu_possible_map)
> 
> On Sun, Aug 29, 2004 at 01:09:49PM -0400, James Bottomley wrote:
> > I really don't think so.  This macro is also used at runtime, so there
> > it would return CPUs that aren't online.
> > It does look like all runtime uses in sched.c pass node_to_cpumask
> > through any_online_cpu(), so at least for the scheduler, the change may
> > be safe, but you'd have to audit all other runtime uses.

On Sun, Aug 29, 2004 at 10:22:50AM -0700, William Lee Irwin III wrote:
> ./drivers/base/node.c:22:	cpumask_t mask = node_to_cpumask(node_dev->sysdev.id);
> ./arch/ia64/sn/io/sn2/ml_SN_intr.c:63:		cpu = first_cpu(node_to_cpumask(cnode));

Okay, how about:


Index: wait-2.6.9-rc1-mm1/kernel/sched.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/sched.c	2004-08-28 11:41:47.000000000 -0700
+++ wait-2.6.9-rc1-mm1/kernel/sched.c	2004-08-29 10:25:00.468546856 -0700
@@ -4262,16 +4262,21 @@
 						&cpu_to_isolated_group);
 	}
 
-	/* Set up physical groups */
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		cpumask_t nodemask = node_to_cpumask(i);
-
-		cpus_and(nodemask, nodemask, cpu_default_map);
-		if (cpus_empty(nodemask))
-			continue;
+	if (MAX_NUMNODES == 1)
+		init_sched_build_groups(sched_group_phys, cpu_possible_map,
+							&cpu_to_phys_group);
+	else {
+		/* Set up physical groups */
+		for (i = 0; i < MAX_NUMNODES; i++) {
+			cpumask_t nodemask = node_to_cpumask(i);
+
+			cpus_and(nodemask, nodemask, cpu_default_map);
+			if (cpus_empty(nodemask))
+				continue;
 
-		init_sched_build_groups(sched_group_phys, nodemask,
+			init_sched_build_groups(sched_group_phys, nodemask,
 						&cpu_to_phys_group);
+		}
 	}
 
 #ifdef CONFIG_NUMA
