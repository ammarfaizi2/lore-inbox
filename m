Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSATKdJ>; Sun, 20 Jan 2002 05:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288130AbSATKc7>; Sun, 20 Jan 2002 05:32:59 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56310 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288127AbSATKcl>; Sun, 20 Jan 2002 05:32:41 -0500
Message-ID: <3C4A9C97.15AE9D32@mvista.com>
Date: Sun, 20 Jan 2002 02:31:51 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Momchil Velikov <velco@fadata.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver.Neukum@lrz.uni-muenchen.de,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16QB8b-0002K8-00@the-village.bc.nu> <87sn98ftpi.fsf@fadata.bg> <20020114154640.A26460@hq.fsmlabs.com> <876664vxm8.fsf@fadata.bg> <20020115053135.B32605@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> On Tue, Jan 15, 2002 at 10:15:11AM +0200, Momchil Velikov wrote:
> > >>>>> "yodaiken" == yodaiken  <yodaiken@fsmlabs.com> writes:
> >
> > yodaiken> On Tue, Jan 15, 2002 at 12:34:01AM +0200, Momchil Velikov wrote:
> > >> One can consider a non-preemptible kernel as a special kind of
> > >> priority inversion, preemptible kernel will eliminate _that_ case of
> > >> priority inversion.
> >
> > yodaiken> The problem here is that priority means something very different in
> > yodaiken> a time-shared system than in a hard real-time system. And even in real-time
> > yodaiken> systems, as Walpole and colleagues have pointed out, priority doesn't
> > yodaiken> really capture much of what is needed for good scheduling.
> >
> > Well, maybe there are other policies (notably static scheduling ;),
> > which may be preferrable in one or other case, anyway, I personally
> > tend to think rate-monotonic scheduling is quite adequate in practice.
> 
> That's not what we see in real RT applications.
> 
> > Of course, anyone is free to prove me wrong by implementing earliest
> > deadline or slack time scheduler in the kernel.
> 
> My impression is that these are of limited use in applications.
> 
> >
> > yodaiken> In a general purpose system,  priorities are dynamic and "fair".
> > yodaiken> The priority of even the lowliest process increases while it waits
> > yodaiken> for time. In a raw real-time system, the low priority process can sit
> > yodaiken> forever and should wait until no higher priority thread needs the
> > yodaiken> processor.
> >
> > *nod*
> >
> > yodaiken>             So it's absurd to talk of priority inversion in a non RT
> > yodaiken> system. When a low priority process is delaying a higher priority task
> > yodaiken> for reasons of fairness, increased throughput, or any other valid
> > yodaiken> objective, that is not a scheduling error.
> >
> > What is a non real-time system?  E.g. are a desktop playing ogg or a
> > server serving multimedia content over ATM, real-time systems?  The
> > point is that one can view the system as real-time or not depending on
> > the dominant _current_ load.  A system may have real-time load now and
> 
> I don't think so, and certainly the straightforward priority based model
> of traditional RT seems grossly wrong. What's the highest priority process -
> is it the CD player or is it the niced sendmail that is running in the
> background? The fact is we require that _both_ make progress. Therefore
> at some time the sendmail process must have effectively higher priority
> than the CD player. If we then factor in the many kernel threads that may
> be running at any time, the calculation becomes even more problematic.
> In RTLinux we have a much simpler environment and we can use the rule:
>         The highest priority runnable task should be the running task
>         within some T and the OS gets better as T goes to 0.
> If something starves, that's the user problem - our users are programmers
> who we want to provide with as much control as possible. We certainly
> do not want to have a situation where the stop command to the robot arm
> is delayed because the OS needs to run bdflush ...
> 
> For Linux, even Linux doing the critical work of playing DVDs, this is
> not so simple. The target users are not programmers, liveness and
> responsiveness remain important criteria ...
> It's clear that much of the problem when people discuss this issue is
> lack of clear goals. "Preemption" is a controversial implementation
> technique, not a goal in itself - I hope. Even "low latency" doesn't
> really capture the intended goal - "low latency" to do what?  If it's
> simply "low latency" switch to highest priority process, that's not
> necesarily anything that is going to be useful in itself. The
> "resource reservation" work at CMU seems to me to be way off the point
> too. The OGI people have some interesting thoughts about this stuff, but
> I don't think they've come close to working out a comprehensive model.
> 
> What I think we need is a kind of interval real-time scheduling.
> Something like:
>         The system has a basic timing period of N milliseconds where
>         N is at lease 500 and probably more.
> 
>         Over a N millisecond period each process gets a full scheduling quantum
>         and, if it requests, a full I/O quantum.
>         For a niced process there is some calculated interval greater than
>         N. An I/O quantum should correspond somehow to a rate of I/0.
> 
>         RTLIMIT is used to set the max number of processes allowed to start
>         and this determines the computation length of "one quantum"

Have you looked at SCHED_SPORADIC (see 1003.1d-1999)?
> 
> There is this cliche about RT that RT is about deadlines, not speed, but I think
> that's only partially true. To say that every task will run during a 1 second period
> with today's PC/Server technology is fundamentally different than to say that
> every task will run during a 10 millisecond period.
> 
> > a non real-time one an hour later, both occasionally intermixed with
> > tasks of the other class. It is unreasonable to say "This system is
> > non-realtime so use that kernel and when you want to play vidoes,
> > please reboot to something else, for example XX-Linux".
> 
> Yes, but it's not unreasonable to pop up a window and ask the user if
> he/she wants to have the scheduling rates of other applications
> stepped down to run the DVD player.
>         The Oracle logging server is designed to run at 1 second periods
>         increasing the responsiveness of your current process will
>         reduce that to a 2 second period.
>         Email delivery will be delayed up to 1 minute
>         ...
>         YES NO
> 
> and so we can follow the most important OS design technique of all time:
>         push complexity to user space.
> 
> 
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
