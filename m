Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVGWWTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVGWWTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVGWWRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:17:24 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:26622 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261897AbVGWWPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:15:44 -0400
Date: Sat, 23 Jul 2005 18:09:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc3] i386: add alternative_output() for
  altinstructions
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200507231813_MC3-1-A560-460E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds alternative_output() for altinstructions that
have output.  Only one output is allowed.

It also cleans up the comments for alternative_input().

With this patch in place, I cleaned up the i387 save/restore in
my local copy so it now looks like this:

===================================================================
static inline void restore_fpu( struct task_struct *tsk )
{
	alternative_input(
		"frstor %1 ; nop",
		"fxrstor %1",
		X86_FEATURE_FXSR,
		"m" (tsk->thread.i387.fxsave));
}
static inline void __save_init_fpu( struct task_struct *tsk )
{
	alternative_output(
		"fnsave %0 ; nop ; fwait ; nop",
		"fxsave %0 ; fnclex",
		X86_FEATURE_FXSR,
		"=m" (tsk->thread.i387.fxsave));
	tsk->thread_info->status &= ~TS_USEDFPU;
}
===================================================================


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc3a/include/asm-i386/system.h
===================================================================
--- 2.6.13-rc3a.orig/include/asm-i386/system.h	2005-06-24 00:50:33.000000000 -0400
+++ 2.6.13-rc3a/include/asm-i386/system.h	2005-07-23 15:36:02.000000000 -0400
@@ -313,13 +313,13 @@
 
 /*
  * Alternative inline assembly with input.
- * 
- * Pecularities:
- * No memory clobber here. 
+ *
+ * Peculiarities:
+ * No memory clobber here.
  * Argument numbers start with 1.
  * Best is to use constraints that are fixed size (like (%1) ... "r")
- * If you use variable sized constraints like "m" or "g" in the 
- * replacement maake sure to pad to the worst case length.
+ * If you use variable sized constraints like "m" or "g" in the
+ * replacement make sure to pad to the worst case length.
  */
 #define alternative_input(oldinstr, newinstr, feature, input...)		\
 	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
@@ -336,6 +336,27 @@
 		      ".previous" :: "i" (feature), ##input)
 
 /*
+ * Alternative inline assembly with output.
+ *
+ * Same as alternative_input, except:
+ *	No inputs.
+ *	Only one output: 0.
+ */
+#define alternative_output(oldinstr, newinstr, feature, output...)		\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
+		      ".section .altinstructions,\"a\"\n"			\
+		      "  .align 4\n"						\
+		      "  .long 661b\n"            /* label */			\
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c1\n"             /* feature bit */		\
+		      "  .byte 662b-661b\n"       /* sourcelen */		\
+		      "  .byte 664f-663f\n"       /* replacementlen */ 		\
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
+		      ".previous" : output : "i" (feature))
+
+/*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
  * to devices.
__
Chuck
