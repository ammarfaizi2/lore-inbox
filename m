Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWA1QOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWA1QOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWA1QOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:14:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11930 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965018AbWA1QOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:14:55 -0500
Message-ID: <43DB9877.7020206@us.ibm.com>
Date: Sat, 28 Jan 2006 08:14:47 -0800
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org, andrea@suse.de,
       linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com> <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com> <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com> <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com> <43D96A93.9000600@us.ibm.com> <20060127025126.c95f8002.pj@sgi.com> <43DAC222.4060805@us.ibm.com> <20060128081641.GB1605@elf.ucw.cz>
In-Reply-To: <20060128081641.GB1605@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
> I'll probably regret getting into this discussion, but:
>
>   
>>> Or Alan's suggested revival
>>> of the old code to drop non-critical network patches in duress.
>>>       
>> Dropping non-critical packets is still in our plan, but I don't think that
>> is a FULL solution.  As we mentioned before on that topic, you can't tell
>> if a packet is critical until AFTER you receive it, by which point it has
>> already had an skbuff (hopefully) allocated for it.  If your network
>> traffic is coming in faster than you can receive, examine, and drop
>> non-critical packets you're hosed.  
>>     
>
> Why? You run out of atomic memory, start dropping the packets before
> they even enter the kernel memory, and process backlog in the
> meantime. Other hosts realize you are dropping packets and slow down,
> or, if they are malicious, you just end up consistently dropping 70%
> of packets. But that's okay.
>
>   
>> I still think some sort of reserve pool
>> is necessary to give the networking stack a little breathing room when
>> under both memory pressure and network load.
>>     
>
> "Lets throw some memory there and hope it does some good?" Eek? What
> about auditing/fixing the networking stack, instead?
>   
The other reason we need a separate critical pool is to satifsy critical 
GFP_KERNEL allocations
when we are in emergency. These are made in the send side and we cannot 
block/sleep.
>   
>>>  * this doesn't really solve the problem (network can still starve)
>>>       
>> Only if the pool is not large enough.  One can argue that sizing the pool
>> appropriately is impossible (theoretical incoming traffic over a GigE card
>> or two for a minute or two is extremely large), but then I guess we
>> shouldn't even try to fix the problem...?
>>     
>
> And what problem are you trying to fix, anyway? Last time I asked I
> got reply around some strange clustering solution that absolutely has
> to survive two minutes. And no, your patches do not even solve that,
> because sizing the pool is impossible. 
>   
Yes, it is true that sizing the critical pool may be difficult if we use 
it for all incoming allocations.
May be as an initial solution we could just depend on dropping 
non-critical incoming packets
and use the critical pool only for outgoing allocations. We could 
definitely size the pool if we use
it only for allocations for critical outgoing packets.

Thanks
Sridhar

