Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVENQJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVENQJr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 12:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVENQJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 12:09:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16769 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262790AbVENQJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 12:09:44 -0400
Date: Sat, 14 May 2005 21:39:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: dipankar@in.ibm.com, dino@in.ibm.com, ntl@pobox.com,
       Andrew Morton <akpm@osdl.org>, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050514160945.GA32720@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com> <20050513135233.6eba49df.pj@sgi.com> <20050513210251.GI5044@in.ibm.com> <20050513195851.5d6665d0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513195851.5d6665d0.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 07:58:51PM -0700, Paul Jackson wrote:
> Why just in sched_setaffinity()?  What about the other 60+ calls to
> set_cpus_allowed().  

Most of the 60+ calls seem to be in arch-specific code. We don't bother
about arch'es which dont support CPU Hotplug. AFAIK, only ppc64, ia64
and s390 support it (as of today that is :)

> Shouldn't most of those calls be checking that the
> passed in cpus are online (holding lock_cpu_hotplug while doing all
> this)?  Either that, or at least handling the error from
> set_cpus_allowed() if the requested cpus end up not being online?  

Yes, if these calls can run on CPU Hotplug supported platforms.

Apart from being buggy on this count (that they don't lock_cpu_hotplug
and/or don't check return value), they will also be buggy
if any code uses set_cpus_allowed against a user-space task to
migrate to a different CPU. Something like:

	old_allowed = tsk->cpus_allowed;
	set_cpus_allowed(tsk, new_mask);
	/* Do something */
	/* Restore mask */
	set_cpus_allowed(tsk, old_allowed);

This is buggy because it can race with sched_setaffinity against the same task.

Having said that, the major remaining offenders (in arch-independent code) seem
to be cpufreq, sn_hwperf, acpi, perfctr/virtual.c, attach_task :), 
net/core/pktgen.c (needs to be converted over to kthread_start/stop interface).

Now how much of this actually runs on the CPU Hotplug supported platforms?
Don't know ..But it is neverthless good to fix few of these ..

In fact, some of these and other set_cpus_allowed woes were discussed here:

http://sourceforge.net/mailarchive/forum.php?thread_id=3582487&forum_id=35582



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
