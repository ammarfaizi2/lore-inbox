Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269850AbUJGWIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269850AbUJGWIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269827AbUJGWIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:08:30 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13969 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269830AbUJGWFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:05:40 -0400
Subject: Re: [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
In-Reply-To: <4164A664.9040005@yahoo.com.au>
References: <1097110266.4907.187.camel@arrakis>
	 <4164A664.9040005@yahoo.com.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097186290.17473.13.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 07 Oct 2004 14:58:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 19:13, Nick Piggin wrote:
> Matthew Dobson wrote:
> > This code is in no way complete.  But since I brought it up in the
> > "cpusets - big numa cpu and memory placement" thread, I figure the code
> > needs to be posted.
> > 
> > The basic idea is as follows:
> > 
> > 1) Rip out sched_groups and move them into the sched_domains.
> > 2) Add some reference counting, and eventually locking, to
> > sched_domains.
> > 3) Rewrite & simplify the way sched_domains are built and linked into a
> > cohesive tree.
> > 
> 
> OK. I'm not sure that I like the direction, but... (I haven't looked
> too closely at it).

The patch is made somewhat larger by a lot of variable renaming because
of the removal of sched_groups.  A lot of s/group/domain/.  The vast
majority of the changes are in a rewrite of arch_init_sched_domains &
it's assorted helpers.


> > This should allow us to support hotplug more easily, simply removing the
> > domain belonging to the going-away CPU, rather than throwing away the
> > whole domain tree and rebuilding from scratch.
> 
> Although what we have in -mm now should support CPU hotplug just fine.
> The hotplug guys really seem not to care how disruptive a hotplug
> operation is.

I wasn't trying to imply that CPU hotplug isn't supported right now. 
But it is currently a very disruptive operation, throwing away the
entire sched_domains & sched_groups tree and then rebuilding it from
scratch just to remove a single CPU!  I also understand that this is
supposed to be a rare event (CPU hotplug), but that doesn't mean it
*has* to be a slow, disruptive event. :)


> >  This should also allow
> > us to support multiple, independent (ie: no shared root) domain trees
> > which will facilitate isolated CPU groups and exclusive domains.  I also
> 
> Hmm, what was my word for them... yeah, disjoint. We can do that now,
> see isolcpus= for a subset of the functionality you want (doing larger
> exclusive sets would probably just require we run the setup code once
> for each exclusive set we want to build).

The current code doesn't, to my knowledge support multiple isolated
domains.  You can set up a single 'isolated' group with boot time
options, but you can't set up *multiple* isolated groups, nor is there
the ability to do any partitioning/isolation at runtime.  This was more
of the motivation for my code than the hotplug simplification.  That was
more of a side-benefit.


> > hope this will allow us to leverage the existing topology infrastructure
> > to build domains that closely resemble the physical structure of the
> > machine automagically, thus making supporting interesting NUMA machines
> > and SMT machines easier.
> > 
> > This patch is just a snapshot in the middle of development, so there are
> > certainly some uglies & bugs that will get fixed.  That said, any
> > comments about the general design are strongly encouraged.  Heck, any
> > feedback at all is welcome! :) 
> > 
> > Patch against 2.6.9-rc3-mm2.
> 
> This is what I did in my first (that nobody ever saw) implementation of
> sched domains. Ie. no sched_groups, just use sched_domains as the balancing
> object... I'm not sure this works too well.
> 
> For example, your bottom level domain is going to basically be a redundant,
> single CPU on most topologies, isn't it?
> 
> Also, how will you do overlapping domains that SGI want to do (see
> arch/ia64/kernel/domain.c in -mm kernels)?
> 
> node2 wants to balance between node0, node1, itself, node3, node4.
> node4 wants to balance between node2, node3, itself, node5, node6.
> etc.
> 
> I think your lists will get tangled, no?

Yes.  I have to put my thinking cap on snug, but I don't think my
version would support this kind of setup.  It sounds, from Jesse's
follow up to your mail, that this is not a requirement, though.  I'll
take a closer look at the IA64 code and see if it would be supported or
if I could make some small changes to support it.

Thanks for the feedback!!

-Matt

