Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932841AbWJGUm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841AbWJGUm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbWJGUm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:42:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932841AbWJGUmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:42:25 -0400
Date: Sat, 7 Oct 2006 13:42:20 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061007204220.GB24743@osdl.org>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007000031.GI22139@osdl.org> <20061007103559.GC30034@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007103559.GC30034@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 12:35:59PM +0200, Pavel Machek wrote:
> On Fri 2006-10-06 17:00:31, Bryce Harrington wrote:
> > On Fri, Oct 06, 2006 at 04:29:24PM -0700, Andrew Morton wrote:
> > > Can you describe the nature of the cpu-hotplug tests you're running?  I'd
> > > be fairly staggered if the kernel was able to survive a full-on cpu-hotplug
> > > stress test for more than one second, frankly.  There's a lot of code in
> > > there which is non-hotplug-aware.  Running a non-preemptible kernel would
> > > make things appear more stable, perhaps.
> > 
> > Certainly, the testsuite is one the OSDL Hotplug SIG put together last
> > summer, and consists of several test cases:
> > 
> > http://developer.osdl.org/dev/HOTPLUG/planning/hotplug_cpu_test_plan_status.html
> 
> Page actually lists test 1-6.

Case 7 was based on a contribution by one of the kernel developers, that
he had used for testing his cpu code.
 
> >    hotplug01:  Check IRQ behavior during cpu hotplug events
> >    hotplug02:  Check process migration during cpu hotplug events
> >    hotplug03:  Verify tasks get scheduled on newly onlined cpu's
> >    hotplug04:  Verify disallowing offlining all CPU's
> >    hotplug05:  (Unimplemented)
> >    hotplug06:  Check userspace tools (sar, top) during cpu hotplug events 
> >    hotplug07:  Stress case doing kernel compile while cpu's are
> >                hotplugged on and off repeatedly
> 
> Well, while nice for "it basically works", that will not stress
> hotplug subsystem too badly.
> 
> If you want some real nasty tests:
> 
> hotplug_locking: create 10 threads, make them try to online/offline
> random cpus, all in paralel. (This is what I was doing in smaller
> scale). You'll get some expected errors (like cpu already up), but
> system should survive.
> 
> cpufreq: change cpufreq parameters on cpu (toggling min/max
> frequency?) while trying to online/offline that cpu from another
> thread.
> 
> suspend: swapoff -a, then proceed like in hotplug_locking, while
> trying to suspend machine to disk (it will immediately wake up because
> of no swap available). Should be useful at pointing out bugs in
> suspend code. (but quite tricky to setup the test, so you may or may
> not want to do this one).

Thanks, I've added these to the todo list.
 
> > We've been running this testsuite fairly continuously for several
> > months, and irregularly for about a year before that.  We find that on
> > some platforms like PPC64 it's quite robust, and on others there are
> > issues, but the developers tend to be quick to provide fixes as the
> > issues are found.  I'm glad to see that the results are finally showing
> > green for ia64.
> 
> Hmm, perhaps you should add ppc64 to the hotplug_report.html, so that
> some green can be seen :-).

I'd like to, however the issue has been that we cannot automatically do
boot-once with yaboot on PPC like we can with other bootloaders, so when
the machine locks up we have to manually boot the machine to test
kernels.  That was okay initially when we were developing the testsuite,
but for running the -mm, -git, and -rc trees every day it hasn't been
feasible to do.

So, getting boot-once functionality enabled in yaboot (or getting grub2
stable for ppc64) is another issue we're tracking.  Kirkland has done
some work in this area, but it sounds like advice from someone with good
knowledge of yaboot internals is necessary to get this solved.  I'm sure
we'll get there eventually, but this has been a roadblock for automating
our ppc64 kernel testing automation so far.

Bryce

