Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVENCYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVENCYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 22:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVENCYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 22:24:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19944 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262680AbVENCX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 22:23:58 -0400
Date: Fri, 13 May 2005 19:23:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: ntl@pobox.com, dino@in.ibm.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050513192331.2244ada9.pj@sgi.com>
In-Reply-To: <20050511135850.3df60a9f.pj@sgi.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050511134235.5cecf85c.pj@sgi.com>
	<20050511135850.3df60a9f.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two days ago, I wrote:
> Another variation will be forthcoming soon.

Don't apply the following yet, Andrew.  It is untested, and we've not
yet obtained agreement.

I'll sqawk again, if this patch survives long enough to warrant inclusion.

===

Ah to heck with it.  This subtle distinction over what level of cpuset
we fall back to when a hot unplug leaves a task with no online cpuset in
its current allowed set is not worth it.

Every variation I consider is either sufficiently complicated that I
can't be sure it's right, or sufficiently simple that it's obviously
broken.

Revert the move_task_off_dead_cpu() code to its previous code, before
cpusets were added.  If none of the remaining allowed cpus are online,
then let the task run on any cpu, no limit.  This is a legal fallback,
and indeed one of the possible outcomes of the previous code.  It's just
not so Nice.

If a system administrator doesn't like a task being allowed to run
anywhere as a result of this, then they should clear out a cpuset of the
tasks running in it, before they take the last cpu in that cpuset
offline, and they should use taskset (sched_setaffinity) or other means
to ensure that tasks aren't pinned to a cpu that is about to be taken
offline.

Unless and until someone can make a good case to the contrary, it is not
worth nesting hotplug and cpuset semaphores to attempt to provide a more
subtle fallback, that few people would understand anyway.

At least do one thing right - attach the task to the top_cpuset if we
have to force its cpus_allowed there.  That keeps the tasks apparent
cpuset in sync with its cpus_allowed (any online cpu or CPU_MASK_ALL,
which are roughly equivalent in this context).

Signed-off-by: Paul Jackson <pj@sgi.com>

diff -Naurp 2.6.12-rc1-mm4.orig/kernel/sched.c 2.6.12-rc1-mm4/kernel/sched.c
--- 2.6.12-rc1-mm4.orig/kernel/sched.c	2005-05-13 18:39:54.000000000 -0700
+++ 2.6.12-rc1-mm4/kernel/sched.c	2005-05-13 19:02:49.000000000 -0700
@@ -4301,7 +4301,8 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		cpus_setall(tsk->cpus_allowed);
+		tsk->cpuset = &top_cpuset;
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
 
 		/*

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
