Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbRAJPc6>; Wed, 10 Jan 2001 10:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135524AbRAJPcg>; Wed, 10 Jan 2001 10:32:36 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:57330 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S135608AbRAJPcJ>; Wed, 10 Jan 2001 10:32:09 -0500
Date: Wed, 10 Jan 2001 15:32:06 +0000 (GMT)
From: Charles McLachlan <cim20@mrao.cam.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with 2.4.0 agpgart on Dell D4100 (probably) Intel i815
In-Reply-To: <OF57A8F6A1.EBEE4C0B-ON852569D0.0048E35A@lotus.com>
Message-ID: <Pine.SOL.4.30.0101101409211.8321-100000@mraosd.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(The ultimate cause of what I'm about to tell you may well be a chipset
problem, but I think I've uncovered a tiny bit of kernel weirdness none
the less)

Using 2.4.0

modprobe agpgart.o

/var/log/messages says
>Jan 10 14:11:56 x kernel: Linux agpgart interface v0.99 (c) Jeff
> Hartmann
> Jan 10 14:11:56 x kernel: agpgart: Maximum main memory to use for
> agp memory: 439M
> Jan 10 14:11:56 x kernel: agpgart: agpgart: Detected an Intel
> i815, but could not find the secondary device.

lspci says
> 00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
> 00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 02)
> 00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 02)
> ...

http://www.datashopper.dk/~finth/pci.html says
> 1130h	82815 i815 (Solano) Host to Hub Bridge (Fully featured chipset)
> 1131h	82815 i815 (Solano) PCI to AGP Bridge
> 1132h	82815 i815 (Solano) Interal GUI Accelerator

I take it "Interal GUI Accelerator" is a built in graphics card (that I
don't have)

/usr/src/linux/drivers/char/agp/agp.h says (amongst other things)
> #define PCI_DEVICE_ID_INTEL_815_0       0x1130
> ...
> #define PCI_DEVICE_ID_INTEL_815_1       0x1132

/usr/src/linux/drivers/char/agp/agpgart_be.c says
> case PCI_DEVICE_ID_INTEL_815_0:
>		   /* The i815 can operate either as an i810 style
>		    * integrated device, or as an AGP4X motherboard.
>		    *
>		    * This only addresses the first mode:
>		    */
>
>	i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
>				PCI_DEVICE_ID_INTEL_815_1,
>						   NULL);

It is this call that is failing and causing the error message.

Questions:
Why don't the PCI ids match in aph.h and lspci? Which one is right?
Is my i815 acting as a "AGP4X motherboard"?
If so does anyone have any suggestions as to how I get it to work?

My BIOS doesn't have many settings for jiggering around with the AGP
stuff, although it does say "AGP 4x" in big letters.

When I alter agp.h to have the "right" PCI id, then /var/log/messages
says:

> Jan 10 14:25:45 x kernel: Linux agpgart interface v0.99 (c) Jeff
> Hartmann
>Jan 10 14:25:45 x kernel: agpgart: Maximum main memory to use for
> agp memory: 439M
> Jan 10 14:25:45 x kernel: agpgart: agpgart: Detected an Intel
> i815 Chipset.
> Jan 10 14:25:45 x kernel: agpgart: i810 is disabled
> Jan 10 14:25:45 x kernel: agpgart: unable to detrimine aperture
> size.

The nasty bit in this case is:

> pci_read_config_dword(agp_bridge.dev, I810_SMRAM_MISCC, &smram_miscc);
>
> if ((smram_miscc & I810_GMS) == I810_GMS_DISABLE) {
>		printk(KERN_WARNING PFX "i810 is disabled\n");
>		return 0;
>	}

smram_miscc comes out as 0xa82800c whereas I810_GMS is 0xc0

This made me think that my i815 is *not* "acting like an i810" but I
carried on bodging anyway.

I'm pretty sure my AGP aperture size is 64Mb (that's what the BIOS reckons
anyway) so I commented out the GMS check, so that intel_i810_fetch_size
would return 64Mb.

after modprobe agpgart I got a *lot* of messages like
> Jan 10 14:37:31 x kernel: io mapaddr 0x1fff4 not valid at
> agpgart_be.c:898!
> Jan 10 14:37:31 x kernel: io mapaddr 0x1fff8 not valid at
>agpgart_be.c:898!
> Jan 10 14:37:31 x kernel: io mapaddr 0x1fffc not valid at
> agpgart_be.c:89

line 898 does an OUTREG32 on some i810 private registers, which (I think)
is more evidence that my chipset is not acting like an i810.

Then the (rather worrying)
> Jan 10 14:37:31 x kernel: agpgart: AGP aperture is 64M @ 0x0

So far so bad. I then insmodded my Nvidia module and started X
> Jan 10 14:38:30 herschel kernel: NVRM: Intel i810 AGP chipset
> Jan 10 14:38:30 herschel kernel: mtrr: type mismatch for 0000,4000000
> old: write-back new: write-combining
> Jan 10 14:38:30 herschel kernel: NVRM: error: unable to set mtrr
> write-combining
> Jan 10 14:38:30 herschel kernel: NVRM: error: unable to remap aperture

Which isn't very good, although X actually did run and didn't hose my
machine, as I was half expecting.

Does anyone have any idea what is going on?

Charlie - Queens' College - Cavendish Astrophysics - 07866 636318


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
