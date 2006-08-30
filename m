Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWH3Gjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWH3Gjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWH3Gjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:39:48 -0400
Received: from 1wt.eu ([62.212.114.60]:38673 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750752AbWH3Gjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:39:48 -0400
Date: Wed, 30 Aug 2006 08:39:32 +0200
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org
Cc: Riley@Williams.Name, davej@redhat.com, pageexec@freemail.hu
Subject: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830063932.GB289@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

PaX Team has sent me this patch for inclusion. Basically, during early
boot on x86, the exception handler does not make a special case for
exceptions which push an error code onto the stack, leading to a return
to a wrong address. Two patches were proposed, one which would add a
special case for all exceptions using the return code, and this one. The
former was of no use in its form because the return from the exception
handler would get back to the faulting exception, causing it to loop.

This one should be better as it effectively hangs the system using HLT
to prevent CPU from burning.

If nobody has any objections, I will merge it. In this case, I would also
like someone to check if 2.6 needs it and to port it in this case.

Thanks,
Willy

--

fix the longest existing kernel bug ever (since 0.01 ;-). basically,
the dummy interrupt handler installed for the early boot period does
not work for exceptions that push an error code as well, effectively
making the iret at the end of the handler to trigger another exception,
ad infinitum, or rather, until the kernel stack runs over, trashes all
memory below and eventually causes a CPU reset or a hang. without this
fix the early printk facility in 2.6 is also rather useless.


diff -Nurp linux-2.4.33/arch/i386/kernel/head.S linux-2.4.33-early-
inthandler/arch/i386/kernel/head.S
--- linux-2.4.33/arch/i386/kernel/head.S	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.33-early-inthandler/arch/i386/kernel/head.S	2006-08-29 
14:19:55.000000000 +0200
@@ -325,27 +325,21 @@ ENTRY(stack_start)
 
 /* This is the default interrupt "handler" :-) */
 int_msg:
-	.asciz "Unknown interrupt\n"
+	.asciz "Unknown interrupt, stack: %p %p %p %p\n"
 	ALIGN
 ignore_int:
 	cld
-	pushl %eax
-	pushl %ecx
-	pushl %edx
-	pushl %es
-	pushl %ds
 	movl $(__KERNEL_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
+	pushl 12(%esp)
+	pushl 12(%esp)
+	pushl 12(%esp)
+	pushl 12(%esp)
 	pushl $int_msg
 	call SYMBOL_NAME(printk)
-	popl %eax
-	popl %ds
-	popl %es
-	popl %edx
-	popl %ecx
-	popl %eax
-	iret
+1:	hlt
+	jmp 1b
 
 /*
  * The interrupt descriptor table has room for 256 idt's,

