Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWA1BAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWA1BAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422769AbWA1BAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:00:24 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:34748 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422733AbWA1BAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:00:23 -0500
Message-ID: <43DAC222.4060805@us.ibm.com>
Date: Fri, 27 Jan 2006 17:00:18 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, sri@us.ibm.com,
       andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain>	<1138233093.27293.1.camel@localhost.localdomain>	<Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>	<43D953C4.5020205@us.ibm.com>	<Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>	<43D95A2E.4020002@us.ibm.com>	<Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>	<43D96633.4080900@us.ibm.com>	<Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com>	<43D96A93.9000600@us.ibm.com> <20060127025126.c95f8002.pj@sgi.com>
In-Reply-To: <20060127025126.c95f8002.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Matthew wrote:
> 
>>I'm glad we're on the same page now. :)  And yes, adding four "duplicate"
>>*_mempool allocators was not my first choice, but I couldn't easily see a
>>better way.
> 
> 
> I hope the following comments aren't too far off target.
> 
> I too am inclined to prefer the __GFP_CRITICAL approach over this.

OK.  Chalk one more up for that solution...


> That or Andrea's suggestion, which except for a free hook, was entirely
> outside of the page_alloc.c code paths.

This is supposed to be an implementation of Andrea's suggestion.  There are
no hooks in ANY page_alloc.c code paths.  These patches touch mempool code
and some slab code, but not any page allocator code.


> Or Alan's suggested revival
> of the old code to drop non-critical network patches in duress.

Dropping non-critical packets is still in our plan, but I don't think that
is a FULL solution.  As we mentioned before on that topic, you can't tell
if a packet is critical until AFTER you receive it, by which point it has
already had an skbuff (hopefully) allocated for it.  If your network
traffic is coming in faster than you can receive, examine, and drop
non-critical packets you're hosed.  I still think some sort of reserve pool
is necessary to give the networking stack a little breathing room when
under both memory pressure and network load.


> I am tempted to think you've taken an approach that raised some
> substantial looking issues:
> 
>  * how to tell the system when to use the emergency pool

We've dropped the whole "in_emergency" thing.  The system uses the
emergency pool when the normal pool (ie: the buddy allocator) is out of pages.

>  * this doesn't really solve the problem (network can still starve)

Only if the pool is not large enough.  One can argue that sizing the pool
appropriately is impossible (theoretical incoming traffic over a GigE card
or two for a minute or two is extremely large), but then I guess we
shouldn't even try to fix the problem...?

>  * it wastes memory most of the time

True.  Any "real" reserve system will suffer from that problem.  Ben
LaHaise suggested a reserve system that allows the reserve pages to be used
for trivially reclaimable allocation while not in active use.  An
interesting idea.  Regardless, the Linux VM sorta already wastes memory by
keeping min_free_kbytes around, no?

>  * it doesn't really improve on GFP_ATOMIC

I disagree.  It improves on GFP_ATOMIC by giving it a second chance.  If
you've got a GFP_ATOMIC allocation that is particularly critical, using a
mempool to back it means that you can keep going for a while when the rest
of the system OOMs/goes into SWAP hell/etc.

> and just added another substantial looking issue:
> 
>  * it entwines another thread of complexity and performance costs
>    into the important memory allocation code path.

I can't say that it doesn't add any complexity into an important memory
allocation path, but I don't think it is a significant amount of
complexity.  It is just a pointer check in kmem_getpages()...


>>With large machines, especially as
>>those large machines' workloads are more and more likely to be partitioned
>>with something like cpusets, you want to be able to specify where you want
>>your reserve pool to come from.
> 
> 
> Cpusets is about performance, not correctness.  Anytime I get cornered
> in the cpuset code, I prefer violating the cpuset containment, over
> serious system failure.

Fair enough.  But if we can keep the same baseline performance and add this
new feature, I'd like to do that.  Doing our best to allocate on a
particular node when requested to isn't too much to ask.

-Matt
