Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVDEQ7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVDEQ7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVDEQuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:50:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:63641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261820AbVDEQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:42 -0400
Date: Tue, 5 Apr 2005 09:46:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: amy.griffis@hp.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       dwmw2@infradead.org
Subject: [03/08] fix ia64 syscall auditing
Message-ID: <20050405164647.GD17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Attached is a patch against David's audit.17 kernel that adds checks
for the TIF_SYSCALL_AUDIT thread flag to the ia64 system call and
signal handling code paths.  The patch enables auditing of system
calls set up via fsys_bubble_down, as well as ensuring that
audit_syscall_exit() is called on return from sigreturn.

Neglecting to check for TIF_SYSCALL_AUDIT at these points results in
incorrect information in audit_context, causing frequent system panics
when system call auditing is enabled on an ia64 system.

I have tested this patch and have seen no problems with it.

[Original patch from Amy Griffis ported to current kernel by David Woodhouse]

From: Amy Griffis <amy.griffis@hp.com>
From: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- 1.34/arch/ia64/kernel/fsys.S	2005-01-22 22:19:11 +00:00
+++ edited/arch/ia64/kernel/fsys.S	2005-04-01 00:20:32 +01:00
@@ -611,8 +611,10 @@
 	movl r2=ia64_ret_from_syscall
 	;;
 	mov rp=r2				// set the real return addr
-	tbit.z p8,p0=r3,TIF_SYSCALL_TRACE
+	and r3=_TIF_SYSCALL_TRACEAUDIT,r3
 	;;
+	cmp.eq p8,p0=r3,r0
+
 (p10)	br.cond.spnt.many ia64_ret_from_syscall	// p10==true means out registers are more than 8
 (p8)	br.call.sptk.many b6=b6		// ignore this return addr
 	br.cond.sptk ia64_trace_syscall
===== arch/ia64/kernel/signal.c 1.49 vs edited =====
--- 1.49/arch/ia64/kernel/signal.c	2005-01-25 20:23:45 +00:00
+++ edited/arch/ia64/kernel/signal.c	2005-04-01 00:18:29 +01:00
@@ -224,7 +224,8 @@
 	 * could be corrupted.
 	 */
 	retval = (long) &ia64_leave_kernel;
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
+	if (test_thread_flag(TIF_SYSCALL_TRACE) 
+	    || test_thread_flag(TIF_SYSCALL_AUDIT))
 		/*
 		 * strace expects to be notified after sigreturn returns even though the
 		 * context to which we return may not be in the middle of a syscall.
