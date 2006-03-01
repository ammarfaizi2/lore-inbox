Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWCAUyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWCAUyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWCAUyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:54:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19357 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751182AbWCAUyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:54:10 -0500
Date: Wed, 1 Mar 2006 12:53:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060301125358.29261ad9.pj@sgi.com>
In-Reply-To: <200603012021.59638.ak@suse.de>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<200603011934.34136.ak@suse.de>
	<20060301105844.d5b243f2.pj@sgi.com>
	<200603012021.59638.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I spent much time minimizing that overhead over the last few months, as
> > a direct result of your recommendation to do so.
> 
> IIRC my recommendation only optimized the case of nobody using
> cpuset if I remember correctly. 

As a result of your general concern with the performance impact
of cpusets on the page allocation code path, I optimized each
element of it, not just the one case covered by your specific
recommendation.

Take a look.

> Using a single cpuset would already drop into the slow path, right?

No - having a single cpuset is the fastest path.  All tasks
are in that root cpuset in that case, and all nodes allowed.

> I'm not sure I want to get into the business
> of explaining all the distributions how to set up cpusets ..

Good grief - I already quoted the 3 lines of boottime init script it
would take - this can't require that much explaining, and your new
sysctl can't get by with much less:
    test -d /dev/cpuset || mkdir /dev/cpuset
    mount -t cpuset cpuset /dev/cpuset
    echo 1 > /dev/cpuset/memory_spread_slab	# enable system wide

> and set up new file systems.

That's a Linux source issue that matters a single time in the history
of each file system type supported by Linux.  It is not a customer or
even distro issue.

And even from the perspective of maintaining Linux, this should be on
autopilot.  Every file systems inode cache is marked, and if we do
nothing, as more file system types are invented for Linux, they will
predictably cut+paste the inode slab cache setup from an existing file
system, and "just get it right."

> For that a single switch that can be just set by default is much more
> practical.

Doing it via cpusets is also a single switch that is set by default.

It is just as practical; well more practical - it's already there.

===

Mind you, I don't have any profound objections to such a sysctl.

I just don't see that it serves any purpose, and I suspect that
misunderstandings of the performance impact of cpusets are the
primary source of motivation for such a sysctl.

I prefer to (1) set the record straight on cpusets, and (2) avoid
adding additional kernel mechanisms that are redundant.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
