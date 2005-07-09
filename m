Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVGIPaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVGIPaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVGIPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 11:30:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27799 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261528AbVGIP3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 11:29:19 -0400
Date: Sat, 9 Jul 2005 17:29:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       "Guillaume C." <guichaz@gmail.com>
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050709152924.GA13492@elte.hu>
References: <20050709144116.GA9444@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709144116.GA9444@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guillaume noticed a bug in the patch, si_signo should be used instead of 
SIGSEGV. (doh) New patch below.

	Ingo

-----

this patch pushes the creation of a rare signal frame (SIGBUS or 
SIGSEGV) into a separate function, thus saving stackspace in the main 
do_page_fault() stackframe. The effect is 132 bytes less of stack used 
by the typical do_page_fault() invocation - resulting in a denser 
cache-layout.

(another minor effect is that in case of kernel crashes that come from a 
pagefault, we add less space to the already existing frame, giving the 
crash functions a slightly higher chance to do their stuff without 
overflowing the stack.)

(the changes also result in slightly cleaner code.)

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

argument bugfix from "Guillaume C." <guichaz@gmail.com>

Index: linux/arch/i386/mm/fault.c
===================================================================
--- linux.orig/arch/i386/mm/fault.c
+++ linux/arch/i386/mm/fault.c
@@ -201,6 +201,18 @@ static inline int is_prefetch(struct pt_
 	return 0;
 } 
 
+static void force_sig_info_fault(int si_signo, int si_code,
+				 unsigned long address, struct task_struct *tsk)
+{
+	siginfo_t info;
+
+	info.si_signo = si_signo;
+	info.si_errno = 0;
+	info.si_code = si_code;
+	info.si_addr = (void __user *)address;
+	force_sig_info(si_signo, &info, tsk);
+}
+
 fastcall void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
@@ -220,9 +232,8 @@ fastcall notrace void do_page_fault(stru
 	struct vm_area_struct * vma;
 	unsigned long address;
 	unsigned long page;
-	int write;
-	siginfo_t info;
-
+	int write, si_code;
+	
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
 	trace_special(regs->eip, error_code, address);
@@ -236,7 +247,7 @@ fastcall notrace void do_page_fault(stru
 
 	tsk = current;
 
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
@@ -316,7 +327,7 @@ fastcall notrace void do_page_fault(stru
  * we can handle it..
  */
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 	write = 0;
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
@@ -390,11 +401,7 @@ bad_area_nosemaphore:
 		/* Kernel addresses are always protection faults */
 		tsk->thread.error_code = error_code | (address >= TASK_SIZE);
 		tsk->thread.trap_no = 14;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_info_fault(SIGSEGV, si_code, address, tsk);
 		return;
 	}
 
@@ -500,11 +507,7 @@ do_sigbus:
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *)address;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
 	return;
 
 vmalloc_fault:
