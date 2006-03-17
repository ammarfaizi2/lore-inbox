Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWCQQSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWCQQSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWCQQSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:18:04 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:53390 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030204AbWCQQSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:18:00 -0500
Subject: [Patch 8 of 8] GCC 4.1 patch for kernel stack-protector
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:17:00 +0100
Message-Id: <1142612220.3033.116.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch to gcc 4.1 makes the kernel use the gs segment for the canary value, rather than 
the customary fs segment for userspace

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

--- gcc-4.1/gcc/config/i386/i386.md.org	2006-03-01 20:08:20.000000000 +0100
+++ gcc-4.1/gcc/config/i386/i386.md	2006-03-01 21:20:36.000000000 +0100
@@ -146,6 +146,9 @@
    (UNSPEC_SP_TEST		101)
    (UNSPEC_SP_TLS_SET		102)
    (UNSPEC_SP_TLS_TEST		103)
+   (UNSPEC_SP_TLS_SET_KERNEL	104)
+   (UNSPEC_SP_TLS_TEST_KERNEL	105)
+ 
   ])
 
 (define_constants
@@ -20138,10 +20141,14 @@
   ""
 {
 #ifdef TARGET_THREAD_SSP_OFFSET
-  if (TARGET_64BIT)
-    emit_insn (gen_stack_tls_protect_set_di (operands[0],
+  if (TARGET_64BIT) {
+	if (ix86_cmodel==CM_KERNEL) 
+	    emit_insn (gen_stack_tls_protect_set_di_kernel (operands[0],
+					GEN_INT (TARGET_THREAD_SSP_OFFSET)));	
+	else
+	    emit_insn (gen_stack_tls_protect_set_di (operands[0],
 					GEN_INT (TARGET_THREAD_SSP_OFFSET)));
-  else
+  } else
     emit_insn (gen_stack_tls_protect_set_si (operands[0],
 					GEN_INT (TARGET_THREAD_SSP_OFFSET)));
 #else
@@ -20189,6 +20196,15 @@
   "mov{q}\t{%%fs:%P1, %2|%2, QWORD PTR %%fs:%P1}\;mov{q}\t{%2, %0|%0, %2}\;xor{l}\t%k2, %k2"
   [(set_attr "type" "multi")])
 
+(define_insn "stack_tls_protect_set_di_kernel"
+  [(set (match_operand:DI 0 "memory_operand" "=m")
+	(unspec:DI [(match_operand:DI 1 "const_int_operand" "i")] UNSPEC_SP_TLS_SET_KERNEL))
+   (set (match_scratch:DI 2 "=&r") (const_int 0))
+   (clobber (reg:CC FLAGS_REG))]
+  "TARGET_64BIT"
+  "mov{q}\t{%%gs:%P1, %2|%2, QWORD PTR %%gs:%P1}\;mov{q}\t{%2, %0|%0, %2}\;xor{l}\t%k2, %k2"
+  [(set_attr "type" "multi")])
+
 (define_expand "stack_protect_test"
   [(match_operand 0 "memory_operand" "")
    (match_operand 1 "memory_operand" "")
@@ -20201,10 +20217,14 @@
   ix86_compare_emitted = flags;
 
 #ifdef TARGET_THREAD_SSP_OFFSET
-  if (TARGET_64BIT)
-    emit_insn (gen_stack_tls_protect_test_di (flags, operands[0],
+  if (TARGET_64BIT) {
+	if (ix86_cmodel==CM_KERNEL)
+	    emit_insn (gen_stack_tls_protect_test_di_kernel (flags, operands[0],
 					GEN_INT (TARGET_THREAD_SSP_OFFSET)));
-  else
+	else
+	    emit_insn (gen_stack_tls_protect_test_di (flags, operands[0],
+					GEN_INT (TARGET_THREAD_SSP_OFFSET)));
+  } else
     emit_insn (gen_stack_tls_protect_test_si (flags, operands[0],
 					GEN_INT (TARGET_THREAD_SSP_OFFSET)));
 #else
@@ -20257,6 +20277,17 @@
   "mov{q}\t{%1, %3|%3, %1}\;xor{q}\t{%%fs:%P2, %3|%3, QWORD PTR %%fs:%P2}"
   [(set_attr "type" "multi")])
 
+(define_insn "stack_tls_protect_test_di_kernel"
+  [(set (match_operand:CCZ 0 "flags_reg_operand" "")
+	(unspec:CCZ [(match_operand:DI 1 "memory_operand" "m")
+		     (match_operand:DI 2 "const_int_operand" "i")]
+		    UNSPEC_SP_TLS_TEST_KERNEL))
+   (clobber (match_scratch:DI 3 "=r"))]
+  "TARGET_64BIT"
+  "mov{q}\t{%1, %3|%3, %1}\;xor{q}\t{%%gs:%P2, %3|%3, QWORD PTR %%gs:%P2}"
+  [(set_attr "type" "multi")])
+
 (include "sse.md")
 (include "mmx.md")
 (include "sync.md")
+

