Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266706AbRHKILI>; Sat, 11 Aug 2001 04:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRHKIK7>; Sat, 11 Aug 2001 04:10:59 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:39435 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266158AbRHKIKk>; Sat, 11 Aug 2001 04:10:40 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
Date: 11 Aug 2001 01:10:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9l2p9e$89h$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com> <9kuid8$q57$1@cesium.transmeta.com> <m1n157rrpk.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1n157rrpk.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> There are good reasons to use the kernel 32 bit entry point.  In
> particular I routinely run linux on systems with exactly 10 16bit
> instructions.   On one of them I don't even have normal memory between
> 640KB and 1MB. The only real parameter the kernel needs from the BIOS
> is memory size, and I could probably steel code from memtest86 so it
> wouldn't even need that.  
> 
> However I do understand the instabilities, and the deficiets of the
> current 32bit entry point, and why having a standard 16bit entry point
> is a good thing.  Which is why in 2.5 (if it ever starts) I intend to
> do the work required so we can have a standard cross platform native
> mode entry point to the kernel.  
> 
> To keep linux portable we should never assume that on a given platform
> there is a specific kind of BIOS.  Alpha-linux at least is nasty
> because of this.  x86 linux is very nice because all you need to do on
> platforms that don't do support the classic BIOS interface is to drop
> the 16bit header.  That is definentily a structure worth keeping.
> 

This is indeed a good structure, but this wide interface is a pain to
keep stable, and having bootloaders call it directly is a genuinely
bad idea.  It will lock us into an interface, or cause major breakage,
when we have to do necessary revving of this interface.

Instead, the proper time to deal with this is at kernel link time.
The PC-BIOS stuff should go in, say arch/i386/pcbios, and you then can
have other platforms (say, for example, arch/i386/linuxbios) which has
its own setup code.  You then link a kernel image which has the
appropriate code for the platform you're running on, and you're set.

> Currently I have a stable easy to use structure that isn't even linux
> specific with just a few more details on how to encode parameters to
> work out.  The structure is the ELF format for static executables,
> with a specific implementation of how parameters will be passed to it
> from the bootloader, before the bootloader goes away.  In particular
> how to specify things like onboard ISA devices so we don't even have
> to assume what is or is not present on a motherboard for those devices
> that don't support probing and there is a firmware interface for
> finding them.  The interesting case there is not so much how to encode
> the device but instead on how to represent the location of devices,
> and the connections between devices.   
> 
> Being able to describe how an interrupt goes from a pci slot to an irq
> router to a legacy interrupt controller to a local apic and to the
> cpu, and simultanesly goes from the pci slot to an ioapic to a local
> apic to the cpu.   And saying that pci slot is behind a PCIX<->pci
> bridge.  Is an interesting question.  Especially in data structures
> that have very few special cases.  We are close in the kernel with
> struct resource, and struct pci_device but we haven't gone all of the
> way yet. 
> 
> So no I don't think it is right to blast someone for using the 32bit
> entry point, while at the same time I do agree that right now it is a
> very questionable things to do.

I haven't blasted anyone; I said it is a bad idea.  You're now
encoding a ton of assumptions about what the kernel needs in each and
every bootloader, which is bound to cause a major headache not too
long down the road.  For example, the stuff you describe above may
very well be obsolete in 2 years with HyperTransport, Infiniband and
3GIO on the very near horizon.  Now you have to suffer dealing with
lots and lots of compatibility logic to make things work, which may
not be possible, or we're going to have frequent breakage.

I do not believe this is a good idea.  This kind of information
belongs in the kernel image, although it should be abstracted out
within the kernel tree.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
