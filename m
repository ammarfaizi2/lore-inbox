Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTA1HQS>; Tue, 28 Jan 2003 02:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTA1HQS>; Tue, 28 Jan 2003 02:16:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27726 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267327AbTA1HQQ>; Tue, 28 Jan 2003 02:16:16 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org>
	<3E35AAE4.10204@us.ibm.com> <203100000.1043705004@flay>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2003 00:24:54 -0700
In-Reply-To: <203100000.1043705004@flay>
Message-ID: <m1n0ll68jd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> The problem is that I have not figured out how to tell the memory
> >> allocator just what I need, 
> > <snip>
> >> I guess I would make the standard zones something like:
> >> /*
> >>  * ZONE_DMA	  < 16 MB	ISA DMA capable memory
> >>  * ZONE_NORMAL  16-896 MB	direct mapped by the kernel
> >>  * ZONE_PHYSMEM 896-4096 MB	memory that is accessible with the
> >>                               MMU disabled.
> >>  * ZONE_HIGHMEM > 4096MB      only page cache and user processes
> >>  */
> > 
> > I think this might be overkill.  ZONE_NORMAL gives you what you want,
> > and I don't think it's worth it to introduce a new one just for the
> > relatively short timespan where you have the new kernel loaded, but
> > haven't actually shut down.  I think a little comment next to the
> > allocation explaining this will be more than enough.
> > 
> > Martin, any ideas?
> 
> We talked about creating a new zone specifically for DMA32 (ie <4Gb)
> for other reasons, but it's not there as yet. 

Right.  And because of that I don't feel bad about asking for a zone
that ends at 4GB, as it is a fairly general need in the kernel, even
if the rest of the interfaces have a little catching up to do before
the can use it.  Although with IOMMUs I don't know how much such a
DMA32 zone is worth.

> As Dave mentioned,
> ZONE_NORMAL should be sufficient, though if you need it physically
> contiguous, that might be a problem.

I am fine with memory that is not physically contiguous.  The memory
I really want the kernel is currently sitting on.....

> How much memory do you need? If it's only 2Mb or so, why don't we
> statically reserve it at boot time and keep it set aside?

The largest I have heard of is currently is 96MB.   Typical is
somewhere between 900K and 6MB.  You get some interesting
kernel+ramdisk combinations when people are network booting a diskless
system.   Theoretically I can accommodate a nearly 4GB image, with the
current code structure. 

So the 4GB instead of 960MB limit, and not pesimizing the kernel for
the cases where the new image sits in ram for a while (kexec on panic)
is while I modified my code to use high memory.

The nasty case comes with highmemory when I am allocating memory on a
32GB NUMA box and am allocating memory on the wrong node.  In which
case my code needs to allocate 28GB before it starts getting the
memory it wants.

Eric
