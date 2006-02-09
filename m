Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWBIJIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWBIJIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWBIJIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:08:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964850AbWBIJIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:08:20 -0500
Date: Thu, 9 Feb 2006 01:06:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: pj@sgi.com, heiko.carstens@de.ibm.com, wli@holomorphy.com, ak@muc.de,
       mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209010655.5cdeb192.akpm@osdl.org>
In-Reply-To: <200602090335_MC3-1-B7FA-621E@compuserve.com>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> In-Reply-To: <20060208204502.12513ae5.akpm@osdl.org>
> 
> On Wed, 8 Feb 2006 at 20:45:02 -0800, Andrew Morton wrote:
> 
> > > Its even documented in line 332 of include/linux/cpumask.h
> > > 
> > >   *  #ifdef CONFIG_HOTPLUG_CPU
> > >   *     cpu_possible_map - all NR_CPUS bits set
> > 
> > That seems a quite bad idea.  If we know which CPUs are possible we should
> > populate cpu_possible_map correctly, whether or not CONFIG_HOTPLUG_CPU is
> > set.
> 
> I don't think that's, um, "possible."  Even if you could discover how many
> empty sockets there were in a system, someone might be able to hotplug
> a board with more of them on it.  And there's no way to tell how many CPUs
> to reserve for each socket anyway, e.g. AMD has already announced quad-core
> processors.

Well maybe.  But it's awfully presumptuous for us to say that no platform
will be capable of telling us what its maximum number of CPUs is, or even
whether certain CPUs within that range aren't possible.

<checks>

Yup, on my 2-way x86 test box, with NR_CPUS=16 we have
cpu_possible_map=0xffff.

That's just insane - the default setting for a distro kernel should be (or
will become) NR_CPUS=lots, HOTPLUG_CPU=y.  All those for_each_cpu() loops
are iterating across 16 CPUs.

aargh.

> But what really surprised me is that for_each_cpu() actually walks
> cpu_possible_map and not cpu_present_map as I had assumed.  This violates
> the Principle Of Least Surprise.  Maybe renaming for_each_cpu to
> for_each_possible_cpu might be a good idea?

That would make sense.
