Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290520AbSA3T6r>; Wed, 30 Jan 2002 14:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290521AbSA3T62>; Wed, 30 Jan 2002 14:58:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18484 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290520AbSA3T6P>; Wed, 30 Jan 2002 14:58:15 -0500
To: <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2002 12:54:46 -0700
Message-ID: <m1elk7d37d.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been working on this quietly and now my pieces generally work,
and I am down to dotting the i's, and crossing the t's.  As my start
of pushing for inclusion I want to get some feedback (in case I have
missed something), and to give some feedback so people understand what
I am doing.


First the connections.
- I have a patch I am maintaining (kexec) for booting linux and other
  OS's from linux.  This patch is not x86 specific (it does take
  architecture specific code). It takes as input an ELF file.

- I am working on a native LinuxBIOS port of Linux, and LinuxBIOS
  takes as an input a ELF formated kernel.

- I need regularly network boot with etherboot, and an ELF formated
  kernel can be used natively.  bzImage needs help.

- It is a pain not when switching platforms alpha/ia32/xxx to have to
  completely change your toolchain for booting the linux kernel.

- I have a patch that makes the x86 linux kernel natively ELF
  bootable.


What a bootable ELF formatted kernel is.
- A list of segments that say load this chunk of file at this physical
  address. 

- An 32bit entry point. (64bit on 64bit platforms).

- Code at that entry point to query from the firmware/BIOS the
  information the kernel needs.


My next step is to integrate all of my pieces and do some cleanup but
I have functioning code for everything.

An x86 ELF bootable kernel:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/linux-2.4.17.elf_bootable.diff

A patch to boot an arbitrary static ELF executeable.
ftp://download.lnxi.com/pub/src/linux-kernel-patches/linux-2.4.17.eb-kexec-apic-lb-mtd2.diff

A kernel fix to do proper SMP shutdown so that you can kexec on a SMP kernel
ftp://download.lnxi.com/pub/src/linux-kernel-patches/linux-2.4.17.eb-apic-lb-mtd2.diff

A kernel patch that implements minimal some LinuxBIOS support.
ftp://download.lnxi.com/pub/src/linux-kernel-patches/linux-2.4.18-pre7.linuxbios.diff

A standalone executable to adapt an existing x86 bzImage to be an ELF
bootable kernel.
ftp://download.lnxi.com/pub/src/mkelfImage/mkelfImage-1.12.tar.gz

A first draft of a specification that goes into detail about how an
ELF image is interpreted, and extensions that can be added so the
bootloader name, the bootloader version, and similar interesting but
functionally unnecessary information can be passed to the loaded 
image, and so the bootloader can find out similar kinds of information
about the ELF executable it is loading.
ftp://download.lnxi.com/pub/src/linuxbios/specifications/draft1_elf_boot_proposal.txt


For what it is worth I have gotten fairly positive feedback from both
the Etherboot and the LinuxBIOS communities so far.   And etherboot
and memtest86 have both been modified already to be ELF bootable.  And
there is current work that gets a long ways with Plan9.

My kexec work is direct competition to two kernel monte, bootimage,
lobos.  I have been using it in production for about a year, and I
haven't encountered real problems.  The biggest issue I have had is
with the kernel not properly shutting down devices.  

In the short term shutting down devices is trivially handled by
umounting filesystems, downing ethernet devices, and calling the
reboot notifier chain.  Long term I need to call the module_exit
routines but they need a little sorting out before I can use them
during reboot.  In particular calling any module_exit routing that clears
pm_power_off is a no-no.

Also while it should work in most cases any loaded ELF image that
starts using BIOS/firmware services to drive the hardware is on it's
own.  Putting all devices back in a state that they match the
firmwares cached state is a poorly defined problem.  However normal
firmware calls that ask if for the memory size or IRQ routing
information should work correctly.

More on etherboot can be found at:
http://www.etherboot.org

More on LinuxBIOS can be found at:
http://www.linuxbios.org

Eric
