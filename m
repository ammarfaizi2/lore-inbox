Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288262AbSA0Ror>; Sun, 27 Jan 2002 12:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSA0Rof>; Sun, 27 Jan 2002 12:44:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11927 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288262AbSA0Roa>;
	Sun, 27 Jan 2002 12:44:30 -0500
Date: Sun, 27 Jan 2002 18:37:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] x86 idle thread should clear %fs, %gs
Message-ID: <Pine.LNX.4.33.0201271826220.5785-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the idle thread (on SMP, all idle threads) should clear the %fs and %gs
register, we forgot to clear these registers after the boot process. This
is especially important in kernels with the previous %fs/%gs patch
applied. (The patch below is against 2.5.3-pre3.)

i've checked and it apperas that the 0.01 Linux kernel source code has the
same problem, in boot/head.s the idle task loads the 0x10 selector, and
INIT_TASK's init TSS uses the 0x17 selector for %gs and never clears it.
:-)

while it's not an issue from the correctness point of view in the 0.01
kernel either, the TSS switching microcode probably exeutes slightly
faster if %gs is 0 for both tasks.

so it appears that this lowlevel x86 performance bug(?) is more than 11
years old! :-)

	Ingo

--- linux/arch/i386/kernel/setup.c.orig	Sun Jan 27 15:14:43 2002
+++ linux/arch/i386/kernel/setup.c	Sun Jan 27 16:01:34 2002
@@ -2803,9 +2803,10 @@
 	load_TR(nr);
 	load_LDT(&init_mm);

-	/*
-	 * Clear all 6 debug registers:
-	 */
+	/* Clear %fs and %gs. */
+	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
+
+	/* Clear all 6 debug registers: */

 #define CD(register) __asm__("movl %0,%%db" #register ::"r"(0) );


