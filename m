Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUEJAoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUEJAoT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 20:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUEJAoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 20:44:19 -0400
Received: from duke.cs.duke.edu ([152.3.140.1]:8441 "EHLO duke.cs.duke.edu")
	by vger.kernel.org with ESMTP id S264429AbUEJAoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 20:44:16 -0400
Date: Sun, 9 May 2004 20:44:15 -0400 (EDT)
From: Patrick Reynolds <reynolds@cs.duke.edu>
To: linux-kernel@vger.kernel.org
Subject: ACPI and broken PCI IRQ sharing on Asus M5N laptop
Message-ID: <Pine.GSO.4.58.0405092015260.19837@shekel.cs.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted yesterday about how the built-in psmouse in my Asus M5N (M5200N)
laptop is broken under recent 2.6 kernels.  I believe I have tracked the
problem down to broken IRQ sharing.  It's broken under 2.6.2 through
2.6.6-rc3-bk11, but it works fine under 2.6.1.

Booting with default parameters puts the i8042 psmouse channel, the Intel
8x0 sound card, and the Cardbus controller all on IRQ 12.  The mouse is
almost unusable, sampling 3-4 times per second.  The sound works fine.  In
/proc/interrupts I get
   12:      310     XT-PIC  i8042, Intel 82801DB-ICH4, yenta
The interrupt count goes up when I play MP3s, but not when I move the
mouse.

Booting with acpi=noirq (or acpi=off or pci=noacpi under 2.6.5) makes the
mouse work, but breaks several other devices, including sound.  From
dmesg:
  PCI: Probing PCI hardware
  PCI: Using IRQ router default [8086/24cc] at 0000:00:1f.0
  PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 0000:00:1f.5 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 0000:00:1f.6 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 0000:01:03.0 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: IRQ 0 for device 0000:01:03.1 doesn't match PIRQ mask - try pci=usepirqmask
[snip]
  PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
  PCI: IRQ 0 for device 0000:00:1f.5 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: No IRQ known for interrupt pin B of device 0000:00:1f.5. Please try using pci=biosirq.
  unable to grab IRQ 0
  Intel ICH: probe of 0000:00:1f.5 failed with error -16
In this case, /proc/interrupts shows only the i8042 on IRQ 12, and the
interrupt count increments as expected (about 75/sec) when I move the
mouse.

Enabling pci=biosirq didn't help.  Sound still didn't work:
  PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
  PCI: IRQ 0 for device 0000:00:1f.5 doesn't match PIRQ mask - try pci=usepirqmask
  PCI: No IRQ known for interrupt pin B of device 0000:00:1f.5.
  unable to grab IRQ 0
  Intel ICH: probe of 0000:00:1f.5 failed with error -16

Finally, enabling pci=biosirq and pci=usepirqmask together didn't help
either.  It got rid of a few warnings (basically anything telling me to
try biosirq or usepirqmask!), but the sound still couldn't get an
IRQ:
  PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
  PCI: No IRQ known for interrupt pin B of device 0000:00:1f.5.
  unable to grab IRQ 0
  Intel ICH: probe of 0000:00:1f.5 failed with error -16

So I'm stuck with either sound or mouse, but not both at once unless I
roll back to 2.6.1.  Any ideas?

I've put my dmesg from my last 5 reboots here:
  http://www.cs.duke.edu/~reynolds/dmesg2.txt

Here's the output of lspci -v:
  http://www.cs.duke.edu/~reynolds/pci.txt

In case it's an ACPI issue, here's my DSDT:
  http://www.cs.duke.edu/~reynolds/dsdt.bin

--Patrick
