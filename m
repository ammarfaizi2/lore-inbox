Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSDLPmt>; Fri, 12 Apr 2002 11:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313332AbSDLPms>; Fri, 12 Apr 2002 11:42:48 -0400
Received: from dialin-145-254-148-025.arcor-ip.net ([145.254.148.25]:25604
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S312638AbSDLPms>; Fri, 12 Apr 2002 11:42:48 -0400
Message-ID: <3CB6FEFC.DE282A91@loewe-komp.de>
Date: Fri, 12 Apr 2002 17:36:28 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: frankeh@watson.ibm.com
CC: Bill Abt <babt@us.ibm.com>, drepper@redhat.com,
        linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futex Generalization Patch
In-Reply-To: <OF0676911E.A8260761-ON85256B97.006AB10C@raleigh.ibm.com> <20020410194702.C8A6D3FE06@smtp.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> On Wednesday 10 April 2002 03:30 pm, Bill Abt wrote:
> > On 04/10/2002 at 02:10:59 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
> >
> > wrote:
> > > So you are OK with having only poll  or  select.  That seems odd.
> > > It seems you still need SIGIO on your fd to get the async notification.
> >
> > Duh...  You're right.  I forgot about that...
> >
> 
> Yes,
> 
> The current interface is
> 
> (A)
> async wait:
>         sys_futex (uaddr, FUTEX_AWAIT, value, (struct timespec*) sig);
> upon signal handling
>         sys_futex(uaddrs[], FUTEX_WAIT, size, NULL);
>         to retrieve the uaddrs that got woken up...
> 
> If you simply want a notification with SIGIO (or whatever you desire)
> We can change that to
> (A)
> sys_futex(uaddr, FUTEX_WAIT, value, (truct timespec*) fd);
> 
> I send a SIGIO and you can request via ioctl or read the pending
> notifications from fd.
> (B)        { struct futex *notarray[N]
>               int n = read( futex_fd, (void**)notarray,
>                             N*sizeof(struct futex));
>         }
> I am mainly concerned that SIGIO can be overloaded in a thread package ?
> How would you know whether a SIGIO came from the futex or from other file
> handle.
> 

I want to vote for using POSIX realtime signals. With them (and SA_SIGINFO) 
you can carry small amounts of userdata, passed in the 

struct siginfo_t
---susv2---
The <signal.h> header defines the siginfo_t type as a structure that 
includes at least the following members: 

      int           si_signo  signal number
      int           si_errno  if non-zero, an errno value associated with
                              this signal, as defined in <errno.h>
      int           si_code   signal code
      pid_t         si_pid    sending process ID
      uid_t         si_uid    real user ID of sending process
      void         *si_addr   address of faulting instruction
      int           si_status exit value or signal
      long          si_band   band event for SIGPOLL
      union sigval  si_value  signal value

[and further on]
Implementations may support additional si_code values not included in this 
list, may generate values included in this list under circumstances other 
than those described in this list, and may contain extensions or limitations 
that prevent some values from being generated. Implementations will not 
generate a different value from the ones described in this list for 
circumstances described in this list. 

---susv2---

So we could use  si_code=SI_QUEUE and pass the uaddr in sival_ptr
or even si_code=SIGPOLL and pass the data in si_band.

We could also add our own si_code (SI_FUTEX) and add the tid in
siginfo_t (if needed for NGPT)

Why pass this data over a file descriptor?
The user space library can block on sigtimedwait() for notifications.

And with the DoS (letting the kernel pin too much memory on behalf
of a user process) we could use the "max locked memory" ulimit.
