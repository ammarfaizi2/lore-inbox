Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTEFICU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTEFICT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:02:19 -0400
Received: from elin.scali.no ([62.70.89.10]:63885 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S261156AbTEFICP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:02:15 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
In-Reply-To: <m17k94bkh0.fsf@frodo.biederman.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505112531.B16914@infradead.org>  <m17k94bkh0.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052208877.15887.13.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 10:14:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 09:30, Eric W. Biederman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 

> 
> Looking at the mpi spec there are two forms of point to point communications.
> 1) mpi_send/mpi_recv which do have that limitation.
> 2) mpi_put/mpi_get which are restricted to be used with a specifically
>    allocated window, and the window can be restricted to areas allocated
>    with mpi_alloc_mem.
> 
> So the mpi_put/mpi_get should be easy to optimize.
> 
> Handling mpi_send/mpi_recv is more difficult.  MPI specifies
> that the data can be copied it just does not require it so in
> sufficiently weird situations a copy slow path can be taken.
> 
> So there are really two questions here.
> 1)  What is a clean way to provide a high performance message
>     passing layer.  Assuming you have a network card for which
>     it is safe to mmap a subset of control registers.
> 
> 2) What is a good way to map MPI onto that clean layer.
> 

All applications pretty much uses send/recv.

> I believe the answer on how to do a clean safe interface is
> to allocate the memory and tell the card about it in the driver,
> and then allow user space to mmap it.  With the driver mmap operation
> informing the network card of the mapping.
> 

You can't mmap() a buffer every time your going to do a send/recv, it's
way to costly. 


> A good implementation of mpi on top of that is an interesting
> question.  Replacing malloc and free and having everything run on
> top of the mmapped buffer sounds like a possibility.  But it is
> additionally desirable for the memory used by an MPI job to come
> from hugetlbfs, or the equivalent.  And I don't know if a driver
> can provide huge pages.
> 
> At this point I am strongly tempted to see what it would take to come
> up with an MPI-2.1 to fix this issue.
> 

all current MPI apps uses MPI-1

> > so use get_user_pages.
> > 
> > > 6. point 4: pinning is VERY expensive (point 1), so I can't pin the
> > > buffers every time they're used. 
> > 
> > Umm, pinning memory all the time means you get a bunch of nice DoS
> > attachs due to the huge amount of memory.
> 
> I wonder if there is an easy way to optimize this if you don't have
> swap configured.  In general it is a bug if an MPI job swaps.
> 

hmm, it's not a problem as long as you only page out data page used only
under initialization, or pages that are used very infrequent. That is
actually a good thing, since you could fit a bit more live data in
memory. 


> In general there is one mpi process per cpu running on a machine.  So
> I have trouble seeing this as a denial of service.
> 
> > > 7. The only way to cache buffers (to see if they're used before and
> > > hence pinned) is the user space virtual address. A syscall, thus ioctl
> > > to a device file is prohibitive expensive under point 1.  
> > 
> > That's a horribly b0rked approach..
> > 
> > Again, where's your driver source so we can help you to find a better
> > approach out of that mess?
> 
> With some digging I can find the source for both quadrics and myrinet
> drivers, and they have the same issues.  This is a general problem
> for running MPI jobs so it is probably worth finding a solution that
> works for those people whose source we can obtain.
> 

Hmm, no the drivers, don't have the issue, the MPI implementations do. 
The two used approaches are 1) replace malloc() and friends, which break
with fortran 90 compilers 2) tell glibc never to release alloced memory
thru sbrk(-n) or munmap() which also break with f90 compilers, and run
the risk of bloating memory usage. 
 

> Eric
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

