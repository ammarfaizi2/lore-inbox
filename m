Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVEROwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVEROwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVEROwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:52:10 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:55003 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262283AbVEROvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:51:24 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] [2/2] kdump: Save trap information for later
	analyzis
From: Alexander Nyberg <alexn@telia.com>
To: vgoyal@in.ibm.com
Cc: fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050518124144.GB3657@in.ibm.com>
References: <1116103800.6153.31.camel@localhost.localdomain>
	 <20050518124144.GB3657@in.ibm.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 16:51:03 +0200
Message-Id: <1116427863.22324.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we are faulting in kernel it is quite possible this will lead to a
panic. Save trap number, cr2 (in case of page fault) and error_code in
the current thread (these fields already exist for signal delivery but
are not used here). 

This helps later kdump crash analyzing from user-space (a script has
been submitted to dig this info out in gdb).


Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: mm/arch/i386/mm/fault.c
===================================================================
--- mm.orig/arch/i386/mm/fault.c	2005-05-18 16:39:04.000000000 +0200
+++ mm/arch/i386/mm/fault.c	2005-05-18 16:39:20.000000000 +0200
@@ -469,6 +469,9 @@
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 #endif
+	tsk->thread.cr2 = address;
+	tsk->thread.trap_no = 14;
+	tsk->thread.error_code = error_code;
 	die("Oops", regs, error_code);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
Index: mm/arch/i386/kernel/traps.c
===================================================================
--- mm.orig/arch/i386/kernel/traps.c	2005-05-18 16:39:04.000000000 +0200
+++ mm/arch/i386/kernel/traps.c	2005-05-18 16:39:20.000000000 +0200
@@ -410,6 +410,10 @@
 static void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
+	struct task_struct *tsk = current;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_no = trapnr;
+	
 	if (regs->eflags & VM_MASK) {
 		if (vm86)
 			goto vm86_trap;
@@ -420,9 +424,6 @@
 		goto kernel_trap;
 
 	trap_signal: {
-		struct task_struct *tsk = current;
-		tsk->thread.error_code = error_code;
-		tsk->thread.trap_no = trapnr;
 		if (info)
 			force_sig_info(signr, info, tsk);
 		else
@@ -537,6 +538,9 @@
 	}
 	put_cpu();
 
+	current->thread.error_code = error_code;
+	current->thread.trap_no = 13;
+	
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
@@ -977,9 +981,9 @@
 					  error_code);
 			return;
 		}
-		die_if_kernel("cache flush denied", regs, error_code);
 		current->thread.trap_no = 19;
 		current->thread.error_code = error_code;
+		die_if_kernel("cache flush denied", regs, error_code);
 		force_sig(SIGSEGV, current);
 	}
 }


