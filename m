Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVIEDyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVIEDyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVIEDyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:54:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32322
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932188AbVIEDyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:54:46 -0400
Date: Mon, 5 Sep 2005 05:54:32 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       cpushare-devel@cpushare.com
Subject: [patch] i386 seccomp fix for auditing/ptrace
Message-ID: <20050905035432.GG17185@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the same issue as ppc64 before, when returning to userland we
shouldn't re-compute the seccomp check or the task could be killed
during sigreturn when orig_eax is overwritten by the sigreturn syscall.
This was found by Roland.

This was harmless from a security standpoint, but some i686 users
reported failures with auditing enabled system wide (some distro
surprisingly makes it the default) and I reproduced it too by keeping
the whole workload under strace -f.

Patch is tested and works for me under strace -f.

nobody@athlon:~/cpushare> strace -o /tmp/o -f python seccomp_test.py
make: Nothing to be done for `seccomp_test'.
Starting computing some malicious bytecode
init
load
start
stop
receive_data failure
kill
exit_code 0 signal 9
The malicious bytecode has been killed successfully by seccomp
Starting computing some safe bytecode
init
load
start
stop
174 counts
kill
exit_code 0 signal 0
The seccomp_test.py completed successfully, thank you for testing.

Thanks.

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>

diff -r 1df7bfbb783f arch/i386/kernel/ptrace.c
--- a/arch/i386/kernel/ptrace.c	Fri Sep  2 09:01:35 2005
+++ b/arch/i386/kernel/ptrace.c	Mon Sep  5 05:30:49 2005
@@ -680,8 +680,9 @@
 __attribute__((regparm(3)))
 void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	/* do the secure computing check first */
-	secure_computing(regs->orig_eax);
+	if (!entryexit)
+		/* do the secure computing check first */
+		secure_computing(regs->orig_eax);
 
 	if (unlikely(current->audit_context) && entryexit)
 		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
