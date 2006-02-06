Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWBFHk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWBFHk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWBFHk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:40:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43965 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750724AbWBFHkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:40:55 -0500
Date: Mon, 6 Feb 2006 08:39:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206073938.GA24366@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060205203711.2c855971.akpm@osdl.org> <20060205225629.5d887661.pj@sgi.com> <20060205230816.4ae6b6e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205230816.4ae6b6e2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> We're all on the same page here.  I'm questioning whether slab and 
> pagecache should be inextricably lumped together though.
> 
> Is it possible to integrate the slab and pagecache allocation policies 
> more cleanly into a process's mempolicy?  Right now, MPOL_* are 
> disjoint.
> 
> (Why is the spreading policy part of cpusets at all?  Shouldn't it be 
> part of the mempolicy layer?)

the whole mempolicy design seems to be too coarse: it is a fundamentally 
per-node thing, while workloads often share nodes. So it seems to me the 
approach Paul took was to make things more finegrained via cpusets - as 
that seems to be the preferred method to isolate workloads anyway.  
Cpusets are a limited form of virtualization / resource allocation, they 
allow the partitioning of a workload to a set of CPUs and a workload's 
memory allocations to a set of nodes.

in that sense, if we accept cpusets as the main abstraction for workload 
isolation on NUMA systems, it would be a natural and minimal extension 
to attach an access pattern hint to the cpuset - which is the broadest 
container of the workload. Mempolicies are pretty orthogonal to this and 
do not allow the separate handling of two workloads living in two 
different cpusets.

once we accept cpusets as the main abstraction, i dont think there is 
any fundamentally cleaner solution than the one presented by Paul. The 
advantage of having a 'global, per-cpuset' hint is obvious: the 
administrator can set it without having to change applications. Since it 
is global for the "virtual machine" (that is represented by the cpuset), 
the natural controls are limited to kernel entities: slab caches, 
pagecache, anonymous allocations.

what feels hacky is the knowledge about kernel-internal caches, but 
there's nothing else to control i think. Making it finegrained to the 
object level would make it impractical to use in the cpuset abstraction.

if we do not accept cpusets as the main abstraction, then per-task and
per-object hints seem to be the right control - which would have to be
used by the application.

the cpuset solution is certainly simpler to implement: the cpuset is 
already available to the memory allocator, so it's a simple step to 
extend it. Object-level flags would have to be passed down to the 
allocators - we dont have those right now as allocations are mostly 
anonymous.

also, maybe application / object level hints are _too_ finegrained: if a 
cpuset is used as a container for a 'project', then it's easy and 
straightforward to attach an allocation policy to it. Modifying hundreds 
of apps, some of which might be legacy, seems impractical - and the 
access pattern might very much depend on the project it is used in.

so to me the cpuset level seems to be the most natural point to control 
this: it is the level where resources are partitioned, and hence anyone 
configuring them should have a good idea about the expected access 
patterns of the project the cpuset belongs to. The application writer 
has little idea about the circumstances the app gets used in.

if we want to reduce complexity, i'd suggest to consolidate the MPOL_* 
mechanism into cpusets, and phase out the mempolicy syscalls. (The sysfs 
interface to cpusets is much cleaner anyway.)

	Ingo
