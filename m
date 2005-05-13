Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVEMU0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVEMU0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVEMU0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:26:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17316 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262519AbVEMUAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:00:19 -0400
Date: Fri, 13 May 2005 12:59:53 -0700
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: dino@in.ibm.com, ntl@pobox.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050513125953.66a59436.pj@sgi.com>
In-Reply-To: <20050513172540.GA28018@in.ibm.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050513123216.GB3968@in.ibm.com>
	<20050513172540.GA28018@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa, replying to Dinakar:
> This in fact was the reason that we added lock_cpu_hotplug
> in sched_setaffinity.

Why just in sched_setaffinity()?  What about the other 60+ calls to
set_cpus_allowed().  Shouldn't most of those calls be checking that the
passed in cpus are online (holding lock_cpu_hotplug while doing all
this)?  Either that, or at least handling the error from
set_cpus_allowed() if the requested cpus end up not being online?  I see
only 2 set_cpus_allowed() calls that make any pretense of examining the
return value.


> I agree that taking the hotplug lock seems reasonable here.

I take it that you are recommending changing cpuset_cpus_allowed() in
the way sched_setaffinity() was changed, to grab lock_cpu_hotplug around
the small piece of code that examines cpu_online_map and calls
set_cpus_allowed().

This sounds good to me.  I wonder why it doesn't need to be considered
in the other 60+ calls to set_cpus_allowed.


> Given the fact that CPU/Memory hotplug and cpuset operation may
> be infrequent events, this will probably be not a concern. 

I agree that performance is not the key issue here.  Little if any
of this is on any hot code path.

We do need to be clear about how these locks work, their semantics, what
they require and what they insure, and their various interactions.

This is not easy stuff to get right.

I notice that the documentation for lock_cpu_hotplug() is a tad on
the skimpy side:

	/* Stop CPUs going up and down. */

That's it, so far as I can see.  Interaction of hotplug locking with
the rest of the kernel has been, is now, and will continue to be, a
difficult area.  More care than this needs to be put into explaining
the use, semantics and interactions of any locking involved.

In particular, in my view, locks should guard data.  What data does
lock_cpu_hotplug() guard?  I propose that it guards cpu_online_map.

I recommend considering a different name for this lock.  Perhaps
'cpu_online_sem', instead of 'cpucontrol'?   And perhaps the
lock_cpu_hotplug() should be renamed, to say 'lock_cpu_online'?

Then a survey of all uses of cpu_online_map, and by extension, of all
calls to set_cpus_allowed(), should be made, to see in which cases this
semaphore should be held.  For extra credit, make sure that every caller
to set_cpus_allowed() makes an effort to only pass in cpus that are
currently online.  The caller should do this, since only the caller can
know what alternative cpus to use, if their first choice is offline.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
