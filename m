Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbUEDUY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUEDUY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbUEDUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:24:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:51177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263164AbUEDUYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:24:19 -0400
Date: Tue, 4 May 2004 13:24:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] mxcsr patch for i386 & x86-64
In-Reply-To: <Pine.LNX.4.58.0405041225080.3271@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405041322570.3271@ppc970.osdl.org>
References: <E305A4AFB7947540BC487567B5449BA802CA7BEC@scsmsx402.sc.intel.com>
 <Pine.LNX.4.58.0405041201440.3271@ppc970.osdl.org>
 <Pine.LNX.4.58.0405041225080.3271@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 this is my counter-suggestion, based on your patch. 

Does this work for you guys? Please re-submit if it passes testing and 
otherwise looks good. I can't test it in any sane way..

		Linus

----
===== arch/i386/kernel/i387.c 1.19 vs edited =====
--- 1.19/arch/i386/kernel/i387.c	Tue Feb  3 21:30:39 2004
+++ edited/arch/i386/kernel/i387.c	Tue May  4 13:15:10 2004
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -24,6 +25,21 @@
 #define HAVE_HWFP 1
 #endif
 
+static unsigned long mxcsr_feature_mask = 0xffffffff;
+
+static void __init mxcsr_feature_mask_init(void)
+{
+	unsigned long mask = 0;
+
+	if (cpu_has_fxsr) {
+		memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
+		asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave)); 
+		mask = current->thread.i387.fxsave.mxcsr_mask;
+		if (mask == 0UL) mask = 0x0000ffbf;
+	} 
+	mxcsr_feature_mask &= mask;
+}
+
 /*
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
@@ -204,13 +220,6 @@
 	}
 }
 
-void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
-{
-	if ( cpu_has_xmm ) {
-		tsk->thread.i387.fxsave.mxcsr = (mxcsr & 0xffbf);
-	}
-}
-
 /*
  * FXSR floating point environment conversions.
  */
@@ -355,8 +364,8 @@
 	clear_fpu( tsk );
 	err = __copy_from_user( &tsk->thread.i387.fxsave, &buf->_fxsr_env[0],
 				sizeof(struct i387_fxsave_struct) );
-	/* mxcsr bit 6 and 31-16 must be zero for security reasons */
-	tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+	/* mxcsr reserved bits must be masked to zero for security reasons */
+	tsk->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
 	return err ? 1 : convert_fxsr_from_user( &tsk->thread.i387.fxsave, buf );
 }
 
@@ -457,8 +466,8 @@
 		if (__copy_from_user( &tsk->thread.i387.fxsave, buf,
 				  sizeof(struct user_fxsr_struct) ))
 			ret = -EFAULT;
-		/* mxcsr bit 6 and 31-16 must be zero for security reasons */
-		tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+		/* mxcsr reserved bits must be masked to zero for security reasons */
+		tsk->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
 	} else {
 		ret = -EIO;
 	}
@@ -550,4 +559,11 @@
 		memcpy(fpu, &tsk->thread.i387.fxsave, sizeof(*fpu));
 	}
 	return fpvalid;
+}
+
+void __init fpu_init(void)
+{
+	clts();
+	mxcsr_feature_mask_init();
+	stts();
 }
===== arch/i386/kernel/cpu/common.c 1.26 vs edited =====
--- 1.26/arch/i386/kernel/cpu/common.c	Mon Dec 29 13:37:31 2003
+++ edited/arch/i386/kernel/cpu/common.c	Tue May  4 13:14:44 2004
@@ -536,5 +536,5 @@
 	 */
 	current_thread_info()->status = 0;
 	current->used_math = 0;
-	stts();
+	fpu_init();
 }
===== arch/x86_64/ia32/fpu32.c 1.6 vs edited =====
--- 1.6/arch/x86_64/ia32/fpu32.c	Sat Mar 22 11:41:26 2003
+++ edited/arch/x86_64/ia32/fpu32.c	Tue May  4 13:06:43 2004
@@ -155,7 +155,7 @@
 				     &buf->_fxsr_env[0],
 				     sizeof(struct i387_fxsave_struct)))
 			return -1;
-	tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+		tsk->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
 		tsk->used_math = 1;
 	} 
 	return convert_fxsr_from_user(&tsk->thread.i387.fxsave, buf);
===== arch/x86_64/ia32/ptrace32.c 1.10 vs edited =====
--- 1.10/arch/x86_64/ia32/ptrace32.c	Wed Feb 25 02:31:13 2004
+++ edited/arch/x86_64/ia32/ptrace32.c	Tue May  4 13:05:27 2004
@@ -357,10 +357,10 @@
 		/* no checking to be bug-to-bug compatible with i386 */
 		__copy_from_user(&child->thread.i387.fxsave, u, sizeof(*u));
 		child->used_math = 1;
-	        child->thread.i387.fxsave.mxcsr &= 0xffbf;
+		child->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
 		ret = 0; 
-			break;
-		}
+		break;
+	}
 
 	default:
 		ret = -EINVAL;
===== arch/x86_64/kernel/i387.c 1.10 vs edited =====
--- 1.10/arch/x86_64/kernel/i387.c	Fri Jan 23 12:17:58 2004
+++ edited/arch/x86_64/kernel/i387.c	Tue May  4 13:07:35 2004
@@ -24,6 +24,18 @@
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
+unsigned long mxcsr_feature_mask = 0xffffffff;
+
+static void mxcsr_feature_mask_init(void)
+{
+	unsigned long mask;
+	memset(&current->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
+	asm volatile("fxsave %0" : : "m" (current->thread.i387.fxsave));
+	mask = current->thread.i387.fxsave.mxcsr_mask;
+	if (mask == 0UL) mask = 0x0000ffbf;
+	mxcsr_feature_mask &= mask;
+}
+
 /*
  * Called at bootup to set up the initial FPU state that is later cloned
  * into all processes.
@@ -40,6 +52,8 @@
 
 	write_cr0(oldcr0 & ~((1UL<<3)|(1UL<<2))); /* clear TS and EM */
 
+	clts();
+	mxcsr_feature_mask_init();
 	/* clean state in init */
 	stts();
 	current_thread_info()->status = 0;
===== include/asm-i386/i387.h 1.14 vs edited =====
--- 1.14/include/asm-i386/i387.h	Sat Oct  4 23:51:00 2003
+++ edited/include/asm-i386/i387.h	Tue May  4 13:17:09 2004
@@ -12,10 +12,13 @@
 #define __ASM_I386_I387_H
 
 #include <linux/sched.h>
+#include <linux/init.h>
+
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
+extern void __init fpu_init(void);
 extern void init_fpu(struct task_struct *);
 /*
  * FPU lazy state save handling...
@@ -89,12 +92,6 @@
 extern void set_fpu_cwd( struct task_struct *tsk, unsigned short cwd );
 extern void set_fpu_swd( struct task_struct *tsk, unsigned short swd );
 extern void set_fpu_twd( struct task_struct *tsk, unsigned short twd );
-extern void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr );
-
-#define load_mxcsr( val ) do { \
-	unsigned long __mxcsr = ((unsigned long)(val) & 0xffbf); \
-	asm volatile( "ldmxcsr %0" : : "m" (__mxcsr) ); \
-} while (0)
 
 /*
  * Signal frame handlers...
===== include/asm-i386/processor.h 1.60 vs edited =====
--- 1.60/include/asm-i386/processor.h	Mon Apr 12 10:54:21 2004
+++ edited/include/asm-i386/processor.h	Tue May  4 12:37:44 2004
@@ -332,7 +332,7 @@
 	long	foo;
 	long	fos;
 	long	mxcsr;
-	long	reserved;
+	long	mxcsr_mask;
 	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
 	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
 	long	padding[56];
===== include/asm-x86_64/i387.h 1.9 vs edited =====
--- 1.9/include/asm-x86_64/i387.h	Fri May 23 03:22:07 2003
+++ edited/include/asm-x86_64/i387.h	Tue May  4 13:07:48 2004
@@ -23,6 +23,8 @@
 extern void init_fpu(struct task_struct *child);
 extern int save_i387(struct _fpstate *buf);
 
+extern unsigned int mxcsr_feature_mask;
+
 static inline int need_signal_i387(struct task_struct *me) 
 { 
 	if (!me->used_math)
@@ -52,11 +54,6 @@
 	}							\
 } while (0)
 
-#define load_mxcsr(val) do { \
-		unsigned long __mxcsr = ((unsigned long)(val) & 0xffbf); \
-		asm volatile("ldmxcsr %0" : : "m" (__mxcsr)); \
-} while (0)
-
 /*
  * ptrace request handers...
  */
@@ -75,7 +72,6 @@
 #define set_fpu_cwd(t,val) ((t)->thread.i387.fxsave.cwd = (val))
 #define set_fpu_swd(t,val) ((t)->thread.i387.fxsave.swd = (val))
 #define set_fpu_fxsr_twd(t,val) ((t)->thread.i387.fxsave.twd = (val))
-#define set_fpu_mxcsr(t,val) ((t)->thread.i387.fxsave.mxcsr = (val)&0xffbf)
 
 static inline int restore_fpu_checking(struct i387_fxsave_struct *fx) 
 { 
