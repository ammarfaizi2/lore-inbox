Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTDXJjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTDXJjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:39:48 -0400
Received: from ltgp.iram.es ([150.214.224.138]:59012 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262623AbTDXJio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:38:44 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 24 Apr 2003 10:11:43 +0200
To: Robert Schweikert <Robert.Schweikert@abaqus.com>
Cc: linux-kernel@vger.kernel.org, Robert Schweikert <rjschwei@abaqus.com>
Subject: Re: context switch code question
Message-ID: <20030424081143.GA6405@iram.es>
References: <1050614372.2227.161.camel@cheetah.hks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050614372.2227.161.camel@cheetah.hks.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 05:19:32PM -0400, Robert Schweikert wrote:
> Can someone please point me to the context switching code. I am
> interested in the context switch structure and the values that are
> saved. I am chasing a weird problem with some numerical code that uses
> mmx instructions to get flush to zero to work. Specifically I am calling
> the
> 
> _MM_SET_FLUSH_TO_ZERO_MODE
> 
> macro which in turn ends up calling _mm_setcsr(), wherever that might be
> implemented.
> 
> What I am trying to figure out is a.) is this register value properly
> set/reset during context switch and b.) is this particular register
> properly transfered when the process gets moved to another CPU. 

Well, there is at least one bug in arch/i386/kernel/i387.c regarding the
handling of mxcsr on processors with SSE2 extensions. A new mxcsr bit 
(bit 6, denormals are zero or DAZ) was defined by Intel which will be 
cleared under you when you get a signal and with some ptrace operations.

The following patch should fix this, but I'm not sure that it is your
problem, and the behaviour of SSE code will vary depending on whether
the processor has SSE2 (but blame Intel for that, not me ;-)). You don't
say which kernel you are using, so I made the patch against a very
recent pull from the from 2.5 tree, but it is trivially portable to 2.4 
and might even apply as is.


===== arch/i386/kernel/i387.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/i387.c	Wed Apr  9 07:45:37 2003
+++ edited/arch/i386/kernel/i387.c	Thu Apr 24 09:52:42 2003
@@ -25,6 +25,12 @@
 #define HAVE_HWFP 1
 #endif
 
+/* mxcsr 31-16 must be zero for security reasons,
+ * bit 6 unfortunately depends on cpu features...
+ */
+#define MXSCR_MASK (cpu_has_sse2 ? 0xffff : 0xffbf )
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

The code in arch/x86-64/ia32/fpu32.c also has a couple of 0xffbf
masks, maybe they should really be 0xffff. But I lost my x86-64 doc
in a disk crash and have not yet downloaded it again.

	Regards,
	Gabriel
