Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSIIO7j>; Mon, 9 Sep 2002 10:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSIIO7j>; Mon, 9 Sep 2002 10:59:39 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:31911 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317347AbSIIO7i>; Mon, 9 Sep 2002 10:59:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 9 Sep 2002 08:04:11 -0700
Message-Id: <200209091504.IAA01726@baldur.yggdrasil.com>
To: vojtech@suse.cz
Subject: Re: Patch?: linux-2.5.33/drivers/input/keyboard/atkbd.c allow SETLEDS to fail
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002 at 16:07:23 +0200, Vojtech Pavlik wrote:
>On Mon, Sep 09, 2002 at 06:51:11AM -0700, Adam J. Richter wrote:

>> 	I have a computer with an Iwill VD133 motherboard doing
>> USB-to-PS/2 keyboard emulation (built into the chipset somewhere)
>> for a BTC 7932M USB keyboard.  Under this configuration, the
>> SETLEDS command in atkbd_probe fails (the first atkbd_sendbyte
>> in atkbd_command fails), but the keyboard otherwise works if
>> that failure is ignored.
[...]

>I cannot do that, since then the keyboard identification will give too
>many positives.

	What real problem does that cause?  There are other tests that
the keyboard still has to pass.  Does this change even cause a false
positive in any real case?  As I understand it, this is how it was
prior to 2.5.32.


>I assume you have an USB keyboard, and the BIOS emulates a PS/2 keyboard
>for non-USB capable OSes.

>Well, fix Linux irq router code, instead of damaging the keyboard code.

	How is the Linux IRQ routing code broken?  As far as I know,
it only reads the information given to it and cannot reprogram the
hardware.

	My understanding is that the BIOS is responsible for setting
up the IRQ routes of each device and writing them into each device's
PCI configuration register dword 15 byte 0 (INTERRUPT_LINE), which is
normally just 8 bits of RAM.  The mechanism for *making* those routes
is vendor specific and handled by the BIOS at boot time.  In the
particular case of my VD133, it apparently uses a Via VT82C598 PCI
bridge ("Apollo MVP3 AGP"), which I think is the component that would
have the secret bits for setting up routing from the main PCI bus to
the interrupt controllers.  And those bits do appear to be secret.
While I have found programming information for a number of Via chips
on my VD133 motherboard, I have only been able to find technical
marketing information on the VT82C598, and the form for requesting
additional information from the Via web site says they normally only
give more detailed documentation to high-volume partners under
non-disclosure agreements.

	By the way, there is a note in drivers/pci/quirks.c that
mentioned that a different Via chipset did IRQ configuration for the
USB device by having the write to the INTERRUPT_LINE register actually
do the configuration. I tried it ("setpci -v -s 00:01.0 INTERRUPT_LINE=7"),
but that didn't update the kernel's idea of the IRQ routing (although
I could read it back from hardware with "lspci -H 1 -vv -s 00:01.0").

	However, even if some further development of this kludge works
(I would welcome that), I suspect that the bug that I am reporting is
common to many USB emulated keyboards, and that my fix does not cause
a real problem, and applications that do not need USB for any other
purpose to avoid including or configuring Linux USB.

	On the other hand, if there is real hardware is broken by my
change (and kernels prior to 2.5.32 I assume), that would change things,
and I'd be interested in knowing what that hardware is and how it breaks.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
