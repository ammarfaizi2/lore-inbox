Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289376AbSA1UUh>; Mon, 28 Jan 2002 15:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSA1UTC>; Mon, 28 Jan 2002 15:19:02 -0500
Received: from wireless90.cs.wisc.edu ([128.105.48.190]:14979 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S289367AbSA1UPe>; Mon, 28 Jan 2002 15:15:34 -0500
To: linux-kernel@vger.kernel.org
Cc: "Mike Coleman" <mkc+dated+1012446540.067c74@mathdogs.com>,
        marcelo@conectiva.com.br, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
	<87665wbdtf.fsf@mathdogs.com>
From: vic <zandy@cs.wisc.edu>
Date: Mon, 28 Jan 2002 14:15:36 -0600
In-Reply-To: <87665wbdtf.fsf@mathdogs.com> ("Mike Coleman"'s message of "20
 Jan 2002 21:09:00 -0600")
Message-ID: <m3g04qz0yf.fsf@localhost.localdomain>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for this long message and my delayed replies to everyone's
feedback.

"Mike Coleman" <mkc+dated+1012446540.067c74@mathdogs.com> writes:

> Okay.  Is it at least backward compatible?  Or are some tools expected to
> break?

Some tools may break: those that (1) attach to a stopped
process or (2) detach and leave the process stopped.  However,
I expect the maintainers of such tools will appreciate this
patch, as it would simplify the way they do these things now.

First, a tool that wants to attach to a stopped process needs
some tricks.  For example, if you SIGSTOP any process and then
try to attach gdb to it, gdb will hang.  The problem is that
when the process is already stopped, the call to wait after
PTRACE_ATTACH can block indefinitely because the process
exit_code is left at 0 (so wait blocks) but the process is not
awake.  Currently tools need to detect this condition and
manually wind the process past the pending SIGSTOP.  gdb
doesn't do that.

Second, our tool Paradyn (www.paradyn.org) sometimes wants to
detach and leave a process stopped; I am not aware of any other
tool that needs to do this, but it's not a strange request.
The natural way you would do this with ptrace (PTRACE_DEATCH
with SIGSTOP) does not work.  We found that we had to read the
kernel to figure out how to do it reliably on Linux (i.e., to
understand the race conditions).  The algorithm that we
eventually settled on is non-intuitive and involves calling
sleep to avoid a race we saw no other way around.

Again, tools that work around either of these problem, like
ours, will be affected by this patch: they will need to retire
their kludges and instead do what they probably wanted to do in
the first place.

Offline I corresponded with OGAWA Hirofumi and he gave me an
approach to the PTRACE_KILL issue that I have been slow to
understand.  Now when attaching, I always send the SIGSTOP, but
wake the process if it was already stopped.  I leave the
exit_code the way it was.

Mike Coleman is concerned about SIGCONT and whether this patch
prevents processes from being continued naturally, without
handling a SIGCONT.  Nothing has changed in this aspect.  If
the tracing process wants to continue a process, it just either
does PTRACE_CONT or PTRACE_DETACH as usual.

As promised, I will check UML and Subterfuge; I haven't had the
time.  If anyone can alert me to potentially problematic
operations in these programs, that would very helpful.

The updated patch is below.

Thanks,
Vic

--- /home/vic/src/linux-2.4.16/kernel/ptrace.c	Wed Nov 21 16:43:01 2001
+++ /home/vic/src/linux-2.4.16.1/kernel/ptrace.c	Mon Jan 28 12:12:26 2002
@@ -54,6 +54,8 @@
 
 int ptrace_attach(struct task_struct *task)
 {
+	int stopped;
+
 	task_lock(task);
 	if (task->pid <= 1)
 		goto bad;
@@ -90,7 +92,13 @@
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
--- /home/vic/src/linux-2.4.16/arch/i386/kernel/signal.c	Fri Sep 14 16:15:40 2001
+++ /home/vic/src/linux-2.4.16.1/arch/i386/kernel/signal.c	Wed Jan 16 22:19:16 2002
@@ -620,9 +620,9 @@
 				continue;
 			current->exit_code = 0;
 
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
+			/* The debugger continued. */
+			if (signr == SIGSTOP && (current->ptrace & PT_PTRACED))
+				continue; /* ignore SIGSTOP */
 
 			/* Update the siginfo structure.  Is this good?  */
 			if (signr != info.si_signo) {
