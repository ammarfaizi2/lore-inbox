Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWELAEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWELAEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWELAEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:04:33 -0400
Received: from proof.pobox.com ([207.106.133.28]:13218 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750861AbWELAEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:04:32 -0400
Date: Thu, 11 May 2006 19:04:18 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca,
       vatsa@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060512000418.GF10833@localdomain>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com> <20060511100215.588e89aa.akpm@osdl.org> <20060511102711.A15733@unix-os.sc.intel.com> <4463A1C7.6010205@mbligh.org> <20060511150927.A16977@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511150927.A16977@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Thu, May 11, 2006 at 01:42:47PM -0700, Martin Bligh wrote:
> > Ashok Raj wrote:
> > > 
> > > 
> > > It depends on whats running at the time... with some light load, i measured 
> > > wall clock time, i remember seeing 2 secs at times, but its been a long time
> > > i did that.. so take that with a pinch :-)_
> > > 
> > > i will try to get those idle and load times worked out again... the best
> > > i have is a  16 way, if i get help from big system oems i will send the 
> > > numbers out
> > 
> > Why is taking 30s to offline CPUs a problem?
> > 
> 
> Well, the real problem is that for each cpu offline we schedule a RT thread
> kstopmachine() on each cpu, then turn off interrupts until this one cpu has 
> removed. stop_machine_run() is a big enough sledge hammer during cpu offline
> and doing this repeatedly... say on a 4 socket system, where each socket=16
> logical cpus.
> 
> the system would tend to get hick ups 64 times, since we do the stopmachine
> thread once for each logical cpu. When we want to replace a node for
> reliability reasons, its not clear if this hick ups is a good thing.

Can you provide more detail on what you mean by hiccups?


> Doing kstopmachine() on a single system is in itself noticable, what we heard
> from some OEM's is this would have other app level impact as well.

What "other app level impact"?


> With the bulk removal, we do stop machine just once, but all the 16 cpus
> get removed once hence there is just one hickup, instead of 64.

Have you done any profiling or other instrumentation that identifies
stopmachine as the real culprit here?  I mean, it's a reasonable
assumption to make, but are you sure there's not something else
causing the hiccups?  Perhaps contention on the cpu hotplug lock, or
something wrong in the architecture cpu_disable code?

Module unload also uses stop_machine_run, iirc.  Do you see hiccups
with that, too?


> Less time to offline, avoid process and interrupt bouncing on and off a cpu
> which is just about to be offlined are almost extra fringe benefits you get 
> with the bulk removal approach.

Ok, so that's not the primary motivation for these patches?
