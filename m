Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRBVVmZ>; Thu, 22 Feb 2001 16:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbRBVVmS>; Thu, 22 Feb 2001 16:42:18 -0500
Received: from www.microgate.com ([216.30.46.105]:52239 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S129981AbRBVVl7>; Thu, 22 Feb 2001 16:41:59 -0500
Message-ID: <003f01c09d18$4e037800$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <linux-kernel@vger.kernel.org>
Cc: <pschulz@foursticks.com>
In-Reply-To: <E14W38P-0001OZ-00@mars.foursticks.com.au>
Subject: Re: (my) kgdb patch brakes compile.
Date: Thu, 22 Feb 2001 15:42:07 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think your problem is removing all optimization
(removing '-O2' when kgdb option is enabled).

I realize that debugging is easier with no optimization
but the kernel compile always spilled registers for me
when using -O0. I can do -O1 or -O2 with no problem.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


----- Original Message -----
From: "Paul Schulz" <pschulz@foursticks.com.au>
To: <linux-kernel@vger.kernel.org>
Cc: <pschulz@foursticks.com>
Sent: Thursday, February 22, 2001 3:18 PM
Subject: (my) kgdb patch brakes compile.


> Greetings,
>
> I have been sucessfully able to take Amit S. Kale (akale@veritas.com)
> kgdb patch for 2.4.0-test9, and create a patch for 2.4.0-test12.
>
> I am trying to create a patch for 2.4.1.. but gcc barfs with the
> following:
>
> ---------------------------------------------------------------------
> make[3]: Entering directory `/usr/src/linux-2.4.1-kgdb/kernel'
>
gcc -D__KERNEL__ -I/usr/src/linux-2.4.1-kgdb/include -Wall -Wstrict-prototyp
es -g -pipe -mpreferred-stack-boundary=2 -march=i686    -fno-omit-frame-poin
ter -c -o sched.o sched.c
> sched.c: In function `schedule':
> sched.c:648: Invalid `asm' statement:
> sched.c:648: fixed or forbidden register 6 (bp) was spilled for class
GENERAL_REGS.
> make[3]: *** [sched.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.1-kgdb/kernel'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.1-kgdb/kernel'
> make[1]: *** [_dir_kernel] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.1-kgdb'
> make: *** [stamp-build] Error 2
> ---------------------------------------------------------------------
> This can be traced to include/asm_i386/system.h.. (switch_to)
> ---------------------------------------------------------------------
> #define prepare_to_switch() do { } while(0)
> #Define switch_to(prev,next,last) do { \
> asm volatile("pushl %%esi\n\t" \
>      "pushl %%edi\n\t" \
>      "pushl %%ebp\n\t" \
>      "movl %%esp,%0\n\t" /* save ESP */ \
>      "movl %3,%%esp\n\t" /* restore ESP */ \
>      "movl $1f,%1\n\t" /* save EIP */ \
>      "pushl %4\n\t" /* restore EIP */ \
>      "jmp __switch_to\n" \
>      "1:\t" \
>      "popl %%ebp\n\t" \
>      "popl %%edi\n\t" \
>      "popl %%esi\n\t" \
>      :"=m" (prev->thread.esp),"=m" (prev->thread.eip), \
>       "=b" (last) \
>      :"m" (next->thread.esp),"m" (next->thread.eip), \
>       "a" (prev), "d" (next), \
>       "b" (prev)); \
> } while (0)
> ---------------------------------------------------------------------
> Can someone explain what is the problem here? I'm assuming that it's
> one of the compile options.
>
> The kgdb patch puts the following in the top level makefile...
> and put a switch for $(CONFIG_X86_REMOTE_DEBUG) in the config tool.
>
> The kernel compiles fine without the patch, and with the patch,
> with the option turned off.
> ---------------------------------------------------------------------
> CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes
> ifeq ($(CONFIG_X86_REMOTE_DEBUG),y)
> CFLAGS += -g
> else
> CFLAGS += -fomit-frame-pointer -O2 -fno-strict-aliasing
> endif
> --------------------------------------------------------------------
>
> Thanks,
> Paul Schulz
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

