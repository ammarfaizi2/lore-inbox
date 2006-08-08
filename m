Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWHHPCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWHHPCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWHHPCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:02:43 -0400
Received: from exchfenlb-2.cs.cornell.edu ([128.84.97.34]:56244 "EHLO
	exchfe2.cs.cornell.edu") by vger.kernel.org with ESMTP
	id S964892AbWHHPCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:02:42 -0400
Message-ID: <44D8A80F.1020202@cs.cornell.edu>
Date: Tue, 08 Aug 2006 11:04:47 -0400
From: Alan Shieh <ashieh@cs.cornell.edu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Rodrick <daniel.rodrick@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>	 <44D7579D.1040303@zytor.com>	 <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>	 <44D76F26.9@zytor.com> <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>
In-Reply-To: <292693080608072213n2be75176g46199e92d669f5de@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2006 15:02:40.0429 (UTC) FILETIME=[B1821DD0:01C6BAFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unfoDaniel Rodrick wrote:
>> >
>> > I'm sure having a single driver for all the NICs is a feature cool
>> > enough to die for. Yes, it might have drawbacks like just pointed out
>> > by Peter, but surely a "single driver for all NIC" feature could prove
>> > to be great in some systems.
>> >
>>
>> Assuming it works, which is questionable in my opinion.
>>
>> > But since it does not already exist in the kernel, there must be some
>> > technical feasibility isse. Any ideas on this?
>>
>> No, that's not the reason.  The Intel code was ugly, and the limitations
>> made other people not want to spend any time hacking on it.
>>
> 
> Hi ... so there seem to be no technical feasibily issues, just
> reliabliy / ugly design issues? So one can still go ahead and write a
> Universal Protocol Driver that can work with all (PXE compatible)
> NICs?

With help from the Etherboot Project, I've recently implemented such a 
driver for Etherboot 5.4. It currently supports PIO NICs (e.g. cards 
that use in*/out* to interface with CPU). It's currently available in a 
branch, and will be merged into the trunk by the Etherboot project. It 
works reliably with QEMU + PXELINUX, with the virtual ne2k-pci NIC.

Barring unforseen issues, I should get MMIO to work soon; target 
platform would be pcnet32 or e1000 on VMware, booted with PXELINUX.

I doubt the viability of implementing an UNDI driver that works with all 
PXE stacks in existence without dirty tricks, as PXE / UNDI lack some 
important functionality; I'll summarize some of the issues below.

> Are there any issues related to real mode / protected mode?

Yes, lots.

At minimum, one needs to be able to probe for !PXE presence, which means 
you need to map in 0-1MB of physical memory. The PXE stack's memory also 
needs to be mapped in. My UNDI driver relies on a kernel module, generic 
across all NICs, to accomplish these by mapping in the !PXE probe area 
and PXE memory in a user process.

The PXE specification is very hazy about protected mode operation. In 
principal, PXE stacks are supposed to support UNDI invocation from 
either 16:16 or 16:32 protected mode. I doubt the average stack was 
ever extensively tested from 32-bit code, as the vast majority of UNDI 
clients execute in real mode or V8086 mode.

I encountered several some protected mode issues with Etherboot, some of 
which most likely come up in manufacturer PXE stacks due to similar 
historical influences. I happen to prefer Etherboot stacks over 
manufacturer stacks -- as its OSS, you can fix the bugs, and change the 
UI / timeouts, etc. to work better for your environment:

* Some code did not execute cleanly in CPL3 (e.g., the console print 
code issues privileged instructions)
* Far pointers interpreted as Real mode, rather than 16:16 protected 
mode. This doesn't matter for real mode execution. Many occurances of 
far pointers in the PXE spec are a bad idea, see below.
* Etherboot keeps itself resident in memory after kernel loads, and 
munges the E820 map to discourage the kernel from messing with it. Other 
stacks may not be so smart.

I was able to fix these minor problems with Etherboot with relative ease 
because I had the source. I could also extend the PXE interface and 
conveniently ignore idiosyncracies in the PXE spec.

This is harder with a closed-source stack. In my opinion, the best way 
to reliably run a closed-source, manufacturer PXE stack would be to suck 
it into a virtualization process, like QEMU, virtualize away all of the 
ugly CPL0 and real-mode liberties taken by the code, and talk to it with 
a small real-mode stub within the VM. The virtualization would need to 
shunt PIO and MMIO to the real hardware, and maybe re-export PCI 
configuration space.

( An even easier way would be to axe the manufacturer's stack and use 
Etherboot instead )

PXE is also missing some functionality. Some of this can be worked 
around with ugly hacks, others are a deal-breaker.

* PXE reports its memory segments using a maximum of 16 bits for segment 
length.  The segment length is necessary for loading PXE stack into 
virtual address space.

It is possible to work around this with an E820 trick -- find the 
segment base, which is 32 bit, and then find a E820 hole that contains 
it. Unfortunately, e820map is not exported to Linux modules by the kernel.

16-bits is a really tiny amount of memory, especially if one wants to 
use the same segments for code & data. Etherboot easily overflows this 
when uncompressed.

* UNDI transmit descriptors point to packet chunks 16:16 pointers. This 
is fine if the PXE stack will copy data from those chunks into a fixed 
packet buffer. There are several ways for things to go horribly wrong if 
the stack attempts to DMA (I believe it is actually impossible to do 
this correctly from CPL3 if arbitrary segmentation & paging are in 
effect). There is a provision in my copy of the UNDI spec for physical 
addresses, which is a lot more robust in a protected mode world, but the 
spec says "not supported in this version of PXE", which means a lot of 
stacks you encounter in the wild will not support this.

This can be worked around by making conservative assumptions, e.g. 
ensuring that virtual address == physical address for all regions you 
pass down to the card, and the selector you use happens to emulate the 
semantics of a real-mode pointer.

* PXE will need access to the PCI memory mapped region for MMIO NICs. 
(With PIO, you just need to set IOPL(3) to give your driver process free 
reign over I/O port space). The physical addresses of the PCI devices 
are usually really high up in memory. The Linux kernel takes over this 
address space, as it owns everything from 0xc0000000 and up, and most, 
if not all, of this address range needs to be invariant between 
different process address spaces.

With the help of the kernel module, the user process can just  remap 
those physical addresses to a different area. Unfortunately, PXE doesn't 
have an interface for reprogramming it with the new MMIO location.
--
Alan Shieh
PhD Student, Computer Science
331 Upson Hall
Ithaca, NY 14853
