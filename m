Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314140AbSDLTsO>; Fri, 12 Apr 2002 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314141AbSDLTsN>; Fri, 12 Apr 2002 15:48:13 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35983 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314140AbSDLTsM>; Fri, 12 Apr 2002 15:48:12 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Fri, 12 Apr 2002 14:48:50 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Bill Abt <babt@us.ibm.com>, drepper@redhat.com,
        linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <OF0676911E.A8260761-ON85256B97.006AB10C@raleigh.ibm.com> <20020410194702.C8A6D3FE06@smtp.linux.ibm.com> <3CB6FEFC.DE282A91@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020412194801.35FF13FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 April 2002 11:36 am, Peter Wächtler wrote:
> Hubertus Franke wrote:
> > On Wednesday 10 April 2002 03:30 pm, Bill Abt wrote:
> > > On 04/10/2002 at 02:10:59 PM AST, Hubertus Franke
> > > <frankeh@watson.ibm.com>
> > >
> > > wrote:
> > > > So you are OK with having only poll  or  select.  That seems odd.
> > > > It seems you still need SIGIO on your fd to get the async
> > > > notification.
> > >
> > > Duh...  You're right.  I forgot about that...
> >
> > Yes,
> >
> > The current interface is
> >
> > (A)
> > async wait:
> >         sys_futex (uaddr, FUTEX_AWAIT, value, (struct timespec*) sig);
> > upon signal handling
> >         sys_futex(uaddrs[], FUTEX_WAIT, size, NULL);
> >         to retrieve the uaddrs that got woken up...
> >
> > If you simply want a notification with SIGIO (or whatever you desire)
> > We can change that to
> > (A)
> > sys_futex(uaddr, FUTEX_WAIT, value, (truct timespec*) fd);
> >
> > I send a SIGIO and you can request via ioctl or read the pending
> > notifications from fd.
> > (B)        { struct futex *notarray[N]
> >               int n = read( futex_fd, (void**)notarray,
> >                             N*sizeof(struct futex));
> >         }
> > I am mainly concerned that SIGIO can be overloaded in a thread package ?
> > How would you know whether a SIGIO came from the futex or from other file
> > handle.
>
> I want to vote for using POSIX realtime signals. With them (and SA_SIGINFO)
> you can carry small amounts of userdata, passed in the
>
> struct siginfo_t
> ---susv2---
> The <signal.h> header defines the siginfo_t type as a structure that
> includes at least the following members:
>
>       int           si_signo  signal number
>       int           si_errno  if non-zero, an errno value associated with
>                               this signal, as defined in <errno.h>
>       int           si_code   signal code
>       pid_t         si_pid    sending process ID
>       uid_t         si_uid    real user ID of sending process
>       void         *si_addr   address of faulting instruction
>       int           si_status exit value or signal
>       long          si_band   band event for SIGPOLL
>       union sigval  si_value  signal value
>
> [and further on]
> Implementations may support additional si_code values not included in this
> list, may generate values included in this list under circumstances other
> than those described in this list, and may contain extensions or
> limitations that prevent some values from being generated. Implementations
> will not generate a different value from the ones described in this list
> for circumstances described in this list.
>
> ---susv2---
>

Need to digest your suggestion a bit more. Not too familiar with that 
interface.
One question I have though is whether information can get lost?  

Assume , I have a few notifications pending and signal the app.
We signal the app? what would the app call upon notification.
Remember, I don't want to pass in a heavy weight object into the futex kernel 
call.

> So we could use  si_code=SI_QUEUE and pass the uaddr in sival_ptr
> or even si_code=SIGPOLL and pass the data in si_band.
>
> We could also add our own si_code (SI_FUTEX) and add the tid in
> siginfo_t (if needed for NGPT)
>
> Why pass this data over a file descriptor?
> The user space library can block on sigtimedwait() for notifications.
>
> And with the DoS (letting the kernel pin too much memory on behalf
> of a user process) we could use the "max locked memory" ulimit.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
