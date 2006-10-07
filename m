Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWJGKgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWJGKgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 06:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWJGKgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 06:36:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5262 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750809AbWJGKgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 06:36:12 -0400
Date: Sat, 7 Oct 2006 12:35:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bryce Harrington <bryce@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061007103559.GC30034@elf.ucw.cz>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007000031.GI22139@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007000031.GI22139@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-10-06 17:00:31, Bryce Harrington wrote:
> On Fri, Oct 06, 2006 at 04:29:24PM -0700, Andrew Morton wrote:
> > Can you describe the nature of the cpu-hotplug tests you're running?  I'd
> > be fairly staggered if the kernel was able to survive a full-on cpu-hotplug
> > stress test for more than one second, frankly.  There's a lot of code in
> > there which is non-hotplug-aware.  Running a non-preemptible kernel would
> > make things appear more stable, perhaps.
> 
> Certainly, the testsuite is one the OSDL Hotplug SIG put together last
> summer, and consists of several test cases:
> 
> http://developer.osdl.org/dev/HOTPLUG/planning/hotplug_cpu_test_plan_status.html

Page actually lists test 1-6.

>    hotplug01:  Check IRQ behavior during cpu hotplug events
>    hotplug02:  Check process migration during cpu hotplug events
>    hotplug03:  Verify tasks get scheduled on newly onlined cpu's
>    hotplug04:  Verify disallowing offlining all CPU's
>    hotplug05:  (Unimplemented)
>    hotplug06:  Check userspace tools (sar, top) during cpu hotplug events 
>    hotplug07:  Stress case doing kernel compile while cpu's are
>                hotplugged on and off repeatedly

Well, while nice for "it basically works", that will not stress
hotplug subsystem too badly.

If you want some real nasty tests:

hotplug_locking: create 10 threads, make them try to online/offline
random cpus, all in paralel. (This is what I was doing in smaller
scale). You'll get some expected errors (like cpu already up), but
system should survive.

cpufreq: change cpufreq parameters on cpu (toggling min/max
frequency?) while trying to online/offline that cpu from another
thread.

suspend: swapoff -a, then proceed like in hotplug_locking, while
trying to suspend machine to disk (it will immediately wake up because
of no swap available). Should be useful at pointing out bugs in
suspend code. (but quite tricky to setup the test, so you may or may
not want to do this one).

> We've been running this testsuite fairly continuously for several
> months, and irregularly for about a year before that.  We find that on
> some platforms like PPC64 it's quite robust, and on others there are
> issues, but the developers tend to be quick to provide fixes as the
> issues are found.  I'm glad to see that the results are finally showing
> green for ia64.

Hmm, perhaps you should add ppc64 to the hotplug_report.html, so that
some green can be seen :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
