Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUAZXB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbUAZXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:01:58 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:60314 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265531AbUAZXBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:01:55 -0500
Message-ID: <40159C41.9030707@cyberone.com.au>
Date: Tue, 27 Jan 2004 10:01:21 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
References: <20040125235431.7BC192C0FF@lists.samba.org> <4014CF39.50209@cyberone.com.au> <315060000.1075134874@[10.10.2.4]>
In-Reply-To: <315060000.1075134874@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>	Looking at your new scheduler in -mm, it uses cpu_online_map
>>>alot in arch_init_sched_domains.  This means with hotplug CPU that it
>>>would need to be modified: certainly possible to do, but messy.
>>>
>>>	The other option is to use cpu_possible_map to create the full
>>>topology up front, and then it need never change.  AFAICT, no other
>>>changes are neccessary: you already check against moving tasks to
>>>offline cpus.
>>>
>>>Anyway, I was just porting the hotplug CPU patches over to -mm, and
>>>came across this, so I thought I'd ask.
>>>
>>>
>>Hi Rusty,
>>Yes I'd like to use the cpu_possible_map to create the full
>>topology straight up. Martin?
>>
>
>Well isn't it a bad idea to have cpus in the data that are offline?
>It'll throw off all your balancing calculations, won't it? You seemed
>to be careful to do things like divide the total load on the node by
>the number of CPUs on the node, and that'll get totally borked if you
>have fake CPUs in there.
>

I think it mostly does a good job at making sure to only take
online cpus into account. If there are places where it doesn't
then it shouldn't be too hard to fix.


>
>To me, it'd make more sense to add the CPUs to the scheduler structures
>as they get brought online. I can also imagine machines where you have
>a massive (infinite?) variety of possible CPUs that could appear - 
>like an NUMA box where you could just plug arbitrary numbers of new
>nodes in as you wanted.
>

I guess so, but you'd still need NR_CPUS to be >= that arbitrary
number.

>
>Moreover, as the CPUs aren't fixed numbers in advance, how are you going 
>to know which node to put them in, etc? Setting up every possible thing 
>in advance seems like an infeasible way to do hotplug to me. 
>

Well this would be the problem. I guess its quite possible that
one doesn't know the topology of newly added CPUs before hand.

Well OK, this would require a per architecture function to handle
CPU hotplug. It could possibly just default to arch_init_sched_domains,
and just completely reinitialise everything which would be the simplest.


