Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752207AbWCPHBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbWCPHBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWCPHBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:01:43 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:19460 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752206AbWCPHBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:01:42 -0500
Message-ID: <44190D04.4070204@vmware.com>
Date: Wed, 15 Mar 2006 23:00:20 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jack Lo <jlo@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Daniel Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Daniel Hecht <dhecht@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Eli Collins <ecollins@vmware.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Jyothy Reddy <jreddy@vmware.com>, Christopher Li <chrisl@vmware.com>,
       Chris Wright <chrisw@osdl.org>, Kip Macy <kmacy@fsmware.com>,
       Joshua LeVasseur <jtl@ira.uka.de>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 4
References: <4415CE1C.1060608@vmware.com> <20060315233703.GE1919@elf.ucw.cz>
In-Reply-To: <20060315233703.GE1919@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   
>>     6) Interrupts must always be enabled when running code in userspace.
>>     
>
> I'd say this breaks userspace.
>   

I agree.  My claim is that this is not an issue in a virtual machine.  
What possible reason can you have to disable interrupts in userspace?  
Well, several.  For one, the X server wants to disable interrupts 
temporarily during probing of dot clocks to get accurate timings, and 
also to avoid the kernel interrupting during a sensitive VGA register 
access.  Several other userspace programs, including CMOS time sync 
utilities do this as well.  I contend this is broken, even on native 
hardware, for two reasons.

1) The sensitive VGA register access argument is bogus.  There is 
already a kernel interface that is used by X11 to take control of video 
which lets the kernel know explicitly not to touch the VGA registers.  
The oddity is due to the fact that there are many write only registers, 
and thus, you can't track state of these without explicit handoff.  The 
same interface can be used to avoid these sensitive accesses.

2) Timing dot clocks by disabling interrupts is still broken and subject 
to random variance.  Chipsets which support system management modes can 
cause the processor to enter SMM mode at any time, even when interrupts 
are disabled and NMIs are masked.  This is deliberately hidden from the 
running code, but it does cause time to elapse, which is visible via the 
TSC and all hardware time counters.  Therefore, you can never get an 
accurate timing in one iteration, and using multiple iterations allows 
you to effectively deal with the same issues you would have if you left 
interrupts enabled.

> This code used to work when ran as root:
>
> void
> main(void)
> {
>         int i;
>         iopl(3);
>         while (1) {
>                 asm volatile("cli");
>                 //              for (i=0; i<20000000; i++)
>                 for (i=0; i<1000000000; i++)
>                         asm volatile("");
>                 asm volatile("sti");
>                 sleep(1);
>         }
> }
>
> ...and was actually useful.
>   

The code you show above can be made to work in a virtual machine, and 
you can allow userspace to disable interrupts and still have a perfectly 
fine solution -- if you restrict the enabling and disabling of 
interrupts in userspace to the cli and sti instructions.  But it does 
not work if you start using nested interrupt control, using pushf and popf.

The virtual machine monitor must always leave hardware interrupts 
enabled, since it must service them without allowing the guest VM to 
interfere.  As such, the actual state of the hardware interrupt flag is 
visible to userspace programs.  CLI and STI get away with this, because 
they are privileged instructions, and as such, they trap when IOPL is 
not present.  But PUSHF and POPF do not.  A POPF instruction which 
changes the interrupt flag behaves differently, depending on the IOPL 
state.  When IOPL is not present, and the POPF would change the state of 
the interrupt flag - nothing happens.  The interrupt flag is not 
changed, but most importantly, it is not a privileged instruction, so it 
does not trap.

Therefore, this instruction is non-virtualizable.  You can not run it 
directly in a virtual machine - you must simulate it.  To simulate it 
requires either straightforward interpretation, hardware virtualization, 
or binary translation.  Therein lies the crux of the problem.  While you 
can allow userspace to enable and disable interrupts using CLI and STI, 
you have no way to simulate its use of the POPF instruction unless you 
use one of these technologies.  This is why we disallow all toggling of 
the interrupt flag from userspace, since one of the design goals of 
paravirtualization is not to change userspace code.

Combined with the above argument that enabling / disabling is really not 
useful for userspace in a virtual machine, we have found that if you 
just completely disallow IOPL'ed userspace to enable and disable 
interrupts, _but_ never issue faults to it if it tries, everything just 
works.  The alternative allows you to get in a state where you can end 
up in a non-virtualizable userspace scenario, which is highly undesirable.

>   
>>     7) IOPL semantics for userspace are changed; although userspace may be
>>        granted port access, it can not affect the interrupt flag.
>>     
See above for the impact on X.  X11 runs perfectly fine in our 
paravirtual VMM.

Nit:  Dropping cc'd persons is probably not a good thing.  Some of the 
people here don't subscribe to LKML in full, and would still like to be 
copied on these messages.  No offense meant or taken.

Zach
