Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269971AbUJNFYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269971AbUJNFYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 01:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269976AbUJNFYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 01:24:52 -0400
Received: from chello083144090118.chello.pl ([83.144.90.118]:46855 "EHLO pluto")
	by vger.kernel.org with ESMTP id S269971AbUJNFYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 01:24:49 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
Subject: [PATCH] [i386] current_stack_pointer()
Date: Thu, 14 Oct 2004 07:24:43 +0200
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_c2gbBsoONDlzFJG"
Message-Id: <200410140724.44408.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_c2gbBsoONDlzFJG
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This trivial fix simplifies the output code.

testcase).

volatile unsigned long tmp = current_stack_pointer

without fix).

#APP
        movl    %esp, %eax      # ti
#NO_APP
        movl    %eax, tmp       # ti, tmp

with fix).

        movl    %esp, tmp       # __esp, tmp

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_c2gbBsoONDlzFJG
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0.diff"

diff -uNr linux-2.6.9-rc4.orig/arch/i386/kernel/irq.c linux-2.6.9-rc4/arch/i386/kernel/irq.c
--- linux-2.6.9-rc4.orig/arch/i386/kernel/irq.c	2004-10-11 04:57:02.000000000 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/irq.c	2004-10-12 18:35:56.734235704 +0200
@@ -515,7 +515,7 @@
 			/* build the stack frame on the IRQ stack */
 			isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
 			irqctx->tinfo.task = curctx->tinfo.task;
-			irqctx->tinfo.previous_esp = current_stack_pointer();
+			irqctx->tinfo.previous_esp = current_stack_pointer;
 
 			*--isp = (u32) action;
 			*--isp = (u32) &regs;
@@ -1135,7 +1135,7 @@
 		curctx = current_thread_info();
 		irqctx = softirq_ctx[smp_processor_id()];
 		irqctx->tinfo.task = curctx->task;
-		irqctx->tinfo.previous_esp = current_stack_pointer();
+		irqctx->tinfo.previous_esp = current_stack_pointer;
 
 		/* build the stack frame on the softirq stack */
 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
diff -uNr linux-2.6.9-rc4.orig/include/asm-i386/thread_info.h linux-2.6.9-rc4/include/asm-i386/thread_info.h
--- linux-2.6.9-rc4.orig/include/asm-i386/thread_info.h	2004-10-11 04:57:04.000000000 +0200
+++ linux-2.6.9-rc4/include/asm-i386/thread_info.h	2004-10-12 18:35:41.420563736 +0200
@@ -92,12 +92,7 @@
 }
 
 /* how to get the current stack pointer from C */
-static inline unsigned long current_stack_pointer(void)
-{
-	unsigned long ti;
-	__asm__("movl %%esp,%0; ":"=r" (ti) : );
-	return ti;
-}
+register unsigned long current_stack_pointer asm ("esp");
 
 /* thread information allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE

--Boundary-00=_c2gbBsoONDlzFJG--
