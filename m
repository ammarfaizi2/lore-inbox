Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUKDCC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUKDCC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUKDCBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:01:51 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:64659
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262052AbUKDBzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:38 -0500
Subject: [patch 14/20] uml: fix sysemu test at startup
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it, bodo.stroesser@fujitsu-siemens.com
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:47 +0100
Message-Id: <20041103231747.7CCC855C83@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

Currently, the test for the SYSEMU support on the host is completely wrong, as
Bodo noticed. We should change the syscall result (inserting the host pid) and
check if it is received correctly by the guest. What we actually do, without
this patch, is to overwrite the syscall number.

This went unnoticed because we only check that the getpid() syscall from the
child does not return its pid. We don't check that it returns the correct
value.

Also, override the result portably, using the PT_SYSCALL_RET_OFFSET macro
which abstract away the host stack frame layout (took from Jeff Dike code).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/process.c~uml-fix-sysemu-test-startup arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-fix-sysemu-test-startup	2004-11-03 23:45:15.751044208 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:45:15.754043752 +0100
@@ -214,8 +214,6 @@ static void __init check_sysemu(void)
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
-		struct user_regs_struct regs;
-
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if (n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
@@ -223,18 +221,16 @@ static void __init check_sysemu(void)
 			panic("check_ptrace : expected SIGTRAP, "
 			      "got status = %d", status);
 
-		if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to read child "
-			      "registers, errno = %d", errno);
-		regs.orig_eax = pid;
-		if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to modify child "
-			      "registers, errno = %d", errno);
+		n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+			   os_getpid());
+		if(n < 0)
+			panic("check_ptrace : failed to modify system "
+			      "call return, errno = %d", errno);
 
 		stop_ptraced_child(pid, stack, 0);
 
 		sysemu_supported = 1;
-		printk("found\n");
+		printk("OK\n");
 	}
 	else
 	{
_
