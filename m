Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129492AbQKYBZm>; Fri, 24 Nov 2000 20:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130306AbQKYBZc>; Fri, 24 Nov 2000 20:25:32 -0500
Received: from ip165-45.fli-ykh.psinet.ne.jp ([210.129.165.45]:29379 "EHLO
        standard.erephon") by vger.kernel.org with ESMTP id <S129492AbQKYBZT>;
        Fri, 24 Nov 2000 20:25:19 -0500
Message-ID: <3A1F0DF0.AECF7057@yk.rim.or.jp>
Date: Sat, 25 Nov 2000 09:55:13 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76C-ja  [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test-11: K7 compile error: `current' missing in string macro. 
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test-11: K7 compile error: `current' missing in string macro.

Symptom:
2.4.0-test11 won't compile with K7 if we choose it for CPU.

The compile error is attached at the end.



The same config except for CPU (AMD K6) works.
The diff of config is shown immediately below.
(I saved the old config from some early test-1x series
compilation.)


ishikawa@standard$ diff -C1 -cibw ~/config-saved /usr/src/linux/.config
*** /home/ishikawa/config-saved Fri Nov 24 13:44:30 2000
--- /usr/src/linux/.config      Sat Nov 25 09:29:17 2000
***************
*** 31,34 ****
  # CONFIG_MPENTIUM4 is not set
! CONFIG_MK6=y
! # CONFIG_MK7 is not set
  # CONFIG_MCRUSOE is not set
--- 31,34 ----
  # CONFIG_MPENTIUM4 is not set
! # CONFIG_MK6 is not set
! CONFIG_MK7=y
  # CONFIG_MCRUSOE is not set
***************
*** 42,46 ****
  CONFIG_X86_POPAD_OK=y
! CONFIG_X86_L1_CACHE_SHIFT=5
! CONFIG_X86_ALIGNMENT_16=y
  CONFIG_X86_TSC=y
  CONFIG_X86_USE_PPRO_CHECKSUM=y
--- 42,48 ----
  CONFIG_X86_POPAD_OK=y
! CONFIG_X86_L1_CACHE_SHIFT=6
  CONFIG_X86_TSC=y
+ CONFIG_X86_GOOD_APIC=y
+ CONFIG_X86_USE_3DNOW=y
+ CONFIG_X86_PGE=y
  CONFIG_X86_USE_PPRO_CHECKSUM=y
ishikawa@standard$

HALF-HEARTED FIX suggestion.:

I looked around and found asm/current.h had this
#define current get_current()

I thought including asm/current.h in string.h
would fix it. (And it would.)

HOWEVER, I was a little puzzled at the comment
in string.h just before the 3d-now related macros.:

    #ifdef CONFIG_X86_USE_3DNOW

    /* All this just for in_interrupt() ... */

    #include <asm/system.h>
    #include <asm/ptrace.h>
    #include <linux/smp.h>
    #include <linux/spinlock.h>
    #include <linux/interrupt.h>
    #include <asm/mmx.h>

    /*
     *  This CPU favours 3DNow strongly (eg AMD Athlon)
     */


QUESTION: Shouldn't this code  be enabled for AMD K6-III
(not K7), too? (It would boost the performance on this CPU if so.)
Or does K6-III lack some instructions of 3D-Now (available
in K7, Athlon or Duron) and so can't use these macros?

Either way, asm/current.h needs to be included
somewhere (probably after the include statements quoted above?)

[I should not ask too much in one post, but will the kernel compiled
for AMD-K6-III work for AMD K7  Duron 750 ?
I booted the kernel compiled for K6-III on a Duron 750 PC and
it booted up to where the SCSI Symbios 58xxx driver
failed due to SCRIPT loading error or something.  Could be a motherboard

error.
I began investigating and realized the CPU mismatch, but the
new compilataion failed as noted here. But it seemed
to boot up fine up until the point, FYI.)

Observed compile error:

standard:/usr/src/linux# LC_ALL=C
standard:/usr/src/linux#
standard:/usr/src/linux#
standard:/usr/src/linux#
standard:/usr/src/linux# make bzImage
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -c -o
init/main.o init/main.c
In file included from /usr/src/linux/include/linux/irq.h:57,
                 from /usr/src/linux/include/asm/hardirq.h:6,
                 from /usr/src/linux/include/linux/interrupt.h:45,
                 from /usr/src/linux/include/asm/string.h:296,
                 from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears
in.)
In file included from /usr/src/linux/include/asm/string.h:296,
                 from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first
use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared
(first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared
(first use in this function)
In file included from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use
in this function)
make: *** [init/main.o] Error 1
standard:/usr/src/linux#


TIA



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
