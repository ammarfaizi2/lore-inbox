Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313126AbSDSXOb>; Fri, 19 Apr 2002 19:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314137AbSDSXOa>; Fri, 19 Apr 2002 19:14:30 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:35066 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S313126AbSDSXO0>; Fri, 19 Apr 2002 19:14:26 -0400
Message-ID: <3CC0A447.8020906@didntduck.org>
Date: Fri, 19 Apr 2002 19:12:07 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: andrea@suse.de, ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: SSE related security hole
In-Reply-To: <20020419230454.C1291@dualathlon.random> <2459.131.107.184.74.1019252157.squirrel@www.zytor.com>
Content-Type: multipart/mixed;
 boundary="------------040603080707070807060908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040603080707070807060908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
 >>> Ummm...last I knew, fxrstor is *expensive*.  The fninit/xor regs
 >>> setup is  likely *very* much faster.  Someone should check this
 >>> before we sacrifice  100 cycles needlessly or something.
 >>
 >> most probably yes, fxrestor needs to read ram, pxor also takes
 >> some icache and bytecode ram but it sounds like it will be faster.
 >>
 >> Maybe we could also interleave the pxor with the xorps, since they
 >> uses different parts of the cpu, Honza?
 >>
 >
 >
 > You almost certainly should.  The reason I suggested FXRSTOR is that
 > it would initialize the entire FPU, including any state that future
 > processors may add, thus reducing the likelihood of any funnies in
 > the future.

Here's a patch to do just that.  It initializes the saved state in the
task struct and falls through to restore_fpu().

-- 

						Brian Gerst

--------------040603080707070807060908
Content-Type: text/plain;
 name="fpuclear-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fpuclear-1"

diff -urN linux-2.5.8/arch/i386/kernel/i387.c linux/arch/i386/kernel/i387.c
--- linux-2.5.8/arch/i386/kernel/i387.c	Thu Mar  7 21:18:32 2002
+++ linux/arch/i386/kernel/i387.c	Fri Apr 19 18:23:53 2002
@@ -31,13 +31,20 @@
  * value at reset if we support XMM instructions and then
  * remeber the current task has used the FPU.
  */
-void init_fpu(void)
+void init_fpu(struct task_struct *tsk)
 {
-	__asm__("fninit");
-	if ( cpu_has_xmm )
-		load_mxcsr(0x1f80);
-		
-	current->used_math = 1;
+	if ( cpu_has_xmm ) {
+		memset(&tsk->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
+		tsk->thread.i387.fxsave.cwd = 0x37f;
+		tsk->thread.i387.fxsave.mxcsr = 0x1f80;
+	} else {
+		memset(&tsk->thread.i387.fsave, 0, sizeof(struct i387_fsave_struct));
+		tsk->thread.i387.fsave.cwd = 0xffff037f;
+		tsk->thread.i387.fsave.swd = 0xffff0000;
+		tsk->thread.i387.fsave.twd = 0xffffffff;
+		tsk->thread.i387.fsave.fos = 0xffff0000;
+	}
+	tsk->used_math = 1;
 }
 
 /*
diff -urN linux-2.5.8/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.5.8/arch/i386/kernel/traps.c	Sun Apr 14 23:48:18 2002
+++ linux/arch/i386/kernel/traps.c	Fri Apr 19 18:22:12 2002
@@ -757,13 +757,12 @@
  */
 asmlinkage void math_state_restore(struct pt_regs regs)
 {
+	struct task_struct *tsk = current;
 	clts();		/* Allow maths ops (or we recurse) */
 
-	if (current->used_math) {
-		restore_fpu(current);
-	} else {
-		init_fpu();
-	}
+	if (!tsk->used_math)
+		init_fpu(tsk);
+	restore_fpu(tsk);
 	set_thread_flag(TIF_USEDFPU);	/* So we fnsave on switch_to() */
 }
 
diff -urN linux-2.5.8/include/asm-i386/i387.h linux/include/asm-i386/i387.h
--- linux-2.5.8/include/asm-i386/i387.h	Fri Apr 19 18:44:48 2002
+++ linux/include/asm-i386/i387.h	Fri Apr 19 18:46:12 2002
@@ -17,7 +17,7 @@
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
-extern void init_fpu(void);
+extern void init_fpu(struct task_struct *);
 /*
  * FPU lazy state save handling...
  */

--------------040603080707070807060908--

