Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTA2PdK>; Wed, 29 Jan 2003 10:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTA2PdK>; Wed, 29 Jan 2003 10:33:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57936 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265168AbTA2PdI>; Wed, 29 Jan 2003 10:33:08 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org>
	<3E35AAE4.10204@us.ibm.com> <203100000.1043705004@flay>
	<m1n0ll68jd.fsf@frodo.biederman.org> <1470350000.1043770519@titus>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jan 2003 08:41:44 -0700
In-Reply-To: <1470350000.1043770519@titus>
Message-ID: <m165s855fr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> We talked about creating a new zone specifically for DMA32 (ie <4Gb)
> >> for other reasons, but it's not there as yet. 
> > 
> > Right.  And because of that I don't feel bad about asking for a zone
> > that ends at 4GB, as it is a fairly general need in the kernel, even
> > if the rest of the interfaces have a little catching up to do before
> > the can use it.  Although with IOMMUs I don't know how much such a
> > DMA32 zone is worth.
> 
> It's probably too late for that sort of thing now in 2.5 though. 

Unless there are balancing issues adding a new zone is very trivial.
However any code in that direction will be an additional patch so
because ZONE_NORMAL works for most cases.  Alan Cox can have his high
memory case if he wants it.

> > I am fine with memory that is not physically contiguous.  The memory
> > I really want the kernel is currently sitting on.....
> 
> Oh, in that case you should have no problem getting it from ZONE_NORMAL,
> especially if you can wake up kswapd and wait for a few seconds.

Nope, kswapd will not free the kernels text segment.  So in practice
I can use anything below 4GB. 
  
> > The largest I have heard of is currently is 96MB.   Typical is
> 
> Eeek! ;-)

There is even a distribution built to be run completely out of a ramdisk. 
http://warewulf-cluster.org/
 
> > somewhere between 900K and 6MB.  You get some interesting
> > kernel+ramdisk combinations when people are network booting a diskless
> > system.   Theoretically I can accommodate a nearly 4GB image, with the
> > current code structure. 
> 
> Personnally I don't have a problem setting aside that much space at boot
> time, but it's probably not a good solution for small boxes.
> 
> > So the 4GB instead of 960MB limit, and not pesimizing the kernel for
> > the cases where the new image sits in ram for a while (kexec on panic)
> > is while I modified my code to use high memory.
> 
> Maybe IFF you want to suppork kexec on panic, it should be statically
> reserved at boot time? You don't want to be mucking around in the panic
> path trying to swap out memory, etc. when your kernel is halfway down
> the toilet already ... and that has nothing to do with memory placement,
> it's just a space issue.

As it currently exists kexec happens in two stages sys_kexec_load that
scatters the new image through out memory, with some care so that I can
use memcpy, and some variant of memmove to place the image at it's
final location in memory.   This is where all of the memory allocation
happens.


Then there is sys_reboot(LINUX_REBOOT_CMD_KEXEC), (or a kernel panic)
which triggers the work.  And except for cpu state changes nothing
happens.

> > The nasty case comes with highmemory when I am allocating memory on a
> > 32GB NUMA box and am allocating memory on the wrong node.  In which
> > case my code needs to allocate 28GB before it starts getting the
> > memory it wants.
> 
> Oh, just do alloc_pages_node(0) (works on non NUMA as well, will just 
> fall back). But I can show you a 32Gb SMP box as well ;-) ZONE_NORMAL 
> is probably still easiest, and most general.

Right it is not hard to do it just takes a little more work.

Eric
