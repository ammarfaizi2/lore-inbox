Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVBWWaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVBWWaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVBWW2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:28:11 -0500
Received: from hyperion.affordablehost.com ([12.164.25.86]:44702 "EHLO
	hyperion.affordablehost.com") by vger.kernel.org with ESMTP
	id S261650AbVBWWNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:13:40 -0500
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
From: Alan Kilian <kilian@bobodyne.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
References: <1109190273.9116.307.camel@desk>
	 <Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 16:17:46 -0600
Message-Id: <1109197066.9116.319.camel@desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hyperion.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bobodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 23 Feb 2005, Dick Johnson wrote:
> 
>  	call	pci_enable_device(dev)
>  	... before you use the IRQ in dev->irq.
> 
>  	The reported IRQ is bogus until you make that
>  	call. It's a reported BUG, probably won't
>  	ever get fixed because it's considered a
>  	feature.
> 
>  	Also, make sure that your .config for the Dell looks
>  	something like:
> 
>  	CONFIG_X86_IO_APIC=y
>  	CONFIG_X86_LOCAL_APIC=y
>  	CONFIG_PCI=y
>  	# CONFIG_PCI_GOBIOS is not set
>  	# CONFIG_PCI_GODIRECT is not set
>  	CONFIG_PCI_GOANY=y
>  	CONFIG_PCI_BIOS=y
>  	CONFIG_PCI_DIRECT=y


    Dick,

	Thanks for the quick reply.

	1) I call pci_enable_device(dev) immediatly after I call
	   dev = pci_find_device(0x1492, PCI_ANY_ID, dev);

	2) I have verified all the CONFIG settings you suggested.

	Here is `cat /proc/interrupts` on my working dell:

          	 CPU0
  	  0:   16891629          XT-PIC  timer
  	  1:         10          XT-PIC  i8042
  	  2:          0          XT-PIC  cascade
  	  3:          2          XT-PIC  parport0
  	  5:        764          XT-PIC  sse
  	  7:        422          XT-PIC  ohci_hcd
  	  8:          1          XT-PIC  rtc
  	  9:          0          XT-PIC  acpi
 	 11:      35198          XT-PIC  eth0
 	 12:         66          XT-PIC  i8042
 	 14:      42769          XT-PIC  ide0
 	 15:     151569          XT-PIC  ide1
	NMI:          0
	ERR:          0

	My driver is called "sse" and is interrupting at IRQ #5

	Here is `cat /proc/interrupts` on my non-working Sun:

           	CPU0       CPU1
  	  0:    7302649    7417311    IO-APIC-edge  timer
  	  5:          0          0    IO-APIC-edge  sse
  	  8:          0          1    IO-APIC-edge  rtc
  	  9:          0          0   IO-APIC-level  acpi
 	 15:          1        478    IO-APIC-edge  ide1
	169:          0         30   IO-APIC-level  aic79xx
	177:      13991      18084   IO-APIC-level  aic79xx
	185:          0          3   IO-APIC-level  ehci_hcd
	193:          0         26   IO-APIC-level  ohci_hcd
	201:          0         21   IO-APIC-level  ohci_hcd
	209:     167119         87   IO-APIC-level  eth0
	NMI:          0          0
	LOC:   14719159   14719203
	ERR:          0
	MIS:          0

	It appears that the card is also interrupting at IRQ#5

	There is an interesting message on the Sun in /var/log/messages:

Feb 23 14:01:26 sunw1200z kernel: sse: no version magic, tainting
kernel.
Feb 23 14:01:26 sunw1200z kernel: SSE: Found a DeCypher card.
Feb 23 14:01:26 sunw1200z kernel: ACPI: PCI interrupt 0000:13:03.0[A] ->
GSI 36 (level, low) -> IRQ 217
Feb 23 14:01:26 sunw1200z kernel: interrupting on line 5
Feb 23 14:01:26 sunw1200z kernel: SSE: bar[0] From 0xd2806000 to
0xd2806fff F=0x200 MEMORY space
Feb 23 14:01:26 sunw1200z kernel: SSE: bar[1] From 0xd2800000 to
0xd2801fff F=0x200 MEMORY space
Feb 23 14:01:26 sunw1200z kernel: SSE: bar[2] From 0xd2000000 to
0xd27fffff F=0x200 MEMORY space
Feb 23 14:01:26 sunw1200z kernel: SSE: bar[0] mybase = 0xf889a000 size =
0x00001000 D'4096
Feb 23 14:01:26 sunw1200z kernel: SSE: bar[1] mybase = 0xf889c000 size =
0x00002000 D'8192
Feb 23 14:01:26 sunw1200z kernel: SSE: bar[2] mybase = 0xf8b00000 size =
0x00800000 D'8388608
Feb 23 14:01:26 sunw1200z kernel: pci_alloc_consistent returned
0xf0ded000
Feb 23 14:01:26 sunw1200z kernel: sse_read_bus_buffer 0x30ded000
Feb 23 14:01:26 sunw1200z kernel: request_irq() returned 0
Feb 23 14:01:26 sunw1200z kernel: SSE device_id 3, Rev 4
Feb 23 14:01:26 sunw1200z kernel: SSE Before: intstatus = 0x00000000
Feb 23 14:01:26 sunw1200z kernel: SSE Before: intstatus = 0x00000000
Feb 23 14:01:26 sunw1200z kernel: SSE: End of card attachment. Number of
cards = 1
Feb 23 14:01:26 sunw1200z kernel: Iterating through the softp
structures...
Feb 23 14:01:26 sunw1200z kernel: Card at softp->mem_reg1 0xf889a000
minor = 0


	The interesting bits seem to be these two lines:

	kernel: SSE: Found a DeCypher card.
	kernel: ACPI: PCI interrupt 0000:13:03.0[A] -> GSI 36 (level, low) ->
IRQ 217

	The first message is in my driver after pci_find_device()
	The second is from when I do pci_enable_device(dev);

	Can you decode the mysterious ACPI message?

			-Alan

-- 
- Alan Kilian <kilian(at)bobodyne.com>


