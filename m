Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283561AbRLIP4A>; Sun, 9 Dec 2001 10:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283567AbRLIPzl>; Sun, 9 Dec 2001 10:55:41 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:21399 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283561AbRLIPza>; Sun, 9 Dec 2001 10:55:30 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: "ChristianK."@t-online.de (Christian Koenig)
To: Maciek Nowacki <maciek@mzn.dyndns.org>
Subject: Re: [PATCH] Making vmlinux Multiboot compliant and grub capable of loading modules at boot time.
Date: Sun, 9 Dec 2001 16:56:25 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <16C3zt-2CSvpYC@fwd00.sul.t-online.com> <20011208055652.GA19246@mzn.dyndns.org>
In-Reply-To: <20011208055652.GA19246@mzn.dyndns.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <16D6IB-1uKFncC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 08 December 2001 06:56, Maciek Nowacki wrote:
> Hello!
>
> On Thu, Dec 06, 2001 at 08:17:13PM +0100, Christian Koenig wrote:
> > Hi,
> >
> > First this patch isn't "release ready", but I need some help with it.
> >
> > The patch is for 2.4.14 Kernel Image, but it should patch well on other
> > Versions.
> >
> > It adds Multiboot compatibility to vmlinux, by adding a Multibootheader
> > to arch/i386/kernel/head.S
>
> This is very cool! I've been hoping for this capability for a while. I even
> tried doing it myself about half a year ago but gave up after not having
> any luck attaching the header to the kernel image.

The Multiboot header wasn't the problem, but the conversion from
Multiboot Information -> Linux like boot structures wasn't so easy.

> > The Multiboot information (apm-table, memmapping....) are converted to
> > linux conform things, and the Memory used by the Modules is reserved with
> > the bootmem bitmap in
> > arch/i386/kernel/setup.c
> >
> > The reserved data is released in
> > arch/i386/mm/init.c
> > when the Init data is released.
> >
> > Then in
> > init/main.c
> > a newly created elf-object loader is called in
> > kernel/boot_modules.c
> > inserting the Modules into the kernel.
>
> So for instance binfmt_elf.o could be modular, neat. Is the elf loader
> needed though? I thought a boot loader such as grub might load in essential
> modules before the kernel is called, so the handling of elf objects is in
> the bootloader. I would suggest this approach: have the bootloader link the
> kernel at boot time (the CORE_FILES kernel.o, mm.o, fs.o, ipc.o,
> network.o), then required modules such as binfmt_elf and the root
> filesystem - though these might not actually be proper modules but just
> parts of the static image, or you would need modifications to load modules
> into the kernel before it is running).

binfmt_elf is not needed, AFAIK it is not capable to load elf-object files.

>
> It is nice to be able to load modules the way this patch allows but it is
> not a huge advantage over the existing initrd setup. rd, binfmt_elf, and
> the filesystem could be modularized, and rd and the filesystem could be
> unloaded after pivot_root, but it would be interesting to modularize
> everything - perhaps even go further than CORE_FILES and load the
> individual .o files, but that's probably too much to do at boot.
>
> Adding the elf loader to the kernel seems to be bloat since binfmt_elf
> should provide that functionality, but it would be nice to have that as a
> module. So it seems that's one way to do it, or somehow allow the
> bootloader to load modules into the kernel before it is running, which
> would allow a lot more of the kernel to be modularized - and what couldn't
> be modularized could be linked statically at boot from individual objects.

AFAIK binfmt_elf is only a elf-programm and library loader, 
it is not  a object file relocator or symbol resolver (like insmod).

>
> > With this grub is capable of loading multiple modules at boot time,
> > before the root fs is mounted..
> > This can't be done with initrd, because you could on load one single
> > initrd Image.
>
> As another point, initramfs would make this nicer since it provides an
> initial filesystem as a cpio archive in an elf object (afaik). Then grub
> might link CORE_FILES + cpio.o + binfmt_elf.o + cramfs.o + ...
>
> > My question is what should I do to make this patch "clean" ?
> > I know that vmlinux isn't compressed and contains unused elf-sections.
>
> I think vmlinux should not be compressed by default. It is a hack
> introduced back when it was important to squeeze kernels into low memory.
> This is not really necessary anymore since no modern kernel image will fit
> into such a space. Modern kernels use new BIOS calls to load piecemeal into
> >1MB, though I have never understood why the flat mode approach used by
> HIMEM.SYS and many others would not work (doesn't break on old systems...
> eliminates special cases in boot loader... oh well).

The compression is needed for boot/installation disk.

Am I wrong or did you sugest me to write a new bootloader ?

Mfg, Christian König.
