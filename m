Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273415AbRINPDb>; Fri, 14 Sep 2001 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273408AbRINPDW>; Fri, 14 Sep 2001 11:03:22 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:7978 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273414AbRINPDM>; Fri, 14 Sep 2001 11:03:12 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109140838040.21992-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109140838040.21992-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.12.07.08 (Preview Release)
Date: 14 Sep 2001 11:04:06 -0400
Message-Id: <1000479851.2156.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-14 at 02:40, Arjan Filius wrote:
> Hello Robert,

Hi Arjan,

> I do Athlon/K7 opmimization indeed, and didn't test without.
> Haven't stress-tested it very well yet, but as soon i notice something i
> let you know.

Have you had any oops that were unexplained, after we fixed the other
problems?  I have attached the patch below, you can give it a whirl, but
it is odd you have had no problems.

> Great!

:)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net


diff -urN linux-2.4.10-pre8/arch/i386/kernel/i387.c linux/arch/i386/kernel/i387.c
--- linux-2.4.10-pre8/arch/i386/kernel/i387.c	Thu Sep 13 19:24:48 2001
+++ linux/arch/i386/kernel/i387.c	Thu Sep 13 20:00:57 2001
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -65,6 +66,8 @@
 {
 	struct task_struct *tsk = current;
 
+	ctx_sw_off();
+	
 	if (tsk->flags & PF_USEDFPU) {
 		__save_init_fpu(tsk);
 		return;
diff -urN linux-2.4.10-pre8/include/asm-i386/i387.h linux/include/asm-i386/i387.h
--- linux-2.4.10-pre8/include/asm-i386/i387.h	Thu Sep 13 19:27:28 2001
+++ linux/include/asm-i386/i387.h	Thu Sep 13 20:01:30 2001
@@ -12,6 +12,7 @@
 #define __ASM_I386_I387_H
 
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <asm/user.h>
@@ -24,7 +25,7 @@
 extern void restore_fpu( struct task_struct *tsk );
 
 extern void kernel_fpu_begin(void);
-#define kernel_fpu_end() stts()
+#define kernel_fpu_end() stts(); ctx_sw_on()
 
 
 #define unlazy_fpu( tsk ) do { \


