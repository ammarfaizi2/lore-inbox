Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQKAAGA>; Tue, 31 Oct 2000 19:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130049AbQKAAFv>; Tue, 31 Oct 2000 19:05:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55568 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130056AbQKAAFf>;
	Tue, 31 Oct 2000 19:05:35 -0500
Date: Tue, 31 Oct 2000 18:05:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF465F.4EEB811A@timpanogas.org>
Message-ID: <Pine.LNX.3.95.1001031174047.165A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> 
> A "context" is usually assued to be a "stack".  The simplest of all
> context switches 
> is:
> 
>    mov    x, esp
>    mov    esp, y
> 
> A context switch can be as short as two instructions, or as big as a TSS
> with CR3 hardware switching,
> 
> i.e.  
> 
>    ltr    ax
>    jmp    task_gate
> 
> (500 clocks later)
> 
>    ts->eip gets exec'd
> 
> you can also have a context switch that does an int X where X is a gate
> or TSS.
> 
> you can also have a context switch (like linux) that does
> 
>     mov    x, esp
>     mov    esp, y
>     mov    z, CR3
>     mov    CR3, w
> 
> etc.
> 
> In NetWare, a context switch is an in-line assembly language macro that
> is 2 instructions long for a stack switch and 4 instructions for a CR3
> reload -- this is a lot shorter than Linux.
> Only EBX, EBP, ESI, and EDI are saved and this is never done in the
> kernel, but is a natural
> affect of the Watcom C compiler.  There's also strict rules about
> register assignments that re enforced between assembler modules in
> NetWare to reduce the overhead of a context switch.  The code path is
> very complex in NetWare, and priorities and all this stuff exists, but
> these code paths are segragated so these types of checks only happen
> once in a while and check a pre-calc'd "scoreboard" that is read only
> across processors and updated and recal'd by a timer every 18 ticks.
> 
> Jeff
> 
>    

I have this feeling that this is an April Fools joke. Unfortunately
it's Halloween.

One could create a 'kernel' that does:
	for(;;)
        {
          proc0();
          proc1();
          proc2();
          proc3();
          etc();
        }

... and loop forever. All 'tasks' would just be procedures and no
context-switching would even be necessary. This is how some network
file-servers worked in the past (Vines comes to mind). Since all
possible 'tasks' are known at compile-time, there isn't even any
need for memory protection because every task cooperates and doesn't
destroy anything that it doesn't own.

The only time you need to save anything is for interrupt handlers.
This was some simple push/pops of only the registers actually
used in the ISR.

Now, the above example may seem absurd, however it's not. Inside
each of the proc()'s is a global state-variable that allows the
code to start executing at the place it left off the last time
through. If the code was written in 'C' it would be a 'switch'
statement. The state-variable for each of the procedures is global
and can be changed in an interrupt-service-routine. This allows
interrupts to change the state of the state-machines.

This kind of 'kernel' is very fast and very effective for things
like file-servers and routers, things that do the same stuff over
and over again.

However, there techniques are not useful with a kernel that
has an unknown number of tasks that execute 'programs' that are
not known to the kernel at compile-time, such as a desk-top
operating system.

These operating systems require context-switching. This requires
that every register that a user could possibly alter, be saved
and restored. It also requires that the state of any hardware
that a user could be using, also be save and restored. This
cannot be done in 2 instructions as stated. Further, this saving
and restoring cannot be a side-effect of a particular compiler, as
stated.

Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
