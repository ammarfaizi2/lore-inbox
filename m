Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVGaSGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVGaSGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVGaSGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:06:39 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43944 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261850AbVGaSGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:06:38 -0400
Subject: [patch 1/1] UML Support - SYSEMU: slight cleanup and speedup
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       cwright@cs.sunysb.edu
From: blaisorblade@yahoo.it
Date: Sun, 31 Jul 2005 20:11:31 +0200
Message-Id: <20050731181134.4D98721D458@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Charles P. Wright <cwright@cs.sunysb.edu>

As a follow-up to "UML Support - Ptrace: adds the host SYSEMU support, for UML
and general usage" (i.e. uml-support-* in current mm).

Avoid unconditionally jumping to work_pending and code copying, just reuse the
already existing resume_userspace path.

About those patches, they should stay in -mm only for now - I expect to get
them reviewed.

One interesting note, from Charles P. Wright, suggested that the API is
improvable with no downsides for UML (except that it will have to support yet
another host API, since dropping support for the current API, for UML, is not
reasonable from users' point of view).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/entry.S |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/i386/kernel/entry.S~sysemu-cleanup-speedup arch/i386/kernel/entry.S
--- linux-2.6.git/arch/i386/kernel/entry.S~sysemu-cleanup-speedup	2005-07-31 20:03:19.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/entry.S	2005-07-31 20:03:19.000000000 +0200
@@ -339,18 +339,12 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_skip		# ret != 0 -> running under PTRACE_SYSEMU,
+	jne resume_userspace		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
-syscall_skip:
-	cli				# make sure we don't miss an interrupt
-					# setting need_resched or sigpending
-					# between sampling and the iret
-	movl TI_flags(%ebp), %ecx
-	jmp work_pending
 
 	# perform syscall exit tracing
 	ALIGN
_
