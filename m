Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbUAZXn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbUAZXnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:43:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10918 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265626AbUAZXlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:41:52 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: New NUMA scheduler and hotplug CPU
Date: Mon, 26 Jan 2004 17:40:12 -0600
User-Agent: KMail/1.5
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20040125235431.7BC192C0FF@lists.samba.org> <315060000.1075134874@[10.10.2.4]> <40159C41.9030707@cyberone.com.au>
In-Reply-To: <40159C41.9030707@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401261740.12657.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >To me, it'd make more sense to add the CPUs to the scheduler structures
> >as they get brought online. I can also imagine machines where you have
> >a massive (infinite?) variety of possible CPUs that could appear -
> >like an NUMA box where you could just plug arbitrary numbers of new
> >nodes in as you wanted.
>
> I guess so, but you'd still need NR_CPUS to be >= that arbitrary
> number.
>
> >Moreover, as the CPUs aren't fixed numbers in advance, how are you going
> >to know which node to put them in, etc? Setting up every possible thing
> >in advance seems like an infeasible way to do hotplug to me.
>
> Well this would be the problem. I guess its quite possible that
> one doesn't know the topology of newly added CPUs before hand.
>
> Well OK, this would require a per architecture function to handle
> CPU hotplug. It could possibly just default to arch_init_sched_domains,
> and just completely reinitialise everything which would be the simplest.

Call me crazy, but why not let the topology be determined via userspace at a 
more appropriate time?  When you hotplug, you tell it where in the scheduler 
to plug it.  Have structures in the scheduler which represent the 
nodes-runqueues-cpus topology (in the past I tried a node/rq/cpu structs with 
simple pointers), but let the topology be built based on user's desires thru 
hotplug.  

For example, you boot on just the boot cpu, which by default is in the first 
node on the first runqueue.  All other cpus, whether being "booted" for the 
for the first time or hotplugged (maybe now there's really no difference), 
the hotplugging tells where the cpu should be, in what node and what 
runqueue.  HT cpus work even better, because you can hotplug siblings, once 
at a time if you wanted, to the same runqueue.  Or you have cpus sharing a 
die, same thing, lots of choices here.  This removes any per-arch updates to 
the kernel for things like scheduler topology, and lets them go somewhere 
else more easily changes, like userspace. 

Forgive me if this sounds stupid; I have not been following the discussion 
closely.



