Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313817AbSDZK6P>; Fri, 26 Apr 2002 06:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313818AbSDZK6P>; Fri, 26 Apr 2002 06:58:15 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11034 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313817AbSDZK6N>; Fri, 26 Apr 2002 06:58:13 -0400
Date: Fri, 26 Apr 2002 12:58:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: x86 FPU fixes for 2.4.19pre7
Message-ID: <20020426125827.M1337@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, please review and merge these below fixes in next mainline.

this one is from pre7aa1:

--- 2.4.19pre6aa2/arch/i386/kernel/i387.c.~1~	Sun Apr  1 01:17:07 2001
+++ 2.4.19pre6aa2/arch/i386/kernel/i387.c	Mon Apr 15 01:21:58 2002
@@ -349,13 +349,15 @@
 
 static inline int restore_i387_fxsave( struct _fpstate *buf )
 {
+	int err;
 	struct task_struct *tsk = current;
 	clear_fpu( tsk );
-	if ( __copy_from_user( &tsk->thread.i387.fxsave, &buf->_fxsr_env[0],
-			       sizeof(struct i387_fxsave_struct) ) )
-		return 1;
+	err = __copy_from_user(&tsk->thread.i387.fxsave, &buf->_fxsr_env[0],
+			       sizeof(struct i387_fxsave_struct));
 	/* mxcsr bit 6 and 31-16 must be zero for security reasons */
 	tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+	if (err)
+		return 1;
 	return convert_fxsr_from_user( &tsk->thread.i387.fxsave, buf );
 }
 

this one from pre7aa2:

diff -urN 2.4.19pre7/arch/i386/kernel/i387.c mmx/arch/i386/kernel/i387.c
--- 2.4.19pre7/arch/i386/kernel/i387.c	Sun Apr  1 01:17:07 2001
+++ mmx/arch/i386/kernel/i387.c	Fri Apr 26 10:56:02 2002
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -24,6 +25,29 @@
 #define HAVE_HWFP 1
 #endif
 
+static union i387_union empty_fpu_state;
+
+void __init boot_init_fpu(void)
+{
+	memset(&empty_fpu_state, 0, sizeof(union i387_union));
+
+	if (!cpu_has_fxsr) {
+		empty_fpu_state.fsave.cwd = 0xffff037f;
+		empty_fpu_state.fsave.swd = 0xffff0000;
+		empty_fpu_state.fsave.twd = 0xffffffff;
+		empty_fpu_state.fsave.fos = 0xffff0000;
+	} else {
+		empty_fpu_state.fxsave.cwd = 0x37f;
+		if (cpu_has_xmm)
+			empty_fpu_state.fxsave.mxcsr = 0x1f80;
+	}
+}
+
+void load_empty_fpu(struct task_struct * tsk)
+{
+	memcpy(&tsk->thread.i387, &empty_fpu_state, sizeof(union i387_union));
+}
+
 /*
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
@@ -32,10 +56,10 @@
  */
 void init_fpu(void)
 {
-	__asm__("fninit");
-	if ( cpu_has_xmm )
-		load_mxcsr(0x1f80);
-		
+	if (cpu_has_fxsr)
+		asm volatile("fxrstor %0" : : "m" (empty_fpu_state.fxsave));
+	else
+		__asm__("fninit");
 	current->used_math = 1;
 }
 
diff -urN 2.4.19pre7/arch/i386/kernel/ptrace.c mmx/arch/i386/kernel/ptrace.c
--- 2.4.19pre7/arch/i386/kernel/ptrace.c	Tue Jan 22 18:55:43 2002
+++ mmx/arch/i386/kernel/ptrace.c	Fri Apr 26 10:56:02 2002
@@ -369,12 +369,8 @@
 			break;
 		}
 		ret = 0;
-		if ( !child->used_math ) {
-			/* Simulate an empty FPU. */
-			set_fpu_cwd(child, 0x037f);
-			set_fpu_swd(child, 0x0000);
-			set_fpu_twd(child, 0xffff);
-		}
+		if ( !child->used_math )
+			load_empty_fpu(child);
 		get_fpregs((struct user_i387_struct *)data, child);
 		break;
 	}
@@ -397,13 +393,8 @@
 			ret = -EIO;
 			break;
 		}
-		if ( !child->used_math ) {
-			/* Simulate an empty FPU. */
-			set_fpu_cwd(child, 0x037f);
-			set_fpu_swd(child, 0x0000);
-			set_fpu_twd(child, 0xffff);
-			set_fpu_mxcsr(child, 0x1f80);
-		}
+		if ( !child->used_math )
+			load_empty_fpu(child);
 		ret = get_fpxregs((struct user_fxsr_struct *)data, child);
 		break;
 	}
diff -urN 2.4.19pre7/include/asm-i386/bugs.h mmx/include/asm-i386/bugs.h
--- 2.4.19pre7/include/asm-i386/bugs.h	Fri Apr 26 10:36:12 2002
+++ mmx/include/asm-i386/bugs.h	Fri Apr 26 10:56:52 2002
@@ -204,7 +204,10 @@
 
 static void __init check_bugs(void)
 {
+	extern void __init boot_init_fpu(void);
+
 	identify_cpu(&boot_cpu_data);
+	boot_init_fpu();
 #ifndef CONFIG_SMP
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
diff -urN 2.4.19pre7/include/asm-i386/i387.h mmx/include/asm-i386/i387.h
--- 2.4.19pre7/include/asm-i386/i387.h	Sat Apr 20 09:43:17 2002
+++ mmx/include/asm-i386/i387.h	Fri Apr 26 10:56:02 2002
@@ -76,6 +76,7 @@
 			struct task_struct *tsk );
 extern int set_fpxregs( struct task_struct *tsk,
 			struct user_fxsr_struct *buf );
+extern void load_empty_fpu(struct task_struct *);
 
 /*
  * FPU state for core dumps...


Thanks,
Andrea
