Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273788AbSISXdS>; Thu, 19 Sep 2002 19:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273842AbSISXdS>; Thu, 19 Sep 2002 19:33:18 -0400
Received: from packet.digeo.com ([12.110.80.53]:42921 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S273788AbSISXdQ>;
	Thu, 19 Sep 2002 19:33:16 -0400
Message-ID: <3D8A5FE6.4C5DE189@digeo.com>
Date: Thu, 19 Sep 2002 16:38:14 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 23:38:14.0515 (UTC) FILETIME=[9F7DCC30:01C26035]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> 
> ...
>         So akpm's removal of lock section directives breaks down the
> functions holding locks that previously were reported under the
> .text.lock.filename?

Yup.  It makes the profiler report the spinlock cost at the
actual callsite.  Patch below.

> Looks like fastwalk might not behave so well
> on this 32 cpu numa system...

I've rather lost the plot.  Have any of the dcache speedup
patches been merged into 2.5?

It would be interesting to know the context switch rate
during this test, and to see what things look like with HZ=100.



--- 2.5.24/include/asm-i386/spinlock.h~spinlock-inline	Fri Jun 21 13:12:01 2002
+++ 2.5.24-akpm/include/asm-i386/spinlock.h	Fri Jun 21 13:18:12 2002
@@ -46,13 +46,13 @@ typedef struct {
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
-	LOCK_SECTION_START("") \
+	"jmp 3f\n" \
 	"2:\t" \
 	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
-	LOCK_SECTION_END
+	"3:\t" \
 
 /*
  * This works. Despite all the confusion.
--- 2.5.24/include/asm-i386/rwlock.h~spinlock-inline	Fri Jun 21 13:18:33 2002
+++ 2.5.24-akpm/include/asm-i386/rwlock.h	Fri Jun 21 13:22:09 2002
@@ -22,25 +22,19 @@
 
 #define __build_read_lock_ptr(rw, helper)   \
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
-		     "js 2f\n" \
-		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tcall " helper "\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
+		     "jns 1f\n\t" \
+		     "call " helper "\n\t" \
+		     "1:\t" \
 		     ::"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK "subl $1,%0\n\t" \
-		     "js 2f\n" \
-		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tpushl %%eax\n\t" \
+		     "jns 1f\n\t" \
+		     "pushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
+		     "1:\t" \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
@@ -52,25 +46,19 @@
 
 #define __build_write_lock_ptr(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
-		     "jnz 2f\n" \
+		     "jz 1f\n\t" \
+		     "call " helper "\n\t" \
 		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tcall " helper "\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
 		     ::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
-		     "jnz 2f\n" \
-		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tpushl %%eax\n\t" \
+		     "jz 1f\n\t" \
+		     "pushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
+		     "1:\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \

-
