Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263656AbUESLBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUESLBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUESLBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:01:44 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:4554 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263623AbUESLBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:01:22 -0400
Date: Wed, 19 May 2004 13:01:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/4): core s390.
Message-ID: <20040519110120.GB5888@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Fix atomic_inc_and_test primitive.
 - Fix system call trace / audit interface.
 - Fix find_first_bit / find_next_bit inlines assembly constraints.

diffstat:
 arch/s390/kernel/entry.S   |    8 ++++----
 arch/s390/kernel/entry64.S |    8 ++++----
 include/asm-s390/atomic.h  |    2 +-
 include/asm-s390/bitops.h  |   25 +++++++++++++++++++------
 4 files changed, 28 insertions(+), 15 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Wed May 19 12:46:51 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Wed May 19 12:47:27 2004
@@ -239,7 +239,7 @@
 sysc_do_restart:
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
         l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
-        bo      BASED(sysc_tracesys)
+        bnz     BASED(sysc_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
                                   # ATTENTION: check sys_execve_glue before
@@ -328,7 +328,7 @@
 	st	%r2,SP_R2(%r15)   # store return value
 sysc_tracenogo:
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        bno     BASED(sysc_return)
+        bz      BASED(sysc_return)
 	l	%r1,BASED(.Ltrace)
 	la	%r2,SP_PTREGS(%r15)    # load pt_regs
 	la	%r3,1
@@ -512,7 +512,7 @@
 pgm_svcstd:
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
         l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
-        bo      BASED(pgm_tracesys)
+        bnz     BASED(pgm_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
                                   # ATTENTION: check sys_execve_glue before
@@ -554,7 +554,7 @@
         st      %r2,SP_R2(%r15)   # store return value
 pgm_svc_nogo:
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        bno     BASED(pgm_svcret)
+        bz      BASED(pgm_svcret)
         l       %r1,BASED(.Ltrace)
 	la	%r2,SP_PTREGS(%r15)    # load pt_regs
 	la	%r3,1
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Wed May 19 12:46:51 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Wed May 19 12:47:27 2004
@@ -231,7 +231,7 @@
 #endif
 	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
         lgf     %r8,0(%r7,%r10)   # load address of system call routine
-        jo      sysc_tracesys
+        jnz     sysc_tracesys
         basr    %r14,%r8          # call sys_xxxx
         stg     %r2,SP_R2(%r15)   # store return value (change R2 on stack)
                                   # ATTENTION: check sys_execve_glue before
@@ -319,7 +319,7 @@
         stg     %r2,SP_R2(%r15)     # store return value
 sysc_tracenogo:
 	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        jno     sysc_return
+        jz      sysc_return
 	la	%r2,SP_PTREGS(%r15)    # load pt_regs
 	la	%r3,1
 	larl	%r14,sysc_return    # return point is sysc_return
@@ -551,7 +551,7 @@
 #endif
 	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
         lgf     %r8,0(%r7,%r10)   # load address of system call routine
-        jo      pgm_tracesys
+        jnz     pgm_tracesys
         basr    %r14,%r8          # call sys_xxxx
         stg     %r2,SP_R2(%r15)   # store return value (change R2 on stack)
                                   # ATTENTION: check sys_execve_glue before
@@ -592,7 +592,7 @@
         stg     %r2,SP_R2(%r15)     # store return value
 pgm_svc_nogo:
 	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        jno     pgm_svcret
+        jz      pgm_svcret
 	la	%r2,SP_PTREGS(%r15)    # load pt_regs
 	la	%r3,1
 	larl	%r14,pgm_svcret     # return point is sysc_return
diff -urN linux-2.6/include/asm-s390/atomic.h linux-2.6-s390/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	Wed May 19 12:47:10 2004
+++ linux-2.6-s390/include/asm-s390/atomic.h	Wed May 19 12:47:27 2004
@@ -72,7 +72,7 @@
 
 static __inline__ int atomic_inc_and_test(volatile atomic_t * v)
 {
-	return __CS_LOOP(v, 1, "ar") != 0;
+	return __CS_LOOP(v, 1, "ar") == 0;
 }
 static __inline__ void atomic_dec(volatile atomic_t * v)
 {
diff -urN linux-2.6/include/asm-s390/bitops.h linux-2.6-s390/include/asm-s390/bitops.h
--- linux-2.6/include/asm-s390/bitops.h	Mon May 10 04:31:59 2004
+++ linux-2.6-s390/include/asm-s390/bitops.h	Wed May 19 12:47:27 2004
@@ -110,6 +110,7 @@
 
 #endif /* __s390x__ */
 
+#define __BITOPS_WORDS(bits) (((bits)+__BITOPS_WORDSIZE-1)/__BITOPS_WORDSIZE)
 #define __BITOPS_BARRIER() __asm__ __volatile__ ( "" : : : "memory" )
 
 #ifdef CONFIG_SMP
@@ -534,6 +535,7 @@
 static inline int
 find_first_zero_bit(const unsigned long * addr, unsigned int size)
 {
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
 	unsigned long cmp, count;
         unsigned int res;
 
@@ -566,13 +568,15 @@
                 "   alr  %0,%2\n"
                 "4:"
                 : "=&a" (res), "=&d" (cmp), "=&a" (count)
-                : "a" (size), "a" (addr), "a" (&_zb_findmap) : "cc" );
+                : "a" (size), "a" (addr), "a" (&_zb_findmap),
+		  "m" (*(addrtype *) addr) : "cc" );
         return (res < size) ? res : size;
 }
 
 static inline int
 find_first_bit(const unsigned long * addr, unsigned int size)
 {
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
 	unsigned long cmp, count;
         unsigned int res;
 
@@ -605,7 +609,8 @@
                 "   alr  %0,%2\n"
                 "4:"
                 : "=&a" (res), "=&d" (cmp), "=&a" (count)
-                : "a" (size), "a" (addr), "a" (&_sb_findmap) : "cc" );
+                : "a" (size), "a" (addr), "a" (&_sb_findmap),
+		  "m" (*(addrtype *) addr) : "cc" );
         return (res < size) ? res : size;
 }
 
@@ -695,6 +700,7 @@
 static inline unsigned long
 find_first_zero_bit(const unsigned long * addr, unsigned long size)
 {
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
         unsigned long res, cmp, count;
 
         if (!size)
@@ -730,13 +736,15 @@
                 "   algr  %0,%2\n"
                 "5:"
                 : "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (addr), "a" (&_zb_findmap) : "cc" );
+		: "a" (size), "a" (addr), "a" (&_zb_findmap),
+		  "m" (*(addrtype *) addr) : "cc" );
         return (res < size) ? res : size;
 }
 
 static inline unsigned long
 find_first_bit(const unsigned long * addr, unsigned long size)
 {
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
         unsigned long res, cmp, count;
 
         if (!size)
@@ -772,7 +780,8 @@
                 "   algr  %0,%2\n"
                 "5:"
                 : "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (addr), "a" (&_sb_findmap) : "cc" );
+		: "a" (size), "a" (addr), "a" (&_sb_findmap),
+		  "m" (*(addrtype *) addr) : "cc" );
         return (res < size) ? res : size;
 }
 
@@ -983,6 +992,7 @@
 static inline int 
 ext2_find_first_zero_bit(void *vaddr, unsigned int size)
 {
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
 	unsigned long cmp, count;
         unsigned int res;
 
@@ -1016,7 +1026,8 @@
                 "   alr  %0,%2\n"
                 "4:"
                 : "=&a" (res), "=&d" (cmp), "=&a" (count)
-                : "a" (size), "a" (vaddr), "a" (&_zb_findmap) : "cc" );
+                : "a" (size), "a" (vaddr), "a" (&_zb_findmap),
+		  "m" (*(addrtype *) vaddr) : "cc" );
         return (res < size) ? res : size;
 }
 
@@ -1068,6 +1079,7 @@
 static inline unsigned long
 ext2_find_first_zero_bit(void *vaddr, unsigned long size)
 {
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
         unsigned long res, cmp, count;
 
         if (!size)
@@ -1103,7 +1115,8 @@
                 "   algr  %0,%2\n"
                 "5:"
                 : "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (vaddr), "a" (&_zb_findmap) : "cc" );
+		: "a" (size), "a" (vaddr), "a" (&_zb_findmap),
+		  "m" (*(addrtype *) vaddr) : "cc" );
         return (res < size) ? res : size;
 }
 
