Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTA1QGG>; Tue, 28 Jan 2003 11:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTA1QGG>; Tue, 28 Jan 2003 11:06:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21653 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267288AbTA1QGF>; Tue, 28 Jan 2003 11:06:05 -0500
Date: Tue, 28 Jan 2003 08:15:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kexec reboot code buffer
Message-ID: <1470350000.1043770519@titus>
In-Reply-To: <m1n0ll68jd.fsf@frodo.biederman.org>
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org><3E35AAE4.10204@us.ibm.com> <203100000.1043705004@flay> <m1n0ll68jd.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> We talked about creating a new zone specifically for DMA32 (ie <4Gb)
>> for other reasons, but it's not there as yet. 
> 
> Right.  And because of that I don't feel bad about asking for a zone
> that ends at 4GB, as it is a fairly general need in the kernel, even
> if the rest of the interfaces have a little catching up to do before
> the can use it.  Although with IOMMUs I don't know how much such a
> DMA32 zone is worth.

It's probably too late for that sort of thing now in 2.5 though. 

> I am fine with memory that is not physically contiguous.  The memory
> I really want the kernel is currently sitting on.....

Oh, in that case you should have no problem getting it from ZONE_NORMAL,
especially if you can wake up kswapd and wait for a few seconds.
 
> The largest I have heard of is currently is 96MB.   Typical is

Eeek! ;-)

> somewhere between 900K and 6MB.  You get some interesting
> kernel+ramdisk combinations when people are network booting a diskless
> system.   Theoretically I can accommodate a nearly 4GB image, with the
> current code structure. 

Personnally I don't have a problem setting aside that much space at boot
time, but it's probably not a good solution for small boxes.

> So the 4GB instead of 960MB limit, and not pesimizing the kernel for
> the cases where the new image sits in ram for a while (kexec on panic)
> is while I modified my code to use high memory.

Maybe IFF you want to suppork kexec on panic, it should be statically
reserved at boot time? You don't want to be mucking around in the panic
path trying to swap out memory, etc. when your kernel is halfway down
the toilet already ... and that has nothing to do with memory placement,
it's just a space issue.

> The nasty case comes with highmemory when I am allocating memory on a
> 32GB NUMA box and am allocating memory on the wrong node.  In which
> case my code needs to allocate 28GB before it starts getting the
> memory it wants.

Oh, just do alloc_pages_node(0) (works on non NUMA as well, will just 
fall back). But I can show you a 32Gb SMP box as well ;-) ZONE_NORMAL 
is probably still easiest, and most general.

M.
