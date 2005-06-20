Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVFTVUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVFTVUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFTVLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:11:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:47859 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261541AbVFTVHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:07:50 -0400
Subject: Re: [RFC] Linux memory error handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Russ Anderson <rja@sgi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506202042.j5KKgXKl4801437@clink.americas.sgi.com>
References: <200506202042.j5KKgXKl4801437@clink.americas.sgi.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 14:07:35 -0700
Message-Id: <1119301655.27442.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 15:42 -0500, Russ Anderson wrote:
> Is there a standard for how to name hardware entries in 
> /sys/devices/system (or sysfs in general)?

For system devices, no, I don't think so.

> Seems like his same general issue would apply to other hardware
> components, cpus, nodes, etc.  

I don't think it's true for anything other than memory.  Linux doesn't
manage CPUs or nodes any differently than it manages its internal
representations of them.

But, for memory at a level any less granular than pages, Linux and the
hardware seldom have the same view. 

> > One other minor thing.  You might want to think about referring to the
> > pieces of memory as things other than DIMMs.  On ppc64, for instance,
> > the hypervisor hands off memory in sections called LMBs (logical memory
> > blocks), and they're not directly related to any hardware DIMM.  The
> > same things will show up in other virtualized environments.
> 
> If we're talking about specific hardware entries, it seems like they
> should be called what they are.  If we're talking about abstractions,
> a more abstract name seems in order.  One of my concerns is mapping 
> failures back to hardware components, hence my bias for component names.

Even with generic names mapping back to components should be easy

Somethinng like memory/type could even contain the hardware type of each
ram entry.

> Would having /sys/.../memory/LMB on ppc64 to correspond to 
> /sys/.../memory/DIMM be a problem?

No, it wouldn't really be too much of a problem.  But, it's not a very
accurate description.  There is certainly hardware that has RAM which
does not have a single DIMM. :)

> RAM would be an alternative,
> but that could be confused with /sys/block/ram.  :-)

RAM would probably be fine.  There should be very few properties
that /sys/devices/system devices share with /sys/block, so it shouldn't
be too bad.

> In general, I'm more concerned with getting the necessary functionality
> in than what the specific entries are called, so I'll go along with
> the consensus.

I don't think there's much of a consensus.  I just want to make sure we
do something that works on all platforms consistently.  For instance,
I'd hate to have every userspace utilities that are trying to examine
memory look like this:

if [ `uname -a` == ppc64 ]; then
	UNIT=LMB
elif [ `uname -a` == ia64 ]; then
	UNIT=DIMM
etc...

FILE=/sys/devices/system/memory/$UNIT$NUMBER

-- Dave

