Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270438AbRHWVQ5>; Thu, 23 Aug 2001 17:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270460AbRHWVQw>; Thu, 23 Aug 2001 17:16:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17916 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S270438AbRHWVQg>; Thu, 23 Aug 2001 17:16:36 -0400
Message-ID: <3B857210.44E7DA20@mvista.com>
Date: Thu, 23 Aug 2001 14:13:52 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Victor Yodaiken <yodaiken@fsmlabs.com>,
        "christophe =?iso-8859-1?Q?barb=E9?=" <christophe.barbe@lineo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), 
 exit(), SIGCHLD)
In-Reply-To: <20010817125727.A16475@hq2> <3B7D76EF.DA34EB23@mvista.com> <20010822194035.K18391@flint.arm.linux.org.uk> <3B8561B9.AC440835@mvista.com> <20010823211121.H24974@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Thu, Aug 23, 2001 at 01:04:09PM -0700, george anzinger wrote:
> > Sorry, but none of those system calls requires the registers which is
> > where the problem is.
> 
> /* Fork a new task - this creates a new program thread.
>  * This is called indirectly via a small wrapper
>  */
> asmlinkage int sys_fork(struct pt_regs *regs)
>                         ^^^^^^^^^^^^^^^^^^^^
> {
>         return do_fork(SIGCHLD, regs->ARM_sp, regs, 0);
> }
> 
> /* sys_execve() executes a new program.
>  * This is called indirectly via a small wrapper
>  */
> asmlinkage int
> sys_execve(char *filenamei, char **argv, char **envp, struct pt_regs *regs)
>                                                      ^^^^^^^^^^^^^^^^^^^^^
> {
>         int error;
>         char * filename;
> 
>         filename = getname(filenamei);
>         error = PTR_ERR(filename);
>         if (IS_ERR(filename))
>                 goto out;
>         error = do_execve(filename, argv, envp, regs);
>         putname(filename);
> out:
>         return error;
> }
> 
> Certainly looks to me like they do.  See the highlighted arguments.
> 
I stand corrected!  Guess I should look before I leap, uh email.  OK,
here is the issue I am dealing with.  I would like to define a new
system call (clock_nanosleep()) to conform to the extended POSIX
standard.  It, as well as the current nanosleep() needs the regs. to
call do_signal(), however, it is strictly a pass thru, do_signal() uses
the regs, not the main body of the sleep functions.  The various
platforms have different ways of passing the regs to the system call and
also different ways of calling do_signal().  The failure to be able to
call do_signal() results in the call not properly ignoring ptrace
signals, see the beginning of this thread.  What I would like to do is
to abstract the interface to the system calls (just the nanosleep ones
will do for now) so that the common code will work (except for the
ptrace problem) while leaving room for the platform code to pick up the
ball as they support people feel so inclined.  This means that some of
them would have to write the required wrappers and all would have to
define the macros that abstract the interface.  Here is what I have so
far:

In include/linux/signal.h
#ifndef PT_REGS_ENTRY
#define PT_REGS_ENTRY(type,name,p1_type,p1,p2_type,p2) \
type name(pi_type p1,p2_type,p2) {

#define _do_signal() 1
#endif

In include/asm_i386/signal.h

asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t
*oldset));
#define PT_REGS_ENTRY(type,name,p1_type,p1,p2_type,p2) \
type name(p1_type p1,p2_type p2) \
{	struct pt_regs *regs=(struct pt_regs *)&p1;
#define _do_signal() do_signal(regs,NULL)

and in kernel/timer.c

PT_REGS_ENTRY(asmlinkage long,sys_nanosleep,struct timespec*,rqtp,struct
timespec* ,rmtp)
struct timespec t;.....

do{
	current->state = TASK_INTERRUPTABLE;
}while((expire = schedule_timeout(expire)) && !_do_signal());

I think this lets us get on with fixing the i386 branch without breaking
any other branch and still leaves it easy for other branches to catch up
as they find the time to do so.


The question I haven't had time to research is if there is enough
flexibility for all the other platforms.  Certainly ARM can insert the
additional parameter in the system call using this.  

If you want my $.02 worth, the pt_regs should be addressable without
reference to the call stack.  To the best of my knowledge, they are
always at the base of the kernel stack (assuming we ignore the case of
kernel interrupts where we don't allow signal delivery in any case) and
so should be find able by doing a bit of math on the stack pointer.  How
does the hardware come up with a stack pointer when interrupting/
calling from user space?  Food for thought, and of course, it is
different for each platform.

George
