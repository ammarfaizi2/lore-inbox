Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269888AbUICWp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269888AbUICWp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUICWp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:45:28 -0400
Received: from holomorphy.com ([207.189.100.168]:10632 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269888AbUICWpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:45:12 -0400
Date: Fri, 3 Sep 2004 15:45:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [sched] fix sched_domains hotplug bootstrap ordering vs. cpu_online_map issue
Message-ID: <20040903224507.GX3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <1094246465.1712.12.camel@mulgrave> <20040903145925.1e7aedd3.akpm@osdl.org> <20040903222212.GV3106@holomorphy.com> <20040903153434.15719192.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903153434.15719192.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> This is the whole thing; the "other half" referred to a new hunk added to
>> the patch (identical to this one) posted in its entirety.

On Fri, Sep 03, 2004 at 03:34:34PM -0700, Andrew Morton wrote:
> ho-hum. changelog, please?

cpu_online_map is not set up at the time of sched domain initialization
when hotplug cpu paths are used for SMP booting. At this phase of
bootstrapping, cpu_possible_map can be used by the various
architectures using cpu hotplugging for SMP bootstrap, but the
manipulations of cpu_online_map done on behalf of NUMA architectures,
done indirectly via node_to_cpumask(), can't, because cpu_online_map
starts depopulated and hasn't yet been populated. On true NUMA
architectures this is a distinct cpumask_t from cpu_online_map and so
the unpatched code works on NUMA; on non-NUMA architectures the
definition of node_to_cpumask() this way breaks and would require an
invasive sweeping of users of node_to_cpumask() to change it to e.g.
cpu_possible_map, as cpu_possible_map is not suitable for use at
runtime as a substitute for cpu_online_map.

Signed-off-by: William Irwin <wli@holomorphy.com>


Index: wait-2.6.9-rc1-mm1/kernel/sched.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/sched.c	2004-08-28 11:41:47.000000000 -0700
+++ wait-2.6.9-rc1-mm1/kernel/sched.c	2004-08-29 10:46:52.543081208 -0700
@@ -4224,7 +4224,11 @@
 		sd = &per_cpu(phys_domains, i);
 		group = cpu_to_phys_group(i);
 		*sd = SD_CPU_INIT;
+#ifdef CONFIG_NUMA
 		sd->span = nodemask;
+#else
+		sd->span = cpu_possible_map;
+#endif
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
 
@@ -4262,6 +4266,7 @@
 						&cpu_to_isolated_group);
 	}
 
+#ifdef CONFIG_NUMA
 	/* Set up physical groups */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
@@ -4273,6 +4278,10 @@
 		init_sched_build_groups(sched_group_phys, nodemask,
 						&cpu_to_phys_group);
 	}
+#else
+	init_sched_build_groups(sched_group_phys, cpu_possible_map,
+							&cpu_to_phys_group);
+#endif
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
