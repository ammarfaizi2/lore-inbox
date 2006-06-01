Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWFAIj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWFAIj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFAIj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:39:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36577 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750795AbWFAIj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:39:27 -0400
Message-ID: <447EA694.8060407@in.ibm.com>
Date: Thu, 01 Jun 2006 14:04:28 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>, Sam Vilain <sam@vilain.net>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>
In-Reply-To: <447E9A1D.9040109@openvz.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kirill,

Kirill Korotaev wrote:
>> Do you have any documented requirements for container resource 
>> management?
>> Is there a minimum list of features and nice to have features for 
>> containers
>> as far as resource management is concerned?
> 
> Sure! You can check OpenVZ project (http://openvz.org) for example of 
> required resource management. BTW, I must agree with other people here 
> who noticed that per-process resource management is really useless and 
> hard to use :(

I'll take a look at the references. I agree with you that it will be useful
to have resource management for a group of tasks.

> 
> Briefly about required resource management:
> 1) CPU:
> - fairness (i.e. prioritization of containers). For this we use SFQ like 
> fair cpu scheduler with virtual cpus (runqueues). Linux-vserver uses 
> tocken bucket algorithm. I can provide more details on this if you are 
> interested.

Yes, any information or pointers to them will be very useful.

> - cpu limits (soft, hard). OpenVZ provides only hard cpu limits. For 
> this we account the time in cycles. And after some credit is used do 
> delay of container execution. We use cycles as our experiments show that 
> statistical algorithms work poorly on some patterns :(
> - cpu guarantees. I'm not sure any of solutions provide this yet.

ckrm has a solution to provide cpu guarantees. 

I think as far as CPU resource management is concerned (limits or guarantees),
there are common problems to be solved, for example

1. Tracking when a limit or a gaurantee is not met
2. Taking a decision to cap the group
3. Selecting the next task to execute (keeping O(1) in mind)

For the existing resource controller in OpenVZ I would be
interested in the information on the kinds of patterns it does not
perform well on and the patterns it performs well on.

> 
> 2) disk:
> - overall disk quota for container
> - per-user/group quotas inside container
> 
> in OpenVZ we wrote a 2level disk quota which works on disk subtrees. 
> vserver imho uses 1 partition per container approach.
> 
> - disk I/O bandwidth:
> we started to use CFQv2, but it is quite poor in this regard. First, it 
> doesn't prioritizes writes and async disk operations :( And even for 
> sync reads we found some problems we work on now...
> 
> 3) memory and other resources.
> - memory
> - files
> - signals and so on and so on.
> For example, in OpenVZ we have user resource beancounters (original 
> author is Alan Cox), which account the following set of parameters:
> kernel memory (vmas, page tables, different structures etc.), dcache 
> pinned size, different user pages (locked, physical, private, shared), 
> number of files, sockets, ptys, signals, network buffers, netfilter 
> rules etc.
> 
> 4. network bandwidth
> traffic shaping is already ok here.

Traffic shaping is just for outgoing traffic right? How about incoming
traffic (through the accept call)

> 

These are a great set of requirements. Thanks for putting them together.


>> Thinking a bit more along these lines, it would probably break O(1). 
>> But I guess a good
>> algorithm can amortize the cost.
> 
> this is the price to pay. but it happens quite rarelly as was noticed 
> already...
> 

Yes, agreed.

> Kirill
> 


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs

PS: I am also cc'ing ckrm-tech and srivatsa
