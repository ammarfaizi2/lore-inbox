Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313500AbSC3QbK>; Sat, 30 Mar 2002 11:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313501AbSC3QbB>; Sat, 30 Mar 2002 11:31:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50219 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313500AbSC3Qan>; Sat, 30 Mar 2002 11:30:43 -0500
To: <linux-kernel@vger.kernel.org>
Subject: [CFT][RFC] Linux/i386 boot protocol version 2.04
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Mar 2002 09:24:28 -0700
Message-ID: <m1d6xmuipv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been doing some very weird things with booting the Linux kernel
for a long time.  
  - Entering the kernel in 32bit mode to avoid 16bit BIOS calls.  
  - Converting bzImage into static ELF executables.  
  - Hard coding a kernel command-line
  - Going back to 16bit mode to make BIOS calls if necessary.

This version of the boot protocol should be fully backwards compatible
but has new capabilities so I can do all of the above cleanly.

The current plan is to send this to Linus in the next couple of days
as soon as he gets back.


The patch series is at:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/

The overall patch is:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.7.boot.diff

Anyway please tell me what you think.

Eric


This is a log of a series of patches that cleans up and enhances the
x86 boot process.

2.5.7.boot.linuxbios 8
============================================================
Support for reading information from the linuxbios table.
For now I just get the memory size more to come as things
evolve.

2.5.7.boot.proto 7
============================================================
Update the boot protocol to include:
   - A compiled in command line
   - A 32bit entry point
   - File and memory usage information enabling a 1 to 1 
     conversion between the bzImage format and the static ELF
     executable file format.

   - In setup.c split the parameters between those that
     are compiled in and those that are

2.5.7.boot.build 6
============================================================
Rework the actual build/link step for kernel images.  
- remove the need for objcopy
- Kill the ROOT_DEV Makefile variable, the implementation
  was only half correct and there are much better ways
  to specify your root device than modifying the kernel.
- Don't loose information when the executable is built

Except for a few extra fields in setup.S the binary image
is unchanged.

2.5.7.boot.heap 5
============================================================
Modify video.S so that mode_list is also allocated from
the boot time heap.  This probably saves a little memory,
and makes a compiled in command line a sane thing to implement.

- Made certain we don't overwrite code with the E820_MAP

- Changed the lables around the setup.S to _setup && _esetup


2.5.7.boot.pic16 4
============================================================
  All changes are syntactic the generate code should not
  be affected at all.

- Modify the 16 bit code files bootsect.S video.S setup.S so they may
  linked with any virtual address, not just 0.  The code is already
  PIC this just makes the build process the same.

- e820.h Add define E820ENTRY_SIZE

- Add define KERNEL_START in setup.S so if I need this
  value more than once it is easy to get at.

2.5.7.boot.32bit_entry 3
============================================================
- trampoline.S fix comments, and enter the kernel at
  secondary_startup_32 instead of startup_32
- trampoline.S fix gdt_48 to have the correct gdt limit
- Save all of the registers we get from any 32bit entry point,
  and don't assume they have any particular value.
- head.S split up startup_32
  - secondary_startup_32 handles the SMP case
  - move finding the command line to startup.c
  - Don't copy the kernel parameters to the initial_zero_page,
    instead just pass setup.c where they are located.
  All of these are what it takes to remove the assumptions
  of what register values we get on entry.  And let's us
  handle those assumptions up in C code.
- Seperate the segments used by setup.S from the rest of the kernel.
  This way bootloader can continue to make assumptions about
  which segments setup.S uses while the rest of the kernel
  can do whatever is convinient.
- Move boot specific defines into boot.h

2.5.7.boot.vmlinuxlds 2
============================================================
- i386/Makefile remove bogus linker command line of -e stext
- Fix vmlinux.lds so vmlinux knows it loads at 0x100000 (1MB)
- Fix vmlinux.lds so we correctly use startup_32 for our entry point

2.5.7.boot.boot_params 1
============================================================
- Introduce asm-i386/boot_param.h and struct boot_params
- Implement struct boot_params in misc.c & setup.c

This removes a lot of magic macros and by keeping all of the
boot parameters in a structure it becomes much easier to track
which boot_paramters we have and where they live.  Additionally
this keeps the names more uniform making grepping easier.

