Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289302AbSANXZ0>; Mon, 14 Jan 2002 18:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSANXXg>; Mon, 14 Jan 2002 18:23:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:497 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289289AbSANXXX>; Mon, 14 Jan 2002 18:23:23 -0500
Message-ID: <3C4367EA.A52D6360@mvista.com>
Date: Mon, 14 Jan 2002 15:21:14 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Roman Zippel <zippel@linux-m68k.org>, Rob Landley <landley@trommello.org>,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org> <20020112075638.A5098@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> On Sat, Jan 12, 2002 at 02:25:03PM +0100, Roman Zippel wrote:
> > Hi,
> >
> > yodaiken@fsmlabs.com wrote:
> >
> > > > > SCHED_FIFO leads to
> > > > >                 niced app 1 in K mode gets Sem A
> > > > >                 SCHED_FIFO app prempts and blocks on  Sem A
> > > > >                 whoops! app 2 in K more preempts niced app 1
> > > >
> > > > Please explain what's different without the preempt patch.
> > >
> > > See that "preempt" in line 2 . Linux does not
> > > preempt kernel mode processes otherwise. The beauty of the
> > > non-preemptive kernel is that "in K mode every process makes progress"
> > > and even the "niced app" will complete its use of SemA and
> > > release it in one run.
> >
> > The point of using semaphores is that one can sleep while holding them,
> > whether this is forced by preemption or voluntary makes no difference.
> 
> No. The point of using semaphores is that one can sleep while
> _waiting_ for the resource. Sleeping while holding semaphores is
> a different kettle of lampreys entirely.
> And it makes a very big difference
> A:
>         get sem on memory pool
>                 do something horrible to pool
>         release sem on memory pool
> 
> In a preemptive kernel this can cause a deadlock. In a non
> preemptive it cannot. You are correct in that
> B:
>         get sem on memory pool
>                 do potentially blocking operations
>         release sem
> is also dangerous - but I don't think that helps your case.
> To fix B, we can enforce a coding rule - one of the reasons why
> we have all those atomic ops in the kernel is to be able to
> avoid this problem.
> To fix A in a preemptive kernel we need to start messing about with
> priorities and that's a major error.
> "The current kernel has too many places where processes
> can sleep while holding semaphores so we should always have the
> potential of blocking with held semaphores" is, to me, a backwards
> argument.
> 
> > > If you have a reasonably fair scheduler you
> > > can make very useful analysis with Linux now of the form
> > >
> > >         Under 50 active proceses in the system means that in every
> > >         2 second interval every process
> > >         will get at least 10ms of time to run.
> > >
> > > That's a very valuable property and it goes away in a preemptive kernel
> > > to get you something vague.
> >
> > How is that changed? AFAIK inserting more schedule points does not
> > change the behaviour of the scheduler. The niced app will still get its
> > time.
> 
> How many times can an app be preempted? In a non preempt kernel
> is can be preempted during user mode at timer frequency and no more

Uh, it can be and is preempted in user mode by ANY interrupt, be it
keyboard, serial, lan, disc, etc.  The kernel looks for need_resched at
the end of ALL interrupts, not just the timer interrupt.

> and it cannot be preempted during kernel mode. So
>         while(1){
>                 read mpeg data
>                 process
>                 write bitmap
>                 }
> 
> Assuming Andrew does not get too ambitious about read/write granularity, once this
> process is scheduled on a non-preempt system it will always make progress. The non
> preempt kernel says, "your kernel request will complete - if we have resources".
> A preempt kernel says: "well, if nobody more important activates you get some time"
> Now you do the analysis based on the computation of "goodness" to show that there is
> a bound on preemption count during an execution of this process. I don't want to
> have to think that hard.
> Let's suppose the Gnome desktop constantly creates and
> destroys new fresh i/o bound tasks to do something. So with the old fashioned non
> preempt (ignoring Andrew) we get
>                         wait no more than 1 second
>                         I'm scheduled and start a read
>                         wait no more than one second
>                         I'm scheduled and in user mode for at least 10milliseconds
>                         wait no more than 1 second
>                         I'm scheduled and do my write
>                         ...
> with preempt we get
>                         wait no more than 1 second
>                         I'm scheduled and start a read
>                                 I'm preempted
>                                 read not done
>                                 come back for 2 microseconds
>                                 preempted again
>                                 haven't issued the damn read request yet
>                                 ok a miracle happens, I finish the read request
>                                 go to usermode and an interrupt happens
>                                                 well it would be stupid to have a goodness
>                                                 function in a preempt kernel that lets a low
>                                                 priority task finish its time slice so preempt
>                                 ...
> 
> >
> > > So your argument is that I'm advocating Andrew Morton's patch which
> > > reduces latencies more than the preempt patch because I have a
> > > financial interest in not reducing latencies? Subtle.
> >
> > Andrew's patch requires constant audition and Andrew can't audit all
> > drivers for possible problems. That doesn't mean Andrew's work is
> > wasted, since it identifies problems, which preempting can't solve, but
> > it will always be a hunt for the worst cases, where preempting goes for
> > the general case.
> 
> the preempt requires constant auditing too - and more complex auditing.
> After all, a missed audit in Andrew will simply increase worst case timing.
> A missed audit in preempt will hang the system.
> 
> >
> > > In any case, motive has no bearing on a technical argument.
> > > Your motive could be to make the 68K look better by reducing
> > > performance on other processors for all I know.
> >
> > I am more than busy to keep it running (together with a few others, who
> > are left) and more important I make no money of it.
> 
> Come on! First of all, you are causing me a great deal of pain by making
> me struggle not to make some bad joke about the economics of Linux companies.
> More important, not making money has nothing to do with purity of motivation -
> don't you read this list?
> And how do I know that you haven't got a stockpile of 68K boards that may
> be worth big money once it's known that 68K linux is at the top of the heap?
> Much less plausible money making schemes have been tried.
> 
> Seriously: for our business, a Linux kernel that can reliably run at millisecond
> level latencies is only good. If you could get a Linux kernel to run at
> latencies of 100 microseconds worst case on a 486, I'd be a little more
> worried  but even then ...
> On a 800Mhz Athlon, RTLinux scheduling jitter is 17microseconds worst case right now.
> 
> --
> ---------------------------------------------------------
> Victor Yodaiken
> Finite State Machine Labs: The RTLinux Company.
>  www.fsmlabs.com  www.rtlinux.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
