Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCSEBB>; Mon, 18 Mar 2002 23:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293634AbSCSEAw>; Mon, 18 Mar 2002 23:00:52 -0500
Received: from 66-188-80-185.mad.wi.charter.com ([66.188.80.185]:56974 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S293632AbSCSEAj>; Mon, 18 Mar 2002 23:00:39 -0500
To: linux-kernel@vger.kernel.org
Cc: "Mike Coleman" <mkc+dated+1012446540.067c74@mathdogs.com>,
        marcelo@conectiva.com.br, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
	<87665wbdtf.fsf@mathdogs.com> <m3g04qz0yf.fsf@localhost.localdomain>
From: vic <zandy@cs.wisc.edu>
Date: Mon, 18 Mar 2002 21:59:51 -0600
Message-ID: <m3zo15jjgo.fsf@localhost.localdomain>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of the ptrace patch to 2.4 kernels
we've discussed in recent months.

Since the last post, I have updated it to linux 2.4.18
(no changes) and tested it with subterfuge and uml. 

Subterfuge seems to be unaffected.

UML needs minor modifications; I've discussed them with
Jeff Dike and (I believe) he is happy.

I believe I have addressed everyone's concerns.

The patch fixes these two bugs:

    1. gdb and other tools cannot attach to a stopped
    process.  The wait that follows the PTRACE_ATTACH
    will block indefinitely.

    2. It is not possible to use PTRACE_DETACH to leave
    a process stopped, because ptrace ignores SIGSTOPs
    sent by the tracing process.

Vic

--- /home/vic/p/linux-2.4.18.orig/kernel/ptrace.c	Wed Mar 13 13:14:54 2002
+++ /home/vic/p/linux-2.4.18/kernel/ptrace.c	Mon Mar 18 21:58:11 2002
@@ -54,6 +54,7 @@
 
 int ptrace_attach(struct task_struct *task)
 {
+	int stopped;
 	task_lock(task);
 	if (task->pid <= 1)
 		goto bad;
@@ -90,7 +91,13 @@
 	}
 	write_unlock_irq(&tasklist_lock);
 
+	stopped = (task->state == TASK_STOPPED);
 	send_sig(SIGSTOP, task, 1);
+	/* If it was stopped when we got here,
+	   clear the pending SIGSTOP. */
+	if (stopped)
+		wake_up_process(task);
+
 	return 0;
 
 bad:
--- /home/vic/p/linux-2.4.18.orig/arch/i386/kernel/signal.c	Wed Mar 13 13:16:44 2002
+++ /home/vic/p/linux-2.4.18/arch/i386/kernel/signal.c	Wed Mar 13 16:31:38 2002
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
