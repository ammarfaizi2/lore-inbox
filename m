Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282547AbRLRPtp>; Tue, 18 Dec 2001 10:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284134AbRLRPtf>; Tue, 18 Dec 2001 10:49:35 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:42723 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284124AbRLRPtW>; Tue, 18 Dec 2001 10:49:22 -0500
Date: Tue, 18 Dec 2001 10:49:13 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Fix arch/i386/kernel/{signal,vm68}.c for CVS gcc
Message-ID: <20011218104913.T4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Using __attribute__((regparm(0))) __attribute__((regparm(3))) on the same
function is asking for trouble. I think gcc documentation never talks about
what it does when seeing attributes for the same DECL/TYPE. It used to pick
regparm(3), current CVS gcc picks regparm(0).

Please apply.

--- linux/arch/i386/kernel/vm86.c.jj	Sat Jul  7 02:05:07 2001
+++ linux/arch/i386/kernel/vm86.c	Tue Dec 18 16:55:52 2001
@@ -62,7 +62,7 @@
         ( (unsigned)( & (((struct kernel_vm86_regs *)0)->VM86_REGS_PART2) ) )
 #define VM86_REGS_SIZE2 (sizeof(struct kernel_vm86_regs) - VM86_REGS_SIZE1)
 
-asmlinkage struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
+struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
 struct pt_regs * save_v86_state(struct kernel_vm86_regs * regs)
 {
 	struct tss_struct *tss;
--- linux/arch/i386/kernel/signal.c.jj	Fri Sep 14 23:15:40 2001
+++ linux/arch/i386/kernel/signal.c	Tue Dec 18 16:56:05 2001
@@ -28,7 +28,7 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-asmlinkage int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
+int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
 int copy_siginfo_to_user(siginfo_t *to, siginfo_t *from)
 {

	Jakub
