Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTIVNBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbTIVNBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:01:24 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:25016 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263129AbTIVNBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:01:21 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "J.C. Wren" <jcwren@jcwren.com>
Date: Mon, 22 Sep 2003 15:00:55 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test5-bk8 breaks VMWare build
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <ED6EB3408B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Sep 03 at 0:48, J.C. Wren wrote:

> I don't know if this should be considered a VMWare or a kernel problem.  This works fine under 2.6.0-test3-bk8, so a header that VMWare depends on has changed.  The 
> `__set_64bit_var': warning does occur in test3-bk8, but the module safely compiles.

As usual. Get update from http://platan.vc.cvut.cz/ftp/pub/vmware,
currently vmware-any-any-update40.tar.gz. __set_64bit_var was fixed
in update37, and recent misc_device changes in update40.

> /lib/modules/2.6.0-test5-bk8/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
> /lib/modules/2.6.0-test5-bk8/build/include/asm/system.h:193: warning: dereferencing type-punned pointer will break strict-aliasing rules
> ../linux/driver.c: In function `init_module':
> ../linux/driver.c:246: error: structure has no member named `prev'
> ../linux/driver.c:247: error: structure has no member named `next'
> ../include/vm_asm.h: In function `Div643264':
> ../include/vm_asm.h:1095: warning: use of memory input without lvalue in asm operand 4 is deprecated

This one is fixed too. I believe that since update37 too, but I'm
not 100% sure. 

[OT] And I'm not sure that this one is actually correct warning
from gcc, as it looks completely bogus to me. Gcc even correctly
understood that it must save dividend to the memory to satisfy rules,
but "(uint32)dividend" is good enough lvalue for left side in assignment,
yet it is not enough "lvalued" for asm constraint... And if
it could decide for "i" choice from "mi", it would be perfect...
                                            Best regards,
                                                Petr Vandrovec
                                                


#define ORIG

typedef unsigned int uint32;
typedef unsigned long long uint64;

static inline void
Div643232(uint64 dividend,   // IN
          uint32 divisor,    // IN
          uint32 *quotient,  // OUT
          uint32 *remainder) // OUT
{
   /* Checked against the Intel manual and GCC --hpreg */
   __asm__(
      "divl %4"
      : "=a" (*quotient),
        "=d" (*remainder)
      : "0" ((uint32)dividend),
        "1" ((uint32)(dividend >> 32)),
        "rm" (divisor)
      : "cc"
   );
}

static inline void
Div643264(uint64 dividend,   // IN
          uint32 divisor,    // IN
          uint64 *quotient,  // OUT
          uint32 *remainder) // OUT
{
   uint32 hQuotient;
   uint32 lQuotient;

   /* Checked against the Intel manual and GCC --hpreg */
   __asm__(
      "divl %5"        "\n\t"
      "movl %%eax, %0" "\n\t"
      "movl %4, %%eax" "\n\t"
      "divl %5"
#ifdef ORIG
      : "=m" (hQuotient),
        "=a" (lQuotient),
        "=d" (*remainder)
      : "1" ((uint32)(dividend >> 32)),
        "mi" ((uint32)dividend),
        "rm" (divisor),
        "2" (0)
      : "cc"
#else
      : "=&rm" (hQuotient),
        "=a" (lQuotient),
        "=d" (*remainder)
      : "1" ((uint32)(dividend >> 32)),
        "g" ((uint32)dividend),
        "rm" (divisor),
        "2" (0)
      : "cc"
#endif
   );
   *quotient = (uint64)hQuotient << 32 | lQuotient;
}

uint32
Vmx86_GetkHzEstimate(void)  // IN: start time
{
   uint64 hz;
   uint32 tmp;
   uint32 tmpkHz;

   Div643264(2222, 333, &hz, &tmp);
   Div643232(hz + 500, 1000, &tmpkHz, &tmp);
   return tmpkHz;

}

/*

 platan:/tmp/x# gcc -W -Wall -O2 -c vmx86.c
 vmx86.c: In function `Vmx86_GetkHzEstimate':
 vmx86.c:34: warning: use of memory input without lvalue in asm operand 4 is deprecated
 vmx86.c: In function `Div643264':
 vmx86.c:34: warning: use of memory input without lvalue in asm operand 4 is deprecated
 
 gcc version 3.3.2 20030908 (Debian prerelease)

 */



