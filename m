Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSDTAKt>; Fri, 19 Apr 2002 20:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313747AbSDTAKs>; Fri, 19 Apr 2002 20:10:48 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:25501 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S313669AbSDTAKl>; Fri, 19 Apr 2002 20:10:41 -0400
Message-ID: <3CC0B16F.1050501@didntduck.org>
Date: Fri, 19 Apr 2002 20:08:15 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, andrea@suse.de, ak@suse.de,
        linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <Pine.LNX.4.44.0204191637570.20973-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090405060502080603080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405060502080603080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Fri, 19 Apr 2002, Brian Gerst wrote:
> 
>>Here's a patch to do just that.  It initializes the saved state in the
>>task struct and falls through to restore_fpu().
> 
> 
> One issue is whether we _can_ restore a "generated" image like this: it's
> entirely possible that Intel might save away internal CPU shadow data in
> the save-state structure, and future CPU's might be unhappy about loading
> data that doesn't conform to what the CPU would save.
> 
> That said, the same issue is certainly true for just doing "xorps", since
> that will not clear any potential future CPU state.
> 
> I get this feeling that Intel screwed up on specifying how to initialize
> this whole state.
> 
> 		Linus
> 

I don't know about Intel, but the Athlon doesn't appear to save anything 
in the "reserved" areas.  The values that I use to initialize the state 
are from what is saved after loading the stack with zeroes (fldz) and 
then doing finit.  I have samples of the saved state from a P2, a K6-2, 
and an Athlon XP.

Attached is a revised patch.  I had the cpu_has_xmm test wrong.

-- 

						Brian Gerst

--------------090405060502080603080707
Content-Type: text/plain;
 name="fpuclear-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fpuclear-2"

diff -urN linux-2.5.8/arch/i386/kernel/i387.c linux/arch/i386/kernel/i387.c
--- linux-2.5.8/arch/i386/kernel/i387.c	Thu Mar  7 21:18:32 2002
+++ linux/arch/i386/kernel/i387.c	Fri Apr 19 19:35:14 2002
@@ -31,13 +31,21 @@
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
+	if (cpu_has_fxsr) {
+		memset(&tsk->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
+		tsk->thread.i387.fxsave.cwd = 0x37f;
+		if (cpu_has_xmm)
+			tsk->thread.i387.fxsave.mxcsr = 0x1f80;
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
+++ linux/include/asm-i386/i387.h	Fri Apr 19 19:34:03 2002
@@ -17,7 +17,7 @@
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
-extern void init_fpu(void);
+extern void init_fpu(struct task_struct *);
 /*
  * FPU lazy state save handling...
  */

--------------090405060502080603080707--

