Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRECQPE>; Thu, 3 May 2001 12:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132898AbRECQOy>; Thu, 3 May 2001 12:14:54 -0400
Received: from picard.csihq.com ([204.17.222.1]:54747 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S132895AbRECQOk>;
	Thu, 3 May 2001 12:14:40 -0400
Message-ID: <04e601c0d3ec$32ed29c0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: <linux-kernel@vger.kernel.org>,
        "Christian Iseli" <chris@ludwig-alpha.unil.ch>
In-Reply-To: <200105021613.SAA22580@ludwig-alpha.unil.ch>
Subject: Re: Linux 2.4.4-ac3, asm problem in asm-i386/rwsem.h using gcc 3.0 CVS
Date: Thu, 3 May 2001 12:14:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like if you remove the "inline" from the function definition this
compiles OK.

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Christian Iseli" <chris@ludwig-alpha.unil.ch>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, May 02, 2001 12:13 PM
Subject: Linux 2.4.4-ac3, asm problem in asm-i386/rwsem.h using gcc 3.0 CVS


Hi folks,

I currently fail to compile the 2.4.4-ac3 kernel using latest GCC 3.0 from
CVS:
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
LOCK_PREFIX     "  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the
old value */
                "  js        2f\n\t" /* jump if the lock is being waited
upon */
                "1:\n\t"
                ".section .text.lock,\"ax\"\n"
                "2:\n\t"
                "  decw      %%dx\n\t" /* do nothing if still outstanding
active readers */
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




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

