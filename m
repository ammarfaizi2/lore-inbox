Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135664AbRDXOy7>; Tue, 24 Apr 2001 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135660AbRDXOyu>; Tue, 24 Apr 2001 10:54:50 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:8535 "EHLO
	c0mailgw06.prontomail.com") by vger.kernel.org with ESMTP
	id <S135668AbRDXOyc>; Tue, 24 Apr 2001 10:54:32 -0400
Message-ID: <3AE59348.1DFE3E23@mvista.com>
Date: Tue, 24 Apr 2001 07:52:56 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: "Robert H. de Vries" <rhdv@rhdv.cistron.nl>,
        high-res-timers-discourse@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: high-res-timers start code.
In-Reply-To: <Pine.HPX.4.10.10104241213530.2724-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> 
> On Mon, 23 Apr 2001, george anzinger wrote:
> 
> > "Robert H. de Vries" wrote:
> > >
> > > On Monday 23 April 2001 19:45, you wrote:
> > >
> > > > By the way, is the user land stuff the same for all "arch"s?
> > >
> > > Not if you plan to handle the CPU cycle counter in user space. That is at
> > > least what I would propose.
> >
> > Just got interesting, lets let the world look in.
> >
> > What did you have in mind here?  I suspect that on some archs the cycle
> > counter is not available to user code.  I know that on parisc it is
> > optionally available (kernel can set a bit to make it available), but by
> > it self it is only good for intervals.  You need to peg some value to a
> > CLOCK to use it to get timeofday, for instance.
> 
> On Intel there is a also bit to disable unprivileged RDTSC, IIRC. On PPC
> the timebase is always available (but the old 601 needs spacial casing: it
> uses different registers and does not count in binary :-().
> 
> > On the other hand, if there is an area of memory that both users and
> > system can read but only system can write, one might put the soft clock
> > there.  This would allow gettimeofday (with the cycle counter) to work
> > without a system call.  To the best of my knowledge the system does not
> > have such an area as yet.
> >
> > comments?
> 
> Well, there may be work in this area, since x86-64 will not enter kernel
> mode for gettimeofday() if I understand correctly what Andrea said. Linus
> hinted once at exporting (kernel) code to user space.
> 
> Some data also will also need to be accessible but as long as you don't
> guarantee compatibility on data layout, only AFAIU on interface for these
> calls (it was not clear to me if it would be a fixed address forever or
> dynamic linking with kernel exported symbols), it's not a problem.

HPUX passes some kernel addresses to programs on the initial start up,
i.e. the primary entry point where exec starts the task.  In this case
the addresses are in registers.  I think HPUX also passes addresses back
to the kernel at this time, but those are done with a system call.  In
any case, such a change requires a user land relink, something that may
want the kernel to move from 2.x.x to 3.x.x (depending on version
conventions :).

I think the real problem has more to do with the "minor" variations on
various archs, for example the 601 ppc above and the i386 TSC is only
available in the "newer" machines.  This would require user land
configuration based on fine points of the arch, stuff "only the kernel
knows for sure".

So what do we do in the meantime?

Comments?

George
> 
> Of course it will SIGSEGV instead of returning -EFAULT but this is a good
> thing IMHO, nobody checks for -EFAULT from gettimeofday(). I think
> that system calls should rather force SIGSEGV than return -EFAULT anyway,
> to make syscalls indistinguishable from pure library calls.
> 
>         Regards,
>         Gabriel.
