Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267817AbTBKNZK>; Tue, 11 Feb 2003 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267822AbTBKNZK>; Tue, 11 Feb 2003 08:25:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:34997 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267817AbTBKNZJ>; Tue, 11 Feb 2003 08:25:09 -0500
Date: Tue, 11 Feb 2003 19:10:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Corey Minyard <cminyard@mvista.com>, Kenneth Sumrall <ken@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030211191027.A2999@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030211182508.A2936@in.ibm.com>; from suparna@in.ibm.com on Tue, Feb 11, 2003 at 06:25:08PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 06:25:08PM +0530, Suparna Bhattacharya wrote:
> On Mon, Feb 10, 2003 at 10:56:43AM -0700, Eric W. Biederman wrote:
> > Suparna Bhattacharya <suparna@in.ibm.com> writes:
> [snip]
> > 
> > Not primarily.  Instead I am trying to address the possibility that
> > DMA is overwriting the recovery code due to a device not being shutdown
> > properly.  Though it would happen to cover many cases of the wrong
> > memory address being passed to a device.
> > 
> 
> OK, I see where you are coming from. It is an interesting
> possibility, if you know how to pull it off for various 
> architectures, and the working area that the new kernel needs 
> to do operate to the extent of issuing the writeout is not 
> too big (i.e.  doesn't take away too much memory from the 
> operational kernel). Perhaps we could hide this memory from 
> the normal kernel virtual address space most of the time, so 
> its less susceptable to software corruption (i.e. besides
> physical access via DMA).

For the sort of problems which Ken is seeing, maybe we can,
for a start, do without all the modifications to make the 
new kernel run at a different address, if we can assume 
that most i/o is likely is happen on dynamically allocated 
buffers.

We could just reserve a memory area of reasonable size (how
much ?) which would be used by the new kernel for all its 
allocations. We already have the infrastructure to tell the 
new kernel which memory areas not to use, so its simple 
enough to ask it exclude all but the reserved area. 
By issuing the i/o as early as possible during bootup
(for lkcd all we need is the block device to be setup for
i/o requests), we can minimize the amount of memory to
reserve in this manner.

That might address a large percentage of the regular cases,
i.e. except where statically allocated buffers could be
targets for DMA. If we are using in-use (user) pages
for saving the dump, then there is a possibility of a dump
getting corrupted by a DMA, but there may be a way to
minimize that when we chose destination pages to use.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

