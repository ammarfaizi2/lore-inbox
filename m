Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269689AbUHZVSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269689AbUHZVSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbUHZVPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:15:10 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:26343 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S269660AbUHZVOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:14:04 -0400
Message-ID: <412E5299.3070806@zytor.com>
Date: Thu, 26 Aug 2004 14:14:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Make i386 signal delivery work with -mregparm
Content-Type: multipart/mixed;
 boundary="------------070003010309010607020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003010309010607020806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch allows i386 signal delivery to work correctly when userspace 
is compiled with -mregparm.  This is somewhat hacky: it passes the 
arguments *both* on the stack and in registers, but it works because 
there are only one or three (depending on SA_SIGINFO) official 
arguments.  If you're relying on the unofficial arguments then you're 
doing something nonportable anyway and can put in the 
__attribute__((cdecl,regparm(0))) in the correct place.

Patch against current top of tree (2.6.9-rc1).

	-hpa

--------------070003010309010607020806
Content-Type: text/x-patch;
 name="signal-regparm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="signal-regparm.diff"

Index: linux-2.5/arch/i386/kernel/signal.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/signal.c,v
retrieving revision 1.42
diff -u -r1.42 signal.c
--- linux-2.5/arch/i386/kernel/signal.c	13 Jul 2004 18:02:33 -0000	1.42
+++ linux-2.5/arch/i386/kernel/signal.c	26 Aug 2004 06:50:40 -0000
@@ -345,18 +345,20 @@
 	void __user *restorer;
 	struct sigframe __user *frame;
 	int err = 0;
+	int usig;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
 
-	err |= __put_user((current_thread_info()->exec_domain
-		           && current_thread_info()->exec_domain->signal_invmap
-		           && sig < 32
-		           ? current_thread_info()->exec_domain->signal_invmap[sig]
-		           : sig),
-		          &frame->sig);
+	usig = current_thread_info()->exec_domain
+		&& current_thread_info()->exec_domain->signal_invmap
+		&& sig < 32
+		? current_thread_info()->exec_domain->signal_invmap[sig]
+		: sig;
+
+	err |= __put_user(usig, &frame->sig);
 	if (err)
 		goto give_sigsegv;
 
@@ -395,6 +397,9 @@
 	/* Set up registers for signal handler */
 	regs->esp = (unsigned long) frame;
 	regs->eip = (unsigned long) ka->sa.sa_handler;
+	regs->eax = (unsigned long) sig;
+	regs->edx = (unsigned long) 0;
+	regs->ecx = (unsigned long) 0;
 
 	set_fs(USER_DS);
 	regs->xds = __USER_DS;
@@ -422,18 +427,20 @@
 	void __user *restorer;
 	struct rt_sigframe __user *frame;
 	int err = 0;
+	int usig;
 
 	frame = get_sigframe(ka, regs, sizeof(*frame));
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
 
-	err |= __put_user((current_thread_info()->exec_domain
-		    	   && current_thread_info()->exec_domain->signal_invmap
-		    	   && sig < 32
-		    	   ? current_thread_info()->exec_domain->signal_invmap[sig]
-			   : sig),
-			  &frame->sig);
+	usig = current_thread_info()->exec_domain
+		&& current_thread_info()->exec_domain->signal_invmap
+		&& sig < 32
+		? current_thread_info()->exec_domain->signal_invmap[sig]
+		: sig;
+
+	err |= __put_user(usig, &frame->sig);
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, info);
@@ -476,6 +483,9 @@
 	/* Set up registers for signal handler */
 	regs->esp = (unsigned long) frame;
 	regs->eip = (unsigned long) ka->sa.sa_handler;
+	regs->eax = (unsigned long) usig;
+	regs->edx = (unsigned long) &frame->info;
+	regs->ecx = (unsigned long) &frame->uc;
 
 	set_fs(USER_DS);
 	regs->xds = __USER_DS;

--------------070003010309010607020806--
