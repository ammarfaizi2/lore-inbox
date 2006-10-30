Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWJ3DXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWJ3DXv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbWJ3DXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:23:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:61716 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030497AbWJ3DXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:23:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:date:message-id:subject;
        b=ZLjtFbOLFa/rw7Sf1Rlppxtn0MhlBZtrBTVFYjtAPmqM9+xgAXDelMEPC1yPmzQGU5jo0lfKBXxVrNNZhIl7B6G+jwIFG12Qh+TIsFHq8pBvV8VENanNDb6dhBriHpzSJqhqUWRCY43ZDiKTcAsfHKzZwLjrDUvt/A95T275hew=
From: Albert Cahalan <acahalan@gmail.com>
To: Albert Cahalan <acahalan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Cc: Albert Cahalan <acahalan@gmail.com>
Date: Sun, 29 Oct 2006 22:26:17 -0500
Message-Id: <20061030032617.9875.86052.sendpatchset@cube>
Subject: [PATCH] i386 regparm=3 RT signal handlers on x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to make x86_64 support i386 binaries compiled
with -mregparm=3 only covered signal handlers without SA_SIGINFO.
(the 3-arg "real-time" ones) This is useful for klibc at least.

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

diff -Naurd old/arch/x86_64/ia32/ia32_signal.c new/arch/x86_64/ia32/ia32_signal.c
--- old/arch/x86_64/ia32/ia32_signal.c	2006-10-29 20:36:01.000000000 -0500
+++ new/arch/x86_64/ia32/ia32_signal.c	2006-10-29 21:58:01.000000000 -0500
@@ -579,6 +579,11 @@
 	regs->rsp = (unsigned long) frame;
 	regs->rip = (unsigned long) ka->sa.sa_handler;
 
+	/* Make -mregparm=3 work */
+	regs->rax = sig;
+	regs->rdx = (unsigned long) &frame->info;
+	regs->rcx = (unsigned long) &frame->uc;
+
 	asm volatile("movl %0,%%ds" :: "r" (__USER32_DS)); 
 	asm volatile("movl %0,%%es" :: "r" (__USER32_DS)); 
 	
