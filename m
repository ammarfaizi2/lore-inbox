Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261953AbSI3HtO>; Mon, 30 Sep 2002 03:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261957AbSI3HtO>; Mon, 30 Sep 2002 03:49:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30991 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261953AbSI3HtK>; Mon, 30 Sep 2002 03:49:10 -0400
Message-Id: <200209300739.g8U7d0p18183@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DragonK <dragon_krome@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.x Kernel Bug - Problem NOT found, but found workaround
Date: Mon, 30 Sep 2002 10:33:03 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020927215802.19246.qmail@web20309.mail.yahoo.com>
In-Reply-To: <20020927215802.19246.qmail@web20309.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I followed your suggestion and tried to find where
> exactly did the kernel
> hang, by using an infinite loop and blinking floppy
> LED (sorry, the kbd leds
> didn't work, except in DOS).
>     I ended up in protected mode, in
> [arch/i386/kernel/head.S] where I managed
> to find a SOLUTION for the problem (HAVEN'T FOUND THE
> PROBLEM (I THINK)).

Wow! :-) Thank you for going that far!

> Here is the modification I've made (sorry for not
> sending a diff, I've lost the
> original file :P )
>
> This is from KERNEL 2.4.18
>
> -------------(arch/i386/kernel/head.S)----------------------
>         xorl %eax,%eax                  # call CPUID 0 (vendor ID)
>         cpuid
>         movl %eax,X86_CPUID             # save CPUID level
>         movl %ebx,X86_VENDOR_ID         # lo 4 chars
>         movl %edx,X86_VENDOR_ID+4       # next 4 chars
>         movl %ecx,X86_VENDOR_ID+8       # last 4 chars
>
>         orl %eax,%eax           # do we have processor info as well?
>         je is486
>
> #       movl $1,%eax            # Use the CPUID instruction to get CPU type
> #       cpuid                   # <- This CPUID thing hangs the machine
> # With it, there's a lock, without it, a reboot :(
> # I've noticed that this code is the same in 2.2.20 kernel,
> # which works perfectly!!!=20

This is very weird. It means that your CPU executes CPUID level 0
and reports that it is capable of CPUID level 1, but it hangs
trying to execute CPUID level 1! Can you try to execute CPUID 1
in DOS? In usermode under 2.2?

WRT 2.2, I have no 2.2 source at hand but my guess it does not use
CPUID at least for your CPU. It would be interesting to check this...
can you compile 2.2 kernel with debugging check just after
level 1 CPUID? Maybe 2.2 skips that branch?

> #       movb %al,%cl            # save reg for future use
> #       andb $0x0f,%ah          # mask processor family
> #       movb %ah,X86
> #       andb $0xf0,%al          # mask model
> #       shrb $4,%al
> #       movb %al,X86_MODEL
> #       andb $0x0f,%cl          # mask mask revision
> #       movb %cl,X86_MASK
> #       movl %edx,X86_CAPABILITY
>
>         movb    $4, %al         #
>         movb    %al, X86_MODEL  #
>         movb    $5, %al         # Hardcoded the CPUID results=20
>         movb    %al, X86        # and... the kernel works fine!
>         movb    $2, %al         #
>         movb    %al, X86_MASK   #
> is486:

I recall some Cyrixes needs some magic to enable CPUID...
This is an exerpt from one of Cyrix686/686MX PDFs:
--------------------------------------------------
Access to the configuration registers is achieved
by writing the register index number for the
configuration register to I/O port 22h. I/O port
23h is then used for data transfer.

Each I/O port 23h data transfer must be preceded
by a valid I/O port 22h register index
selection. Otherwise, the current 22h, and the
second and later I/O port 23h operations com-municate
through the I/O port to produce
external I/O cycles. All reads from I/O port 22h
produce external I/O cycles. Accesses that hit
within the on-chip configuration registers do
not generate external I/O cycles.

After reset, configuration registers with indexes
C0-CFh and FC-FFh are accessible. To prevent
potential conflicts with other devices which
may use ports 22 and 23h to access their regis-ters,
the remaining registers (indexes D0-FBh)
are accessible only if the MAPEN(3-0) bits in
CCR3 are set to 1h. See Figure 2-16 (Page
2-29) for more information on the
MAPEN(3-0) bit locations.

name                         ind MAPEN?
---------------------------- --- ------
Configuration Control 0 CCR0 C0h x
Configuration Control 1 CCR1 C1h x
Configuration Control 2 CCR2 C2h x
Configuration Control 3 CCR3 C3h x
Configuration Control 4 CCR4 E8h 1
Configuration Control 5 CCR5 E9h 1
Configuration Control 6 CCR6 EAh 1

MAPEN3 MAPEN2 MAPEN1 MAPEN0 Reserved LINBRST NMI_EN SMI_LOCK
Figure 2-16. 6x86MX Configuration Control Register 3 (CCR3)

7-4 MAPEN(3-0) MAP Enable
	1h: All configuration registers are accessible.
	0h: Only configuration registers with indexes C0-CFh,
	    FEh and FFh are accessible.

CPUID Reserved Reserved Reserved Reserved IORT2 IORT1 IORT
Figure 2-17. 6x86MX Configuration Control Register 4 (CCR4)

7 CPUID Enable CPUID instruction.
	1: the ID bit in the EFLAGS register can be modified
	   and execution of the CPUID instruction occurs as
	   documented in section 6.3. 
	0: the ID bit in the EFLAGS register can not be modified
	   and execution of the CPUID instruction causes
	   an invalid opcode exception.
--
vda
