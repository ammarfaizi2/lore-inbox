Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSGMXY5>; Sat, 13 Jul 2002 19:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSGMXY4>; Sat, 13 Jul 2002 19:24:56 -0400
Received: from pl1787.nas911.n-yokohama.nttpc.ne.jp ([210.139.45.251]:57795
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id <S315454AbSGMXYv>; Sat, 13 Jul 2002 19:24:51 -0400
Message-ID: <3D30B76A.1090804@yk.rim.or.jp>
Date: Sun, 14 Jul 2002 08:27:38 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Q: boot time memory region recognition and clearing.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the feedback.

While I would not rule out the  possibility
of actual memory error occuring,
I think it is highly unlikely. I will explain the reasoning below, but
before proceeding, here is a question to the list in general.

Q: Does anyone know for sure

   - what the memory area used by the kernel code and
     its data structure including stack during
     the call to routines to arch/i386/kernel/setup.c.
     
  [If there is a formula to calculcate the upper limit boundary using
   a variable or two,   it is better :-) ]

  I am trying to see if I can simply add
  a memory clearing routine arch/i386/kernel/setup.c
  instead of hacking the arch/i386/boot/setup.S.

  Knowing the used area makes it possible to
  clear the known available memory space with, say, 0's.

  This only permits me to clear the area not used by
  the kernel code and stuff at the time of call, but this is close enough
  and much better than the current state of the affairs
  for my ECC experimentation...
 
Now back to why I think the memory problem warning from ecc.o on my PC
is bogus.

I am speaking this from my experience of having
a real memory error in past and that I could notice the  problem
rather quickly from erratic system behavior.

If we have a memory problem,  sooner or later we will see that

 - the system may lock up,

 - kernel recompilation may fail,

 - recompilation of large software package such as xfree86 may fail, or

 - running many copies of bonnie and the similar test programs may
   fail.

But nothing like this happens on my PC for some time.
I did experience the above mentioned problems when
there WAS a memory problem with a memory board. After figuring
that there was a hardware problem I ran memtest86.
Memtest86 detected errors only after about a few minutes of
running and I was impressed.

Now, your friend's use of rand() to test memory is a good idea
although I do think the systematic approach of memtest86 is necesary when
I consider the "typical" error patterns in memory chips. (I know
companies who make memory chips have special in-house memory test
programs. I wonder if any of these programs would be made publicly
available sometime in the future. Caveat: one company's test program
may not be effective to another's memory chip. Internal memory cell
layout and wiring patters have much to do with "typical" memory
patterns of one vendor's make.)  In any case, it might be a good
idea to add such random patterns as the last entry to the test patterns
of memtest86 although the chance of finding errors not found by the
existing patterns may be small indeed.

Testing memory problems is a fairly complex
problem and I want to see a kernel support for ECC
module and that is why I have been toying with
ecc.o module and pondering on the memory clearing issues.

Back to my PC's ECC handling.
 
Now after running the memtest86 version 3.0 downloded from

    www.memtest86.com

which indeed has the ECC memory controller suppport now, for
a few hours, I found that it didn't find any errors.

Considering that the amd751 controller is supported
by the memtest86 v3 and the linux ecc support project ecc.c
module (although I use a locally modified version of
ecc.c) it is a little strange that one reports the error
and the other doesn't.

I am not excluding that the real world memory usage
patterns may cause an error which memtest86
doesn't discover using its test patterns,
but from the experience
I explained above, I am looking for other causes currently.

- Maybe my local ecc.c hack is incorrect.
  But it is unlilely.
  (I have checked this out. I compared what ecc.c and controller.c of
   memtest86 does.
   I found there is slight difference in handling error output from AMD751.
   This is about locating the bank # of the memory chip where the error
   occurs, but otherwise, the code seems to be logically identical.
   I have downloaded the AMD751 pdf file again to make sure
   bank # calculation is OK.
   I then found the difference is cosmetic. My ecc.c reports
   only the bank # while memtest86 tries to infer the starting memory 
address
   of that bank. Fair enough. So the ecc.c code is OK. Both
   memtest86 controller.c and ecc.c follow the AMD documentation. So
   we are OK unless there is a typo in AMD doc.)

- Opportunistic memory access of AMD CPU.

  The opportunistic memory access of AMD CPU might
  cause the CPU to read a byte or two which the
  CPU is not supposed to read. (Maybe
  it is reading a memory mapped I/O area or something, say, unmapped
  memory area??? by this opportunistic memory read mechanism?)

  After following the discussion on ECC mailing list where
  it was suggested that boot command line option
  mem=nopentium would disable the
  opportunistic read of AMD CPU and might solve the bogus ecc.o warning
  message, I have added mem=nopentium on the boot command line, i.e.,

  mem=nopentium devfs=mount drm=debug root=/dev/sda6 ro \
  scsihosts=sym53c8xx:tmscsim BOOT_IMAGE=lin2418.img

  But the bogus message still appears (and as if it depends on
  the phase of the moon. After I boot into win98 first and
  use memory using mozilla, and then reboot into linux, the
  warning disappears. Some of you might be saying, "transient error!".
  Well, if I boot under linux and see the warning message and
  run mozilla and others, and THEN reboot into linux again,
  it is likely that I see warning messages again. So I think
  there is linux-specific thingy about this warning message.)

Can it be that mem=nopentium support is not quite working on
linux kernel 2.4.18?

I am not sure what "mem=nopentium" does, though.

Quick search through the linux 2.4.18 source tree reveals the
reference to the C macro, X86_FEATURE_PSE,
which this mem=nopentium clears in CPU capability settting.

/usr/src/linux/include/asm-i386/processor.h:#define cpu_has_pse   
 (test_bit(X86_FEATURE_PSE,  boot_cpu_data.x86_capability))
/usr/src/linux/include/asm-i386/cpufeature.h:#define X86_FEATURE_PSE    
 (0*32+ 3) /* Page Size Extensions */
/usr/src/linux/include/asm-i386/cpufeature.h:#define X86_FEATURE_PSE36   
 (0*32+17) /* 36-bit PSEs */
/usr/src/linux/arch/i386/kernel/setup.c:               
 clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);

I wonder why there are two macros, X86_FEATURE_PSE, and
X86_FEATURE_PSE36, but I digress.

OK so cpu_has_pse macro should be  used somewhere.
A quick search reveled these references.

/usr/src/linux/include/asm-i386/processor.h:#define cpu_has_pse   
 (test_bit(X86_FEATURE_PSE,  boot_cpu_data.x86_capability))
/usr/src/linux/arch/i386/mm/init.c:            if (cpu_has_pse) {

I read init.c but not quite so sure what it does yet as far as
oppotunitisc read of AMD CPU is concerned.
(Does memory page size have something to do with eliminating
opportunistic read of AMD CPU?)

arch/i386/kernel/setup.c contains numerous comments about
tricky business of these CPU registers. Is it possible somehow
AMD memory access mechanism is not handled quite right under 2.4.18
as far as opportunistic memory access is concerned?
(Or maybe I have a buggy Duron CPU. :-).)
(Sorry searching through the kernel source file for "opportunistic"
ended in two references totally urelated to the subject at hand.
/usr/src/linux/fs/coda/upcall.c:    The statements below are part of the 
Coda opportunistic
/usr/src/linux/mm/swapfile.c: * work, but we opportunistically check whether


Anyway, if someone can answer my question above
 >Q: Does anyone know for sure
 >
 >   - what the memory area used by the kernel code and
 >     its data structure including stack during
 >     the call to routines to arch/i386/kernel/setup.c.

I would be able to test if clearing memory with 0's first
might help.

(Or I may hack memtest86 and loadlin to
run memory test first and then load linux kernel as was
suggested on ECC mailing list.)

cf.
Part of my .config file:

     Hmm... Maybe I should build in the following options for
     the correct AMD cpu mem=nopentium usage?

     >CONFIG_X86_MSR=m
     >CONFIG_X86_CPUID=m
     ??? Well, these only offer the support for reading the
         priviledged registers via device file, and
         should not matter.

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set







