Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWI2Xbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWI2Xbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWI2Xbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:31:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32224 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422644AbWI2Xbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:31:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Cc: "Sukadev Bhattiprolu" <sukadev@us.ibm.com>,
       "Auke Kok" <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: Network problem with 2.6.18-mm1 ?
References: <20060928013724.GA22898@us.ibm.com> <451B2D29.9040306@intel.com>
	<20060928185222.GB3352@us.ibm.com>
	<4807377b0609281410p28d445c8mc32e7d2cb71221ab@mail.gmail.com>
	<20060929005205.GA3876@us.ibm.com>
	<4807377b0609291108x84f39c6ic4c669fd91f8fcd4@mail.gmail.com>
Date: Fri, 29 Sep 2006 17:30:27 -0600
In-Reply-To: <4807377b0609291108x84f39c6ic4c669fd91f8fcd4@mail.gmail.com>
	(Jesse Brandeburg's message of "Fri, 29 Sep 2006 11:08:10 -0700")
Message-ID: <m1ejtui73g.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesse Brandeburg" <jesse.brandeburg@gmail.com> writes:

> On 9/28/06, Sukadev Bhattiprolu <sukadev@us.ibm.com> wrote:
>> $ cat /proc/interrupts
>>
>>            CPU0       CPU1
>>  28:          0          0   IO-APIC-fasteoi  eth0
>> NMI:         96         35
>> LOC:      18251      18524
>> ERR:          0
>
> you should be getting an interrupt every two seconds from the eth0
> (e1000) driver.  You are having interrupt delivery problems probably
> due to something screwing up interrupt routing in the kernel.
> Normally these issues are associated with MSI interrupts but your
> adapter doesn't support those and is using generic IRQ
>
> I'm guessing that if you somehow enable interrupts on your vga card on
> the same bus as e1000 (bus 3) it will have interrupt delivery problems
> as well.  Maybe try xorg?

To summarize.

We have an e1000 plugged into a pci-x slot on an Opteron system with
an amd chipset.

That motherboard has 3 ioapics.  (One on each PCI-X bridge and
one on the 8111 for handling everything else.

We know we are getting interrupts through the 8111 ioapic.

We don't know which ioapic the pci-x bus is hooked to.

So either the ioapics on the 8131 are having problems.
Or we have a problem parsing the irq routing tables.

We see in dmesg.
[    0.000000] I/O APIC #2 at 0xFEC00000.
[    0.000000] I/O APIC #3 at 0xE8000000.
[    0.000000] I/O APIC #4 at 0xE8001000.
...
[   97.410411] PCI: Cannot allocate resource region 0 of device 0000:00:0a.1
[   97.423945] PCI: Cannot allocate resource region 0 of device 0000:00:0b.1

We see in lspci
> 
> 0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> (prog-if 10 [IO-APIC])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at 88100000 (64-bit, non-prefetchable) [size=4K]
> 
> 0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> (prog-if 10 [IO-APIC])
> 	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at 88101000 (64-bit, non-prefetchable) [size=4K]

So it looks like the kernel moved the ioapics.

The following patch in 2.6.18-mm1 is known to have that effect.
x86_64-mm-insert-ioapics-and-local-apic-into-resource-map

Can you please try reverting that one patch?

There is a fix an updated version of that patch I think in -mm2
but I haven't had a chance to see if it fixes the problem yet.

Eric
