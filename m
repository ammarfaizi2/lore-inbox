Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423006AbWJFX3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423006AbWJFX3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423005AbWJFX3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:29:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423006AbWJFX3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:29:37 -0400
Date: Fri, 6 Oct 2006 16:29:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>, Pavel Machek <pavel@ucw.cz>
Cc: vatsa@in.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       shaohua.li@intel.com, hotplug_sig@osdl.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-Id: <20061006162924.344090f8.akpm@osdl.org>
In-Reply-To: <20061006231012.GH22139@osdl.org>
References: <20060316174447.GA8184@in.ibm.com>
	<20060316170814.02fa55a1.akpm@osdl.org>
	<20060317084653.GA4515@in.ibm.com>
	<20060317010412.3243364c.akpm@osdl.org>
	<20061006231012.GH22139@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 16:10:12 -0700
Bryce Harrington <bryce@osdl.org> wrote:

> On Fri, Mar 17, 2006 at 01:04:12AM -0800, Andrew Morton wrote:
> > Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> > > Well ..other arch-es need to have a similar check if they get around to
> > > implement physical hot-add (even if they allow offlining of all CPUs). This is 
> > > required since a user can (by mistake maybe) try to bring up an already online 
> > > CPU by writing a '1' to it's sysfs 'online' file. 'store_online' 
> > > (drivers/base/cpu.c) unconditionally calls 'smp_prepare_cpu' w/o checking for 
> > > this error condition. The check added in the patch catches such error 
> > > conditions as well.
> > 
> > OK..  I guess we should fix those architectures while we're thinking about it.
> >
> > > +	/* Check if CPU is already online. This can happen if user tries to 
> > > +	 * bringup an already online CPU or a previous offline attempt
> > > +	 * on this CPU has failed.
> > > +	 */
> > > +	if (cpu_online(cpu)) {
> > > +		ret = -EINVAL;
> > > +		goto exit;
> > > +	}
> > 
> > How well tested is this?  From my reading, this will cause
> > enable_nonboot_cpus() to panic.  Is that intended?
> 
> Andrew,
> 
> I wanted to give you an update on results of cpu testing I've done on
> recent kernels and several architectures.  Since -rc1 is out, I wanted
> to give added visibility to the few issues that remain.
> 
> The full results are available here:
> 
>     http://crucible.osdl.org/runs/hotplug_report.html
> 
> This is actually a report for cpu hotplug tests generated hourly,
> however we run it against all of the kernel -git snapshots posted to
> kernel.org.  Whereever you see a blank square, it indicates the kernel
> either failed to build or boot.
> 

Can you describe the nature of the cpu-hotplug tests you're running?  I'd
be fairly staggered if the kernel was able to survive a full-on cpu-hotplug
stress test for more than one second, frankly.  There's a lot of code in
there which is non-hotplug-aware.  Running a non-preemptible kernel would
make things appear more stable, perhaps.

iirc Pavel did some testing a month or two ago and was seeing userspace
misbehaviour?

> 
> Issues were found in four areas: General kernel, cpu hotplug, sysstat,
> and the test harness itself.
>

It's surprising that AMD and Intel CPUs behave differently.  Also a good
start on diagnosing things.

