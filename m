Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWFAHof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFAHof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFAHof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:44:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:29969 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750704AbWFAHoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:44:34 -0400
Message-ID: <447E9A1D.9040109@openvz.org>
Date: Thu, 01 Jun 2006 11:41:17 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Peter Williams <pwil3058@bigpond.net.au>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>, Sam Vilain <sam@vilain.net>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447DBD44.5040602@in.ibm.com>
In-Reply-To: <447DBD44.5040602@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The more runnable tasks there are the less likely it is that any of 
>>> them is exceeding its hard cap due to normal competition for the 
>>> CPUs.  So I think that it's unlikely that there will ever be a very 
>>> large number of tasks in the sinbin at the same time.
>>
>>
>> for containers this can be untrue... :( actually even for 1000 tasks 
>> (I suppose this is the maximum in your case) it can slowdown 
>> significantly as well.
> 
> 
> Do you have any documented requirements for container resource management?
> Is there a minimum list of features and nice to have features for 
> containers
> as far as resource management is concerned?
Sure! You can check OpenVZ project (http://openvz.org) for example of 
required resource management. BTW, I must agree with other people here 
who noticed that per-process resource management is really useless and 
hard to use :(

Briefly about required resource management:
1) CPU:
- fairness (i.e. prioritization of containers). For this we use SFQ like 
fair cpu scheduler with virtual cpus (runqueues). Linux-vserver uses 
tocken bucket algorithm. I can provide more details on this if you are 
interested.
- cpu limits (soft, hard). OpenVZ provides only hard cpu limits. For 
this we account the time in cycles. And after some credit is used do 
delay of container execution. We use cycles as our experiments show that 
statistical algorithms work poorly on some patterns :(
- cpu guarantees. I'm not sure any of solutions provide this yet.

2) disk:
- overall disk quota for container
- per-user/group quotas inside container

in OpenVZ we wrote a 2level disk quota which works on disk subtrees. 
vserver imho uses 1 partition per container approach.

- disk I/O bandwidth:
we started to use CFQv2, but it is quite poor in this regard. First, it 
doesn't prioritizes writes and async disk operations :( And even for 
sync reads we found some problems we work on now...

3) memory and other resources.
- memory
- files
- signals and so on and so on.
For example, in OpenVZ we have user resource beancounters (original 
author is Alan Cox), which account the following set of parameters:
kernel memory (vmas, page tables, different structures etc.), dcache 
pinned size, different user pages (locked, physical, private, shared), 
number of files, sockets, ptys, signals, network buffers, netfilter 
rules etc.

4. network bandwidth
traffic shaping is already ok here.

>>>> Is it possible to use the scheduler_tick() function take a look at all
>>>> deactivated tasks (as efficiently as possible) and activate them when
>>>> its time to activate them or just fold the functionality by defining a
>>>> time quantum after which everyone is worken up. This time quantum
>>>> could be the same as the time over which limits are honoured.
>>
>>
>> agree with it.
> 
> 
> Thinking a bit more along these lines, it would probably break O(1). But 
> I guess a good
> algorithm can amortize the cost.
this is the price to pay. but it happens quite rarelly as was noticed 
already...

Kirill

