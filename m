Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUAZXYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265587AbUAZXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:24:46 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:39162 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265586AbUAZXYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:24:42 -0500
Date: Mon, 26 Jan 2004 15:24:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
Message-ID: <31860000.1075159471@flay>
In-Reply-To: <40159C41.9030707@cyberone.com.au>
References: <20040125235431.7BC192C0FF@lists.samba.org> <4014CF39.50209@cyberone.com.au> <315060000.1075134874@[10.10.2.4]> <40159C41.9030707@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well isn't it a bad idea to have cpus in the data that are offline?
>> It'll throw off all your balancing calculations, won't it? You seemed
>> to be careful to do things like divide the total load on the node by
>> the number of CPUs on the node, and that'll get totally borked if you
>> have fake CPUs in there.
> 
> I think it mostly does a good job at making sure to only take
> online cpus into account. If there are places where it doesn't
> then it shouldn't be too hard to fix.

It'd make the code a damned sight simpler and cleaner if you dropped
all that stuff, and updated the structures when you hotplugged a CPU,
which is really the only sensible way to do it anyway ...

For instance, if I remove cpu X, then bring back a new CPU on another node
(or in another HT sibling pair) as CPU X, then you'll need to update all
that stuff anyway. CPUs aren't fixed position in that map - the ordering
handed out is arbitrary.

>> To me, it'd make more sense to add the CPUs to the scheduler structures
>> as they get brought online. I can also imagine machines where you have
>> a massive (infinite?) variety of possible CPUs that could appear - 
>> like an NUMA box where you could just plug arbitrary numbers of new
>> nodes in as you wanted.
> 
> I guess so, but you'd still need NR_CPUS to be >= that arbitrary
> number.

Yup ... but you don't have to enumerate all possible positions that way.
See Linus' arguement re dynamic device numbers and ISCSI disks, etc.
Same thing applies.

> Well this would be the problem. I guess its quite possible that
> one doesn't know the topology of newly added CPUs before hand.
> 
> Well OK, this would require a per architecture function to handle
> CPU hotplug. It could possibly just default to arch_init_sched_domains,
> and just completely reinitialise everything which would be the simplest.

Yeah, it's not trivially simple. But then neither is the rest of CPU 
hotplug, to do it right ;-) Requiring CPU hotplug callback hooks does 
seem to be the right way to interface with the sched code though ...

M.

