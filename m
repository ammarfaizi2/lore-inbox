Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422934AbWJRVH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422934AbWJRVH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422949AbWJRVH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:07:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60081 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422934AbWJRVH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:07:56 -0400
Date: Wed, 18 Oct 2006 14:07:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018140738.a0c1c845.pj@sgi.com>
In-Reply-To: <20061018105307.GA17027@lnx-holt.americas.sgi.com>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<20061018105307.GA17027@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You do, however, hopefully have enough information to create the
> calls you would make to partition_sched_domain if each had their
> cpu_exclusive flags cleared.  Essentially, what I am proposing is
> making all the calls as if the user had cleared each as the
> remove/add starts, and then behave as if each each was set again.

Yes - hopefully we have enough information to rebuild the sched domains
each time, consistently.  And your proposal is probably an improvement
for that reason.

However, I'm afraid that only solves half the problem.  It makes the
sched domains more repeatable and predictable.  But I'm worried that
the cpuset control over sched domains is still broken .. see the
example below.

I've half a mind to prepare a patch to just rip out the sched domain
defining code from kernel/cpuset.c, completely uncoupling the
cpu_exclusive flag, and any other cpuset flags, from sched domains.

Example:

    As best as I can tell (which is not very far ;), if some hapless
    user does the following:

	    /dev/cpuset		cpu_exclusive == 1; cpus == 0-7
	    /dev/cpuset/a	cpu_exclusive == 1; cpus == 0-3
	    /dev/cpsuet/b	cpu_exclusive == 1; cpus == 4-7

    and then runs a big job in the top cpuset (/dev/cpuset), then that
    big job will not load balance correctly, with whatever threads
    in the big job that got stuck on cpus 0-3 isolated from whatever
    threads got stuck on cpus 4-7.

Is this correct?

If so, there no practical way that I can see on a production system for
the system admin to realize they have messed up their system this way.

If we can't make this work properly automatically, then we either need
to provide users the visibility and control to make it work by explicit
manual control (meaning my 'sched_domain' flag patch, plus some way of
exporting the sched domain topology in /sys), or we need to stop doing
this.

If the above example is not correct, then I'm afraid my education in
sched domains is in need of another lesson.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
