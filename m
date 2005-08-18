Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVHRJp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVHRJp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHRJpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:45:55 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:49018 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932149AbVHRJpz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:45:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FHn6WLBu3KIF4URaeewltBkr5qrcrA5eFogVyie28Xv+9bWMgaUAxpEJGPhJWpOf+icbFHprbUjp7fB4yNS8HxERfKyYm3O26B5SR6xtmhtZBCDrtjuHpmx8V0uUcZHNyMet+mCX26ltx0OhqNGKZS6S7AqBhfnSqfc3JTJ3/SA=
Message-ID: <98df96d30508180245a79bd31@mail.gmail.com>
Date: Thu, 18 Aug 2005 18:45:52 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, taka@valinux.co.jp,
       Hiro Yoshioka <hyoshiok@miraclelinux.com>,
       Akira Tsukamoto <akira-t@s9.dion.ne.jp>
In-Reply-To: <200508171121_MC3-1-A776-594E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508171121_MC3-1-A776-594E@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On 8/18/05, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> On Wed, 17 Aug 2005 at 13:50:22 +0900 (JST), Hiro Yoshioka wrote:
> 
> > 3) page faults/exceptions/...
> > 3-1  TS flag is set by the CPU (Am I right?)
> 
>   TS will _not_ be set if a trap/fault or interrupt occurs.  The only
> way that could happen automatically would be to use a separate hardware
> task with its own TSS to handle those.

OK.

>   And since the kernel does not have any state information of its own
> (no task_struct) any attempt to save the kernel-mode FPU state would
> overwrite the current user-mode state anyway.
> 
>   Interrupt and fault handlers will not use FP instructions anyway.
> The only thing you have to worry about is getting scheduled away
> while your code is running, and I guess that's why you have to worry
> about page faults.  And as Arjan pointed out, if you are doing
> __copy_from_user_inatomic you cannot sleep (==switch to another task.)
> 
>   So I would try the code from include/asm-i386/xor.h, modify it to
> save as many registers as you plan to use and see what happens.  It will
> do all the right things. See the xor_sse_2() for how to save and restore
> properly -- you will need to put your xmm_save area on the stack.

My hack is the following. I just change from using kernel_fpu_begin()
and kernel_fpu_end() to using a stack.

My test does not find any regressions.

--- usercopy.c.orig     2005-08-05 16:04:37.000000000 +0900
+++ usercopy.c  2005-08-18 16:53:37.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <asm/i387.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>

@@ -511,6 +512,144 @@
                : "memory");                                            \
 } while (0)

+#define MMX_SAVE do {                           \
+        preempt_disable();                      \
+        __asm__ __volatile__ (                  \
+                "movl %%cr0,%0          ;\n\t"  \
+                "clts                   ;\n\t"  \
+                "movq %%mm0,(%1)     ;\n\t"     \
+                "movq %%mm1,8(%1) ;\n\t"     \
+                "movq %%mm2,16(%1) ;\n\t"     \
+                "movq %%mm3,24(%1) ;\n\t"     \
+                : "=&r" (cr0)                   \
+                : "r" (mmx_save)                \
+                : "memory");                    \
+} while(0)
+
+#define MMX_RESTORE do {                       \
+        __asm__ __volatile__ (                  \
+                "sfence                 ;\n\t"  \
+                "movq (%1),%%mm0     ;\n\t"  \
+                "movq 8(%1),%%mm1 ;\n\t"  \
+                "movq 16(%1),%%mm2 ;\n\t"  \
+                "movq 24(%1),%%mm3 ;\n\t"  \
+                "movl   %0,%%cr0        ;\n\t"  \
+                :                               \
+                : "r" (cr0), "r" (mmx_save)     \
+                : "memory");                    \
+        preempt_enable();                       \
+} while(0)
+
+#define ALIGN8 __attribute__((aligned(8)))
+
+/* Non Temporal Hint version of mmx_memcpy */
+/* It is cache aware                       */
+/* hyoshiok@miraclelinux.com               */
+static unsigned long
+__copy_user_zeroing_nocache(void *to, const void *from, size_t len)
+{
+        /* Note! gcc doesn't seem to align stack variables properly, so we
+         * need to make use of unaligned loads and stores.
+         */
+       void *p;
+       int i;
+        char mmx_save[8*4] ALIGN8;
+        int cr0;
+
+       if (unlikely(in_interrupt())){
+               __copy_user_zeroing(to, from, len);
+               return len;
+       }
+
+       p = to;
+       i = len >> 6; /* len/64 */
+
+       /*        kernel_fpu_begin();*/
+       MMX_SAVE;
+
+       __asm__ __volatile__ (
+               "1: prefetchnta (%0)\n"         /* This set is 28 bytes */
+               "   prefetchnta 64(%0)\n"
+               "   prefetchnta 128(%0)\n"
+               "   prefetchnta 192(%0)\n"
+               "   prefetchnta 256(%0)\n"
+               "2:  \n"
+               ".section .fixup, \"ax\"\n"
+               "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
+               "   jmp 2b\n"
+               ".previous\n"
+               ".section __ex_table,\"a\"\n"
+               "       .align 4\n"
+               "       .long 1b, 3b\n"
+               ".previous"
+               : : "r" (from) );
+
+       for(; i>5; i--)
+       {
+               __asm__ __volatile__ (
+               "1:  prefetchnta 320(%0)\n"
+                "2:  movq (%0), %%mm0\n"
+                "  movq 8(%0), %%mm1\n"
+                "  movq 16(%0), %%mm2\n"
+                "  movq 24(%0), %%mm3\n"
+                "  movntq %%mm0, (%1)\n"
+                "  movntq %%mm1, 8(%1)\n"
+                "  movntq %%mm2, 16(%1)\n"
+                "  movntq %%mm3, 24(%1)\n"
+                "  movq 32(%0), %%mm0\n"
+                "  movq 40(%0), %%mm1\n"
+                "  movq 48(%0), %%mm2\n"
+                "  movq 56(%0), %%mm3\n"
+                "  movntq %%mm0, 32(%1)\n"
+                "  movntq %%mm1, 40(%1)\n"
+                "  movntq %%mm2, 48(%1)\n"
+                "  movntq %%mm3, 56(%1)\n"
+               ".section .fixup, \"ax\"\n"
+               "3: movw $0x05EB, 1b\n" /* jmp on 5 bytes */
+               "   jmp 2b\n"
+               ".previous\n"
+               ".section __ex_table,\"a\"\n"
+               "       .align 4\n"
+               "       .long 1b, 3b\n"
+               ".previous"
+               : : "r" (from), "r" (to) : "memory");
+               from+=64;
+               to+=64;
+       }
+
+       for(; i>0; i--)
+       {
+               __asm__ __volatile__ (
+                "  movq (%0), %%mm0\n"
+                "  movq 8(%0), %%mm1\n"
+                "  movq 16(%0), %%mm2\n"
+                "  movq 24(%0), %%mm3\n"
+                "  movntq %%mm0, (%1)\n"
+                "  movntq %%mm1, 8(%1)\n"
+                "  movntq %%mm2, 16(%1)\n"
+                "  movntq %%mm3, 24(%1)\n"
+                "  movq 32(%0), %%mm0\n"
+                "  movq 40(%0), %%mm1\n"
+                "  movq 48(%0), %%mm2\n"
+                "  movq 56(%0), %%mm3\n"
+                "  movntq %%mm0, 32(%1)\n"
+                "  movntq %%mm1, 40(%1)\n"
+                "  movntq %%mm2, 48(%1)\n"
+                "  movntq %%mm3, 56(%1)\n"
+               : : "r" (from), "r" (to) : "memory");
+               from+=64;
+               to+=64;
+       }
+       /*
+        *      Now do the tail of the block
+        */
+       /*      kernel_fpu_end();*/
+       MMX_RESTORE;
+       if(i=(len&63))
+         __copy_user_zeroing(to, from, i);
+       return i;
+}
+

 unsigned long __copy_to_user_ll(void __user *to, const void *from,
unsigned long n)
 {
@@ -582,6 +721,21 @@
        return n;
 }

+unsigned long
+__copy_from_user_ll_nocache(void *to, const void __user *from, unsigned long n)
+{
+       BUG_ON((long)n < 0);
+        if (n < 512) {
+          if (movsl_is_ok(to, from, n))
+                __copy_user_zeroing(to, from, n);
+          else
+                n = __copy_user_zeroing_intel(to, from, n);
+        }
+        else
+          n = __copy_user_zeroing_nocache(to, from, n);
+       return n;
+}
+
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.

-- 
Hiro Yoshioka
mailto:hyoshiok at miraclelinux.com
