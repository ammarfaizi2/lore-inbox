Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVENRXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVENRXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVENRXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:23:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7142 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262807AbVENRXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:23:16 -0400
Date: Sat, 14 May 2005 22:53:17 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Paul Jackson <pj@sgi.com>, dipankar@in.ibm.com, dino@in.ibm.com,
       Simon.Derr@bull.net, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050514172317.GD32720@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com> <20050513135233.6eba49df.pj@sgi.com> <20050513210251.GI5044@in.ibm.com> <20050513195851.5d6665d0.pj@sgi.com> <20050514163012.GL3614@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514163012.GL3614@otto>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 11:30:12AM -0500, Nathan Lynch wrote:
> I suspect that the lock_cpu_hotplug is no longer necessary in
> sched_setaffinity.  

Digging harder into my memory, I think the primary reason why lock_cpu_hotplug
was added in sched_setaffinity was this: some code wants to temporarily
override a (user-space) task's cpu mask. Before stop_machine came along, module
code was doing that (again if my memory serves me right). With stop_machine,
temporary changing of user-space (rmmod's) cpus_allowed is not reqd.
However I still see other code (like acpi_processor_set_performance) which
does something like this:

        saved_mask = current->cpus_allowed;

        set_cpus_allowed(current, new_mask);

        /* Do something ..Could block */

        set_cpus_allowed(current, saved_mask);

How do you ensure that saved_mask has not changed since the time
we took a snapshot of it (bcoz of sched_setaffinity having
changed it)? lock_cpu_hotplug could serialize such pieces of code

> I found the original changeset which introduced
> it, and it's short enough that I'll just duplicate it here:

[snip]

> The lock/unlock_cpu_hotplug is no longer there in sched_migrate_task.

Essentialy, if I remember correct, sched_migrate_task was also doing
something like acpi_processor_set_performance to migrate a task to a new cpu. 
Thats why we discussed that sched_migrate_task should take lock_cpu_hotplug.  
But I don't think it ever went in. There were concerns of cache-line bounces 
on NUMA m/c bcoz of lock_cpu_hotplug in a frequently executed code like 
sched_migrate_task. Moreover sched_migrate_task no longer behaves like 
acpi_processor_set_performance when it wants to migrate a user-space task to a 
different CPU. It now seems to take the help of migration thread (which is 
much neater compared to what was there earlier i guess).

> The changelog leads me to believe that it was intended that the same
> change should have been made to sched_setaffinity by now.  I think
> it's safe to remove it; I can't see why it would be necessary any
> more.

I recommend that we keep the lock_cpu_hotplug in sched_affinity
unless we figure out a different way of solving the race I highlighted above
or we ban code like that in acpi_processor_set_performance :)




-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
