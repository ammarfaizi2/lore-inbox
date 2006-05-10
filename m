Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWEJTGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWEJTGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWEJTGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:06:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64444 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964776AbWEJTGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:06:32 -0400
Date: Wed, 10 May 2006 15:06:01 -0400
From: Don Zickus <dzickus@redhat.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       oprofile-list@lists.sourceforge.net, perfmon@napali.hpl.hp.com
Subject: Re: [patch 8/8] Add abilty to enable/disable nmi watchdog from sysfs
Message-ID: <20060510190601.GM16561@redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com> <20060509205958.578466000@drseuss.boston.redhat.com> <20060510091026.GD21833@frankl.hpl.hp.com> <20060510145952.GL16561@redhat.com> <20060510150357.GO21833@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510150357.GO21833@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 08:03:57AM -0700, Stephane Eranian wrote:
> Don,
> 
> On Wed, May 10, 2006 at 10:59:53AM -0400, Don Zickus wrote:
> > > 
> > > This means you can at runtime enable/disbale nmi_watchdog, i.e., reserve
> > > some performance counters on the fly. This gets complicated because now
> > > the perfmon subsystem (and probably oprofile) cannot check register
> > > availability when they are first initialized. Basically each time,
> > > the /sys entry is modified, they would have to scan the list of available
> > > performance counters. I don't know exactly when Oprofile does this checking.
> > > For perfmon, this is done only once, when the PMU description table is loaded.
> 
> > How often did you plan on enabling/disabling the nmi_watchdog?  My
> > understanding was you disable nmi_watchdog, run oprofile/perfmon,
> > re-enable nmi_watchdog.  I guess I don't understand what type of funky
> > scenarios you are dealing with.  
> > 
> I thought that part of the exercise was to allow oprofile/perfmon and nmi_watchdog
> to work simultaneously, i.e., don't disable watchdog when you monitor. Leave watchdog
> on and have oprofile/perfmon run with fewer counters. The alternative would be to do
> what you say: disbale nmi, monitor, re-enable nmi.

It was and the patch allows one to run the monitor and the nmi_watchdog at
the same time.  I guess I am confused to what your original concern
was.  

> 
> > > 
> > > Also something that I did not see in this code is the error detection in
> > > case enable_lapic_nmi_watchdog() fails. Oprofile runs on all CPUs or none.
> > > Perfmon lets you monitor on subsets on CPUs. In case NMI was disabled and
> > > a monitoring session was active on some CPUs. The enable_lapic_nmi_watchdog()
> > > will fail on some CPUs. How is that handled?
> > 
> > It's not.  In fact I wouldn't know what to do in such situations.  Is it
> > really wrong to only have a subset of cpus being monitored by the
> > nmi_watchdog?  This seems to be wandering into the area where the user is
> > looking to do something complicated (profiling a subset of cpus) and as
> > such might be expected to make sure the nmi_watchdog is properly enabled
> > on all cpus when they are done.
> > 
> On larger machines (think NUMA-style), it does not always make sense to monitor all CPUs.

That makes sense.  Thinking about it, it probably wouldn't be too hard to
add code to try and re-scan the cpus and enable those nmi_watchdogs that
were disabled during your monitoring.  But you would have to manually do
this once you were done testing. 

Cheers,
Don
