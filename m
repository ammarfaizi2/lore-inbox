Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285834AbRLHF5W>; Sat, 8 Dec 2001 00:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285837AbRLHF5N>; Sat, 8 Dec 2001 00:57:13 -0500
Received: from h24-82-28-170.ed.shawcable.net ([24.82.28.170]:45326 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S285834AbRLHF47>;
	Sat, 8 Dec 2001 00:56:59 -0500
From: Maciek Nowacki <maciek@mzn.dyndns.org>
Date: Fri, 7 Dec 2001 22:56:53 -0700
To: Christian Koenig <"ChristianK."@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Making vmlinux Multiboot compliant and grub capable of loading modules at boot time.
Message-ID: <20011208055652.GA19246@mzn.dyndns.org>
In-Reply-To: <16C3zt-2CSvpYC@fwd00.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16C3zt-2CSvpYC@fwd00.sul.t-online.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Dec 06, 2001 at 08:17:13PM +0100, Christian Koenig wrote:
> Hi,
> 
> First this patch isn't "release ready", but I need some help with it.
> 
> The patch is for 2.4.14 Kernel Image, but it should patch well on other 
> Versions.
> 
> It adds Multiboot compatibility to vmlinux, by adding a Multibootheader to
> arch/i386/kernel/head.S

This is very cool! I've been hoping for this capability for a while. I even
tried doing it myself about half a year ago but gave up after not having any
luck attaching the header to the kernel image.

> The Multiboot information (apm-table, memmapping....) are converted to linux 
> conform things, and the Memory used by the Modules is reserved with the 
> bootmem bitmap in
> arch/i386/kernel/setup.c
> 
> The reserved data is released in 
> arch/i386/mm/init.c
> when the Init data is released.
> 
> Then in 
> init/main.c
> a newly created elf-object loader is called in
> kernel/boot_modules.c 
> inserting the Modules into the kernel.

So for instance binfmt_elf.o could be modular, neat. Is the elf loader needed
though? I thought a boot loader such as grub might load in essential modules
before the kernel is called, so the handling of elf objects is in the
bootloader. I would suggest this approach: have the bootloader link the
kernel at boot time (the CORE_FILES kernel.o, mm.o, fs.o, ipc.o, network.o),
then required modules such as binfmt_elf and the root filesystem - though
these might not actually be proper modules but just parts of the static
image, or you would need modifications to load modules into the kernel before
it is running).

It is nice to be able to load modules the way this patch allows but it is not
a huge advantage over the existing initrd setup. rd, binfmt_elf, and the
filesystem could be modularized, and rd and the filesystem could be unloaded
after pivot_root, but it would be interesting to modularize everything -
perhaps even go further than CORE_FILES and load the individual .o files, but
that's probably too much to do at boot.

Adding the elf loader to the kernel seems to be bloat since binfmt_elf should
provide that functionality, but it would be nice to have that as a module. So
it seems that's one way to do it, or somehow allow the bootloader to load
modules into the kernel before it is running, which would allow a lot more of
the kernel to be modularized - and what couldn't be modularized could be
linked statically at boot from individual objects.

> With this grub is capable of loading multiple modules at boot time, before 
> the root fs is mounted..
> This can't be done with initrd, because you could on load one single initrd 
> Image.

As another point, initramfs would make this nicer since it provides an
initial filesystem as a cpio archive in an elf object (afaik). Then grub
might link CORE_FILES + cpio.o + binfmt_elf.o + cramfs.o + ...

> My question is what should I do to make this patch "clean" ?
> I know that vmlinux isn't compressed and contains unused elf-sections.

I think vmlinux should not be compressed by default. It is a hack introduced
back when it was important to squeeze kernels into low memory. This is not
really necessary anymore since no modern kernel image will fit into such a
space. Modern kernels use new BIOS calls to load piecemeal into >1MB, though
I have never understood why the flat mode approach used by HIMEM.SYS and many
others would not work (doesn't break on old systems... eliminates special
cases in boot loader... oh well).

Maciek
