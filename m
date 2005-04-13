Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVDMWla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDMWla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 18:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDMWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 18:41:30 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:11445 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261181AbVDMWlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 18:41:21 -0400
Date: Thu, 14 Apr 2005 00:41:08 +0200
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Andrew Morton <akpm@osdl.org>,
       Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Message-ID: <20050413224108.GA29349@faui00u.informatik.uni-erlangen.de>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <20050412085922.GA6664@faui00u.informatik.uni-erlangen.de> <20050412020956.4c64cbb4.akpm@osdl.org> <200504132124.04871.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504132124.04871.daniel.ritz@gmx.ch>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 09:24:04PM +0200, Daniel Ritz wrote:
> On Tuesday 12 April 2005 11:09, Andrew Morton wrote:
> > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> > >
> > > On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> > > > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> > > > >
> > > > > 
> > > > > I'm hitting an annoying bug in kernel 2.6.11.5
> > > > > 
> > > > > Every time I _reboot_ (warmstart) my pc my two network cards won't get
> > > > > recognized any longer.
> > > > >
> > > > > Following error message appears on my screen:
> > > > >
> > > > > PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> > > > > ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > > > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > > > > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> > > > > PCI: Setting latency timer of device 0000:00:0b.0 to 64
> > > > > *** EEPROM MAC address is invalid.
> > > > > 3c59x: vortex_probe1 fails.  Returns -22
> > > > > 3c59x: probe of 0000:00:0b.0 failed with error -22
> > > > > PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
> > > > > ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > > > 0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
> > > > > PCI: Setting latency timer of device 0000:00:0d.0 to 64
> > > > > *** EEPROM MAC address is invalid.
> > > > > 3c59x: vortex_probe1 fails.  Returns -22
> > > > > 3c59x: probe of 0000:00:0d.0 failed with error -22
> > > > >
> > > > > This doesn't happen with older kernels (especially with 2.6.10) and so
> > > > > I've done a binary search and narrowed it down to 2.6.11-rc5 where it
> > > > > first hits me.
> > > > >
> > > > > My config, lspci output and the dmesg output of the working and non-working
> > > > > version can be found at [1]
> > > > >
> > > > > Feel free to ask if any information is missing or if I am supposed to try
> > > > > a patch.
> > > >
> > > > Thanks for doing the bsearch - it helps.
> > > >
> > > > There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
> > > >
> > > > The only PCI change I see is
> > > >
> > > > --- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> > > > +++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> > > > @@ -268,7 +268,7 @@
> > > >                 return -EIO;
> > > >
> > > >         pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> > > > -       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> > > > +       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> > > >                 printk(KERN_DEBUG
> > > >                        "PCI: %s has unsupported PM cap regs version (%u)\n",
> > > >                        dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> > > >
> > > > and you're not getting that message (are you?)
> > > >
> > > 
> > > I have still the problem described above with 2.6.12-rc2-mm2 and
> > > reverting the above patch solved it. And yes, now I get many of those
> > > 
> > > PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
> > > PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
> > > PCI: 0000:00:09.0 has unsupported PM cap regs version (1)
> > > 
> > > messages.
> > > 
> > 
> > Yes, we need to work out what's going on here.
> > 
> > Daniel?
> 
> yes. i already posted a debugging patch and asked to have to dmesg output.
> but no response. Message-Id: <200504050042.11987.daniel.ritz@gmx.ch>
> 
> i see two possibilities:
> - it's not really writing to the PM registers but somewhere else (or it's
>   writing some crap)
> - the device hates when somebody writes the current state again
>   (yes, there is a check for this but it's useless during boot). i have
>   a patch for this but i didn't send it until now because i really like
>   to see the debugging output first...attached anyway...
> 
> rgds
> -daniel
> 
> ------------------
> 
> [PATCH] PCI PM: read initial state from device
> 
> the PCI PM code tries not to write to the PM registers when there is no change
> in state. this however fails when a device is initially set up. and because
> some devices are broken they hate being forced to the state they are in. fix
> it by reading the current state from the device itself. also does some other
> things:
> - support PCI PM CAP version 3 (as defined in PCI PM Interface Spec v1.2)
> - add and export the function pci_get_power_state() to get it from the device
> - pci.h defines "4" as D3cold while probe.c uses it for unknown state
> - minor cleanups
> 

[patch snipped]

I tried your patch with 2.6.12-rc2-mm3 (did not apply cleanly, I have
applied one hunk per hand) and here is a diff of the dmesg of a
working/non-working version. If I should try something else, then tell
me and I will do.

The full dmesg output can be obtained from

http://wwwcip.informatik.uni-erlangen.de/~siprbaum/kernel/2.6.12-rc2-mm3_firstboot.txt
http://wwwcip.informatik.uni-erlangen.de/~siprbaum/kernel/2.6.12-rc2-mm3_secondboot.txt


--- 2.6.12-rc2-mm3_firstboot.txt	2005-04-14 00:31:13.000000000 +0200
+++ 2.6.12-rc2-mm3_secondboot.txt	2005-04-14 00:31:13.000000000 +0200
@@ -47,7 +47,7 @@
 ide_setup: ide4=noprobe
 ide_setup: ide5=noprobe
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 1537.101 MHz processor.
+Detected 1537.644 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
@@ -149,11 +149,21 @@
 ACPI: No ACPI bus support for floppy.0
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 loop: loaded (max 8 devices)
+PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
 ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
-0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xac00. Vers LK1.1.19
+0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
+PCI: Setting latency timer of device 0000:00:0b.0 to 64
+*** EEPROM MAC address is invalid.
+3c59x: vortex_probe1 fails.  Returns -22
+3c59x: probe of 0000:00:0b.0 failed with error -22
+PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
 ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
-0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb000. Vers LK1.1.19
+0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
+PCI: Setting latency timer of device 0000:00:0d.0 to 64
+*** EEPROM MAC address is invalid.
+3c59x: vortex_probe1 fails.  Returns -22
+3c59x: probe of 0000:00:0d.0 failed with error -22
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 HPT370A: IDE controller at PCI slot 0000:00:08.0
@@ -408,13 +418,11 @@
 ACPI: No ACPI bus support for 4-0:1.0
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
-ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
 ACPI: CPU0 (power states: C1[C1])
 ACPI: Power Button (FF) [PWRF]
 ACPI: Power Button (CM) [PWRB]
 ACPI: Fan [FAN] (on)
-ACPI: Thermal Zone [THRM] (42 C)
+ACPI: Thermal Zone [THRM] (40 C)
 lp0: using parport0 (interrupt-driven).
 Bluetooth: Core ver 2.7
 NET: Registered protocol family 31


Gruss,
  Peter Baumann
