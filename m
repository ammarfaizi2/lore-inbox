Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTBLEcI>; Tue, 11 Feb 2003 23:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBLEcI>; Tue, 11 Feb 2003 23:32:08 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:34280 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266859AbTBLEcB>;
	Tue, 11 Feb 2003 23:32:01 -0500
Date: Wed, 12 Feb 2003 10:17:05 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030212101705.A1593@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E4914CA.6070408@mvista.com>; from cminyard@mvista.com on Tue, Feb 11, 2003 at 09:20:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 09:20:42AM -0600, Corey Minyard wrote:
> |The scope here was just the case that Eric seemed to be
> |trying to address, the way I understood it, and hence a much
> |simpler subset of the problem at hand, since it is not really
> |tackling the rouge/buggy cases. There is no restriction on
> |where DMA can happen, just a block of memory area set aside
> |for the dormant kernel to use when it is instantiated.
> |So this is an area that the current kernel will not use or
> |touch and not specify as a DMA target during "regular"
> |operation.
> 
> You don't understand.  You don't *want* to set aside a block of memory 
> that's
> reserved for DMA.  You want to be able to DMA directly into any user 
> address.
> Consider demand paging.  The performance would suck if you DMA into some
> fixed region then copied to the user address.  Plus you then have another
> resource you have to manage in the kernel.  And you still have to change all
> the drivers, buffer management, etc. to add a flag that says "I'm going 
> to use
> this for DMA" to allocations.  

That is not what I'm suggesting. I wish I knew a better way 
to put myself in your shoes and explain this from your context
without repeating myself. 

I'm not talking about DMA'ing into a fixed region and copying
into user address. 

There is just this (say) 4MB area that the current kernel thinks
is reserved/already allocated. When the recovery kernel comes up
it thinks its booted with just this 4MB of memory, quickly performs
the writeout of the dump to disk (which in the case of lkcd
happens straight from the kernel, _unlike_ MCL which needs 
filesystems mounted and drives this from user space), and 
then reboots itself the normal way (i.e. not via kexec). 

So while the recovery kernel is running in a very constrained 
way, it is not _meant_ to be dealing with user-space workloads 
etc - just a disk writeout and a prompt reboot.

And there is no need to change drivers, buffer mgmt etc in any
of this. There is no explicit limitation on where to or not to
DMA from.

It is simply what Eric was suggesting, minus the need to build
the recovery kernel to be able to run from different physical
addresses.

That's about all !

Does this make things any clearer ?

> You might as well add the quiesce 
> function, it's probably easier to do.  

Yes if that can be done for all drivers, well and good.

> And it doesn't help if you DMA to static memory
> addresses.

Again I'm not suggesting we DMA into static memory addresses.
Quite the reverse actually.
The point was that this scheme wouldn't help in the cases where
DMA is happening to static memory addresses.

> 
> I, too, would like a simpler solution. I just don't think 
this is it.

This wasn't even intended to be a full solution as Eric
has already observed. 

I think we must quiesce the devices. Just that for the
cases that this isn't happening yet, we are a little 
better off than having nothing all all.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

