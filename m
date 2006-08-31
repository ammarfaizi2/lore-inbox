Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWHaLDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWHaLDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWHaLDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:03:51 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40718 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751231AbWHaLDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:03:51 -0400
Message-ID: <44F6C204.6040301@shadowen.org>
Date: Thu, 31 Aug 2006 12:03:32 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Steve Fox <drfickle@us.ibm.com>
Subject: 2.6.18-rc5-git3: compilation failure on numa-q
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------050605050602090709070607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050605050602090709070607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

It seems that between 2.6.18-rc5-git2 and -git3 some of our test systems
stopped compiling the kernel; the two I have investigated appear to be
Numa-Q systems, x86 smp.  They are failing as below:

  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:86,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:44,
                 from include/linux/module.h:9,
                 from include/linux/crypto.h:20,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h: In function `__raw_read_lock':
include/asm/spinlock.h:164: error: parse error before ')' token
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

The only change relating to this file appears to be this one:

commit 8c74932779fc6f61b4c30145863a17125c1a296c
Author: Andi Kleen <ak@suse.de>
Date:   Wed Aug 30 19:37:14 2006 +0200

    [PATCH] i386: Remove alternative_smp

    The .fill causes miscompilations with some binutils version.

    Instead just patch the lock prefix in the lock constructs. That is the
    majority of the cost and should be good enough.

    Cc: Gerd Hoffmann <kraxel@suse.de>
    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Tried backing this out and the compile failure seems to go away.

Ok, having stared at it for a bit it seems the attached patch fixes it
up.  But as its asm could someone cast an eye over it.

-apw

--------------050605050602090709070607
Content-Type: text/plain;
 name="fix-up-rwlocks-following-alternative_smp-removal"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-up-rwlocks-following-alternative_smp-removal"

commit 2b5087b6ff53558d95b3b5c9a6fb1bd41fabbae6
Author: Andy Whitcroft <apw@shadowen.org>
Date:   Thu Aug 31 10:58:44 2006 +0000

    fix up rwlocks following alternative_smp removal
    
    We seem to be getting compile errors in reader-write lock support
    on x86 SMP following the removal of the alternative_smp in commit
    8c74932779fc6f61b4c30145863a17125c1a296c:
    
         CC      arch/i386/kernel/asm-offsets.s
       In file included from include/linux/spinlock.h:86,
                        from include/linux/capability.h:45,
                        from include/linux/sched.h:44,
                        from include/linux/module.h:9,
                        from include/linux/crypto.h:20,
                        from arch/i386/kernel/asm-offsets.c:7:
       include/asm/spinlock.h: In function `__raw_read_lock':
       include/asm/spinlock.h:164: error: parse error before ')' token
       make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
       make: *** [prepare0] Error 2.
    
    We seem to have lost some ':'s in the conversion, and the UP alternative
    has not been removed in some cases.  I think we want something like the
    below.
    
    Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diff --git a/include/asm-i386/rwlock.h b/include/asm-i386/rwlock.h
index 3ac1ba9..2aebb81 100644
--- a/include/asm-i386/rwlock.h
+++ b/include/asm-i386/rwlock.h
@@ -25,7 +25,7 @@ #define __build_read_lock_ptr(rw, helper
 			"jns 1f\n" \
 			"call " helper "\n\t" \
 			"1:\n" \
-			:"a" (rw) : "memory")
+			: : "a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK_PREFIX " ; subl $1,%0\n\t" \
@@ -34,8 +34,8 @@ #define __build_read_lock_const(rw, help
 			"leal %0,%%eax\n\t" \
 			"call " helper "\n\t" \
 			"popl %%eax\n\t" \
-			"1:\n" : \
-			"+m" (*(volatile int *)rw) : : "memory")
+			"1:\n" \
+			: "+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
@@ -48,9 +48,8 @@ #define __build_write_lock_ptr(rw, helpe
 	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 			"jz 1f\n" \
 			"call " helper "\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",(%0)\n\t", \
-			:"a" (rw) : "memory")
+			"1:\n" \
+			: : "a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
@@ -59,9 +58,8 @@ #define __build_write_lock_const(rw, hel
 			"leal %0,%%eax\n\t" \
 			"call " helper "\n\t" \
 			"popl %%eax\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",%0\n\t", \
-			"+m" (*(volatile int *)rw) : : "memory")
+			"1:\n" \
+			: "+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \

--------------050605050602090709070607--
