Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUJWRMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUJWRMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUJWRMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:12:00 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:26337 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261257AbUJWRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:11:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Date: Sat, 23 Oct 2004 19:13:08 +0200
User-Agent: KMail/1.6.2
References: <200410222354.44563.rjw@sisk.pl> <20041022162656.2f9ca653.akpm@osdl.org>
In-Reply-To: <20041022162656.2f9ca653.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410231913.08520.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 of October 2004 01:26, you wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Hi,
> > 
> > I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely, 
after 
> > some time in X, USB suddenly stops working and sound goes off 
simultaneously 
> > (it's quite annoying, as I use a USB mouse ;-)).  It is 100% reproducible 
and 
> > it may be related to the sharing of IRQ 5:
> > 
> > rafael@albercik:~> cat /proc/interrupts
> >            CPU0
> >   0:    3499292          XT-PIC  timer
> >   1:       7135          XT-PIC  i8042
> >   2:          0          XT-PIC  cascade
> >   5:       6945          XT-PIC  NVidia nForce3, ohci_hcd
> >   8:          0          XT-PIC  rtc
> >   9:       1416          XT-PIC  acpi, yenta
> >  10:          2          XT-PIC  ehci_hcd
> >  11:      37266          XT-PIC  SysKonnect SK-98xx, yenta, ohci1394, 
ohci_hcd
> >  12:      13781          XT-PIC  i8042
> >  14:         16          XT-PIC  ide0
> >  15:      23601          XT-PIC  ide1
> > NMI:          0
> > LOC:    3498657
> > ERR:          1
> > MIS:          0
> > 
> > (NVidia nForce3 is a sound chip, snd_intel8x0).  After it happens I can't 
> > reboot the box cleanly (the ohci-hcd driver cannot be reloaded) and it 
does 
> > not leave any traces in the log.
> > 
> 
> Beats me.  Does the interrupt count stop increasing?

Yes, it does.

Moreover, 2.6.10-rc1 has this problem too, but here the network adapter 
stopped working along with the USB (as you can see above, it shares an IRQ 
with the USB too).  Also, this time I was able to reload the ohci-hcd module 
(it didn't help) and I got these messages:

Oct 23 18:32:23 albercik kernel: ohci_hcd 0000:00:02.0: remove, state 1
Oct 23 18:32:23 albercik kernel: usb usb2: USB disconnect, address 1
Oct 23 18:32:23 albercik kernel: usb 2-2: USB disconnect, address 2
Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.0: IRQ INTR_SF lossage
Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.0: USB bus 2 deregistered
Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.1: remove, state 1
Oct 23 18:32:24 albercik kernel: usb usb3: USB disconnect, address 1
Oct 23 18:32:24 albercik kernel: ohci_hcd 0000:00:02.1: USB bus 3 deregistered
Oct 23 18:32:41 albercik kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host 
Controller (OHCI) Driver (PCI)
Oct 23 18:32:41 albercik kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 
(level, low) -> IRQ 11
Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.0: nVidia Corporation 
nForce3 USB 1.1
Oct 23 18:32:41 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.0 to 64
Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem 
0xfebfb000
Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.0: new USB bus 
registered, assigned bus number 2
Oct 23 18:32:41 albercik kernel: hub 2-0:1.0: USB hub found
Oct 23 18:32:41 albercik kernel: hub 2-0:1.0: 3 ports detected
Oct 23 18:32:41 albercik kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 
(level, low) -> IRQ 5
Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.1: nVidia Corporation 
nForce3 USB 1.1 (#2)
Oct 23 18:32:41 albercik kernel: PCI: Setting latency timer of device 
0000:00:02.1 to 64
Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.1: irq 5, pci mem 
0xfebfc000
Oct 23 18:32:41 albercik kernel: ohci_hcd 0000:00:02.1: new USB bus 
registered, assigned bus number 3
ct 23 18:32:41 albercik kernel: hub 3-0:1.0: USB hub found
Oct 23 18:32:41 albercik kernel: hub 3-0:1.0: 3 ports detected
Oct 23 18:32:41 albercik kernel: usb 2-2: new low speed USB device using 
address 2
Oct 23 18:32:46 albercik kernel: usb 2-2: control timeout on ep0out
Oct 23 18:32:46 albercik kernel: ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  
Different ACPI or APIC settings may help.
Oct 23 18:36:04 albercik kernel: Losing some ticks... checking if CPU 
frequency changed.
Oct 23 18:37:28 albercik kernel: eth0: network connection down
Oct 23 18:37:40 albercik kernel: eth0: no IPv6 routers present
Oct 23 18:42:45 albercik kernel: Intel ICH 0000:00:06.0: Device was removed 
without properly calling pci_disable_device(). This may need fixing.

The "control timeout on ep0out" and "Unlink after no-IRQ?" messages are 
puzzling, but the last one is just ridiculous as the box has _nothing_ to do 
with Intel.

The .config for 2.6.10-rc1 is available at:
http://www.sisk.pl/kernel/041023/2.6.10-rc1.config
The .config for 2.6.9-mm1 is available at:
http://www.sisk.pl/kernel/041023/2.6.9-mm1.config

The outputs of dmesg and lspci requested by Zwane will follow in a couple of 
minutes.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
