Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVEMUrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVEMUrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVEMUdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:33:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16292 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262513AbVEMUAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:00:17 -0400
Date: Fri, 13 May 2005 12:59:48 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: ntl@pobox.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050513125948.26272893.pj@sgi.com>
In-Reply-To: <20050513123216.GB3968@in.ibm.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050513123216.GB3968@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note:

I believe that the following, starting with Dinakar's post to which I am
responding, is a _separate_ issue from the one that Dinakar proposed to
address with his patch of a couple days ago.

The problem two days ago involves trying to take cpuset_sem in the
cpu_down() code path, while holding a spinlock.  My (still not yet
reposted) alternative patch will seek to avoid needing cpuset_sem on
this code path entirely.

The following problem involves a race condition between code that would
examine the cpu_online_map prior to calling set_cpus_allowed(), and the
hotplog code possibly changing that cpu_online_map.

Details ...

Dinakar wrote:
> Vatsa pointed out another scenario where cpusets+hotplug is currently
> broken. attach_task in cpuset.c is called without holding the hotplug 
> lock and it is possible to call set_cpus_allowed for a task with no 
> online cpus. 

First - my apologies for not replying on this thread yesterday
with an updated patch proposal.  I spent yesterday rebuilding my
email server - a bad disk and a bad fan.

If kernel/cpuset.c attach_task() can call set_cpus_allowed() with a
a mask that has no online cpus, it is certainly not for lack of trying.

The following two lines of code are adjacent in attach_task():

        guarantee_online_cpus(cs, &cpus);
        set_cpus_allowed(tsk, cpus);

The last line of guarantee_online_cpus() calls BUG_ON if the cpus
mask has no online cpus:

	BUG_ON(!cpus_intersects(*pmask, cpu_online_map));

So this code tries really hard to see that online cpus are passed to
set_cpus_allowed().  Before the hotplug code came along, this was
probably sufficient.

But, yes indeed, there is now a race here, as there is no lock on
cpu_online_map between this BUG_ON() check, and the call to
set_cpus_allowed(), a few instructions later.  The hotplug code could
change what is online, in the meanwhile.

The code for set_cpus_allowed() anticipates this - after getting the
relevant task_rq_lock, which (I presume) holds off hotplug, it verifies
that the target mask has some online cpus:

=========================================================
int set_cpus_allowed(task_t *p, cpumask_t new_mask)
{
        ...
        rq = task_rq_lock(p, &flags);
        if (!cpus_intersects(new_mask, cpu_online_map)) {
                ret = -EINVAL;
                goto out;
        }

        p->cpus_allowed = new_mask;
=========================================================

Seems to me that the problem here is not particularly to do with
cpusets, but with the call to set_cpus_allowed() and with hotplug
possibly changing the cpu_online_map at the same time.

I see over 60 calls to set_cpus_allowed() in the kernel, approximately 2
of which actually pay any attention to the return value.

Could not any of these calls fail, due to hotplug taking offline all the
cpus requested in the set_cpus_allowed() call before the task_rq_lock()
is obtained?  It wouldn't surprise me if some of these calls don't even
try to see that the requested cpus are online, much less avoid racing
with hotplug or handle the -EINVAL error from set_cpus_allowed().

I think that hotplug needs to think carefully about how to handle
set_cpus_allowed() calls.

Perhaps this means a lock that needs to be held around the code that
composes the cpu mask to be set, verifies these cpus are online, and
calls set_cpus_allowed.  This lock would need to be considered for
likely use in most of the 60 calls of set_cpus_allowed().  Having done
this, then the set_cpus_allowed() code probably shouldn't be returning
an error silently, but rather complaining in some sort of BUG() report
if passed cpus that were not online.

Hmmm ... looking ahead to Srivatsa's post, it looks like this might have
been done, in the form of lock_cpu_hotplug().

I will continue this line of thought as a reply to Srivatsa's post.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
