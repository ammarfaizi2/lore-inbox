Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTFBCub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 22:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTFBCub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 22:50:31 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:63189 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S261790AbTFBCu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 22:50:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16090.48773.258921.532437@gargle.gargle.HOWL>
Date: Sun, 1 Jun 2003 23:03:33 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 and 2.5.70-mm3 hang on bootup
In-Reply-To: <16090.15708.707835.911577@gargle.gargle.HOWL>
References: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
	<16090.15708.707835.911577@gargle.gargle.HOWL>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Stoffel <stoffel@lucent.com> writes:

Bernhard> Both 2.5.70 and 2.5.70-mm3 hang right after "Ok, booting the
Bernhard> kernel..." on one of my test boxes (at the point, nothing
Bernhard> works, not even turning on/off the NumLock LED).

Bernhard> Hardware: ASUS A7S333, Athlon 2600+, 1 GB RAM
Bernhard> Compiler: gcc 3.3

John> Make sure you've turned off APIC mode, even for UP processors.  I'm
John> trying to get 2.5.70-mm3 working with SMP and I've narrowed it down to
John> an APIC problem.  Doesn't matter if I'm SMP or UP if I have APIC
John> enabled.  Booting with 'noapic' doesn't seem to help, but I'm probably
John> doing that part wrong.

John> My machine is a Dell Precision 610MT, dual 550 Mhz PIII Xeon, 440BX
John> chipset.  Latest BIOS from Dell, but it's a pretty stripped down one,
John> not much to poke at.

I'm an idiot, I have a 440GX (not B) chipset, as shown by lspic:

  > lspci
  00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
  00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
  00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
  00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
  00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
  00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
  00:0d.0 PCI bridge: Hint Corp: Unknown device 0021 (rev 13)
  00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro
  100] (rev 05)
  00:10.0 SCSI storage controller: Adaptec AIC-7881U
  00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
  03)
  01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
  (rev 82)
  02:08.0 USB Controller: NEC Corporation USB (rev 41)
  02:08.1 USB Controller: NEC Corporation USB (rev 41)
  02:08.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02)
  02:0b.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
  03:0a.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
  03:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)

Just to follow up here, it's still not working for me with 2.5.70-bk6,
it hangs on bootup when I have UP compilied in, along with "Local APIC
support on uniprocessors".  

And since I haven't been able to get 2.5.x to run in the past (though
admittedly I was always using SMP builds) I can't tell you when this
got broken.  

Here's the output of /proc/version and interrupts from my currently
working 2.4.x SMP setup:

  > cat /proc/version 
  Linux version 2.4.21-pre5-ac1 (john@jfsnew) (gcc version 2.96 20000731
  (Red Hat Linux 7.2 2.96-112.7.2)) #4 SMP Thu Mar 6 17:21:37 EST 2003
  > cat /proc/interrupts 
	     CPU0       CPU1       
    0:      30769      31439    IO-APIC-edge  timer
    1:        793        791    IO-APIC-edge  keyboard
    2:          0          0          XT-PIC  cascade
    5:          1          0    IO-APIC-edge  Crystal audio controller
    8:          1          0    IO-APIC-edge  rtc
   11:       7043       4241    IO-APIC-edge  Cyclom-Y
   12:        429        435    IO-APIC-edge  PS/2 Mouse
   14:        613        336    IO-APIC-edge  ide0
   16:          0          0   IO-APIC-level  usb-ohci
   17:       1323       1393   IO-APIC-level  usb-ohci, eth0
   18:       3966       3863   IO-APIC-level  aic7xxx, aic7xxx
   19:         32         28   IO-APIC-level  aic7xxx
  NMI:          0          0 
  LOC:      62121      62119 
  ERR:          0
  MIS:          0



Here's the output from what I can boot 2.5.70-mm3 in UP mode with APIC
turned off, notice how all my devices are on Interuppt 11, and that my
Cyclom-Y ISA serial board isn't detected properly.  The driver sorta
finds it, but can't get an interrupt properly.

  > cat /proc/interrupts 
	     CPU0       
    0:     136453          XT-PIC  timer
    1:         93          XT-PIC  i8042
    2:          0          XT-PIC  cascade
    9:          0          XT-PIC  acpi
   10:         52          XT-PIC  eth0
   11:       4555          XT-PIC  aic7xxx, aic7xxx, aic7xxx, ehci-hcd,
  uhci-hcd
   12:        397          XT-PIC  i8042
   14:        118          XT-PIC  ide0
  NMI:          0 
  ERR:          0


Hopefully this will help people who know more than I about APIC stuff
to debug this.  I'm willing to try out patches, now that 2.5.70-mm3
seems have a pretty solid RAID1 setup.  Which I'll test a bit more
tonight.

John




