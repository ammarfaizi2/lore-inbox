Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSKCLVZ>; Sun, 3 Nov 2002 06:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSKCLVZ>; Sun, 3 Nov 2002 06:21:25 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33806 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261732AbSKCLVX>; Sun, 3 Nov 2002 06:21:23 -0500
Message-Id: <200211031122.gA3BMYp27801@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>
Subject: 2.5.45: gcc 3.2 aligns everything to 16 bytes when I compile for 486
Date: Sun, 3 Nov 2002 14:14:32 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm compiling 2.5.45 for 486.

For example, exit.c got compiled with this command:

gcc -v -Wp,-MD,kernel/.exit.o.d -D__KERNEL__ -Iinclude -Wall \
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 \
-march=i486 -Iarch/i386/mach-generic -nostdinc -iwithprefix include \
-DKBUILD_BASENAME=exit -c -o zz25.o kernel/exit.c

Whereas for 2.4, command is different:

gcc -v -D__KERNEL__ -Iinclude -Iarch/i386/mach-generic \
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing \
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i386 -nostdinc \
-iwithprefix include -DKBUILD_BASENAME=exit -c -o zz24.o kernel/exit.c

(commands slightly adapted to actually execute in 2.5 tree and
don't destroy exit.o)

As you can see, the difference is in -march=.
2.5 compiles for 486. I have nothing against 486, but
gcc 3.x got nasty habit of aligning functions and sometimes
*even loops* to 16 bytes. Result:

objdump -D exit.o, abridged
=================================
exit.o:     file format elf32-i386

Disassembly of section .text:

00000000 <__unhash_process>:
00000130 <release_task>:
000002f0 <unhash_process>:
     348:	90                   	nop
     349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,1),%esi
00000350 <session_of_pgrp>:
     3d7:	90                   	nop
     3d8:	90                   	nop
     3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,1),%esi
000003e0 <__will_become_orphaned_pgrp>:
     46b:	90                   	nop
     46c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
00000470 <will_become_orphaned_pgrp>:
     4ac:	8d 74 26 00          	lea    0x0(%esi,1),%esi
000004b0 <is_orphaned_pgrp>:
     4bf:	90                   	nop    

Tons of wasted space.

my .config, oldconfig'ed from 2.4, is below. What's that, marked <=== ?

#
# Processor type and features
#
# CONFIG_M386 is not set
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y           <============= ??!
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=32
# CONFIG_X86_NUMA is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
