Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUJHAgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUJHAgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbUJHAck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:32:40 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:35955 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269896AbUJHAWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:22:40 -0400
Message-ID: <4165DDB4.1070806@yahoo.com.au>
Date: Fri, 08 Oct 2004 10:22:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
Subject: Re: [RFC PATCH] scheduler: Dynamic sched_domains
References: <1097110266.4907.187.camel@arrakis>	 <4164A664.9040005@yahoo.com.au> <1097186290.17473.13.camel@arrakis>
In-Reply-To: <1097186290.17473.13.camel@arrakis>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

>On Wed, 2004-10-06 at 19:13, Nick Piggin wrote:
>
>>Matthew Dobson wrote:
>>
>
>>>This should allow us to support hotplug more easily, simply removing the
>>>domain belonging to the going-away CPU, rather than throwing away the
>>>whole domain tree and rebuilding from scratch.
>>>
>>Although what we have in -mm now should support CPU hotplug just fine.
>>The hotplug guys really seem not to care how disruptive a hotplug
>>operation is.
>>
>
>I wasn't trying to imply that CPU hotplug isn't supported right now. 
>But it is currently a very disruptive operation, throwing away the
>entire sched_domains & sched_groups tree and then rebuilding it from
>scratch just to remove a single CPU!  I also understand that this is
>supposed to be a rare event (CPU hotplug), but that doesn't mean it
>*has* to be a slow, disruptive event. :)
>
>

Well no... but it already is disruptive :)

>
>>> This should also allow
>>>us to support multiple, independent (ie: no shared root) domain trees
>>>which will facilitate isolated CPU groups and exclusive domains.  I also
>>>
>>Hmm, what was my word for them... yeah, disjoint. We can do that now,
>>see isolcpus= for a subset of the functionality you want (doing larger
>>exclusive sets would probably just require we run the setup code once
>>for each exclusive set we want to build).
>>
>
>The current code doesn't, to my knowledge support multiple isolated
>domains.  You can set up a single 'isolated' group with boot time
>options, but you can't set up *multiple* isolated groups, nor is there
>the ability to do any partitioning/isolation at runtime.  This was more
>of the motivation for my code than the hotplug simplification.  That was
>more of a side-benefit.
>
>

No, the isolcpus= option allows you to set up n *single CPU* isolated
domains. You currently can't setup isolated groups with multiple CPUs
in them, no. You can't do runtime partitioning either.

I think both would be pretty trivial to do though with the current
code though.

>
>>>hope this will allow us to leverage the existing topology infrastructure
>>>to build domains that closely resemble the physical structure of the
>>>machine automagically, thus making supporting interesting NUMA machines
>>>and SMT machines easier.
>>>
>>>This patch is just a snapshot in the middle of development, so there are
>>>certainly some uglies & bugs that will get fixed.  That said, any
>>>comments about the general design are strongly encouraged.  Heck, any
>>>feedback at all is welcome! :) 
>>>
>>>Patch against 2.6.9-rc3-mm2.
>>>
>>This is what I did in my first (that nobody ever saw) implementation of
>>sched domains. Ie. no sched_groups, just use sched_domains as the balancing
>>object... I'm not sure this works too well.
>>
>>For example, your bottom level domain is going to basically be a redundant,
>>single CPU on most topologies, isn't it?
>>
>>Also, how will you do overlapping domains that SGI want to do (see
>>arch/ia64/kernel/domain.c in -mm kernels)?
>>
>>node2 wants to balance between node0, node1, itself, node3, node4.
>>node4 wants to balance between node2, node3, itself, node5, node6.
>>etc.
>>
>>I think your lists will get tangled, no?
>>
>
>Yes.  I have to put my thinking cap on snug, but I don't think my
>version would support this kind of setup.  It sounds, from Jesse's
>follow up to your mail, that this is not a requirement, though.  I'll
>take a closer look at the IA64 code and see if it would be supported or
>if I could make some small changes to support it.
>
>

I they might find that it will be a requirement. If not now, then soon.
Your periodic balancing happens from the timer interrupt as you know...
that means pulling a cacheline off every CPU.

But anyway..

>Thanks for the feedback!!
>

OK... I still don't know exactly how your system is an improvement over what
we have, but I'll try to be open minded :)

