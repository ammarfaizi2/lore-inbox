Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUJJCS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUJJCS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUJJCS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:18:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29836 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268037AbUJJCS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:18:26 -0400
Date: Sat, 9 Oct 2004 19:15:56 -0700
From: Paul Jackson <pj@sgi.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: colpatch@us.ibm.com, mbligh@aracnet.com, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041009191556.06e09c67.pj@sgi.com>
In-Reply-To: <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
References: <20041007072842.2bafc320.pj@sgi.com>
	<200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick replying to Paul:
> > But doesn't CKRM provide a way to control what percentage of the
> > compute cycles are available from a pool of cycles?
> > 
> > And don't cpusets provide a way to control which physical CPUs a
> > task can or cannot use?
> 
> Right.

I am learning (see other messages of the last couple days on this
thread) that CKRM is supposed to be a general purpose workload manager
framework, and that fair share scheduling (managing percentage of
compute cycles) just happens to be the first instance of such a manager.

> And what I'm hearing is that if you're a job running in a set of shared
> resources (i.e., non-exclusive) then by definition you are *not* a job
> who cares about which processor you run on.  I can't think of a situation
> where I'd care about the physical locality, and the proximity of memory
> and other nodes, but NOT care that other tasks might steal my cycles.

There are at least these situations:
 1) proximity to special hardware (graphics, networking, storage, ...)
 2) non-dedicated tightly coupled multi-threaded apps (OpenMP, MPI)
 3) batch managers switching resources between jobs

On (2), if say you want to run eight copies of an application, on a
system that only has eight CPUs, where each copy of the app is an
eight-way tightly coupled app, they will go much faster if each app is
placed across all 8 CPUs, one thread per CPU, than if they are placed
willy-nilly.  Or a bit more realistically, if you have a random input
queue of such tightly coupled apps, each with a predetermined number of
threads between one and eight, you will get more work done by pinning
the threads of any given app on different CPUs.  The users submitting
the jobs may well not care which CPUs are used for their job, but an
intermediate batch manager probably will care, as it may be solving the
knapsack problem of how to fit a stream of varying sized jobs onto a
given size of hardware.

On (3), a batch manager might say have two small cpusets, and also one
larger cpuset that is the two small ones combined.  It might run one job
in each of the two small cpusets for a while, then suspend these two
jobs, in order to run a third job in the larger cpuset.  The two small
cpusets don't go away while the third job runs -- you don't want to lose
or have to tear down and rebuild the detailed inter-cpuset placement of
the two small jobs while they are suspended.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
