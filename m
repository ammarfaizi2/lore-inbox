Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVICQVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVICQVd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVICQVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:21:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:9941 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751079AbVICQVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:21:32 -0400
Date: Sat, 3 Sep 2005 09:21:13 -0700 (PDT)
From: hawkes@sgi.com
To: Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050903162113.22561.80700.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH 0/3] 2.6.13: cpuset + build_sched_domains() fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala's "dynamic sched domains" functionality was been merged
into 2.6.13-rcN, although it was disabled at the last minute in the final
2.6.13 because it triggers a fatal bug for NUMA systems with more than one
CPU per node.

Conceptually, when a user/sysadmin declares a cpu-exclusive (a.k.a.
"isolated") cpuset, the cpuset code calls build_sched_domains() to isolate
the cpu-exclusive CPU(s) such that these CPU(s) only load-balance among
themselves and the remaining CPU(s) only load-balance among themselves.
Thus, the non-isolated CPU(s) spend no load-balancing effort trying to
offload tasks cannot be migrated away from their isolated CPU(s).
Otherwise, for example, if an isolated CPU were to be the systemwide
most-heavily-loaded CPU, then this would effectively disable all dynamic
load-balancing in the Scheduler because the non-isolated CPU(s) would
keep making futile efforts to offload isolated, non-migratable tasks.

Unfortunately, the 2.6.13 bug is that build_sched_domains() expects that
a sched domain will include all the CPUs of each node in the domain; more
accurately, that no node will belong in both an isolated cpuset and a
non-isolated cpuset.  Declaring a cpuset that violates this presumption
will produce flawed data structures and will oops the kernel.  Hence,
for 2.6.13, the cpuset code that would otherwise call build_sched_domains()
is #ifdef'ed disabled.

To trigger the problem (on a NUMA system with >1 CPUs per node, if the
kernel/cpuset.c disabling #ifdef is removed):
   cd /dev/cpuset
   mkdir newcpuset
   cd newcpuset
   echo 0 >cpus
   echo 0 >mems
   echo 1 >cpu_exclusive

The fix is in three parts:
1) A contribution from Ingo Molnar to pull the arch-specific ia64
   build_sched_domains() (et al) routines into kernel/sched.c to form
   a unified set of build and destroy routines.
2) My fix to the 2.6.13 problem:  dynamically allocate sched_group_nodes[]
   and sched_group_allnodes[] for each invocation of build_sched_domains(),
   rather than use global arrays for these structures, taking care to
   remember kmalloc() addresses so that arch_destroy_sched_domains() can
   properly kfree() them.
3) Undo the #ifdef disabling hack that was put into 2.6.13 to disable
   dynamic sched domains.

This is a patch against 2.6.13.  I have posted a previous similar patch
against 2.6.13-mm1.

John Hawkes
