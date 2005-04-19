Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVDSHWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVDSHWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVDSHWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:22:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27623 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261359AbVDSHWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:22:50 -0400
Date: Tue, 19 Apr 2005 00:19:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050419001926.605a6b59.pj@sgi.com>
In-Reply-To: <1113891575.5074.46.camel@npiggin-nld.site>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> It doesn't work if you have *most* jobs bound to either
> {0, 1, 2, 3} or {4, 5, 6, 7} but one which should be allowed
> to use any CPU from 0-7.

How bad does it not work?

My understanding is that Dinakar's patch did _not_ drive tasks out of
larger cpusets that included two or more of what he called isolated
cpusets, I call cpuset domains.

For example:

	System starts up with 8 CPUs and all tasks (except for
	a few kernel per-cpu daemons) in the root cpuset, able
	to run on CPUs 0-7.

	Two cpusets, Alpha and Beta are created, where Alpha
	has CPUs 0-3, and Beta has CPUs 4-7.

	Anytime someone logs in, their login shell and all
	they run from it are placed in one of Alpha or Beta.
	The main spawning daemons, such as inetd and cron,
	are placed in one of Alpha or Beta.

	Only a few daemons that don't do much are left in the
	root cpuset, able to run across 0-7.

If we tried to partition the sched domains with Alpha and Beta as
separate domains, what kind of pain do these few daemons in
the root cpuset, on CPUs 0-7, cause?

If the pain is too intolerable, then I'd guess not only do we have to
purge any cpusets superior to the ones determining the domain
partitioning of _all_ tasks, but we'd also have to invent yet one more
boolean flag attribute for any such superior cpusets, to mark them as
_not_ able to allow a task to be attached to them.  And we'd have to
refine the hotplug co-existance logic in cpusets, which currently bumps
a task up to its parent cpuset when all the cpus in its current cpuset
are hot unplugged, to also rebuild the sched domains to some legal
configuration, if the parent cpuset was not allowed to have any tasks
attached.

I'd rather not go there, unless push comes to shove.  How hard are
you pushing?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
