Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269748AbRHQS22>; Fri, 17 Aug 2001 14:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269504AbRHQS2S>; Fri, 17 Aug 2001 14:28:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3058 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269748AbRHQS2K> convert rfc822-to-8bit; Fri, 17 Aug 2001 14:28:10 -0400
Message-ID: <3B7D61A6.AF988634@mvista.com>
Date: Fri, 17 Aug 2001 11:25:42 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>,
        "christophe =?iso-8859-1?Q?barb=E9?=" <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), 
 exit(), SIGCHLD)
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com> <3B7AB93D.F8B5B455@mvista.com> <3B7B1B07.A9FB293B@mvista.com> <20010816121746.A5861@pc8.lineo.fr> <20010816112905.A30202@flint.arm.linux.org.uk> <20010816180010.A9235@pc8.lineo.fr> <20010816171248.E30202@flint.arm.linux.org.uk> <3B7C0E3F.24EFB03D@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Russell King wrote:
> >
> > On Thu, Aug 16, 2001 at 06:00:10PM +0200, christophe barbé wrote:
> > > Le jeu, 16 aoû 2001 12:29:05, Russell King a écrit :
> > > > Note also that this is bogus as an architecture invariant.
> > > >
> > > > On ARM, we have to pass a pt_regs pointer into any function that requires
> > > > it.
> > >
> > > I'm not sure to understand your point.
> >
> > Its quite simple:
> >
> > int sys_foo(struct pt_regs regs)
> > {
> > }
> >
> > does not reveal the user space registers on ARM.  It instead reveals crap.
> > Why?  The ARM procedure call standard specifies that the first 4 words
> > of "regs" in this case are in 4 processor registers.  The other words
> > are on the stack immediately above the frame created by foo.  This is
> > not how the stack is layed out on ARM on entry to a sys_* function
> > due to the requirement for these to be restartable.
> >
> > Instead, we must pass a pointer thusly:
> >
> > int sys_foo(struct pt_regs *regs)
> > {
> > }
> >
> > and the pointer is specifically setup and passed in by a very small
> > assembler wrapper.
> >
> > > The first sentence tell me that the "struct pt_regs ..." line is x86
> > > specific and this was the reason behind my proposition to not add a _signal
> > > macro but a  _sys_nanosleep macro to include this too.
> >
> > Correct.  But the act of getting "struct pt_regs" on entry to the function
> > is also architecture specific.
> >
> > > The second sentence seem's to indicate that this is a classic problem for
> > > the ARM port. So if this is correct what is the best way to solve it ?
> >
> > It used to be with such functions as sys_execve.  Then, sys_execve
> > became an architecture specific wrapper around do_execve (not by my
> > hand), so I guess that its not an ARM specific problem.
> >
> > --
> So, it seems we need an arch. specific wrapper for nano_sleep.  Now, how
> to do it so it is a smooth transition?
> 
How about something like:

In ../asm/signal.h  (for i386)

#define PT_REGS_ENTRY(type,name,p1_type,p1, p2_type,p2) \
type name(p1_type p1,p2_typ p2)\
{	struct pt_regs *regs = (struct pt_regs *)&p1;

#define _do_signal() do_signal(regs, NULL)

in ../asm_arm/signal.h

#define PT_REGS_ENTRY(type,name,p1_type,p1, p2_type,p2) \
type name(p1_type p1,p2_typ p2, struct pt_regs *regs) \
{

#define _do_signal() do_signal(NULL,regs, NULL)

and other archs as needed.

in ../linux/signal.h  (the default)

:
#include <asm/signal.h>

:
:
#ifndef PT_REGS_ENTRY
#define PT_REGS_ENTRY(type,name,p1_type,p1, p2_type,p2) \
type name(p1_type p1,p2_typ p2)\
{
#define _do_signal() 1
#endif

and finally in nano_sleep :

PT_REGS_ENTRY(asmlinkage long,sys_nanosleep,struct timespec
*,rqtp,struct timespec *,rmtp)

	struct timespec t;
	unsigned long expire;
:
: etc...

:
	do {
                current->state = TASK_INTERRUPTIBLE;
        } while((expire = schedule_timeout(expire)) && !_do_signal());


The notion is that this could be used for other system calls, in
particular I want to implement clock_nanosleep() as part of the extended
POSIX standard.

Comments, flames,...

George
