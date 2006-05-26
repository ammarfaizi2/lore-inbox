Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWEZDZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWEZDZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWEZDZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:25:11 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:5566 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030219AbWEZDZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:25:09 -0400
Date: Thu, 25 May 2006 23:24:24 -0400
From: Jeff Dike <jdike@addtoit.com>
To: discuss@x86-64.org, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, User-mode-linux-devel@lists.sourceforge.net,
       Steven James <pyro@linuxlabs.com>, Roland McGrath <roland@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: [RFC] [PATCH] Double syscall exit traces on x86_64
Message-ID: <20060526032424.GA8283@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing double ptrace notifications of system call returns on recent
x86_64 kernels.  This breaks UML and at least one other app.

The patch below appears to fix the problem.  The bug is caused by both
syscall_trace and int_very_careful both calling syscall_trace_leave,
and the system call tracing path going through int_very_careful.

I would have liked to get rid of one or the other call to
syscall_trace_leave.  However, the syscall_trace path looks like it
can exit to userspace without going through int_very_careful, and
int_very_careful does things other than system call tracing.

So, instead, I took _TIF_SYSCALL_TRACE and _TIF_SYSCALL_AUDIT out of
the flags test on the grounds that they had already been checked in
syscall_trace.  There is possibly a preemption and call to schedule
between syscall_trace and int_very_careful, so if it can be attached
at that point, then the first return will be missed.  However, I think
that ptrace attachment requires a stopped child, not just one that has
been preempted.

I don't see signal delivery between syscall_trace and
int_very_careful, so I don't see that there can be a ptrace attach
followed by int_very_careful missing the first return.

This is an RFC - if it turns out to be actually correct, some comments
need fixing before this goes anywhere.

UML works with this applied, and it doesn't seem to break
singlestepping, either on normal instructions or across system calls,
which looks like the next most vulnerable thing.

				Jeff


Index: linux-2.6.16.x86_64/arch/x86_64/kernel/entry.S
===================================================================
--- linux-2.6.16.x86_64.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.16.x86_64/arch/x86_64/kernel/entry.S
@@ -345,7 +345,7 @@ int_very_careful:
 	sti
 	SAVE_REST
 	/* Check for syscall exit trace */	
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_SINGLESTEP),%edx
 	jz int_signal
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
@@ -353,7 +353,7 @@ int_very_careful:
 	call syscall_trace_leave
 	popq %rdi
 	CFI_ADJUST_CFA_OFFSET -8
-	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
+	andl $~(_TIF_SINGLESTEP),%edi
 	cli
 	jmp int_restore_rest
 	
