Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbQLHNuI>; Fri, 8 Dec 2000 08:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbQLHNt6>; Fri, 8 Dec 2000 08:49:58 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:44674 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130021AbQLHNtp>; Fri, 8 Dec 2000 08:49:45 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Message-ID: <802569AF.004926DB.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 8 Dec 2000 13:18:11 +0000
Subject: Re: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK
---------------------- Forwarded by Richard J Moore/UK/IBM on 08/12/2000
13:17 ---------------------------




To:   root@chaos.analogic.com
cc:

From: Richard J Moore/UK/IBM@IBMGB
Subject:  Re: Why is double_fault serviced by a trap gate?
Importance:    Normal


I'm sorry I still don't see your point. You have a double-fault in R0
running on the normal R0 stack I presume.  If you don't handle exception 8
with a task gate then this automatically becomes a triple-fault, the
processor resets and we get no information about what's happened.

My point is that the double-fault code is a waste of time unless you use a
task gate. If you're not going to do that then just leave IDT 8 as an
invalid descriptor.

As far as aguing without reading what you're written, that's not the case.
You're using very abreviated language, it's not obvious to me what you're
driving at - I have to fill in the gaps and guess.

What do you mean by "stack-trick"?
Why can't recovery be sufficient at least to give meaninful diagnostic
information?

Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


"Richard B. Johnson" <root@chaos.analogic.com> on 08/12/2000 12:58:06

Please respond to root@chaos.analogic.com

To:   Richard J Moore/UK/IBM@IBMGB
cc:   Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>, "Maciej
      W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject:  Re: Why is double_fault serviced by a trap gate?




On Fri, 8 Dec 2000 richardj_moore@uk.ibm.com wrote:

>
>
> No no. That's that the whole point of a gate. You make a controlled
> transition to ring 0 including stack switching. There are complex
> protection checking rules, however as long as the DPL of the gate
> descriptor is 3 then ring 3 is allowed to make the transition to ring 0.
A
> stack fault in user mode cannot kill the system. If it ever did it would
be
> a blatant bug of the most crass kind.
>
> You seem to be implying that a stack fault in R3 will or could cause a
> stack fault in R0 - why? Each thread has it's own R0 stack. The value for
> R0 SS:ESP are taken from the current (H/W) TSS and gets initial values at
> the top of the stack.
>

Read my lips. I implied no such thing. The user trap to kernel was
just a way to get to the kernel, i.e., "system call". Otherwise
you don't have anything to "get back to".

Too many people just want to argue without even reading what they
are arguing against. Again, I implied nothing. I said;

 (1) User traps, CPL3, stack for trap is in CPL0.
 (2) CPL0 has stack-fault (bad ring zero code, bad memory).
 (3) CPL0 traps, using faulted stack, double fault.
 (4) There is no stack-trick, including a call-gate  to another
  "environment" (complete with its previously-reserved stack),
  that will ever get you back to (2), much less to (1).

Now, if you can't read this, don't argue.



>
> "Richard B. Johnson" <root@chaos.analogic.com> on 08/12/2000 01:36:58
>
> Please respond to root@chaos.analogic.com
>
> To:   Brian Gerst <bgerst@didntduck.org>
> cc:   Richard J Moore/UK/IBM@IBMGB, Andi Kleen <ak@suse.de>, "Maciej W.
>       Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
> Subject:  Re: Why is double_fault serviced by a trap gate?
>
>
>
>
> On Thu, 7 Dec 2000, Brian Gerst wrote:
>
> > "Richard B. Johnson" wrote:
> > >
> > > On Thu, 7 Dec 2000 richardj_moore@uk.ibm.com wrote:
> > >
> > > >
> > > >
> > > > Which surely we can on today's x86 systems. Even back in the days
of
> OS/2
> > > > 2.0 running on a 386 with 4Mb RAM we used a taskgate for both NMI
and
> > > > Double Fault. You need only a minimal stack - 1K, sufficient to
save
> state
> > > > and restore ESP to a known point before switching back to the main
> TSS to
> > > > allow normal exception handling to occur.
> > > >
> > > > There no architectural restriction that some folks have hinted at -
> as long
> > > > as the DPL for the task gates is 3.
> > > >
> > > [SNIPPED...]
> > >
> > > Please refer to page 6-16, Inter486 Microprocessor Family
Programmer's
> > > Reference Manual.
> > >
> > > The specifc text is: "The TSS does not have a stack pointer for a
> > > privilege level 3 stack, because the procedure cannot be called by a
> less
> > > privileged procedure. The stack for privilege level 3 is preserved by
> the
> > > contents of SS and EIP registers which have been saved on the stack
> > > of the privilege level called from level 3".
> > >
> > > What this means is that a stack-fault in level 3 will kill you no
> > > matter how cute you try to be. And, putting a task gate as call
> > > procedure entry from a trap or fault is just trying to be cute.
> > > It's extra code that will result in the same processor reset.
> >
> > No, because the CPL of the task gate would be 0, which means the stack
> > will be set to tss->esp0.  The DPL of 3 means that the descriptor can
be
> > accessed from CPL3.  The text you mention generally means that the only
> > way to get back to CPL3 is with iret (via the saved %cs:%eip and
> > %ss:%esp pushed on the CPL0/1/2 stack).
> >
> > --
> >
> It is yes, not no.
>
> (1) User traps, CPL3, stack for trap is in CPL0.
> (2) CPL0 has stack-fault (bad ring zero code, bad memory).
> (3) CPL0 traps, using faulted stack, double fault.
> (4) There is no stack-trick, including a call-gate  to another
> "environment" (complete with its previously-reserved stack),
> that will ever get you back to (2), much less to (1).
>
> I am not denying the possibility of "warm-booting", i.e.,
> reloate some code to where there is a 1:1 physical to virtual
> translation, jump to the relocated code, disable paging, restart kernel
> code, and possibly examine what happened. You just have to get
> back to "flat-mode" with no paging to handle anything beyond a
> double fault. You are just not going to be able to restart
> from the stack-faulted code.
>
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).
>
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
