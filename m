Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTEIAmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbTEIAmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:42:33 -0400
Received: from mrt-aod.iram.es ([150.214.224.146]:21255 "EHLO mrt-lx16.iram.es")
	by vger.kernel.org with ESMTP id S262263AbTEIAm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:42:28 -0400
Date: Fri, 9 May 2003 00:42:01 +0000
From: paubert <paubert@iram.es>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>,
       David Mosberger <davidm@hpl.hp.com>
Subject: [PATCH] Mask mxcsr according to cpu features.
Message-ID: <20030509004200.A22795@mrt-lx16.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[CC'ed to x86_64 and ia64 maintainers because they might have the 
same issues. For existing x86_64 processors, s/0xffbf/0xffff/ in 
arch/x86-64/ia32/{fpu32,ptrace32}.c might be sufficient]

With SSE2, mxcsr bit 6 is defined as controlling whether
denormals should be treated as zeroes or not. Setting it
no more causes an exception, but with the current code it 
would be cleared at every signal return which is a bit harsh.

The following patch fixes this (2.5, but easily ported to 2.4).

===== arch/i386/kernel/i387.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/i387.c	Wed Apr  9 05:45:37 2003
+++ edited/arch/i386/kernel/i387.c	Thu May  8 23:30:23 2003
@@ -25,6 +25,12 @@
 #define HAVE_HWFP 1
 #endif
 
+/* mxcsr bits 31-16 must be zero for security reasons,
+ * bit 6 depends on cpu features.
+ */
+#define MXCSR_MASK (cpu_has_sse2 ? 0xffff : 0xffbf)
+
+
 /*
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
@@ -208,7 +214,7 @@
 void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
 {
 	if ( cpu_has_xmm ) {
-		tsk->thread.i387.fxsave.mxcsr = (mxcsr & 0xffbf);
+		tsk->thread.i387.fxsave.mxcsr = (mxcsr & MXCSR_MASK);
 	}
 }
 
@@ -356,8 +362,7 @@
 	clear_fpu( tsk );
 	err = __copy_from_user( &tsk->thread.i387.fxsave, &buf->_fxsr_env[0],
 				sizeof(struct i387_fxsave_struct) );
-	/* mxcsr bit 6 and 31-16 must be zero for security reasons */
-	tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+	tsk->thread.i387.fxsave.mxcsr &= MXCSR_MASK;
 	return err ? 1 : convert_fxsr_from_user( &tsk->thread.i387.fxsave, buf );
 }
 
@@ -455,8 +460,7 @@
 	if ( cpu_has_fxsr ) {
 		__copy_from_user( &tsk->thread.i387.fxsave, buf,
 				  sizeof(struct user_fxsr_struct) );
-		/* mxcsr bit 6 and 31-16 must be zero for security reasons */
-		tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+		tsk->thread.i387.fxsave.mxcsr &= MXCSR_MASK;
 		return 0;
 	} else {
 		return -EIO;

	Gabriel
