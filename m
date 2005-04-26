Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVDZLcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVDZLcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVDZLcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:32:20 -0400
Received: from hades.snarc.org ([212.85.152.11]:15877 "EHLO hades.snarc.org")
	by vger.kernel.org with ESMTP id S261449AbVDZLbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:31:53 -0400
Date: Tue, 26 Apr 2005 13:31:49 +0200
From: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: ian.pratt@cl.cam.ac.uk, akpm@osdl.org, ak@suse.de
Subject: [PATCH 5/6][XEN][x86_64] Add macro for debugreg
Message-ID: <20050426113149.GE26614@snarc.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ian.pratt@cl.cam.ac.uk, akpm@osdl.org, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch add 2 macros to set and get debugreg on x86_64.
This is useful for Xen because it will need only to redefine each macro
to a hypervisor call. 

Please apply, or comments.

	Signed-off-by: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Naur linux-2.6.12-rc3.1/arch/x86_64/kernel/signal.c linux-2.6.12-rc3.2/arch/x86_64/kernel/signal.c
--- linux-2.6.12-rc3.1/arch/x86_64/kernel/signal.c	2005-04-25 14:19:05.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/x86_64/kernel/signal.c	2005-04-25 14:59:09.950079957 +0100
@@ -433,7 +433,7 @@
 		 * inside the kernel.
 		 */
 		if (current->thread.debugreg7)
-			asm volatile("movq %0,%%db7"	: : "r" (current->thread.debugreg7));
+			cpu_set_debugreg(current->thread.debugreg7, 7);
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, &ka, oldset, regs);
diff -Naur linux-2.6.12-rc3.1/arch/x86_64/kernel/traps.c linux-2.6.12-rc3.2/arch/x86_64/kernel/traps.c
--- linux-2.6.12-rc3.1/arch/x86_64/kernel/traps.c	2005-04-25 12:01:25.000000000 +0100
+++ linux-2.6.12-rc3.2/arch/x86_64/kernel/traps.c	2005-04-25 14:58:17.006385409 +0100
@@ -667,7 +667,7 @@
        }
 #endif
 
-	asm("movq %%db6,%0" : "=r" (condition));
+	cpu_get_debugreg(condition, 6);
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
 						SIGTRAP) == NOTIFY_STOP)
@@ -719,7 +719,7 @@
 	info.si_addr = (void __user *)regs->rip;
 	force_sig_info(SIGTRAP, &info, tsk);	
 clear_dr7:
-	asm volatile("movq %0,%%db7"::"r"(0UL));
+	cpu_set_debugreg(0UL, 7);
 	return;
 
 clear_TF_reenable:
diff -Naur linux-2.6.12-rc3.1/include/asm-x86_64/processor.h linux-2.6.12-rc3.2/include/asm-x86_64/processor.h
--- linux-2.6.12-rc3.1/include/asm-x86_64/processor.h	2005-04-25 15:37:51.000000000 +0100
+++ linux-2.6.12-rc3.2/include/asm-x86_64/processor.h	2005-04-25 15:38:13.750221554 +0100
@@ -280,6 +280,14 @@
 	set_fs(USER_DS);							 \
 } while(0) 
 
+#define cpu_get_debugreg(var, register)				\
+		__asm__("movq %%db" #register ", %0"		\
+			:"=r" (var))
+#define cpu_set_debugreg(value, register)			\
+		__asm__("movq %0,%%db" #register		\
+			: /* no output */			\
+			:"r" (value))
+
 struct task_struct;
 struct mm_struct;
 
