Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVLQUQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVLQUQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLQUQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:16:51 -0500
Received: from smtpout.mac.com ([17.250.248.73]:23766 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932180AbVLQUQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:16:50 -0500
In-Reply-To: <p73slsrehzs.fsf@verdi.suse.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <714652CE-EA33-4DD0-B9BB-C1D0E597F7F2@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sat, 17 Dec 2005 15:16:28 -0500
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17, 2005, at 12:44, Andi Kleen wrote:
> Kernel code is getting more complex all the time and running with  
> very tight stack is just risky.

IMPORTANT POINT:  The 4k-stacks code does *NOT* reduce overall  
available stack!!!  With the old code we have 8k of _total_ stack.   
With the new code we have 4k of interrupt stack and 4k of per-process  
stack.  This makes stack-overflows a _LOT_ more debuggable, because  
it's not a coincidence of high process-stack-usage and high interrupt- 
stack-usage.

>> The point is to force it in -mm so most people can't just disable  
>> it  because it fixes their problem.  We want 8k stacks to go away
>
> Who is we? And why?
>
> About the only half way credible arguments I've seen for it were:

I posted a list of links to the archives of various reasons a day or  
so ago, but for summary:

This helps for some NUMA systems because single pages can come out of  
a per-cpu pool instead of requiring global allocator locks.

> - "it might reduce stalls in the VM with order 1". Didn't quite  
> convince me because there were no numbers presented and at least on  
> x86-64 I've never noticed or got reported significant stalls  
> because of this.

One comment on x86-64 vs. x86:  There are restrictions on where in  
memory your process stacks can be located on a 32-bit platform.  They  
need to reside in lowmem, which means under certain circumstances  
your lowmem can get too fragmented to create new processes even  
though you still have a lot of available RAM.

> - "it allows more threads for 32bit which might run out of lowmem"  
> - i think everybody agrees that the 10k threads case is not really  
> something to encourage.

Who is this "everybody" of whom you speak?  :-D.  Personally I agree  
that we shouldn't _encourage_ 10k threads, but there are existing  
userspace programs which do that, and I think we should support them  
as much as possible.

> And even when you want to add it then only a factor two increase  
> (which this patch brings) is not really too helpful.

The fragmentation behavior and optimizations for order-1 vs. order-0  
_is_ significant.  You can _always_ allocate order-0 pages if you  
have any free memory in that zone, which is _not_ necessarily true  
for order-N pages. (even if N==1).  Also, I think some of the  
fragmentation avoidance attempts get significantly easier and produce  
much better results if all the kernel stacks are order-0.

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley





