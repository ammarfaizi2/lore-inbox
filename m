Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291555AbSBHMaN>; Fri, 8 Feb 2002 07:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291559AbSBHM3y>; Fri, 8 Feb 2002 07:29:54 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:22165 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291555AbSBHM3e>; Fri, 8 Feb 2002 07:29:34 -0500
Message-Id: <5.1.0.14.2.20020208122845.00b1bc00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 12:29:41 +0000
To: Troy Benjegerdes <hozer@drgw.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
Cc: wli@holomorphy.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
In-Reply-To: <20020207234555.N17426@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:15 08/02/02, Anton Altaparmakov wrote:
>Hi,
>
>This patch is broken. Please don't apply as it is.
>
>At 05:45 08/02/02, Troy Benjegerdes wrote:
>>This patch introduced include/linux/div64.h and removes asm/div64.h from
>>all the architectures that don't have optimized ASM.
>>
>>I also played janitor and found every file that used asm/div64.h. There
>>was some mips stuff that I didn't touch, but now everything else should
>>actually work on all platforms linux supports, instead of just those that
>>are either 64 bit, or have optimized asm versions.
>[snip]
>>diff -N div64.h
>>--- /dev/null   Tue May  5 13:32:27 1998
>>+++ div64.h     Thu Feb  7 21:33:12 2002
>>@@ -0,0 +1,81 @@
>>+/*
>>+ * include/linux/div64.h
>>+ *
>>+ * Primarily used by vsprintf to divide a 64 bit int N by a small 
>>integer base
>>+ * We really do NOT want to encourage people to do slow 64 bit divides in
>>+ * the kernel, so the 'default' version of this function panics if you
>>+ * try and divide a 64 bit number by anything other than 8 or 16.
>>+ *
>>+ * If you really *really* need this, and are prepared to be flamed by
>>+ * lkml, #define USE_SLOW_64BIT_DIVIDES before including this file.
>>+ */
>>+#ifndef __DIV64
>>+#define __DIV64
>>+
>>+#include <linux/config.h>
>>+
>>+/* configurable  */
>>+#undef __USE_ASM
>>+
>>+
>>+#ifdef __USE_ASM
>>+/* yeah, this is a mess, and leaves out m68k.... */
>>+# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) || defined(CONFIG_MIPS)
>>+#  define __USE_ASM__
>>+# endif
>>+#endif
>
>Er, what exactly do you think the above does?!?
>
>It NEVER will define __USE_ASM because you make the definition dependent 
>on the UNDEFINED __USE_ASM! If anything you need to do instead:

Ooops. Sorry, didn't notice the second "__". This part will work. But rest 
of comments remain.

Best regards,

Anton

>+# if defined(CONFIG_X86) || define(CONFIG_ARCH_S390) || 
>defined(CONFIG_MIPS) || defined(CONFIG_M68K)
>+#  define __USE_ASM__
>+# endif
>
>I.e. remove the #ifdef __USE_ASM and add CONFIG_M68K dependence.
>
>>+#ifdef __USE_ASM__
>>+#include <asm/div64.h>
>>+#else /* __USE_ASM__ */
>>+static inline int do_div(unsigned long long * n, unsigned long base)
>>+{
>>+       int res = 0;
>>+       unsigned long long t = *n;
>>+       if ( t == (unsigned long)t ){ /* this should handle 64 bit 
>>platforms */
>>+               res = ((unsigned long) t) % base;
>>+               t = ((unsigned long) t) / base;
>>+       } else {
>
>This check is silly. It is _way_ more efficient to do:
>
>if (BITS_PER_LONG == 64) {
>         res = ((unsigned long)t) % base;
>         t = ((unsigned long)t) / base;
>} else {
>
>This actually only compiles one or the other but not both.
>
>>+#ifndef USE_SLOW_64BIT_DIVIDES
>
>This is stupid. If someone knows in advance they are only doing a division 
>by 8 or 16 they would not be using do_div in the first place, they would 
>be using a shift or even just normal division sign which gcc is supposed 
>to optimize to a shift itself (assuming division by constant).
>
>Please remove this. People using do_div() are using it for a reason.
>
>>+               switch (base) {
>>+                       case 8:
>>+                               res = ((unsigned long) t & 0x7);
>>+                               t = t >> 3;
>>+                               break;
>>+                       case 16:
>>+                               res = ((unsigned long) t & 0xf);
>>+                               t = t >> 4;
>>+                               break;
>>+                       default:
>>+                               panic("do_div called with 64 bit arg and 
>>unsupported base\n", base);
>
>Anyway, why do you randomly pick 8 and 16? You could do any power of two 
>via shift by simply doing something along these lines:
>
>if (!(base & (base - 1))) {
>         res = t & (base - 1);
>         t >>= ffs(base) - 1;
>} else
>         panic("blah");
>
>But I still think this is a really stupid thing to do.
>
>>+               }
>>+#else /* USE_SLOW_64BIT_DIVIDES */
>>+               /*
>>+               * Nasty ugly generic C 64 bit divide on 32 bit machine
>>+               * No one seems to want to take credit for this
>>+               */
>>+               unsigned long low, low2, high;
>>+               low  = (t) & 0xffffffff;
>>+               high = (t) >> 32;
>
>Look at asm-parisc/div64.h which has an optimized version of this for t 
>actually being 32bit.
>
>>+               res   = high % base;
>>+               high  = high / base;
>>+               low2  = low >> 16;
>>+               low2 += res << 16;
>>+               res   = low2 % base;
>>+               low2  = low2 / base;
>>+               low   = low & 0xffff;
>>+               low  += res << 16;
>>+               res   = low  % base;
>>+               low   = low  / base;
>>+               t = low  + ((long long)low2 << 16) +
>>+                       ((long long) high << 32);
>>+#endif  /* USE_SLOW_64BIT_DIVIDES */
>>+       }
>>+       *n = t;
>>+       return res;
>>+}
>>+
>>+
>>+#endif /* __USE_ASM__ */
>>+
>>+#endif
>[snip]
>
>I think the patch is generally a good idea but it has to be done right...
>
>Best regards,
>
>Anton
>
>
>--
>   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
>ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

