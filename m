Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270731AbRHKHY0>; Sat, 11 Aug 2001 03:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270732AbRHKHYQ>; Sat, 11 Aug 2001 03:24:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18795 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270731AbRHKHYA>; Sat, 11 Aug 2001 03:24:00 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Etienne Lorrain <etienne@masroudeau.com>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
	<9kuid8$q57$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Aug 2001 01:17:11 -0600
In-Reply-To: <9kuid8$q57$1@cesium.transmeta.com>
Message-ID: <m1n157rrpk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
> By author:    Etienne Lorrain <etienne@masroudeau.com>
> In newsgroup: linux.dev.kernel
> > 
> >  - Loads Linux kernel images (zImage and bZimage) without the help
> >    of LILO, and short-circuit all real-mode code in the kernel to
> >    start at the first protected mode instruction of the kernel.
> > 
> 
> This is a very bad idea.  The kernel entry point is in real mode for a
> reason: it means that the kernel doesn't have to rely on the boot
> loader to provide the services it needs from real mode before
> entering protected mode once and for all.  The interface to the real
> mode entry point is narrow and stable, the protected mode entrypoint
> is a kernel internal and doesn't have an interface that is guaranteed
> to be stable -- again, for good reason.

There are good reasons to use the kernel 32 bit entry point.  In
particular I routinely run linux on systems with exactly 10 16bit
instructions.   On one of them I don't even have normal memory between
640KB and 1MB. The only real parameter the kernel needs from the BIOS
is memory size, and I could probably steel code from memtest86 so it
wouldn't even need that.  

However I do understand the instabilities, and the deficiets of the
current 32bit entry point, and why having a standard 16bit entry point
is a good thing.  Which is why in 2.5 (if it ever starts) I intend to
do the work required so we can have a standard cross platform native
mode entry point to the kernel.  

To keep linux portable we should never assume that on a given platform
there is a specific kind of BIOS.  Alpha-linux at least is nasty
because of this.  x86 linux is very nice because all you need to do on
platforms that don't do support the classic BIOS interface is to drop
the 16bit header.  That is definentily a structure worth keeping.

Currently I have a stable easy to use structure that isn't even linux
specific with just a few more details on how to encode parameters to
work out.  The structure is the ELF format for static executables,
with a specific implementation of how parameters will be passed to it
from the bootloader, before the bootloader goes away.  In particular
how to specify things like onboard ISA devices so we don't even have
to assume what is or is not present on a motherboard for those devices
that don't support probing and there is a firmware interface for
finding them.  The interesting case there is not so much how to encode
the device but instead on how to represent the location of devices,
and the connections between devices.   

Being able to describe how an interrupt goes from a pci slot to an irq
router to a legacy interrupt controller to a local apic and to the
cpu, and simultanesly goes from the pci slot to an ioapic to a local
apic to the cpu.   And saying that pci slot is behind a PCIX<->pci
bridge.  Is an interesting question.  Especially in data structures
that have very few special cases.  We are close in the kernel with
struct resource, and struct pci_device but we haven't gone all of the
way yet. 

So no I don't think it is right to blast someone for using the 32bit
entry point, while at the same time I do agree that right now it is a
very questionable things to do.

Eric
