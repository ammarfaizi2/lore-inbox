Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261762AbSI2UJb>; Sun, 29 Sep 2002 16:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbSI2UJb>; Sun, 29 Sep 2002 16:09:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47370 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261762AbSI2UJ2>;
	Sun, 29 Sep 2002 16:09:28 -0400
Date: Sun, 29 Sep 2002 21:14:51 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: of 2.5.39 on none-x86
Message-ID: <20020929201451.GH2153@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 21:09:03 up 2 days,  1:06,  1 user,  load average: 0.10, 0.55, 0.64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was kind of triggered by the discussion on the 2.6 v 3.0 thread
about how many people are trying 2.5.x.

I've just tried cross building 2.5.39 for various architectures.  This
is from the standard 2.5.39 dist without any architecture specific
patches.

The crosses were done from Debian/sid with the toolchain-source package
having built the compiler/tool chains.

All builds were done with the form:

make CROSS_COMPILE=....-linux- ARCH=.... 

The results aren't pretty:

Alpha:
------
Configured for LX164; built the vmlinux and then hit:

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer tools/objstrip.c
-o tools/objstrip
tools/objstrip.c: In function `main':
tools/objstrip.c:191: warning: long unsigned int format, Elf32_Addr arg
(arg 5)
tools/objstrip.c:198: structure has no member named `fh'
tools/objstrip.c:204: structure has no member named `fh'
tools/objstrip.c:204: structure has no member named `ah'
tools/objstrip.c:216: structure has no member named `ah'
tools/objstrip.c:216: structure has no member named `ah'
tools/objstrip.c:217: structure has no member named `ah'
tools/objstrip.c:221: structure has no member named `ah'
tools/objstrip.c:222: structure has no member named `ah'
tools/objstrip.c:265: warning: long unsigned int format, size_t arg (arg
4)
make[1]: *** [tools/objstrip] Error 1

MIPS
----
Configured for SGI IP22.

  mips-linux-gcc -Wp,-MD,./.offset.s.d -I
	/discs/cross/kernels/t/linux-2.5.39/include/asm/gcc -D__KERNEL__
	-I/discs/cross/kernels/t/linux-2.5.39/include -Wall
	-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
	-fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic
	-mcpu=r4600 -mips2 -Wa,--trap -pipe -nostdinc -iwithprefix include
	-DKBUILD_BASENAME=offset   -S -o offset.s offset.c 
	<blah blah...):
	/discs/cross/kernels/t/linux-2.5.39/include/linux/thread_info.h:11:29:
	asm/thread_info.h: No such file or directory

hppa
----
/discs/cross/kernels/linux-2.5.39/include/asm/system.h:72:1: warning:
"local_irq_restore" redefined
/discs/cross/kernels/linux-2.5.39/include/asm/system.h:66:1: warning:
this is the location of the previous definition
/discs/cross/kernels/linux-2.5.39/include/linux/thread_info.h:11:29:
asm/thread_info.h: No such file or directory

s390
----
discs/cross/kernels/linux-2.5.39/include/linux/rwsem.h:110: warning:
implicit declaration of function `__downgrade_write'
In file included from
/discs/cross/kernels/linux-2.5.39/include/asm/smp.h:14,
                 from
/discs/cross/kernels/linux-2.5.39/include/linux/smp.h:16,
                 from
/discs/cross/kernels/linux-2.5.39/include/linux/sched.h:24,
                 from
/discs/cross/kernels/linux-2.5.39/include/linux/mm.h:4,
                 from sched.c:19:
/discs/cross/kernels/linux-2.5.39/include/linux/ptrace.h: In function
`ptrace_link':
/discs/cross/kernels/linux-2.5.39/include/linux/ptrace.h:42:
dereferencing pointer to incomplete type

ppc
---
 fix needed at line 57 arch/ppc/Makefile - split line
 breaking in IDE build, adb

arm
---
make menuconfig    hung in awk (took 700M of RAM and climbing)
make xconfig fails 'Error in startup script: invalid command name
"clear_choices"'

after manual config:

  arm-linux-gcc -Wp,-MD,./.softirq.o.d -D__KERNEL__
-I/discs/cross/kernels/linux-2.5.39/include -Wall -Wstrict-prototypes
-Wno-trigraphs -Os -fno-strict-aliasing -fno-common -mapcs-32
-D__LINUX_ARM_ARCH__=4 -march=armv4 -mtune=arm9tdmi -mshort-load-bytes
-msoft-float -nostdinc -iwithprefix include    -DKBUILD_BASENAME=softirq
-c -o softirq.o softirq.c
  In file included from softirq.c:19:
  /discs/cross/kernels/linux-2.5.39/include/linux/percpu.h:4:24:
asm/percpu.h: No such file or directory
  softirq.c:154: parse error before "tasklet_vec"
  softirq.c:154: warning: type defaults to `int' in declaration of
`DEFINE_PER_CPU'

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
