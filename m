Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290750AbSARRCv>; Fri, 18 Jan 2002 12:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290740AbSARRCm>; Fri, 18 Jan 2002 12:02:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8832 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290750AbSARRCb>; Fri, 18 Jan 2002 12:02:31 -0500
Date: Fri, 18 Jan 2002 12:02:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Raman S <raman_s_@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: int 0x40
In-Reply-To: <F49lHiu3fQtYdVzDpub0001e2cc@hotmail.com>
Message-ID: <Pine.LNX.3.95.1020118113841.960A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Raman S wrote:

> Hi,
>   I relatively new to the kernel and am trying to understand how the linux 
> kernel handles interrupts. For this I attempted to
> create an int 0x40 by adding a set_system_gate(64, &system_call) in traps.c. 
> I verfied by giving out print statements within set_system_gate that 64 is 
> being set during initialization (though it isnt a surprise that it is being 
> set).  But when i give an int 0x40 in a user level assembly program I get 
> segmentation fault, (a SIGSEGV signal is sent to the process).  I have tried 
> adding another function in entry.S called my_system_call and reproducing the 
> code in system_call with a jmp ret_from_sys_call  at the end. Also tried 
> giving an empty C function for my_system_call all with the same result.
> 

As you no-doubt know, any 'int' instruction from user-world is
invalid and will cause a trap. So, you can make a trap-handler
and have it do something useful. To have the trap handler get
control, rather than the illegal-instruction trap, you need an
entry in the IDT (interrupt descriptor table). I don't know
which system procedure (if any) will make this entry for you.
You can see how the initial interrupt(s) are set up, make an
entry and then remember to `lidt` load the new IDT.

> My assembly prints out hello world, from the linux assembly how to, 
> reproduced here
> If i replace int 0x80 with my int 0x40 I end up with a segmentation fault. 
> Is there any thing other than set_system_gate and writing the my_system_call 
> handler, that i need to do to have a successful int 0x40? I had tried
>    a) commenting out just the deference of the system handler function 
> within system_call (call *sys_call_table(0, %eax, 4) )
>    b) using &system_call itself in set_system_gate
>   but still the same situation.
> 
> Any suggestions will be appreciated.
> 
> Thanks
> Raman
> 

[SNIPPED assembly...]

In principle, one should be able to nest software interrupts, DOS
did it all the time. However, I fear that executing interrupt 0x80
from within interrupt 0x40 may be interpreted by other kernel code
as "bad". You might get a "Eieee scheduling in an interrupt!" panic.

I would suggest that you execute the sys-calls directly, not through
int 0x80, within your code. This will prevent this problem. It is
also faster. Since a user-mode interrupt is really just a 'call',
'current' should still be valid for I/O.

The kernel was not designed for user-mode software interrupts so you
might find other problems. My question is why you would actually want
one? If you need another function, just add it. If you need something
else, make a module.

Note that a hardware interrupt will never execute a user-mode
interrupt service routine unless you make a kernel-mode ISR that
somehow calls a user-mode routine....and, although that's possible
by using some clever tricks, it's kinda dumb.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


