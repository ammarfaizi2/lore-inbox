Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTEFLJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTEFLJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:09:23 -0400
Received: from elin.scali.no ([62.70.89.10]:59024 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262538AbTEFLJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:09:21 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
In-Reply-To: <m13cjsbfc7.fsf@frodo.biederman.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505112531.B16914@infradead.org> <m17k94bkh0.fsf@frodo.biederman.org>
	 <1052208877.15887.13.camel@pc-16.office.scali.no>
	 <m13cjsbfc7.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052220098.15887.24.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 13:21:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 11:21, Eric W. Biederman wrote:
> Terje Eggestad <terje.eggestad@scali.com> writes:
> 
> > 
> > > I believe the answer on how to do a clean safe interface is
> > > to allocate the memory and tell the card about it in the driver,
> > > and then allow user space to mmap it.  With the driver mmap operation
> > > informing the network card of the mapping.
> > > 
> > 
> > You can't mmap() a buffer every time your going to do a send/recv, it's
> > way to costly. 
> 
> Definitely not.  But if the memory malloc returns is originally
> from a mmaped buffer area (mmaped from your driver) it can be useful.
> I assume somewhere your card has the smarts to transform virtual to
> physical addresses and this is what the mmap sets up.
> 

The problem I've got happen when an app registers the memory with the
driver, releases the memory back to the kernel thru sbrk(-n) or
munmap()s it. Then get new memory thru sbrk(+n) or mmap() which then get
the same vaddr. 

mapping from vaddr to phys addr happen at the registration point. 

Querying the kernel for a vaddrs  phys addr every time it's used is too
costly. There is a better explanantion in a earlier post. 


> That can be handled in user space by querying the mmaped region.  But
> if the card does not have the smarts to do the virtual to physical
> translation, or at the very least limit the set of physical pages a
> user space a do DMA to/from that is a fundamental security issue and
> means all of the optimizations are not safe.  And you must enter/exit
> the kernel to send a DMA transaction.
> 

send/recv don't need kernel interaction on high perf interconnects. 


> > The two used approaches are 1) replace malloc() and friends, which break
> > with fortran 90 compilers 2) tell glibc never to release alloced memory
> > thru sbrk(-n) or munmap() which also break with f90 compilers, and run
> > the risk of bloating memory usage. 
> 
> Actually there is a third.  Hack the vm layer and require a highly
> patched kernel.  That is the approach quadrics was using last time I
> looked although they promised something different in their next major
> rev.
> 
> Is it pgi or intels f90 compilers that break, and how do they break.
> Replacing malloc and friends should be well defined if you simply
> replace or wrap the symbols glibc provides.
> 
> Quite possibly the answer is to call those compilers ABI
> non-conformant and get them fixed.  Especially given that they are not
> compatible with g77 in fortran mode there is a good case for this.  By
> default the native compiler is correct. 
> 
> So far the only fortran issues I have seen that could affect malloc
> are adding extra under scores.  What issue are you running into?
> 

Some don't use (g)libc, but do syscalls directly.


> 
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

