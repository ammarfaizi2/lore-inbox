Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTEFHWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbTEFHWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:22:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3396 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262434AbTEFHV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:21:58 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	<20030505092324.A13336@infradead.org>
	<1052127216.2821.51.camel@pc-16.office.scali.no>
	<20030505112531.B16914@infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 01:30:35 -0600
In-Reply-To: <20030505112531.B16914@infradead.org>
Message-ID: <m17k94bkh0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, May 05, 2003 at 11:33:36AM +0200, Terje Eggestad wrote:
> > 1. performance is everything. 
> 
> then Linux is the wrong OS for you :)
> 
> > 2. We're making a MPI library, and as such we don't have any control
> > with the application. 
> 
> I can't remember that the MPI spec tells anything about intercepting
> syscalls..
> 
> > 3b. the performance loss from copying from a receive area to the
> > userspace buffer is unacceptable. 
> > 3c. It's therefore necessary for HW to access user pages. 
> > 4. In order to to 3, the user pages must be pinned down. 
> > 5. the way MPI is written, it's not using a special malloc() to allocate
> > the send receive buffers. It can't since it would break language binding
> > to fortran. Thus ANY writeable user page may be used. 

Looking at the mpi spec there are two forms of point to point communications.
1) mpi_send/mpi_recv which do have that limitation.
2) mpi_put/mpi_get which are restricted to be used with a specifically
   allocated window, and the window can be restricted to areas allocated
   with mpi_alloc_mem.

So the mpi_put/mpi_get should be easy to optimize.

Handling mpi_send/mpi_recv is more difficult.  MPI specifies
that the data can be copied it just does not require it so in
sufficiently weird situations a copy slow path can be taken.

So there are really two questions here.
1)  What is a clean way to provide a high performance message
    passing layer.  Assuming you have a network card for which
    it is safe to mmap a subset of control registers.

2) What is a good way to map MPI onto that clean layer.

I believe the answer on how to do a clean safe interface is
to allocate the memory and tell the card about it in the driver,
and then allow user space to mmap it.  With the driver mmap operation
informing the network card of the mapping.

A good implementation of mpi on top of that is an interesting
question.  Replacing malloc and free and having everything run on
top of the mmapped buffer sounds like a possibility.  But it is
additionally desirable for the memory used by an MPI job to come
from hugetlbfs, or the equivalent.  And I don't know if a driver
can provide huge pages.

At this point I am strongly tempted to see what it would take to come
up with an MPI-2.1 to fix this issue.

> so use get_user_pages.
> 
> > 6. point 4: pinning is VERY expensive (point 1), so I can't pin the
> > buffers every time they're used. 
> 
> Umm, pinning memory all the time means you get a bunch of nice DoS
> attachs due to the huge amount of memory.

I wonder if there is an easy way to optimize this if you don't have
swap configured.  In general it is a bug if an MPI job swaps.

In general there is one mpi process per cpu running on a machine.  So
I have trouble seeing this as a denial of service.

> > 7. The only way to cache buffers (to see if they're used before and
> > hence pinned) is the user space virtual address. A syscall, thus ioctl
> > to a device file is prohibitive expensive under point 1.  
> 
> That's a horribly b0rked approach..
> 
> Again, where's your driver source so we can help you to find a better
> approach out of that mess?

With some digging I can find the source for both quadrics and myrinet
drivers, and they have the same issues.  This is a general problem
for running MPI jobs so it is probably worth finding a solution that
works for those people whose source we can obtain.

Eric
