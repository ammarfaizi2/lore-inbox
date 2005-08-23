Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVHWIEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVHWIEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 04:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVHWIEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 04:04:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54925 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750963AbVHWIEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 04:04:30 -0400
Date: Tue, 23 Aug 2005 01:04:27 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, dino@in.ibm.com
Message-Id: <20050823080427.14740.20177.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2.6.13-rc6] cpu_exclusive sched domains on partial nodes temp fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If Dinakar, Hawkes and Nick concur (and no one else complains too
loud) then the following should go into 2.6.13, to avoid the potential
kernel oops that Hawkes reported in Dinakar's feature to allow user
control of dynamic sched domain placement using cpu_exclusive cpusets.

This patch keeps the kernel/cpuset.c routine update_cpu_domains()
from invoking the sched.c routine partition_sched_domains() if the
cpuset in question doesn't fall on node boundaries.

I have boot tested this on an SN2, and with the help of a couple of
ad hoc printk's, determined that it does indeed avoid calling the
partition_sched_domains() routine on partial nodes.

I did not directly verify that this avoids setting up bogus sched
domains or avoids the oops that Hawkes saw.

Obviously, if the above named parties decide to take some other path,
then this patch should be discarded.  I submit this patch under the
expectation that Hawkes and others fixes to support sched domains not
on node boundaries will go into *-mm and 2.6.14.  Do not include the
following patch in *-mm or 2.6.14 versions which have the real sched
domain fixes.

This patch imposes a silent artificial constraint on which cpusets
can be used to define dynamic sched domains.

This patch should allow proceeding with this new feature in 2.6.13 for
the configurations in which it is useful (node alligned sched domains)
while avoiding trying to setup sched domains in the less useful cases
that can cause the kernel corruption and oops.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
===================================================================
--- linux-2.6.13-cpuset-mempolicy-migrate.orig/kernel/cpuset.c
+++ linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
@@ -636,6 +636,23 @@ static void update_cpu_domains(struct cp
 		return;
 
 	/*
+	 * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
+	 * Require the 'cpu_exclusive' cpuset to include all (or none)
+	 * of the CPUs on each node, or return w/o changing sched domains.
+	 * Remove this hack when dynamic sched domains fixed.
+	 */
+	{
+		int i, j;
+
+		for_each_cpu_mask(i, cur->cpus_allowed) {
+			for_each_cpu_mask(j, node_to_cpumask(cpu_to_node(i))) {
+				if (!cpu_isset(j, cur->cpus_allowed))
+					return;
+			}
+		}
+	}
+
+	/*
 	 * Get all cpus from parent's cpus_allowed not part of exclusive
 	 * children
 	 */

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
