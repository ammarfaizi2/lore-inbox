Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbRBVVT2>; Thu, 22 Feb 2001 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbRBVVTH>; Thu, 22 Feb 2001 16:19:07 -0500
Received: from ppp-014.cust210-9-19.ghr.chariot.net.au ([210.9.19.14]:59397
	"EHLO mars.foursticks.com.au") by vger.kernel.org with ESMTP
	id <S129688AbRBVVS5>; Thu, 22 Feb 2001 16:18:57 -0500
To: linux-kernel@vger.kernel.org
cc: pschulz@foursticks.com
Subject: (my) kgdb patch brakes compile.
Date: Fri, 23 Feb 2001 07:48:20 +1030
From: Paul Schulz <pschulz@foursticks.com.au>
Message-Id: <E14W38P-0001OZ-00@mars.foursticks.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have been sucessfully able to take Amit S. Kale (akale@veritas.com)
kgdb patch for 2.4.0-test9, and create a patch for 2.4.0-test12.

I am trying to create a patch for 2.4.1.. but gcc barfs with the
following:

---------------------------------------------------------------------
make[3]: Entering directory `/usr/src/linux-2.4.1-kgdb/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.1-kgdb/include -Wall -Wstrict-prototypes -g -pipe -mpreferred-stack-boundary=2 -march=i686    -fno-omit-frame-pointer -c -o sched.o sched.c
sched.c: In function `schedule':
sched.c:648: Invalid `asm' statement:
sched.c:648: fixed or forbidden register 6 (bp) was spilled for class GENERAL_REGS.
make[3]: *** [sched.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.1-kgdb/kernel'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.1-kgdb/kernel'
make[1]: *** [_dir_kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.1-kgdb'
make: *** [stamp-build] Error 2
---------------------------------------------------------------------
This can be traced to include/asm_i386/system.h.. (switch_to)
---------------------------------------------------------------------
#define prepare_to_switch()	do { } while(0)
#Define switch_to(prev,next,last) do {					\
	asm volatile("pushl %%esi\n\t"					\
		     "pushl %%edi\n\t"					\
		     "pushl %%ebp\n\t"					\
		     "movl %%esp,%0\n\t"	/* save ESP */		\
		     "movl %3,%%esp\n\t"	/* restore ESP */	\
		     "movl $1f,%1\n\t"		/* save EIP */		\
		     "pushl %4\n\t"		/* restore EIP */	\
		     "jmp __switch_to\n"				\
		     "1:\t"						\
		     "popl %%ebp\n\t"					\
		     "popl %%edi\n\t"					\
		     "popl %%esi\n\t"					\
		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
		      "=b" (last)					\
		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
		      "a" (prev), "d" (next),				\
		      "b" (prev));					\
} while (0)
---------------------------------------------------------------------
Can someone explain what is the problem here? I'm assuming that it's 
one of the compile options.

The kgdb patch puts the following in the top level makefile...
and put a switch for $(CONFIG_X86_REMOTE_DEBUG) in the config tool.

The kernel compiles fine without the patch, and with the patch, 
with the option turned off.
---------------------------------------------------------------------
CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes
ifeq ($(CONFIG_X86_REMOTE_DEBUG),y)
CFLAGS += -g
else
CFLAGS += -fomit-frame-pointer -O2 -fno-strict-aliasing
endif
--------------------------------------------------------------------

Thanks,
Paul Schulz




