Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbRLUTxn>; Fri, 21 Dec 2001 14:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285074AbRLUTxd>; Fri, 21 Dec 2001 14:53:33 -0500
Received: from wireless90.cs.wisc.edu ([128.105.48.190]:7057 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S285073AbRLUTxS>; Fri, 21 Dec 2001 14:53:18 -0500
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: [PATCH] ptrace on stopped processes (2.4)
From: vic <zandy@cs.wisc.edu>
Date: Fri, 21 Dec 2001 13:53:32 -0600
Message-ID: <m3adwc9woz.fsf@localhost.localdomain>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple problems with ptrace's interaction with
stopped processes on Linux 2.4.

The most significant bug is that gdb cannot attach to a stopped
process.  Specifically, the wait that follows the PTRACE_ATTACH will
block indefinitely.

Another bug is that it is not possible to use PTRACE_DETACH to leave a
process stopped, because ptrace ignores SIGSTOPs sent by the tracing
process.

This patch is against 2.4.16 on x86.  I have tested gdb and strace.
After this patch is reviewed, I would be happy to submit an analogous
patch for the other platforms, although I cannot test it.

Vic Zandy

--- linux-2.4.16/arch/i386/kernel/signal.c	Fri Sep 14 16:15:40 2001
+++ linux-2.4.16.1/arch/i386/kernel/signal.c	Fri Dec 21 11:05:45 2001
@@ -620,9 +620,9 @@
 				continue;
 			current->exit_code = 0;
 
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
+			/* The debugger continued. */
+			if (signr == SIGSTOP && current->ptrace & PT_PTRACED)
+				continue; /* ignore SIGSTOP */
 
 			/* Update the siginfo structure.  Is this good?  */
 			if (signr != info.si_signo) {
--- linux-2.4.16/kernel/ptrace.c	Wed Nov 21 16:43:01 2001
+++ linux-2.4.16.1/kernel/ptrace.c	Fri Dec 21 10:42:44 2001
@@ -89,8 +89,10 @@
 		SET_LINKS(task);
 	}
 	write_unlock_irq(&tasklist_lock);
-
-	send_sig(SIGSTOP, task, 1);
+	if (task->state != TASK_STOPPED)
+		send_sig(SIGSTOP, task, 1);
+	else
+		task->exit_code = SIGSTOP;
 	return 0;
 
 bad:
