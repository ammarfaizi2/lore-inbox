Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVGVDJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVGVDJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVGVDJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:09:36 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:26009 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262004AbVGVDJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:09:36 -0400
Date: Thu, 21 Jul 2005 23:06:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200507212309_MC3-1-A534-95EF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  This patch makes restore_fpu() an inline.  When L1/L2 cache are saturated
it makes a measurable difference.

  Results from profiling Volanomark follow.  Sample rate was 2000 samples/sec
(HZ = 250, profile multiplier = 8) on a dual-processor Pentium II Xeon.


Before:

 10680 restore_fpu                              333.7500
  8351 device_not_available                     203.6829
  3823 math_state_restore                        59.7344
 -----
 22854


After:

 12534 math_state_restore                       130.5625
  8354 device_not_available                     203.7561
 -----
 20888


Patch is "obviously correct" and cuts 9% of the overhead.  Please apply.

Next step should be to physically place math_state_restore() after
device_not_available().  Would such a patch be accepted?  (Yes it
would be ugly and require linker script changes.)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc3a/arch/i386/kernel/i387.c
===================================================================
--- 2.6.13-rc3a.orig/arch/i386/kernel/i387.c
+++ 2.6.13-rc3a/arch/i386/kernel/i387.c
@@ -82,17 +82,6 @@
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
-void restore_fpu( struct task_struct *tsk )
-{
-	if ( cpu_has_fxsr ) {
-		asm volatile( "fxrstor %0"
-			      : : "m" (tsk->thread.i387.fxsave) );
-	} else {
-		asm volatile( "frstor %0"
-			      : : "m" (tsk->thread.i387.fsave) );
-	}
-}
-
 /*
  * FPU tag word conversions.
  */
Index: 2.6.13-rc3a/include/asm-i386/i387.h
===================================================================
--- 2.6.13-rc3a.orig/include/asm-i386/i387.h
+++ 2.6.13-rc3a/include/asm-i386/i387.h
@@ -22,11 +22,20 @@
 /*
  * FPU lazy state save handling...
  */
-extern void restore_fpu( struct task_struct *tsk );
-
 extern void kernel_fpu_begin(void);
 #define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
 
+static inline void restore_fpu( struct task_struct *tsk )
+{
+	if ( cpu_has_fxsr ) {
+		asm volatile( "fxrstor %0"
+			      : : "m" (tsk->thread.i387.fxsave) );
+	} else {
+		asm volatile( "frstor %0"
+			      : : "m" (tsk->thread.i387.fsave) );
+	}
+}
+
 /*
  * These must be called with preempt disabled
  */
__
Chuck
