Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVENQbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVENQbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVENQbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 12:31:03 -0400
Received: from orb.pobox.com ([207.8.226.5]:15006 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262799AbVENQa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 12:30:26 -0400
Date: Sat, 14 May 2005 11:30:12 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: dipankar@in.ibm.com, vatsa@in.ibm.com, dino@in.ibm.com,
       Simon.Derr@bull.net, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050514163012.GL3614@otto>
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com> <20050513135233.6eba49df.pj@sgi.com> <20050513210251.GI5044@in.ibm.com> <20050513195851.5d6665d0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513195851.5d6665d0.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 07:58:51PM -0700, Paul Jackson wrote:
> 
> So how would you, or Srivatsa or Nathan, respond to my more substantive
> point, to repeat:
> 
> Srivatsa, replying to Dinakar:
> > This in fact was the reason that we added lock_cpu_hotplug
> > in sched_setaffinity.
> 
> Why just in sched_setaffinity()?

I suspect that the lock_cpu_hotplug is no longer necessary in
sched_setaffinity.  I found the original changeset which introduced
it, and it's short enough that I'll just duplicate it here:

diff -Naru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	    2005-05-14 07:21:39 -07:00
+++ b/kernel/sched.c	    2005-05-14 07:21:39 -07:00
@@ -1012,6 +1012,7 @@
   unsigned long flags;
   cpumask_t old_mask, new_mask = cpumask_of_cpu(dest_cpu);
 
+	lock_cpu_hotplug();
	rq = task_rq_lock(p, &flags);
	old_mask = p->cpus_allowed;
	if (!cpu_isset(dest_cpu, old_mask) || !cpu_online(dest_cpu))
@@ -1035,6 +1036,7 @@
   }
 out:
	task_rq_unlock(rq, &flags);
+	unlock_cpu_hotplug();
 }
 
 /*
@@ -2309,11 +2311,13 @@
   if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
      return -EFAULT;
 
+	lock_cpu_hotplug();
	read_lock(&tasklist_lock);
 
	p = find_process_by_pid(pid);
	if (!p) {
	   read_unlock(&tasklist_lock);
+		unlock_cpu_hotplug();
			return -ESRCH;
			}
 
@@ -2334,6 +2338,7 @@
 
 out_unlock:
	put_task_struct(p);
+	unlock_cpu_hotplug();
	return retval;
 }
 
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/19 08:02:56-08:00 rusty@rustcorp.com.au 
#   [PATCH] Hotplug CPUs: Take cpu Lock Around Migration
#   
#   Grab cpu lock around sched_migrate_task() and
#sys_sched_setaffinity().
#   This is a noop without CONFIG_HOTPLUG_CPU.
#   
#   The sched_migrate_task may have a performance penalty on NUMA if
#lots
#   of exec rebalancing is happening, however this only applies to
#   CONFIG_NUMA and CONFIG_HOTPLUG_CPU, which noone does at the moment
#   anyway.
#   
#   Also, the scheduler in -mm solves the race another way, so this
#will
#   vanish then.
# 
# kernel/sched.c
#   2004/03/16 18:10:10-08:00 rusty@rustcorp.com.au +5 -0
#   Hotplug CPUs: Take cpu Lock Around Migration
# 

The lock/unlock_cpu_hotplug is no longer there in sched_migrate_task.
The changelog leads me to believe that it was intended that the same
change should have been made to sched_setaffinity by now.  I think
it's safe to remove it; I can't see why it would be necessary any
more.

Nathan

