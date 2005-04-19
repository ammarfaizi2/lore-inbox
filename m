Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVDSH6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDSH6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSH6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:58:16 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:20922 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261234AbVDSH5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:57:33 -0400
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lkml <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, colpatch@us.ibm.com
In-Reply-To: <20050419001926.605a6b59.pj@sgi.com>
References: <1097110266.4907.187.camel@arrakis>
	 <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com>
	 <1113891575.5074.46.camel@npiggin-nld.site>
	 <20050419001926.605a6b59.pj@sgi.com>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 17:57:20 +1000
Message-Id: <1113897440.5074.62.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 00:19 -0700, Paul Jackson wrote:
> Nick wrote:
> > It doesn't work if you have *most* jobs bound to either
> > {0, 1, 2, 3} or {4, 5, 6, 7} but one which should be allowed
> > to use any CPU from 0-7.
> 
> How bad does it not work?
> 
> My understanding is that Dinakar's patch did _not_ drive tasks out of
> larger cpusets that included two or more of what he called isolated
> cpusets, I call cpuset domains.
> 
> For example:
> 
> 	System starts up with 8 CPUs and all tasks (except for
> 	a few kernel per-cpu daemons) in the root cpuset, able
> 	to run on CPUs 0-7.
> 
> 	Two cpusets, Alpha and Beta are created, where Alpha
> 	has CPUs 0-3, and Beta has CPUs 4-7.
> 
> 	Anytime someone logs in, their login shell and all
> 	they run from it are placed in one of Alpha or Beta.
> 	The main spawning daemons, such as inetd and cron,
> 	are placed in one of Alpha or Beta.
> 
> 	Only a few daemons that don't do much are left in the
> 	root cpuset, able to run across 0-7.
> 
> If we tried to partition the sched domains with Alpha and Beta as
> separate domains, what kind of pain do these few daemons in
> the root cpuset, on CPUs 0-7, cause?
> 

They don't cause any pain for the scheduler. They will be *in* some
pain because they can't escape from the domain in which they have been
placed (unless you do a set_cpus_allowed thingy).

So, eg. inetd might start up a million blahd servers, but they'll
all be stuck in Alpha even if Beta is completely idle.

> If the pain is too intolerable, then I'd guess not only do we have to
> purge any cpusets superior to the ones determining the domain
> partitioning of _all_ tasks, but we'd also have to invent yet one more
> boolean flag attribute for any such superior cpusets, to mark them as
> _not_ able to allow a task to be attached to them.  And we'd have to
> refine the hotplug co-existance logic in cpusets, which currently bumps
> a task up to its parent cpuset when all the cpus in its current cpuset
> are hot unplugged, to also rebuild the sched domains to some legal
> configuration, if the parent cpuset was not allowed to have any tasks
> attached.
> 
> I'd rather not go there, unless push comes to shove.  How hard are
> you pushing?
> 

Well the scheduler simply can't handle it, so it is not so much a
matter of pushing - you simply can't use partitioned domains and
meaningfully have a cpuset above them.

-- 
SUSE Labs, Novell Inc.


