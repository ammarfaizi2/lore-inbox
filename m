Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSD3UBs>; Tue, 30 Apr 2002 16:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSD3UBr>; Tue, 30 Apr 2002 16:01:47 -0400
Received: from [192.82.208.96] ([192.82.208.96]:46530 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315192AbSD3UBp>;
	Tue, 30 Apr 2002 16:01:45 -0400
Date: Tue, 30 Apr 2002 13:01:36 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: =?iso-8859-1?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to write portable MMIO code?
Message-ID: <20020430200136.GA1204879@sgi.com>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	=?iso-8859-1?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020430190110.GA20294@localhost> <Pine.LNX.4.44.0204301428480.32217-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 02:41:56PM -0500, Kai Germaschewski wrote:
> Well, my understanding is the following: (if I get something wrong, 
> hopefully somebody who's reading this will correct me)
> 
> the barrier(), {,r,w}mb() stuff is for actually for normal memory 
> accesses.
> 
> About barrier():
> 
> If you have
> 
> 	*p1 = 1; *p2 = 2;
> 
> the compiler may decide to reorder this to (if it knows that p1 != p2)
> 
> 	*p2 = 2; *p1 = 1;
> 
> A barrier() in between will inhibit this reordering.
> 
> For some archs, even the barrier() is not sufficient to serialize the
> accesses to RAM. The compiler may generate something like
> 
> 	mov [p1], 1
> 	mov [p2], 2
> 
> but on e.g. alpha (where the asm would look differently ;-), the processor
> may decide to put the second instruction on the memory bus before the 
> first one. Only an mb in between will guarantee the ordering on the
> memory bus.

That's a good summary of the memory ordering issues one normally runs
into.

> Now, for IO, basically the same holds, though I wouldn't want to guarantee 
> that the macros designed for the memory bus would work on the PCI bus as 
> expected.

Right.  In fact, waiting on I/O busses can take a bit longer than
making sure the processor executes memory transactions in the order
you'd like.

> However, I do *believe*, that the readl/writel functions implicitly do the
> right thing and introduce barriers where needed. On x86 e.g., the macros
> do a cast to (volatile *), which will ensure that these functions are
> compiled without reordering. As x86 is strongly ordered, no additional
> mb() or whatever is necessary (nor does it exist) to make sure that this
> ordering will propagate to the PCI bus.

Right, readl/writel will order things wrt the compiler and
processor, but not necessarily the I/O bus.  On IA64, we've introduced
mmiob() to address this.  It acts just like mb(), but wrt I/O address
space.  The ia64 patch for 2.5 includes some documentation about it,
I'd love to see other arches implement something similar (even as a
simple nop) so that machines with weakly ordered I/O busses will work
as expected.

Jesse
