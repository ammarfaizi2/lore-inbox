Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQLGWco>; Thu, 7 Dec 2000 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLGWcf>; Thu, 7 Dec 2000 17:32:35 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:4110 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129428AbQLGWcQ>;
	Thu, 7 Dec 2000 17:32:16 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Thu, 7 Dec 2000 23:01:14 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Why is double_fault serviced by a trap gate?
CC: Andi Kleen <ak@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F0595854FC8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Dec 00 at 16:44, Richard B. Johnson wrote:
> On Thu, 7 Dec 2000 richardj_moore@uk.ibm.com wrote:
> 
> > Which surely we can on today's x86 systems. Even back in the days of OS/2
> > 2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI and
> > Double Fault. You need only a minimal stack - 1K, sufficient to save state
> > and restore ESP to a known point before switching back to the main TSS to
> > allow normal exception handling to occur.
> > 
> > There no architectural restriction that some folks have hinted at - as long
> > as the DPL for the task gates is 3.
> > 
> [SNIPPED...]
> 
> Please refer to page 6-16, Inter486 Microprocessor Family Programmer's
> Reference Manual.
> 
> The specifc text is: "The TSS does not have a stack pointer for a
> privilege level 3 stack, because the procedure cannot be called by a less
> privileged procedure. The stack for privilege level 3 is preserved by the
> contents of SS and EIP registers which have been saved on the stack
> of the privilege level called from level 3".
> 
> What this means is that a stack-fault in level 3 will kill you no
> matter how cute you try to be. And, putting a task gate as call
> procedure entry from a trap or fault is just trying to be cute.
> It's extra code that will result in the same processor reset.

You misunderstand. There is no SS/ESP for level 3, because of you cannot
switch to CPL 3 using CALL/JMP, you can switch to it only through IRET/RETF.
And both of them fetch new SS/ESP from stack...

If stack-fault happens on CPL3, CPU switches to CPL0 (as defined by
stack fault trap gate), executes appropriate code, and then returns
back to CPL3 through IRET.

Maybe you forgot when reading this, that CPL3 is non-priviledged level,
and CPL0 has most of priviledges.

Problem with doublefault is that if you overflowed CPL0 stack, you just
cannot service this error on same stack, you must switch to another one.
And only way to switch out from CPL0 stack during fault service is
hardware switch to another TSS.

In either case, nothing is ever pushed into old stack, so doing

movl $0,%esp

does not matter. With userspace never, in kernel if you have task gate
for doublefault... In userspace it will not even crash until you send some
signal to that process, or until you'll execute some call/push/pop yourself.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
