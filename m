Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRHPQMw>; Thu, 16 Aug 2001 12:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271582AbRHPQMm>; Thu, 16 Aug 2001 12:12:42 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:13714 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S268342AbRHPQMg>; Thu, 16 Aug 2001 12:12:36 -0400
Date: Thu, 16 Aug 2001 17:12:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), SIGCHLD)
Message-ID: <20010816171248.E30202@flint.arm.linux.org.uk>
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com> <3B7AB93D.F8B5B455@mvista.com> <3B7B1B07.A9FB293B@mvista.com> <20010816121746.A5861@pc8.lineo.fr> <20010816112905.A30202@flint.arm.linux.org.uk> <20010816180010.A9235@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010816180010.A9235@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Thu, Aug 16, 2001 at 06:00:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 06:00:10PM +0200, christophe barbé wrote:
> Le jeu, 16 aoû 2001 12:29:05, Russell King a écrit :
> > Note also that this is bogus as an architecture invariant.
> > 
> > On ARM, we have to pass a pt_regs pointer into any function that requires
> > it.
> 
> I'm not sure to understand your point.

Its quite simple:

int sys_foo(struct pt_regs regs)
{
}

does not reveal the user space registers on ARM.  It instead reveals crap.
Why?  The ARM procedure call standard specifies that the first 4 words
of "regs" in this case are in 4 processor registers.  The other words
are on the stack immediately above the frame created by foo.  This is
not how the stack is layed out on ARM on entry to a sys_* function
due to the requirement for these to be restartable.

Instead, we must pass a pointer thusly:

int sys_foo(struct pt_regs *regs)
{
}

and the pointer is specifically setup and passed in by a very small
assembler wrapper.

> The first sentence tell me that the "struct pt_regs ..." line is x86
> specific and this was the reason behind my proposition to not add a _signal
> macro but a  _sys_nanosleep macro to include this too.

Correct.  But the act of getting "struct pt_regs" on entry to the function
is also architecture specific.

> The second sentence seem's to indicate that this is a classic problem for
> the ARM port. So if this is correct what is the best way to solve it ?

It used to be with such functions as sys_execve.  Then, sys_execve
became an architecture specific wrapper around do_execve (not by my
hand), so I guess that its not an ARM specific problem.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

