Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTBLETJ>; Tue, 11 Feb 2003 23:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBLETJ>; Tue, 11 Feb 2003 23:19:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49505 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266686AbTBLETI>; Tue, 11 Feb 2003 23:19:08 -0500
To: Corey Minyard <cminyard@mvista.com>
Cc: suparna@in.ibm.com, Kenneth Sumrall <ken@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210174243.B11250@in.ibm.com>
	<m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com>
	<20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com>
	<20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Feb 2003 21:28:32 -0700
In-Reply-To: <3E4914CA.6070408@mvista.com>
Message-ID: <m1of5ixgun.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <cminyard@mvista.com> writes:

> Suparna Bhattacharya wrote:
> 
> |On Tue, Feb 11, 2003 at 08:06:44AM -0600, Corey Minyard wrote:
> |
> |>|
> |>|We could just reserve a memory area of reasonable size (how
> |>|much ?) which would be used by the new kernel for all its
> |>|allocations. We already have the infrastructure to tell the
> |>|new kernel which memory areas not to use, so its simple
> |>|enough to ask it exclude all but the reserved area.
> |>|By issuing the i/o as early as possible during bootup
> |>|(for lkcd all we need is the block device to be setup for
> |>|i/o requests), we can minimize the amount of memory to
> |>|reserve in this manner.
> |>
> |>DMA can occur almost anywhere.  If you restrict the area of DMA, that
> |>means you have to copy the contents to the final destination.  I don't think
> |>we want to do that in many cases.
> |
> |
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
> You don't understand.  You don't *want* to set aside a block of memory that's
> reserved for DMA.  You want to be able to DMA directly into any user address.
> Consider demand paging.  The performance would suck if you DMA into some
> fixed region then copied to the user address.  Plus you then have another
> resource you have to manage in the kernel.  And you still have to change all
> the drivers, buffer management, etc. to add a flag that says "I'm going to use
> this for DMA" to allocations.  You might as well add the quiesce function, it's
> probably easier to do.  And it doesn't help if you DMA to static memory
> addresses.
> 
> I, too, would like a simpler solution.  I just don't think this is it.

You have it backwards.  It is not about reserving a block of memory
for DMA.  It is about reserving a block of memory to not do DMA in.
Something like 4MB or so.  

The idea is not to let the original kernel touch the reserved block at all.
We just put the kernel that kexec will start in that block of memory.

Eric
