Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273289AbRINEfo>; Fri, 14 Sep 2001 00:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273287AbRINEfZ>; Fri, 14 Sep 2001 00:35:25 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:14873 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S273285AbRINEfO> convert rfc822-to-8bit; Fri, 14 Sep 2001 00:35:14 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.12.07.08 (Preview Release)
Date: 14 Sep 2001 00:35:01 -0400
Message-Id: <1000442113.3897.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-13 at 22:47, Dieter Nützel wrote:
> > first, highmem is fixed and the original patch you have from me is good.
> > second, Daniel Phillips gave me some feedback into how to figure out the
> > VM error.  I am working on it, although just the VM potential
> 
> Good to hear.
> 
> > -- ReiserFS may be another problem.
> 
> Can't wait for that.
> 
> > third, you may be experiencing problems with a kernel optimized for
> > Athlon.  this may or may not be related to the current issues with an
> > Athlon-optimized kernel.  Basically, functions in arch/i386/lib/mmx.c
> > seem to need some locking to prevent preemption.  I have a basic patch
> > and we are working on a final one.
> 
> Can you please send this stuff along to me?
> You know I own an Athlon (since yester Athlon II 1 GHz :-) and need some 
> input...

Yes, find the Athlon patch below.  Please let me know if it works.

> Mobo is MSI MS-6167 Rev 1.0B (AMD Irongate C4, yes the very first one)
> 
> Kernel with preempt patch and mmx/3dnow! optimization crash randomly.
> Never had that (without preempt) during the last two years.

Oh, I did not remember you having problems with Athlon.  I try to keep a
list of what problems are being had.

Are there any other configurations where you have problems?

> Thanks,
> 	Dieter

You are welcome; thank you for the feedback.

Before applying, note there are new patches at
http://tech9.net/rml/linux - a patch for 2.4.10-pre9 and a _new_ patch
for 2.4.9-ac10.  These include everything (highmem, etc) except the
Athlon patch.

The problem with Athlon compiled kernels is that MMX/3DNow routines used
in the kernel are not preempt safe (but SMP safe, so I missed them). 
This patch should correct it.


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


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

