Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313546AbSDMNyI>; Sat, 13 Apr 2002 09:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSDMNyH>; Sat, 13 Apr 2002 09:54:07 -0400
Received: from dialin-145-254-150-019.arcor-ip.net ([145.254.150.19]:13829
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S313546AbSDMNyG> convert rfc822-to-8bit; Sat, 13 Apr 2002 09:54:06 -0400
Message-ID: <3CB83807.5AD7EEA7@loewe-komp.de>
Date: Sat, 13 Apr 2002 15:52:07 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Bill Abt <babt@us.ibm.com>, drepper@redhat.com,
        linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futex Generalization Patch
In-Reply-To: <OF0676911E.A8260761-ON85256B97.006AB10C@raleigh.ibm.com> <20020410194702.C8A6D3FE06@smtp.linux.ibm.com> <3CB6FEFC.DE282A91@loewe-komp.de> <20020412194801.35FF13FE06@smtp.linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> On Friday 12 April 2002 11:36 am, Peter Wächtler wrote:
> > Hubertus Franke wrote:
> > > On Wednesday 10 April 2002 03:30 pm, Bill Abt wrote:
> > > > On 04/10/2002 at 02:10:59 PM AST, Hubertus Franke
> > > > <frankeh@watson.ibm.com>
> > > >
> > > > wrote:
> > > > > So you are OK with having only poll  or  select.  That seems odd.
> > > > > It seems you still need SIGIO on your fd to get the async
> > > > > notification.
> > > >
> > > > Duh...  You're right.  I forgot about that...
> > >
> > > Yes,
> > >
> > > The current interface is
> > >
> > > (A)
> > > async wait:
> > >         sys_futex (uaddr, FUTEX_AWAIT, value, (struct timespec*) sig);
> > > upon signal handling
> > >         sys_futex(uaddrs[], FUTEX_WAIT, size, NULL);
> > >         to retrieve the uaddrs that got woken up...
> > >
> > > If you simply want a notification with SIGIO (or whatever you desire)
> > > We can change that to
> > > (A)
> > > sys_futex(uaddr, FUTEX_WAIT, value, (truct timespec*) fd);
> > >
> > > I send a SIGIO and you can request via ioctl or read the pending
> > > notifications from fd.
> > > (B)        { struct futex *notarray[N]
> > >               int n = read( futex_fd, (void**)notarray,
> > >                             N*sizeof(struct futex));
> > >         }
> > > I am mainly concerned that SIGIO can be overloaded in a thread package ?
> > > How would you know whether a SIGIO came from the futex or from other file
> > > handle.
> >
> > I want to vote for using POSIX realtime signals. With them (and SA_SIGINFO)
> > you can carry small amounts of userdata, passed in the
> >
> > struct siginfo_t
> > ---susv2---
> > The <signal.h> header defines the siginfo_t type as a structure that
> > includes at least the following members:
> >
> >       int           si_signo  signal number
> >       int           si_errno  if non-zero, an errno value associated with
> >                               this signal, as defined in <errno.h>
> >       int           si_code   signal code
> >       pid_t         si_pid    sending process ID
> >       uid_t         si_uid    real user ID of sending process
> >       void         *si_addr   address of faulting instruction
> >       int           si_status exit value or signal
> >       long          si_band   band event for SIGPOLL
> >       union sigval  si_value  signal value
> >
> > [and further on]
> > Implementations may support additional si_code values not included in this
> > list, may generate values included in this list under circumstances other
> > than those described in this list, and may contain extensions or
> > limitations that prevent some values from being generated. Implementations
> > will not generate a different value from the ones described in this list
> > for circumstances described in this list.
> >
> > ---susv2---
> >
> 
> Need to digest your suggestion a bit more. Not too familiar with that
> interface.
> One question I have though is whether information can get lost?
> 
> Assume , I have a few notifications pending and signal the app.
> We signal the app? what would the app call upon notification.
> Remember, I don't want to pass in a heavy weight object into the futex kernel
> call.
> 

Well, realtime signals are reliable in that, that the implementation has to
assure, that NO signal gets lost (in contrast to the early unreliable signals 
[in Version7 ?]). For every notification a realtime signal gets queued.

Do you want to be able to read all (or at least a lot of) pending notifications
at once? Then your interface _could_ be more efficient than using a realtime 
signal for every notification.
OTOH, if you pass the uaddr with the signal, you save one syscall ...
Here is an advantage on low lock contention (number of waiters).

So you want to read several WAKEUP events in your signal handler. Except for the
pthread_cond_broadcast(which is not often used?) do you think that this is a 
realistic real world scenario or only good for a synthetic benchmark 
that shows: hey, on heavy lock contention: this implementation is faster.

Looking closer at the pthread_cond_broadcast:

a) NGPT and n waiters on the same kernel vehicle
	the thread manager could request one WAITA for all, would
	get just one signal and wakes up all threads on his own

b) NGPT and n waiters on m kernel vehicles
	all threads on their own vehicle will block on sys_futex(FUTEX_WAIT)
	all others are managed on user space queue and woken up
	by manager who gets only 1 notification

c) NGPT and n waiters on n kernel vehicles (like on LinuxThreads)
	every kernel vehicle will request a WAIT and block

So when we have 500 threads competing for dozens of mutexes on a big SMP box:
is the bottleneck in the kernel (and on the locked bus) or in the notification
mechanism? I can't imagine (don't hit me on this :) that if the kernel releases a 
lock, and the app wants a fast notification (and delivered/scheduled in priority 
order) that there is a big chance that a lot of notifications pile up... 
What do you think?
Also: the waitqueues in the kernel are protected by a mutex themselves, while in 
progress of waking up, no new waiters can be added.

If the waiter has higher priority I want to deliver the notify immediatly so that 
it's getting the CPU and preempts the lock releaser - I wouldn't want a lazy wake up. 

[And yes, I am missing the wake up in priority order. Uh, now we can discuss the 
preempt patch again... and I will check how realtime processes are treated]
