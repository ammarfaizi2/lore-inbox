Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSIJQAs>; Tue, 10 Sep 2002 12:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319150AbSIJQAr>; Tue, 10 Sep 2002 12:00:47 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:35053 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317641AbSIJQAn>; Tue, 10 Sep 2002 12:00:43 -0400
Date: Tue, 10 Sep 2002 09:05:20 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.33/drivers/input/keyboard/atkbd.c allow SETLEDS to fail
Message-ID: <20020910090520.A731@adam.yggdrasil.com>
References: <200209091504.IAA01726@baldur.yggdrasil.com> <20020909172004.A2631@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020909172004.A2631@ucw.cz>; from vojtech@suse.cz on Mon, Sep 09, 2002 at 05:20:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2002 at 05:20:04PM +0200, Vojtech Pavlik wrote:
> There are not. If SETLEDS fails, then there is the GETID command, which
> is also allowed to fail (fails on AT (non-PS/2) keyboards, which are
> still common), and it most likely also fails on your keyboard. That's
> all.
> 
> If you kill the SETLEDS command, then even without a keyboard, the
> keyboard will be detected, and sent commands, which will have to time
> out every time.

	100 milliseconds, which normally only happens when the user
hits CapsLock, NumLock or ScrollLock, which generally implies that a
keyboard is present.  I suspect that you could change it to use mdelay
instead of udelay, so that other processes could do useful work during
the wait, which might be relevant even with a keyboard plugged in that
just happens to be slow if one is running a screen saver that cycles
the keyboard LED's.  If it's important, you could also set a flag
when SETLEDS fails and not attempt further SETLEDS until another
sign of life from the keyboard is received (which would also address
the case of someone unplugging the keyboard after initialization).

	I also noticed a problem with plugging in a PS/2 keyboard
after initialization where it would not work, at least when I also had
the USB-to-PS/2 emulation enabled (if I booted with PS/2 keyboard
plugged in, both the USB and the PS/2 keyboards would work).  I have
not checked the purely non-USB case for whether your code works for
loading the module without the keyboard present and then plugging the
keyboard in later.

	Without the USB-to-PS/2 emulation on my VD133 motherboard, I
can't type into lilo.  Perhaps newer BIOSes have USB keyboard input
without need for hardware emulation, but I imagine that there are
quite a few computers with this problem.  That would be OK if there
were some way for Linux to turn off USB-to-PS/2 keyboard emulation
once the Linux USB code is loaded.  Currently, I get an infinite loop
of carriage returns when I do "modprobe hid" if I am using USB-to-PS/2
keyboard emulation.

	I agree that USB-to-PS/2 seems to be an ugly kludge, but I
think that the small cost due to orphaning certain oddball hardware
combinations is greater than the even smaller benefit of faster
SETLEDs (which I think could be achieved in other ways).

	The rest of this email is just about the PCI interrupt routing.

> > >I assume you have an USB keyboard, and the BIOS emulates a PS/2 keyboard
> > >for non-USB capable OSes.
> > 
> > >Well, fix Linux irq router code, instead of damaging the keyboard code.
> > 
> > 	How is the Linux IRQ routing code broken?  As far as I know,
> > it only reads the information given to it and cannot reprogram the
> > hardware.
> 
> It can.

	Thanks for the pointers to arch/i386/pci/irq.c and
drivers/pci/quirks.c.  This code programs interrupt routing in a few
special cases and arch/i386/pci/irq.c has somewhat general underlying
facilities that could be put to more general use, but I do not see any
existing programming interface by which a user level program could
somehow get the kernel to try, for example, to reprogram pci device
00:07.2 to IRQ 10.


> > 	My understanding is that the BIOS is responsible for setting
> > up the IRQ routes of each device and writing them into each device's
> > PCI configuration register dword 15 byte 0 (INTERRUPT_LINE), which is
> > normally just 8 bits of RAM.
> 
> Yes, but because the BIOS often writes nonsense to these config
> registers, Linux knows several southbridges and can fix the routing by
> hand.
> 
> > The mechanism for *making* those routes
> > is vendor specific and handled by the BIOS at boot time.  In the
> > particular case of my VD133, it apparently uses a Via VT82C598 PCI
> > bridge ("Apollo MVP3 AGP"), which I think is the component that would
> > have the secret bits for setting up routing from the main PCI bus to
> > the interrupt controllers.
> 
> Most likely the interrupt routing is controlled by the southbridge (the
> ISA bridge device). See arch/i386/pci/irq.c. Maybe it's as easy as an
> entry for your southbridge is missing.
> 
> > And those bits do appear to be secret.
> 
> Not really. Most of them are actually documented. Namely for built-in
> devices like USB controllers, because those cannot be wired differently
> by different board manufacturers.

	There appears to be more black magic involved than is covered
by drivers/pci/quirks.c and arch/i386/pci/irq.c.  Thanks for the
pointers.  From the files that you mentioned and a lot of
experimentation of setpci and a minor kernel change, I have determined
that when I have my natsemi ethernet card plugged in, then, and *only
then*, I can get the USB controller to use the same IRQ as the
ethernet card, and, with the attached modification to
arch/i386/pci/irq.c, I can get the kernel to use that IRQ even though
there is no pirq entry for it.  By the way, this isn't just the USB
controller being polled whenever an ethernet packet arrives.  I've
verified that it works with the ethernet cable unplugged, as long as
the card is present.  However, without the ethernet card installed,
the only way I have gotten the USB keyboard to work is with the
USB-to-PS/2 emulation.  Right now, I have the ethernet card installed
and am composing this email on that USB keyboard via the Linux USB
drivers.  Thanks again particularly for the pointer to
arch/i386/pci/irq.c.

	Here are the details of what I found, as the information may
be useful for other purposes in the future.

	pirq_via_{get,set} in arch/i386/pci/irq.c show a general
mechanism for assigning IRQ's though the Via south bridge chip.
dev_perq_info->irq[pin].link is an index into a table of 4 bit
nibbles starting at PCI configuration register 0x55 of the south
bridge.  You write the IRQ that you want to route to into the
appropriate nibble.  Here is an example from my system, with some
comments in brackets:

	setpci -v -s 00:07.0 55 56 57 58
	00:07.0:55 = c0					[ pirq#1 --> IRQ 12 ]
	00:07.0:56 = 0b					[ pirq#2 --> IRQ 11 ]
	00:07.0:57 = 00
	00:07.0:58 = 00

	I can change the ethernet's IRQ routing from 11 to, say, 9,
and watch the ethernet immediately stop, by doing something like
"setpci -s 00:07.0 56=09".

	However, the built-in USB on the VT82C586B does not seem to use
this mechanism.  There is no PIRQ entry for the pin that the USB controller
uses, and I cannot, for example, get the USB interrupts to show up on IRQ
ten by filling all of the southbridge configuration registers from 0x55
through 0x58 with 0xaa.

	It seems that the built-in USB on the VT82C586B has the same
feature as is described for the Via 686A/B in quirk_via_irqpic in
drivers/pci/quirks.c:

 * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
 * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
 * when written, it makes an internal connection to the PIC.

	This seems to work on my VD133 motherboard also, but it seems
only to work if I route it to the interrupt being used by the ethernet
card.  It seems that there is some additional initialization needed
(and yes, I've checked that my choice of IRQ conforms that various IRQ
masks in arch/i386/pci/irq.c, and I've tried setting the south
bridge's configuration registers at 0x55 in conjunction with this.
So, it appears that there is some further interrupt routing
preparation that the kernel does not know about.

> Try the southbridge instead of the northbridge. I have several of the
> documents, and can send it to you if you tell me the right chip number.

	Great!  Here is output of lspci on my system.  I would be
interested in documents for any of the relevant chips.  Although I've
kludged around the problem enough for my own use, I'd prefer to
develop a more general and correct fix for other VD133 users at least
and perhaps other boards if they have a similar BIOS problem.

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 44)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev 12)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 08)
00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 20)
00:10.0 Ethernet controller: National Semiconductor Corporation DP83815 10/100Mbps Ethernet with Wake on LAN
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP AGP 1X/2X (rev 5c)


	Thanks for your help.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="irq.route"

--- linux-2.5.33/arch/i386/pci/irq.c	2002-08-31 15:05:37.000000000 -0700
+++ linux/arch/i386/pci/irq.c	2002-09-10 05:29:09.000000000 -0700
@@ -591,8 +591,13 @@
 	pirq = info->irq[pin].link;
 	mask = info->irq[pin].bitmap;
 	if (!pirq) {
-		DBG(" -> not routed\n");
-		return 0;
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &dev->irq);
+		if (dev->irq)
+			return 1;
+		else {
+			DBG(" -> not routed\n");
+			return 0;
+		}
 	}
 	DBG(" -> PIRQ %02x, mask %04x, excl %04x", pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;

--CE+1k2dSO48ffgeK--
