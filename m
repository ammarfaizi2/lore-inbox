Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbSJDOrT>; Fri, 4 Oct 2002 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbSJDOqL>; Fri, 4 Oct 2002 10:46:11 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:27314 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261858AbSJDOhb> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (15/27): 64 bit spinlocks.
Date: Fri, 4 Oct 2002 16:30:59 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041630.59599.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use diag 0x44 on s390x for spinlocks.

diff -urN linux-2.5.40/arch/s390x/kernel/head.S linux-2.5.40-s390/arch/s390x/kernel/head.S
--- linux-2.5.40/arch/s390x/kernel/head.S	Fri Oct  4 16:14:42 2002
+++ linux-2.5.40-s390/arch/s390x/kernel/head.S	Fri Oct  4 16:15:54 2002
@@ -555,6 +555,17 @@
 	oi     7(%r12),16               # set MVPG flag
 0:
 
+#
+# find out if the diag 0x44 works in 64 bit mode
+#
+	la     %r1,0f-.LPG1(%r13)	# set program check address
+	stg    %r1,__LC_PGM_NEW_PSW+8
+	mvc    __LC_DIAG44_OPCODE(8),.Lnop-.LPG1(%r13)
+	diag   0,0,0x44			# test diag 0x44
+	oi     7(%r12),32		# set diag44 flag
+	mvc    __LC_DIAG44_OPCODE(8),.Ldiag44-.LPG1(%r13)
+0:	
+
         lpswe .Lentry-.LPG1(13)         # jump to _stext in primary-space,
                                         # virtual and never return ...
         .align 16
@@ -578,6 +589,8 @@
 .Lpcmsk:.quad  0x0000000180000000
 .L4malign:.quad 0xffffffffffc00000
 .Lscan2g:.quad 0x80000000 + 0x20000 - 8 # 2GB + 128K - 8
+.Lnop:	.long  0x07000700
+.Ldiag44:.long 0x83000044
 
 	.org PARMAREA-64
 .Lduct:	.long 0,0,0,0,0,0,0,0
diff -urN linux-2.5.40/include/asm-s390x/lowcore.h linux-2.5.40-s390/include/asm-s390x/lowcore.h
--- linux-2.5.40/include/asm-s390x/lowcore.h	Tue Oct  1 09:07:34 2002
+++ linux-2.5.40-s390/include/asm-s390x/lowcore.h	Fri Oct  4 16:15:54 2002
@@ -38,6 +38,8 @@
 #define __LC_IO_INT_WORD                0x0C0
 #define __LC_MCCK_CODE                  0x0E8
 
+#define __LC_DIAG44_OPCODE		0x214
+
 #define __LC_SAVE_AREA                  0xC00
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_ASYNC_STACK                0xD48
@@ -146,7 +148,8 @@
 	psw_t        io_new_psw;               /* 0x1f0 */
         psw_t        return_psw;               /* 0x200 */
 	__u32        sync_io_word;             /* 0x210 */
-        __u8         pad8[0xc00-0x214];        /* 0x214 */
+	__u32        diag44_opcode;            /* 0x214 */
+        __u8         pad8[0xc00-0x218];        /* 0x218 */
         /* System info area */
 	__u64        save_area[16];            /* 0xc00 */
         __u8         pad9[0xd40-0xc80];        /* 0xc80 */
diff -urN linux-2.5.40/include/asm-s390x/setup.h linux-2.5.40-s390/include/asm-s390x/setup.h
--- linux-2.5.40/include/asm-s390x/setup.h	Tue Oct  1 09:07:07 2002
+++ linux-2.5.40-s390/include/asm-s390x/setup.h	Fri Oct  4 16:15:54 2002
@@ -25,11 +25,12 @@
  */
 extern unsigned long machine_flags;
 
-#define MACHINE_IS_VM    (machine_flags & 1)
-#define MACHINE_IS_P390  (machine_flags & 4)
-#define MACHINE_HAS_MVPG (machine_flags & 16)
+#define MACHINE_IS_VM		(machine_flags & 1)
+#define MACHINE_IS_P390		(machine_flags & 4)
+#define MACHINE_HAS_MVPG	(machine_flags & 16)
+#define MACHINE_HAS_DIAG44	(machine_flags & 32)
 
-#define MACHINE_HAS_HWC  (!MACHINE_IS_P390)
+#define MACHINE_HAS_HWC		(!MACHINE_IS_P390)
 
 /*
  * Console mode. Override with conmode=
diff -urN linux-2.5.40/include/asm-s390x/spinlock.h linux-2.5.40-s390/include/asm-s390x/spinlock.h
--- linux-2.5.40/include/asm-s390x/spinlock.h	Fri Oct  4 16:14:46 2002
+++ linux-2.5.40-s390/include/asm-s390x/spinlock.h	Fri Oct  4 16:15:54 2002
@@ -16,7 +16,14 @@
  * asm/spinlock.h. The diagnose is only available in kernel
  * context.
  */
+#ifdef __KERNEL__
 #include <asm/lowcore.h>
+#define __DIAG44_INSN "ex"
+#define __DIAG44_OPERAND __LC_DIAG44_OPCODE
+#else
+#define __DIAG44_INSN "#"
+#define __DIAG44_OPERAND 0
+#endif
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -38,12 +45,13 @@
 {
 	unsigned long reg1, reg2;
         __asm__ __volatile("    bras  %1,1f\n"
-                           "0:  # diag  0,0,68\n"
+                           "0:  " __DIAG44_INSN " 0,%4\n"
                            "1:  slr   %0,%0\n"
                            "    cs    %0,%1,0(%3)\n"
                            "    jl    0b\n"
                            : "=&d" (reg1), "=&d" (reg2), "+m" (lp->lock)
-                           : "a" (&lp->lock) : "cc" );
+                           : "a" (&lp->lock), "i" (__DIAG44_OPERAND)
+			   : "cc" );
 }
 
 extern inline int _raw_spin_trylock(spinlock_t *lp)
@@ -88,43 +96,47 @@
 #define _raw_read_lock(rw)   \
         asm volatile("   lg    2,0(%1)\n"   \
                      "   j     1f\n"     \
-                     "0: # diag  0,0,68\n" \
+                     "0: " __DIAG44_INSN " 0,%2\n" \
                      "1: nihh  2,0x7fff\n" /* clear high (=write) bit */ \
                      "   la    3,1(2)\n"   /* one more reader */  \
                      "   csg   2,3,0(%1)\n" /* try to write new value */ \
                      "   jl    0b"       \
-                     : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
 		     : "2", "3", "cc" )
 
 #define _raw_read_unlock(rw) \
         asm volatile("   lg    2,0(%1)\n"   \
                      "   j     1f\n"     \
-                     "0: # diag  0,0,68\n" \
+                     "0: " __DIAG44_INSN " 0,%2\n" \
                      "1: lgr   3,2\n"    \
                      "   bctgr 3,0\n"    /* one less reader */ \
                      "   csg   2,3,0(%1)\n" \
                      "   jl    0b"       \
-                     : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
 		     : "2", "3", "cc" )
 
 #define _raw_write_lock(rw) \
         asm volatile("   llihh 3,0x8000\n" /* new lock value = 0x80...0 */ \
                      "   j     1f\n"       \
-                     "0: # diag  0,0,68\n"   \
+                     "0: " __DIAG44_INSN " 0,%2\n"   \
                      "1: slgr  2,2\n"      /* old lock value must be 0 */ \
                      "   csg   2,3,0(%1)\n" \
                      "   jl    0b"         \
-                     : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
 		     : "2", "3", "cc" )
 
 #define _raw_write_unlock(rw) \
         asm volatile("   slgr  3,3\n"      /* new lock value = 0 */ \
                      "   j     1f\n"       \
-                     "0: # diag  0,0,68\n"   \
+                     "0: " __DIAG44_INSN " 0,%2\n"   \
                      "1: llihh 2,0x8000\n" /* old lock value must be 0x8..0 */\
                      "   csg   2,3,0(%1)\n"   \
                      "   jl    0b"         \
-                     : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
 		     : "2", "3", "cc" )
 
 #endif /* __ASM_SPINLOCK_H */

