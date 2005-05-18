Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVERVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVERVUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVERVT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:19:29 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:1983 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262370AbVERVQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:16:46 -0400
Date: Wed, 18 May 2005 14:16:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ntl@pobox.com, dino@in.ibm.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050518141607.29343ffb.pj@sgi.com>
In-Reply-To: <20050514104429.7dc92c85.pj@sgi.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050511134235.5cecf85c.pj@sgi.com>
	<20050511135850.3df60a9f.pj@sgi.com>
	<20050513192331.2244ada9.pj@sgi.com>
	<20050514121434.GK3614@otto>
	<20050514100417.5083262d.pj@sgi.com>
	<20050514104429.7dc92c85.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> pls resend.

Here it is ... ready for prime time.

This patch removes the entwining of cpusets and hotplug code in the "No
more Mr. Nice Guy" case of sched.c move_task_off_dead_cpu().

Since the hotplug code is holding a spinlock at this point, we cannot
take the cpuset semaphore, cpuset_sem, as would seem to be required
either to update the tasks cpuset, or to scan up the nested cpuset
chain, looking for the nearest cpuset ancestor that still has some CPUs
that are online.  So we just punt and blast the tasks cpus_allowed with
all bits allowed.

This reverts these lines of code to what they were before the cpuset
patch.  And it updates the cpuset Doc file, to match.

The one known alternative to this that seems to work came from Dinakar
Guniguntala, and required the hotplug code to take the cpuset_sem
semaphore much earlier in its processing.  So far as we know, the
increased locking entanglement between cpusets and hot plug of this
alternative approach is not worth doing in this case.

Signed-off-by: Paul Jackson <pj@sgi.com>
Acked-by: Nathan Lynch <ntl@pobox.com>
Acked-by: Dinakar Guniguntala <dino@in.ibm.com>

diff -Naurp 2.6.12-rc1-mm4.orig/Documentation/cpusets.txt 2.6.12-rc1-mm4/Documentation/cpusets.txt
--- 2.6.12-rc1-mm4.orig/Documentation/cpusets.txt	2005-05-14 10:20:27.000000000 -0700
+++ 2.6.12-rc1-mm4/Documentation/cpusets.txt	2005-05-14 10:24:13.000000000 -0700
@@ -252,8 +252,7 @@ in a tasks processor placement.
 There is an exception to the above.  If hotplug funtionality is used
 to remove all the CPUs that are currently assigned to a cpuset,
 then the kernel will automatically update the cpus_allowed of all
-tasks attached to CPUs in that cpuset with the online CPUs of the
-nearest parent cpuset that still has some CPUs online.  When memory
+tasks attached to CPUs in that cpuset to allow all CPUs.  When memory
 hotplug functionality for removing Memory Nodes is available, a
 similar exception is expected to apply there as well.  In general,
 the kernel prefers to violate cpuset placement, over starving a task
diff -Naurp 2.6.12-rc1-mm4.orig/kernel/sched.c 2.6.12-rc1-mm4/kernel/sched.c
--- 2.6.12-rc1-mm4.orig/kernel/sched.c	2005-05-13 18:39:54.000000000 -0700
+++ 2.6.12-rc1-mm4/kernel/sched.c	2005-05-14 09:06:29.000000000 -0700
@@ -4301,7 +4301,7 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		cpus_setall(tsk->cpus_allowed);
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 		/*



-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
