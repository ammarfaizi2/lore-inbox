Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWGHGMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWGHGMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 02:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWGHGMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 02:12:48 -0400
Received: from bay0-omc3-s1.bay0.hotmail.com ([65.54.246.201]:43963 "EHLO
	bay0-omc3-s1.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S964817AbWGHGMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 02:12:47 -0400
Message-ID: <BAY110-F20F0B50886D0441B0B8989B8750@phx.gbl>
X-Originating-IP: [198.123.50.95]
X-Originating-Email: [trajcenedev@hotmail.com]
From: "trajce nedev" <trajcenedev@hotmail.com>
To: torvalds@osdl.org, acahalan@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-os@analogic.com, khc@pm.waw.pl,
       mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Fri, 07 Jul 2006 23:12:44 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jul 2006 06:12:47.0692 (UTC) FILETIME=[88C130C0:01C6A255]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Linus Torvalds wrote:
>
>No.
>
>"volatile" simply CANNOT get the job done. It fundamentally does _nothing_ 
>for all the issues that are fundamental today: CPU memory ordering in SMP, 
>special IO synchronization requirements for memory-mapped IO registers etc 
>etc.
>
>It's not that "volatile" is the "portable way". It's that "volatile" is 
>fundamentally not sufficient for the job.
>

Incorrect.  I haven't been following this thread very closely but your 
assault on volatile is inappropriate.  There are several present day uses in 
assember instructions.

For example, if you're going to clobber hard registers specifically, 
volatile is required because you cannot write a clobber that overlaps input 
or output operands:
	asm volatile ("movc3 %0,%1,%2"
		: /* none */
		: "g" (from), "g" (to), "g" (count)
		: "r0", "r1", "r2", "r3", "r4", "r5");
You cannot have an operand that describes a register class with a single 
member if that register is in the clobber list; there is simply no way to 
specify that an input operand is modified without explicitly specifying it 
as output.  If all the output operands are for that purpose, they are 
considered unused.  volatile is _necessary_ for the asm to prevent the 
compiler from deleting it for this reason.

Furthermore, if the asm modifies memory unpredictably, you must add `memory` 
to the list of clobbers.  The compiler will not keep the memory value cached 
in registers any longer across asm instructions; volatile is added if the 
memory you're touching is not listed in the inputs or outputs since the 
`memory` clobber does not count as a side-effect of issuing the asm.  
volatile indicates the asm has side effects that are _important_ and will 
not delete it (if it's reachable, otherwise it is fair game).

If your asm has output operands, gcc currently assumes that the instruction 
has no side effects except changing these output operands (for 
optimization).  The compiler is free to eliminate or move out of loops any 
instructions with side effects if the output operands aren't used.  Even 
more dangerously, if the asm has a side effect on a variable that doesn't 
otherwise appear to change, the old value _may_ be reused later if it's 
found in a register.  volatile is used to prevent the asm from being deleted 
in this case (or more dangerously, combined):
	#define get_and_set_priority(new)		\
	({ 	int __old;				\
		asm volatile ("get_and_set_priority %0, %1"	\
			: "=g" (__old) : "g" (new));	\
		__old; })
The alternative is to write an asm with no outputs so that the compiler 
knows the instruction has side effects and won't eliminate or move it.

Also, gcc will not reschedule instructions across volatile asm's which is 
often necessary:
	*(volatile int *)addr = foo;
	asm volatile ("eieio" : : );
If addr contains the address of a memory-mapped device register, then the 
PowerPC eieio instruction informs the processor that it is necessary to 
store to that device register before issuing any other I/O.

		Trajce Nedev
		tnedev@mail.ru

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

