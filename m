Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135626AbREBQQB>; Wed, 2 May 2001 12:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135623AbREBQOY>; Wed, 2 May 2001 12:14:24 -0400
Received: from ludwig-alpha.unil.ch ([192.42.197.33]:33182 "EHLO
	ludwig-alpha.unil.ch") by vger.kernel.org with ESMTP
	id <S135618AbREBQOD>; Wed, 2 May 2001 12:14:03 -0400
Message-Id: <200105021613.SAA22580@ludwig-alpha.unil.ch>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.4-ac3, asm problem in asm-i386/rwsem.h using gcc 3.0 CVS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 May 2001 18:13:59 +0200
From: Christian Iseli <chris@ludwig-alpha.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I currently fail to compile the 2.4.4-ac3 kernel using latest GCC 3.0 from CVS:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
 -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
 -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname':
/usr/src/linux/include/asm/rwsem.h:152:
 inconsistent operand constraints in an `asm'

Here is the code exerpt:
/*
 * unlock after reading
 */
static inline void __up_read(struct rw_semaphore *sem)
{
        __s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
        __asm__ __volatile__(
                "# beginning __up_read\n\t"
LOCK_PREFIX     "  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
                "  js        2f\n\t" /* jump if the lock is being waited upon */
                "1:\n\t"
                ".section .text.lock,\"ax\"\n"
                "2:\n\t"
                "  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
                "  jnz       1b\n\t"
                "  pushl     %%ecx\n\t"
                "  call      rwsem_wake\n\t"
                "  popl      %%ecx\n\t"
                "  jmp       1b\n"
                ".previous\n"
                "# ending __up_read\n"
                : "+m"(sem->count), "+d"(tmp)
                : "a"(sem)
                : "memory", "cc");
}

I'm afraid I know zilch about asm constraints...
Can anybody spot the trouble (and fix it :) ?

Thanks,
					Christian




