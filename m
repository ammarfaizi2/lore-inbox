Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVENRFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVENRFA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVENRE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:04:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262802AbVENREz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:04:55 -0400
Date: Sat, 14 May 2005 10:04:17 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050514100417.5083262d.pj@sgi.com>
In-Reply-To: <20050514121434.GK3614@otto>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050511134235.5cecf85c.pj@sgi.com>
	<20050511135850.3df60a9f.pj@sgi.com>
	<20050513192331.2244ada9.pj@sgi.com>
	<20050514121434.GK3614@otto>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> Hmm, tsk->cpuset will break the build if !CONFIG_CPUSETS, no?  Plus,
> the task's original cpuset->count will be unbalanced and it will never
> be released, methinks.

Ah - yup.

Well, at least I am keeping my mistakes simple enough that others can
spot them quickly ;).

Fixing the tasks cpuset by moving it to top_cpuset to match its
newly extended tsk->cpus_allowed setting probably requires holding
cpuset_sem, which is what we were trying to avoid.  Drat.


> As a short-term (i.e. 2.6.12) solution, would it be terrible to set
> tsk->cpus_allowed to the default value without messing with the
> cpuset? 

No - not terrible at all.  The code that was there before, using the
cpuset_cpus_allowed() and guarantee_online_cpus(), could do just that,
setting tsk->cpus_allowed to a superset of tsk->cpuset->cpus_allowed,
possibly even setting tsk->cpus_allowed to all bits.  No one has noticed
any terrible disasters from this yet.

Granted, no one has pushed this code path very hard yet.


> However, I think making a best effort to honor the task's cpuset is a
> reasonable goal in this context.  But it will require some nontrivial
> changes to the code for migrating tasks off the dead cpu, as well as
> some changes to the cpuset code.

If these nontrivial changes have other merits, such as making some code
simpler or clearer or more elegant, then that's goodness in any case. 

But I am reluctant to complicate either the cpuset or the hotplug code
on this account.  In my view, the kernel reserves the right to blow out
a cpuset, if it is convenient for the kernel to do so in order stay
sane, which includes:

 * insuring every task has a cpu it is allowed to run on,
 * insuring every task has a node is is allowed to allocate on, and
 * no deadlocks, hangs, oops, panics or other disasters.

The mm/page_alloc.c __alloc_pages() code makes similar tradeoffs,
allowing GFP_ATOMIC requests to ignore cpusets under memory pressure,
for the "convenience of the kernel."

A key property of any solution to this is that it is so simple and
robust that people who don't understand this stuff (including obviously
myself after a month's vacation) won't break it in the future.

The following untested patch is probably what you meant by your
"short-term solution", above.  It _just_ reverts the "No more Mr. Nice
Guy" code back to setting all bits in tsk->cpus_allowed.  I see on
another post in my inbox that Srivatsa has just heartily endorsed this
approach as well.

Signed-off-by: Paul Jackson <pj@sgi.com>

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
