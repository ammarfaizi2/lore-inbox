Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbVLOMwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbVLOMwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVLOMwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:52:10 -0500
Received: from smtpout.mac.com ([17.250.248.71]:46295 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965202AbVLOMwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:52:08 -0500
In-Reply-To: <20051215090401.GV23384@wotan.suse.de>
References: <20051215033937.GC11856@waste.org> <20051214.203023.129054759.davem@davemloft.net> <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com> <20051215.002120.133621586.davem@davemloft.net> <9E6D85FF-E546-4057-80EF-7479021AFAA1@mac.com> <20051215090401.GV23384@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8FC3785F-01B3-4F9A-9E3C-89E90CB719B0@mac.com>
Cc: "David S. Miller" <davem@davemloft.net>, sri@us.ibm.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Fine-grained memory priorities and PI
Date: Thu, 15 Dec 2005 07:51:10 -0500
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 15, 2005, at 04:04, Andi Kleen wrote:
>> When processes request memory through any subsystem, their memory  
>> priority would be passed through the kernel layers to the  
>> allocator, along with any associated information about how to free  
>> the memory in a low-memory condition.  As a result, I could  
>> configure my database to have a much higher priority than  
>> SETI@home (or boinc or whatever), so that when the database server  
>> wants to fill memory with clean DB cache pages, the kernel will  
>> kill SETI@home for it's memory, even if we could just leave some  
>> DB cache pages unfaulted.
>
> Iirc most of the freeing happens in process context anyways, so  
> process priority information is already available. At least for CPU  
> cost it might even be taken into account during schedules (Freeing  
> can take up quite a lot of CPU time)
>
> The problem with GFP_ATOMIC is though that someone else needs to  
> free the memory in advance for you because you cannot do it yourself.
>
> (you could call it a kind of "parasite" in the normally very  
> cooperative society of memory allocators ...)
>
> That would mess up your scheme too. The priority cannot be  
> expressed because it's more a case of
> "somewhen someone in the future might need it"

Well, that's currently expressed as a reserved pool with watermarks,  
so with a PI system you would have a single pool with some collection  
of reservation watermarks with various priorities.  I'm not sure what  
the best data-structure would be, probably some sort of ordered  
priority tree.  When allocating or freeing memory, the code would  
check the watermark data (which has some summary statistics so you  
don't need to check the whole tree each time); if any of the  
watermarks are too low with relative priority taken into account, you  
fail the allocation or move pages into the pool.

>> Questions? Comments? "This is a terrible idea that should never  
>> have seen the light of day"? Both constructive and destructive  
>> criticism welcomed! (Just please keep the language clean! :-D)
>
> This won't help for this problem here - even with perfect  
> priorities you could still get into situations where you can't make  
> any progress if progress needs more memory.

Well the point would be that the priorities could force a more- 
extreme and selective OOM (maybe even dropping dirty pages for  
noncritical filesystems if necessary!), or handle the situation  
described with the IPSec daemon and IPSec network traffic (IPSec  
would inherit the increased memory priority, and when it tries to do  
networking, its send path and the global receive path would inherit  
that increased priority as well.

Naturally this is all still in the vaporware stage, but I think that  
if implemented the concept might at least improve the OOM/low-memory  
situation considerably.  Starting to fail allocations for the cluster  
programs (including their kernel allocations) well before failing  
them for the swap-fallback tool would help the original poster, and I  
imagine various tweaked priorities would make true OOM-deadlock far  
less likely.

Cheers,
Kyle Moffett

--
When you go into court you either want a very, very, very bright line  
or you want the stomach to outlast the other guy in trench warfare.   
If both sides are reasonable, you try to stay _out_ of court in the  
first place.
   -- Rob Landley



