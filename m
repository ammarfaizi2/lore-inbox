Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129698AbRBLRCS>; Mon, 12 Feb 2001 12:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130010AbRBLRCI>; Mon, 12 Feb 2001 12:02:08 -0500
Received: from dandelion.com ([198.186.200.3]:35593 "EHLO dandelion.com")
	by vger.kernel.org with ESMTP id <S129698AbRBLRCF>;
	Mon, 12 Feb 2001 12:02:05 -0500
Date: Mon, 12 Feb 2001 09:02:00 -0800
Message-Id: <200102121702.f1CH20U03841@dandelion.com>
From: "Leonard N. Zubkoff" <lnz@dandelion.com>
To: olli@mpoli.fi
In-Reply-To: <20010212134757.A18423@mpoli.fi> (message from Olli Lounela on
	Mon, 12 Feb 2001 13:47:57 +0200)
Subject: Re: fwd: Mylex dac960 not SMP-safe?
cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Date: Mon, 12 Feb 2001 13:47:57 +0200
  From: Olli Lounela <olli@mpoli.fi>

  Hi! 

  Here's what I sent to linux-kernel today, since I'm not sure you're there,
  I'm sending this separately.

  Hi all!

  I'm having mucho trouble trying to run any kind of kernel in the following
  hardware:

      - Intel PR440FX, latest BIOS (1.00.09DI)
      - 2 * Intel PPro/200, stepping 09
      - Onboard Intel eepro100/B with 82557, driver in 2.2.18 reports 
	assembly 645520-034
      - Onboard Adaptec 7880
      - Mylex AcceleRAID 250 (code DACPTLM-1), 8 MB ECC cache SIMM.
      - 3 * IBM DNES-309170 9 GB LVD-SCSI disks in RAID-5 setup (Mylex
	recognizes them as LVD)

  Basically, there's something there that just locks the machine up.

I seem to recall that the Intel Providence motherboard has been problematic in
many configurations.  Have you contacted Mylex Technical Support to inquire
about compatibility issues between the AcceleRAID 250 and the PR440FX
motherboard?  They are far more expert than I when hardware compatibility is in
question.

  Apparently the keyboard controller is peculiar, or else any of the keyboards
  I have access to can't produce SysRQ, since SysRQ key just produces four raw
  scancodes, not one, and the documentation doesn't say how to handle this
  case. I'd be much happier to force an OOPS and add the trace here.

  The main idea is to boot from the dac960, and remove any old disks still
  attached to the aic7880. The dac960 is in a butmastering slot, and I did try
  removing the busmastering jumper. Main memory is ECC, and has been swapped
  (the SIMMs available are 64 MB and 128 MB, one each).

Busmastering jumper?  The only jumper on the AcceleRAID 250 I recall is the one
that controls whether the SISL support for onboard Symbios SCSI chips is
activated.  Having this jumper in the wrong position could lead to interrupt
problems, I expect.

  Symptoms with booting 2.4-kernels from dac960

    - Booting with SMP

      * Both 2.4.1-ac9 and 2.4.2-pre3 hang at dac960 initialization

If it hangs right after the driver banner is printed, but before the
configuration of the controller is reported, this almost certainly means that
the driver is not receiving interrupts from the DAC960.  This generally
indicates compatibility problems between the motherboard, its BIOS, and the
DAC960 hardware/firmware, a buggy motherboard, or it can indicate that the
Linux kernel is not dealing properly with the motherboard APIC configuration.
I thought that the latter type of issue is no longer likely.

    - Booting SMP-compiled kernel with nosmp option

      * dac960 gets initialized, but the builtin eepro/100b hangs at once

  Nothing is produced in the log, and the machine just stops. To me it looks
  like a deadlock. Getting the machine to react in any way requires hardware
  reset. Softdog doesn't react, so apparently the kernel is still running, to
  a degree at least.

  With newer 2.2-kernels (like 2.2.19pre9) the machine works for a while, and
  then hangs at random, apparently from network traffic. This also occurs with
  stock RedHat 2.2.16-3.

  The machine has formerly run linux faultlessly for a long time (years),
  without the dac960. It's pretty hard to find out the kernel version for sure,
  but apparently 2.2.14 has worked from 10 March 2000 till Dec 2000.
  Accordingly, while the dac960 card itself may be the culprit, I strongly
  suspect the dac960 driver is not SMP-safe.

There are no known driver SMP deadlock issues with the 2.2.9 or 2.2.10 versions
of the driver (or with 2.4.9/2.4.10).  While it is certainly possible there
could be an undetected driver problem, there are a *lot* of SMP machines
running the driver in production environments under heavy load with the
eepro100, so I am initially much more suspicious of the PR440FX motherboard
combination.

  Booting from aic7880, the system works with 2.2.18 kernel (with dac960
  driver), and I can compile kernel with 'make -j 20', but the machine still
  hangs in a few minutes if I try to simultaneously fetch 2.4.1 from mirror.
  The latter hanged the even with RH 2.2.16-3 (2.2.19pre9 was a bit better but
  did the same). What with the dismaying results above, I haven't tested
  2.4-kernels booting from the aic7880.

  With most any 2.2-kernel, when booting with nosmp or UP-compiled kernel I
  seem to be able fetch and compile a new kernel. Booting 2.2.14-SMP without
  dac960 driver, fetching 2.4.1 while compiling kernel with -j15 did not hang
  the machine.

  Apparently there's some strange interaction with SMP PPro and eepro100/B and
  dac960 drivers. I'm a bit at a loss on how to approach the problem, any help
  will be appreciated.

I notice that the AcceleRAID 250 and eepro100 are sharing IRQ 10.  WHile in
theory this should work fine, and does in other systems, is it possible to
place the AcceleRAID 250 in a different slot or assign it another IRQ?

		Leonard
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
