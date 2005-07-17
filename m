Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVGQVUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVGQVUh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 17:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVGQVUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 17:20:37 -0400
Received: from totor.bouissou.net ([82.67.27.165]:4031 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261399AbVGQVUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 17:20:32 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.44L0.0507171606320.30920-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507171606320.30920-100000@netrider.rowland.org>
Cc: bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org, Mathieu.Berard@crans.org
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 17 Jul 2005 23:20:25 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200507172320.26156@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Dimanche 17 Juillet 2005 22:36, vous avez écrit :
> Determining whether or not the system is working shouldn't be hit-or-miss.

Hum, yes, we're not using Windows ;-)

> To start out, try to determine whether each of the UHCI controllers really
> is mapped to IRQ 21.  Do this by booting with no USB devices plugged in,
> and then plugging a full- or low-speed device (like a USB mouse) into each
> of the ports in turn.  Check to make sure it works in each port and that
> that counts for IRQ 21 in /proc/interrupts increase each time.  To make
> this even more reliable you should run the test twice -- you don't have to
> reboot in between.  The first time, rmmod ehci-hcd before plugging in
> anything; the second time modprobe ehci-hcd before plugging.

I'm afraid I won't have time for this today. It's already more than 11 PM here 
and I'm leaving early tomorrow for travel...

But AFAIR, when I performed previous tests, I had tried about every USB socket 
on my computer (I have 6 of them...) to the same result.

> The results you have reported make me a little suspicious.  The best way
> to see whether the EHCI controller really is at fault is to plug in a
> high-speed USB device.  I'm not totally familiar with the operation of
> ehci-hcd, and it's quite possible that plugging in a low- or full-speed
> device would not cause it to generate enough interrupts to be a problem --
> even though you did trigger the fault by plugging in a low-speed mouse --
> but plugging in a high-speed device ought to, provided ehci-hcd is loaded.
>   Again, monitor the numbers in /proc/interrupts to see which is going up:
> IRQ 19 or IRQ 21.

Humm. I'm not sure about what you call a "full speed" device, for when I plug 
my USB scanner, my kernel reports it as a "full speed" USB device, and says 
it's managed by uhci (not ehci):

Jul 17 22:46:42 totor kernel: usb 3-2: new full speed USB device using 
uhci_hcd and address 3

I just tried an USB flashdisk that "used to work good with 2.4" and that I 
hadn't tried yet in 2.6. It's identified as "high speed" and ehci would like 
to manage it, but it seems I'm out of luck in some other aspect:

totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address 25
totor kernel: usb 4-4: device not accepting address 25, error -71
totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address 35
totor kernel: usb 4-4: device not accepting address 35, error -71
totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address 36
totor kernel: usb 4-4: device not accepting address 36, error -71
totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address 38
totor kernel: usb 4-4: device not accepting address 38, error -71
totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address 48
totor kernel: usb 4-4: device not accepting address 48, error -71

...ad nauseam until I unplug the key...

Shhh... 

Doesn't like the front panel socket ? Let me try another USB socket... Just 
close to my mouse...

totor kernel: usb 4-2: new high speed USB device using ehci_hcd and address 16
totor kernel: SCSI subsystem initialized
totor kernel: Initializing USB Mass Storage driver...
totor kernel: scsi0 : SCSI emulation for USB Mass Storage devices
totor kernel: usbcore: registered new driver usb-storage
totor kernel: USB Mass Storage support registered.

Looks better, isn't it ?

Now, I checked that I can mount it and see its contents. That's OK.

I'm currently running with IO-APIC disabled, so my interrupts shows as:
[root@totor etc]# cat /proc/interrupts
           CPU0
  0:   12540579          XT-PIC  timer
  1:      22352          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:      38647          XT-PIC  serial
  7:      18470          XT-PIC  parport0
 10:     863039          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, 
eth0, eth1, VIA8233, nvidia
 11:     155832          XT-PIC  ide0, ide1, ide2, ide3, ehci_hcd:usb4
 14:     112325          XT-PIC  ide4
 15:     112334          XT-PIC  ide5
NMI:          0
LOC:   12539533
ERR:        350


> The instability you mention is another cause for concern.  It may indicate
> that at some times, or under certain circumstances, the IRQs are routed
> wrongly whereas at others they are routed correctly.  And without any
> changes to the software!  If this is a random hardware fault it may be
> impossible to fix.  (But then why would it be so reliable under 2.4?)

I know that what I'm going to write will look crazy ;-) because it doesn't 
seem to make any sense, but I've noticed a pattern that tends to emerge from 
the different tests I've made with IO-APIC enabled and different 2.6.12 
kernels (patches, boot options, etc...) :

1/ When I'm testing a new kernel for the first time, I usually call it 
manually by typing the different relevant option manually from my grub 
(bootloader) commandline, and most of the times, it works without "losing IRQ 
21".
That's why I had thought, with your first suggestion of "usb-handoff" option, 
that my problem was solved.

Once I believe it works and want to test it again, I then put this as the 
default entry in my bootloader, then I reboot without touching anything (I 
let the bootloader select its default entry), and, usually, it then fails.

So I would say that a patterns looks emerging : When I have typed things on 
the keyboard at the bootloader stage, then loaded Linux, it may work. On the 
contrary, when I let the machine boot by itself without having touched 
anything, then I usually get these IRQ 21 losses.

Yes, I know this look completely silly ;-) but I mentioned it to be as 
complete as possible about what I noticed, and that may or may not be 
relevant...

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
