Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVC3Vam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVC3Vam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVC3Vak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:30:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29865 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262099AbVC3V35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:29:57 -0500
To: Diego Calleja <diegocg@gmail.com>
cc: Paul Jackson <pj@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 0/8] CKRM: Core patch set 
In-reply-to: Your message of Wed, 30 Mar 2005 22:55:05 +0200.
             <20050330225505.7a443227.diegocg@gmail.com> 
Date: Wed, 30 Mar 2005 13:29:53 -0800
Message-Id: <E1DGkl7-0002aV-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Mar 2005 22:55:05 +0200, Diego Calleja wrote:
> El Tue, 29 Mar 2005 22:05:30 -0800,
> Paul Jackson <pj@engr.sgi.com> escribi=F3:
> 
> 
> > worth having.  I for one am a CKRM skeptic, so won't be much help to you
> > in that quest.  Good luck.
> >
> > I don't see any performance numbers, either on small systems, or
> > scalability on large systems.  Certainly this patch does not fall under
> > the "obviously no performance impact" exclusion.
> 
> I'm one of those people who also thinks that CKRM tries to do too much things, and
> although my opinion doesn't counts a lot, I'll try to explain myself anyway :)
>
> One of the things I personally don't like about CKRM its how it handles "CPU resources".
> The goal of CKRM seems to be "control how much % a process can get get", but the
> amount of concepts created to achieve that is too huge and too complex. For the
> "CPU resources", I think that there're much simpler and better solutions. For example,
> instead what CRKM proposes I propose a simpler concept: "attaching" GIDs to a
> niceness level.

Well, the current code and the stacked up patch sets don't currently
include a CPU resource controller, although the SuSE distro version does.
We've pulled back on that for the time being since the scheduler has
been under so much revision lately.  However, resource utilization at the
priority level does not allow you to say "OpenOffice can have up to 30%
of my CPU, my email client is guaranteed to get at least 5%, and Firefox +
Java apps get no more than 50% of my machine, and my CD player gets 10%".
Niceness levels provide none of that level of resource control.  Also,
GID's have no utility on a desktop machine, other than to separate
possibly background tasks like updatedb vs. all my real time apps.

> Say, we "attach" group foo to nice level -5. All users who belong to group foo will have
> permissions to renice themselves to nice -5. If instead of that, group foo has been
> attached at nice level 15, all processes from users who belong to foo will be run at 15,
> and they won't be able to renice themselves even to the default priority (0)
 
 Again, great for multiuser systems if you just want people to be prioritized
 as opposed to work.  But more often on larger multiuser systems, you want various
 services to have priorities.  For instance, a web server may be allowed some
 rate of incoming connections or some amount of CPU bandwidth; a database may
 have memory limits, CPU limits (or allowing "at least" some percentage, possibly
 also limiting it from taking over the entire machine; and IO limits in terms
 amount disk traffic.  These limits may allow various clients or web servers
 to make progress without getting drowned out by some large server which
 wants to consume 100% of cpu or all of available memory.

> This should be very easy to implement, and what's more important, it'd probably have
> zero performance impact at runtime - CRKM touches hot paths in the scheduler
> I think, this would just touch a few non-critical places - because we'd just use a existing
> concept.

 Not currently in the patches being brought forward to LKML.

> Sure, this can't guarantee that a group will get reserved exactly 57% of  the CPU, but I
> think that such level of detail is unnecesary - instead we let the kernel uses the
> standard internal mechanisms to do the dirty job based in the distinction between
> standard nice levels. (And we could get that level of detail just by modifying the
> scheduler algorithm and adding a range of -50...0...50 nice levels ;)
 
 Also, with various implementation of the scheduler, the nice levels have been
 either studiously ignored or sometimes at the other extreme there has been a
 more clear stairstepping of nice levels.  Relying on predictability here based
 on the current algorithm is not a great formula for success, nor does it address
 the needs of most desktop or server users in any simple/easy to use way.

> For the CPU resources, we already have nice levels. The existing algorithms can already
> handle priorities with them. CKRM alternative seems to be to add a second scheduling
> algorithm which in super-hot paths like the ones from sched.c are, it will probably have a
> performance impact. In my very humble opinion, I think we should reuse existing UNIX
> concepts and combine them to achieve some of the goals CKRM tries to achieve in
> a much simpler (unixy ;) way.

 I'd love to see patches which could be validated by folks like the PlanetLab
 folks, for instance.  I don't believe it is possible to get the level of machine
 partitioning/virtualization that CKRM provides with this overly simple prioritization
 scheme.

gerrit
