Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVGLTCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVGLTCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVGLTAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:00:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:10447 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262022AbVGLS56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:57:58 -0400
Date: Tue, 12 Jul 2005 14:57:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507122016.25877@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507121440020.6281-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Michel Bouissou wrote:

> I've booted with the patched kernel in the following way:
> 
> - BIOS option for mouse support still off ;
> 
> - Kernel commandline:
> kernel /vmlinuz-2.6.12-6mib7test root=/dev/evms/lv_racine ro 3 usb-handoff 
> devfs=nomount noquiet vga=791

Okay, good.

> - USB mouse plugged to what I believe to be the USB 2.0 controller (according 
> to the motherboard manual)
> 
> First thing I notice at boot is that "mouse doesn't work".

As I explained in the previous message, the mouse ends up being connected 
to a UHCI controller no matter what port you plug it in to.

> cat /proc/interrupts shows :
>            CPU0       
>   0:     208937    IO-APIC-edge  timer
>   1:        334    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   4:        464    IO-APIC-edge  serial
>   7:          3    IO-APIC-edge  parport0
>  14:       1321    IO-APIC-edge  ide4
>  15:       1330    IO-APIC-edge  ide5
>  18:        822   IO-APIC-level  eth0, eth1
>  19:      14157   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
>  21:      33962   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
>  22:          0   IO-APIC-level  VIA8233
> NMI:          0 
> LOC:     208855 
> ERR:          0
> MIS:          0

Interesting, isn't it?  Even though the UHCI controllers are unable to 
generate interrupts, you're still getting thousands of interrupts requests 
on IRQ 21.

> Looking at dmesg or /var/log/mesages shows a huge number of :
> Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.2: IRQ, status = 0
> Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.0: IRQ, status = 0
> Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.1: IRQ, status = 0
> Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.2: IRQ, status = 0
> 
> (3043 similar lines...)
> 
> ...immediately at startup, then it stops complaining
> 
> The interesting thing is that I unplugged my USB mouse at 19:45 -- nothing 
> happened, and plugged it back at 19:45:40, while looking at a "tail 
> -f /var/log/messages"
> 
> And see what happened in the attached copy of my /var/log/messages for this 
> session...
> 
> Doesn't mean anything to me ;-) but I hope it will be of some help for you...

Status = 0 means the UHCI controller has no reason to request an
interrupt.  Given the good record of your hardware in the past, this
probably means that the controllers really were not generating interrupt
requests.  The alternative is that one of them _is_ generating an IRQ when 
it's not supposed to -- this seems pretty unlikely.

On the other hand, _something_ was generating an interrupt request that 
got mapped to IRQ 21 by the hardware.  And these requests do seem to be 
associated with USB activity.  Maybe the EHCI controller is responsible?
One of your postings showed both uhci_hcd:usb2 and ehci_hcd:usb4 mapped to 
IRQ 11.  That could indicate a shared signal line, which is currently 
being mapped incorrectly.

You can test this a couple of ways.  The easiest is to rmmod ehci_hcd, or 
prevent it from being loaded in the first place, by renaming 
/lib/modules/.../drivers/usb/host/ehci_hcd.ko so that modprobe can't find 
it.  Also your BIOS may offer the option of disabling USB 2.0 support 
entirely.  Try doing this under the kernel that has the test patch 
installed.

Without ehci_hcd loaded, the EHCI controller should not generate any
interrupt requests.  If your problem then goes away, and plugging or
unplugging the mouse doesn't cause anything unusual to happen, that will
be a pretty clear indication.

Alan Stern

