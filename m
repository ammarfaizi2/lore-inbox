Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbTC1AGI>; Thu, 27 Mar 2003 19:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbTC1AGI>; Thu, 27 Mar 2003 19:06:08 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:6294 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S261485AbTC1AGG>; Thu, 27 Mar 2003 19:06:06 -0500
Date: Thu, 27 Mar 2003 16:17:15 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BUG] 2.5.65 kills dosemu, 2.5.64 is OK
In-Reply-To: <Pine.LNX.4.44.0303251531480.18554-100000@mf1.private>
Message-ID: <Pine.LNX.4.44.0303271601170.20032-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Wayne Whitney wrote:

> From time to time I run an old DOS game under dosemu under X.  In 2.5.64,
> everything works fine.  In 2.5.65, after about a minute, the display locks
> up.  Alt-Sysrq stills works OK.

OK, I traced this problem to the "Cache the MSR_IA32_SYSENTER_CS value in
the per-CPU TSS" changeset from Linus, which is number 1.889.330.36 on
linus.bkbit.net/linux-2.5.  This changeset first appeared in 2.5.64-bk5.  
To be 100% clear, 2.5.64-bk4 doesn't have the problem, 2.5.65-bk5 does
have the problem, and 2.5.64-bk5 with the changeset reverted doesn't have
the problem.  

Oh, I am running dosemu 1.0.2.1.  For reference, the Changeset diff is
below.  Any thoughts on why dosemu is no longer working for me?

Yours, Wayne


diff -ru linux-2.5.64-bk4/arch/i386/kernel/sysenter.c linux-2.5.64-bk5/arch/i386/kernel/sysenter.c
--- linux-2.5.64-bk4/arch/i386/kernel/sysenter.c	2003-03-26 21:06:54.000000000 -0800
+++ linux-2.5.64-bk5/arch/i386/kernel/sysenter.c	2003-03-26 13:55:08.000000000 -0800
@@ -40,6 +40,7 @@
 	int cpu = get_cpu();
 	struct tss_struct *tss = init_tss + cpu;
 
+	tss->ss1 = __KERNEL_CS;
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp0, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
diff -ru linux-2.5.64-bk4/arch/i386/kernel/vm86.c linux-2.5.64-bk5/arch/i386/kernel/vm86.c
--- linux-2.5.64-bk4/arch/i386/kernel/vm86.c	2003-03-26 21:06:54.000000000 -0800
+++ linux-2.5.64-bk5/arch/i386/kernel/vm86.c	2003-03-26 13:55:08.000000000 -0800
@@ -291,7 +291,7 @@
 
 	tss = init_tss + smp_processor_id();
 	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
-	disable_sysenter();
+	disable_sysenter(tss);
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
diff -ru linux-2.5.64-bk4/include/asm-i386/processor.h linux-2.5.64-bk5/include/asm-i386/processor.h
--- linux-2.5.64-bk4/include/asm-i386/processor.h	2003-03-26 21:06:55.000000000 -0800
+++ linux-2.5.64-bk5/include/asm-i386/processor.h	2003-03-26 13:55:09.000000000 -0800
@@ -347,7 +347,7 @@
 	unsigned long	esp0;
 	unsigned short	ss0,__ss0h;
 	unsigned long	esp1;
-	unsigned short	ss1,__ss1h;
+	unsigned short	ss1,__ss1h;	/* ss1 is used to cache MSR_IA32_SYSENTER_CS */
 	unsigned long	esp2;
 	unsigned short	ss2,__ss2h;
 	unsigned long	__cr3;
@@ -413,15 +413,20 @@
 {
 	tss->esp0 = esp0;
 	if (cpu_has_sep) {
-		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+		if (tss->ss1 != __KERNEL_CS) {
+			tss->ss1 = __KERNEL_CS;
+			wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+		}
 		wrmsr(MSR_IA32_SYSENTER_ESP, esp0, 0);
 	}
 }
 
-static inline void disable_sysenter(void)
+static inline void disable_sysenter(struct tss_struct *tss)
 {
-	if (cpu_has_sep)  
+	if (cpu_has_sep)  {
+		tss->ss1 = 0;
 		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
+	}
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\


