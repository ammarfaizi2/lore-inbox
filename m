Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbSJNTX5>; Mon, 14 Oct 2002 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSJNTX5>; Mon, 14 Oct 2002 15:23:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63096 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262109AbSJNTXz>; Mon, 14 Oct 2002 15:23:55 -0400
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <Pine.LNX.3.95.1021014130129.15441A-100000@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2002 13:28:16 -0600
In-Reply-To: <Pine.LNX.3.95.1021014130129.15441A-100000@chaos.analogic.com>
Message-ID: <m1smz8kegf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So in summary.
- Asserting the system level reset line is the most reliable way to
  reboot.  

  Note: This is not always true, I have seen machines with hardware
  bugs where asserting the reset line destabilizes things. And they do 
  not come back reliably.

- The kernel does not assert this line but politely requests the x86
  BIOS to do so. 

- There is at least some BIOS code that runs before the reset line is
  toggled.  And the reset line may not actually be toggled.

If we want reliable reboots what can the Linux kernel do.  
1) Include chipset+motherboard specific logic that toggles the reset
   line directly.
2) Walk the driver tree and ask the drivers politely to place their
   devices in a reasonable state.

   The dangers of not doing this are:
   - Network cards can DMA random packets into memory.  And if the
     network is quiet this can take a while.

   - Disks can have multiple outstanding disk requests and may
     DMA them into memory as well.

   - Drivers may not be able to initialize a device in a random state.
     I doubt you can do much with a floppy or ide device that is
     transfer data via pio and the transaction is left half finished.

   - On some platforms if we reassign device resources the firmware
     may fail to track where the new resources are.  This is arguably
     a firmware bug.

Additionally there is one extra nasty case.  On some platforms the
firmware cannot reliably reboot in a reasonable amount of time.  On
those platforms we need some kind of soft reboot that does the
Linux booting linux thing to get a reliable reboot in a reasonable
amount of time.

I am all for reboots being fast.  But until I observe that walking
the device tree and placing devices in a quiescent state is a major
time waster I do not see that we should skip it.  And given the recent
problems with the IDE driver I think it is good that we are running
this code on every reboot so we can see the drivers that take way to
much time placing their devices in a quiescent state.

With respect to the IDE code if we have to spin down the disk to get
a reliable sync we should do this whenever the sync command is issued.
Or we could have data loss from an unplanned power outage.  When I ask
the device driver to let go of the device, turning it off sounds quite
excessive to me.

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> Some drivers don't work after a "warm-boot" because the I/O resources
> shown in the PCI initialization have changed.  It's only after they
> get hit with a reset that they put their default resource type and
> length back into their registers. I am told that some lap-tops have
> semi-documented methods of sending a hardware reset to the PCI bridge(s)
> only. This is needed to get them into a restartable state.

I have only seen this on Alpha, with the SRM.  Or with drivers that
think they are dealing with ISA devices when they are not.

In a standard pci base address register, you can always derive
the resource type, and length.  In fact the kernel does this when
it loads.   You do not need a pci reset to be able to get the
pci base address, and resource size out of a pci bar.

Actually I can confirm that pci devices do not place anything special
in their bars after a pci reset.  Since a random bar is safe they save
hardware circuits not setting it to anything during a reset.  I have
actually had this byte me, in conjunction with detecting read-only BARs.

> A processor reset will get the processor onto the bus even if there is
> an ongoing DMA operation. Since the first of many instructions are
> fetched from ROM, it is quite likely that any DMA activity would have
> stopped before the ROM is shadowed by the BIOS. I don't see "ongoing"
> DMA as being a problem, which you can verify by forcing a reset in
> the FDC code (easiest to do) while waiting for read DMA to complete.
> FDC DMA is slow, so you can catch it 100% of the time.

I have seen it as a problem in real life.  With a NIC several seconds
after a reboot.  The network was quiet and than an arp request came
in.  So baring a reset of the device in question this can happen.


So in summary:
I am firmly convinced that:
- device_shutdown should walk the device tree asking drivers to place
  their devices in a quiescent state. ->remove() is likely the right
  method for this, and it what the device-mode people have selected.
  I personally don't care so long as there is an appropriate method.

- device_shutdown should be fast.

- The kernel has more general hardware knowledge than the BIOS so
  it is more likely to get the case of a soft reboot (no reset line
  asserted) correct. 

- The x86 BIOS does not always toggle the reset line on the
  motherboard, and device_shutdown should have a negligible cost.
  So we should always calling device_shutdown, to so it does not
  regress from being under used.

Eric
