Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRLDEQZ>; Mon, 3 Dec 2001 23:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRLDEQQ>; Mon, 3 Dec 2001 23:16:16 -0500
Received: from quark.didntduck.org ([216.43.55.190]:10250 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S280191AbRLDEPy>; Mon, 3 Dec 2001 23:15:54 -0500
Message-ID: <3C0C4D11.90D3A46B@didntduck.org>
Date: Mon, 03 Dec 2001 23:12:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre5-bg1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Small bluesmoke patch
Content-Type: multipart/mixed;
 boundary="------------61C45F33DA20FBF4617B53BA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------61C45F33DA20FBF4617B53BA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch eliminates the do_machine_check function, by using the
machine_check_vector directly from the asm entry stub.

-- 

						Brian Gerst
--------------61C45F33DA20FBF4617B53BA
Content-Type: text/plain; charset=us-ascii;
 name="diff-bluesmoke"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-bluesmoke"

diff -urN linux-2.5.1-pre2/arch/i386/kernel/bluesmoke.c linux/arch/i386/kernel/bluesmoke.c
--- linux-2.5.1-pre2/arch/i386/kernel/bluesmoke.c	Mon Nov 12 12:59:43 2001
+++ linux/arch/i386/kernel/bluesmoke.c	Tue Nov 27 15:01:50 2001
@@ -98,16 +98,7 @@
 	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
 }
 
-/*
- *	Call the installed machine check handler for this CPU setup.
- */
-
-static void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
-
-asmlinkage void do_machine_check(struct pt_regs * regs, long error_code)
-{
-	machine_check_vector(regs, error_code);
-}
+void (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
 /*
  *	Set up machine check reporting for Intel processors
diff -urN linux-2.5.1-pre2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.1-pre2/arch/i386/kernel/entry.S	Fri Nov  2 20:18:49 2001
+++ linux/arch/i386/kernel/entry.S	Tue Nov 27 15:01:17 2001
@@ -386,7 +386,7 @@
 
 ENTRY(machine_check)
 	pushl $0
-	pushl $ SYMBOL_NAME(do_machine_check)
+	pushl SYMBOL_NAME(machine_check_vector)
 	jmp error_code
 
 ENTRY(spurious_interrupt_bug)

--------------61C45F33DA20FBF4617B53BA--

