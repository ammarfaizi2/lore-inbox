Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267873AbTBKOZU>; Tue, 11 Feb 2003 09:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267868AbTBKOZU>; Tue, 11 Feb 2003 09:25:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:11502 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267878AbTBKOZN>; Tue, 11 Feb 2003 09:25:13 -0500
Date: Tue, 11 Feb 2003 20:10:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030211201029.A3148@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E490374.1060608@mvista.com>; from cminyard@mvista.com on Tue, Feb 11, 2003 at 08:06:44AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:06:44AM -0600, Corey Minyard wrote:
> |
> |We could just reserve a memory area of reasonable size (how
> |much ?) which would be used by the new kernel for all its
> |allocations. We already have the infrastructure to tell the
> |new kernel which memory areas not to use, so its simple
> |enough to ask it exclude all but the reserved area.
> |By issuing the i/o as early as possible during bootup
> |(for lkcd all we need is the block device to be setup for
> |i/o requests), we can minimize the amount of memory to
> |reserve in this manner.
> 
> DMA can occur almost anywhere.  If you restrict the area of DMA, that
> means you have to copy the contents to the final destination.  I don't think
> we want to do that in many cases.

The scope here was just the case that Eric seemed to be 
trying to address, the way I understood it, and hence a much 
simpler subset of the problem at hand, since it is not really
tackling the rouge/buggy cases. There is no restriction on 
where DMA can happen, just a block of memory area set aside 
for the dormant kernel to use when it is instantiated. 
So this is an area that the current kernel will not use or 
touch and not specify as a DMA target during "regular" 
operation. 

> |
> |That might address a large percentage of the regular cases,
> |i.e. except where statically allocated buffers could be
> |targets for DMA. If we are using in-use (user) pages
> |for saving the dump, then there is a possibility of a dump
> |getting corrupted by a DMA, but there may be a way to
> |minimize that when we chose destination pages to use.
> 
> Unless you have some way to mark pages as current DMA targets, you,
> you won't be able to do this.  And the problem Ken and I are seeing is
> happening after the new kernel has booted. An old DMA operation is
> occuring after the new kernel has booted.  That means two kernels would
> have to choose the same DMA target areas, and that's fairly unreasonable
> to ask, IMHO.

Not really, this isn't about matching DMA target areas. Its
about the new kernel ignoring memory that the old kernel was 
using and only using the reserved area of memory which the
old kernel was expected to have left alone in normal operation.

This is not the entire spectrum of situations where any physical
address could be a potential DMA target, due to a buggy kernel
which could have passed any address to the device concerned.
For that case, of course, quiescing the devices seems like the 
best way out so far.

So whether such reservation would solve the case you see
would depend on whether the old DMA operation is targetted at
a valid buffer in the old kernel, or if it is indeed a buggy
scenario where DMA is happening into an address it shouldn't
really be overwriting.

> 
> The only reasonable way I can think of to do this is to quiesce the devices
> before dumping memory or doing a kexec.  It's not that hard to do, it's just
> that a lot of DMA capable device drivers exist that don't do this.

Yes, this is indeed what we need eventually.	
What would it take to get there ? The main difficulty is making
sure all device drivers do this ..

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

