Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVA2UnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVA2UnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVA2UnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:43:07 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:12177 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261557AbVA2UmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:42:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=WnFGppDKz3Ldf2qad7ZP99TossFQCAcdS6w1I3Irm6hJZZo3XcunkuSEQ8RHbaxSXapqVkn0+1av+n3KBNE+3eOBE25EVXqcWWZ2I+9WkAVp6MhpLYUMwSamgHY0Fx23HE9uU92xcWeVOl/y7+yR1VkoBpBVe+bIHofkbjYIJC8=
Message-ID: <1295c7b005012912423352cd9d@mail.gmail.com>
Date: Sat, 29 Jan 2005 12:42:17 -0800
From: Mike Cumings <mcumings@gmail.com>
Reply-To: Mike Cumings <mcumings@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Yenta CardBus IRQ storm disabling interrupt
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day gurus,

I've got an IRQ storm resulting in a useless CardBus bridge that I am having
a hard time debugging.  I've seen this on 2.6.9, 2.6.10, and 2.6.11-rc2 which is
what I'm currently testing against.

For some reason I'm getting an IRQ storm when attempting to use a TI1225
CardBus bridge (Yenta-compatible).  Oddly enough, the storm happens more 
frequently with one PCCard than another in my possession, but both have 
encountered the infamous "Disabling IRQ #??" (in my case, IRQ 11).

In my Googling, I encountered a thread on January 10th of this year entitled
"yenta_socket rapid fires interrupts" (between Dick Hollenbeck, Linus,
and others)
which describes the same fail mode, but for a different TI card.  It
doesnt appear
in that thread that there was any resolution.  I'd like to help change that if
possible! ;)  I ended up adding a good amount of verbosity to the yenta_socket.c
file in an effort to figure out what is going on, but the TI bridge
appears to be
operating fine from what I can tell.  Here is a dmesg snippet of a failure:

...
Yenta: Begin yenta_probe
Yenta: Enabing PCI Device
PCI: 0000:00:04.0 has unsupported PM cap regs version (1)
PCI: Current state: (4)
PCI: Desired state: (0)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: Request Regions
Yenta: Start Resource
Yenta: Map regs and request IRQ
Yenta: CardBus bridge found at 0000:00:04.0 [1028:009e]
Yenta: Config init
Yenta: Diable events
Yenta: Setup bridge regions
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.0, mfunc 0x01021c72, devctl 0x66
Yenta TI: pre intctl=50
Yenta TI: post intctl=50
Yenta: Bridge control pre =05c0
Yenta: Bridge control post=0540
Yenta: Requesting IRQ: b
Yenta: Generating interrupt
Yenta: Probe handler: cb_event=00000001
Yenta: Probe handler:      CSC=00
Yenta: Disabling interrupts
Yenta: CSC: 0
Yenta: Returning socket status: 1
Yenta: Finish init
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
Yenta: Register with PCMCIA layer
Yenta: Begin yenta_probe
Yenta: Enabing PCI Device
PCI: 0000:00:04.1 has unsupported PM cap regs version (1)
PCI: Current state: (4)
PCI: Desired state: (0)
Yenta: Request Regions
Yenta: Start Resource
Yenta: Map regs and request IRQ
Yenta: CardBus bridge found at 0000:00:04.1 [1028:009e]
Yenta: Config init
Yenta: Diable events
Yenta: Setup bridge regions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:04.1, mfunc 0x01021c72, devctl 0x66
Yenta: Bridge control pre =0580
Yenta: Bridge control post=0500
Yenta: Requesting IRQ: b
Yenta: Generating interrupt
Yenta: Storm#=01/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Probe handler: cb_event=00000001
Yenta: Probe handler:      CSC=00
Yenta: Disabling interrupts
Yenta: CSC: 0
Yenta: Returning socket status: 1
Yenta: Finish init
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000069
Yenta: Register with PCMCIA layer
...
Yenta: Storm#=02/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=03/25 event=00000006 state=30000026 csc=08 intctl=50
Yenta: Resetting storm counter
Yenta: Storm#=01/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=02/25 event=00000004 state=30000082 csc=00 intctl=50
Yenta: Resetting storm counter
Yenta: Storm#=01/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=02/25 event=00000004 state=30000086 csc=00 intctl=50
Yenta: Resetting storm counter
Yenta: Storm#=01/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=02/25 event=00000006 state=30000820 csc=08 intctl=50
Yenta: Resetting storm counter
Yenta: Storm#=01/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=02/25 event=00000008 state=30000829 csc=00 intctl=50
Yenta: Storm#=03/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=04/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=05/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=06/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=07/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=08/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=09/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=10/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=11/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=11/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=12/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=13/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=14/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=15/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=16/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=17/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=18/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=19/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=20/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=21/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=22/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=23/25 event=00000000 state=30000006 csc=00 intctl=50
Yenta: Storm#=24/25 event=00000000 state=30000829 csc=00 intctl=50
Yenta: Storm#=25/25 event=00000000 state=30000006 csc=00 intctl=50
irq 11: nobody cared!
 [<c01354aa>] __report_bad_irq+0x2a/0x90
 [<c0134dd9>] handle_IRQ_event+0x39/0x70
 [<c01355d3>] note_interrupt+0xa3/0xd0
 [<c0134f71>] __do_IRQ+0x161/0x180
 [<c0104cc9>] do_IRQ+0x19/0x30
 [<c0103306>] common_interrupt+0x1a/0x20
 [<c011c3ee>] __do_softirq+0x2e/0xa0
 [<c011c486>] do_softirq+0x26/0x30
 [<c011c545>] irq_exit+0x35/0x40
 [<c0104cce>] do_IRQ+0x1e/0x30
 [<c0103306>] common_interrupt+0x1a/0x20
 [<c0201c4f>] acpi_processor_idle+0xf0/0x229
 [<c01010e4>] cpu_idle+0x44/0x60
 [<c041a79e>] start_kernel+0x14e/0x170
 [<c041a330>] unknown_bootoption+0x0/0x1e0
handlers:
[<c0284060>] (yenta_interrupt+0x0/0x40)
[<c0284060>] (yenta_interrupt+0x0/0x40)
Disabling IRQ #11


In the above output, the "Yenta: Storm" lines are displayed by the
yenta_interrupt function whenever it is called, but limits it's output
to the first 25 unhandled interrupts in the sequence.  As soon as
an interrupt is handled, the tally is reset.

The alternation in the state register display is due to the fact that
each slots' handler is called for each interrupt.  For reference,
here is a breakdown of the state register values minus the slot
capability information in the first octets:

3000 0006:  CDETECT1, CDETECT2
3000 0026:  CardBus detected, CDETECT1, CDETECT2
3000 0082:  Not a Card, CDETECT1
3000 0086:  Not a Card, CDETECT1
3000 0820:  3V Card Inserted, CardBus detected
3000 0829:  3V Card inserted, CardBus detected, Power applied,
            Card status changed (CSTSCHG)

And the event register values:
0000 0006:  CDETECT1 Changed, CDETECT2 Changed
0000 0004:  CDETECT2 Changed
0000 0008:  Power status changed

Complete dmesg output and modified yenta_socket.c used to
generate this output can be found at:
http://www.scummer.org/linux/

The above dmesg snippet came from "fail.1".  For in-depth
yenta_socket debugging, take a look at "fail.5" which includes
all register get/set traffic as well.

TI1225 specs can be found at:
http://focus.ti.com/lit/ds/symlink/pci1225.pdf

Other pieces of information which may help:
o The storm has also been observed while yenta_socket
   is probing the IRQ prior to any card insertion or removal
   events.
o I've tried SMP and UP kernels, completely removed ACPI
   and APM from the kernel, and have tried various other
   configuration changes.  Removing ACPI initially got things
   up and running again, but after a couple days/reboots it
   reverted back to consistent failures.
o The stack traces are not always consistent as far as
   source of the call is concerned, though with my current
   build the storm is almost always initiated via
   acpi_processor_idle.
o This cardbus bridge uses PCI power management spec
   1.0 (reg value 1).  I noticed a warning saying that this
   version was not supported.  Looking into pci.c I found that
   pci_set_power_state will only operate against PCI
   power management spec 1.2.  That seemed odd considering
   the TI device was trying to move from power state 4 to 0
   (off to on), so I hacked it to see if allowing target state D0
   for older PCI PM versions would make a difference.  It didnt.

I started trying to back trace the origin of the interrupts in
an attempt to figure out what the source was, but I ended
up running into some assembly and figured I was in over
my head. :P

Is there any way that another subsystem would be generating
there IRQ storms?  Anything to recommend that I try?  Until
fixed my laptop must be wired to the wall.  :(

Thanks in advance,

-- 
Mike Cumings
