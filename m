Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTLFBwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTLFBwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:52:47 -0500
Received: from legolas.restena.lu ([158.64.1.34]:45023 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263868AbTLFBwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:52:43 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1070672114.2759.8.camel@big.pomac.com>
References: <1070672114.2759.8.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1070675560.4117.9.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 02:52:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.. I decided I would try the patch out.. here are the results:

Interrupts before patch: (booted with nmi-watchdog=2)

           CPU0
  0:    2863919          XT-PIC  timer
  1:       7851    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
12:     104453    IO-APIC-edge  i8042
14:      26951    IO-APIC-edge  ide0
15:       8490    IO-APIC-edge  ide1
19:     211976   IO-APIC-level  radeon@PCI:3:0:0
21:      17303   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
22:          3   IO-APIC-level  ohci1394
NMI:          0
LOC:    2863756
ERR:          0
MIS:          0


Interrupts after patch: (booted with nmi-watchdog=2)
           CPU0
  0:     435688    IO-APIC-edge  timer
  1:       2714    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
12:       5490    IO-APIC-edge  i8042
14:      16831    IO-APIC-edge  ide0
15:        392    IO-APIC-edge  ide1
19:       9931   IO-APIC-level  radeon@PCI:3:0:0
21:       3980   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
22:          3   IO-APIC-level  ohci1394
NMI:          0
LOC:     435246
ERR:          0
MIS:          0

All the interrupts are the same...except:
0, timer is now IO-APIC-edge.

Im not getting any NMI counts.. should I use nmi-watchdog=1?


dmesg differences:

1.
after:
..TIMER: vector=0x31 pin1=2 pin2=0

before:
..TIMER: vector=0x31 pin1=2 pin2=-1

2.
after:
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 16.

before:
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
number of MP IRQ sources: 15.


Ian, from looking back, you have an A7N8X-X bios 1007.
Interesting that my USB hcis are still sharing IRQs there.
Any idea how I can get them apart, or if I should try.
My system was pretty stable as I've stated.. but the patch has changed
things slightly re the timer.

I've run hdparm about 25 times... and as its almost 3am I'm going to let
this thing idle for a few hours like this.

Craig






On Sat, 2003-12-06 at 01:55, Ian Kumlien wrote: 
> Craig Bradney wrote:
> > Sounds great.. maybe you have come across something. Yes, the CPU
> > Disconnect function arrived in your BIOS in revision of 2003/03/27
> > "6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset
> > does not support C2 disconnect; thus, disable C2 function."
> 
> I doubt thats related, i run ACPI with powersave anyways... 
> 
> > For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can
> > see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS
> > that has been discussed.
> 
> I don't have it either... 
> 
> I'm more hopeful about the patch from Mathieu <cheuche+lkml () free ! fr>...
> 
>            CPU0
>   0:     267486    IO-APIC-edge  timer
>   1:       9654    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:      28252    IO-APIC-edge  ide0
>  15:        103    IO-APIC-edge  ide1
>  16:     251712   IO-APIC-level  eth0
>  17:      90632   IO-APIC-level  EMU10K1
>  19:     415529   IO-APIC-level  nvidia
>  20:          0   IO-APIC-level  usb-ohci
>  21:        153   IO-APIC-level  ehci_hcd
>  22:      58257   IO-APIC-level  usb-ohci
> NMI:        479
> LOC:     265875
> ERR:          0
> MIS:          0
> 
> this far and it feels like a closer match to what windows does from what
> i have read on the ml. 
> 
> I haven't even come close to testing this yet, I've only been up 45 mins
> but i'll leave it running and do what i usually do when it hangs... =)
> 
> I'll get back to you about how it goes... 

