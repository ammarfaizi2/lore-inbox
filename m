Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWJSF4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWJSF4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 01:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWJSF4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 01:56:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8881 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161311AbWJSF4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 01:56:40 -0400
Date: Wed, 18 Oct 2006 22:56:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com,
       nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018225626.16a0469f.pj@sgi.com>
In-Reply-To: <20061018140738.a0c1c845.pj@sgi.com>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<20061018105307.GA17027@lnx-holt.americas.sgi.com>
	<20061018140738.a0c1c845.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier today I wrote:
> I've half a mind to prepare a patch to just rip out the sched domain
> defining code from kernel/cpuset.c, completely uncoupling the
> cpu_exclusive flag, and any other cpuset flags, from sched domains.
> 
> Example:
> 
>     As best as I can tell (which is not very far ;), if some hapless
>     user does the following:
> 
> 	    /dev/cpuset		cpu_exclusive == 1; cpus == 0-7
> 	    /dev/cpuset/a	cpu_exclusive == 1; cpus == 0-3
> 	    /dev/cpsuet/b	cpu_exclusive == 1; cpus == 4-7
> 
>     and then runs a big job in the top cpuset (/dev/cpuset), then that
>     big job will not load balance correctly, with whatever threads
>     in the big job that got stuck on cpus 0-3 isolated from whatever
>     threads got stuck on cpus 4-7.
> 
> Is this correct?
> 
> If so, there no practical way that I can see on a production system for
> the system admin to realize they have messed up their system this way.
> 
> If we can't make this work properly automatically, then we either need
> to provide users the visibility and control to make it work by explicit
> manual control (meaning my 'sched_domain' flag patch, plus some way of
> exporting the sched domain topology in /sys), or we need to stop doing
> this.


I am now more certain - the above gives an example of serious breakage
with the current mechanism of connecting cpusets to sched domains via
the cpuset flag.

We should either fix it (perhaps with my patch to add sched_domain
flags to cpusets, plus a yet to be written patch to make sched domains
visible via /sys or some such place), or we should nuke it,

I am now 90% certain we should nuke the entire mechanism connecting
cpusets to sched domains via the cpu_exclusive flag.

The only useful thing to be done, which is much simpler, is to provide
someway to manipulate the cpu_isolated_map at runtime.

I have a pair of patches ready to ship out that do this.

Coming soon to a mailing list near you ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
