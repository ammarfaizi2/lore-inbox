Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314527AbSEBObR>; Thu, 2 May 2002 10:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSEBObQ>; Thu, 2 May 2002 10:31:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5993 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314527AbSEBObO>; Thu, 2 May 2002 10:31:14 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.12] x86 boot enhancements
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 08:23:26 -0600
Message-ID: <m16626zl0h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My patches to build improve the x86 boot process are now
available at:
ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/index.html 
http://www.xmission.com/~ebiederm/files/boot/index.html
There is one summary patch and the rest are incremental patches,
not significant changes have been made.

Eric


#11  boot.elf
============================================================
Add support for generating an ELF executable kernel.  External
tools are only needed now to manipulate the command line,
and to add a ramdisk.  For netbooting this is very handy.

To revert to a bzImgae you simply strip off the the ELF header.
This should keep the kinds of kernel images floating around low.


#10  boot.linuxbios
============================================================
Support for reading information from the linuxbios table.
For now I just get the memory size more to come as things
evolve.

#9  boot.proto
============================================================
Update the boot protocol to include:
   - A compiled in command line
   - A 32bit entry point
   - File and memory usage information enabling a 1 to 1 
     conversion between the bzImage format and the static ELF
     executable file format.

   - In setup.c split the parameters between those that
     are compiled in or specified by the bootloader and 
     those that are queried from the BIOS.

#8  boot.build
============================================================
Rework the actual build/link step for kernel images.  
- remove the need for objcopy
- Kill the ROOT_DEV Makefile variable, the implementation
  was only half correct and there are much better ways
  to specify your root device than modifying the kernel Makefile.
- Don't loose information when the executable is built

Except for a few extra fields in setup.S the binary image
is unchanged.

#7  boot.footprint
============================================================
Solve the space/reliability tradeoff misc.c asks bootloaders
to make, with belt and suspenders.

- modify misc.c to relocate the real mode code to maximize low
  memory usage.
- modify misc.c to do inplace decompression
- modify setup.S to query int12 to get the low memory size
- Introduce STAY_PUT flag for bootloaders that don't pass a
  command_line but still don't need the bootsector to relocate
  itself. 

The kernel now uses approximately 78KB of memory below 1MB and 8 bytes
more than the decompressesed kernel above 1MB.  And if required
everything except the 5KB of real mode code can go above 1MB.

The 78KB below 1MB is 5KB real mode code 10KB decompressor code 61KB bss. 

The change is especially nice because now in my worst case of only
using 5KB real mode data, I do better than the best case with previous
kernels (assuming it isn't a zImage).  With the the bootmem bitmap
reserved in vmlinux.lds I can put initrds down at 2.6MB and not have
to worry about them getting stomped :)

#6  boot.clean_32bit_entries
============================================================
In general allow any kernel entry point to work given any set of
initial register values, while saving the original registers
values so the C code can do something with it if we desire.

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
- Seperate the segments used by setup.S from the rest of the kernel.
  This way bootloader can continue to make assumptions about
  which segments setup.S uses while the rest of the kernel
  can do whatever is convinient.
- Move boot specific defines into boot.h

#5  boot.heap
============================================================
Modify video.S so that mode_list is also allocated from
the boot time heap.  This probably saves a little memory,
and makes a compiled in command line a sane thing to implement.

- Made certain we don't overwrite code with the E820_MAP
  Previously we actually reserved to much memory.

- Changed the lables around the setup.S to _setup && _esetup

The Effective the bootsector size is reduced by 200 bytes.

#4  boot.syntax
============================================================
  All changes are syntactic the generated code is not affected.

- e820.h Add define E820ENTRY_SIZE

- boot.h Add defines for address space divisions.

- Add define KERNEL_START in setup.S so if I need this
  value more than once it is easy to get at.

#3  boot.spring-cleaning
============================================================
Some pieces of code only make sense if we are a bzImage or
a zImage.  Since size is relatively important use conditional
compilation to select between the two.

Plus this clearly marks dead code that we can kill we we drop
support for the zImage format.

#2  boot.vmlinuxlds
============================================================
- i386/Makefile remove bogus linker command line of -e stext
- Fix vmlinux.lds so vmlinux knows it loads at 0x100000 (1MB)
- Fix vmlinux.lds so we correctly use startup_32 for our entry point
- Fix vmlinux.lds so we reserve the bootmem bitmap at the end
  of the bss segment.
- Make startup_32 global

#1  boot.boot_params
============================================================
- Introduce asm-i386/boot_param.h and struct boot_params
- Implement struct boot_params in misc.c & setup.c

This removes a lot of magic macros and by keeping all of the
boot parameters in a structure it becomes much easier to track
which boot_paramters we have and where they live.  Additionally
this keeps the names more uniform making grepping easier.

