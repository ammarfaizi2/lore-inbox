Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTEFL2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTEFL2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:28:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1349 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262563AbTEFL2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:28:37 -0400
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	<20030505092324.A13336@infradead.org>
	<1052127216.2821.51.camel@pc-16.office.scali.no>
	<20030505112531.B16914@infradead.org>
	<m17k94bkh0.fsf@frodo.biederman.org>
	<1052208877.15887.13.camel@pc-16.office.scali.no>
	<m13cjsbfc7.fsf@frodo.biederman.org>
	<1052220098.15887.24.camel@pc-16.office.scali.no>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 05:37:36 -0600
In-Reply-To: <1052220098.15887.24.camel@pc-16.office.scali.no>
Message-ID: <m1n0i09ugv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad <terje.eggestad@scali.com> writes:

> On Tue, 2003-05-06 at 11:21, Eric W. Biederman wrote:
> > Terje Eggestad <terje.eggestad@scali.com> writes:
> > 
> > > 
> > > > I believe the answer on how to do a clean safe interface is
> > > > to allocate the memory and tell the card about it in the driver,
> > > > and then allow user space to mmap it.  With the driver mmap operation
> > > > informing the network card of the mapping.
> > > > 
> > > 
> > > You can't mmap() a buffer every time your going to do a send/recv, it's
> > > way to costly. 
> > 
> > Definitely not.  But if the memory malloc returns is originally
> > from a mmaped buffer area (mmaped from your driver) it can be useful.
> > I assume somewhere your card has the smarts to transform virtual to
> > physical addresses and this is what the mmap sets up.
> > 
> 
> The problem I've got happen when an app registers the memory with the
> driver, releases the memory back to the kernel thru sbrk(-n) or
> munmap()s it. Then get new memory thru sbrk(+n) or mmap() which then get
> the same vaddr. 
> 
> mapping from vaddr to phys addr happen at the registration point. 

I was talking about an method that does not require a registration
point.  So it sounds like we are talking past each other on this one.
 
> Querying the kernel for a vaddrs  phys addr every time it's used is too
> costly. There is a better explanantion in a earlier post. 

There are 2 possible interfaces to get a vaddr to phys addr mapping.
1) Register the memory area and pin it down.
2) MMap from memory allocated by the driver.
   In this case the driver is told about every mmap and unmap.

So I believe that baring the strange issues with hooking malloc
to call a mmap function on your driver 2 is the correct solution.

> > That can be handled in user space by querying the mmaped region.  But
> > if the card does not have the smarts to do the virtual to physical
> > translation, or at the very least limit the set of physical pages a
> > user space a do DMA to/from that is a fundamental security issue and
> > means all of the optimizations are not safe.  And you must enter/exit
> > the kernel to send a DMA transaction.
> > 
> 
> send/recv don't need kernel interaction on high perf interconnects.

Agreed.  I was simply mention the requires for that to be safe.

> > So far the only fortran issues I have seen that could affect malloc
> > are adding extra under scores.  What issue are you running into?
> > 
> 
> Some don't use (g)libc, but do syscalls directly.

That is clearly broken code.  A user space application compiled statically is
one thing.  Directly putting syscalls in libraries other than libc is
quite bad.  And I currently cannot think of an excuse for it.
Especially as that will ensure you use the slow syscall path on recent
kernels. 

Eric
