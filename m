Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbTEFJMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTEFJMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:12:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31812 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262638AbTEFJMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:12:14 -0400
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 03:21:28 -0600
In-Reply-To: <1052208877.15887.13.camel@pc-16.office.scali.no>
Message-ID: <m13cjsbfc7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad <terje.eggestad@scali.com> writes:

> On Tue, 2003-05-06 at 09:30, Eric W. Biederman wrote:
> > Christoph Hellwig <hch@infradead.org> writes:
> > 
> 

> > Handling mpi_send/mpi_recv is more difficult.  MPI specifies
> > that the data can be copied it just does not require it so in
> > sufficiently weird situations a copy slow path can be taken.
> > 
> > So there are really two questions here.
> > 1)  What is a clean way to provide a high performance message
> >     passing layer.  Assuming you have a network card for which
> >     it is safe to mmap a subset of control registers.
> > 
> > 2) What is a good way to map MPI onto that clean layer.
> > 
> 
> All applications pretty much uses send/recv.
> 
> > I believe the answer on how to do a clean safe interface is
> > to allocate the memory and tell the card about it in the driver,
> > and then allow user space to mmap it.  With the driver mmap operation
> > informing the network card of the mapping.
> > 
> 
> You can't mmap() a buffer every time your going to do a send/recv, it's
> way to costly. 

Definitely not.  But if the memory malloc returns is originally
from a mmaped buffer area (mmaped from your driver) it can be useful.
I assume somewhere your card has the smarts to transform virtual to
physical addresses and this is what the mmap sets up.

That can be handled in user space by querying the mmaped region.  But
if the card does not have the smarts to do the virtual to physical
translation, or at the very least limit the set of physical pages a
user space a do DMA to/from that is a fundamental security issue and
means all of the optimizations are not safe.  And you must enter/exit
the kernel to send a DMA transaction.

> > A good implementation of mpi on top of that is an interesting
> > question.  Replacing malloc and free and having everything run on
> > top of the mmapped buffer sounds like a possibility.  But it is
> > additionally desirable for the memory used by an MPI job to come
> > from hugetlbfs, or the equivalent.  And I don't know if a driver
> > can provide huge pages.
> > 
> > At this point I am strongly tempted to see what it would take to come
> > up with an MPI-2.1 to fix this issue.
> > 
> 
> all current MPI apps uses MPI-1

Given that mpich does not even implement mpi_put/mpi_get I can
easily believe it for this case.  All of the MPI file I/O which
also does get used at least to some extent also is part of MPI-2.

> > > so use get_user_pages.
> > > 
> > > > 6. point 4: pinning is VERY expensive (point 1), so I can't pin the
> > > > buffers every time they're used. 
> > > 
> > > Umm, pinning memory all the time means you get a bunch of nice DoS
> > > attachs due to the huge amount of memory.
> > 
> > I wonder if there is an easy way to optimize this if you don't have
> > swap configured.  In general it is a bug if an MPI job swaps.
> > 
> 
> hmm, it's not a problem as long as you only page out data page used only
> under initialization, or pages that are used very infrequent. That is
> actually a good thing, since you could fit a bit more live data in
> memory. 

Right.  Defining it as a bug was to emphasize the point that paging is
a non-issue and for the most part an MPI job is already pinned in
memory.  I totally agree that having swapping enabled and being able
to page out every unused page in the is useful.

> > In general there is one mpi process per cpu running on a machine.  So
> > I have trouble seeing this as a denial of service.
> > 
> > > > 7. The only way to cache buffers (to see if they're used before and
> > > > hence pinned) is the user space virtual address. A syscall, thus ioctl
> > > > to a device file is prohibitive expensive under point 1.  
> > > 
> > > That's a horribly b0rked approach..
> > > 
> > > Again, where's your driver source so we can help you to find a better
> > > approach out of that mess?
> > 
> > With some digging I can find the source for both quadrics and myrinet
> > drivers, and they have the same issues.  This is a general problem
> > for running MPI jobs so it is probably worth finding a solution that
> > works for those people whose source we can obtain.
> > 
> 
> Hmm, no the drivers, don't have the issue, the MPI implementations
> do. 

The drivers have the issue of how to provide an interface for
the mpi implementation that sits on top of them.  I totally agree this
looks like a bug in MPI.

> The two used approaches are 1) replace malloc() and friends, which break
> with fortran 90 compilers 2) tell glibc never to release alloced memory
> thru sbrk(-n) or munmap() which also break with f90 compilers, and run
> the risk of bloating memory usage. 

Actually there is a third.  Hack the vm layer and require a highly
patched kernel.  That is the approach quadrics was using last time I
looked although they promised something different in their next major
rev.

Is it pgi or intels f90 compilers that break, and how do they break.
Replacing malloc and friends should be well defined if you simply
replace or wrap the symbols glibc provides.

Quite possibly the answer is to call those compilers ABI
non-conformant and get them fixed.  Especially given that they are not
compatible with g77 in fortran mode there is a good case for this.  By
default the native compiler is correct. 

So far the only fortran issues I have seen that could affect malloc
are adding extra under scores.  What issue are you running into?


Eric
