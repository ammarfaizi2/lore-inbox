Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbTBFWeA>; Thu, 6 Feb 2003 17:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbTBFWd4>; Thu, 6 Feb 2003 17:33:56 -0500
Received: from crack.them.org ([65.125.64.184]:14314 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267652AbTBFWdR>;
	Thu, 6 Feb 2003 17:33:17 -0500
Date: Thu, 6 Feb 2003 17:42:54 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Ptrace updates: event tracing for vfork finish and process exit [4/5]
Message-ID: <20030206224254.GD22762@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030206223924.GA22688@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206223924.GA22688@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two new event hooks to ptrace:

  PTRACE_EVENT_EXIT, which triggers in do_exit().  This is useful to quickly
  find out where a program is making an exit syscall from, etc. - it
  triggers before the mm is released, so we can still get backtraces et
  cetera.

  PTRACE_EVENT_VFORK_DONE triggers in do_fork() after the vfork completion,
  i.e. when the child is done with the mm.  This is a safe way to figure out
  when we can re-insert breakpoints in the parent without the child hitting
  them.  It's the only safe way, in fact.

# --------------------------------------------
# 03/02/06	drow@nevyn.them.org	1.960
# Add PTRACE_O_TRACEVFORKDONE and PTRACE_O_TRACEEXIT facilities.
# --------------------------------------------

diff -Nru a/include/linux/ptrace.h b/include/linux/ptrace.h
--- a/include/linux/ptrace.h	Thu Feb  6 16:57:29 2003
+++ b/include/linux/ptrace.h	Thu Feb  6 16:57:29 2003
@@ -35,12 +35,16 @@
 #define PTRACE_O_TRACEVFORK	0x00000004
 #define PTRACE_O_TRACECLONE	0x00000008
 #define PTRACE_O_TRACEEXEC	0x00000010
+#define PTRACE_O_TRACEVFORKDONE	0x00000020
+#define PTRACE_O_TRACEEXIT	0x00000040
 
 /* Wait extended result codes for the above trace options.  */
 #define PTRACE_EVENT_FORK	1
 #define PTRACE_EVENT_VFORK	2
 #define PTRACE_EVENT_CLONE	3
 #define PTRACE_EVENT_EXEC	4
+#define PTRACE_EVENT_VFORK_DONE	5
+#define PTRACE_EVENT_EXIT	6
 
 #include <asm/ptrace.h>
 #include <linux/sched.h>
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Feb  6 16:57:29 2003
+++ b/include/linux/sched.h	Thu Feb  6 16:57:29 2003
@@ -441,6 +441,8 @@
 #define PT_TRACE_VFORK	0x00000020
 #define PT_TRACE_CLONE	0x00000040
 #define PT_TRACE_EXEC	0x00000080
+#define PT_TRACE_VFORK_DONE	0x00000100
+#define PT_TRACE_EXIT	0x00000200
 
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
diff -Nru a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	Thu Feb  6 16:57:29 2003
+++ b/kernel/exit.c	Thu Feb  6 16:57:29 2003
@@ -653,6 +653,9 @@
 
 	profile_exit_task(tsk);
  
+	if (unlikely(current->ptrace & PT_TRACE_EXIT))
+		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
+
 fake_volatile:
 	acct_process(code);
 	__exit_mm(tsk);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Feb  6 16:57:29 2003
+++ b/kernel/fork.c	Thu Feb  6 16:57:29 2003
@@ -1046,9 +1046,11 @@
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}
 
-		if (clone_flags & CLONE_VFORK)
+		if (clone_flags & CLONE_VFORK) {
 			wait_for_completion(&vfork);
-		else
+			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
+				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
+		} else
 			/*
 			 * Let the child process run first, to avoid most of the
 			 * COW overhead when the child exec()s afterwards.
diff -Nru a/kernel/ptrace.c b/kernel/ptrace.c
--- a/kernel/ptrace.c	Thu Feb  6 16:57:29 2003
+++ b/kernel/ptrace.c	Thu Feb  6 16:57:29 2003
@@ -277,9 +277,20 @@
 	else
 		child->ptrace &= ~PT_TRACE_EXEC;
 
+	if (data & PTRACE_O_TRACEVFORKDONE)
+		child->ptrace |= PT_TRACE_VFORK_DONE;
+	else
+		child->ptrace &= ~PT_TRACE_VFORK_DONE;
+
+	if (data & PTRACE_O_TRACEEXIT)
+		child->ptrace |= PT_TRACE_EXIT;
+	else
+		child->ptrace &= ~PT_TRACE_EXIT;
+
 	if ((data & (PTRACE_O_TRACESYSGOOD | PTRACE_O_TRACEFORK
 		    | PTRACE_O_TRACEVFORK | PTRACE_O_TRACECLONE
-		    | PTRACE_O_TRACEEXEC))
+		    | PTRACE_O_TRACEEXEC | PTRACE_O_TRACEEXIT
+		    | PTRACE_O_TRACEVFORKDONE))
 	    != data)
 		return -EINVAL;
 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
