Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbRHJM1s>; Fri, 10 Aug 2001 08:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbRHJM1i>; Fri, 10 Aug 2001 08:27:38 -0400
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:9220
	"EHLO hp.masroudeau.com") by vger.kernel.org with ESMTP
	id <S267268AbRHJM1U>; Fri, 10 Aug 2001 08:27:20 -0400
Date: Fri, 10 Aug 2001 05:24:58 -0700 (PDT)
From: Etienne Lorrain <etienne@masroudeau.com>
To: <linux-kernel@vger.kernel.org>
cc: <Gujin-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
Message-ID: <Pine.LNX.4.33.0108100134440.19627-100000@hp.masroudeau.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa wrote:
> Etienne wrote:
> >  - Loads Linux kernel images (zImage and bZimage) without the help
> >    of LILO, and short-circuit all real-mode code in the kernel to
> >    start at the first protected mode instruction of the kernel.
>
> This is a very bad idea.  The kernel entry point is in real mode for a
> reason: it means that the kernel doesn't have to rely on the boot
> loader to provide the services it needs from real mode before
> entering protected mode once and for all.  The interface to the real
> mode entry point is narrow and stable, the protected mode entrypoint
> is a kernel internal and doesn't have an interface that is guaranteed
> to be stable -- again, for good reason.

 Thanks for the constructive criticism, now it is time to explain
 why I did it this way - it is far to be the simplest solution.

 First, I need to say that the Linux current interface is really
 stable: if you define "BOOT_KERNEL_BEFORE_2_0" in vmlinuz.[ch],
 Gujin will be able to boot pre- 1.0 Linux versions. Also, Gujin
 has always booted kernels this way.

 Considering the kernel interface to the bootloader, I find it is
 IMHO a bit complex: you not only have to give parameters in
 memory (at 0x9000:0000 or at %esi on 2.4.1+) but also provide
 callbacks (BIOS calls) for quite a lot of things.

 Alan Cox described it (incompletely) in his message in june,
 subject "draft BIOS use document for the kernel" at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=99322719013363&w=2

 You also have to put in memory one or two compressed files
 (kernel and initrd) without any way to check if those hundred
 of Kbytes have been correctly read and are not corrupted.
 There will be no way - if an error is detected by the legacy
 loader at the decompression stage - to return to the bootloader
 saying: Fatal error, please select another kernel.

 These two files in memory have also to be at fixed linear
 addresses in real mode - and if you have a memory manager
 (himem.sys) loaded, these address may not be free. Usually
 you will find at the bottom of the himem memory the smartdrv
 (disk cache) data. It is then impossible to load a file at a random
 memory address and stay in real mode to do futher processing.
 In this case, Gujin is just malloc'ing the memory (using himem.sys),
 loading and decompressing this file (checking its CRC32), and
 only then disable interrupts, switch to protected mode, copy
 the file at its intended linear address and jump to the kernel
 code.

 Then, with the "old" method to load the kernel, you have the video
 selection menu. Well, it is a bit complex a thing to do in
 a bootloader, and its interface is complex (not speaking of the
 user interface), considering that you have already written everywhere
 in memory without knowing if (for instance) a video driver was loaded.
 All the video selection stuff has be to handled before selecting
 a kernel to load, IMO.

 I could probably find other problem, but I do not want to do
 destructive criticism.

 What do I propose? Lets put is simply:

 - The kernel file is a simple binary image to load at 0x100000,
 so you get it from the linux ELF file by just doing:
  objcopy -O binary -R .note -R .comment -S /usr/src/linux/vmlinux kernel
  gzip -9 kernel
 There is absolutely no limit on its size.

 - The initrd (if present) is a gzip of a filesystem image.

 - All information needed by the kernel is set in memory. It is
 clearly described on a C structure (vmlinuz.h::struct linux_param).
 This structure contains also (for reference) old fields which
 are no more used, or fields which were used only by previous
 bootloader. The is _no_ BIOS callback.

 - The hardware is setup correctly, for instance for the current
 video mode - if you are in graphic 8 BPP - the 256 color palette
 is set up with reasonnable values independant of the video card.
 Basically, hardware is immediately useable by the kernel.

 - There is a compatibility mode to load vmlinuz/zImage/bzImage.

 Note that all this is coded and working (I hope so). I know that
 with this solution, the bootloader and the kernel are more
 linked together, but I know also that the bootloader has to
 be a lot more intelligent (considering the number of related
 messages in the Linux lists). It should not try to load a Pentium
 compiled kernel on a 486. It should setup the video card (so
 be ready to get "invalid instruction exceptions" while executing
 BIOS calls). It should not try to run a corrupted kernel. It should
 not crash if a kernel/initrd file has been moved or two hard disks
 have been exchanged. It should display clear messages on what is
 wrong.
 It is up to the bootloader to crash if one BIOS call modify one
 register which is documented as constant (if it did not take care)
 - and in DEBUG mode send some informations to a serial/parallel port.
 When a new buggy BIOS appear, it is up to the bootloader to be upgraded,
 not to the Linux kernel.
 In short it is a real and complete software which handle all/most
 of the (buggy) BIOSes in their natural environment: the i386 real mode.
 If there is few fields to add to "struct linux_param" (really
 unusual from history), then Gujin will be upgraded. Anyway it is
 GPL - and written in C so there is a lot of people around able to
 change it, unlike assembly code.

 It is not as clean as described because of the APM / ACPI /
 PCI configuration BIOS32 calls; but that did not change by the
 Gujin bootloader. Note also that the SMP tables are passed in
 memory.

 One last thing I have to add (for people who have read up to here),
 is that having removed the "header" of the vmlinuz file, I lack the
 only important parameter in this header: the root device (rdev command).
 Right now, I am guessing it in a lot of configurations, but that
 is not a perfect solution. I think one of the simplest way is
 to add a "root=/dev/hd**" in the described comment field of the GZIP
 header; that is still not coded.
 From the same area, there is no way to know if a kernel will be able
 to boot in graphic mode (support of VESA framebuffer and which BPP
 are available). If vesafb is not compiled in and you start the
 kernel in graphic, the kernel boots but the display is like a
 crash... Right now the dirty way is the write-protect bit of the
 vmlinuz file - not a long term solution.

  Comment anyone?

  Etienne.

