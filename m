Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264433AbRFSRWf>; Tue, 19 Jun 2001 13:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRFSRWZ>; Tue, 19 Jun 2001 13:22:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264433AbRFSRWO>; Tue, 19 Jun 2001 13:22:14 -0400
Date: Tue, 19 Jun 2001 13:21:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gnu asm help...
In-Reply-To: <giuPyB.A.JvE.jR3L7@dinero.interactivesi.com>
Message-ID: <Pine.LNX.3.95.1010619125114.20417A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Timur Tabi wrote:

> ** Reply to message from "Petr Vandrovec" <VANDROVE@vc.cvut.cz> on Tue, 19 Jun
> 2001 01:36:26 MET-1
> 
> 
> > No. Another CPU might increment value between LOCK INCL and
> > fetching v->counter. On ia32 architecture you are almost out of
> > luck. You can either try building atomic_inc around CMPXCHG,
> > using it as conditional store (but CMPXCHG is not available 
> > on i386), or you can just guard your atomic variable with 
> > spinlock - but in that case there is no reason for using atomic_t 
> > at all.
> 
> Oh, I see the problem.  You could do something like this:
> 
> cli
> mov %0, %%eax
> inc %%eax
> mov %%eax, %0
> sti
> 
> and then return eax, but that won't work on SMP (whereas the "lock inc" does).
> Doing a global cli might work, though.

The Intel book(s) state that an interrupt is not acknowledged until
so many clocks (don't remember the number) after a stack operation.

Given this, is an 'attack' by another CPU allowed within this time-frame?
If not, you can do:

	pushl	%ebx
	movl	INPUT_VALUE(%esp), %eax	# Get input value
	movl	INPUT_PTR(%esp), %ebx	# Get input pointer
	lock
	addl	%eax,(%ebx)		# Add value 
	pushl	(%ebx)			# Put result on stack
	popl	%eax			# Return value in EAX
	popl	%ebx

It may be worth an experiment.

In any event, you can always use a local lock to make these
operations atomic.

# Stack offsets
VALUE = 0x08
POINTER = 0x0C

.section .data
__local_lock:	.long	0
.section .text

.global	add_atom
.type	add_atom,@function

add_atom:
	pushf
	cli
	incb	(__local_lock)		# Set the lock
1:	cmpb	$1,(__local_lock)
	jnz	1b
	pushl	%ebx
	movl	VALUE(%esp), %eax
	movl	POINTER(%esp), %ebx
	addl	%eax, (%ebx)
	movl	(%ebx), %eax
	popl	%ebx
	decb	(__local_lock)		# Release the lock
	popf
	ret

The lock can also be done as:

	incb	(__local_lock)
1:	cmpb	$1,(__local_lock)
	jz	2f
	repz
	nop
	jmp	1b
2:

(maybe) the CPU being locked loops in low-power mode.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


