Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267790AbTBJL5m>; Mon, 10 Feb 2003 06:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267791AbTBJL5m>; Mon, 10 Feb 2003 06:57:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:60104 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267790AbTBJL5j>;
	Mon, 10 Feb 2003 06:57:39 -0500
Date: Mon, 10 Feb 2003 17:42:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Corey Minyard <cminyard@mvista.com>, Kenneth Sumrall <ken@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030210174243.B11250@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1d6m1z4bk.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Feb 09, 2003 at 11:39:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 11:39:27AM -0700, Eric W. Biederman wrote:
> Corey Minyard <cminyard@mvista.com> writes:
> 
> With respect to DMA and SMP handling for kexec on panic that case is
> much trickier.  A lot of the normal methods simply don't apply because
> by definition in a panic something is broken, and that something may
> be the code we need to cleanly shutdown the hardware.  But I an not
> ready to sacrifice a method that works well in a properly working
> kernel just because the panic case can't use it.
> 
> In getting it working I suggest we start with the easy cases, where
> DMA and SMP are not big issues.  And then we can have a working
> framework.

I'd agree. That was also the idea behind the patch we'd just posted 
for LKCD. With a basic working framework in hand that works for 
simpler cases, we can now keep working on addressing more and harder 
situations bit by bit.

> 
> I am still digesting the crash dump code I have seen, but as far as I
> can tell what it does is to compress the contents of memory, for
> writing out later.

Yes. It actually saves a formatted compressed dump in memory,
and later writes it out to disk as is. 

> 
> To handle the hard cases for kexec on panic I would recommend the
> following.
> 
> - Place the recovery code in a reserved area of memory that the normal
>   kernel will not touch, and actually run the code there.  This
>   trivially solves the DMA problem because the hardware is not DMA'ing
> 
> - Setup the kernel that does the recovery so that the pool of memory
>   it uses for dynamic allocations is also in the reserved area of
>   memory so that it is equally free of DMA dangers.
> 
> - Modify the kernel that does the recovery so it can be run at
>   different physical address from the standard kernel, so it will not
>   need to be moved out of the reserved area of memory.

Are you trying to address the possibility that DMA is overwriting
memory we are using in the recovery code, due to a runaway driver
or other code passing a wrong memory address to a device (e.g. in 
a corrupted command area) ? I'm wondering if just reserving 
an area of memory would help. As long as the address is visible/
accessible by the device (i.e. unless we have the h/w support to
apply protection at that level), can we really be safe in those
weird or rare cases ?  Disabling the bus-master sounds like a
more dependable option for that (via device shutdown or reboot 
notifiers as suitable) if it can be done.

Placing the recovery code in a safe reserved area (that the
running kernel may not know about or may be protected),
may reduce the possibility of the panic/buggy kernel overwriting 
it, but will it help the DMA case ?

> 
> - Modify the kernel that does the recovery to not care about
>   which cpu in a SMP system it comes up on first.
> 
> - Modify the kernel that does the recovery so that it is very robust
>   in reinitializing devices.  So it can cope with devices in a random
>   state.  Though most devices can be handled by simply ignoring them.
> 
> - Possibly preserve in the reserved area a separate copy of the tables
>   ACPI/MP/etc that the kernel needs for coming up.  I actually don't
>   think this needs to happen as the kernel preserves those in place
>   already.
> 
> At that point I believe a full memory core dump can be achieved
> without needing to do anything except to jump to the other kernel
> on panic.  All of the memory can be preserved because the kexec case
> would not have touched it.
> 
> I find this very attractive because it can be done with a very low
> impact on the primary kernel whose panic we want to capture, plus it
> is an extremely robust solution.
> 
> The one piece I don't know about is how to prioritize which pieces of
> memory are written out first.  It is certainly a desirable feature
> but do we need that, if we can preserve everything?  Or is it easy
> enough to get the prioritizing information that we don't care.

LKCD has support for doing that - it provides for specifying dump
levels, to dump just a header, kernel pages, all in-use pages and
full-memory.  This can be tuned/extended for some more intermediate
levels (e.g. header + stack traces for all cpus). 

There is also some work-in-progress code for more granular 
dump customisation as a future item.

While the patch I'd posted has been designed so that ideally 
it should be possible to preserve everything, I'm still not 
certain if the compression we get is good enough for all cases 
(e.g a heavily loaded system with lots of non-redundant data) 
-- we really need to play around with the implementation and 
tune it. Secondly, for a large memory system, it could take a 
bit of time to compress all pages, and we might just want to 
dump potentially more relevant data (e.g kernel pages) for 
some kind of problems. It was easy enough to do this with some 
simple heuristics like dumping inuse pages which are nonlru.

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

